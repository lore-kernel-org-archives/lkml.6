Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D1220881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHuMipK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D1220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeINRNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:13:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45581 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeINRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:13:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so4197764pfo.12;
        Fri, 14 Sep 2018 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXf+q3QREvjj/yZVES1pBwngg20esAzdTZTEll+WI4A=;
        b=qHuMipK+W1CB4evrxd1KxU3k1hmiVBWqTQhw9aZZRFqUBw4TNheMhbtKCZcuNsPpWy
         6YlkLM8ymLUzBCFXfWRdQMk9Gds7qJXTKXYRHLMbez1YrIGQg+CXDNzHMgqxlHYcUxfl
         aAfPzTLUdnLHM5fyVRFrtEiLP8WxxNqG5QjDKWG1dsV2Gl7YDSopeqX6h5F2NAwoVdtU
         X/+14a6Zog6B4hbk+lz0p3dCk0+jOuPdlvoDakoe7xoGuslrgtaPPvIERty6HP6dQ++i
         fqZ4WU4wXcNM9mf9EOuz70WvsSwXshEZ0LGsQa2qwipEC8V60y/BhJ+dPbU+QFHEGHa9
         5gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXf+q3QREvjj/yZVES1pBwngg20esAzdTZTEll+WI4A=;
        b=rk8kwt5maeSue+XuCOICZNhiO46hFyWOq9Z9D2q5IwLKsgFjcC5xTCwOjw48vtYPtj
         SO1uOzY61jGDK+10x8smdJEBd5K1hwaUD4ejTMK7DwkpKJU5lz4TA0OFPJna5J11OrgY
         H8en6Xp+BJuHYNRMT0wiUOIS+VphMG/XnXrINv7l4/l/iUsjPSSmBIdk+SU1E4FdOK8v
         SzNtPCtvFirC6LukgmtOFj9m8iu8vKFrg2S73cnpSHcBaYb1WVlwSWxRTZpZMSlUaMCX
         VQefSfZwguvkVNu/tmmFRdDKDD2jSpd2aH1AcAgspWY2ZUnXOl/bIFc5ZuH3tP8/PB1f
         jxLw==
X-Gm-Message-State: APzg51BIFdu9p3Pipw/3WuobXodtcKfwrAj8oxMlTEZwzwXOTy90Ljw1
        AJ9HNgX/EkWl871hOu2KcUI=
X-Google-Smtp-Source: ANB0VdYXGv/AipkNiR8+sCR9qTmB3py7iyDcX3s6mA3mGRSB5OzVL5/m9Oen6e0BrezhD+TXUWi4qA==
X-Received: by 2002:a63:ad07:: with SMTP id g7-v6mr11585390pgf.19.1536926381881;
        Fri, 14 Sep 2018 04:59:41 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id d132-v6sm12259736pgc.93.2018.09.14.04.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 04:59:40 -0700 (PDT)
Date:   Fri, 14 Sep 2018 17:29:28 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, michal.simek@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com, sudeep.holla@arm.com,
        amit.kucheria@linaro.org, leoyang.li@nxp.com, broonie@kernel.org,
        arnaud.pouliquen@st.com, eugen.hristev@microchip.com,
        rdunlap@infradead.org, geert@linux-m68k.org, ak@it-klinger.de,
        freeman.liu@spreadtrum.com, lukas@wunner.de,
        vilhelm.gray@gmail.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, sgoud@xilinx.com, anirudh@xilinx.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gustavo@embeddedor.com
Subject: Re: [PATCH v2 3/4] iio: adc: Add Xilinx AMS driver
Message-ID: <20180914115928.GA6465@himanshu-Vostro-3559>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
 <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

On Fri, Sep 14, 2018 at 12:48:29PM +0530, Manish Narani wrote:
> The AMS includes an ADC as well as on-chip sensors that can be used to
> sample external voltages and monitor on-die operating conditions, such
> as temperature and supply voltage levels. The AMS has two SYSMON blocks.
> PL-SYSMON block is capable of monitoring off chip voltage and
> temperature.
> PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> from external master. Out of these interface currently only DRP is
> supported.
> Other block PS-SYSMON is memory mapped to PS.
> The AMS can use internal channels to monitor voltage and temperature as
> well as one primary and up to 16 auxiliary channels for measuring
> external voltages.
> The voltage and temperature monitoring channels also have event
> capability which allows to generate an interrupt when their value falls
> below or raises above a set threshold.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
[]
> +// SPDX-License-Identifier: GPL-2.0

License Identifier seems inconsistent as below you
mentioned "GPL" and not "GPLv2".


Please check once.
Documentation/process/license-rules.rst


> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (chan->address) {
> +			case AMS_SUPPLY1:
			/* fall through */
> +			case AMS_SUPPLY2:
			/* fall through */


Similarly to others as well.
There is a plan to enable "-Wimplicit-fallthrough" gcc flag
https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

Also, Gustavo nearly cleaned all the cases and would save
his effort of doing it again :)
https://lore.kernel.org/lkml/20180903183618.GA6905@embeddedor.com/

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Xilinx, Inc.");


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
