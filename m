Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29F0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FE120847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="kl6MziuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FE120847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeH2OGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:06:04 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40955 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbeH2OGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:06:03 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so6489834ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5hWH5cwcRqnlP8QBSgwyrr7XbkM0aTdIEsouUgxOgI=;
        b=kl6MziuDWeog/Wjr0DV4rb3rrVKfhFMJYw+iSCJUYXGkhUeEkkHWGaNxsNxAGDvl/q
         cCReVw3ECkC699JFd/+W03yoVntYtcWv1EAp48ClWF8RpJ7WbeIvVP/M6KRSGlt1GXJu
         rRgvvHGFOYFEU2QMorGkmB390+hQAVEqR/4ABlZjwKljmaT5O9VO3mrAu/+vjmuBP0Bh
         FZ3ZnNoP+ZYi6I+GZ1VMwWeNEe8hDdZmrE0V68RBjld4IdbI0yVFLuRPqDvpCPKwcj/5
         YVmPF1BXNpzip+O4EzgcEISwQCVCoolDFs6uIjz2kVBdQjnnmcb8zH/83ErClnuYZkwv
         JvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5hWH5cwcRqnlP8QBSgwyrr7XbkM0aTdIEsouUgxOgI=;
        b=s281vcyIQX1Y7M+KDue8bx8yWXDENuDEm5QoZi+YGYjSvSMQtoiNmXg/V/blX2kC8U
         ySqWJAnPlxPyvGsd38QQ1cI5R6aqO4e9ySOj33AxyiZw5KgxwtCQX7enmYv2DPHhLITP
         b9zaLXqCcSIarehGtuJsawdWMJWwZc65sE1siXYdAgnH14pofsyCdu4JfSv5gFLQMoMK
         OefQZMR0Q0MuQ0q1g1lmD2Y2Lvvi/DKdUq0qwTOfgXWZnPJg4CPZ4h7FdeUk/BUA/kGo
         OGKEmKz7FB5Lvc9DV2lYU4NZcaBd1Q28gH3diKYzdwNjUXRlJ9s2XRyOdYFzcukWzW8E
         FSGQ==
X-Gm-Message-State: APzg51AeCigmG1BrU8Kht96ZZPyaALBCMBveuoSXo5OE6V2LQp3sea9r
        oWDzkgxtFGuPX/NyPN82C9la3J/b2/c=
X-Google-Smtp-Source: ANB0VdZriADwfuav4jchmmAO260IMGAbpH2FKmZIpBn7BkxcINQkJ7JVObs3ikZk/8LKE38muM0ECQ==
X-Received: by 2002:a24:ac5c:: with SMTP id m28-v6mr4381774iti.120.1535537393308;
        Wed, 29 Aug 2018 03:09:53 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id v14-v6sm1721501iog.42.2018.08.29.03.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 03:09:53 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
Date:   Wed, 29 Aug 2018 12:09:29 +0200
Message-Id: <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the OCSSD 2.0 spec., the sector and metadata sizes are reported though
the standard nvme identify command. Thus, the lightnvm subsystem needs
to update this information on the geometry structure on bootup.

Since 1.2 devices report these values on the OCSSD geometry identify,
avoid this update is it is unnecessary and can also corrupt the geometry
if the devices does not report the nvme sizes correctly (which is not
required by the OCSSD 1.2 spec either)

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 5bfa354c5dd5..33ed09f8410e 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_geo *geo = &ndev->geo;
 
+	if (geo->version == NVM_OCSSD_SPEC_12)
+		return;
+
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
 }
-- 
2.7.4

