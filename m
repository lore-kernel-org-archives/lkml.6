Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvMLUP9IzEX3J/BCpJcPqFThx68Vbged/KKC2aCGfOVI7O+H/OdKRsxwXCksnNg8bqNjQy8
ARC-Seal: i=1; a=rsa-sha256; t=1519411252; cv=none;
        d=google.com; s=arc-20160816;
        b=DKCzEBLK3slUm1a1gAMYKsQLsMY4ZJ8JdSIuGp3WjCv/b4iBXMLvcFG1yUiSrwq7V2
         TxCYaQj2i78nvs0a1+w7+3YYmC0mAe20wWucHLjw0GpL371q11zNqF5z97w9Yx1zAAGi
         aTLt0rE6aEy4Gfe4xjlzzuBF3MmjkRAl3kuO8A2KLyFUPPnXmTP1f4CzIeqQ4SKulWrQ
         4Wky6rfa5PWRPdQ9/jxHQfPZrKVTkLX/Kmykwfs7g7EpkbRWWjSXyF7vE84u9+Sfxox1
         fA9AHOIYd4bN+YiwEXoOeIsN8wq0K2Swtr+Gedz5+KuueOPUsaiHnTdNeMD63mzKR3PP
         mDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FbyFLFVtMqH4EXIpOD7ujpnnqAehzxdPOLiAEU/QEAg=;
        b=oJD9PC58p6kspZUss6KknYGGfKGtpN+bdqVsSkWNCsbEjZLRfAb88jonsF7eQ2Jr3c
         FkxtadGq4IAGgS1s//x+n5oSI1tXlMgCg+ibl1rzCMSvXCGOZvuRsNbL0Uljqxy3YBQH
         iHQMF0MT/LGcTdtXXe/Yf0vqxSNlla2Y3aajZ0LdoP5+WDNR+FOmrc478ysmAwT6z1uI
         0y2ivFlqzhPYKspEsbAxrz3aYUTH8bQVbmL7xIEEXx84xwbwMdU2I8i/V90DL6U+wJ1M
         q1jJw7W28ulSoG7U2LD1E8Gz6YXQc7t5C2YDA2WjFurTbCotjwZahaycRAqIaqPmSnpO
         GP5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kees Cook <keescook@chromium.org>,
	linux-arch@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	kernel-hardening@lists.openwall.com,
	torvalds@linux-foundation.org,
	alan@linux.intel.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 173/193] Documentation: Document array_index_nospec
Date: Fri, 23 Feb 2018 19:26:46 +0100
Message-Id: <20180223170353.126016056@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218174234829623?=
X-GMAIL-MSGID: =?utf-8?q?1593218174234829623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
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
