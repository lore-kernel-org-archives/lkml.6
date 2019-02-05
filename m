Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F98C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7D52083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwfMNv/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfBETYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:24:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46973 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfBETYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:24:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so1915852pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0IpBC4OloPlMLmUVkvUYfF8AnMCmz/A1YcJcCSC31cA=;
        b=kwfMNv/G/JGCA2aAGP/lKCLGziS7+iyMxXgbHWYnfOnKG7DfHlVMyRXp8TKmMgs5rn
         41vHiQ6QydH/yRbWd+Aq4w0fQpeugdrv6llBv3SSTXW1ajA+VB4s7nqrv/f03C/Zpgx5
         ZAmZa6hlowBe+Gl1RMGKMrfVxyNksXos4tq8KrxQQp/EV2/9dVXaqvCrfkGWL+CC98I5
         EKaxQ6F+87lAlPSqnuAVm9mVjpiPne2YL3bSd9uV+Y3NMq9V3rRUNtOkK/ZJQojRhGl/
         SG6ObbutF6r1ivexqaB1/xyb1VYY+x04K4UwnrrW58TV8DlUk+I7LTABwJWmbACZgMg/
         WFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0IpBC4OloPlMLmUVkvUYfF8AnMCmz/A1YcJcCSC31cA=;
        b=iVlQ/sjrrr1Hpl91yM5KSnUZGK2C2O+4bREtoL4DyHIPYerPADwY1xq2cn8SE4FGhx
         sE8NZt6UlricxAwzXNTg5PPZdKOxPXF8riTKFIKed5wFfl1pWOrdGzW8O+RUTupiqbzD
         zCmnGnhGVp5D1O6hqSxeqsRnaWBsoBmoaYvrPMYP6rRtv0thABZ4Hurb4hyZD/qlMqaL
         AXfQ747oihFmoS9ZwD8HNcVQOwOtQ/c4c+y3DKUY2MVpekVAG0boZXb1GksSvS/7OZ7w
         6Le4xVelIOokAaYF5z4zCVyuZuCRiUSuuQsRLkxem6ZmL7qbkunF83ANZ6xgjinVB0eU
         Nlyw==
X-Gm-Message-State: AHQUAuYc7ITekUFtbpwybHE+sukbsCGKsr+LBUC9wgloxEbDODezVcb4
        GTUnADlqjGDgdXtk7QH8+FQ/ng==
X-Google-Smtp-Source: AHgI3IYBIFeXO4IjapHd9eSoVRE5BNWG2bXKQ6dEz3Nf0WFzp3jYwOJio9Nr6P3C93299yNBhPap4w==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr6765446plb.104.1549394655485;
        Tue, 05 Feb 2019 11:24:15 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z1sm5401719pfi.155.2019.02.05.11.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 11:24:14 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:24:12 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Koen Kooi <koen.kooi@linaro.org>
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: apq8016-sbc: Standardize LED
 labels
Message-ID: <20190205192412.GG31919@minitux>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-8-manivannan.sadhasivam@linaro.org>
 <20181221023554.GB3233@Mani-XPS-13-9360>
 <CAP71WjzWiCg-NXDnh58N-5O7kvNj+DDndSK04DeoPxFE2L8W0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP71WjzWiCg-NXDnh58N-5O7kvNj+DDndSK04DeoPxFE2L8W0g@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Feb 11:00 PST 2019, Nicolas Dechesne wrote:

> Hey Mani,
> 
> thanks for sending this out, it should have been just like that in the
> first place ;)
> 

Thanks Nico for the confirmation, I will queue this for v5.2

Regards,
Bjorn

> On Fri, Dec 21, 2018 at 3:36 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Oct 29, 2018 at 03:12:45PM +0530, Manivannan Sadhasivam wrote:
> > > For all 96Boards, the following standard is used for onboard LEDs.
> > >
> > > green:user1  default-trigger: heartbeat
> > > green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> > > green:user3  default-trigger: mmc1 (SD-card)
> > > green:user4  default-trigger: none, panic-indicator
> > > yellow:wlan  default-trigger: phy0tx
> > > blue:bt      default-trigger: hci0-power
> > >
> > > So lets adopt the same for APQ8016 SBC (Dragonboard410c), which is
> > > one of the 96Boards CE platform.
> > >
> >
> > Hello,
> >
> > Any update on this patch?
> 
> Reviewed-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> 
> >
> > Regards,
> > Mani
> >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > > index 46feedf7c989..35f95154316b 100644
> > > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > > @@ -300,28 +300,28 @@
> > >                       compatible = "gpio-leds";
> > >
> > >                       led@1 {
> > > -                             label = "apq8016-sbc:green:user1";
> > > +                             label = "green:user1";
> > >                               gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "heartbeat";
> > >                               default-state = "off";
> > >                       };
> > >
> > >                       led@2 {
> > > -                             label = "apq8016-sbc:green:user2";
> > > +                             label = "green:user2";
> > >                               gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "mmc0";
> > >                               default-state = "off";
> > >                       };
> > >
> > >                       led@3 {
> > > -                             label = "apq8016-sbc:green:user3";
> > > +                             label = "green:user3";
> > >                               gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "mmc1";
> > >                               default-state = "off";
> > >                       };
> > >
> > >                       led@4 {
> > > -                             label = "apq8016-sbc:green:user4";
> > > +                             label = "green:user4";
> > >                               gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "none";
> > >                               panic-indicator;
> > > @@ -329,14 +329,14 @@
> > >                       };
> > >
> > >                       led@5 {
> > > -                             label = "apq8016-sbc:yellow:wlan";
> > > +                             label = "yellow:wlan";
> > >                               gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "phy0tx";
> > >                               default-state = "off";
> > >                       };
> > >
> > >                       led@6 {
> > > -                             label = "apq8016-sbc:blue:bt";
> > > +                             label = "blue:bt";
> > >                               gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "bluetooth-power";
> > >                               default-state = "off";
> > > --
> > > 2.17.1
> > >
