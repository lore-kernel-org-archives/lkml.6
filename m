Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1323216-1518182316-2-9269931427005042012
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518182315; b=Z9yhF8BJ6wK+o/x2kHZ3fYufKIGZb0USCETuNISS8aCdgil
    uoHLa34JpRkX4bYdYoSaV2G3tzHgK1dughENW4wC94dFVduT/JvUi3FbljBcRuwd
    /2DVrx+hS7rFVu3Hhzl9V86iCc+899uKMEOnBcqG08a72FdnVFPDI0wPf0Vs60aC
    Q8bC/nRvojrTPfidL1ZxIDs10Ya6O/B08YAygsO7f5iJdcYqE01cLjiPhjNrelV0
    QUmKddESRyH3hfzdCiVN4FjMSCuxV4MS4FRCwbGvG1B7PE3Xmwni4Hkunc5/KujH
    wm7yLb7auHrNIc3Mbh5uowx7j2ZGBJ081T6JrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518182315; bh=hqpDr5SJZDWfoiE+TZVEDVlVt1
    fQzrJlWymaJaYOgLM=; b=PiEK/YwGYthzlDgsY+JgMwyypinzTEgE9aNe60n3tR
    fPLMianXLyrgmkS3F7Hy1vK70QRSxluLo8iY6HOKnSJijSvWmy8xMG+yo8aJGrfp
    K3Bf38WbYFN6KLWKXEX+wPo1wfjzPDQ7ODBNaLOVaH2Hoyu7e61+4O8pYzCJRW/0
    GybCXezb1CJl8Np3MMglOVtJMNCfPksGslyBo4XXfaupMHGC/J+UcIK9cxAnUX2i
    Wx6hjw02Owvm34i6R1PMh6gnjuP8D99NbN/vOt00viThE4n8tvyeyuTEUxkx6zGM
    0/734j+YRxZKlpNV7JqpYBW3kpFaDZ57Qz9LkDC4vunw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbeBINSc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:18:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbeBINSb (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Feb 2018 08:18:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8993E2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=kbingham@kernel.org
From: Kieran Bingham <kbingham@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "Stable v4.14+" <stable@vger.kernel.org>
Subject: [PATCH] v4l: vsp1: Fix continuous mode for dual pipelines
Date: Fri,  9 Feb 2018 13:18:25 +0000
Message-Id: <1518182305-17988-1-git-send-email-kbingham@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

To allow dual pipelines utilising two WPF entities when available, the
VSP was updated to support header-mode display list in continuous
pipelines.

A small bug in the status check of the command register causes the
second pipeline to be directly afflicted by the running of the first;
appearing as a perceived performance issue with stuttering display.

Fix the vsp1_dl_list_hw_update_pending() call to ensure that the read
comparison corresponds to the correct pipeline.

Fixes: eaf4bfad6ad8 ("v4l: vsp1: Add support for header display
lists in continuous mode")
Cc: "Stable v4.14+" <stable@vger.kernel.org>

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_dl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_dl.c b/drivers/media/platform/vsp1/vsp1_dl.c
index 8cd03ee45f79..34b5ed2592f8 100644
--- a/drivers/media/platform/vsp1/vsp1_dl.c
+++ b/drivers/media/platform/vsp1/vsp1_dl.c
@@ -509,7 +509,8 @@ static bool vsp1_dl_list_hw_update_pending(struct vsp1_dl_manager *dlm)
 		return !!(vsp1_read(vsp1, VI6_DL_BODY_SIZE)
 			  & VI6_DL_BODY_SIZE_UPD);
 	else
-		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index) & VI6_CMD_UPDHDR));
+		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index))
+			  & VI6_CMD_UPDHDR);
 }
 
 static bool vsp1_dl_hw_active(struct vsp1_dl_manager *dlm)
-- 
2.7.4
