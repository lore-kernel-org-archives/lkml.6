Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6ECC282E6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D792084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OyNOrfXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfAUHwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:52:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40902 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAUHwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:52:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so15787508edr.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dazpabB+cJDgmqjbKILU5ER9btyscoPtFMMvH2bA99g=;
        b=OyNOrfXFu6ry9Lez7TQ5UiEsSfwhFV+YoYZfixvZszu/L8O7JARXPS7rVyRp48mHgf
         abJfhN0SmF/+I4YWobukc/kUNT9Y3l3WA8Nr6h7+B9YKYergeesdasqllGl9bLKL3Wio
         Zme5pHiDVbIcr2i5E2ABFeApwXbgn/WN3JjOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dazpabB+cJDgmqjbKILU5ER9btyscoPtFMMvH2bA99g=;
        b=sJdNfaDOp/t0kTzxZ0KVi3zzofRqs075pudTBl4/sesGrZMXLe+1V29x+sEI8k6U9o
         p6J1T5tTJoWklGjHgZ+eWGDc3GCQuaaFa37hI3HYAZXFfA6sJSoFSInI0Tt9a9mrDXg9
         iBDQJIi8IaJWqTmpTpP5dQGfR552cJj5s26zVHkDmHa2tVTvsN7TaJhyEGgb5d3tX1bO
         oq7emNRZq93iTbEMi0rCkjXSARm3T/HSD4B7srJ+UL9lBrJanFAa+fx4n6Zj+7nDZUQm
         l6vyYDzOgYpw0cXOuGCiR1nwYi/aGoCtc9u1cWuvJgX7hCiUFGqcnRojwy6ZYed6bafz
         IwDA==
X-Gm-Message-State: AJcUukeGqbky8O2rp9yBiQYhzZvXaOGUDUG9acYlLNxCp7yaqxbxRDhE
        2SiccSh+DW4oNxT5izxSQc64eA==
X-Google-Smtp-Source: ALg8bN6hFhMXNCMUuNlpXn35GQLk2gZ4gtCbJuM0QHJbLPj/uMlbNy+MXRrw03OW38VIhkiL+D/7vA==
X-Received: by 2002:a17:906:33d9:: with SMTP id w25-v6mr22327320eja.190.1548021006089;
        Sun, 20 Jan 2019 13:50:06 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p16-v6sm4730867eju.73.2019.01.20.13.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 13:50:04 -0800 (PST)
Subject: Re: [PATCH v3 0/8] Add IPROC I2C slave mode and NIC I2C support
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        rjui@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        shreesha.rajashekar@broadcom.com, sbranden@broadcom.com,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ccheng@broadcom.com,
        heikki.krogerus@linux.intel.com, geert@linux-m68k.org,
        arnd@arndb.de, manivannan.sadhasivam@linaro.org, ajayg@nvidia.com,
        ard.biesheuvel@linaro.org, eajames@linux.vnet.ibm.com,
        kramasub@codeaurora.org, vigneshr@ti.com,
        mika.westerberg@linux.intel.com, pierre-yves.mordret@st.com,
        f.fainelli@gmail.com, aaron.wu@analog.com, jdelvare@suse.de,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        rayagonoda.kokatanur@braodcom.com
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
Date:   Sun, 20 Jan 2019 13:49:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rayagonda/Wolfram,

I reviewed the entire patch series and added my Reviewed-by tag on 1/8
and 2/8. The rest of the patches in this series already had my
Signed-off-by tag.

Thanks,

Ray

On 1/17/2019 10:04 PM, Rayagonda Kokatanur wrote:
> Hi,
> This patchset contains support for IPROC I2C slave and NIC I2C support.
> Following are the brief changes done inorder to support both IPROC I2C
> slave mode and NIC I2C,
> 
> a. Add support to allow I2C rx transfer upto 255 bytes
> b. Add polling mode support to the iProc I2C driver. Polling mode is used
>    in certain SoCs where interrupt is not connected from the I2C block.
> c. Add warpper read/write access for register to support indirect register
>    access. This is required in certain SoCs with this iProc I2C
>    block registered.
> d. Remove the set RESET bit to LOW right after setting it to HIGH so that
>    wait duration can be met.
> 
> This patch series is based on kernel v5.0.0-rc2.
> 
> Changes from v2:
>  - Address Ray's review comments.
> 
> Changes from v1:
>  - Rebased to Linux v5.0.0-rc2
> 
> Ray Jui (1):
>   dt-bindings: i2c: iproc: make 'interrupts' optional
> 
> Rayagonda Kokatanur (5):
>   i2c: iproc: add polling support
>   i2c: iproc: use wrapper for read/write access
>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>   i2c: iproc: add NIC I2C support
>   arm64: dts: Stingray: Add NIC i2c device node
> 
> Shreesha Rajashekar (2):
>   i2c: iproc: I2C read up to 255 bytes support
>   i2c: iproc: Add Slave mode support
> 
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>  drivers/i2c/busses/Kconfig                         |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c                 | 757 +++++++++++++++++----
>  4 files changed, 659 insertions(+), 131 deletions(-)
> 
