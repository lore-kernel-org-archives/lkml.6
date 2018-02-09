Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185640-2-4947958090055438106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185639; b=aDzEzlGhYJeEkPEZ2T+OYXTZ80fX1OOsk4+eRvl2A5Veo24
    ggAwSJxB5Rgma1dZfQ/aJB79DaYHUjpPfBAtmNbkuQTGGVJi7eOZUKpFBkATNr/n
    N2OOn0pwzW5dnE49c9Rx9kdwxm8f7giA/vsdUjKoxmHS37v95G9FRw4o6fr4rHps
    bFJLEbSsYMCy59glGV6LRbO4R1wCBDH6f9BGmUzaNIAXAJR72jboyTUqM+PYE7us
    X7cBUI4aTvuFqJXbQp8h564U4gk1mWcUlHjJq+JxSGkgt0yVpJih78wLVUolbZX0
    ally7kv99fSC4QY8efhs1taLjFClJJh1hChAFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185639; bh=KwaTUJ9g5P/4A9RhxW+C35XYto
    PQZGoR3xX7ixup1AI=; b=cwWT/Q85KF9RfciM0x3FdBMCBE47bIeXP1l5UhEpbx
    aGI57vQZESynuSKj+eoRfra/ruqdr0At0eg+1WudHZUlZHXErIeVOkrlSA/MRTZX
    pcLe9MWwn9WtN5OvNgI9SSqX4rnw1tQZq51azHpgj29Yrc1m8NZMFqv5OBb/j2yZ
    37r+FMdFLxOB8sboqHnArlwCZfBjqGSve/QkQOMhqRDhBLCOgOL17nx+lmiNmLF8
    8Z5PPGyXRNsvfm8gG2yzzKqbGSuLgJUvIJzkVgf2SJTEOWuTvxxiyuO72qOTizu/
    pvDCtflVqUD3tYeLGiodr7koO2MS7xfsbLl++wOwREJA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbeBINlg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:41:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbeBINla (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:41:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4.9 11/92] powerpc/64s: Allow control of RFI flush via debugfs
Date: Fri,  9 Feb 2018 14:38:40 +0100
Message-Id: <20180209133932.050028723@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 236003e6b5443c45c18e613d2b0d776a9f87540e upstream.

Expose the state of the RFI flush (enabled/disabled) via debugfs, and
allow it to be enabled/disabled at runtime.

eg: $ cat /sys/kernel/debug/powerpc/rfi_flush
    1
    $ echo 0 > /sys/kernel/debug/powerpc/rfi_flush
    $ cat /sys/kernel/debug/powerpc/rfi_flush
    0

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/setup_64.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -38,6 +38,7 @@
 #include <linux/memory.h>
 #include <linux/nmi.h>
 
+#include <asm/debugfs.h>
 #include <asm/io.h>
 #include <asm/kdump.h>
 #include <asm/prom.h>
@@ -779,6 +780,35 @@ void __init setup_rfi_flush(enum l1d_flu
 		rfi_flush_enable(enable);
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int rfi_flush_set(void *data, u64 val)
+{
+	if (val == 1)
+		rfi_flush_enable(true);
+	else if (val == 0)
+		rfi_flush_enable(false);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rfi_flush_get(void *data, u64 *val)
+{
+	*val = rfi_flush ? 1 : 0;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
+
+static __init int rfi_flush_debugfs_init(void)
+{
+	debugfs_create_file("rfi_flush", 0600, powerpc_debugfs_root, NULL, &fops_rfi_flush);
+	return 0;
+}
+device_initcall(rfi_flush_debugfs_init);
+#endif
+
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (rfi_flush)
