Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CD3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48A4208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+sV9T4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48A4208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934102AbeGJPD6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:03:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43134 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933709AbeGJPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:03:54 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so7746893plj.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=9CCPpeXeDewdYG+/XQfD2a50nOQwIqsOvU8KH4vki7M=;
        b=d+sV9T4sUIdh2GUdkWatqCZggIBk1KQN8NKYgR+f0xdE+sY1tWLCAnHjza8oeo39TT
         /nRshUDLik5zXFkDGjLNoUF4RD0SSgUVUL8QzorxGfP6tVDLjWv6VkXBuQTcotLPvuqp
         bwSeWanEgzxDr3DnNR9qQ59wTE/tw0pcTOVHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=9CCPpeXeDewdYG+/XQfD2a50nOQwIqsOvU8KH4vki7M=;
        b=YeRVYyzFp6bhLemDtwCOGyvxoipseff2dtylpKZhK/6VYuxzkzgjWpIAFHV0e9x0+H
         saK/Mm8SvngpbLA9WXriloycg+FyaFZl+4dTGuPBzxIbX4LWx43RrFSRu5ehiF9EKej2
         mULrZgzXch+dmvv65PEAlik6KL6b+nra6zY0bbTbii+iLXld1D8QImlvBKKhA6y+AQfq
         /H+xWt3HOlzqkLr5IjmVgRWJPwn3+03AWF0dOBBZqJ3ovdV51Xw4sjWaZG0auw94jcut
         btoi/UGrYzs/d70fOmy9/LJqoKRXQQyVGm6F/jANWxSDXjP2PrlvVHfZ7tTYdIGpu0nc
         dCPA==
X-Gm-Message-State: APt69E1r5SXWWBD1PRXuqujYn7Lg6P0d3ximxiFMbrXuVnHfHb4rPYVJ
        npA/OxkjFr+HFfhqkgveBYg7+g==
X-Google-Smtp-Source: AAOMgpfvye9JBwPWHlSkdMfgBF7gUfV8oYeTZvnf+Qq1eFoKTisOzMGe8095L/TrNexYGsaqk6xojA==
X-Received: by 2002:a17:902:bb8d:: with SMTP id m13-v6mr15402952pls.46.1531235034375;
        Tue, 10 Jul 2018 08:03:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id x6-v6sm34797079pfe.30.2018.07.10.08.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 08:03:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Girish Mahadevan <girishm@codeaurora.org>, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Cc:     Girish Mahadevan <girishm@codeaurora.org>, dianders@chromium.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Message-ID: <153123503305.143105.13357813628465667911@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Tue, 10 Jul 2018 08:03:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Girish Mahadevan (2018-07-05 14:46:41)
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt | 36 ++++++++++++++++=
++++++
>  err.txt                                            | 27 ----------------
>  2 files changed, 36 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-q=
spi.txt
>  delete mode 100644 err.txt
> =

> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt=
 b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> new file mode 100644
> index 0000000..3baa893
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> @@ -0,0 +1,36 @@
> +QTI [Qualcomm Technologies Inc] Quad Serial Peripheral Interface (QSPI)

Just write out the TLA?

> +
> +QSPI [Quad Serial Peripheral Interface] allows single dual and quad read=
/write
> +access to slaves. QTI's QSPI controller implements the QSPI protocol to =
interface

This QSPI controller?

> +with slaves like NOR Flash devices.
> +
> +Required properties:
> +- compatible:  Should contain:
> +               "qcom,qspi-v1"
> +- reg:         Contains the base register location and length
> +- interrupts:  Interrupt number used by the controller.
> +- clocks:      Contains the core and AHB clock names.
> +- clock-names: "core" for core clock and "iface" for AHB clock.
> +- spi-max-frequency:   Maximum SPI core clock frequency in Hz.
> +
> +SPI slave nodes must be children of the SPI master node and can contain
> +properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +
> +       qspi: qspi@7418000 {
> +               compatible =3D "qcom,qspi-v1";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               reg =3D <0x7418000 0x600>;
> +               interrupts =3D <0 459 0>;
> +               clock-names =3D "iface", "core";
> +               clocks =3D <&clock_gcc clk_gcc_qspi_ahb_clk>,
> +                        <&clock_gcc clk_gcc_qspi_ser_clk>;
> +
> +               device@0 {
> +                       compatible =3D "dummy_device";
> +                       reg =3D <x>; /* CS for the device */
> +                       spi-max-frequency =3D <f>; /* Max supported frequ=
ency of the slave (Hz) */
> +               };
> +       };
> diff --git a/err.txt b/err.txt
> deleted file mode 100644
> index 09000e4..0000000

This part of the patch shouldn't be here.

> --- a/err.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -Skipping hidl generation
> -arch/arm64/Makefile:23: ld does not support --fix-cortex-a53-843419; ker=
nel may be susceptible to erratum
> -arch/arm64/Makefile:44: Detected assembler with broken .inst; disassembl=
y will be unreliable
> -  CHK     include/config/kernel.release
> -  CHK     include/generated/uapi/linux/version.h
> -  CHK     include/generated/utsrelease.h
> -  CHK     include/generated/bounds.h
> -  CHK     include/generated/timeconst.h
> -  CHK     include/generated/asm-offsets.h
> -  CALL    scripts/checksyscalls.sh
> -  CHK     scripts/mod/devicetable-offsets.h
> -  CHK     include/generated/compile.h
> -  CHK     kernel/config_data.h
> -  CC      drivers/mtd/devices/m25p80.o
> -  AR      drivers/mtd/devices/built-in.o
> -  AR      drivers/mtd/built-in.o
> -  CC      drivers/spi/spi-mem.o
> -drivers/spi/spi-mem.c:12:23: fatal error: internals.h: No such file or d=
irectory
> - #include "internals.h"
> -                       ^
> -compilation terminated.
> -make[2]: *** [drivers/spi/spi-mem.o] Error 1
> -make[1]: *** [drivers/spi] Error 2
> -make: *** [drivers] Error 2
> -
