Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1609ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CB0208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwpqIDMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CB0208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbeGMSRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:17:04 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43571 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeGMSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:17:04 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so63727056oib.10;
        Fri, 13 Jul 2018 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wOa8n4VMXaitegeD26HrCf+x+d+zG900/5JQSsraFKs=;
        b=cwpqIDMt11czljSs23AeJLnojqSwPeUaPjev0Td/7XKAEufNTURB6TuPy2YAYdCQvV
         NKFBYjPDba4p6HFZ5Pj5JBkzmLDXoOZNZBZl4uYJ3+4QdbyYSnatfmsSUhG7ES2DyG0i
         JKPZVLw4nfgRHcOuU5uvF1i1LPlivWZ0bJ7sMf7AOLm/WRPWaXpRsfqFf/Kt41JXRrnS
         HyuKk6XDN0foP5nk6m1igha+PlUMOpz56D1AvTge5NnYKWTo6LOOGLvLyVrpQdIBQLwb
         K5o0vgmgrwXpt6ziG2szV4OdI9QA/oy+X3lNoNhOUfS2/mhDB7+SbB2HZ8mMV3OOzwLE
         BJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wOa8n4VMXaitegeD26HrCf+x+d+zG900/5JQSsraFKs=;
        b=GofxcOQPotM3HgDITtAP0w3+3BzMpTu3XQfyxXb5/pIcXiJXY55v3g8+Q1ki9f51dn
         M0RRNEQs/V3DgDrnmHsvOxZAJZbX1SU6L+MKMsxENyEFoQgMp3ryAFO9MeJa03fwjC2k
         Cya4oToiBxsCtQoTLsNxPY94Gm02QnBPyy5FzzcluT59/tyvAgCugE0Gh/HJbUYmU0TN
         f3zO4YLDGtQS/BfmG+X0lzuqug3VwKiIJjaGCqFazj6qD7JlAc5eDelZeAUUg/lXHWQA
         7ZiR6RBL6nnEjpQeTclOEZxM019tJsKlXTTtIIy9xbKm6AjgKWVraU107MuCD9LUbCkd
         CorA==
X-Gm-Message-State: AOUpUlEIQtVqw7HRkY3uZnylDVAsvcfn39zfseHOhhJ3ZmUNG1p4mmAo
        JH29qjknL1kOROdsliGDtr51YFUvr2au+nf+pdc=
X-Google-Smtp-Source: AAOMgpfTHVCufepgpn7ydAO5Gv0W0wnMqt8jZtvOB9NMzVB9Xz6BpR0vFyCV/Jp154Y+zRGeh8VVmnNBD87UeoCarDM=
X-Received: by 2002:aca:3a57:: with SMTP id h84-v6mr8524295oia.336.1531504883211;
 Fri, 13 Jul 2018 11:01:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 11:01:22
 -0700 (PDT)
In-Reply-To: <1531468707-25737-3-git-send-email-Anson.Huang@nxp.com>
References: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com> <1531468707-25737-3-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Jul 2018 15:01:22 -0300
Message-ID: <CAOMZO5CBaO7agXqdqcxrdmJMqM4rvYc2VsMSXBtyMZNN8fzAtg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6sll-evk: enable SEIKO 43WVF1G lcdif panel
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 4:58 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Enable SEIKO 43WVF1G lcdif panel for DRM driver,
> add necessary properties according to SEIKO 43WVF1G
> driver's requirement, such as "dvdd-supply", "avdd-supply"
> and "backlight" etc..
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
