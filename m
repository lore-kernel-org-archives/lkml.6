Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5256CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072FB21782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OLu941U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072FB21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbeHCVJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:09:28 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:40678 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeHCVJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:09:28 -0400
Received: by mail-io0-f174.google.com with SMTP id l14-v6so5867709iob.7;
        Fri, 03 Aug 2018 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwwIur6umNjycxCiRrkC2BJRxRkLaWADCN1BfLDsqCE=;
        b=OLu941U9ouGk3v3AvSgK72zuheGLRg9yfurmgLpOiR34V8Y73J5zWFufWA52CwDD1V
         cpXXFC0+COm70rcwuCvGMMBFxqgwOmHpwj4AwZtMCn0AQzDUccCoz8NFcDcz7bSNr+jD
         KXDfBygoG9XTfQDe/08alma7LjPKjv2TvNbxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwwIur6umNjycxCiRrkC2BJRxRkLaWADCN1BfLDsqCE=;
        b=b4o3FF9ChALjfUbMYdWSGHom0M9DvE4EyyCHrY+5vnPSXYZq2WrgpkN3so+AG/hkXQ
         xbMPl+1rVXD0fnWnHVwfOF/HVTmcyZLzZoEU8l4LdwgddjMfiKX2pdw4v/HfmQ+6Mjb1
         zHO7bIl9nLP/9R26j6SZDSOVy5OyL2hFBJ8DRKVz5ow5cFx2qzJFxI7HeQK5tLwR5cyO
         w/vxHf0+DAafHL9OyZdDF86c9qsQgSFjEmRInQEl6eWcyEZObm/v6Wbzipsb5xMVDyn8
         vF9qGUc/6z3nxcBa2eTnzveCwrL5/nsOKo1rueTcwN817XWtBIxv+KEQukYsk6rcYDwF
         QJgg==
X-Gm-Message-State: AOUpUlGnowF6tGB+8CzLeqQ1ZbtcGF1/9uKRzy9Hu+TH1tU49N5Yjc3G
        lRSVMrAc5nuM/j4wcEpbmFTAR+HHzqn6v0OHdJ0=
X-Google-Smtp-Source: AA+uWPxBdn2k6SX3zXOAG2FllObtoAQoJGUnJ2so01NXLKSofRn0eHbaldobg73bxRao38ujYlqH1YFf2WPNGFMQ06Q=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr7511909iom.238.1533323512782;
 Fri, 03 Aug 2018 12:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru> <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com> <20180803152034.GD32066@thunk.org>
 <20180803183932.GA3258@redhat.com> <CA+55aFwGGjs_imFFkEPJ4g99Kseam=4Qppv4G6Q=ZfZXdzF7Vw@mail.gmail.com>
 <20180803190617.GA4498@redhat.com>
In-Reply-To: <20180803190617.GA4498@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Aug 2018 12:11:41 -0700
Message-ID: <CA+55aFy+j6fyvXxbZH8rnrqvSTQ=jFMOq-yu6Hmncf4fOiP=Mw@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru,
        Zdenek Kabelac <zkabelac@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 12:06 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> But you're making Zdenek's response into mine and threathening to no
> longer pull from me.

No. I'm *very* unhappy about how you seem to think that Zdenek's
response was even half-way ok, and you jumped in when Ted said it
wasn't.

            Linus
