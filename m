Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D26C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7223C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="S4S7ZPVB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxSq830o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7223C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeKPI0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:26:45 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59835 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbeKPI0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:26:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D93C23174;
        Thu, 15 Nov 2018 17:17:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=mesmtp; bh=IZYxCftFemGWl2wFyTdCQGD
        Z2De25PDU9vVwfWgX7ig=; b=S4S7ZPVB95OlIhWqRfdiHyJYVMZL2KGrsPWNF7K
        K+4A//g5AyUcnUsdgjPRR8Ffuchv7x1sUN7GBDu11G2vMGxmrbiTOCjWvAeSwZnI
        D6Hnb7BKjXCuFfVDMbFn90kFf6m0ehgxxXFF9CaHYIq5oBj/PQIZwd/cbZeK/hFd
        1vbM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IZYxCftFemGWl2wFy
        TdCQGDZ2De25PDU9vVwfWgX7ig=; b=qxSq830oSg3YFPBHuGLYwKqAfxWEt8C6p
        LBn96QEp9EXsRVYS9l37/dN6st6ZNPo5yTj+O/zTmrTZC4m6c0TYgaDJDp4AH/2w
        7rqvBGTZZIWtiK4VHuEAIshfO8d6lq6NGu9WF4soNp8PQqaczLwuoK7oVc3hXTQr
        AxvY36FyrFz5BPyEF5xdFaF6yq175Fabt5TokR75Tfpm0kehPq6ScKjJSn3txEux
        B2y0CWNxBY51N1s7lXHXxU6rFXRPWt90Ouned43QUPFADkrIMwtTXF0QVV/g2cYm
        +esbDBGMrz4UlIR8P89n8CIkuE++5cTlnFreCYvziYXBOx7uX5IGQ==
X-ME-Sender: <xms:WfDtW2f9cg4OYmJKo7LaVQlvXv_akGsCbRRH856bD3P_qoOPcaJVBQ>
X-ME-Proxy: <xmx:WfDtWyg9E6XaiLfeS4vnfM7fEd6ACh_4RzsBDEy-f7w6Qbvu3yEO0w>
    <xmx:WfDtW2QCgdcj-sZik789wPc6ihe0oCc7pzOLtToOcoM-JjUVJIICPQ>
    <xmx:WfDtWzhgDn9a-4FwHNNsSGUSi3xHn5HQQUHNAciwvd5li7pM4tzQtg>
    <xmx:WfDtW27DkrGdv3TRA2NY6UWOt84BIfvjDzpJZiPqTkLGH3q8xUvNiA>
    <xmx:WfDtWwCLCw9F7dnrZxBy4QK8MSH8HjJxIGbvF5zllS07SAM12tIAIA>
    <xmx:YPDtWzLKGGquh1wpa7-4vZIpUwRS1P_lLEGGPi5PZ2-OQ64-mw-QLg>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2AFB2E48FA;
        Thu, 15 Nov 2018 17:16:52 -0500 (EST)
From:   Fernando Ramos <greenfoo@gluegarage.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH 0/9] drm: remove deprecated functions
Date:   Thu, 15 Nov 2018 23:16:20 +0100
Message-Id: <20181115221634.22715-1-greenfoo@gluegarage.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

One of the things in the DRM TODO list ("Documentation/gpu/todo.rst") was to
"switch from reference/unreference to get/put". That's what this patch series is
about.

In the past year or so most of the functions had already been renamed and only a
few remained, which are the ones I fix here.

In addition, now that all calls to these deprecated functions are gone, this
patch also removes their implementation and the coccinelle script that takes
care of them (which is no longer needed).

Anyway, this is my first patch and I'm sure I've done something wrong. Please
let me know :)

Fernando Ramos (9):
  drm: replace "drm_gem_object_unreference_unlocked" function with
    "*put_unlocked"
  drm: remove deprecated "[__]drm_gem_object_[un]reference[_locked]"
    functions
  drm: replace "drm_dev_unref" function with "drm_dev_put"
  drm: remove deprecated "drm_dev_unref" function
  drm: replace "drm_connector_unreference" with "drm_connector_put"
  drm: remove deprecated "drm_connector_[un]reference" functions
  drm: remove deprecated "drm_framebuffer_[un]reference" functions
  drm: remove no longer needed drm-get-put coccinelle script
  docs: drm: remove no longer relevant TODO entry

 Documentation/gpu/todo.rst                   | 17 -----
 drivers/gpu/drm/arc/arcpgu_drv.c             |  4 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c |  4 +-
 drivers/gpu/drm/bochs/bochs_mm.c             |  4 +-
 drivers/gpu/drm/bridge/tc358764.c            |  2 +-
 drivers/gpu/drm/drm_drv.c                    | 13 ----
 drivers/gpu/drm/etnaviv/etnaviv_drv.c        |  4 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c            |  4 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c        |  2 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c     |  4 +-
 drivers/gpu/drm/tve200/tve200_drv.c          |  4 +-
 drivers/gpu/drm/zte/zx_drm_drv.c             |  4 +-
 include/drm/drm_connector.h                  | 24 ------
 include/drm/drm_drv.h                        |  1 -
 include/drm/drm_framebuffer.h                | 24 ------
 include/drm/drm_gem.h                        | 50 -------------
 scripts/coccinelle/api/drm-get-put.cocci     | 78 --------------------
 17 files changed, 18 insertions(+), 225 deletions(-)
 delete mode 100644 scripts/coccinelle/api/drm-get-put.cocci

-- 
2.19.1

