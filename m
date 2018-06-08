Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RJEVOciYGls4LwAAmS7hNA
	; Fri, 08 Jun 2018 14:55:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0B592601D2; Fri,  8 Jun 2018 14:55:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="PtJFgsjv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 850EF607E4;
	Fri,  8 Jun 2018 14:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 850EF607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeFHOzL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:55:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34979 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeFHOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:55:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so4321373wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4j077mPXsXrx+Eb/HyhwM5ZNbFZ8JfZTCdW3pP4zJTo=;
        b=PtJFgsjvZsWC4fJPAoMpF4WfXfX+nMpxtWzJaSsx8P1FxaK/63we1VDlHePyqBd4dV
         lG30eS1RZP6QkRduAyZLPcuKBVb+Vqr4oCisKM5WkO7vgSCwRdZkYUQR9J92KK+8yI4D
         piJ3SXl6lLQw7vdWW6Xc1k5e9eX0YcFAODZffmUVsRNI+7Ihnx8XDEiKrR/GUtdzKB2M
         v10xQA0jNpeGzZSYLIe8Kd39srCIWwE3KSfnjjPzcrwGj6DW84STsQEMGI/sRVvHs633
         biaJz6HIofFgChNivl86RhDiMaiSlyjhB5bxBNhNn0IRHjW+J/+j4UCfdzCxDbcQ3wGs
         g8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4j077mPXsXrx+Eb/HyhwM5ZNbFZ8JfZTCdW3pP4zJTo=;
        b=UNJF/7H4Wi6aKSpBOMm0fT4dc7X4PYsF8bAwQpFr0E81jh5VjbWrkC9VD6TgmckVE0
         51PQN6zDGQmz8Xy2LEWdCBTzodfgk4hjcq0nGjC+8/UC/knrdhKIGm6je+aA5S6QN1RO
         RwMbhChcYMDpN17e4WfCEdazMRRCijDjdIghFKdGSpCyLELOJuVJc9dAoGKIM09oNrPS
         bHwkXxi+aksUUg6BOoCBb3mMRiFVLB0Vg80l32aWuA2LnoHQ1SiRPQjL/JzRjbskg1Mi
         SzoNNUlz0cGIJJz9g7OPb220lCc7R/mz+yA69BGxfnzhtQ20ChPaM6wsRzF6ebDgEDaQ
         pIEg==
X-Gm-Message-State: APt69E0sCH9HOX16O//AqCCmowyMU8Pa/HQmZtvbHV/Q5qZD1R5D79ai
        qh7G5ctxDO/08c8PaBEuTH/ycg==
X-Google-Smtp-Source: ADUXVKKa7DcRJKnS/tIDJUmQ6ORApYqIyxwfMFJnLI0BfmRjIOI1lGWA0ChGBNOp0Vd79Pu4hwko9w==
X-Received: by 2002:a1c:dca:: with SMTP id 193-v6mr1731234wmn.36.1528469708944;
        Fri, 08 Jun 2018 07:55:08 -0700 (PDT)
Received: from avi.cloudius-systems.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id b14-v6sm50649945wrn.57.2018.06.08.07.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 07:55:07 -0700 (PDT)
From: Avi Kivity <avi@scylladb.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: [PATCH v1] aio: mark __aio_sigset::sigmask const
Date: Fri,  8 Jun 2018 17:55:05 +0300
Message-Id: <20180608145505.29063-1-avi@scylladb.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io_pgetevents() will not change the signal mask. Mark it const
to make it clear and to reduce the need for casts in user code.

Signed-off-by: Avi Kivity <avi@scylladb.com>
---
 include/uapi/linux/aio_abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index ed0185945bb2..cdf115b03761 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -106,11 +106,11 @@ struct iocb {
 
 #undef IFBIG
 #undef IFLITTLE
 
 struct __aio_sigset {
-	sigset_t __user	*sigmask;
+	const sigset_t __user	*sigmask;
 	size_t		sigsetsize;
 };
 
 #endif /* __LINUX__AIO_ABI_H */
 
-- 
2.14.4
