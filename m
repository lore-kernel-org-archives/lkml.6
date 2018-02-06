Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1345673-1517929734-2-11190247555073965110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517929734; b=hsPyI5oCVg42iLQdU9fSQpAPJI8akytX+UHqqgQlaiqo1v1
    x+xTd/b9yCVJRjjnGknVpIeu9xCt6o91ILa7AnMX9gKEgpPhUjHeQjcQKKKllxjh
    uQM1A1PGhOUxjk9cLAdR/KfZtjsWxnH62FQbOTwDlBZQ3E8EevEeC4NUYEmlYCIm
    BtlInQH6brcbmkYPwzAXa+QxH0qOJUbKfyhB2rUtACLRg3HcAtGFcfjfFih1ngU7
    TOCW0FbxJYKArgWIAE6aPHwYh40cxOJazmWlLTu0ZgbLzd7gDGEPLj+GSzbraJ1g
    zFkocbuNBVNUyrGose9UQuAvDiJFghR55BGQE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517929734; bh=zkbwtWHJPWieNHsQzIKt2mfe2a1EsrPCslwM0H
    UgWPU=; b=FlelOKDu89mUo1aWS6dq5beAFUFk29ppTlTUJkUKjRHzqhbw/dusvn
    n/AzrMfZhlOe5mcmaGL8A9jmx2Jjav3Y+wiIBdTDUVbUx7del6s8lMTx5ZYLyRTR
    QDL4WPLAeoqfnJapl3SPGSrETI1vl4mJChLPQ2hv1D+aOaDT5NexWWAuaJSzazi2
    d8yH9D+cWysDxXuiJ1mL6OOJDGsaELZ+fNGDErwVIqoFG0Pf6i2ZA8EiM18uW4XI
    wDjx9ypDlQzOaOHKJh0Di8V9caN+038fJ2/0bhHOE3Jv/Hgljp2//ZtkRt5rFGoj
    7QcZ2T2ZWQ91rSRDzGGdqmWMsT1ImITg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Zv8Drfrt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k+cv2fdp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Zv8Drfrt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k+cv2fdp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBFPIw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 10:08:52 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:35303 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeBFPIu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 10:08:50 -0500
X-Google-Smtp-Source: AH8x226GY9Nrira0RFZYkf4X/5WomGek07pjoIWBAQjH29HGQwjfIA++QhzNohKW/z0dh6+YbzcbihcD3BTK/AuvGqM=
MIME-Version: 1.0
In-Reply-To: <5a78c368.5896df0a.8f293.fd41@mx.google.com>
References: <5a78c368.5896df0a.8f293.fd41@mx.google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Feb 2018 16:08:49 +0100
X-Google-Sender-Auth: aEHFmRhBxEtd1HPQh4b1WIxbyrg
Message-ID: <CAK8P3a1n2ELL56MHqEgffzNg2B8gdpwHpMnp_vgN4ftAAiwW8A@mail.gmail.com>
Subject: Re: stable-rc/linux-4.15.y build: 185 builds: 0 failed, 185 passed,
 46 warnings (v4.15.1-61-g7ab5513e4cbc)
To: gregkh <gregkh@linuxfoundation.org>
Cc: Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "4.15.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 9:49 PM, kernelci.org bot <bot@kernelci.org> wrote:
>
> stable-rc/linux-4.15.y build: 185 builds: 0 failed, 185 passed, 46 warnings (v4.15.1-61-g7ab5513e4cbc)

Hi Greg,

FYI, the device tree compiler warnings are all fixed in
linux-4.16-rc1. These are basically fixes
that we ended up not submitting last minute for the release after one
of them (the USB PHY
one, if you remember) had blown up.

Anyway, I think the risk is rather low for any of them (they are
mostly platforms that
are not widely used, and the fixes make things work that didn't), so
to get a clean
build, feel free to pick up the remaining patches from mainline now or
after -rc1:

> Warnings Detected:
>
> Warnings summary:
> 2 arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Property 'dmas', cell 4 is not a phandle reference in /ahb/apb/serial@b4100000
> 2 arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Missing property '#dma-cells' in node /interrupt-controller@ec801000 or bad phandle (referred from /ahb/apb/serial@b4100000:dmas[4])

cdd104099141 ("arm: spear13xx: Fix dmas cells")

> 2 arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property): Property 'cs-gpios', cell 6 is not a phandle reference in /ahb/apb/spi@e0100000
> 2 arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property): Missing property '#gpio-cells' in node /interrupt-controller@ec801000 or bad phandle (referred from /ahb/apb/spi@e0100000:cs-gpios[6])

