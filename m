Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2A1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9EA20835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qeWKuLK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9EA20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeHaX3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:29:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55954 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaX3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:29:02 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJJsQL101587;
        Fri, 31 Aug 2018 14:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535743194;
        bh=3pysIlNIBs1PHlVSfRzcK4cbVQmzGFG7nrRqS/gku74=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qeWKuLK8y2sRVkh8DQNMNqebIpzi0BNeFapmRlhFQffZN4q67i/c1ifoQxXW+Toe/
         5stUsqwJHrifQUdp1Lf3q1i/HBeTAQJH2n+OnIighg5JjhKuzN3IJhQBUBzagc1n7U
         Gop7Xf80ElYKbxCi5y836qfo1S8ioqc03H2UfUxY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJJrPY002100;
        Fri, 31 Aug 2018 14:19:53 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:19:53 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:19:53 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJJrag010553;
        Fri, 31 Aug 2018 14:19:53 -0500
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function called
 from invalid context at kernel/locking/rtmutex.c:974
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
 <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
 <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
 <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <c744c81c-752e-499e-ffe1-32df30a7831b@ti.com>
Date:   Fri, 31 Aug 2018 14:19:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/30/2018 04:14 AM, Sebastian Andrzej Siewior wrote:
> On 2018-08-29 16:28:50 [-0500], Grygorii Strashko wrote:
>>
>> Thank you. Are there any plans to back port them for 4.14-rt?
>> Patch [1] need to be reworked a bit, [2] - I was able to cherry-pick from 4.18-rt.
> 
> Grygorii, could you please replace the second patch with
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/plain/patches/irqchip-gic-v3-its-Move-pending-table-allocation-to-.patch?h=linux-4.18.y-rt-patches
> 
> (incremental patch
>    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/patch/?id=4a0819bb25d12d39c0390636122eefba232596c1
> )
> 
> and check if it works? It should work but I can't test it myself because
> my box with GICv3 died recently…

I've tried this and do not see warnings. I'm sending 4.14-rt patches i have as
I could miss smth while cherry-picking.

-- 
regards,
-grygorii
