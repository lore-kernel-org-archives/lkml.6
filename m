Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-670130-1522322103-2-4337562613264329244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='134.134.136.65', Host='mga03.intel.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322103; b=FxL0IueHOuZb00Q2QGw2PeopCS0fTOsrLU9JNeI/Z1/KSVa3M3
    F+OePfClUYgA0G1Ro85qfLRO3gHnEdWMio6zy4EKwKlBdBdZbtpleMEXbO+IsAHQ
    20NiKf5WL1cSLd0fcNQXnqQ8xw0jkcZ6FwsPNpXc/iK2Pb+Httd09NNTC5fhu+vd
    k7hGdnm/NYpBRIAmKAi8kW+XDlR8Vjp8rPlUWbEoXdylVCxVVWRj86khs+mNw0ab
    6Yo43umLxe5IlcHOu9v8I72Hla/pCokIweN3Qi4VC6tF1DLppZ1E2kb5ET0gd/L7
    fNn1QHaqybRqLwYNxTpfFApr+2JZe8I7OqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322103; bh=YrSRPf8UBIJ43Gp
    ZIUOXSzg7ysSX0EjEJwpWk3KggzY=; b=WNtlXARE47X2F93uzHajfDkuOja6T4P
    s/X1FT347Bry/G3IMD7FFFxuhhtsYYXSkSzNha1aY1BvKOLqxoEGPwNep4BfWT13
    2M/j0Npe67YxrLjLYFxmiXT50xcBsNWduZm1MxSZxtxO7AEYXkFQbTl1KJ98YOr6
    UYUFw8dt7szX/pKrVi1w7EoYmLoed2hiD/kCCNuTiNufu2G7DM32oRYhMWKYwFpG
    +eCkdXqQt1Yg0Sxc8t7+3NYbyBYWRCSMp8ajv6Cku4bW/bviRLpTg9ml/JrbiZRv
    iwDUngXvyiUDGk7x9RnEVTqKiL4jQqnyC/Ir93NE9mFYQ6Snn6FWkQQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.65 (mga03.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga03.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga03.intel.com x-ptr-lookup=mga03.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.65 (mga03.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga03.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga03.intel.com x-ptr-lookup=mga03.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfASnbHb5enCP357uO2d3jqpvXefp/a0O7r6+dgVVJ/0nGKj7lhWM2hJ3OVv68LfHWJ36md6VspKJ7zimpnuCb5qZUhVd7dIzqOOHFlnZmPW//Np5XK7K
    fysOwAYhH4yDMDi8WvJ49iO8Xhcm0Fw5LODMPiUxNXbsztKQCEyhAycTrz4NmRxcQVIZbAWaSfyG/Se2mGXAVvWxG46U0hgWZ3I=
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=Oj+l1AdcLniEkYwH1Tuwng==:117
    a=Oj+l1AdcLniEkYwH1Tuwng==:17 a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8
    a=oGImMVIB0tULdUseTqYA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="43204808"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 05/10] intel_th: Use correct method of finding hub
Date: Thu, 29 Mar 2018 14:14:13 +0300
Message-Id: <20180329111418.9416-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since commit 8edc514b01e9 ("intel_th: Make SOURCE devices children of the
root device") the hub is not the parent of SOURCE devices any more, so the
new helper function should be used for that instead of always using the
parent. The intel_th_set_output() path, however, still uses the old
logic, leading to the hub driver structure being aliased with something
else, like struct pci_driver or struct acpi_driver, and an incorrect call
to an address inferred from that, potentially resulting in a crash.

Fixes: 8edc514b01e9 ("intel_th: Make SOURCE devices children of the root device")
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index bf1e4543c722..8e4f5fd8a43e 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -927,7 +927,7 @@ EXPORT_SYMBOL_GPL(intel_th_trace_disable);
 int intel_th_set_output(struct intel_th_device *thdev,
 			unsigned int master)
 {
-	struct intel_th_device *hub = to_intel_th_device(thdev->dev.parent);
+	struct intel_th_device *hub = to_intel_th_hub(thdev);
 	struct intel_th_driver *hubdrv = to_intel_th_driver(hub->dev.driver);
 
 	if (!hubdrv->set_output)
-- 
2.16.2
