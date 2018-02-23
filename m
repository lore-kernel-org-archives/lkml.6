Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415303-2-981659267723445246
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415303; b=tI75HC3NEaOiTAes6kxiQuiNMB1aljaAja9UbB2TivVkurK
    g7MWolzf9qztW6iLwB42Pc4DVovjD+CYHEGJEATt4sUj2PpDzBNehoGBPXoB9h9F
    CcY0fk1ks+zRXCmsGF89cXIiPWVP5zubzCxlxrcdE4C1tazoPyQtgwGxsdcKpFGb
    JAY+QJuXZB8AqIR/3edjSbY0AvI45QB0hTTPveoiL1pfEHoUw+tEc3T6DFTGjYET
    s9jhROmsb/Y8OzvOdYukaZIHLCT/Zoc9i+2Oel68lWImkyvBgjWBECHSLm4m1lsz
    GNdJwK2iXAvqlbYarI0GWjH/sQOg01t6Tf5B5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415303; bh=I9zf+qH0G9e+PenG6ctq1UeIRx
    +vx/HEjIlPd4m8ESM=; b=tvCs+QwAmMcdaq7eUwVdkoOU1PVw6wtloz1O55WPDx
    T3ca6i/Lkacf5mhX0S9SC8mUg1ibDQkXOxu6asMK2UDJNmkkpjvGSGma2xtL/3On
    J0mk3j5N5Kr8wBZAvIwWkFTylUf6bWggYYyOwdBPZp7sfCtUyHXNdTCGyd1RswkO
    VFQvQymmk4Jr6SPkzu8uph8DzYtwuuT0Wn3VEKWxUMOUmf1MLXAcGLwBmnR+8ipf
    M/QBHIKPdX4kj8rzmrYD+D8/DwobMlbNQRXWxmDxnkmusY8vXnhX4fjmneVw5Cqg
    k6+eJA+/4SG42FcedAnf80wJBYxNMBV/qHqmCVH93jjw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934125AbeBWSrO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44494 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934058AbeBWSrN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4.9 110/145] thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
Date: Fri, 23 Feb 2018 19:26:56 +0100
Message-Id: <20180223170739.079915401@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 68fd77cf8a4b045594231f07e5fc92e1a34c0a9e upstream.

We get a Kconfig warning when selecting this without also enabling
CONFIG_PCI:

warning: (X86_INTEL_LPSS && INTEL_SOC_DTS_IOSF_CORE
&& SND_SST_IPC_ACPI && MMC_SDHCI_ACPI && PUNIT_ATOM_DEBUG)
selects IOSF_MBI which has unmet direct dependencies (PCI)

This adds a new depedency.

Fixes: 3a2419f865a6 ("Thermal: Intel SoC: DTS thermal use common APIs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -316,7 +316,7 @@ config X86_PKG_TEMP_THERMAL
 
 config INTEL_SOC_DTS_IOSF_CORE
 	tristate
-	depends on X86
+	depends on X86 && PCI
 	select IOSF_MBI
 	help
 	  This is becoming a common feature for Intel SoCs to expose the additional
@@ -326,7 +326,7 @@ config INTEL_SOC_DTS_IOSF_CORE
 
 config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
-	depends on X86
+	depends on X86 && PCI
 	select INTEL_SOC_DTS_IOSF_CORE
 	select THERMAL_WRITABLE_TRIPS
 	help
