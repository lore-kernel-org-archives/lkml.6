Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1071428-1522070974-2-5667761133780245368
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522070973; b=gfrFCV3Yt87BsaGuW62gDdkxutV/WfLWahUTLCo5o7fhRIq
    mIeT2h5BF6eh0FOvivpaCmmzr6QBlgamPv8i6tE4rystIoBoGNQ5+QVc2MguDQtA
    mAkVKYR2jphJ/rQs2G0MarfGd+cwmHyKBVqzLzBflNHzPpjK7GuPKYq6VdB63k1M
    4WduS/1T43lzpZCediV2qMb1n/2HsGeo5j5CeSMUhDqkSz43lUXc1gPeaBj6JF7j
    qNNdelcCgwQhaDK6KY4jx+v0FK4E2HaxT6dGw6sTb3D00jHZ/0LDxRltPnjjcsvT
    eJRv4bzsNVSq1ySSZPuwUyNxOOADpyfNI2cJJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522070973; bh=aOn5BhMK6bIpx9a0k3X06W1jBS
    0p2Z9m39dwR0RZYXs=; b=AtjbmiozYy/ui20WD/lB8q1+MO+UqYqPCVNvQtNqey
    9Fxd6MozH97x4N0+mpEXe9/CsUfnlQ87/OQJ+gqBwLVLXjxaZbiGR+b5I3+l4HFt
    bfqOCDD1998G+X+4VZS2s75g9Nq+0E5GLEi7183Zp3eh+GjSXNOeifxs8qFknrkI
    hJz+p4DGtIHoJbr7JQmv+SBL/nOA5VZ7avRDNsVoReuwBDmsNr2/gT9wZpER4CuQ
    yiy03i1ZnMC6SYKB1AB8/r5fvhZ9ZQcCpmqRcfXnGZiAhwIjUrKb0i417xdVSq8T
    6QMnR1qK6husaUtlP4bEEUpUEyf8HaSDmu65iM4Jczgg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oN45CT+Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oN45CT+Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPT3j4+FzEvwFSlweZKUfaKY1hy25VUrxwfBWi68Mqiyi9QU2zH7jZcVfznQqgqHaqJuvwlj4feoQXaB0j/35c5rz9Nnc1j2Qvetznf8G7tN0SqyGZbv
    1H+ND7sKEkh2iXHfYvHOkVGc5HbGaKZBEXvBxU847QBjiI9DamLmRmtlk8of1I8E5PBxrX5YPUkJgGkakWWVF7Rtwiz7ek519HR2bwK90ujp6Ewc0TnqQTQC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=vQBBkBfzAAAA:8 a=P1BnusSwAAAA:8 a=iIJ2klduiM13sd8G9MQA:9
    a=WUt_NFmRvr_ssUr4:21 a=YivH8Aaw7B0n05WS:21 a=AjGcO6oz07-iQ99wixmX:22
    a=NGXS0kB0m_rannUenejW:22 a=D0XLA9XvdZm18NrgonBM:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCZN3a (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 09:29:30 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:43032 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCZN33 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Mar 2018 09:29:29 -0400
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: vsp1: Fix BRx conditional path in WPF
Date: Mon, 26 Mar 2018 14:29:17 +0100
Message-Id: <1522070958-24295-1-git-send-email-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a BRx is provided by a pipeline, the WPF must determine the master
layer. Currently the condition to check this identifies pipe->bru ||
pipe->num_inputs > 1.

The code then moves on to dereference pipe->bru, thus the check fails
static analysers on the possibility that pipe->num_inputs could be
greater than 1 without pipe->bru being set.

The reality is that the pipeline must have a BRx to support more than
one input, thus this could never cause a fault - however it also
identifies that the num_inputs > 1 check is redundant.

Remove the redundant check - and always configure the master layer
appropriately when we have a BRx configured in our pipeline.

Fixes: 6134148f6098 ("v4l: vsp1: Add support for the BRS entity")
Cc: stable@vger.kernel.org

Suggested-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_wpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/vsp1/vsp1_wpf.c
index f7f3b4b2c2de..8bd6b2f1af15 100644
--- a/drivers/media/platform/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/vsp1/vsp1_wpf.c
@@ -452,7 +452,7 @@ static void wpf_configure(struct vsp1_entity *entity,
 			: VI6_WPF_SRCRPF_RPF_ACT_SUB(input->entity.index);
 	}
 
-	if (pipe->bru || pipe->num_inputs > 1)
+	if (pipe->bru)
 		srcrpf |= pipe->bru->type == VSP1_ENTITY_BRU
 			? VI6_WPF_SRCRPF_VIRACT_MST
 			: VI6_WPF_SRCRPF_VIRACT2_MST;
-- 
2.7.4
