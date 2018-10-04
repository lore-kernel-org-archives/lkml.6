Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B67C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCDE21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="NUD7ExLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCDE21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJDOFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:05:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37415 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeJDOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:05:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id c22-v6so7579478edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=up+5ED4Mpzr5vSusGgWNBwpS2FQKw1fBwECZSogBjEg=;
        b=NUD7ExLPFVk4kCIxCCe10PPUY/XKPqL/xdRlz0c7w+2L9M8tH5z0GiLozoGfl71AF3
         UdOsHaqIiTvBRI5z60AHclil0MuJcuP/qh48tr3CMZnuXUsZphaf9SXh5FjUa5MR6s4l
         hKkmURLBpMh922UXcB+KM1DPHHnql9WyRcd8mTnihTbmNgod34gcGByHZeHT82V4T1KO
         7gI6rNtjT64w0134NxxOLHna+4acIJFcUleSpfqQEh9XmdZvl4suIbMyaV4cepBoHprT
         W51YdyvhFoNPhNdw9AkJph5s1pPW02/8mikg7NRKSsgESGxiKPNke253P//q3TEmdynM
         mcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=up+5ED4Mpzr5vSusGgWNBwpS2FQKw1fBwECZSogBjEg=;
        b=lkVaNVTWVzTrnQs03lsQ0NtrRmbS4D3Dq5mkRDnCfuPVKODfOait4f0yjunXcSdnrh
         2iaWfI1o/YwwMDBf2dkFPv0hGlxYNkY6HEJ6JmbIB36JhDR0bRzXsJF0zVzCvfhpz7Vt
         Z0PP/sxir5lCb1LBygVWlmNw0M7nmPAKZZh2jT9hz0NOOYOK4iQjuJsANU4+PAqRzlDW
         qKNSl3hgfQaoOKVcvmM3tPwV+tACQK93bVj1C10s7CNE/IeduKfH0PlR4McZOxB16HDq
         jyYF9Jdg0852QfdfiBqiq52AvjIkXklh7B1Y7MHf1HrH11ksF9Rvc2UM55VlZ+2c8Jqu
         fraA==
X-Gm-Message-State: ABuFfojA5PiKPSiBo76zY29tMDwfO65IC3NDTm4N1S1RTpHevNjgl+Mm
        VrfqH8EQU71lNOf/68tqdxGWwA==
X-Google-Smtp-Source: ACcGV60zS8zG1jODqOuTElp2NBBPs/fWL539VIsqpd/AgZOgMEeUj7VZ0WFTnDGKlJtoOXl2CcUvcQ==
X-Received: by 2002:a50:da4f:: with SMTP id a15-v6mr6914629edk.62.1538637243414;
        Thu, 04 Oct 2018 00:14:03 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f39-v6sm1297462ede.75.2018.10.04.00.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 00:14:02 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/2] lightnvm: pblk: add helper for printing chunk state
Date:   Thu,  4 Oct 2018 09:13:54 +0200
Message-Id: <1538637235-25469-2-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
References: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement pblk helper for printing chunk state.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0f98ea24ee59..34c9c1dbeed9 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1218,6 +1218,15 @@ static inline int pblk_io_aligned(struct pblk *pblk, int nr_secs)
 	return !(nr_secs % pblk->min_write_pgs);
 }
 
+static inline void print_chunk(struct pblk *pblk, struct nvm_chk_meta *chk,
+			       char *msg, int error)
+{
+	pblk_err(pblk, "chunk: (%s: %x) s:%d,t:%d,wi:%d,slba:%llu,cnlb:%llu,wp:%llu\n",
+			msg, error,
+			chk->state, chk->type, chk->wi,
+			chk->slba, chk->cnlb, chk->wp);
+}
+
 #ifdef CONFIG_NVM_PBLK_DEBUG
 static inline void print_ppa(struct pblk *pblk, struct ppa_addr *p,
 			     char *msg, int error)
-- 
2.7.4

