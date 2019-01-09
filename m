Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAE821738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g168KLbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfAIKfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:35:30 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38386 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:35:30 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so7749260qtl.5;
        Wed, 09 Jan 2019 02:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1DTfSsLWfiKQ3Qk4KvpFI3hjnQ31uNq337zO3QevBg=;
        b=g168KLbU2XFvnVL3ARtgmlHuFP4vXLVQlJgYhwdMnQEVRTYNs9tq9u+FF78pAPnJs3
         1KuLFb1Ppu+s2Ku7AOO60deQS2gdBA/DHaHpBwySbMdnOMwQzq3m4vidzqCdNomfPPBb
         awdY57TJedBf5TRwjx23MgHQzm7tjFzArRyMupYkHHvft4fDnieAG9njH5Qxfs+NCaPX
         fDrWdZ2Q2rpDm5qXmz0av67OopPzsuODJ/ShspeYZBDXWfXKHKiBO3nMuu/igSBJP1kT
         r48/azMCyjK8HFMt01Qzve6QbAIk+c5nbzY/DG1sNdG6+Fc42xXMSN1q5BRo2duL9ss5
         hU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1DTfSsLWfiKQ3Qk4KvpFI3hjnQ31uNq337zO3QevBg=;
        b=cqFf04SKpeCGFcv+ZmpupTaEvd8BkO5eihPY9HUkERrrly7hQg0SGnadUVd24X2OyK
         3if/X2hz0LyELZG/NJSkWILso05zvJ20BO4/y42HW30m6LSFSKUqYIgGt8/whUZwObQz
         J+Ire8ZFAHl7J7W0EG3NMDjxPykrWZGfzIluqFtPSM3/VolXnUuMIvDdk8jaHRcNLPIo
         oYSYRcwsy6dsgOPDu7i63fdMTGNZPuFQev3Y98lnMp7CtZmUQAqp7rTwZ0dTUGqlOd6u
         5S28/DkR3VZ0vJCdd9Efks7L+/HVQ4AGyfn5ZzrYy0bzvU4H/U3KvIwfTxi6bn6j/dW4
         ZPMw==
X-Gm-Message-State: AJcUukdn9dycKkeETvJ+eCRFJNIVwHN0YX1mYvp6Q4Kurto3TFLA/xov
        tWdG5OlGttDwWGSZ40Mq+xCXHxtgDdV1V15MiJ1MinshXwQ=
X-Google-Smtp-Source: ALg8bN5F/qD3QVzWhXGzM2PmKwdg3op8oP/ckcQ7EGqKce+pmFN/hJV4G1tyElJ7UxAVJVUOKk35FPzCPH84xaRmnwA=
X-Received: by 2002:ac8:71d0:: with SMTP id i16mr5220180qtp.386.1547030129307;
 Wed, 09 Jan 2019 02:35:29 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
 <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
In-Reply-To: <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Wed, 9 Jan 2019 04:35:17 -0600
Message-ID: <CALaQ_hrE9kX1F2sYab7rC6i15x1=vvJdOr4aTY3Oyx8w49sA7A@mail.gmail.com>
Subject: Re: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event type 37 -
 Kernel 4.19.13
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can ignore the last set of files with a sample of 1.
I got a nice sample of like 150 about 6 hours ago.
The link I included in the previous reply contains the same filenames,
just updated.
The journal timestamps (to correspond with the trace times) go from
"[513438.430253] computername kernel: xhci_hcd 0000:00:14.0: ERROR
unknown event type 37"
to
"[513438.796965] computername kernel: xhci_hcd 0000:00:14.0: ERROR
unknown event type 37"
That's 150 of them in less than 1/2 second.

On Wed, Jan 2, 2019 at 5:32 AM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> The event type 37 is a host controller event, most likely a event ring full error.
>
> So there are probably so many events that we fill the event ring before we can handle them.
>
> Could you take traces of this?
> Note that the trace file will be huge.
>
> mount -t debugfs none /sys/kernel/debug
> echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
> echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
>
> copy the traces somewhere safe once the error is triggered:
> cp /sys/kernel/debug/tracing/trace  /<somewhere>
>
> -Mathias
