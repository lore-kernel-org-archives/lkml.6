Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90872C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B346216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tjader-xyz.20150623.gappssmtp.com header.i=@tjader-xyz.20150623.gappssmtp.com header.b="gsX0NCP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B346216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeI0VIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:08:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35832 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI0VIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:08:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id m11-v6so2412987oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-xyz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J56I+n24WqfHZ/b7Qx3EVxvVlwOeebrJQeabBTitkpE=;
        b=gsX0NCP++T4yJboQqhEA1eYftwZqQinLdyygd79OmtKodftLHKlhatCwvCkRT7ujxe
         DLwhgNT4F4gbFuU4XuD14S5Oh4wQulI+b/KuFXyH+fxZghTx+4bZ83VUiol8CvckmF8b
         bP1dUrpRMIR0FPvDW+DsWSIcxYny3fg8uEDldAaF9MEUVuBwDi1WO0/rqdGhLtIH/N0S
         cNylD/n5Guzf27UM4ibh5KrM4EuKnBizICK3DL7IgZRQBMHd05KIty6OlYtXTR33+F+c
         OtGzOw9E4CKc5K4xRxa9ZzZydYFyyziAd5Q8eJdBuPMUGQ/QVPtmAQ5G/f22Jc45eqAA
         Uehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J56I+n24WqfHZ/b7Qx3EVxvVlwOeebrJQeabBTitkpE=;
        b=ekef11Ic0xzr9OHF4rNv9Zlg8Dx3p0cN46lqBV+h+Snp8ZdikIK5sA+ur6JB8rg9EG
         p8sESz//N7GWoCGc68pbCkANsiSeKjCS+ugeBZNyiFx3nXzKpPM+yQvwBb7XXFElN+BS
         TxeEdBwxG6VwoRGcw/1dZMB173hdvKenfYFmHbFEoBefgo8/oT81G4HmWt+PyPU6MEA1
         BpU6MZJyxaO19aRqupqef56BLnEZXKVRAre1vF5QDeem9k6p+wHtrfySZE/6qB14HGkF
         MG5bdCpRKFuqp3nZmNKma0NbgMVVF2yuYmk+dLIFSo3n8SFPMecbQFRFbaXpkbg2M11A
         bp3A==
X-Gm-Message-State: ABuFfohWeWXCY4Lyd/vuN0kMpZ1aUakYDkERKkhqnOoRkpnF83NpmV2D
        f2yZpMB7h2IdfN072MZFboglhkxN8o5vfq+ZUi9h/4mpr+H7kA==
X-Google-Smtp-Source: ACcGV60MfmCYVr6Rzcxn3wtbpGHXtyyrEMSr/iuhafFyPIAUJzg1WRHnwSadUvI5TTMVN24R2oHb7cQPAIj2OvqZ/eY=
X-Received: by 2002:aca:e38e:: with SMTP id a136-v6mr1312694oih.16.1538059772896;
 Thu, 27 Sep 2018 07:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180919141815.18737-1-rodrigo@tjader.xyz> <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea> <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea>
In-Reply-To: <20180927081711.llmwnvpu73loe5iv@flea>
From:   =?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Date:   Thu, 27 Sep 2018 11:49:20 -0300
Message-ID: <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable eMMC.
To:     maxime.ripard@bootlin.com
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
>
> On Tue, Sep 25, 2018 at 02:47:59PM -0300, Rodrigo Exterck=C3=B6tter Tj=C3=
=A4der wrote:
> > On Tue, Sep 25, 2018 at 6:01 AM Maxime Ripard <maxime.ripard@bootlin.co=
m> wrote:
> > > We can't really do that, unfortunately. If the device tree name was t=
o
> > > change for a given board, we'd break all the build systems, boot
> > > scripts and distros out there.
> >
> > What if we keep the device tree for the version without WiFi and eMMC
> > with the current name and create new device trees for the other two
> > versions?
>
> Wifi and Bluetooth should be dealt with with overlays in this case,
> and since the eMMC is already enabled, then there's nothing to do, I
> guess.

It's WiFi that is already enabled, not eMMC. Only one of the three
variants has WiFi.

We can't even remove a node from a device tree? Removing the WiFi node
from the current tree would make it correspond to the variant with the
least features.

About device tree overlays, I read overlay-notes.txt, but I went
looking for an example with "git grep /plugin/ arch" and it came
empty. Is this approach not used for other boards?

Does the overlay approach make the device available at boot time? That
is important for a storage device such as eMMC.

I went with the separate dts approach because that's what I saw was
done for other similar cases, like Pine64 and Pine64+, OLinuXino-LIME2
and its variant with eMMC, among others.
