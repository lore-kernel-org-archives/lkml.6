Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lRnQFbO8Glv3ZgAAmS7hNA
	; Fri, 08 Jun 2018 17:29:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B67876089E; Fri,  8 Jun 2018 17:29:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT/w+ah1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4431A601D2;
	Fri,  8 Jun 2018 17:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4431A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeFHR3B (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:29:01 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36700 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeFHR27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:28:59 -0400
Received: by mail-ot0-f194.google.com with SMTP id c15-v6so6733205otl.3;
        Fri, 08 Jun 2018 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1onH9GSWoh4lumzrHhHWWw6BfdbKzHvdON7zZ0K6wbg=;
        b=rT/w+ah1ITaqI89av1hxfytWqOCJke755PvQ6L/Iwbv222jxzLkpRdmX/jWu/c4XVK
         lGXnS6XDtH1NPOMcTLQI7qVHPRxm2/W5DxXy+RSG+7YWDkuBY213N+LLHZzluObOZ59c
         Up2C0WPWfOG64rUrXiuWO2EV2BgAAJAI4I4326ndCjR0ptvMlkc7H1WgyclRRqboqPih
         CLsN+222dMXW/tDOiiYwjiKTkICsFKiSCN08EJzorvTJMaKKuv/+O1CoUII+JsLLymCr
         tZPqsm6aE9TH+WdYyhQwQckT8cZeTRsqXgU9pCVmCWXblrnBX8cDCl16Hcu31u0qUUew
         c7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1onH9GSWoh4lumzrHhHWWw6BfdbKzHvdON7zZ0K6wbg=;
        b=t2H3cwhx6zOeZpeCx/NYIIYJ0h0Wpt/o40rczYRHTzsSWu2HNSDxX8fw4kVtMZHVTD
         pYkn5cC5r/XwC9uLVE3i3RA15q9X7Pf7cCUM8P8m49li5NTNfwUFHE9rPZavWAuXmhsy
         GBTKmwnjGXx5+pnt1fhTUkbmRooTOpmMQx4SS4ZCyGxTXqYHTtnZYnOL0Zx1ArOKz73F
         dGllguX6IO1SJ18frEs2sxBQC9lOOBIFPG6o4W3EVIWqweqJXgfZkXC06pTSWG3Ljj4x
         QnAEhSt077FuzhrsY8CvdHSVMsmz+XzZKnA4CTnio72B2Da0JRD5fD431Tlf7sO83njX
         gZBQ==
X-Gm-Message-State: APt69E1TPLqjF8KAPVPLgL5JSCT5K77g98R2UwavfUSJJDoXf8fnLQJ1
        dz+9m3M8xKXc/Exxv8rdc8/BjAbEC/NejuC4QL0=
X-Google-Smtp-Source: ADUXVKK08Ed9++QoubHYM9VI6ls5hJfNORsUULUMbTfbXL3ufGXfvAguYXQI/1TxH5BTHYDbx4LBJSebFyHlZim2Mko=
X-Received: by 2002:a9d:2bcd:: with SMTP id u71-v6mr3872907ota.51.1528478937869;
 Fri, 08 Jun 2018 10:28:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 10:28:57 -0700 (PDT)
In-Reply-To: <70b90919f98a6941425b39065dc8d37c95f0fd9f.1528390418.git.leonard.crestez@nxp.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
 <70b90919f98a6941425b39065dc8d37c95f0fd9f.1528390418.git.leonard.crestez@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Jun 2018 14:28:57 -0300
Message-ID: <CAOMZO5Anr6BQ=7XWB8hQSaV6m5b1fwji1RBwSj7vZU2zdAVnTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx_v6_v7_defconfig: Enable imx6qdl-sabreauto sensors
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 2:00 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> CONFIG_SENSORS_ISL29018 supports isil,il29023 light sensor
> CONFIG_MMA8452 supports fsl,mma8451 accelerometer
>
> CONFIG_MAG3110 for fsl,mag3110 is already enabled
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Just a minor nit in the Subject. The "ARM" prefix is missing.

Maybe Shawn can adjust it when applying the patch.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
