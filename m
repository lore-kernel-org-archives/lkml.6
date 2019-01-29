Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA192087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GjiOcNXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfA2QCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:02:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50664 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfA2QCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:02:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190129160252euoutp01affc9b170a11a7a50538c1cc3630b13b~_XS2ewtrT1958719587euoutp01H
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 16:02:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190129160252euoutp01affc9b170a11a7a50538c1cc3630b13b~_XS2ewtrT1958719587euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548777772;
        bh=DRjEHJKFWYoavZVVURNhjQgbrY289jL767C8PXItlo8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GjiOcNXuZjkgNdjkAIDVRVv5hd939Hh66xgwwq2tMgrexVQz1cjtu6+vqHAIYwKuO
         57LQgqV7DxagVT5l8cIbHJ3zdw6fYwUKR7BzgwM4eX0OODEv4XkA+MqKowUveV/QSt
         f5s8j60JjyV1Og0kD9X9CicolpqqGnY3GW227Wp8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129160251eucas1p11b2a576b3e50f36ad7fd8611cbd1e055~_XS1wlKdu2002920029eucas1p1h;
        Tue, 29 Jan 2019 16:02:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DD.6B.04806.B29705C5; Tue, 29
        Jan 2019 16:02:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190129160250eucas1p2eb448275d6c25f1d2a72f68d06f3763a~_XS0_SCkg1287912879eucas1p2X;
        Tue, 29 Jan 2019 16:02:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190129160250eusmtrp10ebb3444ee7272afa1d53764f8dc1545~_XS0vgENY3028630286eusmtrp1Q;
        Tue, 29 Jan 2019 16:02:50 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-67-5c50792bce98
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.76.04128.A29705C5; Tue, 29
        Jan 2019 16:02:50 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190129160249eusmtip22cb274509439e1e990976d16ef1c7476~_XS0NM2QX1687116871eusmtip2U;
        Tue, 29 Jan 2019 16:02:49 +0000 (GMT)
