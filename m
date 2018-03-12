Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826119-2-12733708922117344206
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826118; b=WcF25FWFDMhju/wY/aBk0G8aLxqiV6hf0UspU9pYzW7ihkv
    T+YsVo+8rttdSRyHD/H4r58uKpV3gVgGt1oYXiMawSX24YZO4FfEH4rNOy6/FJRh
    ITi2m0kT+z8iqety9Nyx89oI39C2F+2SkaPAz1bqP/aMy+btFqfKUArY5v+8Cih5
    8zihLEC8Xz5Duoiua3xGAmM04AHDsT41BmqaYsvOt8ZYpdTtjGRuQ/f1IZcNHmuM
    7rTll7UtqJkUtevc7YFMggzXwDIR3p8iueyCN6CpTe5KPjTPQouoUl75y50b8E3C
    lN7C8QWJWDEtXoIHLVwua/0FTisNgWX6hL5T4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826118; bh=vC7C3dPLKNTf79xgU3v
    NOltc0wF+G82IY5pq7GjhvO4=; b=DLJinsI9uyIOuZK5+YIKjmWMDUTvFc2OJ/5
    ORTc+6K568lRlK4KrVyptTu1X+a9Vbhq+Im4S012xldY7UUfBEdN5F6IAKO7JRWj
    tN9LUS6gmCbQDlhY96AVp70SqwtXXnFMNnT1nNabVGtKZw0oJXjPixtQ2mi+C3n7
    P3AJ9BQxbO4Z2//6EI3K1La39+4LCN33TOgYohDppoQiW8hPLfZ0lbV/A8Ig/tO1
    do4Y9m09vOSf8qyHCdeCZ5w/Rar/eyTDonVJh9c0Zfwn3jOSRq8gnm0jCen/+itB
    xRqSuYNbhA2jxBEC66HW+HeAxEsbupnpim45ZqQuzLboJLYRi1Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeCLDlz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:41:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41171 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932663AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Borislav Petkov" <bp@suse.de>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.888673412@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 035/104] x86: Add another set of MSR accessor functions
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 22085a66c2fab6cf9b9393c056a3600a6b4735de upstream.

We very often need to set or clear a bit in an MSR as a result of doing
some sort of a hardware configuration. Add generic versions of that
repeated functionality in order to save us a bunch of duplicated code in
the early CPU vendor detection/config code.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: http://lkml.kernel.org/r/1394384725-10796-2-git-send-email-bp@alien8.de
Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
[bwh: Backported to 3.2: s/wrmsrl_safe/checking_wrmsrl/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/msr.h |  2 ++
 arch/x86/lib/msr.c         | 89 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -265,6 +265,8 @@ do {
 
 struct msr *msrs_alloc(void);
 void msrs_free(struct msr *msrs);
+int msr_set_bit(u32 msr, u8 bit);
+int msr_clear_bit(u32 msr, u8 bit);
 
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -8,7 +8,7 @@ struct msr *msrs_alloc(void)
 
 	msrs = alloc_percpu(struct msr);
 	if (!msrs) {
-		pr_warning("%s: error allocating msrs\n", __func__);
+		pr_warn("%s: error allocating msrs\n", __func__);
 		return NULL;
 	}
 
@@ -21,3 +21,90 @@ void msrs_free(struct msr *msrs)
 	free_percpu(msrs);
 }
 EXPORT_SYMBOL(msrs_free);
+
+/**
+ * Read an MSR with error handling
+ *
+ * @msr: MSR to read
+ * @m: value to read into
+ *
+ * It returns read data only on success, otherwise it doesn't change the output
+ * argument @m.
+ *
+ */
+int msr_read(u32 msr, struct msr *m)
+{
+	int err;
+	u64 val;
+
+	err = rdmsrl_safe(msr, &val);
+	if (!err)
+		m->q = val;
+
+	return err;
+}
+
+/**
+ * Write an MSR with error handling
+ *
+ * @msr: MSR to write
+ * @m: value to write
+ */
+int msr_write(u32 msr, struct msr *m)
+{
+	return checking_wrmsrl(msr, m->q);
+}
+
+static inline int __flip_bit(u32 msr, u8 bit, bool set)
+{
+	struct msr m, m1;
+	int err = -EINVAL;
+
+	if (bit > 63)
+		return err;
+
+	err = msr_read(msr, &m);
+	if (err)
+		return err;
+
+	m1 = m;
+	if (set)
+		m1.q |=  BIT_64(bit);
+	else
+		m1.q &= ~BIT_64(bit);
+
+	if (m1.q == m.q)
+		return 0;
+
+	err = msr_write(msr, &m);
+	if (err)
+		return err;
+
+	return 1;
+}
+
+/**
+ * Set @bit in a MSR @msr.
+ *
+ * Retval:
+ * < 0: An error was encountered.
+ * = 0: Bit was already set.
+ * > 0: Hardware accepted the MSR write.
+ */
+int msr_set_bit(u32 msr, u8 bit)
+{
+	return __flip_bit(msr, bit, true);
+}
+
+/**
+ * Clear @bit in a MSR @msr.
+ *
+ * Retval:
+ * < 0: An error was encountered.
+ * = 0: Bit was already cleared.
+ * > 0: Hardware accepted the MSR write.
+ */
+int msr_clear_bit(u32 msr, u8 bit)
+{
+	return __flip_bit(msr, bit, false);
+}
