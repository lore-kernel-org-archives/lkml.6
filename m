Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804105-2-10627768563626579125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804104; b=cbC7pEXr2KN9qzhA22AasrtwZHAuDwXJ1W234chXv6RCgXD
    2F1XXy+iEgWBRB3Xd2U4N1IDDpOXmcTQMMoDiU70qWZHVC1Guf6DxNiVhyBzeGZb
    byCYRmjYA99aJFNj+bv+zNugXe069zDZuQ2ipkDpNySQf+XCpk+aNIevAz0eNw+h
    TzeriR6iSmGDcE/KtYwH6nvxiWSFwyOlkpi/EdPv3HYck6bzj457kEY2VlU4yXyX
    KiT2Gxxiwrm3zXnmdOlmfhImXVSvThIKPG8tspN/74jTPaUfXiAF3YXi5d5e2Fwi
    uWEB8QjPa+2sdpdBDUu8aXNrNFkLoCYFr0inXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804104; bh=brQQuSSj10x7ilJ53ZLIXaQGIg
    pqpI8nghOTvxCIy/A=; b=gMMHBeNJLb8doBzMb4iy39MUnNcPzfCDmQibwVFGEC
    9ce5Yh7zg8ZsT0qmdulJ3ltsDqK+U7VSjSlnkrK4y8U4m7dpl/iAzDR8V4F+G80t
    /38IOqXT5kh6h4urNxRvYGFuaRGGAe9D9sSCpBD9zdstNkmQjPrBf96gyaB2XzIz
    qIbMgWCWGDkK0cwkAzhIGGP3wgd9E4DDwvti++j+VybMH3gNrE++EKeCFfouEtg7
    /VLfJBHxxwspBNKOxa9hRhWsigXSteWkGheRe+3cUKWQUaju5OYCwizhFTjA1ijw
    dHjyeak8N4sqZusnMucknDlUWu5Wu8AtDRbmH7QVpAJw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755531AbeCWKIX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755507AbeCWKIW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Fedorov <Alexei.Fedorov@arm.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 081/177] ACPICA: iasl: Fix IORT SMMU GSI disassembling
Date: Fri, 23 Mar 2018 10:53:29 +0100
Message-Id: <20180323094208.882787107@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Lv Zheng <lv.zheng@intel.com>


[ Upstream commit bb1e23e66e6237ff7a1824b37366540a89149c33 ]

ACPICA commit 637b88de24a78c20478728d9d66632b06fcaa5bf

If the IORT template is compiled and then iort.aml binary disassembled to
iort.dsl, SMMUv1 node lists incorrect offset for SMMU_Nsg_cfg_irpt Interrupt:
[0ECh 0236   8]       SMMU_Nsg_irpt Interrupt : 0000000000000000
[0ECh 0236   8]    SMMU_Nsg_cfg_irpt Interrupt : 0000000000000000
This is because iasl hasn't implemented SMMU GSI decoding yet.

This patch fixes this issue by preparing structures for decoding IORT SMMU
GSI. ACPICA BZ 1340, reported by Alexei Fedorov, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/637b88de
Link: https://bugs.acpica.org/show_bug.cgi?id=1340
Reported-by: Alexei Fedorov <Alexei.Fedorov@arm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/acpi/actbl2.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -783,6 +783,15 @@ struct acpi_iort_smmu {
 #define ACPI_IORT_SMMU_DVM_SUPPORTED    (1)
 #define ACPI_IORT_SMMU_COHERENT_WALK    (1<<1)
 
+/* Global interrupt format */
+
+struct acpi_iort_smmu_gsi {
+	u32 nsg_irpt;
+	u32 nsg_irpt_flags;
+	u32 nsg_cfg_irpt;
+	u32 nsg_cfg_irpt_flags;
+};
+
 struct acpi_iort_smmu_v3 {
 	u64 base_address;	/* SMMUv3 base address */
 	u32 flags;
