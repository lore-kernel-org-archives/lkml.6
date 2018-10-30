Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBB3C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA7820664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSiijJ+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA7820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeJaINe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:13:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34073 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:13:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so8443623qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R4FfmyudWt22yr3GuUsX1lBmqq2M04khVTuNGRj1dc4=;
        b=FSiijJ+qyZc8Gd3BrQEIT4zszQZz8FY2xCdyIVFNQkundmNKxd0cqC11QWPUrVDQdU
         4WgU0LyH/3IGr57y04ElyyY2zxklvZURb36l2HQgv9RLacYYMZSkrcKcj//RkWBFvoLn
         Hl2kmBCX90wVXHHb6BrZOIzQ94pvdATh7Ck+Jk42uG5HRjwlGR+sA5iQ7seU2aiWbZBw
         UuJ1Owr4AOp0c1o0ex87065mMhwhNsAaMvrIxFjYyTALMaEQ1bfQvLkjtC9KPBfsdZRq
         QQOJ7bBRID4Nlc/H9nond8l8t0GNRdOV9CGUzEZjj+9A9Ba6npNbNr2ZMLhzDaUb5q+S
         Wy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R4FfmyudWt22yr3GuUsX1lBmqq2M04khVTuNGRj1dc4=;
        b=oszvZKtEBqzXRBEf+S3sYWJGxwqQIKS3q6ZCHew1tFGHV3fp/GERvmZ6CLpTW0ak2H
         AlLRQWcWSabGoMNIKPuh/i0ppvtxOPZ0QVzwQgY23LHz2nF5pBPyO3EI+IgTitdYUINi
         g0W8YqpYnQAWOraVHAfmDrMmIdZfuqepx79KBhbxg2JOFBgfmIEvQrckOF/ErBEXGaa9
         zyFVKTNPVxLeKlRvIj8T0uNfMiKbpsdiZItJI0qt7X5NfIEL1pnWSmOMEb+NOka+rTDJ
         SRPgRvzg/LRiTEcIzGj6mrGvrr+V1G013ay0CWIXBS100oGa2/uirnZf8JC3cu3iMv96
         0sjQ==
X-Gm-Message-State: AGRZ1gIo7dIBfLgEWvl0o2KR7oddfwmia9TR7g5ZxI6pTcWFprFpVcmD
        Z2UzcTVO325wFPuHwhqDw1Y=
X-Google-Smtp-Source: AJdET5f/6Je3x2DVBwM2hkBFhl5FZyjC1dI3TZIqGKrrPluYufCBSOx6uM/Vqfhf1Sxuw7aQi4NJUg==
X-Received: by 2002:a37:a09:: with SMTP id 9mr591188qkk.339.1540941481438;
        Tue, 30 Oct 2018 16:18:01 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c79-v6sm21125836qka.83.2018.10.30.16.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 16:18:00 -0700 (PDT)
Date:   Tue, 30 Oct 2018 20:17:57 -0300
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vboxvideo: Remove unnecessary parentheses
Message-ID: <20181030231757.24ooubt25oykmgkt@smtp.gmail.com>
References: <20181023174304.iq4ra7vafwujr3ex@smtp.gmail.com>
 <20181030092539.GA10009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030092539.GA10009@kroah.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Greg Kroah-Hartman wrote:
> On Tue, Oct 23, 2018 at 02:43:04PM -0300, Shayenne da Luz Moura wrote:
> > Remove unneeded parentheses around the arguments of ||. This reduces
> > clutter and code behave in the same way.
> > Change suggested by checkpatch.pl.
> > 
> > vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
> > crtc->x'
> > 
> > Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in v2:
> >   - Make the commit message more clearer.
> 
> This patch does not apply to the latest kernel tree at all :(
> 
> Please fix up and resend.
> 
> thanks,
> 
> greg k-h

Hi Greg!

Sorry, I do not know what branch are expected to be used.
I used the drm-misc-next to create this patch and I could not
find any merge problem.

Could you please tell me the details?

Thanks,

Shayenne
