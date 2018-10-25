Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4920FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0225D20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpXkM9Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0225D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJZCtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:49:14 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:35876 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJZCtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:49:13 -0400
Received: by mail-it1-f181.google.com with SMTP id h14-v6so2971114itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3boceHdvwF+yl7uVwQWtms95Pe8vsglnDYg55Hv+Yw=;
        b=VpXkM9Y/QujWBPmVySqxdx6t9qC8CiOBshQDlLdb7erAxJ7pr8fvwAuuNHrDgCXMli
         0yshfSNo05gqOyTVWtaDucFPppgmrnQDCS1X4NIlFFXFLCe/w8ATQkOlcjiJ+rEmt13+
         vLoCZDr6nZ1tL96IntbEp1gPNXb174f4T82sjP9WsuuX9rDSm/hv1Uxj+0pytx6UdMRR
         hFJ2R8ZU7pWmEZidN9Y10yo2tq1NxvZM/WOSJ3EY1+dnvix7Ak1u8FwdonjeOVv5ZdRL
         DxMnKkHgu7A4/1zFm+eSSNte8GgfTZUnT0YHyUp2my1cLBzE/DkHzKnpGwf8Ej9igoxd
         mZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3boceHdvwF+yl7uVwQWtms95Pe8vsglnDYg55Hv+Yw=;
        b=hZCnyS+acZg+h9AjlcvXacmeZciuhDCFY7k0RLnqHRgpgCWGqH7xmoWYAmOBiw/o5i
         Ns0onlKZ2A7s02R2NvYogG21XG/VXVUFLr/51F/C6VSJtJe8pf32V23tCZp3lkW3r8T9
         ajdkb7YTq1AP6Cef+Z+SgaRcjfRdZXlkKKhHoTILX7E1cEJ7FOaTA+mtstjkTjp6u2Lz
         Yaf0O5w57YTA9BeBg4jW5S6zjkk3vRw7U1PxdQ0Sat0TrzhXOmibFB8qqv3q9C4TfXH1
         Iu97BE3t8fOc+kP+gbvsFrSfbV2FvxvZCf7X4wyR6/Ag2RFcuqgGtyDzN5Vd/EgBbjKy
         SMPQ==
X-Gm-Message-State: AGRZ1gLC5JEbM4PMQoyMHo5Ljso2yP6guMezGbLdAZ7mzzSAK6A+h9ve
        E22q92vX+mC/fBkeoopssIOGDerM
X-Google-Smtp-Source: AJdET5eILoUbTN6JvEcV/PDNYggtOH5SVHzlAmRNqWnUypCZnclrvk9A5SjscqAqNTj18XMBVd5OxQ==
X-Received: by 2002:a24:92d5:: with SMTP id l204-v6mr1694124itd.84.1540491322529;
        Thu, 25 Oct 2018 11:15:22 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id t10-v6sm5198935iod.8.2018.10.25.11.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:15:22 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, p.zabel@pengutronix.de, denis@eukrea.com,
        rmk+kernel@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC v1 0/1] imx-drm: match ipu_di_signal_cfg's clk_pol with its observed behaviour.
Date:   Thu, 25 Oct 2018 14:15:18 -0400
Message-Id: <20181025181518.4433-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, thanks for looking at the RFC !

> Given what's in the documentation, I'd opt for it describing the
> edge that the output data changes, not the latch edge.  With that
> interpretation, the existing code is correct.

The clock polarity is reversed in Freescale's non-mainline fbdev code,
which we were using previously, contributing to the confusion.

Yes, I think your interpretation is the correct one. Let's double-check.

Suppose we set this bus flag in the panel/mode definition:

drm/drm_connector.h:
/* drive data on pos. edge */
#define DRM_BUS_FLAG_PIXDATA_POSEDGE	(1<<2)

According to your interpretation, this means we're asking the data to change
on the positive edge, and be stable on the negative edge. Correct?

then clk_pol == 1:
drivers/gpu/drm/imx/ipuv3-crtc.c:
	sig_cfg.clk_pol = !!(imx_crtc_state->bus_flags &
			     DRM_BUS_FLAG_PIXDATA_POSEDGE);

then DI_GENERAL bit 17 is set:
drivers/gpu/ipu-v3/ipu-di.c:
	if (sig->clk_pol)
		di_gen |= DI_GEN_POLARITY_DISP_CLK;

and data is stable on the pixel clock's falling edge, as we observed on
the oscilloscope.

All good. Thank you !
