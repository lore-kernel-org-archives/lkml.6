Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-670130-1522322092-2-14445748365852365027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.93', Host='mga11.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322091; b=bRY1LWcCwnrMpBBlT5HD1MlXbIn3og0kGnxmf8mHRxtcxaEAz/
    Q6JcDx85BHKDJObufAAVexZTpiqLZG0oaX3oBXQSdL8TjKsdaoBfUDsLEQs8aq9m
    jlbtIwOUnZUjDzlnftIs7YBHTObVXy3gblkQ4mxnRg7tENoO8X06SVgu/qc6R5q/
    MmWP6NujElnmGvsmJHia5lEmgLJPcXbFtJ1JY7mwlGvdYq3Adam87JockZHXRPa+
    na4s6WJVt/+UP33tkJOfdV8ySZmTQffdoMoWqvQDoYFOANp1XaQVytmnt4aeWbF9
    vJikUmj1MhyBDlXw1HQ0hKJtiupmdSVrTOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322091; bh=4Mm+Yq2gELANoy4
    sQWl0mJ6UxWaeGSV97byyaPQsbdU=; b=SFMOkLQh4iRHPhaotqPhRf69ZSUAGxB
    nHN9MFkdYQX94mgSLZkAjPQg1NSzo5NCv/v5WBtcSvOO3tA8pWTwhnQgByEJPTMS
    2IwameI2dK2jNdDsvO9hU5l7YEbLGHa0HC3sbHoCOhLjQuRsv0chR4UD0lnZBlaH
    llE5s9F7JBe5uavOeYa/xGwwBJdb8aXoV/QuukREGF+9JOPNNqnS1qaFubIQDsg7
    NXateLljNIxQZk9IKPjr7NFwBxoKXbGGYcAngDeo9a873A2KGiGjmZqssVmhlugh
    7PjGuMikBj/QGXkpsNrEBp78gE5GRCCJ9awepnfgpGMVPhhaqtvtK8A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.93 (mga11.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga11.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga11.intel.com x-ptr-lookup=mga11.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.93 (mga11.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga11.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga11.intel.com x-ptr-lookup=mga11.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFT4ua8eKbvo+Xf3B7xAuCfRGHm9VEP4aCGoGM2KOU0weuJTUofyVRO9yOcmqpXHfZ3Htgx0fR/HHVEF4ZugUNcgvUiqSdbSZgIhTaPc6H6KgiUMlxkN
    dPkPkRJRlfyzTA2zW9rpeB5Q48c0H65QhmwBzhW811uaM1bdYktY0wgT/6bvuMZ1QTOBcTUAuHjR6g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=C441Q106UFfO2N3IWpcXiw==:117
    a=C441Q106UFfO2N3IWpcXiw==:17 a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8
    a=2LjLHKtCAAAA:8 a=KKAkSRfTAAAA:8 a=9vgwsUXFrHkxTjFTn4QA:9
    a=9FfIoZ25bH_a3prSmYoa:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="27980039"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 01/10] MAINTAINERS: Bestow upon myself the care for drivers/hwtracing
Date: Thu, 29 Mar 2018 14:14:09 +0300
Message-Id: <20180329111418.9416-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Although all components of drivers/hwtracing are Maintained, the
directory itself isn't, which leads to confusion when people want
to patch the Kconfig file, for example.

This adds an entry to the MAINTAINERS file with myself as a
maintainer.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..48e426fcde97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6242,6 +6242,11 @@ F:	Documentation/hw_random.txt
 F:	drivers/char/hw_random/
 F:	include/linux/hw_random.h
 
+HARDWARE TRACING FACILITIES
+M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
+S:	Maintained
+F:	drivers/hwtracing/
+
 HARDWARE SPINLOCK CORE
 M:	Ohad Ben-Cohen <ohad@wizery.com>
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
-- 
2.16.2
