Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cObbMI3vG1t6QwAAmS7hNA
	; Sat, 09 Jun 2018 15:17:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AD40C608C9; Sat,  9 Jun 2018 15:17:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="K9t/Fkxr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F3E42608BA;
	Sat,  9 Jun 2018 15:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3E42608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeFIPRa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:17:30 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33975 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbeFIPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:17:29 -0400
Received: by mail-oi0-f68.google.com with SMTP id i205-v6so14395232oib.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 08:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Srs10aGu97SDT63LqxVT2JnaRBZjA8mhV0gwru0FIf0=;
        b=K9t/FkxrDswQj8Hpbmu0qkc3VpcKPgLqZ+/eNlBAd1zo+B+pCoUHRrPj0qDSYJ4Xc3
         hWpJb6NXbC//XeFvq6cDXplK9IKB28Q4sd+ReFwf66qH9xDX2xBVHqndCZjbEcUOcz13
         //KOcq0zPfwF4QUSyrhotimvdVJiIhR+UOxHflOQstDMlB6lIHXPqjptV2crDj+SPlYY
         a7jcmbFtbtusNvP1D+XuDaWdf9z1dLcbMPorPjkKWvwYn3WZgodewjygQFthbX1xZbf8
         YKCKKHrCGcY5TFbJyM8ikHOvl62CAelRmra0s3zQiQqLeKXf/xwmPUvKmEOQ6BuZS3zd
         amPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Srs10aGu97SDT63LqxVT2JnaRBZjA8mhV0gwru0FIf0=;
        b=LP4QjKqIJ2cqW8YScT1/wH8JbzmCe5slonrCCPEnNoVvpw6fDm5wXh0TR/5p5k4DxG
         LN0Lh9NnDWOCEZNcembUgMGAwaRk95tyga/a210cDVrhKCpr8KACLPsrkVbDi6hV9jJy
         0bsLY2Au+hNevX1XQI7Qghaq91dAaZj/A2t1bF9yZ00ANPqQS/DhiSXRjgtMmJ5NwZJE
         8O8yt3nO0ODNVSALXVv5RE3hqph82KI1nHPZldwlMPloHZAsgu12BpbJCfC4s9ZSZ7/5
         t7Jtg/IZLxO/oxWEGGO+C0RyZz2ZFzVv5nOOB0/SFEvBxnOLgoSjU4HdR7LQfeAxG6wp
         Ixyg==
X-Gm-Message-State: APt69E2jI4UMEfzdl/Bkhoto581GEDcQEuciPfl7FpM4amir6SEwaDOR
        78rbTayHP3duv7KkR5SFw1r84nA7A07FlB5toPijaw==
X-Google-Smtp-Source: ADUXVKK68ej637Qct2mPdXtXybXxvkJ31ETkv3JIfJN9Lzw1TCVSp3mU2H3hRjlPFaprJc0U6Q9apkF0x83h4nf43cA=
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr5601862oia.215.1528557448620;
 Sat, 09 Jun 2018 08:17:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 08:17:27 -0700 (PDT)
In-Reply-To: <CA+55aFyTXHxaRQhsCwgicFw6=xk80Bjw92tgfmmRP4HQ-AhSvw@mail.gmail.com>
References: <1528502307.25740.14.camel@intel.com> <CA+55aFy_fiF2bwW=0gL4g8uL5099hWarL4+Q9djmDEuwRR2KKw@mail.gmail.com>
 <CA+55aFyTXHxaRQhsCwgicFw6=xk80Bjw92tgfmmRP4HQ-AhSvw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 9 Jun 2018 08:17:27 -0700
Message-ID: <CAPcyv4hPTyfSO5pncQ84cPrTe4sUJ+jA6cMHXm-6ocvLGKr65A@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for 4.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 5:26 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jun 8, 2018 at 5:19 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> If I get stuff that looks at all complex at the end of the merge
>> window, I will just cackle unpleasantly while I press the big 'D' key
>> on my keyboard.
>
> Side note: looking at what I just pulled, there was close to a D key here too.
>
> Dammit, the top commit in your tree is a merge. And the merge message
> for that merge is this:
>
>     Merge branch 'for-4.18/mcsafe' into libnvdimm-for-next
>
> That's it. One line. That doesn't say anything at all.
>
> That kind of uninformative commit message wouldn't be remotely
> acceptable for a regular simple one-liner patch.
>
> WHY THE HELL DO PEOPLE CONTINUE TO THINK THAT IT'S OK FOR MERGES?
>
> Dammit. Merges are *more* complex than random usual patches. They need
> proper commit messages. Yet you have two merges there with absolutely
> *no* information in the commit message.
>
> If you can't be bothered to write an informative commit message for a
> merge, you damn well shouldn't do the merge.
>
> It really is that simple.

Well, crap. I've been doing it the wrong way for a while. Do you have
a preference for more pull requests or just splitting what is now a
top level tag message into a summary changelog per branch when I merge
the ready branches for the merge window? I had been assuming that the
arrangement you have with Ingo / Thomas to pull individual topics was
a privilege for the tip tree and not necessarily something everyone
that sends you pulls should be doing.
