Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524669233-2-8033316168735781892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524669232; b=tKDpPdBX+6bNkj4uxUFCFdJ2tEC1pN0rSOfruIDNuBTrNd3LXJ
    zKiixkFPM/Fne6CZJDRNo5l5AIr9XWWz5ev/C7zYCNsHVyF+sS6kt3N2qtK2FKJh
    1TtCCOZdpXHg6R/eo3/r9BPltAtAXbP3YITnBioF86kIZzhidPzCfEoSL1Vc4wQg
    9aaa4RbVUmNjDlKz8Z66zychHSdUwrElgwcLE7z2CH7QptGynTtGJzcmVQ0zmFIc
    4DhoJ4QS0LgHNpC3ajE2Ow9iYMPgytnG6JsR2m/kIElis85y8LmFe2SLcjZMszIp
    e+q8z2Km/fSSEqxapUFS7xabaaQAHB2sm3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669232; bh=
    dD9ilnbSt7ngRxD4OQwY+h9xAMs7la8MYipbcP4yibQ=; b=Wp6x8DWApPHIuEss
    KQUF8V+LmcC/mR19B6f1BVUeFJwdY9Y8//DiNZU8QgtIO4D9S0MpIgSqhgRF9ipI
    UgCfJx1U3fxARxCy+MMBEmWJxRo23pIBXLLfcZ9QoTA2aTjswxZNXdbcmGw6a3HC
    IpAO0tBIp0jIECFJWlJvoRl5pC6Ufcd3tqHczYXMxt+58xGcSOTlB6eKqsNh4Ye4
    MRwPYcHzvHrQq0zXtSOhZBHp4CFMMM/R74Kn/SXUHe9WQiQm5xxVqIA/Oqss5nrw
    ie4PAvi1qOSdpiIAFSWngNzwdqD7AgtRZl6YbUqAY3pu0oNr0zpQADtq1Cy7NMiK
    d6Bi3Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEduGPbWbiJ52sOW8BZXOuxjimkc5iR5uxHNU7/21Z2Uj5EW9V9DOF1pOLCDbh8Mkx3KT93NXVqT1IUiv0TdcVaDJdl6WoATdlGVFBd7/fW1lkVAtTFB
    HBfzSTAIrsdntiTS8Dcf3vtOlVDxR06hRpkrWhtTpBW6/F5q5ABqz5sSPagN0G0hJUw1+8IbOTpCEDIRFkfb1AL6ZTDAXLcA1c3Kv0Zfr5yp6oHIu6+HdntY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=nfMvwj1s_EtHegV2GFMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755109AbeDYPND (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:13:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754843AbeDYPHQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, albert.aribaud@3adev.fr,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        zackw@panix.com, noloader@gmail.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 16/16] y2038: ipc: Redirect ipc(SEMTIMEDOP, ...) to compat_ksys_semtimedop
Date: Wed, 25 Apr 2018 17:06:06 +0200
Message-Id: <20180425150606.954771-16-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Mlabpj+luf20+BILETO7JbXl11x+S63/lDeB9I8xRdnCyML+2y2
 SEv4/EcskLmyzHqtorUKLjUzHaKIwF3Ds0JuyIVnUSiBRzGFwo4mfePbv/NjOJUH7+wbjgP
 lmNVVsYy/PzzGz5xplirZQQTSika5eJxOseY0UxWAdqlH+uiS/Q2ThdtOzEu8I7kUv5JvvK
 72vyib/moYdduZzTS/ckg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SqN+npyaZdU=:2iB9BZauhQXqPesFdfkWfK
 vCbG8Vgy9eKVJKuVzfB9K58T37/tMsSYEdG8+iCyMd15rkm5zdQlv62xWWqATm1JnamavSIrR
 dOIBdlGpcbYB4xH9Mife2fCp7OBJUH3fVTNw2V7ifw/08z4c/Q0kJqO0g3f1lO0QZaGLYiNBP
 ylTKkLgcQSoOLgoDIi5sXktp/Jm3z99JasrSdmPovzve8flXC5KzbkHAR733KaU2ECqObcoHb
 meEIjmuEZdgLNXT80vCxhv7U+vkPOyxO7bVv2yvkkFYKxFUZCqELNcKwQSrbjJ+7ihgT3FlRf
 YcR6DDqEuDIA/2lfvZSyPPc9fS0BhmVvIdNNZhTo8xgwxByxHSStmnsV8I4lu7boEPgxLJFCH
 BhhoAwnIYKFA7VJSoD/4At0rDW2ZqHODq0bKsw9DF9KJXXS5Uu/QyFiQayyFT0H09/lawzzhs
 InT5i4GoJlQ7sbmeSXkFJ88kG2DnxEiJrUDyiVrBe4TaBtn4RUGT4VTCseE1lYIYT7CwYriMX
 AGT9xePhRrwJvDom+Z4537rZjggZWKyX66M0PuTgsJnTJhwekmiFkBtjlI7QzjtBMNVa7OIR4
 W4Jl92RwlQKgE0omplLfF7UPjdp4MFGW2JPNpMl5udI/k6mXxmq1YyXpYXE1eFwfFJBir05R9
 stWRpssw1H+8rGSMKvynbFlVuAPL0Rfsppk30AIFUKlYX/4rXvMuReQesL/csKce2Ewll5K9z
 ENLb1unuxr5CX6vSUO1teYurJEtv+ALHyMGYCg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

32-bit architectures implementing 64BIT_TIME and COMPAT_32BIT_TIME
need to have the traditional semtimedop() behavior with 32-bit timestamps
for sys_ipc() by calling compat_ksys_semtimedop(), while those that
are not yet converted need to keep using ksys_semtimedop() like
64-bit architectures do.

Note that I chose to not implement a new SEMTIMEDOP64 function that
corresponds to the new sys_semtimedop() with 64-bit timeouts. The reason
here is that sys_ipc() should no longer be used for new system calls,
and libc should just call the semtimedop syscall directly.

One open question remain to whether we want to completely avoid the
sys_ipc() system call for architectures that do not yet have all the
individual calls as they get converted to 64-bit time_t. Doing that
would require adding several extra system calls on m68k, mips, powerpc,
s390, sh, sparc, and x86-32.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/syscall.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ipc/syscall.c b/ipc/syscall.c
index 77a883ef2eca..65d405f1ba0c 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -30,9 +30,14 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
 				       second, NULL);
 	case SEMTIMEDOP:
-		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
-				       second,
-				       (const struct timespec __user *)fifth);
+		if (IS_ENABLED(CONFIG_64BIT) || !IS_ENABLED(CONFIG_64BIT_TIME))
+			return ksys_semtimedop(first, ptr, second,
+			        (const struct __kernel_timespec __user *)fifth);
+		else if (IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return compat_ksys_semtimedop(first, ptr, second,
+			        (const struct compat_timespec __user *)fifth);
+		else
+			return -ENOSYS;
 
 	case SEMGET:
 		return ksys_semget(first, second, third);
@@ -130,6 +135,8 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 		/* struct sembuf is the same on 32 and 64bit :)) */
 		return ksys_semtimedop(first, compat_ptr(ptr), second, NULL);
 	case SEMTIMEDOP:
+		if (!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return -ENOSYS;
 		return compat_ksys_semtimedop(first, compat_ptr(ptr), second,
 						compat_ptr(fifth));
 	case SEMGET:
-- 
2.9.0

