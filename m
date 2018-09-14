Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17A9C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472DD20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JknTXEwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472DD20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeINFa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:30:59 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36051 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINFa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:30:58 -0400
Received: by mail-yb1-f195.google.com with SMTP id d34-v6so4085833yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 17:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6wMlK1y3LiN3aZ3bTuEJV8QEavcDQjHdwWOtDq+XGy8=;
        b=JknTXEwGLXgm+pEEceglu7LvExbBDFF+hh4kWx/RywJPcCe5axe6DbyxnhMF53x3zl
         4pOXwyOGHLBATO1QydW/Np/o1JFZb4w0CAU7F7gnlqFDWSjZ30pQMF/f76kZjgTgY/+N
         4yLVWKPXkF97gTI7taiRYXRohQqr4VmRvNbvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6wMlK1y3LiN3aZ3bTuEJV8QEavcDQjHdwWOtDq+XGy8=;
        b=JsaC814GbJPsZ9VoHSDyd3djQzIxhMRZeOtXAUxTSaBGSbE6VocLwjuwBHKU0eztxm
         12argSMfN6vldODcLgs30SsNPl+mpCy8PP9g3NAYiMIspGMP1aRhjCJoloii5BHN2iX8
         do/io1TPFR1Pr6v3ikuT4sNfdZ2CkazFt3Q8MlBgKZYBoz/7J0x85k0gwdy4eb3csfiz
         hY0hYgWN7cWJ1h+8QE24BHFIM/nifrTtQMAWQ7NCC3FFVZYnMqQwZL/rwIW1qLo6FBJt
         Q0k7/GVg4svo02QFflFAgQthTpPayCKA51g9d5sbKfTUlHjDqwYCjdHeq2g6ztC/Qc9n
         UqmQ==
X-Gm-Message-State: APzg51ClA7/wciCao2Yr2oNIxu44OInmgMRjugQKgpaSGgQBo5QIprqW
        xrkfDAmAnKecGE7bZ/TkO7w+cw1+bog=
X-Google-Smtp-Source: ANB0VdZFLRc1LxRGkHkU6qYpEC9WWYsPz8SkraFLmxZHlnlxkFqxCDRcNUEBe2hguL52xg/yWXXmng==
X-Received: by 2002:a25:acdb:: with SMTP id x27-v6mr4660927ybd.297.1536884348978;
        Thu, 13 Sep 2018 17:19:08 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id m39-v6sm2101263ywh.65.2018.09.13.17.19.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 17:19:06 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id x67-v6so1953170ywg.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 17:19:05 -0700 (PDT)
X-Received: by 2002:a0d:db10:: with SMTP id d16-v6mr4787313ywe.124.1536884345238;
 Thu, 13 Sep 2018 17:19:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 17:19:04
 -0700 (PDT)
In-Reply-To: <5b983bba-049c-795a-3354-a2e8ab33cecf@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
 <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com> <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
 <5b983bba-049c-795a-3354-a2e8ab33cecf@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 17:19:04 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ5__jdBM5X0vVyEU1TKnN4dpkXbj=10iak9RvD1DZk9g@mail.gmail.com>
Message-ID: <CAGXu5jJ5__jdBM5X0vVyEU1TKnN4dpkXbj=10iak9RvD1DZk9g@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 5:08 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/13/2018 4:57 PM, Kees Cook wrote:
>> On Thu, Sep 13, 2018 at 4:51 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 9/13/2018 4:06 PM, Kees Cook wrote:
>>>> - what order should any stacking happen? Makefile? security=?
>>> Makefile by default.
>> Okay, if ordering is by Makefile and everyone dislikes my
>> $lsm.enabled=0/1 thing, then these mean the same thing:
>>
>> security=selinux,tomoyo
>> security=tomoyo,selinux
>>
>> i.e. order of security= is _ignored_ in favor of the Makefile ordering.
>
> No, I think that the two lines above should have a different
> execution order. If we really need to specify multiple modules
> at boot time that is what makes the most sense.
>
> It's a matter of mechanics and probably another pass during the
> init process, but it's doable. If we determine it's necessary for
> this stage it is just work.

We already have the minor LSMs that cannot change order. They aren't
part of security= parsing either. To enable/disable LoadPin, you do
"loadpin.enabled=1/0" separate from "security=".

Should "blob-sharing" LSMs be like major LSMs or minor LSMs?

If someone is booting with "security=selinux,tomoyo" and then SARA
lands upstream, does that person have to explicitly add "sara" to
their boot args, since they're doing a non-default list of LSMs?

(I actually prefer the answer being "yes" here, FWIW, I just want to
nail down the expectations.)

-Kees

-- 
Kees Cook
Pixel Security
