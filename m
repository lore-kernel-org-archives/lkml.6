Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEB1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3C9217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0mQk7Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeLXIN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:13:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36263 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeLXIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:13:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so7805332lfg.3;
        Mon, 24 Dec 2018 00:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5mVXO/0jDDt+uZgK+y0kjQmdJN/YpQG6XwufBZZIy8o=;
        b=D0mQk7GxzbqDFGwIWbTbWxGNLKSaWkyIuP0c3qrrj86KHu529+kL+r3EHSFrvUQEAU
         o+4dB9Ve1ykYUtjtVmMLjiqh7kGOXdBMnNbZRNZEOZyrAKqIa0o3QqT4IlrlXXVZ9lUr
         9KW+1TK4MZJIuR0AT/sQjZoe1FpBVrOTZkiA5+h8KXCH6x9kt/ldb48a+Is1OncDngEH
         Q3laMXdmvFYQ3qOh5moc2Rc1IzY4iVXVXLEICHQk+65VN1qABWf15WzWi9PTwCJsapjS
         4pUqmvaibo0BMWVtbHzzJv28D4gtwGXBCZS95sKXecrf7DXTf7qvtXZ5+7fO9RKX4kZt
         1YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5mVXO/0jDDt+uZgK+y0kjQmdJN/YpQG6XwufBZZIy8o=;
        b=ipq9JK3OVBgLHE5Awl9K3u2dtVSq5U7UXxH8CbYi5Fd0GD10lmnjxXIxQZCaiCiULY
         WuYT9KpKdYzjvdNn6psT2BP05QD8pj7qnzHjXTsWnHc9WFMRaeigyHptxhL0txTdbSzm
         l+Ajur0cWViUGPc1quaiv1z/JzdgayndYjFWwCN3YUihfANgxuxHzO8VNzuJiVUBBuce
         lyDI3YhpXrfK4hG8Phw0UkWo/B5UrTMhq7h/gaDKJVo67mS47KLQiRgK5Ob6CNqwPC1Z
         mLamLwIYGDfa+E0SapDxF7A13C4VedlWfnsJPyf6KglnQW8TlzA8sbJKijT0V20W4yOZ
         dSfw==
X-Gm-Message-State: AA+aEWZzkLD2C4ITU7x/mGYlJLsruVoSgCeeTNNG8B8vT5fJY2KBZ1/O
        /4rAVGeWGA/1B8kq3FVTd0ZhmzGboDX0gw==
X-Google-Smtp-Source: AFSGD/XHIV7q1DO5ClHvyFZS5KumVO+y2AxAPKdIsQDXCOOSpRdyH2kQhw8Jp6qOMaNImtBel9eYHg==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr6500711lfa.65.1545639203661;
        Mon, 24 Dec 2018 00:13:23 -0800 (PST)
