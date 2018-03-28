Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522260937-2-15632858636947266687
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522260937; b=w0kuGUjZLJ6dqwL4VLdvNsQ/cUEv2DsnD3AdI4Ji3UVmASO
    Nnzm8J/gSsXrKNz+9N4nbpqRO604uqxsfCI2I+r8XzFWVYvJWjWtZQ8DjV7Gb0/b
    7NMxwgrgIl0xZ/Nd8Pzwa38JpPwG8RXmP5MaMLJA+mtMUxY6QyfFAy5d3x0MY5at
    0HGPcp4UMySHMJeKyaUhRPnuDGg0U/0SO0zVNo05OTBzy+b0DNztloJv4sOwwmFF
    tdlVJU6gWnR7rgaIhhguGAGn2zK6Szvbs5O0lKo1SWEpEtxfzCUOaCKgD4vdRy+3
    cXZCHLL6tAR+kCerHOdX4dYQqXEdqQygWaTHxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522260937; bh=zI3cdmuTY09X4CWDoMRdovckJSIp9NtEHi5
    auKePyck=; b=jvq1JIjrHuyEYmNXAyk0BCZs6XBBZsTZV6RZ25xAe9VWX4t4mei
    +CbwvbAZZs0dILaHTKN8fZ654brG1yYh1kS+1e4K3wvlTEvHxUUavrS6/xZthOdQ
    Plx5CC7WtDD75LSCb7g60BieElUtx2Iq4clvyN6UAjIR5ffLB/WuswkIr3toEmR0
    inqcb+MaroG/Aw+s8lQT1u9/S2l7CdfweeqRdlj5Pp+ARy+oPpE+LRkXedL1vDdv
    X+dBKg18dTRGwh63FAWl4TOG/JuNE7iJ9gVuJFhtyTA4E1SIEJsNX9syRXRXfJom
    uCrIDb5xg/zyz8mGadmuP3Z2+HbfRmo5bBw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIF8lKg73iNuGTzmqBqgNfw7JO36NIQIF8ZMG1X4pzGL//L99WQ+IO1DWYIvBRB8Zn4F1aD9N7bKf8O9Nfrb4pJWtM6JiqqjORDTYVz5ZVKgoNirtJMj
    IUD3Bo7GikcqAQfOYpMM/f/km7omc4y+EYcPZbh+BcnWGNgHO0b2DmlalAEVrjgogvpemBtr9x2KKenix0+0gE3xR2ThBbq0OIeygcnGVHXWgcVgPsC2xDn9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=pGLkceISAAAA:8
    a=AUd_NHdVAAAA:8 a=hD80L64hAAAA:8 a=vQBBkBfzAAAA:8 a=hCT99OXvQAhqnHGAo5IA:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeC1SNQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:13:16 -0400
Received: from osg.samsung.com ([64.30.133.232]:61617 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753130AbeC1SNM (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:13:12 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Ricardo Ribalda <ricardo.ribalda@gmail.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH for v3.18 16/18] media: media/v4l2-ctrls: volatiles should not generate CH_VALUE
Date: Wed, 28 Mar 2018 15:12:35 -0300
Message-Id: <1663cf48e2eb96405c5d6d874020aa9925ee217f.1522260310.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ricardo Ribalda <ricardo.ribalda@gmail.com>

Volatile controls should not generate CH_VALUE events.

Set has_changed to false to prevent this happening.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 3c4e22855652..2bdb2a3512a4 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1619,6 +1619,15 @@ static int cluster_changed(struct v4l2_ctrl *master)
 
 		if (ctrl == NULL)
 			continue;
+		/*
+		 * Set has_changed to false to avoid generating
+		 * the event V4L2_EVENT_CTRL_CH_VALUE
+		 */
+		if (ctrl->flags & V4L2_CTRL_FLAG_VOLATILE) {
+			ctrl->has_changed = false;
+			continue;
+		}
+
 		for (idx = 0; !ctrl_changed && idx < ctrl->elems; idx++)
 			ctrl_changed = !ctrl->type_ops->equal(ctrl, idx,
 				ctrl->p_cur, ctrl->p_new);
-- 
2.14.3
