Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1DDC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2BA20685
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tjader-xyz.20150623.gappssmtp.com header.i=@tjader-xyz.20150623.gappssmtp.com header.b="PT9NU4VY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2BA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeI2XUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:20:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38831 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeI2XUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:20:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id h15-v6so9029712otj.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-xyz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+UBRHgLvJvCwy4ezEVbG0uixZDmG2B8qZby+MyVKkoI=;
        b=PT9NU4VYQ0t+lA9fLwSgudCfXIQn02OCXOOHR/ApTi0jnUskqJmTWwCwFFjdmt0Ep6
         B5hoJ/LooRAGn2I7bEveTsVMp6eHbTdGNeFlQs7SFl8F8UvNwC7f1NnE2Ugdh3RC0qM3
         innPAm4NhiLSPu/2ewgImqXcOtF8Vnrbk8GBb6moyKkXOsI01tRTjPgzG9DkVzBmWRyK
         A5p6OyQZh+liN6ZUhHNwumr/dEtfa0yr2aOI3GZAA4qyimqJbp0aBOQadsUo16XiWS0k
         poXqEzwia5wts4EDYYNP+kC+Ux5xXPs/cR2TEf/kV4GmAExciLGrZLIwLtl7knowYPFC
         ePTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+UBRHgLvJvCwy4ezEVbG0uixZDmG2B8qZby+MyVKkoI=;
        b=eyZTrMsoz6K35l6cqc93w7RHT+Mjpq6eS0ar8bWB843hO+Sdl4phm1qOYF+CFJTJa9
         zAMW6U9PNYm7iQx1p9E/HfAKLd6/jMtecjrgRe+U5a+3r1l1g/yjWXAmrE98qq0WWje/
         Az44WN4DsZd3UwZ3Dh5OlzUdAVrOouQBhQraGoUpvfyYkYGieHel7K76/Adq+cfoZlnE
         MfEKssfzO7wIfa/NQX0hrIIV82ln96+6gmDpb6MXNgqgedKP/Smu7VJMjk4TuAjfg5hR
         AvyQUqGNJgFa9MgjGt2erlWhEEclRCdtXKkxEyBm0tPhJK4kadN3Ry+OZm5M8foKTUIy
         1ucg==
X-Gm-Message-State: ABuFfoj9zu52Wr9gf+msSTyK1PzlRJMinp+61oETXtl1infk7fWdpwdc
        7dSx93uEMkxq0MmuEb4BkW3rRkI9E36nlbAC1ju2Qw==
X-Google-Smtp-Source: ACcGV61VUWQFTO+EZUXcQfY5nkRcUDm9PonrpJUe/C3q+aNeTutieCRmT3l/JWRxqYjhasjsDL1tMENP7HtfkKF2PmU=
X-Received: by 2002:a9d:508e:: with SMTP id b14-v6mr2040086oth.218.1538239873765;
 Sat, 29 Sep 2018 09:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180919141815.18737-1-rodrigo@tjader.xyz> <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea> <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea> <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
 <20180929154754.abz3byvrufvnf4dq@flea>
In-Reply-To: <20180929154754.abz3byvrufvnf4dq@flea>
From:   =?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Date:   Sat, 29 Sep 2018 13:51:02 -0300
Message-ID: <CAG7TQgGS7DkLpNVYqfCD-9vMZkeY6r+L-5oXKWef3x-OVbqjtw@mail.gmail.com>
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

On Sat, Sep 29, 2018 at 12:47 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Thu, Sep 27, 2018 at 11:49:20AM -0300, Rodrigo Exterck=C3=B6tter Tj=C3=
=A4der wrote:
> > On Thu, Sep 27, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.co=
m> wrote:
> > >
> > > On Tue, Sep 25, 2018 at 02:47:59PM -0300, Rodrigo Exterck=C3=B6tter T=
j=C3=A4der wrote:
> > > > On Tue, Sep 25, 2018 at 6:01 AM Maxime Ripard <maxime.ripard@bootli=
n.com> wrote:
> > > > > We can't really do that, unfortunately. If the device tree name w=
as to
> > > > > change for a given board, we'd break all the build systems, boot
> > > > > scripts and distros out there.
> > > >
> > > > What if we keep the device tree for the version without WiFi and eM=
MC
> > > > with the current name and create new device trees for the other two
> > > > versions?
> > >
> > > Wifi and Bluetooth should be dealt with with overlays in this case,
> > > and since the eMMC is already enabled, then there's nothing to do, I
> > > guess.
> >
> > It's WiFi that is already enabled, not eMMC. Only one of the three
> > variants has WiFi.
>
> Ah, right, sorry. In the board that doesn't have an emmc, are the pins
> usable for something else?

I don't have the variant without eMMC nor could I find pictures of it.
The schematics do mention that the A64 pins could be used to control
NAND flash, but you'd have to solder that yourself.

> > We can't even remove a node from a device tree? Removing the WiFi node
> > from the current tree would make it correspond to the variant with the
> > least features.
>
> Not really. How pissed would you be if you were a user, had wifi
> running on your board, you upgrade your kernel, and then it's just
> gone? :)

That would suck, but what about someone who has the board with no wifi
and problems start happening because the wifi is enabled on the device
tree?

> > About device tree overlays, I read overlay-notes.txt, but I went
> > looking for an example with "git grep /plugin/ arch" and it came
> > empty. Is this approach not used for other boards?
>
> It is, it's simply not stored in the kernel, but through other third
> party repos.

So that would mean that it's up to every distro to support the boards
instead of relying on mainline support?

> > Does the overlay approach make the device available at boot time? That
> > is important for a storage device such as eMMC.
> >
> > I went with the separate dts approach because that's what I saw was
> > done for other similar cases, like Pine64 and Pine64+, OLinuXino-LIME2
> > and its variant with eMMC, among others.
>
> Yeah, but in all these cases, it was done from day one, not after the
> facts.

For the LIME2 the dts for the emmc variant was commited two years
after the base LIME2 dts.


What if instead of keeping the current dt for the least featureful
model we keep it for the most featureful model and create new dts for
the two less featureful models?
