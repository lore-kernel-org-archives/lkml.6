Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54254C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BE020644
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZO/fMUc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BE020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeJHATX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:19:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46544 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeJHATX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:19:23 -0400
Received: by mail-io1-f67.google.com with SMTP id t7-v6so14160798ioj.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdoF9j7UBMBaavdMfRf9/McfiVJ/XSSbHcET8rv6DZs=;
        b=ZO/fMUc0XC03eeSY8rkieCgV47L84FkDKebM7NCfj+rnmZde4FeJlotrhs2+dsb2Z6
         AxRv9c/XpDhEEn8qzwB2m2iAm6iyGq7FYcxkGGUGCSYWE5awwvm2DYo+HcFBbX3XvrhA
         Lp6M+TZKR0iDXL1WsThSXVLrH8GYjepes9JhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdoF9j7UBMBaavdMfRf9/McfiVJ/XSSbHcET8rv6DZs=;
        b=XChN4gMjz6alqolezZwve6NH3uHWGE61F2vtrWOYcZQUSx1rpODekT7Lky+wMz5wgJ
         MmJcD1F7a2SGaTNdaCeqVpPvdx5tw+iXH+r0zToPxazC2WA/I4p0VTrOa5SrWRX75Yrl
         XbU+vsdyCiLZVFCRdN6QmzGn9K7piLCZZGwtCbs1Pj6JyGdUmUTPCKTSL9iPJQxri7bM
         HFndBR6E7HTIKI09s5eSlWRgdxjlJh2/IiLna/O9RZEQCdVSG5saztS76rlW8D8aLN67
         QCKdrHF6CoXbuXsbaEodPeaanHXuRfFUgYD7k+wO9eOQKyf3mq5AE2yN3sTB+WwS5MLd
         /EpQ==
X-Gm-Message-State: ABuFfohhn/TxbEQz7fMEK5ne4/Ae8tUc1k6UBKao5sZhcXdo9/vMHbvQ
        Fh1mmus+KN9RigaqwjOaWfTDdmSXMn+jQwnurGbZskw/
X-Google-Smtp-Source: ACcGV60NyHXQcqKmLT520QcKIWxwop30uCbnh6zy/wROPt2tYzHrkTpgzJR5caW2k3BpUbHiQ0WavHFdJw6A+xmgFTw=
X-Received: by 2002:a5e:d51a:: with SMTP id e26-v6mr9611344iom.291.1538932287189;
 Sun, 07 Oct 2018 10:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <1538861738.4088.5.camel@HansenPartnership.com>
In-Reply-To: <1538861738.4088.5.camel@HansenPartnership.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sun, 7 Oct 2018 19:11:14 +0200
Message-ID: <CAKMK7uFvmXtk=WiZJxGrzQQD1RHv7srA-_e8KdwXZ9Kn5rcmiQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 0/2] code of conduct fixes
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Sat, Oct 6, 2018 at 11:36 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> We've had several threads discussing potential changes to the code of
> conduct but Mauro is the only person to have proposed an actual patch.
> In order to move the debate on, I'm presenting two patches, one to fix
> the email problem Mauro identified and the other to strip the
> enforcement section pending community discussion as Shuah suggested.
>
> I'll take responsibility for collecting any tags people want to add
> (review/ack/sign off, etc) and sending the patch in as a signed pull
> request before 4.19 final if they get enough community support.
>
> Note, I've sent both patches in as a series to facilitate review and
> discussion, but they are separable if one is looked on with less favour
> than the other.
>
> It was also a bit unclear which list to send this to, but I finally
> settled on linux-kernel as the catch all and ksummit-discuss since
> that's where most of the current discussion is.  I can add other lists
> as people suggest them.

Personally I'm not happy at all with how the new code of conduct was
rushed in, least because I still don't understand why it happened, but
also for all the other reasons we've discussed here in the past few
weeks.

For all the same reasons I don't think it's a good idea to now rush in
a few edits, just a few days before the 4.19 release. In my
experience, and I've discussed code of conducts and their enforcement
for years even before we implemented the fd.o/dri-devel one, mailing
lists aren't the best place to have this discussion. Definitely not
under the time pressure of just a few days to get it all sorted. I
hope that we can have these discussiones at the maintainer summit and
kernel summit/plumbers, and will have more clarity in a few weeks
(probably more likely months).

But I also understand that there's lots of people (me included) who
don't want to ship a release with the code of conduct in it's current
in-between state. I think adding a disclaimer at the top, along the
lines of

"Please note that this code of conduct and it's enforcement are still
under discussion."

would make this clear and ameliorate the concerns from many people
about the open questions we still have, at least for now. This would
give us the time to discuss all the details properly and with all due
deliberation. I'm travelling next week, so not the right guy to push
this, but I'd be happy to ack such a patch (or something along the
same lines). I also believe that this statement is undisputed enough
that we can gather widespread support for it in the few days left
until 4.19 ships to make it happen.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
