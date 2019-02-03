Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE0C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3C9217D9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UibxsBE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfBCM2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:28:50 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45655 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfBCM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:28:49 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so12664029qtr.12;
        Sun, 03 Feb 2019 04:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=aO9CPDDnza6sqQF9pY9OywcZkuugy77QVzMi4KpIbc4=;
        b=UibxsBE7ROHeYDxx+1SNLVA8OuoGOH5tiDB12AToLgf3Nz/fe7gPF050IFDdItfgzP
         Xsuom+PirTYEXzBQdCborriDHGDqdd4sIjPZpLcGfsusc7aJLc1kxZyFYzRNm8xYhgAY
         gA4To2sd7JCSnGKeKO5+1Sj1VFDRaxSabN79Ol1gc6BJSRip8Fluh2S1iRodwEBqiRje
         PA2rVD2AxijT5ASYCLHDQSzyg06mSnnIBMktCvV8jQwEsq5AyVnqNJdun/CMcsFZSBKr
         4HuJjJHyR8+Q0kl5FLH7+gle9pR2aHIv5IYJb7DawEPHvgqn/jCmbFgncmSqb7J1Csi+
         H3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=aO9CPDDnza6sqQF9pY9OywcZkuugy77QVzMi4KpIbc4=;
        b=XaBXmvGocnfZkjYbofmJLZMIJR73EVWfwqmikGeufOeSUyiAJYSse8oGZRkxSbo+7K
         Fr6C/297xJ8R0zDanDog6rkf/aIPRrJMLs+uoCFkrZsDRFKZ31E/G3mIiQMXG2DsQDRf
         NIYLSa3qcCvqGCbGGDAUUvERcAbWh+C+1gT8U5tLoaK/XW1IWDFFNvPgKHiwZAjN5EIo
         NgY/cT6/TGPsdq2zMXjnsDmX0zi6ZiZYIcfPVM1Ca0KmhEtoKCdhyiHCS4EiXsX3oJzc
         PxVZnCrP9MPUtBOzRxbxQM+kiwVzfLE89sR/coMbCXjONPCdS2rm4/WnNd2fCWnPrf5n
         AHKA==
X-Gm-Message-State: AJcUukfhB4+/oz0B8XadVHbmtWhntaaRCSHXDnQbrhfaOjdh8uAYINHH
        JBCKvtCduzl9ngmGa0z9/MhXdADWWJTV4OfwfQY=
X-Google-Smtp-Source: ALg8bN7MzNhvcsq6XXzV19qjB/F1X0aFrhkWGjxs5r08WDp0Dgh7UzKJH+bainfQlWiiWG5pZPyhMdW2gzOS2+Tg2oI=
X-Received: by 2002:aed:2803:: with SMTP id r3mr45150121qtd.316.1549196928523;
 Sun, 03 Feb 2019 04:28:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190201164720eucas1p1ae770f7981fa09016b69ca7265e820c7@eucas1p1.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com> <1549039612-28905-6-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1549039612-28905-6-git-send-email-l.luba@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 3 Feb 2019 21:28:10 +0900
Message-ID: <CAGTfZH3Uh1yh8c_4v=PW_NAcTi58p1h40VDiBuQoMPQm3X9Z_w@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] dt-bindings: devfreq: add Exynos5422 DMC device description
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

2019=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 2:45, Lu=
kasz Luba <l.luba@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> The patch adds description for DT binding for a new Exynos5422 Dynamic
> Memory Controller device.
> It also contains needed MAINTAINERS file update.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 106 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-=
dmc.txt
>
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt=
 b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
> new file mode 100644
> index 0000000..229efba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
> @@ -0,0 +1,106 @@
> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller=
 device
> +
> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which =
the DRAM
> +memory chips are connected. The driver is to monitor the controller in r=
untime
> +and switch frequency and voltage. To monitor the usage of the controller=
 in
> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit)=
, which
> +is able to measure the current load of the memory.
> +When 'userspace' governor is used for the driver, an application is able=
 to
> +switch the DMC frequency.
> +
> +Required properties for DMC device for Exynos5422:
> +- compatible: Should be "samsung,exynos5422-bus".

The compatible name is wrong.
- exynos5422-bus -> exynos5422-dmc

