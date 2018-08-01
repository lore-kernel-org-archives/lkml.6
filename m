Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17034C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E7B20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDHBMKx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E7B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeHAXJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:09:00 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39620 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbeHAXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:09:00 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so84144oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ucwNnjxHiiHHwhrYQyRF97UJ0t2Xnv51N7lgffCez0U=;
        b=YDHBMKx8U38+8VAmSA1otru15KoVR/xWTp9rYZCf/Q1gFlyBE4K5j0vWeQzWOHN578
         Y3n+3dOFomUbIpMZizETkOWmaJFSxVsGj7TClKcG5fAWoCP9thqVCfpBI3CZKWMSgj9U
         qtwBWRJNZv+Vkd2ckYbnpsMvbgeauv3T8YG1ZVaWT3YICl6guisnpxfyGqnKNFp6jBk3
         iKW/FzPs2an9RByYLYosm9vIvrp4S4oB4xgIKsEuV3USmUuwbN8MqQTDFYs6ZBR+U1oG
         5GXE4RIbszIxQNn2UcNyoj9YYvXBvBEHpLfsNG7lFlS0XfS23yvS9B1zu6jw8gJEpZRM
         oY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ucwNnjxHiiHHwhrYQyRF97UJ0t2Xnv51N7lgffCez0U=;
        b=ji8cmuUvVVS3sflTmAdDO89qPqs2eDeQOmMWrSpTcwkJ/QYxgxor9UP7rmrW2RbxyI
         /uwT5M61hK0boKOOhI0kJU8rxXcAmUU9zWGA6XtC1zqMcYNIQ75PDr5aydRiU7QwBcOS
         yCDqIhNXA+0e4ySyhGJsa80Hu83jGvKpZAYAnLXyxEipzu9iOuNQJuxajx9+CfOlaCSK
         Weu205xrZDjy3Mx1Nn80RS+u/Ntmj0qSxjtuHbgav16mJJMhhDlfGTCr5ynd+Q4WboVa
         VFrLycr/Pbu9R06+dg3+VOZX1b2XhZrHl0lAXFXxIpsjXhp5dlPNJqSI9f+kZzs025wR
         zozA==
X-Gm-Message-State: AOUpUlF0tZV3Vs+9Y78+dc29PhN173Z80PpTJU3CQpMs+Bl9/4/ahnL4
        pJ3T70fOk8okkScOSSjfusHEA9R91Wk0ctDflRg=
X-Google-Smtp-Source: AAOMgpd/6fu2fk/C0cAPtg3IvJRpVXghvpfuHJiHNm7ZoOupjj4owLDu2093gUbetAm9/qUFfiZ8749PfhhMgJ6v3hI=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr40045oig.282.1533158476809;
 Wed, 01 Aug 2018 14:21:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 14:21:16 -0700 (PDT)
In-Reply-To: <68b90830d5024ce75a20b017aaf21c05@codeaurora.org>
References: <1532035440-7860-1-git-send-email-rishabhb@codeaurora.org>
 <CAJZ5v0gWqx5Op-Bbg7bAYALCyBPsc=-+homAYj2Q1qd3WsqmDw@mail.gmail.com>
 <e4ca8572ed913ab65f63be8a351d4439@codeaurora.org> <CAJZ5v0ixuWo9RC21Z8zVhuHfkr1uV4vdqMh4s+qGMR7R8Wycag@mail.gmail.com>
 <68b90830d5024ce75a20b017aaf21c05@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Aug 2018 23:21:16 +0200
X-Google-Sender-Auth: 5FyVw2g84TQtsNFI2Jyxd2zZFag
Message-ID: <CAJZ5v0jpm8tVjyWjA36Sp-bTEWUE+6cExjH7=CM=LUB-6xvePA@mail.gmail.com>
Subject: Re: [PATCH] dd: Invoke one probe retry cycle after every initcall level
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        Vikram Mulukutla <markivx@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 11:18 PM,  <rishabhb@codeaurora.org> wrote:
> On 2018-07-24 01:24, Rafael J. Wysocki wrote:
>>
>> On Mon, Jul 23, 2018 at 10:22 PM,  <rishabhb@codeaurora.org> wrote:
>>>
>>> On 2018-07-23 04:17, Rafael J. Wysocki wrote:
>>>>
>>>>
>>>> On Thu, Jul 19, 2018 at 11:24 PM, Rishabh Bhatnagar
>>>> <rishabhb@codeaurora.org> wrote:
>>>>>
>>>>>
>>>>> Drivers that are registered at an initcall level may have to
>>>>> wait until late_init before the probe deferral mechanism can
>>>>> retry their probe functions. It is possible that their
>>>>> dependencies were resolved much earlier, in some cases even
>>>>> before the next initcall level. Invoke one probe retry cycle
>>>>> at every _sync initcall level, allowing these drivers to be
>>>>> probed earlier.
>>>>
>>>>
>>>>
>>>> Can you please say something about the actual use case this is
>>>> expected to address?
>>>
>>>
>>> We have a display driver that depends 3 other devices to be
>>> probed so that it can bring-up the display. Because of dependencies
>>> not being met the deferral mechanism defers the probes for a later time,
>>> even though the dependencies might be met earlier. With this change
>>> display can be brought up much earlier.
>>
>>
>> OK
>>
>> What runlevel brings up the display after the change?
>>
>> Thanks,
>> Rafael
>
> After the change the display can come up after device_initcall level
> itself.
> The above mentioned 3 devices are probed at 0.503253, 0.505210 and 0.523264
> secs.
> Only the first device is probed successfully. With the current
> deferral mechanism the devices get probed again after late_initcall
> at 9.19 and 9.35 secs. So display can only come up after 9.35 secs.
> With this change the devices are re-probed successfully at 0.60 and
> 0.613 secs. Therefore display can come just after 0.613 secs.

OK, so why do you touch the initcall levels earlier than device_?

> This change helps in overall android bootup as well.

How exactly?
