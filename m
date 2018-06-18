Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54065C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4B420852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2ulJp/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4B420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935570AbeFRLFa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:05:30 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38955 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934189AbeFRLFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:05:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id t22-v6so14423147oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 04:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZbPyoHOtRk+PZVFJa9b0g7fbrzIs/kbH7VZI+36O4MQ=;
        b=U2ulJp/TnCxfKa/OQG9zsQuzEawC343xM0iDD83S9Ha5TJ/pFi++AYubHi6WD5lsza
         2fGV9ri0xIwF606kL8RLP4sjJMZMcjEGc5daxvOAx1QRgLHAA1FuSESX5230hp36OEem
         aTFcmX6g9PdK4B+ARXCPw840uOiQd8mejnCijmE4M0PaN1bAAGPtnq8EAW29nbJSDJ9u
         iGO0sE9uQ6rlxrqzLxaETIKWEAr9GOSfuY8vyZQHEJ6Boh74dn+UdMCdnZRgUg7/YpOg
         /VBAlIHMxWGxOxlOfB0jZzAtMn+Jve2c44APY32ZCpIiOyuEr6Cih3bxwOubeu5rPKjh
         QNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZbPyoHOtRk+PZVFJa9b0g7fbrzIs/kbH7VZI+36O4MQ=;
        b=YjmkN4R1C2hHDe2adM2myf/FdhZstaLST/VDvoC7cFOj4qw7JUEJqKWMi2EV83vbIt
         bvQ2uQ68Z4qrFnTyaFL20I1JW5AbtwHFw7l10veFfC6bUbzCQHkLBO2InDzZAZ2Nu/zN
         Yw7Wqtu4IwlqXKYDa5eE7GpfNStf72GySie+YHf4umf5C1vHN00h5HgbKaT1Qku36TTq
         haihFa7ebh3SvnXwiIyExsNr3aV3Gsu7cGjsymMIcCBVyD54rDm56seZj8XUHTdfYSvH
         +fQLb3pF3KvH+tuX/H8hBF3GQmgJYWYOuK+dLud6t1SIjKutpHRf3zO0bbKYA5ZzKF2x
         a6vQ==
X-Gm-Message-State: APt69E2uDdtfELf6xj/miZajc23rS+uo6KKVLzDtnncatfb/udNvvQJr
        F7ViUbse1VXKgTeaaVfnRiXumkr5I4VMhHnPFOE=
X-Google-Smtp-Source: ADUXVKLBANkf8KrU82afj1/sttNN0abaaDaQ1yKgB2Vlba/ENMeRgDuXBv6xosMjw50kgU/odLUljsnf56L9clyuJJE=
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr6904343oii.198.1529319912953;
 Mon, 18 Jun 2018 04:05:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 04:05:12
 -0700 (PDT)
In-Reply-To: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
References: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Jun 2018 08:05:12 -0300
Message-ID: <CAOMZO5AhN9K0wDZcsimM3f4O7KFp+7JkzjNmFJ9FDnJ131wX7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 5:15 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> The following sensors are on I2C3 on the baseboard:
> * isil,isl29023 light sensor
> * fsl,mag3110 magnetometer
> * fsl,mma8451 accelerometer
>
> Added under i2cmux/i2c@1 because they're not otherwise accessible.
>
> These are all supported by iio with following configs:
> * CONFIG_SENSORS_ISL29018
> * CONFIG_MAG3110
> * CONFIG_MMA8452
>
> Tested with raw reads from iio sysfs.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
