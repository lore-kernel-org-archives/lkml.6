Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-670130-1522322110-2-759014339187852002
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.120', Host='mga04.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322110; b=JKlxoYmX3v1x+h4MkNtPyNdWJ7z9YkdaGVjWAaWAzO5rg3Ysc3
    RHdQviqJDZwilIBmpJDOj4QdiPxIfZ8oHZBS8ThEZ3l5vm2Dqdhin277FE6JlC5x
    K5JGDdlz3T+6HEUu5zZ4as0zaB4A+l+NDWLHYc7vNPuHL+56DRi11O1Otznd1JkF
    DVK0R0jxSQkQSGBAAfVAR9bng1t/ZLc2k5Xr7lr6nTofyuoNISVxCyB/3ru6AAOp
    A/NqROtvPJjsqcYvfrWA4RH157/MPqr5pboMYzUa122o7nlcvOrATYwNf4hJM+wO
    fMfaysfakExLECPcxmcR0xXbGmeCvKNEZqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322110; bh=ihTAwgN4mHvKnG4
    vJ4Lm1nJrj543sxfO0MGPO3UGpdw=; b=mAZpBhWFtcL40m1Th8gTeKyq8WyQX82
    C9JlagLNzUBwZ65heNhhtXF56xSOSBYwiWaOVWcm2H+i8jEj22SYaSJVkHbaECPz
    /klCoOT1uTDU2SZIUCQuB1FrTZC8S/hSTZFHmdwpM7HPp7VyIJZZ7ooQq6QzsTUB
    IWURtjih8FB+n/Wn/mWlt0Y4fZk+sj2z4an7s3f4ZvBBOHgA/GCUInPwy7HeStZP
    YkOQL7Jnr8hpvtF3i9Ib39DwX7kfhncbTehxESN87keESInTbwhInP7hxXHUhuIN
    6kREn7HUOYKlnEQZroPcs51WnTWCRCmKifX4yanXbIN9CZLRTLDqC3A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.120 (mga04.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga04.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga04.intel.com x-ptr-lookup=mga04.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.120 (mga04.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga04.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga04.intel.com x-ptr-lookup=mga04.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGBwf2tSxKBwgw0J66OL8RNQeprY6QVGA6sXMnLlW813DflI2o9SGYVitWeqA9eDJCnAcWQaNgvVC1MxyT7tZvuUMMIZXjkpIkmp47/sSezOD6N8S0aW
    Q+gtYYkG7/jXVZsPUyscSSFZyfUNbZp8ySyteLxxpIQOezpTtXM6c0clUYMOsZpLfdIEfuacLbTTk+UjhTISe0c+da+7M1ToW+w=
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=83rbKwn1RWDzQc6g+5U3cQ==:117
    a=83rbKwn1RWDzQc6g+5U3cQ==:17 a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8
    a=R749zCkpP2ok9mu_1gwA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="46280165"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 08/10] intel_th: Allow forcing host mode through drvdata
Date: Thu, 29 Mar 2018 14:14:16 +0300
Message-Id: <20180329111418.9416-9-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some devices can only operate in host mode, so we need means of
communicating this to the core driver on per-device basis. This
adds a flag to drvdata to signal host-only capability to the core.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c     | 6 ++++--
 drivers/hwtracing/intel_th/intel_th.h | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 8f820c182240..da962aa2cef5 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -630,7 +630,8 @@ intel_th_subdevice_alloc(struct intel_th *th,
 		thdev->output.port = -1;
 		thdev->output.scratchpad = subdev->scrpd;
 	} else if (subdev->type == INTEL_TH_SWITCH) {
-		thdev->host_mode = host_mode;
+		thdev->host_mode =
+			INTEL_TH_CAP(th, host_mode_only) ? true : host_mode;
 		th->hub = thdev;
 	}
 
@@ -729,7 +730,8 @@ static int intel_th_populate(struct intel_th *th)
 		struct intel_th_device *thdev;
 
 		/* only allow SOURCE and SWITCH devices in host mode */
-		if (host_mode && subdev->type == INTEL_TH_OUTPUT)
+		if ((INTEL_TH_CAP(th, host_mode_only) || host_mode) &&
+		    subdev->type == INTEL_TH_OUTPUT)
 			continue;
 
 		/*
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index cdeed3b017d0..780206dc9012 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -42,9 +42,11 @@ struct intel_th_output {
 /**
  * struct intel_th_drvdata - describes hardware capabilities and quirks
  * @tscu_enable:	device needs SW to enable time stamping unit
+ * @host_mode_only:	device can only operate in 'host debugger' mode
  */
 struct intel_th_drvdata {
-	unsigned int	tscu_enable        : 1;
+	unsigned int	tscu_enable        : 1,
+			host_mode_only     : 1;
 };
 
 #define INTEL_TH_CAP(_th, _cap) ((_th)->drvdata ? (_th)->drvdata->_cap : 0)
-- 
2.16.2
