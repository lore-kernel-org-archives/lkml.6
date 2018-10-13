Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6EEC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3F820835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="sB1iDnX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3F820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJMO6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:58:17 -0400
Received: from sonic315-10.consmr.mail.gq1.yahoo.com ([98.137.65.34]:38507
        "EHLO sonic315-10.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbeJMO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1539415334; bh=Z2qp/EGSNTKSVUR7/LTVmyQQ8pqiO34t1pMBC5mdbh8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sB1iDnX2cKcZRns9OxWPWiQtKq38qjxsfNnTHDlR7r5+84Z20+2PXzWfuffcXml6RNwJQcrJYDFeBPl7XHhyrQDXEmi/mpIoh2hxGJi6OjlH1LyWs9TZkY81Fr4YzsMyXxHqqBo1VukbpWMZHwel6CZG5AYiccr7QH7gdmtQ7bMQNgO7uV75L4WrOQ3S7gT1wMJAQJ0fgDoUK67I6BEvyLiYYh0DKtTB2EqQxWWJaRfBCyv9N8Jf4k9/fl/4mPjIg3ZNUFsIRwkiMreEmLEh4HLU1vOlzQ2esVZ1X9agFAA5I78sQdjEz+MtLaEP2aqKOaEcx8PZqx+qWP0jPhw76g==
X-YMail-OSG: 6I.78LsVM1k7jAuMpWM1E2Gd.TZaE1bmvFx_rCKSza1JR9ZzzUPLaPq3SWqZTOY
 sr_ECuTC7EMW8RxRSUlCMQTdnYoQPuErYUoLd1cHTa7cP3NNlPOm7KRpEd7_Y5iWl.jUdWlTGexj
 F2FnlgybVPT_zgD_NslKBQ...UWe3aQ8fiQzTfzeSxC1uBOdly25_XprcUA4wV2sco6C1_NgXAsJ
 eNpu_yn1WONRO033ld_lijIMDsX7mSYS0dvc8TpKxyXU02KJyxnRublHeip7eSxygS5bXftu4CXY
 HSxDNPirzBhM6wZVbbSL.R_0cQRi17aa4ZsfNDni3w8LXuxDdsDd7dH9ZA6IjpyKvWxlwo7HFI9y
 u5jC9hKbWvw1pSLPVfecR4EcORfm4NoMNQhNOMi0AVmWekZBmQyaq3xJnKmQ0W6L4OGNpNnYLg.Z
 otRcW4qpStJRDAXlmrrgbX3Jt0LHwsAn9wWyXeMtwgTbTMqdEa8az6JOZxxYOoixFr1oPgV5sNZu
 z8oqiAG.KJ1WuWQYbQvtk.bKv2fPLmrT.OYW47_v89EzFw6_dGf0STUjKpbTS0puNE5SQI4ijOXU
 Dm7AbK8cB9UAIhVGO1emEE2fE9ccalVghZQL5t6c3PqajbKInSlSxYOTj2h0WyLlvjQzDH_b4UAL
 kTxkkABEYkdpD.lo2IENU5jr07Lx6pY3gd_2_E89A1vlQN_azJOeTJxJ1s_d0TnMQhl6rS3DpRx6
 V_GGMi0K2F2lpGByItCodJDUSjYI095mI790dWbPwETk5Ld.CzEHVBYM7RcIasGBQyR7VPFRL.x.
 gNXpa7Ptm9fdeyW_b6ekzxnfrvSVyfdSDduWE7Z9SaDoupdxUpzmrBKQWdBPRn9WguSfqUyRZ3Vk
 vjPyivTs9VFlsN0Hru2zS5w3mm_D9uEFP3XH1G4ARapeoIZafMP6l8_2PG.sPlc9FHrbqHtWV4f9
 ma.3eXkp6Z4V6lKu0yxRlYTysjbFxHo97DRNPCAF635L6jTB_AEsoiL75C2TSupd6fsYRAxnKaiw
 xWJhi2wGq34HG20wSiC2G_QECtxbGDOTKHyQSJv0iMys87SnaZcuRIMBY9JBWfpqe7Bs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Oct 2018 07:22:14 +0000
Received: from 183.156.49.100 (EHLO [192.168.199.211]) ([183.156.49.100])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 68c5f2376ddf38342c2b721b4108a463;
          Sat, 13 Oct 2018 07:22:12 +0000 (UTC)
Subject: Re: [RFC PATCH] bit_spinlock: introduce smp_cond_load_relaxed
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181013070420.GA29914@kroah.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <99c4d824-7bd2-a91f-eaaa-8cfe55c66232@aol.com>
Date:   Sat, 13 Oct 2018 15:22:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181013070420.GA29914@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/10/13 15:04, Greg Kroah-Hartman wrote:
> On Sat, Oct 13, 2018 at 02:47:29PM +0800, Gao Xiang wrote:
>> It is better to use smp_cond_load_relaxed instead
>> of busy waiting for bit_spinlock.
> 
> Why?  I think we need some kind of "proof" that this is true before
> being able to accept a patch like this, don't you agree?

There are some materials which discuss smp_cond_load_* earlier.
https://patchwork.kernel.org/patch/10335991/
https://patchwork.kernel.org/patch/10325057/

In ARM64, they implements a function called "cmpwait", which uses
hardware instructions to monitor a value change, I think it is more
energy efficient than just do a open-code busy loop...

And it seem smp_cond_load_* is already used in the current kernel, such as:
./kernel/locking/mcs_spinlock.h
./kernel/locking/qspinlock.c
./kernel/sched/core.c
./kernel/smp.c

For other architectures like x86/arm64, I think they could implement
smp_cond_load_* later.


Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
