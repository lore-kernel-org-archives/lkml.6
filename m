Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48nJIyeBpmxCKMDdBz2rfN+crNH1KAUFDug5KnpC6i24wEL4RG/6zcICV7KTqfNQ3Y54tOV
ARC-Seal: i=1; a=rsa-sha256; t=1522168660; cv=none;
        d=google.com; s=arc-20160816;
        b=NCESf0Nv6Mh39dipKhWc76YUZjHpZ6GPGSSy97XU2j5ZxqZhKkdl5ciIQf29rMe+7G
         ZHZ+MxIPcXvU1WAqaWi6BkFhlUTipBhrrKezSeWxIauedZmLBEEzxbStP4gocS4RmQHE
         fC6Zk0hT34ay16bJ91YASywiG5krWxcsGlHjK6TJvYbg2QgbZqup+hDW4ijyBJjUynSl
         gJRRjbaDBLmK5HXikhT6SzxBTMf+TRVs0EMP1VE2joTMPCEnpiEojGa/+NFW2JmDU7bL
         jxZ6RcHVJqW9lzvc09snMiKtV80PdXzdKVKcQUrkGGkCMr2rbJc2ty/Sb9FBemfXqhLs
         gZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IMj+5brXNn8XX9O/NExx7u6Fpwn4prnEfRwhDmrq+qE=;
        b=U1GhZCaM7qal879OzRPTs8rIm2pxp46R4nd9iEBT5H+1n+qd/ZQbiyhQ8+aZgQKjMu
         4vavdA1pkQpooHq3fYDp2BbKq/PM5zzqyX2ggJc4sNZkPTN/Z3DT+dl+YWUTCZofnne/
         USxbz7vBh1LLIP6H7ibr1Tss/PUAyZchkEpYgU5TR6zmfBnNfnkkjLUlML11amhSNYyk
         1gErqc9M1cAIrw5qrg3iXFsWXqIc6nbHUQ41HAUwbPuESOJDaQ+tq3VlXkVJvX2KuVqo
         pqYILX1e0jAhW+5v4mtRzyA1SWz9+vrLBMhDBw7EuLc6Xr3f3ujTGy77PLJ1DhRiHIF0
         z4hg==
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
Subject: [PATCH 4.14 087/101] perf/x86/intel/uncore: Fix Skylake UPI event format
Date: Tue, 27 Mar 2018 18:27:59 +0200
Message-Id: <20180327162755.402410557@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109216126566522?=
X-GMAIL-MSGID: =?utf-8?q?1596109525441216133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3598,7 +3598,7 @@ static struct intel_uncore_type skx_unco
 };
 
 static struct attribute *skx_upi_uncore_formats_attr[] = {
-	&format_attr_event_ext.attr,
+	&format_attr_event.attr,
 	&format_attr_umask_ext.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
