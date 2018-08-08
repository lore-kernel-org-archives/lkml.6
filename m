Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B8C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3084A2170A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WE/QI4he"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3084A2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHHIXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:23:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44126 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:23:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so581189pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=YtqRZ/ptjprLpK04S3SK+7xIoOtkUoPSzOMdbbwWcNM=;
        b=WE/QI4he8zmLXn7mPjU8TOtY8FjKA1hEFnUYbsOG5BADo5fr9NkyN/0n7YBwt7Dr0Y
         BS5u+14mFMV2sa8ycr0KN9aUx6ZkfLcojybE5EWEMxHhU/oZASbUwh3ROWMO4PumuGTU
         Ux/HHQefMSPJdZEdrh0/J1l7OFSl62Z+MS59c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=YtqRZ/ptjprLpK04S3SK+7xIoOtkUoPSzOMdbbwWcNM=;
        b=toc/SfE/9MVzkLryxRZd8Wpaslx5C3dAbRi/ohzeRU13g3B4jBV6XwttJdAlMmJZpb
         iN4Cc+iN68AAI+AYESPQRsJlmL84ldlIdN1QQYe+mulCxgsCCWA0pOIUC8pPWLHnLVdZ
         cQy7/X4FZgbWzM0x+qW/nMEURPTQqsiJfEdxxeYeQVO4xTxHFDxgFkyTcimeVRPDsMur
         /3C1mVLHpN5rKJIaJMLPdp9zuUwnwhZhBPd1CpmV6+AIk2ViukUiy7VVxvdATLnHBGd2
         fnhEfRhD2ayswZ6/ZscObn1Q/pNbY3haHhH+9L7EFh3uzSXrXCgFnxNjxkxAbgo05/Sg
         ByAA==
X-Gm-Message-State: AOUpUlHnJSy9JYbbNvvA15EL2PooVAu0DAfm2HvbuZF3V+YGvCrxK2rL
        NYAO7/N9smqTgsKLPYoJmEUtBw==
X-Google-Smtp-Source: AA+uWPxUX1G3LFTQK8Qwav86XdFOWpIGZlS5cbN83Ve5T7IyEtADYjdrCNKm2JdivwPDNjP/vG3tsw==
X-Received: by 2002:a63:cc04:: with SMTP id x4-v6mr1174963pgf.33.1533708308534;
        Tue, 07 Aug 2018 23:05:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id m20-v6sm5411058pfg.61.2018.08.07.23.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 23:05:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180802125827.GB27850@codeaurora.org>
Cc:     evgreen@chromium.org, linus.walleij@linaro.org,
        bjorn.andersson@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801020021.9782-2-ilina@codeaurora.org>
 <86600uy4vh.wl-marc.zyngier@arm.com> <20180801194538.GA6422@codeaurora.org>
 <86wot9wb9u.wl-marc.zyngier@arm.com> <20180802065104.GA27850@codeaurora.org>
 <86sh3xw7m9.wl-marc.zyngier@arm.com> <20180802125827.GB27850@codeaurora.org>
Message-ID: <153370830708.220756.4595316550560511917@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND RFC 1/4] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Date:   Tue, 07 Aug 2018 23:05:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-08-02 05:58:27)
> On Thu, Aug 02 2018 at 01:27 -0600, Marc Zyngier wrote:
> >
> >Sure. But once woken up (GIC *and* TLMM), the gpio line (which I
> >assume is level) is still high at the TLMM input. So why isn't it
> >registering that state once it has been woken up?
> >
> >I can understand that it would be missing an edge. But that doesn't
> >hold for level signalling.
> >
> Sure, yes. Sorry for not registering your point in my response.
> Once woken up we should see the level interrupt in TLMM.

And the level type gpio interrupt will trigger the TLMM summary
interrupt line after the wakeup? So then the only thing that needs to be
replayed is edge interrupts? How are edge interrupts going to be
replayed?

