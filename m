Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520955633-2-4232046707729848682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955632; b=SKXGyB4dL+eFV3lqV8HY/X7zo+1KDK2go2OREnvbhPuyxCw
    aM9K2X3IMWEyTyt7IUi8SaHvMJLK/LjwVnuFJ3Urik10mqXFjKDLmMnASDTpv5Mf
    UcYl5r9oAyThdxNAa5TKam8lGNDG+o+VaKfJ9bJ6X2onb9fk9AyF+pqqZ73E8En+
    Ge668fYbM67VWg38xw2HyburmZ1nK3hfe5nD5z94rdDTOFadKwpC0SuS71jLGGxY
    e164IbgwnXgsgrjKaonWrDVz5VlDD7wioxU+GAcdeX1WPM4acSS30YEtjOEvZfJq
    jLgU5te6LK7qqZFeZMyjCxkto2Jap5C/dhWFXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955632; bh=PwX6Y2d6l7by8uaIxtgOjzvLTL
    QcN6TSMTTGGu8po8A=; b=MzgHhWtmgOjdHYmCeqlE4Wp34BvsTXAAqglKEzVD6a
    v8banq5fZPOZSrb3wpG61fspf/cLcBrWetIhsjQKiJsL+Cy3Z8xrF7Ij5UVqr4H8
    1lZn+/ismAFKWZgcVYBN+EFX60NsrWBs28N4yYUfMh133uvqatuVap9qYtIrWGnZ
    3vLo0uhBVKgU7zg4vvA/lAYbbCyzFh7HvE9mOEYqHUJkkRRzW1Bg4j65xLB1Tcse
    VLNQ+O0n+NUtU2lvs5YQiz4TStPGQCH60ims+Hgll5H6Pk1RnKEZGujBGxNTAUf4
    KO8+q5hympfq9PNqlaNM50QeFRASG3hyobwnDVMY0jKQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934097AbeCMPk1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:40:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934884AbeCMPkZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:40:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 114/140] MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()
Date: Tue, 13 Mar 2018 16:25:17 +0100
Message-Id: <20180313152505.846604094@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 791412dafbbfd860e78983d45cf71db603a82f67 upstream.

Reading mips_cpc_base value from the DT allows each platform to
define it according to its needs. This is especially convenient
for MIPS_GENERIC kernel where this kind of information should be
determined in runtime.

Use mti,mips-cpc compatible string with just a reg property to
specify the register location for your platform.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/18513/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mips-cpc.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -10,6 +10,8 @@
 
 #include <linux/errno.h>
 #include <linux/percpu.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/spinlock.h>
 
 #include <asm/mips-cps.h>
@@ -22,6 +24,17 @@ static DEFINE_PER_CPU_ALIGNED(unsigned l
 
 phys_addr_t __weak mips_cpc_default_phys_base(void)
 {
+	struct device_node *cpc_node;
+	struct resource res;
+	int err;
+
+	cpc_node = of_find_compatible_node(of_root, NULL, "mti,mips-cpc");
+	if (cpc_node) {
+		err = of_address_to_resource(cpc_node, 0, &res);
+		if (!err)
+			return res.start;
+	}
+
 	return 0;
 }
 
