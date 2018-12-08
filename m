Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455E8C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BD8214DE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="IpX1/qLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BD8214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLHABk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:01:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46206 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHABk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:01:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so5392890otm.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 16:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=4AlXO4Tmj+MGMu7jSdmZ2dMT8ihSwTRyjyCPhPbmVSY=;
        b=IpX1/qLtQnbjTr72KywcBKWyJcBLnB+Po35UXTz2zIYrtXcNK9Umb100VbBrDtxVbz
         RgLJZLDGCoCbKf4eoi2vKBcupoqn2IoKpl1rY+aI9ZyGxSNqRlNd2ZWZRO/PSPDA+9n6
         VQ3CooX8qd/SjuqKjfdw6JR5cKNEPB1KFnCF2KPY52WohnlROdX+sVIkWhyelHdLIoph
         9rz8U4b7lWfftwLCJg1azluuHTjejSUUx/TFcj8A05pxNDdtml0Xs3VhtygswXyYO4mk
         lplM3feoTKT3NcpSsov/hS9+DBPiBzySLnFERSW8bFYRD/QzoTNByCSh14Zxo8apBMHr
         vpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=4AlXO4Tmj+MGMu7jSdmZ2dMT8ihSwTRyjyCPhPbmVSY=;
        b=K5TxpLVvhJ8gcp6MYZut8b2L8a2vsfjM82t7XuYwt9+fTb6iMbYy82bttwe+Zs0QiE
         R9do1r3dTFsU0kIG+U0LL8Wyck4Kg1bHZhXRF/O3scp2q6HWJbel/dOGTSjDX+4LEeEU
         bbE5VvMxy4C+N44ZENoz11sPc5kD4be7cNFLDo86xCSgtCyIBVVYp3ZMdMTZpyxEOhjm
         o5+iIvBBmwv6Z2dDno8jn/QnZr4UN3vlFW2VHr3s28os1L7a0+2WHSQxFhM+Z88xEuyx
         084xnreyFNhMLi/Pqc4nECd+v8uffFw6m/2EM3CUoj2Uu5zxWX1X98ca3IZwHTrQZH96
         +Giw==
X-Gm-Message-State: AA+aEWauECoicEdm0JmKKeHC5LKMmvTCxdliELWSaHSGlfdBr249MGj+
        eNK4GD1wHPjzkfNlNKWtkmATnZsG9ppbHQ==
X-Google-Smtp-Source: AFSGD/Vw7V4HDwZHCILi/m/69sEoUiuZPl+hcpFWcgmhh+yyI+6DJxRn+vbpOmZocF8qyyShGB2NLQ==
X-Received: by 2002:a9d:64c8:: with SMTP id n8mr2961925otl.115.1544227299192;
        Fri, 07 Dec 2018 16:01:39 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id v1sm2189720otq.80.2018.12.07.16.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 16:01:38 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-oi1-f169.google.com with SMTP id j21so4775729oii.8;
        Fri, 07 Dec 2018 16:01:38 -0800 (PST)
X-Received: by 2002:aca:37d5:: with SMTP id e204mr2364152oia.134.1544227297531;
 Fri, 07 Dec 2018 16:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20181206100905.15053-1-otavio@ossystems.com.br> <CAP9ODKoG-XRSOekKJWkD3Wg_dPsS2baRzPhuuJmmoT7-omBOtA@mail.gmail.com>
In-Reply-To: <CAP9ODKoG-XRSOekKJWkD3Wg_dPsS2baRzPhuuJmmoT7-omBOtA@mail.gmail.com>
Date:   Fri, 7 Dec 2018 22:01:18 -0200
X-Gmail-Original-Message-ID: <CAP9ODKpJdGhwN8FHzEZUihWsUu=iig56o0uQQ75kmHeVCRyB9Q@mail.gmail.com>
Message-ID: <CAP9ODKpJdGhwN8FHzEZUihWsUu=iig56o0uQQ75kmHeVCRyB9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Improvements for i.MX7D PICO SoM and its baseboards
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,

On Thu, Dec 6, 2018 at 8:44 AM Otavio Salvador <otavio@ossystems.com.br> wrote:
> On Thu, Dec 6, 2018 at 8:09 AM Otavio Salvador <otavio@ossystems.com.br> wrote:
> > This patchset rework the imx7d-pico SoM, its Pi baseboard
> > and add the Hobbit baseboard support as well.
> >
> > Changes in v2:
> > - replace fsl,uart-has-rtscts with uart-has-rtscts
> >
> > Fabio Estevam (8):
> >   ARM: dts: imx7d-pico: Do not harcode the memory size
> >   ARM: dts: imx7d-pico: Switch to SPDX identifier
> >   ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi
>
> I did the rebase; one thing worth mentioning is that I have "ARM: dts:
> imx7d-pico: Describe the Wifi clock" which is in your fixes tree.

Do you wish me to resent this now that the "ARM: dts: imx7d-pico:
Describe the Wifi clock" is on linux-next? If so I can rebase and
resend. Just let me know how to make it more convenient for you,
please?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
