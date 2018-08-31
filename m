Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92CEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6847F2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aAWPTt8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6847F2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHaXvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:51:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57386 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeHaXvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:51:36 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJgPJ6106444;
        Fri, 31 Aug 2018 14:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535744545;
        bh=2bbyh9vlOqHrMFQgzGzOEVhfRe8gCX99+/3BFJ+cmuM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aAWPTt8/JPz2rXMzIHyUGsFfDhseow4tSEd5lZjk5typpx3ITizurvMY3/fwR88OK
         zQDW2ujMhXMAzrTwnz86OjzdagUQr4F/S1WwBFZOjm76YSzh4Fu3NPOJ/KBxiVUQT9
         iDvMPfsCWl9RzLMP7hvVqCShVLw4r+Ew958bOms4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJgPgQ008070;
        Fri, 31 Aug 2018 14:42:25 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:42:25 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:42:25 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJgPgm008235;
        Fri, 31 Aug 2018 14:42:25 -0500
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
 <c744c81c-752e-499e-ffe1-32df30a7831b@ti.com>
 <20180831193053.e3wvssdrxxnw2qah@linutronix.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <1bb777d4-7d72-ecdf-4b78-7d60ec49b815@ti.com>
Date:   Fri, 31 Aug 2018 14:42:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831193053.e3wvssdrxxnw2qah@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/31/2018 02:30 PM, Sebastian Andrzej Siewior wrote:
> On 2018-08-31 14:19:53 [-0500], Grygorii Strashko wrote:
>>
>> I've tried this and do not see warnings. I'm sending 4.14-rt patches i have as
>> I could miss smth while cherry-picking.
> 
> perfect. Thanks for the confirmation.
> I saw your three patches. Could you please instead just backport the two
> patches I have in v4.16 so that it applies on v4.14?
> 

Do you mean these two:
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.16.y-rt&id=c7a3334c762a9b1dd2e39cb2ded00ce66e8a06d1

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.16.y-rt&id=e083f14dc2e98ced872bf077b4d1cccf95b7e4f8


-- 
regards,
-grygorii
