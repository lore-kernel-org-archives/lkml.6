Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ED0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F1A206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvvWB4zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F1A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJDEii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:38:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39348 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJDEii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:38:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id e22-v6so663070qto.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxfXYzQuj+hJQ2qmEGDI2ygSNG7BGjn3EMXwYB8r0fE=;
        b=RvvWB4zrCJfAYH4pBPP5g6nT4t/JUmEm4laaPDhUY/lLjYM0s3aI3ybkBc1Sili3gx
         LhcXoudYm9qT3dB9DQFo4f+9brtsJkxdcMDgolsc00biXhpcKwLc0CD288Yu1bKvDyVK
         FwCewAeL3gWIHFLpQhRKnIyBljZZ4CMmyxdrPd3dust8HOANQG4hAWhN4RmHKmuNcOyi
         UspktHi/PBGtbndzwl/AdDsE9npaozI4bVvaK5KjNbxXBc8CFF9CKQJC8uq2dx1fo5dG
         KBFudH2tq7h7GMl1wotq7DLf20lo6YBxx8/khFK6+NmbQ8uJ9vGAIufb67cpSxQ19iog
         ZBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxfXYzQuj+hJQ2qmEGDI2ygSNG7BGjn3EMXwYB8r0fE=;
        b=dwOqZhgcUEgQsmMopM9I0wP8v6uh4gHjJ+BRRLrkL1bCcnZeoC/NMKyPOgcwkrPzZA
         MTTOudZix1gGzJL9etcyFi5Z46ZUvgDIe5QS8UJk/Zr6I1mFfNkMihwWI6RbmlTxvgQu
         SSmyYKcfHBX7J4WnrIYzW9Wt5LE2/4sVbnUkR8StA2euDt8FCXajsHeaVcfqGWXWQhSE
         JglhrXBDrV9SQk8o94N6Ve1Kdm5bEY2DbjVytiRm/+A+6wmznwyGJyfKo1oSoBkFK9jk
         ohVNkfsqFaXrYKQBTtjjH75XPFX5X6bHFbYGLo5QeDFjC/RhdoNxNg9sPyC3S89mcJQA
         Lraw==
X-Gm-Message-State: ABuFfoiho0NCJyzKykG891Upyqz6MzfVBb7CBTXE3gNmxsh4o6rqDLPI
        VLRY8mmiuqBl3VhRoPjtToh9AzczbvzLE9aNvR8=
X-Google-Smtp-Source: ACcGV63aKViQYYVD/nH33cdTjVNh/A2JU+6YQzgjRbiEtmijmrbo9zp4sQIM9W0R87Yf+Z3cOyrskTrxyF/Wv6KaEjk=
X-Received: by 2002:ac8:435b:: with SMTP id a27-v6mr2847068qtn.295.1538603306995;
 Wed, 03 Oct 2018 14:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181002142327.GA19792@vkoul-mobl> <20181002163850.GA11549@kroah.com>
 <CANiq72meqnbNYd0syo4DJftZedOD3GitAGeFT_66bpjCV93ehg@mail.gmail.com> <20181002184400.GA28146@kroah.com>
In-Reply-To: <20181002184400.GA28146@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 Oct 2018 23:48:15 +0200
Message-ID: <CANiq72kY-f+tpOFOsG5VcK5z9W4LsCBmibtxJx4h=UTLQMd6oA@mail.gmail.com>
Subject: Re: [GIT PULL] SoundWire updates for 4.20-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     vkoul@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        pierre-louis.bossart@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Oct 2, 2018 at 8:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 02, 2018 at 08:38:41PM +0200, Miguel Ojeda wrote:
> > Hi Greg,
> >
> > On Tue, Oct 2, 2018 at 8:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Oct 02, 2018 at 07:53:27PM +0530, Vinod wrote:
> > > > Hey Greg,
> > > >
> > > > Here are the SoundWire updates (again) for 4.20-rc1/5.0-rc1
> > > > This brings in the multi-link streaming support and rst format
> > > > corrections. The changes are in linux-next for quite some time.
> > > >
> > > > Please consider pull to receive:
> > > >
> > > > The following changes since commit 8d6ccf5cebbc7ed1dee9986e36853a78dfb64084:
> > > >
> > > >   soundwire: Fix acquiring bus lock twice during master release (2018-08-27 09:49:48 +0530)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-4.20-rc1
> > >
> > > Now pulled, thanks.
> > >
> > > greg k-h
> >
> > Confused here -- pulled to where? 4.19 will still have rc7, no?
>
> Pulled to my char-misc-branch to be submitted to "mainline" once
> 4.19-final is out.

Ah, alright! Sorry & thanks!

>
> This has nothing to do with the 4.19-rc development process right now,
> sorry for any potential confusion.

No problem! It was bound to happen now that you are Linus' alter ego ;-)

Cheers,
Miguel
