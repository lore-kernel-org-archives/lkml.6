Return-Path: <kernel-hardening-return-11579-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225jRPJtcHySx+NCw73Ornda1IZsGr2ZcV44QcRSJPlWg/9/6MpVwejCrLjhpzbqItykpScb
ARC-Seal: i=1; a=rsa-sha256; t=1517763734; cv=none;
        d=google.com; s=arc-20160816;
        b=Xr7y5GvU0Gn+hPcsoWA966Leid64T+3MeihNobaFD/VCoL2NQFTvBIufjpKmjvNdaX
         vSmF5OO5PRxulx8PdHOB7hJScATVq9poB9NI+d+RCxKkJvj/tVoSJ+eS3cipyje1a/jE
         Dn6Nvw0svG6C7njshXNKWGIGxV1rT87+8omCG4qzd/lLmkiUbZgJANms9Y6U0BR6CKLy
         LBpVU9Q4aW338t3rCI23eoP+9B5YdMnxzbcemO/aQ1EG7KT+JVKM89TTmTTflbrGR1Jy
         JrVp76EkfqfJl6sglE+mxH/FugKnkwZ+nw/CMftvyWtQmFE0WgLDzBB7i6K6vCwlfnSW
         Xp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:mime-version:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=xVaqeGT6Hn/Y8WH62kl/yMqs607lSqFk+RZmDBP1hxQ=;
        b=qTymSfCqxadS1Hgiy4LPG3a9gnR0tBdRmA10CAttRUMSiVTt0w0rdddmFNdC0lYMUe
         N85dB462QUe9LWnqUuzOainOyS/CSPpDV5aKQyCkoVCaS3g2QDiPye2Q8wrTdhWSmEhI
         hr8AeTnPCi2i/qThenQfvuxFHkAJ9SDgoL5Cr90igelu0+I/n2/mTaJBDbZEWo7qbxoy
         3L23y0Qf+fkohpYlToXFDLX3UDW0iDHXhPll8UW6pHQqv6FA6KIC5W6Gh68f+0J8NrpT
         T7hHJFya8DKkBSgjKsXmY3Y+ONPPo9l0zarp0Ze1q1b4TxaVG5cXHkwtPRe8E19Bk+jV
         kT2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11579-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11579-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11579-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11579-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From: valdis.kletnieks@vt.edu
To: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] GCC release 8 support for gcc-plugins
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Feb 2018 12:01:43 -0500
Message-ID: <119189.1517763703@turing-police.cc.vt.edu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490625322246882?=
X-GMAIL-MSGID: =?utf-8?q?1591490625322246882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GCC requires another #include to get the gcc-plugins to build cleanly.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index ffd1dfaa1cc1..f46750053377 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -97,6 +97,10 @@
 #include "predict.h"
 #include "ipa-utils.h"
 
+#if BUILDING_GCC_VERSION >= 8000
+#include "stringpool.h"
+#endif
+
 #if BUILDING_GCC_VERSION >= 4009
 #include "attribs.h"
 #include "varasm.h"
