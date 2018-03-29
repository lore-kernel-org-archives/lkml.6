Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-670130-1522322105-2-1946999413023674429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='134.134.136.24', Host='mga09.intel.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322104; b=VETwPKsuSrjmil0m9qBmIif75jnc6qG4YU58cOM5B6FKBt0qkS
    VJqC/m52OVMsXcOQO7ou32nDrN4XvA+4bjP2xwTYR/1SC+cXM/Gm2Rdthaab9k+b
    y7kM02VxN3Hugh05vZbQrQ2R56qnpqERzTrwXlOLHxDvRNQvUijF3GI7H+uZgvI9
    g3gtHiw7opZKW4CiulXLFNkv4ir3cl1DJcqJka468/5FUttnsOradDhbUB5KTYEg
    VZWKVNLM3yjaHph9EC3mKKyLWkTeiocby+w4JgEQg45VKI4hQl+Dxliw9V0MrLKo
    H+hOi4ZhlhyiZwxouPZMg3iCd27LihY0/Q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322104; bh=4w6+D3pY+hKSY13
    dsvN7zITIsWTbjblbhpb9v19I5rw=; b=C7lVk0CdGwb7D32YfHLhDPcfGMZtHxL
    hADT9JmyenQIVcGESIVJG7nvV3SyQch/XRbsT/V0TzVrpn9xuF1jR3tFK/1FEM1J
    h1mJ6tjfnjyxMtDeC38Rlg5+bZQsVn4ygqO9ZwIo6KbcZE9UCQepm9AvD+23Be23
    IXIpKUvMli7/qF5XXW6qAoefmZedeRwmLAkjM3J47DBvMhg7nnouPiWmW98jjEgC
    TfpOcHDyFKVpaOE7TYWlRvO5c79SntzMOF71EYwBNMDBnAxt2NNWY7hJvtq2pypV
    vloNlRecJaS4AFI2qs80nWPNVBJQ2cqbKYXew0V1rdUZf9cWhiZNfSQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.24 (mga09.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga09.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga09.intel.com x-ptr-lookup=mga09.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.24 (mga09.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga09.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga09.intel.com x-ptr-lookup=mga09.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFgWa23z3d8z6lSgKhx4ApEdEYBKQj/DudkhIxrojHKzils+Nb8s00J7iohm0vL4aesaEcAylg/91yPfaF/dfsaxgG25jdh49K7DPpWExWt6ApMF4JRd
    eAzz+k5Y4u/ZqW2fvBft9oBnAiLHFTIG/at2o1+alR61Kzc9ZKgdyUC6ZIPrKECWTyXA9bU82mA5FjLrzeKPMiJknaFjlCC9AA4=
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=NbiJzzs714t695yxpfMljw==:117
    a=NbiJzzs714t695yxpfMljw==:17 a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8
    a=AlCTZ8Civ_5MOmcLwn8A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="29887939"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 06/10] intel_th: Don't touch switch routing in host mode
Date: Thu, 29 Mar 2018 14:14:14 +0300
Message-Id: <20180329111418.9416-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the Trace Hub is operating in Host Debugger mode, it is up to the
debugger to configure master routing even for the software sources. Do
not do this in the driver in this case.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 8e4f5fd8a43e..d295b221e0bc 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -930,6 +930,10 @@ int intel_th_set_output(struct intel_th_device *thdev,
 	struct intel_th_device *hub = to_intel_th_hub(thdev);
 	struct intel_th_driver *hubdrv = to_intel_th_driver(hub->dev.driver);
 
+	/* In host mode, this is up to the external debugger, do nothing. */
+	if (hub->host_mode)
+		return 0;
+
 	if (!hubdrv->set_output)
 		return -ENOTSUPP;
 
-- 
2.16.2
