Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AAB2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="tg4xYssa";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="BAnXOoWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AAB2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeJQRuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:50:20 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:5439 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbeJQRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:50:20 -0400
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9H9rJeU020484
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:55:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=iWrG4H3562DqofSZnEETaSKBiRB5u25Y6J2x2L0MvjI=;
 b=tg4xYssa+SY9JCMLYEoOA6e7G2cHkLsH1V8RCo0yCmkEikPiJAbEcdezXAyd2bn36mRM
 xvECtJ4NK21be236VaSnH0LnYlEyULPZdgR7DiBC0Tn0CjKPIHLju107HgFtsQEAfedE
 236orSzqfYIdBmuV19TdJuONhUqn0RywFrmOBYYOjePKdFRgktk/SQYl6afG3/7n7yKZ
 QTiX1chJLbEATyqVM2Tpr8N3ax+sd1zbQZn/bwaAUeePteOcgd+77OYinUQvBFm9I6lD
 Zclv9VUCftc/x8qWbJUWVk8lPw59cbG83PCI/oPfCa7hwT7PMj2nRLTG14dkcz6z7Mbb Bg== 
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by mx07-00252a01.pphosted.com with ESMTP id 2n3641a49r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:55:22 +0100
Received: by mail-pl1-f198.google.com with SMTP id b23-v6so20321127pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWrG4H3562DqofSZnEETaSKBiRB5u25Y6J2x2L0MvjI=;
        b=BAnXOoWENf29poweo4JTozaLEmmjyqrJFd/VB9Foz6UBTPcW0064/j3CU45Wifbh96
         TzHN+EtSGZHUBveDTzYlfmi6tzXDR1bImJYUNVp+rhLCu9wMIwrVXOyuDXWkpOTsXJ4I
         zL2VeMoJqTVUMeEgKMFTPz3av1fZwTgwjWRjUIL3VlOxxOmNlXqm8BCi+XjjHfSpYdJE
         pTmwcIuMAkC4/8YVNSnLVuhjH99ZRmLV1e8LJ+ZSoNdWR+90aCXEMoA5+Sne2h/GJW1F
         yy/6v4LUnYGIUUtw9/+NyRTPEX0Xyu/mJDKBQx4juYgeVZUrTQUMwbN/fw2SLFup/+Vl
         AKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWrG4H3562DqofSZnEETaSKBiRB5u25Y6J2x2L0MvjI=;
        b=BA0VyE3hycuVu6eM4jFW7U55YGEe/eQI2A0xHwZ91RAAf0NxLm0eM8W899hLNsB0t0
         o/JN/PrFqxNoTD9LXxXWJq6z933aqn7nmChUyaJAPO4dJAfbma3ItY/IKHTv1Nv7zSyZ
         rxOz9UBjuoyTL0fPmt9oFVfYY86/1O1nINBjSR2RrGbT21AcocrFdQUXm4mBiKy6r5LH
         HIH3TlltJe//l6km7D74DuHRByqlW8xX2HhHSpv138An/8Yabaw1DOE23EXW/e/nChoD
         0O0t8KjuFIkUFUE+w2OnYr0ozesCYWPAfJ1egjt79a690I8RBSU8yDz/hNstbeBaXe2x
         vyLQ==
X-Gm-Message-State: ABuFfojteiSwRxSV+JSsJUVDlZqrR6xI6vo4IMs6EAOxk7CC5qwZ6lp7
        urgQ3tKqVmjGGR4KJrDp1kI32ow9fvom9MR5uSuDh3wct+jY1y+j+/GUgWGqr3ftBVsb6t7nyPw
        uvSPdvq8VKwKOuqBjOmhb9YxaC+y3Ar3/jAQb9KA=
X-Received: by 2002:a62:5441:: with SMTP id i62-v6mr25974351pfb.155.1539770120416;
        Wed, 17 Oct 2018 02:55:20 -0700 (PDT)
X-Google-Smtp-Source: ACcGV638P+81PnmyFPqQL1AkI86+qOz3L9pBNbTG+kuEc24tCGyyBp6BLt/QwcqC5G75Mcaq26cHvK6eGY7oAbTJvu0=
X-Received: by 2002:a62:5441:: with SMTP id i62-v6mr25974335pfb.155.1539770120144;
 Wed, 17 Oct 2018 02:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
 <1715113043.52878.1538821118324@email.1und1.de> <87a7nf5gr9.fsf@anholt.net>
In-Reply-To: <87a7nf5gr9.fsf@anholt.net>
From:   Dave Stevenson <dave.stevenson@raspberrypi.org>
Date:   Wed, 17 Oct 2018 10:55:06 +0100
Message-ID: <CAAoAYcN_xVvi2-dUcGobVcMEtjFTV=Hi7OFr2vuEF08aQkVWHA@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
To:     Eric Anholt <eric@anholt.net>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, tuomas.tynkkynen@iki.fi,
        Phil Elwell <phil@raspberrypi.org>, devel@driverdev.osuosl.org,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 at 17:27, Eric Anholt <eric@anholt.net> wrote:
>
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
> > Hi Tuomas,
> >
> >> Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> hat am 4. Oktober 2018 um 11:37 geschrieben:
> >>
> >>
> >> Drop various pieces of dead code from here and there to get rid of
> >> the remaining users of VCHI_CONNECTION_T. After that we get to drop
> >> entire header files worth of unused code.
> >>
> >> I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
> >> snd-bcm2835 can still play analog audio just fine.
> >>
> >
> > thanks and i'm fine with your patch series:
> >
> > Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> >
> > Unfortunately this would break compilation of the downstream vchi
> > drivers like vcsm [1]. Personally i don't want to maintain another
> > one, because i cannot see the gain of the resulting effort.
> >
> > [1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom/vc_sm

I'm happy enough to work around these changes. Once the change is in a
released kernel we can merge a modified version of vc_sm into the
downstream kernel branch. It's not as if it requires big changes.

> I think the main concern would be if we removed things necessary for
> 6by9's new vcsm (the one that will let us do dma-buf sharing between
> media decode and DRM).

The new vcsm uses the same VCHI service as the existing downstream vc_sm driver.
The video codec driver don't use any VCHI functionality over and above
the camera. It goes via a slightly extended version of the
mmal-vchiq.c, which I have split out into a shared module.

> On the other hand, git revert is a thing, so it's not like we actually
> lose anything.

:-)

  Dave
