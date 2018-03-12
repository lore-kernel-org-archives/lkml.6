Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520825288-2-1112850892287919844
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
    t=1520825288; b=guvdYRFL+IBuFvR8ONJ2s2SANvPCyOHo6TFywO7rj8/oF9C
    OnMdvV00MH5A5zXdFWhYn07R6dZrkNEuLIQaCBCvEbI2Kn1ljpdJs32A720FluYm
    Z0EuXnMAucNDoUxSBGwGgBMv1Bn6gadLmjEREZOR/DUZowmrtWxYiSbSJFKHnW8a
    /xFo+KCLvi/Dskf+DYdj6XUmddnFGMsfgLroVcyn5Sat0ULiSXBSAuAtapgQk3cS
    0RaQ1smr3aL+jpytCRygZYWFAWwFsaL7Lf7Ni0IiU6wdPyZhclcMMrW66NWXTEZ6
    LyPfDw6i2gRIIe72JYnIATUMw8MRqKBEmG8Is/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825288; bh=hH1bTNzYj3RChreKFa+
    muluNJVA+ymz5RZn0H4YKBm8=; b=aIN+purqxurWbAJujI0ubFWbCBFMhIkMysc
    6B7adjNl0HSHA0OCXjHZDQyziJMVl8Ii2Xa2050UfAU+QI9ykhjxOBGqCQG1Biez
    DJiftuNzRh56NszAV2SDJNJwP2WeCYzpZqBAHkjydTvSRYcV6A/zLCkqeglGOTbT
    tCECzAZHtzLSiVNFq8KdkS79l/7RR+TDsL5JYH3U5VJti9+9M4524QRrC0G0HLtm
    Wyzns2S+wjsOzskK0NWisRb5ErMUJ7AKnvIP34/7yTBLuRH9bVw3fZWvVASawfDo
    9oP/l7NuStwT1p9Mw+PhOJ5NmcsOnhTUioRV0JU35e9dahKB1lw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S932516AbeCLD2F (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:28:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41200 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932674AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.109606626@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 027/104] kconfig: fix IS_ENABLED to not require all
 options to be defined
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

From: Paul Gortmaker <paul.gortmaker@windriver.com>

commit 69349c2dc01c489eccaa4c472542c08e370c6d7e upstream.

Using IS_ENABLED() within C (vs.  within CPP #if statements) in its
current form requires us to actually define every possible bool/tristate
Kconfig option twice (__enabled_* and __enabled_*_MODULE variants).

This results in a huge autoconf.h file, on the order of 16k lines for a
x86_64 defconfig.

Fixing IS_ENABLED to be able to work on the smaller subset of just
things that we really have defined is step one to fixing this.  Which
means it has to not choke when fed non-enabled options, such as:

  include/linux/netdevice.h:964:1: warning: "__enabled_CONFIG_FCOE_MODULE" is not defined [-Wundef]

The original prototype of how to implement a C and preprocessor
compatible way of doing this came from the Google+ user "comex ." in
response to Linus' crowdsourcing challenge for a possible improvement on
his earlier C specific solution:

	#define config_enabled(x)       (__stringify(x)[0] == '1')

In this implementation, I've chosen variable names that hopefully make
how it works more understandable.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/kconfig.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -4,29 +4,43 @@
 #include <generated/autoconf.h>
 
 /*
- * Helper macros to use CONFIG_ options in C expressions. Note that
+ * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
  * these only work with boolean and tristate options.
  */
 
 /*
+ * Getting something that works in C and CPP for an arg that may or may
+ * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
+ * we match on the placeholder define, insert the "0," for arg1 and generate
+ * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
+ * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
+ * the last step cherry picks the 2nd arg, we get a zero.
+ */
+#define __ARG_PLACEHOLDER_1 0,
+#define config_enabled(cfg) _config_enabled(cfg)
+#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
+#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
+#define ___config_enabled(__ignored, val, ...) val
+
+/*
  * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
  * 0 otherwise.
  *
  */
 #define IS_ENABLED(option) \
-	(__enabled_ ## option || __enabled_ ## option ## _MODULE)
+	(config_enabled(option) || config_enabled(option##_MODULE))
 
 /*
  * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
  * otherwise. For boolean options, this is equivalent to
  * IS_ENABLED(CONFIG_FOO).
  */
-#define IS_BUILTIN(option) __enabled_ ## option
+#define IS_BUILTIN(option) config_enabled(option)
 
 /*
  * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
  * otherwise.
  */
-#define IS_MODULE(option) __enabled_ ## option ## _MODULE
+#define IS_MODULE(option) config_enabled(option##_MODULE)
 
 #endif /* __LINUX_KCONFIG_H */
