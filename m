Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E5407C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DC1208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BRtLKlvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DC1208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935638AbeFMVWV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:22:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32959 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeFMVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:22:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so6171027lfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G7aRMKbsemighwGV3SYZAmJGd2MsoJ03kXKpz5fSoeg=;
        b=BRtLKlvMEIXgUpdydD6f2tUDzf4LlCYIVIJ5rpsgtzX9SIMhaYBqU6n4a2uAqAXBhH
         RFswUqHdd2HxzE+eJIFnTg8ekH+fvvGh3vklb1CwbEHpjKHa0hq4AOe8jc7wLuTnINYx
         zmvHYIlPlZQN/RXP1Co+tOn4s02NGj/DBney5VaIiNc3XLe96Br+z+wWi+DNFOyFGUQF
         Ayp/23Ohcygb0eEKmTA1ocN7m3PQCuJXfbhEzB4SbMfF53TAvre013HuZXFpbfoZCiUY
         XF+YId0k6v6paAyieOIQmt/a/T/GNQ5PQ18zFH8eUZ4HImRzr62UlGC7b2OdhY7m2IND
         EKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G7aRMKbsemighwGV3SYZAmJGd2MsoJ03kXKpz5fSoeg=;
        b=WIDgFh+jWPeWU6/9Xhnin4VT+Q2xPhgHoknLeBO2SiN9ZgYtqUYLcwZQK5vJrTJGI1
         NbhLbLLm7LmoJDoS8Xf9LIZkWlnmykk22e/JET4RJfPEXDBHhXFWg7PE/+unbSZ/vHZ1
         tXWVTLj9M/LWsWD4S0fFjU1gDY9OlmU8ip+5+nAKWqwiRWE7Gt6Uu2xIAY4Qm0u1c7vq
         IMybyNvlumEbbmJaySMVIU48MutFdsWxRZD1CAlVvbyAbxwgZOSgLjjPUikW64weB28D
         iabgCvrTkT52nh+fOkZwo30tTqDOsJN/yTUJPR5H14le3a8PdIGValx3ijjhygh1hGMJ
         3gQg==
X-Gm-Message-State: APt69E3MGpL1hrF2V/BHQ/rRSj8kwJf1e8+HpW5byoo6kKm54rm2BQlL
        Ow9pxfEi3/vCQaOfv4tY7gPb58SsGyXDnlWYuZqP
X-Google-Smtp-Source: ADUXVKLeV0QeiUiXZzbsoEu2UtMgAFgxuK6d22Tpo7s5DLCS8xq2RUCVCpUbcbvBm3MnVw37tpur8JsYzpq6vlCremM=
X-Received: by 2002:a19:d245:: with SMTP id j66-v6mr4353168lfg.139.1528924938062;
 Wed, 13 Jun 2018 14:22:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a911:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 14:22:17
 -0700 (PDT)
X-Originating-IP: [50.252.214.51]
In-Reply-To: <1adae238-44cc-83f5-538a-1b9c12916875@schaufler-ca.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com> <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
 <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
 <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
 <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
 <CAHC9VhRXBx_Q2eM48FFqX9PbPz0k8R74gfFFoRhwV91n2_BPsQ@mail.gmail.com>
 <38670733fba157f7acd9c1555b44a296420f0774.camel@perches.com>
 <CAHC9VhRX7Vx9_FB69EgxLypo1SnA9bobtxeLn8KzuHEN8CSaNA@mail.gmail.com> <1adae238-44cc-83f5-538a-1b9c12916875@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jun 2018 17:22:17 -0400
Message-ID: <CAHC9VhRmoUsuS4S9UxFSuE7qgvX1yhhnGfd2U8Foe75unymaRw@mail.gmail.com>
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Joe Perches <joe@perches.com>, James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 5:14 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 6/13/2018 12:57 PM, Paul Moore wrote:
>> On Wed, Jun 13, 2018 at 3:30 PM, Joe Perches <joe@perches.com> wrote:
>>> On Wed, 2018-06-13 at 12:19 -0400, Paul Moore wrote:
>>>> On Wed, Jun 13, 2018 at 12:04 PM, Joe Perches <joe@perches.com> wrote:
>>>>> On Wed, 2018-06-13 at 11:49 -0400, Paul Moore wrote:
>>>>>> On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
>>>>>>> On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:

...

>>> If James is not approving or merging security/selinux or
>>> security/tomoyo then perhaps the F: entries could be
>>> augmented with appropriate X: entries or made specific
>>> by using specific entries like:
>>>
>>> F:      security/*
>>> F:      security/integrity/
>>> F:      security/keys/
>
> There are already F: entries for security/selinux, security/smack
> and security/apparmor so I don't get your point.

Perhaps I've interpreted this the wrong way, but I took this to mean
that those security subsystems which don't flow through James should
use the X: entry to exclude themselves.  For example, here is a quick
diff to exclude SELinux:

diff --git a/MAINTAINERS b/MAINTAINERS
index c13b9fb3be0b..dc0b31121459 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12771,6 +12771,7 @@ T:      git git://git.kernel.org/pub/scm/linux/kernel/g>
W:     http://kernsec.org/
S:     Supported
F:     security/
+X:     security/selinux/

SELINUX SECURITY MODULE
M:     Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
