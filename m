Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156074-2-2898698480278178965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156074; b=hheF/eTTUF41M5abxAh7DJEbKoFEh+GdoY51+vh4F0B8eS4mPp
    1bbGGEvbdqcQBEE8T9jg1Yo6N3au8sfa62j2FW1IO/NzDhDUBJhlEX9CHmA9RFmK
    pDMNwvJ6ZwBA05GvR0Nrs4mp+UDlgtVUwBb+nBacLAlMpEkO+/WF1ADNujAcISYV
    woKQJvUBQiPIeFT2wK5LDjDAl95OW1zai3nNzuH8YGXWvfTbCMEfJ9oYS3gGTZB+
    p+NBVD1qFo9iGGt/HrByIz7PQgGNMCtIsdaMGRI7k0yEpa28Bpk5Zi1OUQQHDFag
    mCkRJsEN6W6ncUTCzisAK/mIqmk2ryv3sR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156074; bh=BohMhZaUjqYHv3/FkTitoJ9rb/5Sj3
    NI2Fp3GbCLbdM=; b=I9vwm6tpMX8kTtSaxsKb4sjqGjyKFjsJ5OaJX+W+f3/46N
    grf+ztG4geqgEMmUUuyvYDFMkjciS0YjwjK8VdWt0czNPr1rRnRxXojjtkIGMIEB
    mhKSbYSLg7Ggqj6ymUzQa16y8B4+9W1DhdC+uVv/39XuU05vLZPN2Hv0LoGaASFD
    yilTm4HvuytUCD4M7cdIW7Gy4U85JFF10X3ygd08A7h/4hYhkMKfbFLsqqPDi5wi
    8urcs1jhGMLZkURaba5sQc5HuXGFcskHYeFW3qir9djHjbWPGY7cklqQLp39R7nE
    d93h7qbi+P5Ne315JG5HXAmQObYfvfRpwf+cYvTg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=w0XDwybQ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=w0XDwybQ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB6y78ENm37slUOfju5LpV28UfLcNh41GHBVvVFZ7wSyM2dUaiBhnSZZOB/0EBfgPnAw4FS/2qOlfobFLwoRJbJ4U4Ay/eSByrlzZdRdojyJi+ocEYtd
    NLRjSjC8hHblbc4ablrdaOPL98DjBHQRzZ/vF8E4jcNSwdCjq4fq3g0Alp+9ZfmppRpN3DbDILoveNwvjJF27mKEaW8G9q4W495Iz20eEYan3aR82hDfVkQD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=XyMwAGQSYJT2K2sAP5MA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030880AbeEXKBI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030878AbeEXKBG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 051/161] s390: report spectre mitigation via syslog
Date: Thu, 24 May 2018 11:37:56 +0200
Message-Id: <20180524093024.568592676@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit bc035599718412cfba9249aa713f90ef13f13ee9 ]

Add a boot message if either of the spectre defenses is active.
The message is
    "Spectre V2 mitigation: execute trampolines."
or  "Spectre V2 mitigation: limited branch prediction."

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/nospec-branch.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -32,6 +32,16 @@ static int __init nospec_setup_early(cha
 }
 early_param("nospec", nospec_setup_early);
 
+static int __init nospec_report(void)
+{
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
+		pr_info("Spectre V2 mitigation: execute trampolines.\n");
+	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
+		pr_info("Spectre V2 mitigation: limited branch prediction.\n");
+	return 0;
+}
+arch_initcall(nospec_report);
+
 #ifdef CONFIG_EXPOLINE
 
 int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
