Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ED9C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6D82080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ssi.gouv.fr header.i=@ssi.gouv.fr header.b="Ph/RkYFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6D82080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssi.gouv.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeLLRBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:01:00 -0500
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:50040 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbeLLRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:00:59 -0500
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 02B7DD0006B;
        Wed, 12 Dec 2018 18:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1544634066;
        bh=PGQIfl8GvoOs1KqhFUvGy6lVfeojWfWYhz5V40aZpE4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=Ph/RkYFSEdsJ4++lI5qLDDZdMG1C1S6JQeFJOud5umJUer1+Aaze6y3zUKMwIxXXx
         JDeBkS4r3nl2u2jwYAxNqkbp6MlRJewHdi9rmMz5vJvzr8Nl4f+0zRe72vwsrUHYc2
         FDJWuGTpwsugXGEMKFliheCe4aCNBhi+AJqPGOvJ/yertoUPer5SKpore4AqQRV5/3
         r5yTCgLBPUKWiiV8dFtR/bn5FBh93kSq+24YNL32eShjmjsA5qwR6m1flvj7yN8Bx1
         NfziqZgwIYMhKwfXE2LK0a5Sm/f7KWV+T7ZvhgvR1KTd3V+805WZGxLVRI3vvJhq//
         8fRwnG5ZFPDXg==
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
To:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <ML-sxPRwNNExkZHkXghYN7e3VrhuZXYLjFv-aniX8qbjcde2GfHMBaI4B3A7IoUEfycQcWCPuxATkYHOz--FqMjH1KRwxMxBCb6Q-1IsKTM=@protonmail.ch>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <7c498761-7d74-956c-01df-1c8f39c10519@ssi.gouv.fr>
Date:   Wed, 12 Dec 2018 18:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ML-sxPRwNNExkZHkXghYN7e3VrhuZXYLjFv-aniX8qbjcde2GfHMBaI4B3A7IoUEfycQcWCPuxATkYHOz--FqMjH1KRwxMxBCb6Q-1IsKTM=@protonmail.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 12/12/2018 à 17:29, Jordan Glover a écrit :
> On Wednesday, December 12, 2018 9:17 AM, Mickaël Salaün <mic@digikod.net> wrote:
> 
>> Hi,
>>
>> The goal of this patch series is to control script interpretation. A
>> new O_MAYEXEC flag used by sys_open() is added to enable userland script
>> interpreter to delegate to the kernel (and thus the system security
>> policy) the permission to interpret scripts or other files containing
>> what can be seen as commands.
>>
>> The security policy is the responsibility of an LSM. A basic
>> system-wide policy is implemented with Yama and configurable through a
>> sysctl.
>>
>> The initial idea come from CLIP OS and the original implementation has
>> been used for more than 10 years:
>> https://github.com/clipos-archive/clipos4_doc
>>
>> An introduction to O_MAYEXEC was given at the Linux Security Summit
>> Europe 2018 - Linux Kernel Security Contributions by ANSSI:
>> https://www.youtube.com/watch?v=chNjCRtPKQY&t=17m15s
>> The "write xor execute" principle was explained at Kernel Recipes 2018 -
>> CLIP OS: a defense-in-depth OS:
>> https://www.youtube.com/watch?v=PjRE0uBtkHU&t=11m14s
>>
>> This patch series can be applied on top of v4.20-rc6. This can be
>> tested with CONFIG_SECURITY_YAMA. I would really appreciate
>> constructive comments on this RFC.
>>
>> Regards,
>>
> 
> Are various interpreters upstreams interested in adding support
> for O_MAYEXEC if it land in kernel? Did you contacted them about this?

I think the first step is to be OK on the kernel side. We will then be
able to help upstream interpreters implement this feature. It should be
OK because the behavior doesn't change by default, i.e. if the sysadmin
doesn't configure (and test) the whole system. Some examples of modified
interpreters can be found at
https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
.

 Mickaël
