Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520825058-2-15400251397646813663
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825057; b=NytnCoM5qIftea0QrBMi+6KhQkjWfXp4SMCoZfsxT/V14Oi
    FT7uck6yppuIG3Sah+xsypn3fmp+g3f012PJwEnj69Ijg8OG9k51CvsVWHd3v9PW
    o1k7aYwUYdxg33gwCgVdco7/FWA8lkamUFVaLF2nDCiv3uEk/CO6BkZEnbtzwW7O
    SDc/hDeGnFrBbIatzB+64VWTlwZPMujzV4JlEzQV+52ZHZsIcsjins/Q/EgxrIjO
    8VaM7Q0uL0k2mblwQvAwJLSSrQttkf7QP6Gy8wG4x9CWN5EBH4RjPW3h0VgUUv3c
    X+TlkCz/ULMCp7LiQTGPDio7cc8oVh6OUJbI/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825057; bh=7lQic2uXw9+KwXTOpH3
    BBTE79Xj/2fQQlTZTxiR5Ykk=; b=nZbkGfrMPkhpZhmk0jvidEsprGslFbkTP3v
    rxjKh/5EFnx8c4gEYYb/NjgTjkXYTOq686P2CoXFd1A5VKgAF6IjwKfSH8dVVSdo
    8ZgIpHAAmpoQthWljo0SJqZKjCKu94c56J4hP7v7JSbjTR1nnlNDLHh5jw0zA1rB
    0c73khvpPk86DU2qxyNvWjV/f7zpFuEsaQy+NudEyNZiLnDFgRZaSl13fKHoPQd+
    Jgt9QIcX4YAaqVuo+I4iJpqGpJAvTMoHXex4bufMpbmgYXmcC7yDNEGvELMGBKou
    0mQ0gc9SpJ2Zk76xr0QeCdlZ2vvz7DEGnUwmVpTdEElCbElNCiQ==
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
        id S932801AbeCLDYO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:24:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41223 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932682AbeCLDHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mathias Krause" <minipli@googlemail.com>,
        "Rusty Russell" <rusty@rustcorp.com.au>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.677872617@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 020/104] modpost: reduce visibility of symbols and
 constify r/o arrays
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

From: Mathias Krause <minipli@googlemail.com>

commit 7a3ee7538598e0d60e6aa87dcf34a4e8a0adebc2 upstream.

Internally used symbols of modpost don't need to be externally visible;
make them static. Also constify the string arrays so they resist in the
r/o section instead of being runtime writable.

Those changes lead to a small size reduction as can be seen below:

   text    data     bss     dec     hex filename
  51381    2640   12416   66437   10385 scripts/mod/modpost.old
  51765    2224   12416   66405   10365 scripts/mod/modpost.new

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 scripts/mod/modpost.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -28,9 +28,9 @@
 
 
 /* Are we using CONFIG_MODVERSIONS? */
-int modversions = 0;
+static int modversions = 0;
 /* Warn about undefined symbols? (do so if we have vmlinux) */
-int have_vmlinux = 0;
+static int have_vmlinux = 0;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
 static int all_versions = 0;
 /* If we are modposting external module set to 1 */
@@ -225,7 +225,7 @@ static struct symbol *find_symbol(const
 	return NULL;
 }
 
-static struct {
+static const struct {
 	const char *str;
 	enum export export;
 } export_list[] = {
@@ -816,7 +816,7 @@ static int match(const char *sym, const
 }
 
 /* sections that we do not want to do full section mismatch check on */
-static const char *section_white_list[] =
+static const char *const section_white_list[] =
 {
 	".comment*",
 	".debug*",
@@ -888,17 +888,18 @@ static void check_section(const char *mo
 #define MEM_EXIT_SECTIONS  ".memexit.*"
 
 /* init data sections */
-static const char *init_data_sections[] = { ALL_INIT_DATA_SECTIONS, NULL };
+static const char *const init_data_sections[] =
+	{ ALL_INIT_DATA_SECTIONS, NULL };
 
 /* all init sections */
-static const char *init_sections[] = { ALL_INIT_SECTIONS, NULL };
+static const char *const init_sections[] = { ALL_INIT_SECTIONS, NULL };
 
 /* All init and exit sections (code + data) */
-static const char *init_exit_sections[] =
+static const char *const init_exit_sections[] =
 	{ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS, NULL };
 
 /* data section */
-static const char *data_sections[] = { DATA_SECTIONS, NULL };
+static const char *const data_sections[] = { DATA_SECTIONS, NULL };
 
 
 /* symbols in .data that may refer to init/exit sections */
@@ -912,8 +913,8 @@ static const char *data_sections[] = { D
 	"*_probe_one",							\
 	"*_console"
 
-static const char *head_sections[] = { ".head.text*", NULL };
-static const char *linker_symbols[] =
+static const char *const head_sections[] = { ".head.text*", NULL };
+static const char *const linker_symbols[] =
 	{ "__init_begin", "_sinittext", "_einittext", NULL };
 
 enum mismatch {
@@ -935,7 +936,7 @@ struct sectioncheck {
 	const char *symbol_white_list[20];
 };
 
-const struct sectioncheck sectioncheck[] = {
+static const struct sectioncheck sectioncheck[] = {
 /* Do not reference init/exit code/data from
  * normal code and data
  */
