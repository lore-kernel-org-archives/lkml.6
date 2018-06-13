Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6DBA8C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EDF208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YUhxhehr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EDF208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935993AbeFMPtj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:49:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43295 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935878AbeFMPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:49:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id n15-v6so4687273lfn.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z/jzzp2HUdVc5uzjwP9XWbghrXXqWPTDFAHT445fTss=;
        b=YUhxhehrTNex0ZX/buYmzyZx81A+ATielvgpUMfyl4d6et4IrMEqvlHxJKaDVU7Tpc
         0EemMF8ugdBTt8Gv99nnq7Tv09rs2XpKeexCyyaKb2j85h4cT7kGAtGRCIlUeeLmj3Xa
         SRsQSAQ2cwKSbfJkEZK8z5X9QpzLhfQWPZs8k9cbm42kOQMGXmqet4w911DGPrSrVY2J
         mOByIv6vevOaX1NxqBrXjgVgbCmbbfcXWIkmMbl6huBnFLdm78We944+OsM1g2n1eScM
         mYmpHs7kzq4/8LdrOsMUaixNxVxRyavIWc/XCI37IzaRPqkmRkR22nMQ2QuoA9VOy89r
         +C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z/jzzp2HUdVc5uzjwP9XWbghrXXqWPTDFAHT445fTss=;
        b=oQVk/EifSW7iK6ZbVv1oPx/AQ51oWn1Xht2VHhZQ/trIWb30pEDrg0NV3rDqmZgyeZ
         0kZM1gZWCIcu017txUkis1NYdIy/fK4IkJvss7Hw7RgBc+o8BCqyplAZBLev43C9AGU7
         rxd9coWaE/No4iL8g8LZyCCNbisORheCnDnXtizyNP30GiWixhSIf39lEvxsxRCdPqI+
         t39ZATE4pP9aVqc28cPu61O6MELVOsOk5WtRSntLEtO//v+9vAOu9qu3y6E4eIB+Jlo5
         rxSU7SDCMrE95UyYYM82g0E7665SL3zlw1jZtOkv5ki+h+lfqb+0viiwnCN1x8Wsl9kg
         YJ0g==
X-Gm-Message-State: APt69E0EWCJGVKnl8iY2ctjIkeoEPvPKhze0TAARNW6CKJcvQvTe9Xn9
        xF12AJwXXrnv2LkvGKeRGbFr2KCbC93uqSGlJ/S0KFGjVhSj
X-Google-Smtp-Source: ADUXVKL90tJotlqrhYvgkbSWDMlbTxUGx20+ikpq2IaCxSjajCQRUTEoaOV4AORwNkm4LxKseMBuuBFZKaFVrRE00yg=
X-Received: by 2002:a19:e497:: with SMTP id x23-v6mr3365304lfi.40.1528904974779;
 Wed, 13 Jun 2018 08:49:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a911:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 08:49:33
 -0700 (PDT)
X-Originating-IP: [108.20.156.165]
In-Reply-To: <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com> <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com> <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jun 2018 11:49:33 -0400
Message-ID: <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
To:     Joe Perches <joe@perches.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
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

On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
>> Joe, in general I really appreciate the fixes you send, but these
>> patches that cross a lot of subsystem boundaries (this isn't the first
>> one that does this) causes unnecessary conflicts in -next and during
>> the merge window.  Could you split your patches up from now on please?
>
> Sorry. No.  Merge conflicts are inherent in this system.

Yes, merge conflicts are inherent in this system when one makes a
single change which impacts multiple subsystems, e.g. changing a core
kernel function which is called by multiple subsystems.  However, that
isn't what this patch does, it makes a number of self-contained
changes across multiple subsystems; there are no cross-subsystem
dependencies in this patch.  You are increasing the likelihood of
conflicts for no good reason; that is why I'm asking you to split this
patch and others like it.

> There is just no good way to do this as sending a set
> of per subsystem patches guarantees partial application
> of the entire set.

Please explain why all of these changes need to be made at the same
time?  Looking quickly at the patch it would appear that each chunk of
the patch could be applied independently and the kernel would still
build and operate correctly.  I'm not suggesting that you decompose
this patch with that level of granularity, that would be silly, but
splitting this patch (and many of the others you tend to submit) at
subsystem boundaries should be possible.

Further, as one could see from the responses of the other LSM
maintainers, splitting this patch is not just possible, it is
desirable.

> If you prefer, each sub-subsystem maintainer, at
> whatever granularity desired, could apply the patch
> to the appropriate subsystem by using
> "git am --include=<subsystem_path>".

Or you could split the patch up by subsystem before posting, like so
many other developers do already.

-- 
paul moore
www.paul-moore.com
