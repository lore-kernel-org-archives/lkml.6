Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E30C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2632192C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wy87EbSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2632192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHHCRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:17:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46419 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHHCRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:17:41 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so676063oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fHNaf21+ty041MRvpbYDXKEhiexp6vn+weXebmL+fpc=;
        b=Wy87EbSXviFhnI1Pum6oeg1nRyJWl98CBLQqvvpoDbJ6U9yEaAyiBB1QCrf3piMZWi
         m4A7oJ8w48U5f+yjNOIDFI2s7yRXhnXh25B+BlgrmZGzjCR0VgIm5NY9r4LP4RlzseRy
         a4CvLqVJQNfY+Kt6DjD2wOeZxGMYv0Z7l4GbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fHNaf21+ty041MRvpbYDXKEhiexp6vn+weXebmL+fpc=;
        b=lATQdoAqYSE4tcJ1xA6lF3ihGc7G+s6jXRUCFMvSneajHpZmpQ6AlvE/3r0o+dc/7I
         UXUOTXBOORIYQ7ifcWkSicFuvo/PRp+3giAuhYt02uyk8BAann25aHJ25cE4UfsNLZlR
         mTMzAneVCcAgSih8gwydcOhRTiQIhLwP2H5VIjiCv6Xu6ahHKLQVj07OJshC1Oty61Rd
         jUhhMmZWdIt6n/hRI/BTh6jlII4fd/XCKyaznqfpExQMyD0LBCkLgwhURnzhLHpx0y91
         aNDF+pTVsFIm3l934VvS1wiIAjBUEAt+yQWf7mfT73vrxZnMasMRWQxuO9ESJwYI1ojn
         TjpQ==
X-Gm-Message-State: AOUpUlEZwzoMynLhVobsuFwKFI2YecDs/vYMk1/0bGyG8rkTCMcDGbGx
        hwbMYBN2j2MRzsFn4kgJ5eMZAb/tI9D0pGbvPpHjfw==
X-Google-Smtp-Source: AA+uWPyaWllP7JbCn5zvEgMtBgy5IaMuGoNbZuLEZC7ZkipYdDIS6sllulZy/UmvSOt9Xe/QLTHHqe+u/sOI0GTl3g4=
X-Received: by 2002:aca:bdc4:: with SMTP id n187-v6mr612001oif.3.1533686448839;
 Tue, 07 Aug 2018 17:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180804082702.434482435@linuxfoundation.org> <CA+G9fYsZtw-OHh2cKC0VG5zwdKOMvnOx-cAVfp2qfY_drFQ4_Q@mail.gmail.com>
 <20180805134952.GA15972@kroah.com> <20180805151933.efzi3mawp22p3wex@linode.therub.org>
 <20180806153508.GB20862@kroah.com>
In-Reply-To: <20180806153508.GB20862@kroah.com>
From:   Anmar Oueja <anmar.oueja@linaro.org>
Date:   Tue, 7 Aug 2018 20:00:20 -0400
Message-ID: <CAJoje1ws6UDXhMBa9N-LcxvVqUv3HjB+DJxzoz4kac1Nr-3Ueg@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/124] 4.4.146-stable review
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Rue <dan.rue@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 11:35 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Aug 05, 2018 at 03:19:33PM +0000, Dan Rue wrote:
> > On Sun, Aug 05, 2018 at 03:49:52PM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Aug 05, 2018 at 05:24:21PM +0530, Naresh Kamboju wrote:
> > > > On 4 August 2018 at 14:29, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > This is the start of the stable review cycle for the 4.4.146 rele=
ase.
> > > > > There are 124 patches in this series, all will be posted as a res=
ponse
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Mon Aug  6 08:26:39 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > > The whole patch series can be found in one patch at:
> > > > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-revie=
w/patch-4.4.146-rc1.gz
> > > > > or in the git tree and branch at:
> > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable-rc.git linux-4.4.y
> > > > > and the diffstat can be found below.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > Results from Linaro=E2=80=99s test farm.
> > > > No regressions on arm64, arm and x86_64.
> > >
> > > Really?  How did you all miss the netfilter bug that was introduced b=
y
> > > this series?
> > >
> > > Anyway, thanks for testing, but I'm worried...
> >
> > I took a look through our test suites to see where we may have coverage=
 for
> > this. There is a netns series of tests in LTP [1], but we've had troubl=
e
> > getting them running successfully in the past and so they are being ski=
pped. I
> > don't know if it would have caught this particular issue, but I'll find=
 out,
> > and also see if we can get them working and running again.
> >
> > We also run the net/ tests in kselftest, but there aren't that many, an=
d of
> > course running kselftest the way we do is not a well supported usecase =
(running
> > all of 4.17 kselftest against 4.4 kernels, skipping tests that are brok=
en).
> >
> > So I would ask, how would net/ expect such things to be tested, and wha=
t can we
> > do to help?
>
> I don't know.  Somehow this was caught when running Android's userspace,
> which seems to be a great stress test for networking.  What about
> running the Android networking tests on kernels?  Those don't need to be
> run on an android system to work properly last I checked.

They [1] are definitely on our radar of tests to integrate into LKFT.

[1] - https://source.android.com/devices/architecture/kernel/network_tests

Cheers!
anmar
