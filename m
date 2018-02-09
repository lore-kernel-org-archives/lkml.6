Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184958-2-11739376612962792134
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
    t=1518184958; b=Flx6jc5fp29gdnK5j47k6pi+JOq9lMzA6iBDFMEo+WT2NlH
    FDzPOvogNCJqx/YThrefVrZ4QTCI1sRdbwVPjm0evYgreJFbLtZLyntdI8O3lb8A
    Zt2A0EzSCrQsGA9FNU6tcxJ9r4zUFXHeenK9go99eCHPB6QJ+hHxzA1XMb8c6KAa
    lUt9QwL0Nb9up0KUnPop7oT+EFgI1BDUO4lLlg0QJhNW+CnEEhSBMj8mGX8g6kcX
    w6UHtCZHfV9T/+mFJjyPc0RJ9S7HP12kPqPtFIWhZa8l0fykib8vFV4t7RTBqXlb
    m8Yl+6buBjqYMdviKA3i1PY4eyzB2B+nfX8MWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184958; bh=iLvjzKMtSX3l9m34dmBJTlq6Vp
    i4MjGj+QyxqHeMKv0=; b=r5QmC6pe6maX4fBynrzdKgIWQ2FKeEPGEL0+KbLZIU
    ob87toX16aHlJy3T3RCbf4NrMQMUP3oyUNfhocHJ1AmoGek/TSj1q0Vc8VuTmJXz
    GvWE9JJvTovVmFSyJBFffp1viIfSOWycTYNFnzmzJ43d6pneHvqXkl2dQz0B834J
    sFWUp6eBRmlsGvlZ9ixJrDT9EN65b+u2QdYr5Zh4Q26ZQlSeL9OMpC5RJLkEXaBq
    0ZfVyWtTONIwrSz9zgo7Krx+LIx1Bo7u+IqKtBKj8d9nPfCuGxBIRW7FM+HrnyB7
    tIUmVHyNV2G04aQvxxMNVjgzAmSd5+/kft6HQqxIBf8g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeBINnn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:43:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbeBINnm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:43:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Garnier <thgarnie@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 74/92] x86/pti: Mark constant arrays as __initconst
Date: Fri,  9 Feb 2018 14:39:43 +0100
Message-Id: <20180209133936.577598802@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>


(cherry picked from commit 4bf5d56d429cbc96c23d809a08f63cd29e1a702e)

I'm seeing build failures from the two newly introduced arrays that
are marked 'const' and '__initdata', which are mutually exclusive:

arch/x86/kernel/cpu/common.c:882:43: error: 'cpu_no_speculation' causes a section type conflict with 'e820_table_firmware_init'
arch/x86/kernel/cpu/common.c:895:43: error: 'cpu_no_meltdown' causes a section type conflict with 'e820_table_firmware_init'

The correct annotation is __initconst.

Fixes: fec9434a12f3 ("x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180202213959.611210-1-arnd@arndb.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -861,7 +861,7 @@ static void identify_cpu_without_cpuid(s
 #endif
 }
 
-static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
+static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
@@ -874,7 +874,7 @@ static const __initdata struct x86_cpu_i
 	{}
 };
 
-static const __initdata struct x86_cpu_id cpu_no_meltdown[] = {
+static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{ X86_VENDOR_AMD },
 	{}
 };