Subject: Re: [PATCH 4/8] dt-bindings: devfreq: add DMC device description
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, myungjoo.ham@samsung.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <79cd56c4-2415-7db1-be6f-73c03c0902bc@partner.samsung.com>
Date:   Tue, 29 Jan 2019 17:02:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPd2g6rtZpK20emJ0tqHhq0D01=BWbU_9MP30313XHvPHg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj229k5Ow4nx6Pli0nBSOhC3io6dEMhYkGgFVKpUDMPU3RqO96W
        UpaWdy0NL1OaPwxtidPlDVErLw0RZ1K4yh+KGpaXStTMUsvtTPLf8z2X730feEmM7sXdyMiY
        eFYVI4+WEmJhy5tV06GD6sBQ768VNNNYpscZ89I0zmh7TThTODmLMUNDDSJm8N6ciDFMjuDM
        u/ZKglnM70VM2VCXgHlqHhYwo3drCeZ+Z6/ITyKre1KHZAZdNiF7UX1HVtCkQ7JFw+5APFh8
        MpyNjkxkVV6nr4sj+r6sE3HDx5PX6uuJNNThkYPsSaCOQHa+nshBYpKmahEUdfzA+McSgvTC
        9zZlEcG4vlC4FTFmrOK8UINgbjrT5ppHUDKjFVlcztQ56BkxWRMu1H4wr69YExi1jEHu64ZN
        gSQJyhPadDctHgl1FmbTN3ALLaQ8oKY1ykLvoK5AT/43xFucoL98ypq0py7AYrmLhcYoV/g0
        pRXweA+0zldaGwA1IYK1338Rv/QZMH03C3jsDDPGJhGP3WGgOM9WjIPBLB3B41TI7G+zeU5A
        j3HYuhq2WUXf7mWBQPlDV7GYh47wYd6J38ARilpKMZ6WQNYDmv9jHzTlvbXN3wk1dSWih0iq
        2VZLs62LZlsXzf+xVUioQ65sAqdUsNzhGDbJk5MruYQYheeNWKUBbd7WwIZxuQ11rYV1I4pE
        UgeJ3aXAUBqXJ3JqZTcCEpO6SHz+BITSknC5+harir2mSohmuW60ixRKXSUpduMhNKWQx7NR
        LBvHqrZUAWnvlobUSv8FUbUh4ZmRzhUzCw0Fj4Oe45iWzhhVXDRmf6xyuLpi7lBXD6cwBXM/
        F9pUIY+83Ztzj45lJgd5BE9Hho96+zWXJrYHffY9FrA3NXNmTFHRWO+XPPIrDPo6826vOGnd
        SgN9g8eTZi7XTch8XDSvmiZr0s+H5o69PFWi7W+WCrkIuc8BTMXJ/wHE8bBHVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7palQExBnsnyFpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLp9YtMFrcbV7BZ
        tO49wu7A67Fm3hpGj02rOtk8Ni+p9+jbsorR4/MmuQDWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Moy/+shVctKr4s24dWwPjHtUuRk4OCQET
        ieMtP1m7GLk4hASWMkrM7bnFDpEQk5i0bzuULSzx51oXG0TRa0aJ6xOPgCWEBTwlDl87xwJi
        iwhoSlz/+x1sErPAd2aJhTfnsEN0LGOSmPJmO3MXIwcHm4CexI5VhSANvAJuEq+b/7GChFkE
        VCWWb88GCYsKREh8fLqPCaJEUOLkzCcsICWcAoESn2eKgISZBcwk5m1+yAxhi0vcejKfCcKW
        l9j+dg7zBEahWUi6ZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECo3Xb
        sZ9bdjB2vQs+xCjAwajEw8sQHBAjxJpYVlyZe4hRgoNZSYTX8Ld/jBBvSmJlVWpRfnxRaU5q
        8SFGU6DXJjJLiSbnAxNJXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYO
        TqkGxp13+N9en2Ixc9WRNK7X237XqM5oKWd1X7SYIXLFO5WJn3nm/O0ufbV9+Y+/gj1Lvps/
        LexbPOuBuex9xpfPn1XefFEmeVNCxVUgz+yjgk7lSSNXDWGFObu+LT8372u51WmdI/KXXVQP
        fXuy23nr827JTRZH7Po/ckX6FZ47yPazPWhv1upbGluUWIozEg21mIuKEwE/2ycw7AIAAA==
X-CMS-MailID: 20190129160250eucas1p2eb448275d6c25f1d2a72f68d06f3763a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128192153eucas1p2d7a796cb89e68c1789069562e91296be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192153eucas1p2d7a796cb89e68c1789069562e91296be
References: <CGME20190128192153eucas1p2d7a796cb89e68c1789069562e91296be@eucas1p2.samsung.com>
        <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
        <1548703299-15806-5-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPd2g6rtZpK20emJ0tqHhq0D01=BWbU_9MP30313XHvPHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 1/29/19 3:47 PM, Krzysztof Kozlowski wrote:
