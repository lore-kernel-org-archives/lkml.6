Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-670130-1522322094-2-8255082509407393400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.115', Host='mga14.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322094; b=Ae3P2UHBNwuR8FVKoST/uD/gVR1Ht7XWsCzUcT0PSqQXCmZwPa
    qYYSNox3XLwEgpwDoLUjOeEuEy5DGkWMMaEQfEet7GctR2At79Kg6La74gTD/Z68
    DQlmKZM24eENNazg+WgJ7L9RBXezzBrGubyjMIcQYQc03jfVvIZzef6WOU91gkc/
    N9/37TWKhbd7RLwKy1+JgO85FqHcLuxEvNSqw+ahHLhWE6ryUuplvZ43+f1nbWxF
    5ka3K+9i9ZI4JHbd222sGhK/SA0mqDN4uGjDFNDke6PZwsB4miPARtKTFtkqz22L
    55k4NJ6QTEatq7vj8bz0g0Gede/W2B5zQ4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322094; bh=Kgs5bBgqpnAYg/W
    VkQVlyokTV0G1u4MkxtuICsUPHOc=; b=kMLjgZPrB2cxOIbr2Mbeft/kQ2Jctb1
    feNDATpjuGCm0p6h/JqGATrUM/SrqH2Ua1hEIwD/ebaf6kSr6alv1fsxVDS3z1jV
    dgH7p9J/l/Eioe6vdoBAdCIL/IxJr0jCoiYSKhytIBo+PvdbLxrUSixuwNt8EPpp
    U1Lr2SJBRnJqn6ffP88pBAtqRN7IJVdbQTLayLfDF5X7+ntXjBYTM6OkG31Qqn0g
    0ljpc0zibiLR7f9dX0FS6Pfuxf47DmqjzIOgcmYqocBnqMCDRJvbe0eh7GadBTDW
    a3/JSaFwIwwRrupemCO8nIx9ohY2857p/DuDf0dMbJ2yUzUg8XBfoqw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.115 (mga14.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga14.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga14.intel.com x-ptr-lookup=mga14.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.115 (mga14.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga14.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga14.intel.com x-ptr-lookup=mga14.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFKJS+iqtrvziX2YVBPQJAjWwAHAADPPPDk+8GJmpqQXk9diGzwmCIWCJmfimEy5mAlObSJYilo4AfzH9Daxr+e3TqqwYUqO62fHHnlF/5LRH31RegYc
    JtqMWKUCpCwde3Dii/NaV6Rn1E7IWq7FaYMqVFXHkDQZe5OM8zwL0M4jwBbN+zt8a2D95MtcaCW6cEJENIdyRnLT+wXoFRIe2g0=
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=yPSvGpHfZI9xrpk/7ex/9g==:117
    a=yPSvGpHfZI9xrpk/7ex/9g==:17 a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8
    a=4TtCKkGZAj6oQ-elyc4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="39127695"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 03/10] stm class: Make dummy's master/channel ranges configurable
Date: Thu, 29 Mar 2018 14:14:11 +0300
Message-Id: <20180329111418.9416-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To allow for more flexible testing of the stm class, make it possible
to specify the ranges of masters and channels that the dummy_stm devices
cover. This is done via module parameters.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/dummy_stm.c | 24 +++++++++++++++++++++---
 include/uapi/linux/stm.h          |  4 ++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index 63288020ea5b..38528ffdc0b3 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/stm.h>
+#include <uapi/linux/stm.h>
 
 static ssize_t notrace
 dummy_stm_packet(struct stm_data *stm_data, unsigned int master,
@@ -44,6 +45,18 @@ static unsigned int fail_mode;
 
 module_param(fail_mode, int, 0600);
 
+static unsigned int master_min;
+
+module_param(master_min, int, 0400);
+
+static unsigned int master_max = STP_MASTER_MAX;
+
+module_param(master_max, int, 0400);
+
+static unsigned int nr_channels = STP_CHANNEL_MAX;
+
+module_param(nr_channels, int, 0400);
+
 static int dummy_stm_link(struct stm_data *data, unsigned int master,
 			  unsigned int channel)
 {
@@ -60,14 +73,19 @@ static int dummy_stm_init(void)
 	if (nr_dummies < 0 || nr_dummies > DUMMY_STM_MAX)
 		return -EINVAL;
 
+	if (master_min > master_max ||
+	    master_max > STP_MASTER_MAX ||
+	    nr_channels > STP_CHANNEL_MAX)
+		return -EINVAL;
+
 	for (i = 0; i < nr_dummies; i++) {
 		dummy_stm[i].name = kasprintf(GFP_KERNEL, "dummy_stm.%d", i);
 		if (!dummy_stm[i].name)
 			goto fail_unregister;
 
-		dummy_stm[i].sw_start		= 0x0000;
-		dummy_stm[i].sw_end		= 0xffff;
-		dummy_stm[i].sw_nchannels	= 0xffff;
+		dummy_stm[i].sw_start		= master_min;
+		dummy_stm[i].sw_end		= master_max;
+		dummy_stm[i].sw_nchannels	= nr_channels;
 		dummy_stm[i].packet		= dummy_stm_packet;
 		dummy_stm[i].link		= dummy_stm_link;
 
diff --git a/include/uapi/linux/stm.h b/include/uapi/linux/stm.h
index 29c89be72275..7bac318b4440 100644
--- a/include/uapi/linux/stm.h
+++ b/include/uapi/linux/stm.h
@@ -12,6 +12,10 @@
 
 #include <linux/types.h>
 
+/* Maximum allowed master and channel values */
+#define STP_MASTER_MAX	0xffff
+#define STP_CHANNEL_MAX	0xffff
+
 /**
  * struct stp_policy_id - identification for the STP policy
  * @size:	size of the structure including real id[] length
-- 
2.16.2
