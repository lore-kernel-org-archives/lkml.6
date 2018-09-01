Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E23BC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EBE20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EBE20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeIARRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:36590 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeIARRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:07 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w81D508B082553;
        Sat, 1 Sep 2018 22:05:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Sat, 01 Sep 2018 22:05:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w81D4ttP082393
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 1 Sep 2018 22:05:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 0/8] CaitSith LSM module
To:     John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201611231531.DGH52135.QtFVOFJLOHFOSM@I-love.SAKURA.ne.jp>
 <2908442d-90f1-7fa2-24ff-0833f6bd2d95@canonical.com>
 <201705211359.BBE26079.LSJFOMHFOVQFOt@I-love.SAKURA.ne.jp>
 <8c6da617-3325-d60d-805f-5e5c1fa322c6@canonical.com>
 <201705211459.EGB48959.OFVFOSHtFJMLQO@I-love.SAKURA.ne.jp>
 <201710211959.CEC65165.SQJOLOFVOtFFHM@I-love.SAKURA.ne.jp>
 <7cab86a5-e115-0905-4d72-8cae7f6540b9@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <b72491b3-834e-e073-0e40-a61d134725db@I-love.SAKURA.ne.jp>
Date:   Sat, 1 Sep 2018 22:04:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7cab86a5-e115-0905-4d72-8cae7f6540b9@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2017/10/22 2:17, Casey Schaufler wrote:
>> As one year elapsed since I proposed CaitSith for upstream, I'd like to
>> hear the status again. I looked at
>> http://schd.ws/hosted_files/lss2017/8b/201709-LinuxSecuritySummit-Stacking.pdf .
>> How is ETA for Security Module Stacking? Is it a half year or so?
> 
> Assuming that I can keep working on stacking at my current level,
> and that we can work out a couple issues with audit and networking
> there is a possibility we're looking at mid 2018 for stacking. The
> increased interest in security module namespaces for containers is
> helping make stacking seem important to more people.
> 
>> If it is likely take longer, should I resume proposing CaitSith for now
>> as one of "Minor modules" except security_module_enable() check added
>> until Security Module Stacking work completes? Or should I wait for
>> completion of stacking work? I want to know it, for recent proposals are
>> rather staying silent.
> 
> I wouldn't wait if it was my project, but I have been known
> to be more aggressive than is good for me from time to time.
> 

It seems that stacking needs some more time. Manual with updated patch for
current source code is available at https://caitsith.osdn.jp/index2.html .
John, if you can resume reviewing, I'd like to propose CaitSith as one of
"Minor modules" except security_module_enable() check.

Regards.