> +- clock-names : the name of clock used by the bus, "bus".

'bus' is right?

> +- clocks : phandles for clock specified in "clock-names" property.
> +- devfreq-events : phandles for PPMU devices connected to this DMC.

The dt-binging file doesn't contain the any description for 'reg' propertie=
s.

> +
> +The example definition of a DMC and PPMU devices declared in DT is shown=
 below:
> +
> +       ppmu_dmc0_0: ppmu@10d00000 {
> +               compatible =3D "samsung,exynos-ppmu";
> +               reg =3D <0x10d00000 0x2000>;
> +               clocks =3D <&clock CLK_PCLK_PPMU_DREX0_0>;
> +               clock-names =3D "ppmu";
> +               status =3D "okay";
> +               events {
> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +                               event-name =3D "ppmu-event3-dmc0_0";
> +                       };
> +               };
> +       };
> +
> +
> +       ppmu_dmc0_1: ppmu@10d10000 {
> +               compatible =3D "samsung,exynos-ppmu";
> +               reg =3D <0x10d10000 0x2000>;
> +               clocks =3D <&clock CLK_PCLK_PPMU_DREX0_1>;
> +               clock-names =3D "ppmu";
> +               status =3D "okay";
> +               events {
> +                       ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> +                               event-name =3D "ppmu-event3-dmc0_1";
> +                       };
> +               };
> +       };
> +
> +       ppmu_dmc1_0: ppmu@10d10000 {
> +               compatible =3D "samsung,exynos-ppmu";
> +               reg =3D <0x10d60000 0x2000>;
> +               clocks =3D <&clock CLK_PCLK_PPMU_DREX1_0>;
> +               clock-names =3D "ppmu";
> +               status =3D "okay";
> +               events {
> +                       ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> +                               event-name =3D "ppmu-event3-dmc1_0";
> +                       };
> +               };
> +       };
> +
> +       ppmu_dmc1_1: ppmu@10d70000 {
> +               compatible =3D "samsung,exynos-ppmu";
> +               reg =3D <0x10d70000 0x2000>;
> +               clocks =3D <&clock CLK_PCLK_PPMU_DREX1_1>;
> +               clock-names =3D "ppmu";
> +               status =3D "okay";
> +               events {
> +                       ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> +                               event-name =3D "ppmu-event3-dmc1_1";
> +                       };
> +               };
> +       };
> +
> +       dmc: memory-controller@10c20000 {
> +               compatible =3D "samsung,exynos5422-dmc";
> +               reg =3D <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                       <0x10030000 0x1000>, <0x10000000 0x1000>;
> +               clocks =3D        <&clock CLK_FOUT_SPLL>,
> +                               <&clock CLK_MOUT_SCLK_SPLL>,
> +                               <&clock CLK_FF_DOUT_SPLL2>,
> +                               <&clock CLK_FOUT_BPLL>,
> +                               <&clock CLK_MOUT_BPLL>,
> +                               <&clock CLK_SCLK_BPLL>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                               <&clock CLK_MOUT_MCLK_CDREX>,
> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
> +                               <&clock CLK_CLKM_PHY0>,
> +                               <&clock CLK_CLKM_PHY1>;
> +               clock-names =3D   "fout_spll",
> +                               "mout_sclk_spll",
> +                               "ff_dout_spll2",
> +                               "fout_bpll",
> +                               "mout_bpll",
> +                               "sclk_bpll",
> +                               "mout_mx_mspll_ccore",
> +                               "mout_mx_mspll_ccore_phy",
> +                               "mout_mclk_cdrex",
> +                               "dout_clk2x_phy0",
> +                               "clkm_phy0",
> +                               "clkm_phy1";
> +
> +               status =3D "okay";
> +               devfreq-events =3D <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> +                               <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> +       };
> +
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e81dfbf..ab0d8a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3316,6 +3316,7 @@ L:        linux-pm@vger.kernel.org
>  L:     linux-samsung-soc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/devfreq/exynos5422-dmc.c
> +F:     Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>
>  BUSLOGIC SCSI DRIVER
>  M:     Khalid Aziz <khalid@gonehiking.org>
> --
> 2.7.4
>


--=20
Best Regards,
Chanwoo Choi
