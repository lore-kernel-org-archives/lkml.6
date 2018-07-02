Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8681C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A246B253FF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFZ6Zlpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A246B253FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932181AbeGBAyx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:54:53 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35698 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeGBAyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:54:50 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so8928608oik.2;
        Sun, 01 Jul 2018 17:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8EH80u6kPN3c+apZFzXNF9tp8AzWvvDYBgoZOOUDzNw=;
        b=iFZ6ZlposPdB08/wKHOxNYakV0mWE+A38JkFfWm0rXrqUvSNkYUEytNqjEKfSzg2Zr
         BEOtXeT/Fhu0Dejco02u1CZ5B4RASlGrOgeSkVoopFdMSIo41R3IsqoaxKQWPGnN0rVM
         MAF9Og5w0rEe3dmLsYZsfQlV7qSzDdxrNfB8ZddR1E2DYfixNVIh6vZ6a/3tGXNpObPg
         X7F+Xc69GfATGmpHLURPvfNR+wKZQZbugIbQqyYlSYN+7zzPkVZusQIhdGjFv0+ft9h9
         CfABOYiWR+nwMSkv2ByvQI5CWfFMJQVwpxnXt5PHuwfXpaRYdGDj7051tk9FRkPBCEt9
         U6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8EH80u6kPN3c+apZFzXNF9tp8AzWvvDYBgoZOOUDzNw=;
        b=qmHxsyZbC6t59NRa1LDObATaqYvayqIPyWJZ5FIO2DtwTwUw3EBEyhjHmRkSl4kGHK
         eWx9GSdo3jz1m5oPyEaH2b64wVprxMS1HCyG2Xs+MlmWRsQ5rR75ftJwm1h1Njiluq8N
         CGb4BKnzW5zoP3YDIFNwG7hLSd7pHkuPkBqxwjmgHhxU6iWlWOOl6PdDbQBFY5GEceol
         RIshw3xUWm/1W2qVp+RioZtEFU3gsik4cFfoCgZvH1NcWIsddygrliDFMjNNc5b2vTVk
         WY84JeG73CERNzALePbBwAg0iXTPr0n5j9TVTWlnYlnfygO+nyhiG97UHOj49QdqH1II
         +rvA==
X-Gm-Message-State: APt69E1+6lPlyWb1bz4TfktpC76or5y5GZhvBnjSn3FZ+M9q7J/TULoH
        /RLV7wMjrZjK788mtPooNtTzTBc6tcOLZei4EQY=
X-Google-Smtp-Source: AAOMgpd44bWtjJDuC80gl6mqkvJMXxn5E/VWcALN6wsgQ25gDQspvBIuO/865oUFGX2SqyUuT1ZynyKDg6ORPaUJkIQ=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr2127256oif.71.1530492889659;
 Sun, 01 Jul 2018 17:54:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 17:54:49 -0700 (PDT)
In-Reply-To: <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon> <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 1 Jul 2018 21:54:49 -0300
Message-ID: <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Sun, Jul 1, 2018 at 9:53 PM, Anson Huang <anson.huang@nxp.com> wrote:

> Yes, I think we can revert it to avoid breakage. Didn't notice that some
> i.MX platform do NOT have those critical switches always-on.

Ok, thanks for confirming.

I will send a revert patch then.

Thanks
