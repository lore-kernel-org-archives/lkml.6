Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4881L4mSsTsLWb2MUbYmUwUnfio8V6ew91yhhF1JF8qC2S63v90UiQVU9t/BFDPvA4mYs7K
ARC-Seal: i=1; a=rsa-sha256; t=1522168962; cv=none;
        d=google.com; s=arc-20160816;
        b=Thh9QPsuO5mIeBs4ciVIoQZ9Q0vypw5IeXoyaPUwebaylMbWiFsc7AlrYi+/lMZc6h
         18J7cJJ+bgpDKx65y7D6OgTb/RjszO24TSoyYPVtVu2KGJah+lDXDfs6HzqerXtn4NcP
         7gyufFUTm3ns+fHhMFzs0N2ZUrV3Gevwu8zZox2BlpSn/HVyaSheET0fmJihlMcx0eFW
         Vy7cEhykbAC1R6zWcs+3HPXud6rmSyOH53HzKm4Zs2+4fkHrKJWY1RxAdmreL9Hf+URW
         7flR6Ur4jKoY2S/JhfSU6Bc1b86Q679twNW0O565cmhlFlIiKXw5+rOeBjL9CliYNu6m
         bTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=82BjhwDMFh1Lj6m4oG+ZsSWpTsb6nWMQqrINCcV8zPs=;
        b=SVXr1l5ZWqSGb3uTayhDjoL/pDaRCL0IkgOCpzeYX0DJc9jHMioRgFt40WjkM2uo+6
         KzOMnK3vWjtXr9GYcOLDn2JMX3jVnqdfDf935gJRM5ehb/P0FPC8l3NIQ+CrZF0tkvHq
         FYmt3BTOPXf4Bg5XvrEKxs7oB6eCqe2sHUGiXQspTZyCLuBOjdfTpNKCootTmi/A52fh
         xcVi7cNqVhgZRmPppaTZ7lXbWVw7msUEhArBzHpTMarpSBWA1iCQEg66P8GmWn7cMEkV
         cEaKsD4kQZGdyYWD3Y0ZyBAp4SDpHGrh7mdgzp0ZzYtCwO4HElxezyQvOSaX1ZZT63+N
         MbkA==
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
Subject: [PATCH 4.15 093/105] perf/x86/intel/uncore: Fix Skylake UPI event format
Date: Tue, 27 Mar 2018 18:28:13 +0200
Message-Id: <20180327162803.788380884@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109216126566522?=
X-GMAIL-MSGID: =?utf-8?q?1596109842441580019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3606,7 +3606,7 @@ static struct intel_uncore_type skx_unco
 };
 
 static struct attribute *skx_upi_uncore_formats_attr[] = {
-	&format_attr_event_ext.attr,
+	&format_attr_event.attr,
 	&format_attr_umask_ext.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
