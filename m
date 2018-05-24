Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156388-2-12371559761266601972
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156387; b=E4A7/ahGNqyjwalCNVoW2NOBGAUaxaPoMZjFXBEz6f5yseXDjx
    BXlmdBOnNpAI6D08+yHr1ZR4CILo6SVzp7nZw+p4GYa91FnJZdgvnAJvJ/Jxr8zP
    K0CbTUl9qMmCG9LVHfZPUymAyNGMlOrotzsRV1oGSChv5oXF25v2UpLJPUa/5BVt
    4/XjzOQXkmm/6GxP1cSQib2Li5xTfpssw6UZ3UT69nI6F6PaSkrydQ4uhnzpHiQr
    A0SGWzkkDG2UjcopD+gmr9RgE31pHR8OyECTeY90Zsnk5k697VrXVdMxk+AMAU/3
    Ssqq8xHtqrK9FLMwFHu6ice4YKuVMHcmBFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156387; bh=riW6Epxj6DOS9Pqj+o1MFJbMdcx8Jd
    9ckDtMUcv9Uf0=; b=DM6Kg1zmItM3AHkxZoAdSy/nNp1/Qm1Rdf4JsrnLhaWdtJ
    jxIscplY59OqcvCP8EFba9EbX9z2auNoleTi/niXLQDm8DmghDOEUFyeCP/vBojr
    UVppR1KX03aFrN1jEQUvv7V1G+VEUZbbmWDit2wgAT+WqkdjhscyHSQ3q6ubilYj
    GfPxzMz98qGlB6ezkKvc4QNC9MyaKk7xZ7a7+7WdS018iboOxwWVzk6mG+QnKI8Q
    j0kWoLxkdFPcy3BcTKX7lt3KdADkqHcyPBLAMyHZQ+dn6q9bOw2Bg1u+ucb4/hq+
    uN9GPJbc4a3KbLORtTadcxbQEs54yb7h1wIIDedA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=O6coU3ZE x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=O6coU3ZE x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCCD5ZlyOvcLckwZQANnYNLVna83BQsLyYUFUh81WQBvon+yiGjFizxUqYA90lo/kA7rQrG0dsAS5yROqhyFl1fjhe+pZEUVJFXSi87UZzdp/ZijWO10
    STxlbWOpXL3yLka29KA8ayvPZjRINVAB7B0wGfe/lkBqQa6PE7YTwTuYCpt7joq/y+rxP17YOlVnBqF0rAP8MBayUvaFabBFbDbvihes1L2uQG0sODrrP+Us
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P1BnusSwAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=Vm4PyTQkU4XbjhRmH8IA:9 a=S4BvozYCWri5y0aB:21 a=7i-VzYy7KgjUr4U4:21
    a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031710AbeEXKGX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031705AbeEXKGS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:06:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 140/161] media: v4l: vsp1: Fix display stalls when requesting too many inputs
Date: Thu, 24 May 2018 11:39:25 +0200
Message-Id: <20180524093035.126474183@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[ Upstream commit 5e3e4cb5e24b92773b194aa90066170b12133bc6 ]

Make sure we don't accept more inputs than the hardware can handle. This
is a temporary fix to avoid display stall, we need to instead allocate
the BRU or BRS to display pipelines dynamically based on the number of
planes they each use.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/vsp1/vsp1_drm.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
@@ -530,6 +530,15 @@ void vsp1_du_atomic_flush(struct device
 		struct vsp1_rwpf *rpf = vsp1->rpf[i];
 		unsigned int j;
 
+		/*
+		 * Make sure we don't accept more inputs than the hardware can
+		 * handle. This is a temporary fix to avoid display stall, we
+		 * need to instead allocate the BRU or BRS to display pipelines
+		 * dynamically based on the number of planes they each use.
+		 */
+		if (pipe->num_inputs >= pipe->bru->source_pad)
+			pipe->inputs[i] = NULL;
+
 		if (!pipe->inputs[i])
 			continue;
 
