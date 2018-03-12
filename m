Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsSiPtXaKX5lCDplhpzFgvcvEVLD8HMZvOG96cr7iER8UMdKcl6MOBumQBhc7s85f6Zfjxa
ARC-Seal: i=1; a=rsa-sha256; t=1520824064; cv=none;
        d=google.com; s=arc-20160816;
        b=WNODQCwRJ+ZoSkWYXfEzQxeb+f7J6aLXoDY2YY9gTFKF/wu8yDiuDL/KknIThuzUZZ
         3CyE1I3U3QmkwazgJV1D7NV0Z9G5pmZBAN7Ak2Fk8H8VCn+gSm/C+u+WEnapsr9clgpv
         htX3TdWNwZRu4qDPXR2H7fEnrIjF9YkY6RHfH2QptpLEpnSiQSsHuuZt1OZv3L5liwcj
         diEofFHfmk6u5LsPdkpeHGbd0JgDuDzwr/OtdB3FG6mtpABw+nfLoIjiB+JlgV4Kv/gF
         iGP+1X1s+jkVK0cSpiHSG3c9PSIggwfqUf1LATdp4zsJ9qDOQn7U3RYybhWeRBjXxSOD
         LHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=zFvAIWLBoN/cXoVpBzns1cgzNgqljSSZW67tN32+28M=;
        b=FY/NNgwrEnS3OU2Gv5ec4/xx8Q+VgAJpccHjL2ITavl68DUA6TPWwLz3ZnvCR6gjbh
         rIehZses89OZhRO7jiZI/ejWNXPUwnpNVRZasq4nlxaH0mtrZ/suK/1/U/MqV3C8aeQJ
         CS+33UyKh8kmIIDO49ece1nIvi0CEt5GP/EjWSuaw69Ra0BzfQrMip/KX1K4NTgJDGcg
         pDN0PUQIKJ0rCEqJ7YZIu4WV8J4hbXsIhlHye8lgXhfMw7RTEUNmF6dmyc60W3VE8HIW
         H+teImswSmf9ixJomhMUOSRhA66nrUWGGeMfBvfEKTJiKlAJ4+/8BztqQgGJbust2i0e
         SJog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, linux-arch@vger.kernel.org,
 "Will Deacon" <will.deacon@arm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gregkh@linuxfoundation.org, kernel-hardening@lists.openwall.com,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 torvalds@linux-foundation.org,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Dan Williams" <dan.j.williams@intel.com>,
 alan@linux.intel.com,
 "Kees Cook" <keescook@chromium.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.145348710@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 082/104] Documentation: Document array_index_nospec
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614392628315?=
X-GMAIL-MSGID: =?utf-8?q?1594699614392628315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit f84a56f73dddaeac1dba8045b007f742f61cd2da upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/speculation.txt | 90 +++++++++++++++++++++++++++++++++++++++++++
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
