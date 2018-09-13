Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857D6C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E302133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGrLBZQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E302133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeIMHSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:18:35 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:38023 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeIMHSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:18:35 -0400
Received: by mail-io1-f74.google.com with SMTP id n17-v6so2793112ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a7z2/GVC0GewoLAOj0ejoiGO7k0hgtIwfj4eCBu18w4=;
        b=jGrLBZQii+9GPVTGTz9sJJOGeoMtb8ANE4IY1JLudPEZQeUkKprISz1XND9ujd8HEd
         xVUszgnKIARu6qtDhF1nwj1AXunoZuNAnrDUunTAq0/jCPb/iXtBpXSlmcL6UcaCvkhZ
         jjw0UzJl5ar/pIvLbvjHzJ4bu4ECwYKlpL3rtvhXAsQe1W3ulSqLEvqGIojiFk2Bz8aG
         VD9aatOuKNhNm7PRBkVkPor+yo7drmkA4ijfiEoZ7eskiKrTRxMDDxHWuKcAK/FNZGOn
         0VPQyozGSHe8h3YHNFspVBMYAY98Q6EwKzc85r2iHhuXI08b9eRPZCXR8ZsqDQ51sr+r
         V8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a7z2/GVC0GewoLAOj0ejoiGO7k0hgtIwfj4eCBu18w4=;
        b=ao1fFYLO1AhpFP0B7yczsTy4kJsD0bEYpZIZjBwM9jxctvS5JrQPlV98NwaMPkuAIR
         yqk78gSYSGMcwc3IDAe1KWlrlXJWa0MnA1nAWkDzUeaZtCkZ8Yrdw0KWlt67HWR4KGZr
         YA/pX6peqNLtPcO+vHF1TC0aiklEWVNVv4fiRWX4ySZRD8jNl07aiFGys5xJ1al48vCr
         tK60CETBUK2JuRY7dIjr/xK2iaJUoNkPg4mrsmXbxm1Ts3sjW1pF9gOgA3/NDOzAPneg
         gZ1SYtakNsW6gxFsI3asv9CpjkoPG7fYM0s4kuKI1AshouXJ9QvyRK8wG6VJoqUZwDVC
         gc5A==
X-Gm-Message-State: APzg51BGDge9oZJJfn2cFG2qxmg6RloFUyHq7rHLo66vnIWEM6gHqrYx
        rNzvL4otPZXco8H9AFhSHLhk/mNc9Hs=
X-Google-Smtp-Source: ANB0VdYv0PyMNckBneXsSawlFTyQAyu0/pgn3LyNjVO6SIS12h0m895hTI8+fHEcr74Xs3XDFpB3QE5HfQk=
X-Received: by 2002:a24:9d43:: with SMTP id f64-v6mr4180845itd.17.1536804678091;
 Wed, 12 Sep 2018 19:11:18 -0700 (PDT)
Date:   Wed, 12 Sep 2018 19:11:12 -0700
Message-Id: <20180913021113.18150-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 1/2] typec: tcpm: Do not disconnect link for self powered devices
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        Badhri Jagan Sridharan <Badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During HARD_RESET the data link is disconnected.
For self powered device, the spec is advising against doing that.

From USB_PD_R3_0
7.1.5 Response to Hard Resets
Device operation during and after a Hard Reset is defined as follows:
Self-powered devices Should Not disconnect from USB during a Hard Reset
(see Section 9.1.2).
Bus powered devices will disconnect from USB during a Hard Reset due to the
loss of their power source.

Tackle this by letting TCPM know whether the device is self or bus powered.

This overcomes unnecessary port disconnections from hard reset.
Also, speeds up the enumeration time when connected to Type-A ports.

Signed-off-by: Badhri Jagan Sridharan <Badhri@google.com>
---
 drivers/usb/typec/tcpm.c | 6 +++++-
 include/linux/usb/tcpm.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 4f1f4215f3d6..a4e0c027a2a9 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -3270,7 +3270,11 @@ static void run_state_machine(struct tcpm_port *port)
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		tcpm_set_charge(port, false);
-		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
+
+		if (port->tcpc->config->self_powered)
+			tcpm_set_roles(port, true, TYPEC_SINK, TYPEC_DEVICE);
+		else
+			tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
 		/*
 		 * VBUS may or may not toggle, depending on the adapter.
 		 * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 7e7fbfb84e8e..50c74a77db55 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -89,6 +89,7 @@ struct tcpc_config {
 	enum typec_port_data data;
 	enum typec_role default_role;
 	bool try_role_hw;	/* try.{src,snk} implemented in hardware */
+	bool self_powered;	/* port belongs to a self powered device */
 
 	const struct typec_altmode_desc *alt_modes;
 };
-- 
2.19.0.397.gdd90340f6a-goog

