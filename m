Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+7NHdopAccBSYs7xUnAZRO13H/+uOa4F7bAPj3AlDvyCV3APVh+4whYmiB7EV/X2FwW/OU
ARC-Seal: i=1; a=rsa-sha256; t=1522168366; cv=none;
        d=google.com; s=arc-20160816;
        b=WSN2YSkeYWqoGq8agLvf+zzkGYKdwhSGzz3seAmx+kw0cMrqAbLVn3ltIaiCv9V1xU
         Hp22evo1RcjkIf0S0bVlFmZH7fKyEfHnnTjYgdLyyrq9bshX91I7lJf3Ym4cr0jJbGDY
         iijeUnprYxm0JU5RijnJnFaQw+DWgGqcfi9VRh8gMkTLAN8jZ+IJqtfElZaA/puCyDmL
         MxD9uK4L1qBX+yrw6h6mY1gIjCsyeWCZv6YN6YUDSHP4t9U5P8zNq1OM6RDBKPCQm1px
         deTUHYt5DeiKHpLX6zC8nyJC2eX7L5hDrsiByMGDeXB5ydslyw1q/8E1vaG0W+3WY3cs
         v5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5lH+uaxkzIvb1Dx/ouE9yIMDh1u+GYFZzQQpDjS7T+w=;
        b=pz0r4PBxocL6f8uhLalfWkEyjBFSrvUot9M4gezY11mfpllbMwk+HcThuxq5vGiO7/
         zpgGYmTgr3QvLcZpk9qIWWYidLLQ1w39Jo3p7Wk2b+epavFkN0DDzRIEJFhNGFTORDXL
         gcShp3+jfEUJ8H8InewpP/5abF9W93Mh50nkM1VhQIG0EjtnvM0IDztY57bBNjDa42VP
         oZt2SYABFMfiQHUTJpmhHVemdRGCDxxHkQ+9DrF5IfVUsmSe6NHzCt1OH7m//8maymm0
         3/26IDWM0D1Cbhgy9qJ39CsyWOiPdSpZOGI6y/MxIZB37ssfRK4Dhv0kCU6Ok+2K+YC1
         uq1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 54/67] perf/x86/intel/uncore: Fix Skylake UPI event format
Date: Tue, 27 Mar 2018 18:27:46 +0200
Message-Id: <20180327162730.541010219@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109216126566522?=
X-GMAIL-MSGID: =?utf-8?q?1596109216126566522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit 317660940fd9dddd3201c2f92e25c27902c753fa upstream.

There is no event extension (bit 21) for SKX UPI, so
use 'event' instead of 'event_ext'.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Link: http://lkml.kernel.org/r/1520004150-4855-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/uncore_snbep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3566,7 +3566,7 @@ static struct intel_uncore_type skx_unco
 };
 
 static struct attribute *skx_upi_uncore_formats_attr[] = {
-	&format_attr_event_ext.attr,
+	&format_attr_event.attr,
 	&format_attr_umask_ext.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
