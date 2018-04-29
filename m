Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3412597-1525003619-2-15232916385059977427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525003619; b=O2fQHsAcod5FjAQv5tH/ESyeZkTUFnMBKJC/DZHKKoHjYcoE2I
    scjkv8gOR0/uxK2vCCv8w9nkI9dJW/5yfVCzVjAEo7KfVXcBepE9UakZ1J25GaKU
    MUagg7Vc1swxvSG4QiWNJCKZ3bzgup01qCbmdcFhpnbbBUNlNWbsrhcuOFQNl1LX
    VMeqDXCFLDYRpWuIVLBNa4Gzt2BvN7ihWv6nitehTipQgUlZYjQE3k6z3HEgKeUS
    GSFraQ50lWy1OA8D5tX3q2elxwnosFYtrmI/LcgJMVJEBE9Yh6HhOYFjWAzyNF72
    ElYISrA1KMP9lH2+FwQJO7meB+YRLwcpo/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525003619; bh=vvX2P
    o9bTwZ13T3zdRgEHezPRGYK52D2IgnGW8a3oHU=; b=WZX8bCD3ScZ+GWfjGuL+l
    UhzySNpMSTcp0UwgaM1BNNmIbrz8nchTgz68rzhl9J8PBVMYEC7ovuC63kBJOfxm
    UlJY2rAYW5bm3JBalcXgW8hcxsiNl1YYFJGOv2NbQlSAefubuwMuZe+5ma5KVhWI
    s5JwkBqxxWI+pYEM72eIS5RMys3Cvq8VhdvChV8IHNVCAibDI88p3vDf/pBR8lvE
    +OVkgB6MUIhFMPGNGc6rdo//GEyqOizTEYvef5wvj405qBJMwkiazEqrybF25I6W
    B63AzOJ1jJIUiZE273LCc1QodPJndarV6IxrjPjacwWTSso8Vl+EON5CQgQIkZiY
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE+ZgniIMIaaQHP4ahL1NZ7nqaXZtjbz2jKzZAYg6WsdmCcmCYpLMa17Vg9YX+AqEKFr4n4/0yW6+adaJUkEeAvI9eAVKzSctl6ZiNc1/tpOVCX2lr6s
    XuNvPKY09FeXefytIU52BRJUtH012sPwgFpq4szSx7JVAxJHdhOd/PpQ/kNiB4hm+EHAhVcP4EQ2QucDe4QPVubigbNX2c+uKjfrb70gd0swizPC8FFU81t2
    H4MQpHhGRn1ESREE/caMLg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DfNHnWVPAAAA:8 a=DDOyTI_5AAAA:8
    a=l9oGLDFQxp-hUUcOClwA:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Alan Cox <alan@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] media: atomisp: fix spelling mistake: "diregard" ->
 "disregard"
Date: Sun, 29 Apr 2018 13:06:47 +0100
Message-Id: <20180429120647.10194-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in ia_css_print message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../css2400/css_2401_csi2p_system/host/csi_rx_private.h         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/css2400/css_2401_csi2p_system/host/csi_rx_private.h b/drivers/staging/media/atomisp/pci/atomisp2/css2400/css_2401_csi2p_system/host/csi_rx_private.h
index 9c0cb4a63862..4fa74e7a96e6 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/css2400/css_2401_csi2p_system/host/csi_rx_private.h
+++ b/drivers/staging/media/atomisp/pci/atomisp2/css2400/css_2401_csi2p_system/host/csi_rx_private.h
@@ -202,7 +202,7 @@ static inline void csi_rx_be_ctrl_dump_state(
 		ia_css_print("CSI RX BE STATE Controller %d PEC ID %d custom pec 0x%x \n", ID, i, state->pec[i]);
 	}
 #endif
-	ia_css_print("CSI RX BE STATE Controller %d Global LUT diregard reg 0x%x \n", ID, state->global_lut_disregard_reg);
+	ia_css_print("CSI RX BE STATE Controller %d Global LUT disregard reg 0x%x \n", ID, state->global_lut_disregard_reg);
 	ia_css_print("CSI RX BE STATE Controller %d packet stall reg 0x%x \n", ID, state->packet_status_stall);
 	/*
 	 * Get the values of the register-set per
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
