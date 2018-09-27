Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF59EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A71C2172A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A71C2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeI1BVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:21:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1BVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:21:02 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F08D1018;
        Thu, 27 Sep 2018 19:01:19 +0000 (UTC)
Date:   Thu, 27 Sep 2018 21:01:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/88] 4.18.11-stable review
Message-ID: <20180927190117.GB1895@kroah.com>
References: <20180927090300.631426620@linuxfoundation.org>
 <5bacd49d.1c69fb81.12c01.3b57@mx.google.com>
 <7hwor72aeq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hwor72aeq.fsf@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 06:05:33PM +0200, Kevin Hilman wrote:
> kernelci.org bot <bot@kernelci.org> writes:
> 
> > stable-rc/linux-4.18.y boot: 179 boots: 16 failed, 144 passed with 17 offline, 2 untried/unknown (v4.18.10-89-gd5a4d8752d2e)
> >
> > Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.18.y/kernel/v4.18.10-89-gd5a4d8752d2e/
> > Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.18.y/kernel/v4.18.10-89-gd5a4d8752d2e/
> >
> > Tree: stable-rc
> > Branch: linux-4.18.y
> > Git Describe: v4.18.10-89-gd5a4d8752d2e
> > Git Commit: d5a4d8752d2e5b7f703fb43749db3c28bf7e104e
> > Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > Tested: 64 unique boards, 25 SoC families, 20 builds out of 199
> >
> > Boot Regressions Detected:
> >
> > arm:
> >
> >     bcm2835_defconfig:
> >         bcm2837-rpi-3-b:
> >             lab-baylibre: new failure (last pass: v4.18.10)
> >
> >     imx_v6_v7_defconfig:
> >         imx6dl-wandboard_dual:
> >             lab-baylibre-seattle: new failure (last pass: v4.18.10)
> >         imx6dl-wandboard_solo:
> >             lab-baylibre-seattle: new failure (last pass: v4.18.10)
> >         imx6q-wandboard:
> >             lab-baylibre-seattle: new failure (last pass: v4.18.10)
> >
> >     multi_v7_defconfig:
> >         tegra124-jetson-tk1:
> >             lab-collabora: new failure (last pass: v4.18.10)
> >             lab-mhart: new failure (last pass: v4.18.10)
> >         tegra20-iris-512:
> >             lab-baylibre-seattle: new failure (last pass: v4.18.10)
> >         tegra30-beaver:
> >             lab-baylibre-seattle: new failure (last pass: v4.18.10)
> 
> FYI... I bisected the tegra ones down to the drm atomic debugfs problem
> that was already reported and reverted from stable.

I have only reverted it right now, so you were fast!  :)

greg k-h
