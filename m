Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518185122-5-13184381184509365932
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
    t=1518185121; b=uUXdtLuTMQ58YN/psK9lMox+LOtSrhbbZ7kiPgz3bg62ka4
    tG8fg42hJW91BWGhvNKMPjKHZpv//a0QzGW4vhjP7PhcpMCRzuejiNn3H1tZtOOf
    23raYPnqHaMEmj4TJ8Ekr67s7lC/TNq9yWJ/8qLyMikoH6ehZ/HXHPqhdcB4v1GY
    Q9Cq5FpakBFj6WLVsKB4g51J60TEqT5dUAvUA3ohNEf7fcIk5A+V1lMGQ8iI7RJC
    jfaQvH+Ji3eo7/gRz7CRnYmMzeMULA2ydlhGKW6ND8qJiXxy2Q3j945+v7Twnl6p
    vpzg8nx9cXfDRin3XN5CpvYpiay0W11ZOdFMIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185121; bh=0D53RnkAorhdU55IK3m3MB/u3w
    R35sTpGzI+Gmxa6y4=; b=abaMyB2WI/3v6yeCLepXl17gw7wKsGeOMI7V1VS7wm
    Pz1X/5eTtI9Zwfac8IDU2LREoTMY2wijkv5WwooXYnCMdVvVbmf2WGufeoI/Onbd
    lOAYqtUMc3ejQ1DF0AU1NS4r1zORxl+9WbQKz/F0lWnYFTEVzbNKf3zXe031ZUGQ
    Gwb3/EangVRU8X9UOblCotzHNJy7VF4/Kd8yjhmJxId43bIvUinQMWg3eKFaaNNM
    WUqsLLmmo1J2euZzdN1wYvXyt1F053wlbqeG/KGqB4M0LBfwxLdWg+9d9NxeLQ9l
    btuiffHM8VWw8t6iH29Z9sFB3e5gAvCvnW77xC0TTnPQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBINnU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:43:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50514 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBINnS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:43:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        torvalds@linux-foundation.org, alan@linux.intel.com,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 63/92] x86/get_user: Use pointer masking to limit speculation
Date: Fri,  9 Feb 2018 14:39:32 +0100
Message-Id: <20180209133935.811950747@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>


(cherry picked from commit c7f631cb07e7da06ac1d231ca178452339e32a94)

Quoting Linus:

    I do think that it would be a good idea to very expressly document
    the fact that it's not that the user access itself is unsafe. I do
    agree that things like "get_user()" want to be protected, but not
    because of any direct bugs or problems with get_user() and friends,
    but simply because get_user() is an excellent source of a pointer
    that is obviously controlled from a potentially attacking user
    space. So it's a prime candidate for then finding _subsequent_
    accesses that can then be used to perturb the cache.

Unlike the __get_user() case get_user() includes the address limit check
near the pointer de-reference. With that locality the speculation can be
mitigated with pointer narrowing rather than a barrier, i.e.
array_index_nospec(). Where the narrowing is performed by:

	cmp %limit, %ptr
	sbb %mask, %mask
	and %mask, %ptr

With respect to speculation the value of %ptr is either less than %limit
or NULL.

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727417469.33451.11804043010080838495.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/lib/getuser.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -39,6 +39,8 @@ ENTRY(__get_user_1)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 1:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -53,6 +55,8 @@ ENTRY(__get_user_2)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 2:	movzwl -1(%_ASM_AX),%edx
 	xor %eax,%eax
@@ -67,6 +71,8 @@ ENTRY(__get_user_4)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 3:	movl -3(%_ASM_AX),%edx
 	xor %eax,%eax
@@ -82,6 +88,8 @@ ENTRY(__get_user_8)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movq -7(%_ASM_AX),%rdx
 	xor %eax,%eax
@@ -93,6 +101,8 @@ ENTRY(__get_user_8)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user_8
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movl -7(%_ASM_AX),%edx
 5:	movl -3(%_ASM_AX),%ecx
