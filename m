Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5B3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1F720652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gr6k1KaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1F720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeH3B1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:27:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47430 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeH3B1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:27:51 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7TLSoBr093873;
        Wed, 29 Aug 2018 16:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535578131;
        bh=Zk8iiAXu8A0Yn8Ro0NmBfaaQ7Mfzx9MVt0hnrfejXXw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gr6k1KaJwcJrpPnvXZ11YJ14lOytF1hg9aPcAQmLg8dRoyV8HP7HzWktvCUjiajXd
         L79hrQ0LxA8FayRwiX2bW1Vqhdnpm3lzgCGztuT6Iq6PoK3fbq+5f0+VsRDKBVxu1e
         moOftKuXOJs0jsC+vXVVt7jUF9vdZazyCSeLV6ZA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7TLSomc011643;
        Wed, 29 Aug 2018 16:28:50 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 29
 Aug 2018 16:28:50 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 29 Aug 2018 16:28:50 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7TLSoFu025152;
        Wed, 29 Aug 2018 16:28:50 -0500
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function called
 from invalid context at kernel/locking/rtmutex.c:974
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
 <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
Date:   Wed, 29 Aug 2018 16:28:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2018 09:08 AM, Sebastian Andrzej Siewior wrote:
> On 2018-08-28 18:28:42 [-0500], Grygorii Strashko wrote:

[...]

>> [    0.912275] [<ffff0000082023cc>] alloc_pages_current+0xcc/0xe0
>> [    0.912287] [<ffff00000846bb00>] its_allocate_pending_table+0x60/0xa0
>> [    0.912295] [<ffff00000846e5d8>] its_cpu_init+0x2a0/0x380
>> [    0.912303] [<ffff00000846b484>] gic_cpu_init.part.6+0x15c/0x170
>> [    0.912311] [<ffff00000846b4ac>] gic_starting_cpu+0x14/0x20
> 
> This is fixed by
>    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/irqchip-gic-v3-its-Make-its_lock-a-raw_spin_lock_t.patch?h=linux-4.18.y-rt-patches
[1]
>    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/irqchip-gic-v3-its-Move-ITS-pend_page-allocation-int.patch?h=linux-4.18.y-rt-patches
[2]
> 
> in the v4.18 tree. The first patch was merged upstream. The second will
> be replaced by the patches Marc Zyngier proposed in
>    https://lkml.kernel.org/r/3302f069-8f4e-8d97-5166-0dec01b43c4c@arm.com
> 
> I plan to test + replace those for the next v4.18 release.

Thank you. Are there any plans to back port them for 4.14-rt?
Patch [1] need to be reworked a bit, [2] - I was able to cherry-pick from 4.18-rt.

-- 
regards,
-grygorii
