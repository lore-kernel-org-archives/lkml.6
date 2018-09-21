Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90026C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3199021547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tjader-xyz.20150623.gappssmtp.com header.i=@tjader-xyz.20150623.gappssmtp.com header.b="Th5WjcUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3199021547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbeIUVP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:15:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46682 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389683AbeIUVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:15:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id q4-v6so249302otf.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-xyz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+fPhgogniaCIWWuzOGnVgoRs6QOAOjleuXpoEvKUbVM=;
        b=Th5WjcUOeG5x1k3mVGN06eo7kTlHGHsr5S7PVtZrLM2+idkeyaX9Gl7hDAGQCGFK5k
         pYxliG2vwMfW0fnjIEAVcbydU+0f8bWPyE3/77CMTLEkx3ac8dHgf9KMP3G5au6DhsIy
         ayvum0mH3OO5hbFzSJZUEBM5lQJTJmbBbm94R6b+cB4lXvL4gjdQAlhYoRSaDGjy8q5L
         VEFRrfvTWxpa1a60KcxTFlUps+/FBZl7h8RAiJfZpLuNqOEb97cMrju9OC2K5FdP9wGr
         GUsunVA8o4i1FSEznURZjhi67UU61D9fVP7gFcvjVOh+1Nh1nr8ODrwzzN773PdKbuL1
         84yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+fPhgogniaCIWWuzOGnVgoRs6QOAOjleuXpoEvKUbVM=;
        b=THuI2UtUqg8q/MYmPNTJTjbLaeGRoELDGt+I0dp4Oi/rbyHcavPsdf0oTXziWMWlmR
         yRHUXaAgixZnTmVG5J+LKKHoJC6HJpC1DGdQbqGEMoIyhiA9NYvoHA7YS5OKjKJwsrsa
         TOWAgGqa2NlQq9ZJWO4OW8Yv/p4Sh3ylJoafGukPDV0U0dT9Avo2StJ0yagU/64dnby0
         Xuck8QL4fl8kZpxr5LRgaee0YzfoxsrlId2zjHY3lIp82Ks/js21pok6MYBjcMIaAs5e
         doFNugFtu0gvIhuCrB0smabISJolZ1znDyaR5NW29ma1XuRL5iVj3nDNn3T2jVRJqwwr
         Uywg==
X-Gm-Message-State: APzg51DwCSdxE6NYHZTyE5blDj+yV57X/Dq5rW2dd1mzJGZDTnuXcYZk
        GYrNNrc3kYgeOYfm6Ag1cAtqfOcVC7YfP27G5NkNFA==
X-Google-Smtp-Source: ANB0VdZjI+QboF357+lS/j4GxD/owlYulS0Raak0iE0VqhWTiKty9ev6HpK1OhtW2wNHU4leFpyjAQTm/HDxookiGrw=
X-Received: by 2002:a9d:4a14:: with SMTP id h20-v6mr24338840otf.259.1537543565288;
 Fri, 21 Sep 2018 08:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180919141938.18791-1-rodrigo@tjader.xyz> <20180921142941.5ymp7ksphgboxrwz@flea>
In-Reply-To: <20180921142941.5ymp7ksphgboxrwz@flea>
From:   =?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Date:   Fri, 21 Sep 2018 12:25:53 -0300
Message-ID: <CAG7TQgFOuHHmkm-6CDDYJ6KuDqfjNvFjnt8_9BPYfdP=oV57VQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: Olimex A64-OLinuXino: fix ethernet
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

On Fri, Sep 21, 2018 at 11:30 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Wed, Sep 19, 2018 at 11:19:36AM -0300, Rodrigo Exterck=C3=B6tter Tj=C3=
=A4der wrote:
> > Without "allwinner,tx-delay-ps =3D <600>;" on the DTP it can receive pa=
ckets
> > but not send.
> >
> > Signed-off-by: Rodrigo Exterck=C3=B6tter Tj=C3=A4der <rodrigo@tjader.xy=
z>
>
> Again, that commit log would be nice if it was a bit more
> explicit. What is a DTP? How did you come up with that value? What is
> the value used by Allwinner/Olimex, and why did you use another one if
> you did?

Thanks for the feedback.

DTP is a typo, it should have been DT for "device tree".

Olimex's provided device tree uses a different driver for ethernet,
but it has a property named "tx-delay" with value 6 and the range of
the property is 0-7. On dwmac-sun8i's bindings documentation it says
allwinner,tx-delay-ps has a range of 0-700 and must be a multiple of
100, so I tried 600 and it works.

I'm not sure how much of that I should include in the commit log,
perhaps something like this:

---
arm64: dts: allwinner: OLinuXino: PHY TX clock delay

The PHY requres a delay on the TX clock, otherwise it is not able to send
any packets on the interface.

Olimex's device tree uses 6 in a range of 0-7, dwmac-sun8i requires a
multiple of 100 in the range 0-700.


Signed-off-by: Rodrigo Exterck=C3=B6tter Tj=C3=A4der <rodrigo@tjader.xyz>
