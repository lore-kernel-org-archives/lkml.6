Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3105817-1517855073-2-17456948219402780923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855072; b=O4t221/T+1icO4gnsIQimxDNA4ZqcKr6QemmaeujmP9D2V7
    Yz7ZGsPOEXMAlGnOWBiSla26NopEOOPxrhezgEtfhy2zRh0iyGW8fhILXpGUlNKJ
    4ql/1LakyWGDX6SBlFFoLKAg2yIHmOaD4VlibxZzvyeSndnCWHTx311mE94nvdMp
    6jbh/e2enEXz7h0+1zBtRgZolrraofMvwxPRe7Z1nbgW9KUiOAkU++WlB423QbD3
    FsR+j5JatcIIxAvbAm1FiupH4SCj7pioGMPQbYvXYDtvYZGq2HUELqVLDHW6TXeA
    pkjdDgM7thFucGUM6C0RV+Ja4hPyEpmd980ca9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855072; bh=WCHnhvpidFg53y7qI0h4iA+hgK
    jTnAMgVyclJGoRjQs=; b=vHR+S67CJq4TGh2DuhDqiP5Mu+6SmV4JF3r3LTXg2S
    2W/CMSjpKEehziZ6FnACogdidlw4epQqlh8KcnsnbcrcQyW7JH4q4t9oxFtv2/Nu
    u0TNzq0tDm7FsH+Fm3cctWtX+FQan3KUCFdyDAcAR8yAZ+34ZpqC9SGXVsr+3rXb
    3sD65uIScGwNv8xVPL3uVT1FtyBF7W/kep26GL7/pPqmbzNAW3b0HINC+lzBGgs9
    PubtTC5rO3Naqq3PfmMKB0OoN5wxX623Vo7KxeEaMyhnaA/+KN2mDisE8pcNsFSN
    wgb2sDcHvyEqVQfQo1wcy7SzBjbIUzuTb+EGeL2Sitjw==
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
        id S1753547AbeBESY3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:24:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51616 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbeBESYW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:24:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        kernel-janitors@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.14 48/64] x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"
Date: Mon,  5 Feb 2018 10:23:07 -0800
Message-Id: <20180205182140.544674450@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King colin.king@canonical.com

commit e698dcdfcda41efd0984de539767b4cddd235f1e

Trivial fix to spelling mistake in pr_err error message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180130193218.9271-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -103,7 +103,7 @@ bool retpoline_module_ok(bool has_retpol
 	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
 		return true;
 
-	pr_err("System may be vunerable to spectre v2\n");
+	pr_err("System may be vulnerable to spectre v2\n");
 	spectre_v2_bad_module = true;
 	return false;
 }
