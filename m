Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A1C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97720218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHwd77B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfAXSHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:07:47 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:44459 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbfAXSHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:07:43 -0500
Received: by mail-lj1-f179.google.com with SMTP id k19-v6so6050506lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tjMXrhI4SQ+brncYCMGz3khd2K34m9mAQPJLSGNTKiU=;
        b=UHwd77B6TWamXj+SgO085iAtcURGIJKeTyjep2yXVn3I6Q52iqv1RftB6+vejz8I62
         DvRhdXHAIFiaWO8Xh6TsgbGRGpy5lxzCzHTTY9mN6C0Dwf0WdlmApTSx7dVEm1c4cuQU
         xCf7hC0rlYWJjqbe8qbxXducPg2bE6NbklzjejoWkGRJxV5h2ByuS3p0cPeB8X+82JzP
         MUffBChH0cX/LOTEl3uFRZmgO3HF5i6AODxMoPqZIwmOaKWJDZVAvbSWJA+MJFpeSuo1
         xkDmGQZaVBhUPFC/3fuP/aEcYOkWY/+hqkYXK4M2Pu6id4WyjkNMb9T28Rgp76W2FsTr
         mXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tjMXrhI4SQ+brncYCMGz3khd2K34m9mAQPJLSGNTKiU=;
        b=Od9JGJ61BmZFZbNad/ApRYTwN2yG3I/8LLif/L7lpCljbXCeg8i3KW1vKsMFKdpPwX
         TGVSEBDSf6uad1UlvEMCFMvesm/KARt69aVaN0PO0bJOhU5k1/8krnWYfZEQZv2RZrL0
         1snGEh9Nv/ttEYPZyU147YNWiaDC/aHAY+Sx2V9yLU8JgIp0oU3Y3biafhRbN0BTFnLA
         8K6urGzXB0QKzbOiOIfcb1u1GOT2eRH8PRxcCMLlBtG2r6MV0IT1Qq/cweXqbHNI8038
         5x7YmfKWCuOesKs/esM5RhnTmGir5QVjnu9/FddH+sDEkD41fuDz9tdT12oklpHGGB8X
         0cGQ==
X-Gm-Message-State: AJcUukcVt0cM/Do+ioJSHcd3Dz5rWuvDx46xDJ/dSjEp4k1WbTPgS5M4
        Fy1H0uT+E+OecO3PF2Pjge4=
X-Google-Smtp-Source: ALg8bN6TDkLJ+RpIU8JfbH1QTlGKXPhSFO/+dIsRqHpRZ/d5DiORco9nkp/F5g/9BKMqxBIzhYhAdg==
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr6806883ljh.174.1548353261281;
        Thu, 24 Jan 2019 10:07:41 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id q67sm1082157lfe.19.2019.01.24.10.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 10:07:40 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 185C1460419; Thu, 24 Jan 2019 21:07:40 +0300 (MSK)
Date:   Thu, 24 Jan 2019 21:07:40 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH -next] rcu: rcu_qs -- Use raise_softirq_irqoff to not save
 irqs twice
Message-ID: <20190124180740.GD2332@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_qs is disabling IRQs by self so no need to do the same in raise_softirq,
instead we can save some cycles using raise_softirq_irqoff directly.

CC: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 kernel/rcu/tiny.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-next.git/kernel/rcu/tiny.c
===================================================================
--- linux-next.git.orig/kernel/rcu/tiny.c
+++ linux-next.git/kernel/rcu/tiny.c
@@ -65,7 +65,7 @@ void rcu_qs(void)
 	local_irq_save(flags);
 	if (rcu_ctrlblk.donetail != rcu_ctrlblk.curtail) {
 		rcu_ctrlblk.donetail = rcu_ctrlblk.curtail;
-		raise_softirq(RCU_SOFTIRQ);
+		raise_softirq_irqoff(RCU_SOFTIRQ);
 	}
 	local_irq_restore(flags);
 }
Subject: [PATCH]
