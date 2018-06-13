Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E269CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8747120020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hqli8dJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8747120020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935746AbeFMN5K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:57:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42342 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935719AbeFMN5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:57:07 -0400
Received: by mail-io0-f194.google.com with SMTP id r24-v6so3513157ioh.9;
        Wed, 13 Jun 2018 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czmfE0rshdChScnyOu30ZfSmkfvXhyOBFAS310Aun1o=;
        b=hqli8dJJgaZdTVmOpTocq7PKl2VGKZ/WnEcU67oY5p/5uvJc6dBTCnjF8NKCp3GgyF
         AaLPc7hzJJNKnyFQT5rAj3heWnbvHiY8KTZBXVnBVW09bgAE25K67nZlzCaJvZLI+xSw
         DiryxhABN/GTLEiMBfyZd0NmZZyBaYHCrl+go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czmfE0rshdChScnyOu30ZfSmkfvXhyOBFAS310Aun1o=;
        b=D2mwkxhScvESFPN/JtSyer5AdJc5nW7WG/qMq0dB2zRpEgOi0dhiN2iouUXa+tX7uu
         OGjSBBLC1+azK2KlBC5PIPQ0qyxEaN4cT1Zx4z+2UulIlaNOdldPSFBtNTrMqu1fdGib
         krYRv5FoAIHqEdElf8y30T83WmiTfKboFf8fKhMomFClskKb81Ki3HeMcZlQu0r6Upmz
         8hdJszN+MdJ0IkFjunjRCvTzSE9bH/Rujz5ORBo9vxN2CY1OBdNiT0yLDk89QxSeV5Y5
         z4YdRwkwb721ss0uzpmP6GNEmSTs6peGIhUJ1vrAXQAtE3uhdP1Nv7VzwnCxu+1WDWhN
         enRA==
X-Gm-Message-State: APt69E2p/EbkiGHqnL9tOweGjCwuwbW+eMANnGJWTiPHsESR5B0X42AP
        /9ovuNdHvhri3tytKZ3aeZeJQw0bK3aTaIPRzY0=
X-Google-Smtp-Source: ADUXVKICV3zgD6kxPpyOQHvyR2bUPIaN1FKJHDxRNum6L9sJ3NDkGVMsQLjVSsv/KcZAOQonvSXsGWur6Zr+Gb+cKro=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr4993063ion.259.1528898226569;
 Wed, 13 Jun 2018 06:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com> <6570c00b-bbec-82c3-16e2-1ba96d8e263b@redhat.com>
In-Reply-To: <6570c00b-bbec-82c3-16e2-1ba96d8e263b@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 06:56:55 -0700
Message-ID: <CA+55aFxyQ0HE6ShB_pF1yXS9VjQv78OyseJpZjLXu=rbBTEPTQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 3:09 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 13/06/2018 04:18, Linus Torvalds wrote:
> >
> > Hmm? And why was this not found before it hit my tree?
>
> Because I should do more "make randconfig"s, probably.

Well, being in linux-next should have found it too. I know linux-next
had a lot of kvm stuff in it, was this not there?

                Linus
