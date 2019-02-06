Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA76C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC572081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S1ZQg6yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfBFP3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:29:24 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38704 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfBFP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:29:24 -0500
Received: by mail-vk1-f196.google.com with SMTP id w72so1712026vkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTKfnQFkkJ/QsAoPKwJp9zSQ4x0uzyPSgB4zTS8O4bM=;
        b=S1ZQg6yhQBTL10D8RPa4Ls0DzVs70IeJjWZ+WVXnubNYJiDaeZ/qIuJ0ILkS9cq+aM
         HJvnk56NvhjUoQdcVZPFP+R25yPfgwnyTmQTh9tjbGAVoNJWy51G3+Yd5Kt2XwmDxVTB
         2LExsm9FZwQKpoJ6/qvfOdU5O7M8U/cewY6o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTKfnQFkkJ/QsAoPKwJp9zSQ4x0uzyPSgB4zTS8O4bM=;
        b=Oog1lcmp2LA4V1GCXh9NNKnvCtOkwSdgLHyd3A4GYdAxgCqitTaZD/XvSO9XOhTh7D
         DJ5I5GQ9xNwqR6FW605ltMyCZqaaVH3B9T5fdoGroYDn7W8GQNWGC+8JCMmabLkra1b3
         cQ1ZFlpiSlJ2QYoXxvdBUfvEIfOXKOtEOSUI5lgsGATirzOI58MfG6s8PTguzqsoczj6
         N3NZae1e+5ZczRHiAyvqN9bI63EXjaeuzU1B6NJCGOce7hLKQMKHVNHiqQ1PIZtVoIBD
         heGEFhMhMAYSSut2XzzdkOjx/gANT+0glzL6p7zpSUS2TMVD9eO2HQgXe6zfcPQFuHaV
         maFw==
X-Gm-Message-State: AHQUAuZ1j2+PWbiS7sqGFFZtdi4G9BRZAfPuF9YK3roo1JoAgoC8H3pn
        jfx+4DnO4mAqyRYgq7WdVnrKa/onrtc=
X-Google-Smtp-Source: AHgI3IYQ7T+tXevDbaTBneFcQsBOS7pF9mReLaj/QlkLImgQ2mKVA+vG0dZrGlerGVzWixUpArLJEQ==
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr4397517vkc.52.1549466962902;
        Wed, 06 Feb 2019 07:29:22 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id q125sm3869843vkh.32.2019.02.06.07.29.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 07:29:19 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id p74so4644047vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:29:19 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr4744679vsc.48.1549466958881;
 Wed, 06 Feb 2019 07:29:18 -0800 (PST)
MIME-Version: 1.0
References: <1548866403-13390-1-git-send-email-js@alien8.de>
 <1548866403-13390-2-git-send-email-js@alien8.de> <20190205144441.GS21801@zn.tnic>
 <ciirm8womdaxn2.fsf@u54ee758033e858cfa736.ant.amazon.com> <20190206141753.GE7314@zn.tnic>
In-Reply-To: <20190206141753.GE7314@zn.tnic>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 6 Feb 2019 15:29:06 +0000
X-Gmail-Original-Message-ID: <CAGXu5jLdm5O9U5N+LR15EnAYcPGB83qK_soaKb7HJ_Pa+G5+Fg@mail.gmail.com>
Message-ID: <CAGXu5jLdm5O9U5N+LR15EnAYcPGB83qK_soaKb7HJ_Pa+G5+Fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/boot: increase maximum number of avoided KASLR regions
To:     Borislav Petkov <bp@alien8.de>
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Julian Stecklina <js@alien8.de>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, jschoenh@amazon.de,
        Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 2:18 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 06, 2019 at 01:50:57PM +0100, Julian Stecklina wrote:
> > Because at this point, we are not in a good position to handle an
> > unlimited amount of regions.
>
> We could save only the regions which are ok to kaslr into. And we do,
> apparently:
>
> static struct slot_area slot_areas[MAX_SLOT_AREA];
>
> but I guess there was a reason to do the mem_avoid thing too instead of
> collecting only OK ranges directly. Maybe Kees will know.

Originally, there weren't a lot of things that needed to be avoided
and physical memory was relatively consecutive, so adding complexity
here didn't make sense.

I'm fine adjusting all this to do things better. Ultimately, we're
still walking two lists to process their intersection.

> > As for the choice of "16", I took our usecase and multiplied it by two.
> > FWIW, this could be even larger.
>
> Because our kernel is not fat enough huh?

Eh, it's just in the boot stub. ;)

-- 
Kees Cook
