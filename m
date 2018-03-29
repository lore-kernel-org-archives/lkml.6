Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-670130-1522322116-2-17576619181202177228
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.43', Host='mga05.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322115; b=oOQr2ks2myg2TcfQrrI6Z++jKngXPEe4jtpUxFn5VAh2sqPSet
    5UPzJJB3EJsTHnR/88MagZslobVLWAWOZxyEed4+t89g46ITAYRfbY2KcuQDxLdr
    YxFw0sAJ+53zRa4DKjeFFilldZE8VyD4FUk4BOfAVs8jVj0koxydsgeN9/RqVTNE
    aXjUmmdwzLQ/m6oaEKKwEVQfIDefuUARz2pIH6m6kDp+GzRuZogi6Ntwj5hkRzKf
    uEnPpGW09Jn+qISR4FZTGCUhvrryqZlCyS9KgK+uilaAwdkHuFSUSGhuxFKfX4ni
    tTQo+o/q90cNt2c5cm40MfXkkHJu0+z5Bemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322115; bh=y6C5GUwdid5T+Zf
    ckgRHTBseljysCPlWdpRXOrTgv8w=; b=LMN12bIK+ipR6htOhVtE4CNCrAOYuz7
    XV1Wp9ajnP04LcTYzkbHxa/3rHKmAllZmHtNGDRMgcDsmaAeyXhyH38ZRRiPQGzb
    DffRAab9JPUpmB8WBtth6+rvQnVGrfWAjma6tLnJ+gyNoHu9NfuqfB+3sM9ubS0C
    hDXJJHyVuRDU4JlZGnPlBTsbA9Vb8l9U4a6Lh5RUZM5f/07+rw6AX1+LvvKo2MVB
    fkClqNrAcE0qi0GMH5mi7e6HRBAB2ugh1/gI2NN2Tmgu2TutDcYHVf4b81mgOxC1
    jxzBzYmaxfSkuH+4fqF1Xit+inwPfHoHX9V5QgG+778WVg2ywGxGT1w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.43 (mga05.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga05.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga05.intel.com x-ptr-lookup=mga05.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.43 (mga05.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga05.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga05.intel.com x-ptr-lookup=mga05.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfbU9uoLHgjjy73fn+STUMt9ibuaVFh9cgBlmPGlYpWvGLzzDyxMQyMOXDDxJGOyduvmtxr/Jow59IHRb7VH/OnlpcnyCamD1Ej4XLwK3V+IdsuPPZg
    vplfKejpUojFP5ljyT3cOdLQ6j+CRB6RBYWsHhtEXNZ/9D24GqYYQmpeMwl9yI36oWErMdml+sILFg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=YWhQVxBgbsGkxU+7CP83Mg==:117
    a=YWhQVxBgbsGkxU+7CP83Mg==:17 a=v2DPQv5-lfwA:10 a=JfrnYn6hAAAA:8
    a=QyXUC8HyAAAA:8 a=75PF2wckneyGCQ3ODoAA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="37844405"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 10/10] hwtracing: Add HW tracing support menu
Date: Thu, 29 Mar 2018 14:14:18 +0300
Message-Id: <20180329111418.9416-11-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Make a "HW tracing support" menu and move 2 entries into it.
(No change in Coresight, which is ARM-specific and is only listed for
ARM & ARM64.)

This makes the Device Drivers menu more consistent and prevents these
drivers from being listed at the top level of the Device Drivers menu.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/Kconfig           | 4 +---
 drivers/hwtracing/Kconfig | 7 +++++++
 2 files changed, 8 insertions(+), 3 deletions(-)
 create mode 100644 drivers/hwtracing/Kconfig

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 879dc0604cba..95b9ccc08165 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -199,9 +199,7 @@ source "drivers/dax/Kconfig"
 
 source "drivers/nvmem/Kconfig"
 
-source "drivers/hwtracing/stm/Kconfig"
-
-source "drivers/hwtracing/intel_th/Kconfig"
+source "drivers/hwtracing/Kconfig"
 
 source "drivers/fpga/Kconfig"
 
diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
new file mode 100644
index 000000000000..f68e025c5131
--- /dev/null
+++ b/drivers/hwtracing/Kconfig
@@ -0,0 +1,7 @@
+menu "HW tracing support"
+
+source "drivers/hwtracing/stm/Kconfig"
+
+source "drivers/hwtracing/intel_th/Kconfig"
+
+endmenu
-- 
2.16.2