f8975cb1b8a3 ("arm: spear13xx: Fix spics gpio controller's warning")

> 2 arch/arm/boot/dts/exynos5410-smdk5410.dtb: Warning (interrupts_property): Missing interrupt-controller or interrupt-map property in /soc/system-controller@10040000
> 2 arch/arm/boot/dts/exynos5410-smdk5410.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/system-controller@10040000
> 2 arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property): Missing interrupt-controller or interrupt-map property in /soc/system-controller@10040000
> 2 arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/system-controller@10040000

5628a8ca1414 ("ARM: dts: exynos: fix RTC interrupt for exynos5410")

> 2 WARNING: modpost: missing MODULE_LICENSE() in arch/arm/mach-pxa/tosa-bt.o

3343647813fd ("ARM: pxa/tosa-bt: add MODULE_LICENSE tag")

> 1 arch/arm64/boot/dts/qcom/msm8916-mtp.dtb: Warning (phys_property): Missing property '#phy-cells' in node /soc/mdss@1a00000/dsi-phy@1a98300 or bad phandle (referred from /soc/mdss@1a00000/dsi@1a98000:phys[0])
> 1 arch/arm64/boot/dts/qcom/apq8016-sbc.dtb: Warning (phys_property): Missing property '#phy-cells' in node /soc/mdss@1a00000/dsi-phy@1a98300 or bad phandle (referred from /soc/mdss@1a00000/dsi@1a98000:phys[0])

b0ab681285aa ("arm64: dts: msm8916: Add missing #phy-cells")

> 1 arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@1:cooling-device[0])
> 1 arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@0:cooling-device[0])

acbf76ee0506 ("arm64: dts: add #cooling-cells to CPU nodes")

> 1 arch/arm/boot/dts/stih410-b2260.dtb: Warning (gpios_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi@8d04000
> 1 arch/arm/boot/dts/stih410-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi@8d04000
> 1 arch/arm/boot/dts/stih407-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi@8d04000

7ac1f59c09a6 ("ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property")

> 1 arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd@10120000
> 1 arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd@10120000

e8bfa0422469 ("ARM: dts: nomadik: add interrupt-parent for clcd")

> 1 arch/arm/boot/dts/spear600-evb.dtb: Warning (interrupts_property): Missing interrupt-parent for /ahb/apb/rtc@fc900000

6ffb5b4f248f ("arm: spear600: Add missing interrupt-parent of rtc")

> 1 arch/arm/boot/dts/s5pv210-torbreck.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
> 1 arch/arm/boot/dts/s5pv210-smdkv210.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
> 1 arch/arm/boot/dts/s5pv210-smdkc110.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
> 1 arch/arm/boot/dts/s5pv210-goni.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
> 1 arch/arm/boot/dts/s5pv210-aquila.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000

5c1037196b9e ("ARM: dts: s5pv210: add interrupt-parent for ohci")

> 1 arch/arm/boot/dts/mt7623n-rfb-nand.dtb: Warning (resets_property): Missing property '#reset-cells' in node /syscon@1b000000 or bad phandle (referred from /ethernet@1b100000:resets[0])
> 1 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb: Warning (resets_property): Missing property '#reset-cells' in node /syscon@1b000000 or bad phandle (referred from /ethernet@1b100000:resets[0])

76a09ce214ad ("arm: dts: mt7623: Update ethsys binding")

> 1 arch/arm/boot/dts/mt2701-evb.dtb: Warning (resets_property): Missing property '#reset-cells' in node /syscon@1b000000 or bad phandle (referred from /ethernet@1b100000:resets[0])

ae72e95b5e4d ("arm: dts: mt2701: Add reset-cells")

> 1 arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
> 1 arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
> 1 arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
> 1 arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18

ca32e0c4bf9c ("ARM: lpc3250: fix uda1380 gpio numbers")

> 1 arch/arm/boot/dts/arm-realview-eb-a9mp.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> 1 arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> 1 arch/arm/boot/dts/arm-realview-eb-11mp.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> 1 arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> 1 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> 1 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000

586b2a4befad ("ARM: dts: Delete bogus reference to the charlcd")

         Arnd
