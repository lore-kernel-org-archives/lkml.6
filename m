Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC90C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359062243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359062243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeKLWzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:55:55 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:44184 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727989AbeKLWzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:55:55 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 15759B400A8;
        Mon, 12 Nov 2018 13:02:40 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 12 Nov 2018 05:02:33 -0800
Subject: Re: [PATCH tip/core/rcu 2/7] sfc: Replace spin_is_locked() with
 lockdep
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
CC:     <mingo@kernel.org>, <jiangshanlai@gmail.com>,
        <dipankar@in.ibm.com>, <akpm@linux-foundation.org>,
        <mathieu.desnoyers@efficios.com>, <josh@joshtriplett.org>,
        <tglx@linutronix.de>, <peterz@infradead.org>,
        <rostedt@goodmis.org>, <dhowells@redhat.com>,
        <edumazet@google.com>, <fweisbec@gmail.com>, <oleg@redhat.com>,
        <joel@joelfernandes.org>, Lance Roy <ldr709@gmail.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
References: <20181111200421.GA10551@linux.ibm.com>
 <20181111200443.10772-2-paulmck@linux.ibm.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <d5a895b9-6d0b-1d51-dc97-96864c5335af@solarflare.com>
Date:   Mon, 12 Nov 2018 13:02:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181111200443.10772-2-paulmck@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24218.006
X-TM-AS-Result: No-7.684100-4.000000-10
X-TMASE-MatchedRID: 7ySqCuYCpfjoSitJVour/Sa1MaKuob8Pt3aeg7g/usDC9z60K74zjBzX
        ueN0Y75lxoWDu6SiHI9hjINm/bTd5bpoUuJnOKxzGVyS87Wb4lw0fWPlA1Gy+lxTR00Ss4P6LPJ
        tWpbJjY26W23KTUVMlCFJl/lfXyoSXHEPHmpuRH05f9Xw/xqKXVkMvWAuahr8+gD2vYtOFhgqtq
        5d3cxkNT43GygvZ/Ae4XpmtMPIgdF0VfrMThUvUxkU23lsL/Gxla4igmjCzqwLytg7p/y75RSS1
        fRN5M1cinXtzqWU3usbzeY44Wp5NeS1vKFEkdJJBsRAh8WmTAcG2WAWHb2qekrMHC7kmmSWc5S6
        hNczuvhDDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.684100-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24218.006
X-MDID: 1542027762-NyhoY-A0vQX3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 20:04, Paul E. McKenney wrote:
> From: Lance Roy <ldr709@gmail.com>
>
> lockdep_assert_held() is better suited to checking locking requirements,
> since it only checks if the current thread holds the lock regardless of
> whether someone else does. This is also a step towards possibly removing
> spin_is_locked().
>
> Signed-off-by: Lance Roy <ldr709@gmail.com>
> Cc: Solarflare linux maintainers <linux-net-drivers@solarflare.com>
> Cc: Edward Cree <ecree@solarflare.com>
> Cc: Bert Kenward <bkenward@solarflare.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <netdev@vger.kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
Acked-by: Edward Cree <ecree@solarflare.com>
>  drivers/net/ethernet/sfc/efx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 98fe7e762e17..3643015a55cf 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -3167,7 +3167,7 @@ struct hlist_head *efx_rps_hash_bucket(struct efx_nic *efx,
>  {
>  	u32 hash = efx_filter_spec_hash(spec);
>  
> -	WARN_ON(!spin_is_locked(&efx->rps_hash_lock));
> +	lockdep_assert_held(&efx->rps_hash_lock);
>  	if (!efx->rps_hash_table)
>  		return NULL;
>  	return &efx->rps_hash_table[hash % EFX_ARFS_HASH_TABLE_SIZE];