Received: from im-mac (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id d10sm6179646lfa.71.2018.12.24.00.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 00:13:22 -0800 (PST)
Message-ID: <2e6d04f50a2060af275c762abcb7f322e165d9fe.camel@gmail.com>
Subject: Re: [PATCH] bnx2x: Fix NULL pointer dereference in
 bnx2x_del_all_vlans() on some hw
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Ariel Elior <ariel.elior@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Dec 2018 13:13:21 +0500
In-Reply-To: <20181223152930.7925-1-mironov.ivan@gmail.com>
References: <20181223152930.7925-1-mironov.ivan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20 release is affected too.

On Sun, 2018-12-23 at 20:29 +0500, Ivan Mironov wrote:
> This happened when I tried to boot normal Fedora 29 system with latest
> available kernel (from fedora rawhide, plus some unrelated custom
> patches):
> 
> 	BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> 	PGD 0 P4D 0
> 	Oops: 0010 [#1] SMP PTI
> 	CPU: 6 PID: 1422 Comm: libvirtd Tainted: G          I       4.20.0-0.rc7.git3.hpsa2.1.fc29.x86_64 #1
> 	Hardware name: HP ProLiant BL460c G6, BIOS I24 05/21/2018
> 	RIP: 0010:          (null)
> 	Code: Bad RIP value.
> 	RSP: 0018:ffffa47ccdc9fbe0 EFLAGS: 00010246
> 	RAX: 0000000000000000 RBX: 00000000000003e8 RCX: ffffa47ccdc9fbf8
> 	RDX: ffffa47ccdc9fc00 RSI: ffff97d9ee7b01f8 RDI: ffff97d9f0150b80
> 	RBP: ffff97d9f0150b80 R08: 0000000000000000 R09: 0000000000000000
> 	R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
> 	R13: ffff97d9ef1e53e8 R14: 0000000000000009 R15: ffff97d9f0ac6730
> 	FS:  00007f4d224ef700(0000) GS:ffff97d9fa200000(0000) knlGS:0000000000000000
> 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	CR2: ffffffffffffffd6 CR3: 00000011ece52006 CR4: 00000000000206e0
> 	Call Trace:
> 	 ? bnx2x_chip_cleanup+0x195/0x610 [bnx2x]
> 	 ? bnx2x_nic_unload+0x1e2/0x8f0 [bnx2x]
> 	 ? bnx2x_reload_if_running+0x24/0x40 [bnx2x]
> 	 ? bnx2x_set_features+0x79/0xa0 [bnx2x]
> 	 ? __netdev_update_features+0x244/0x9e0
> 	 ? netlink_broadcast_filtered+0x136/0x4b0
> 	 ? netdev_update_features+0x22/0x60
> 	 ? dev_disable_lro+0x1c/0xe0
> 	 ? devinet_sysctl_forward+0x1c6/0x211
> 	 ? proc_sys_call_handler+0xab/0x100
> 	 ? __vfs_write+0x36/0x1a0
> 	 ? rcu_read_lock_sched_held+0x79/0x80
> 	 ? rcu_sync_lockdep_assert+0x2e/0x60
> 	 ? __sb_start_write+0x14c/0x1b0
> 	 ? vfs_write+0x159/0x1c0
> 	 ? vfs_write+0xba/0x1c0
> 	 ? ksys_write+0x52/0xc0
> 	 ? do_syscall_64+0x60/0x1f0
> 	 ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> After some investigation I figured out that recently added cleanup code
> tries to call VLAN filtering de-initialization function which exist only
> for newer hardware. Corresponding function pointer is not
> initialized (== 0) for older hardware, namely these chips:
> 
> 	#define CHIP_NUM_57710			0x164e
> 	#define CHIP_NUM_57711			0x164f
> 	#define CHIP_NUM_57711E			0x1650
> 
> And I have one of those in my test system:
> 
> 	02:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme II BCM57711E 10-Gigabit PCIe [14e4:1650]
> 	02:00.1 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme II BCM57711E 10-Gigabit PCIe [14e4:1650]
> 
> Function bnx2x_init_vlan_mac_fp_objs() from
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h decides whether to
> initialize relevant pointers in bnx2x_sp_objs.vlan_obj or not.
> 
> This regression was introduced after v4.20-rc7.
> 
> Fixes: 04f05230c5c13 ("bnx2x: Remove configured vlans as part of unload sequence.")
> Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> ---
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 22 +++++++++++++------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
> index b164f705709d..0e37c2484ac2 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
> @@ -8504,15 +8504,23 @@ int bnx2x_set_vlan_one(struct bnx2x *bp, u16 vlan,
>  static int bnx2x_del_all_vlans(struct bnx2x *bp)
>  {
>  	struct bnx2x_vlan_mac_obj *vlan_obj = &bp->sp_objs[0].vlan_obj;
> -	unsigned long ramrod_flags = 0, vlan_flags = 0;
>  	struct bnx2x_vlan_entry *vlan;
> -	int rc;
>  
> -	__set_bit(RAMROD_COMP_WAIT, &ramrod_flags);
> -	__set_bit(BNX2X_VLAN, &vlan_flags);
> -	rc = vlan_obj->delete_all(bp, vlan_obj, &vlan_flags, &ramrod_flags);
> -	if (rc)
> -		return rc;
> +	/* The whole *vlan_obj structure may be not initialized if VLAN
> +	 * filtering offload is not supported by hardware. Currently this is
> +	 * true for all hardware covered by CHIP_IS_E1x().
> +	 */
> +	if (vlan_obj->delete_all) {
> +		unsigned long ramrod_flags = 0, vlan_flags = 0;
> +		int rc;
> +
> +		__set_bit(RAMROD_COMP_WAIT, &ramrod_flags);
> +		__set_bit(BNX2X_VLAN, &vlan_flags);
> +		rc = vlan_obj->delete_all(bp, vlan_obj, &vlan_flags,
> +					  &ramrod_flags);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	/* Mark that hw forgot all entries */
>  	list_for_each_entry(vlan, &bp->vlan_reg, link)

