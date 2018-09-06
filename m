Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BC120857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BC120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeIFHUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:20:08 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:45565 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeIFHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:20:08 -0400
Received: by mail-oi0-f45.google.com with SMTP id t68-v6so17678295oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 19:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0ql8L1cMJG1B32uJRgxPjeA+n/lQBZrFACx+EstKLk=;
        b=Uiv9YPq/c4VWpXWwsa2lLJg8aMUMiifxkXY2ikH3D1ZT+TyyCxIzodNTVrZz2kDK2t
         EY0UW4kcIP8HQoXtOMe+LQtDVLL/is/qe3hZzU/pGxysnh282bs5nBhCdTPSO9V8ctQg
         D195mnOAXWB8TGVm8fEondeYYjiXWD8TE4adOhihpaGU/vNWvYCNxbnKIKHkRhBjgaJB
         nAmCKtLIAX6zVOLPXFPN6E5jnWfZDRNfcq4a7l4XW4xY45UBTlsWarLWi9EePxqUkUBE
         GM7cxhNdLUj/Lm+LnUuF+xYOQvkVmRZt/dVqKhSyXOpmUo7GWmKDb4fe5f2vMz8aVK9r
         0qPw==
X-Gm-Message-State: APzg51AKG7CFnvTarmJQqevZvpkyat/Y7YTGbChNR1PxsQMqUy7iM77F
        5x4Gp3ti1xzADDue/PMcjAoDy2BybtcsMDPlFU8B+A==
X-Google-Smtp-Source: ANB0VdZfizAScXRwGr17Mdlw8fqA7XcBmzJNyp9RTMzy8AHqyZcLhf/PwgXHUNdhjF9d4tfcCUCySgMwFmqKZ5NevgA=
X-Received: by 2002:aca:3003:: with SMTP id w3-v6mr655910oiw.231.1536202022053;
 Wed, 05 Sep 2018 19:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180802024648.GA499@jagdpanzerIV> <20180906024243.GB749@jagdpanzerIV>
In-Reply-To: <20180906024243.GB749@jagdpanzerIV>
From:   Ben Skeggs <bskeggs@redhat.com>
Date:   Thu, 6 Sep 2018 12:46:50 +1000
Message-ID: <CABDvA=kjVto=Wo1=K9o36mWkvnmG1ck8dPm--G5jQokqH7XGCA@mail.gmail.com>
Subject: Re: [linux-next] DDC responded, but no EDID for %s errors
To:     sergey.senozhatsky.work@gmail.com
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 12:42 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (08/02/18 11:46), Sergey Senozhatsky wrote:
> > Hi,
> >
> > My dmesg is filled up with these errors
> >
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > [..]
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > [..]
> >
> > Basically, a message every 10s or so. Any chance we can make them
> > go away?
>
> A gentle ping?
I've got patches queued in my tree to resolve this, I will get them to
drm-fixes shortly.

Ben.

>
> It literally floods my logbuf with that "DRM: DDC responded, but no EDID
> for VGA-1" thing.
>
> name -a
> 4.19.0-rc2-dbg-00118-gb9a3bad8af2d
>
> $ dmesg | tail -42
> [ 3615.796938] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3626.036865] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3636.276878] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3646.516866] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3656.756750] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3666.996949] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3677.236884] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3687.476865] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3697.716858] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3707.956934] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3718.196925] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3728.436884] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3738.676861] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3748.916731] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3759.156754] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3769.396861] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3779.636826] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3789.876892] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3800.116686] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3810.356926] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3820.596887] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3830.836909] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3841.076932] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3851.316681] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3861.556926] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3871.796869] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3882.036750] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3892.276836] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3902.516803] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3912.756640] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3922.996957] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3933.236700] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3943.476851] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3953.716928] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3963.956915] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3974.196861] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3984.436928] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 3994.676885] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 4004.917030] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 4015.156935] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 4025.396872] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [ 4035.636877] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
>
>         -ss
