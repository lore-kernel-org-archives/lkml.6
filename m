Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155885-2-2462748073497519101
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
    1527155884; b=ScCKEKVDGNkRFQwAg5jnOtolKfHJ9jSjEuHJ94i7GO1fPDnOtV
    RRaMn50cdbN2ehKyIL+OyJxzROpFEYxYNkPsv6v9p50HFbQOcve5MT12oYtMoXHZ
    8rgcrnFuMiqDHDADj/PhEhGYznXxHv7PVD9c03I/clRpUvmpyn103qthgXooBnpU
    cQnH3SZS7uJRvLjb2rVhuGqrVMO6voivBvM+j9x9XS5SD8d0ofbbHmisjCzk8ShN
    B331VCAG9OEiXAc21CPWwIvLEnGei0Lgq8o7JxCzxNhcZFL9lTxxcLjRVPHx9Ac+
    ccNUWQ6kW1RbI/A3FAAu5kH6POpLRdAdC1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155884; bh=Coq6HrASfMDbFG1ZdB/bL78IV+1IcB
    SYHQwLg+AO2Kg=; b=C6P9cVoBLrTWVTbgsVNqg7ff54b9ou3aAUZCxz86OTWr48
    j/2j0Orl3YOs+Dz9DmchFq4WKf+QwhoM4Xsg3xjQIVgmrvLEFWDjhEWAzPUU3KWo
    Q7OxiRXeEaAAqH2fuv0Y3GLYaHM/Iu29Ae4IVb507mXU+0WfsTw2wo3hNiK5T9ka
    GAuP15o3+anX1NQBQCYLBDpXoJXoVBNQfAcgyv1Pjb+0sR6MRfQEuxzu2k9PQb95
    IvwEyLfKpY5Of9cEvuL/b5xNuFVuiex7BI0HHuBEpG7d28Avo8tNlz28M9xO/BVm
    99RQFijc/Ncy5NdaT8muozOwT4NmvRnyoOt1DRdQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=nktLfzvn x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=nktLfzvn x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJkbDntCm5k9lzlhppi1bKrOiekvO9z5GUwwUH+y7FoptFFcd9pWNExC679JAbLjXKvRBCjrp8+apKgFPXkMhoO5uN1j10wG3wwOs049qHU7RlDTYJLu
    WkbogFBBwC8UP2mTR2Kbc01KWqVBfzT4ICZhxIz7Od2UKg+XdZo0cuYgYjD+5TunO/P+NjvFHdsO8rJUaNLbPbawu1V+3h/q3QUhcWQUFX2GFySSReYRs10m
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P1BnusSwAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=Vm4PyTQkU4XbjhRmH8IA:9 a=ImxaVKh6NTYabYR_:21 a=7i-VzYy7KgjUr4U4:21
    a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030527AbeEXJ5z (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030526AbeEXJ5t (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 145/165] media: v4l: vsp1: Fix display stalls when requesting too many inputs
Date: Thu, 24 May 2018 11:39:11 +0200
Message-Id: <20180524093627.941751796@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -504,6 +504,15 @@ void vsp1_du_atomic_flush(struct device
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
 
