Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B08DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37EC208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37EC208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbeFRDNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:13:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:56879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754527AbeFRDNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:13:14 -0400
Received: from homer.simpson.net ([185.221.148.163]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDR21-1fRAeC1cFB-00GrpX; Mon, 18
 Jun 2018 05:13:05 +0200
Message-ID: <1529291584.7059.0.camel@gmx.de>
Subject: Re: v4.14.21+: ATOMIC_SLEEP splat bisected to 9428088c90b6
 ("drm/qxl: reapply cursor after resetting primary")
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Airlie <airlied@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Ray Strode <rstrode@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Date:   Mon, 18 Jun 2018 05:13:04 +0200
In-Reply-To: <CAPM=9tzkKWM2wjeQvWG2qKM-xgFwGD3bjWfgmDUDTQO+tXF-ig@mail.gmail.com>
References: <1529163551.16103.16.camel@gmx.de>
         <20180617093607.GA27652@kroah.com> <1529231886.5303.6.camel@gmx.de>
         <20180617110200.GA19216@kroah.com>
         <CAPM=9tzkKWM2wjeQvWG2qKM-xgFwGD3bjWfgmDUDTQO+tXF-ig@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6DGyglvA118x0b8mLubzVawmY0fKtSw0r3rx8LTZ295zkKgqLpI
 iXF3qR6Sh1LUQNtE7dcLGefcZKZ1RMzkSoMwWFHwluuKTTGS0TIC2Lc5jV28/PH2uZ1ovRi
 kVtq97AwqUulkpbHs/xeW2bhSw/Gyn+zbsU9pEcI9uLObcM+HU1csHEzcBUZ5rrxdtQBevd
 j/ajrojK9APN5sZ8wAlJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bVcu6BQ6Xe4=:eo2xjMUWeNwW1cGQ97q5UU
 xQswkNh1QvFxQutkKchsDqQpXL7FVC3FIYzva0HlvmTrjcwnnYb6cFj56l+tOG2TKEwYWIBM2
 UTF0Ezh+SN4dgQHp5radxVo7xpwuv1eOTK9HqML57MRiQdi2uYk/1Ejea5PSNFN44IAzfirUx
 dmSIKI91/+TL9PRtlKplFZh5XX1XZ/O8EyPxTYC5vt8wxDkpg1KRQzCNoR75U9Qq86DmSwc1T
 DDqJmhbSad3UW36af2wCCLjzOrVHeaI8IHL9Y2BeziZgxiDXRQYyhAUZ736ujjg6d2kBAUdH/
 1ml4x2F/hnHxMwEnUuxfdsIot8HI/lpJXB+cL4ek4VJXg8ZnG3TNathheomtSM6l4syPHUX/q
 MJHtcOFi4aBbEZDbhXRWbCgHK+PBKdhZ66+5154WPAK7BRfJscU4bCHHojKsoqoECaiSP67+a
 kW5ikvc9sPLWG7Pe4j1h3zlmfr2CN4mFhylNkyB7VLcPMMgVcVLNhY4Ph4bTR0kdZ2IUdBnaq
 BGP0ZOcZvguejm0r9AWUeOCInd73+fNn00JSw6sFStGzuYIMlrEIFZg8xccH+Ba7ZDXwx0AAg
 On6CCBh3EIpEmQkmTpWA4Ddo1J86FRzLKOuo2lZP5zbanorndgWcp/XcYaq9uWSgNH1t+QgRz
 q3hSho8cyt7/6u874SoxIAtHLfElj0VvgbEyimvQrlOa6TkeTLbcwM9N7j2AU+vTgM1Ya79Tp
 dI8oXEQEnK/IVsbhVcAuOMhfQDwRav5TkH6etijjBHBRgCSfWKG1N9QnN7PMIOIJtw0CHR6O5
 5Lme1Xb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 12:33 +1000, Dave Airlie wrote:
> On 17 June 2018 at 21:02, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Sun, Jun 17, 2018 at 12:38:06PM +0200, Mike Galbraith wrote:
> >> On Sun, 2018-06-17 at 11:36 +0200, Greg KH wrote:
> >> >
> >> > And if you revert that patch, does everything work again?
> >>
> >> Yes.
> >
> > Great, Dave, care to revert this in 4.18 so I can queue up that revert
> > in older kernels as well?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi MIke,
> 
> Does
> https://patchwork.freedesktop.org/patch/229980/
> 
> fix it?

Yup.

	-Mike
