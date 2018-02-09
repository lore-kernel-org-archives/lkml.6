Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185194-2-7512863963730737900
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
    t=1518185192; b=YLF/Gzhi7F2SwrOPIUWCG7GvPbX2cBlJ2VL00aGE2DRTusk
    /tWRYddGkwtq1RuvzIeEHjWgt2PjHTQZ8LNfKsPdKaeQ/OP9x3uLyD6aQLSGI0zD
    ztRlulytOQoHcens0mn9ZBmkdtiKuYcKJpLqsCjg8GNu5fh+0Z4t/v+G9rNgkDbk
    0FQDLpUiuuADNsHj3AZ0+iHiCEspNWMjyPIC/tLFt682bolU2PgiPpiadmsXZBD4
    HdAjRekOxsu/6fKlKyFM4l3ydhwgLk3HZ45su3zP9pqIFdjzXGoaLQ6XhkHBfQTd
    Zbar2XShErJPiMg2FGYD7B+V4j94zC3idJvGpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185192; bh=68sidBXRhfeKSC1Y7RWV2FTYwW
    mdfPLcsajhuCVHN2s=; b=XtYyC8XwOER7VhQ9hv2QGc5F33mOLxAr4JIsH0ZWYT
    3F4GT1Xp30kL+nlc2YlxRoE4ld6wPSPbpDnVK9NfOid3PuSjlMwzwubzO7lmsRdc
    5pO96wpOqnnYrHBVElSUGhSk5lTfmhrSMMKzUrMUBQ3fbYGu8aXJfun0HvRbXUqR
    eP323AIL56RFOfCwfH9syv/16ysYJpZNbc3cyaI1paJLBMoS3mZEucqkezguaTv2
    ezr929MSCS1P4BynJqT/aS8tcorLe61PczVD+yccQcJFnhi4uSG8ZPzjH91QzdRK
    D5JVHDNANehkbG8+sX7LR6a8Hm/IrL2eZ5L82LPVYKlg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeBINmu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeBINms (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel-hardening@lists.openwall.com, torvalds@linux-foundation.org,
        alan@linux.intel.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 56/92] Documentation: Document array_index_nospec
Date: Fri,  9 Feb 2018 14:39:25 +0100
Message-Id: <20180209133935.257746808@linuxfoundation.org>
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

From: Mark Rutland <mark.rutland@arm.com>


(cherry picked from commit f84a56f73dddaeac1dba8045b007f742f61cd2da)

Document the rationale and usage of the new array_index_nospec() helper.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: linux-arch@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: gregkh@linuxfoundation.org
Cc: kernel-hardening@lists.openwall.com
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727413645.33451.15878817161436755393.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/speculation.txt |   90 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/speculation.txt

--- /dev/null
+++ b/Documentation/speculation.txt
@@ -0,0 +1,90 @@
+This document explains potential effects of speculation, and how undesirable
+effects can be mitigated portably using common APIs.
+
+===========
+Speculation
+===========
+
+To improve performance and minimize average latencies, many contemporary CPUs
+employ speculative execution techniques such as branch prediction, performing
+work which may be discarded at a later stage.
+
+Typically speculative execution cannot be observed from architectural state,
+such as the contents of registers. However, in some cases it is possible to
+observe its impact on microarchitectural state, such as the presence or
+absence of data in caches. Such state may form side-channels which can be
+observed to extract secret information.
+
+For example, in the presence of branch prediction, it is possible for bounds
+checks to be ignored by code which is speculatively executed. Consider the
+following code:
+
+	int load_array(int *array, unsigned int index)
+	{
+		if (index >= MAX_ARRAY_ELEMS)
+			return 0;
+		else
+			return array[index];
+	}
+
+Which, on arm64, may be compiled to an assembly sequence such as:
+
+	CMP	<index>, #MAX_ARRAY_ELEMS
+	B.LT	less
+	MOV	<returnval>, #0
+	RET
+  less:
+	LDR	<returnval>, [<array>, <index>]
+	RET
+
+It is possible that a CPU mis-predicts the conditional branch, and
+speculatively loads array[index], even if index >= MAX_ARRAY_ELEMS. This
+value will subsequently be discarded, but the speculated load may affect
+microarchitectural state which can be subsequently measured.
+
+More complex sequences involving multiple dependent memory accesses may
+result in sensitive information being leaked. Consider the following
+code, building on the prior example:
+
+	int load_dependent_arrays(int *arr1, int *arr2, int index)
+	{
+		int val1, val2,
+
+		val1 = load_array(arr1, index);
+		val2 = load_array(arr2, val1);
+
+		return val2;
+	}
+
+Under speculation, the first call to load_array() may return the value
+of an out-of-bounds address, while the second call will influence
+microarchitectural state dependent on this value. This may provide an
+arbitrary read primitive.
+
+====================================
+Mitigating speculation side-channels
+====================================
+
+The kernel provides a generic API to ensure that bounds checks are
+respected even under speculation. Architectures which are affected by
+speculation-based side-channels are expected to implement these
+primitives.
+
+The array_index_nospec() helper in <linux/nospec.h> can be used to
+prevent information from being leaked via side-channels.
+
+A call to array_index_nospec(index, size) returns a sanitized index
+value that is bounded to [0, size) even under cpu speculation
+conditions.
+
+This can be used to protect the earlier load_array() example:
+
+	int load_array(int *array, unsigned int index)
+	{
+		if (index >= MAX_ARRAY_ELEMS)
+			return 0;
+		else {
+			index = array_index_nospec(index, MAX_ARRAY_ELEMS);
+			return array[index];
+		}
+	}
