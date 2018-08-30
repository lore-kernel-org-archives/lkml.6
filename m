Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E487C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D095A20666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZYNQPWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D095A20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeH3Eaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeH3Eai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:30:38 -0400
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com [209.85.216.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A368B20676;
        Thu, 30 Aug 2018 00:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535589071;
        bh=gJtFs2dgvYnoLMz38y1BQhJ/PWYb+SaJArN0mN1MDYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rZYNQPWqNlb7ujFPpUUQKu4yyh+JA61dbBWTYLvzYhP71014Vtp1eAoE6EhrOod8f
         lcTF5Ui3vMQUO5K0zYpEIbMkaIfjtqMZE869XVPJHwP0z6M+hxUrRr7wTJKI7DXZR7
         j0N0QWplkAU4l5Yz5pYPXwm31tA9yqqF+M+R8b/c=
Received: by mail-qt0-f177.google.com with SMTP id z8-v6so7938062qto.9;
        Wed, 29 Aug 2018 17:31:11 -0700 (PDT)
X-Gm-Message-State: APzg51A3Hg0/MO4cZDTGqqWBzsS9KkOM3BIA5K3IrtRfMBF88nb9EnJp
        n58A4VeX2j5dhtojZfA02Sco8lQSQfqWleAuog==
X-Google-Smtp-Source: ANB0VdYO15tuTxu4fXMHWQV3z2snusPEJVrlmJm+U/S3rJerWunOqHV6Ykuu9w1I3mfYqQoVkwcG9hcy0qF5MPhSqo8=
X-Received: by 2002:a0c:db87:: with SMTP id m7-v6mr9065430qvk.90.1535589070817;
 Wed, 29 Aug 2018 17:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <20180829002535.GA4224@bogus> <d751bc90ab1cfce84d6f419400790566@codeaurora.org>
In-Reply-To: <d751bc90ab1cfce84d6f419400790566@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Aug 2018 19:30:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+prmJDKfXGdcB6mQBzA93PjfTqnpk3_07fmOt4=fx7w@mail.gmail.com>
Message-ID: <CAL_JsqL+prmJDKfXGdcB6mQBzA93PjfTqnpk3_07fmOt4=fx7w@mail.gmail.com>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 6:19 AM <dkota@codeaurora.org> wrote:
>
> On 2018-08-29 05:55, Rob Herring wrote:
> > On Fri, Aug 24, 2018 at 04:12:15PM +0530, Dilip Kota wrote:
> >> From: Girish Mahadevan <girishm@codeaurora.org>
> >>
> >> This driver supports GENI based SPI Controller in the Qualcomm SOCs.
> >> The
> >> Qualcomm Generic Interface (GENI) is a programmable module supporting
> >> a
> >> wide range of serial interfaces including SPI. This driver supports
> >> SPI
> >> operations using FIFO mode of transfer.
> >>
> >> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> >> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> >> ---
> >> Addressing all the reviewer commets given in Patchset1.
> >> Summerizing all the comments below:
> >>
> >>      MAKEFILE: Arrange SPI-GENI driver in alphabetical order
> >>      Kconfig: Mark SPI_GENI driver dependent on QCOM_GENI_SE
> >>      Enable SPI core auto runtime pm, and remove runtime pm calls.
> >>      Remove spi_geni_unprepare_message(),
> >> spi_geni_unprepare_transfer_hardware()
> >>      Remove likely/unlikely keywords.
> >>      Remove get_spi_master() and use dev_get_drvdata()
> >>      Move request_irq to probe()
> >>      Mark bus number assignment to -1 as SPI core framework will assign
> >> dynamically
> >>      Use devm_spi_register_master()
> >>      Include platform_device.h instead of of_platform.h
> >>      Removing macros which are used only once:
> >>              #define SPI_NUM_CHIPSELECT     4
> >>              #define SPI_XFER_TIMEOUT_MS    250
> >>      Place Register field definitions next to respective Register
> >> definitions.
> >>      Replace int and u32 declerations to unsigned int.
> >>      Remove Hex numbers in debug prints.
> >>      Declare mode as u16 in spi_setup_word_len()
> >>      Remove the labels: setup_fifo_params_exit:
> >> exit_prepare_transfer_hardware:
> >>      Declaring struct spi_master as spi everywhere in the file.
> >>      Calling spi_finalize_current_transfer() for end of transfer.
> >>      Hard code the SPI controller max frequency instead of reading from
> >> DTSI node.
> >>      Spinlock not required, removed it.
> >>      Removed unrequired error prints.
> >>      Fix KASAN error in geni_spi_isr().
> >>      Remove spi-geni-qcom.h
> >>      Remove inter words delay and CS to Clock toggle delay logic in the
> >> driver, as of now no clients are using it.
> >>      Will submit this logic in the next patchset.
> >>      Use major, minor and step macros to read from hardware version
> >> register.
> >>
> >>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   2 -
> >
> > Please split to a separate patch and explain why you are removing
> > spi-max-frequency?
>
> Hi Rob Herring,
>
> In this patch, added changes for Driver not to read the SPI controller
> Maximum frequency from the device tree. Accordingly I removed it in the
> device tree documentation file. As both the files need to updated so did
> in the same patch.

Just because the Linux driver doesn't use it isn't a reason. What if
there is another OS driver for it? The binding is the h/w description,
not what the driver uses currently.

> Could you please let me know the reason for making a separate patch.

- Step 1 of Documentation/devicetree/bindings/submitting-patches.txt says so
- I only review the binding generally, so my ack or reviewed by only
applies to it.
- It makes the commit history of the DT only tree[1] more logical.

 Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
