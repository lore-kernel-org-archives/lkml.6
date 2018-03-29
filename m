Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-602900-1522322107-2-16812287018527118156
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, SPF_PASS -0.001, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='134.134.136.126', Host='mga18.intel.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322107; b=Zl3DykSke90yxlqMNIbgUaRg7X1EdqC/wqYJdG1lz1COR4jHgw
    diglRSBQMDAt1/0RPV6PrHmNG5rHE+a5TopZVr1erxFjEfga+HgOflp6bOChR2gv
    MSRNsFOWNrXNvdTLb8CdN0U4e/ycdb5wvlnZY31b70qDHpQAdh7GmGfQpKjtgZYq
    gUjQYYW9wXBN4aOau5EsGHfIImJ8GswPFWtuwaPdpnOLIHndaToEWPvDLpDo21yx
    XEqzPLbweSE6xdJoCzj2xDbWRu+nZQq0upPla8CMRh1wugxwuhMe9uxNQoj6Dznw
    ry97Oi2dEY3bGRDCZinc1ENcBz1/oAvJpD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322107; bh=R/Vob0OJXElkfHF
    85VQutp45Lx9zKgzlPPwcTeKd7Ms=; b=s5y3QlWZPyAc4FPmisS0zczoAA8Ra5W
    bQthtzQjLGBTuQ3TUyECKX4zp5l+so+LoTXabSWT2uM4BSC8bOwVBYpTgsAm3quA
    KrgKEH4UDuNQYop1xJfgu2KzGIycllroq3Mdd0Do14aOTedg9Etlg5STulPKvMLB
    20cGYkclO3RxYAdStxP2/BeZKLILukTARLuHghyyRLY0uKOcRK89XhXIfrUg5YBy
    JypyE8tgiOWYYUXCnrcI3CsY+XMFxbIWGC0tV8bg2V+5hIu11OFlehTznQoEIJcz
    VPrSM6ECo41MSOaJ5sMSgZUrVTHDPq01Xw8dKhiLpx4WWE9Ix5hnkYA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.126 (mga18.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga18.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga18.intel.com x-ptr-lookup=mga18.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.126 (mga18.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga18.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga18.intel.com x-ptr-lookup=mga18.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHm+HBhUTITggpaIjVgjJzc5qLFIkK+V3M7M3N8PoxfV3ja5HJuK2upSoj06tqTlYPrctLEVRZ78oGPQ7/cc3ktPyR/Cy7ixdV++mk01rkPq600FrlL+
    xsTGRKAFH8vHZYp2K9ZawVeKqLrTc7X70TzDG4MJzeNpt9q+iLzGvGJswm9mZW74EEkXqv+jID8K1kdAcgLpD342Cb8ghHWrHF8=
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=LeX/nknxTGvos77NV3PW7A==:117
    a=LeX/nknxTGvos77NV3PW7A==:17 a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8
    a=GhPwWJ2nnblUoDwxlyQA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="27980095"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 07/10] intel_th: Pick up irq number from resources
Date: Thu, 29 Mar 2018 14:14:15 +0300
Message-Id: <20180329111418.9416-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Platform devices pass their IRQs around as resources, so as a convenience
for the glue layer code, allow them pass the IRQ to the core driver in
the resources array.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index d295b221e0bc..8f820c182240 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -805,7 +805,14 @@ intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
 	       struct resource *devres, unsigned int ndevres, int irq)
 {
 	struct intel_th *th;
-	int err;
+	int err, r;
+
+	if (irq == -1)
+		for (r = 0; r < ndevres; r++)
+			if (devres[r].flags & IORESOURCE_IRQ) {
+				irq = devres[r].start;
+				break;
+			}
 
 	th = kzalloc(sizeof(*th), GFP_KERNEL);
 	if (!th)
-- 
2.16.2
