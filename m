Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D629FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1DC223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1DC223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbeKNDbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:31:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:52804 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbeKNDbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:31:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:32:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="88994511"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2018 09:32:49 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gMcYR-0001hE-UC; Tue, 13 Nov 2018 19:32:47 +0200
Date:   Tue, 13 Nov 2018 19:32:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     cai@gmx.us,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: WARNING: CPU: 26 PID: 64391 at lib/vsprintf.c:2193
 set_precision+0x84/0x90
Message-ID: <20181113173247.GJ10650@smile.fi.intel.com>
References: <1542128132.12945.19.camel@gmx.us>
 <CAMuHMdXKDUSEHKzdBCM4Df00fGC3eOdjU6gcSuQXpDaiUnrmMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXKDUSEHKzdBCM4Df00fGC3eOdjU6gcSuQXpDaiUnrmMw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 06:20:20PM +0100, Geert Uytterhoeven wrote:
> On Tue, Nov 13, 2018 at 5:57 PM Qian Cai <cai@gmx.us> wrote:
> > Running the trinity fuzzer with a non-root user on an aarch64 server with the
> > latest mainline (rc2) generated this. Is it just a false alarm to ignore?
> >
> > [  807.847370] precision 65525 too large
> > [  807.847449] WARNING: CPU: 26 PID: 64391 at lib/vsprintf.c:2193
> > set_precision+0x84/0x90
> > [  807.860161] Modules linked in: cast6_generic cast_common lrw bridge 8021q
> > garp mrp stp llc dlci tcp_diag inet_diag af_key pptp gre l2tp_ppp l2tp_netlink
> > l2tp_core ip6_udp_tunnel udp_tunnel pppoe pppox ppp_generic slhc crypto_user
> > ib_core nfnetlink scsi_transport_iscsi atm sctp vfat fat ghash_ce sha2_ce
> > sha256_arm64 sha1_ce ses enclosure ipmi_ssif sg ipmi_si ipmi_devintf sbsa_gwdt
> > ipmi_msghandler sch_fq_codel xfs libcrc32c marvell mpt3sas mlx5_core raid_class
> > hibmc_drm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm
> > ixgbe hisi_sas_v2_hw igb hisi_sas_main libsas hns_dsaf mlxfw devlink
> > hns_enet_drv mdio i2c_designware_platform i2c_algo_bit i2c_designware_core
> > ehci_platform scsi_transport_sas hns_mdio hnae dm_mirror dm_region_hash dm_log
> > dm_mod
> > [  807.927838] CPU: 26 PID: 64391 Comm: trinity-c90 Kdump: loaded Tainted:
> > G        W         4.20.0-rc2+ #16
> > [  807.937494] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50
> > 06/01/2018
> > [  807.944718] pstate: 60000005 (nZCv daif -PAN -UAO)
> > [  807.949515] pc : set_precision+0x84/0x90
> > [  807.953439] lr : set_precision+0x84/0x90
> > [  807.957362] sp : ffff801e6430f6b0
> > [  807.960677] x29: ffff801e6430f6b0 x28: ffff801e6430fb10
> > [  807.965992] x27: 0000000000000003 x26: 00000000ffffffd8
> > [  807.971307] x25: ffff801e6430fba0 x24: ffff801e6430fb48
> > [  807.976622] x23: ffff2000093ddfa0 x22: ffff801e6430f770
> > [  807.981937] x21: ffff2000090eb4a6 x20: ffff801e6430f770
> > [  807.987252] x19: 000000000000fff5 x18: 0000000000000000
> > [  807.992569] x17: 0000000000000000 x16: 0000000000000000
> > [  807.997884] x15: 0000000000000000 x14: 3878302031343220
> > [  808.003201] x13: 6265783020303939 x12: ffff04000172b49c
> > [  808.008516] x11: 1fffe4000172b49b x10: ffff04000172b49b
> > [  808.013832] x9 : 0000000000000000 x8 : 203532353536206e
> > [  808.019148] x7 : 6f69736963657270 x6 : 0000000041b58ab3
> > [  808.024463] x5 : dfff200000000000 x4 : dfff200000000000
> > [  808.029779] x3 : dfff200000000000 x2 : 65a2459128144800
> > [  808.035093] x1 : 65a2459128144800 x0 : 0000000000000000
> > [  808.040408] Call trace:
> > [  808.042861]  set_precision+0x84/0x90
> > [  808.046440]  vsnprintf+0x23c/0x858
> > [  808.049845]  __request_module+0x1a0/0x8b8
> > [  808.053860]  get_fs_type+0xb0/0x138
> > [  808.057351]  do_mount+0x2c4/0x13c0
> > [  808.060756]  ksys_mount+0xf4/0x110
> 
> Looks like someone is calling the mount syscall with a very long filesystemtype
> parameter.
> 
>     struct file_system_type *get_fs_type(const char *name)
>     {
>             struct file_system_type *fs;
>             const char *dot = strchr(name, '.');
>             int len = dot ? dot - name : strlen(name);
> 
>             fs = __get_fs_type(name, len);
>             if (!fs && (request_module("fs-%.*s", len, name) == 0)) {
> 
> set_precision() complains about any prevision that doesn't fit in signed
> 16-bits.

Or maybe \0 is missed and it found first one at that position.


-- 
With Best Regards,
Andy Shevchenko