> On Mon, 28 Jan 2019 at 20:21, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> The patch adds description for DT binding for a new Exynos5 Dynamic Memory
>> Controller device.
>> It also contains needed MAINTAINERS file updates.
>>
>> CC: MyungJoo Ham <myungjoo.ham@samsung.com>
>> CC: Kyungmin Park <kyungmin.park@samsung.com>
>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Kukjin Kim <kgene@kernel.org>
>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>> CC: linux-pm@vger.kernel.org
>> CC: linux-samsung-soc@vger.kernel.org
>> CC: devicetree@vger.kernel.org
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/devfreq/exynos5-dmc.txt    | 108 +++++++++++++++++++++
>>   MAINTAINERS                                        |   7 ++
>>   2 files changed, 115 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
>> new file mode 100644
>> index 0000000..914bd85
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
>> @@ -0,0 +1,108 @@
>> +* Exynos5 frequency and voltage scaling for Dynamic Memory Controller device
>> +
>> +The Samsung Exynos5 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>> +memory chips are connected. The driver is to monitor the controller in runtime
>> +and switch frequency and voltage. To monitor the usage of the controller in
>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>> +is able to measure the current load of the memory.
>> +When 'userspace' governor is used for the driver, an application is able to
>> +switch the DMC frequency.
>> +
>> +Required properties for DMC device for Exynos5422:
>> +- compatible: Should be "samsung,exynos5422-bus".
>> +- clock-names : the name of clock used by the bus, "bus".
>> +- clocks : phandles for clock specified in "clock-names" property.
>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>> +
>> +The example definition of a DMC and PPMU devices declared in DT is shown below:
>> +
>> +       ppmu_dmc0_0: ppmu_dmc0_0@10d00000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d00000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +                               event-name = "ppmu-event3-dmc0_0";
>> +                       };
>> +               };
>> +       };
>> +
>> +
>> +       ppmu_dmc0_1: ppmu_dmc0_1@10d10000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d10000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
>> +                               event-name = "ppmu-event3-dmc0_1";
>> +                       };
>> +               };
>> +       };
>> +
>> +       ppmu_dmc1_0: ppmu_dmc1_0@10d10000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d60000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
>> +                               event-name = "ppmu-event3-dmc1_0";
>> +                       };
>> +               };
>> +       };
>> +
>> +       ppmu_dmc1_1: ppmu_dmc1_1@10d70000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d70000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
>> +                               event-name = "ppmu-event3-dmc1_1";
>> +                       };
>> +               };
>> +       };
>> +
>> +       dmc: dmc@10c20000 {
>> +               compatible = "samsung,exynos5422-dmc";
>> +               reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>> +                       <0x10030000 0x1000>, <0x10000000 0x1000>;
>> +               clocks =        <&clock CLK_FOUT_SPLL>,
>> +                               <&clock CLK_MOUT_SCLK_SPLL>,
>> +                               <&clock CLK_FF_DOUT_SPLL2>,
>> +                               <&clock CLK_FOUT_BPLL>,
>> +                               <&clock CLK_MOUT_BPLL>,
>> +                               <&clock CLK_SCLK_BPLL>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +                               <&clock CLK_MOUT_MCLK_CDREX>,
>> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
>> +                               <&clock CLK_CLKM_PHY0>,
>> +                               <&clock CLK_CLKM_PHY1>
>> +                       ;
> 
> Join with previous line.
> 
>> +               clock-names =   "fout_spll",
>> +                               "mout_sclk_spll",
>> +                               "ff_dout_spll2",
>> +                               "fout_bpll",
>> +                               "mout_bpll",
>> +                               "sclk_bpll",
>> +                               "mout_mx_mspll_ccore",
>> +                               "mout_mx_mspll_ccore_phy",
>> +                               "mout_mclk_cdrex",
>> +                               "dout_clk2x_phy0",
>> +                               "clkm_phy0",
>> +                               "clkm_phy1"
>> +                               ;
> 
> Ditto.
OK, I will fix it.
> 
>> +
>> +               status = "okay";
>> +               devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
>> +                               <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
>> +       };
>> +
>> +
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9f64f8d..3581807 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3310,6 +3310,13 @@ S:       Maintained
>>   F:     drivers/devfreq/exynos-bus.c
>>   F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>
>> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5
>> +M:     Lukasz Luba <l.luba@partner.samsung.com>
>> +L:     linux-pm@vger.kernel.org
>> +L:     linux-samsung-soc@vger.kernel.org
>> +S:     Maintained
>> +F:     Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
> 
> Maintainers change should go with the next change, I think. It looks
> unusual to add an entry for driver... without the driver.
Thank you for the review. I will move the dt-bindings in the patch set
after the dmc driver file. Then the MAINTAINERS file will be updated
only by one entry.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
