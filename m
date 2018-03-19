Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs5/X2npk4Nv+CXmgnujSLmvLQckkU6vfSA/Ul00iqoQ1oWd4jkf9hwALyeDC8Ymi29TmYC
ARC-Seal: i=1; a=rsa-sha256; t=1521483317; cv=none;
        d=google.com; s=arc-20160816;
        b=f0HUlfFEDEH55GICsg5hSxaniH9RLvZfAIoCat0wfEFXEQ8WHKbuh+JbYwQODZ1eup
         xQkJMk2qnILBRw0KyJlmxQPiRGSFLYDd/2K7NF8UPzJpryg7+leMiLVaO7m/PgBKnGd/
         0mrJD0hK4NL5+ScaIgpVDY0buJDA7c++55GFUrUJsL+Z1cEVZfiVWcRqPNqDIjeFMLQF
         4Mti4qt7jwravFhmoPcqiJ2WcaIEq6Z3AAzomr2AwaVHypuYpgaLEhrVTJ5x6ZE3JLJC
         eC1Tjz/hwLWWHT8aYhKr8x+MonSsnLnP9Z2Nlb5ztmYwGlQSMPURHos//hrdanbzIhMw
         q0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9uxrGcCuFN0NE0PqcT7uZm676QmAxNG+shrxhQkiRYQ=;
        b=OuEQoQJpifcvgh1iS16g+cku3uRsT0CkFVuEkggqUZSeHErEV0epIzlOs9ljlQywAs
         T/PCjpVzxOpfELKAtEPR33Mnq/KlLKi1e76zwSSX7oiX5ZKV/N4tM69vx5Njyvc/T48s
         aTynYyjPpPiA2PKZGwtyWzecLV1QlBSw78Amqj7iQDAklETxLfG32CUZ3kpy0QzzKWdi
         5sXEMaHOT5Vcpe6jbJTdP8jYtEp6Ixuw+gOuAVWJtpqwuB9qcE6l2L/xhTTHHlHr6LwE
         b9hWt/pJFnMSr62bXdlsV+qoXtzp+EYIvsoaTQPlJZHZo/E8Y15H4YLuYnTwKLKTdOCB
         bv7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Carrillo-Cisneros <davidcc@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	He Kuang <hekuang@huawei.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Paul Turner <pjt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Simon Que <sque@chromium.org>,
	Stephane Eranian <eranian@google.com>,
	Wang Nan <wangnan0@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 072/134] perf session: Dont rely on evlist in pipe mode
Date: Mon, 19 Mar 2018 19:05:55 +0100
Message-Id: <20180319171859.667052979@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390656543207317?=
X-GMAIL-MSGID: =?utf-8?q?1595390891400557113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carrillo-Cisneros <davidcc@google.com>


[ Upstream commit 0973ad97c187e06aece61f685b9c3b2d93290a73 ]

Session sets a number parameters that rely on evlist. These parameters
are not used in pipe-mode and should not be set, since evlist is
unavailable. Fix that.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170410201432.24807-6-davidcc@google.com
[ Check if file != NULL in perf_session__new(), like when used by builtin-top.c ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/session.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -135,8 +135,14 @@ struct perf_session *perf_session__new(s
 			if (perf_session__open(session) < 0)
 				goto out_close;
 
-			perf_session__set_id_hdr_size(session);
-			perf_session__set_comm_exec(session);
+			/*
+			 * set session attributes that are present in perf.data
+			 * but not in pipe-mode.
+			 */
+			if (!file->is_pipe) {
+				perf_session__set_id_hdr_size(session);
+				perf_session__set_comm_exec(session);
+			}
 		}
 	} else  {
 		session->machines.host.env = &perf_env;
@@ -151,7 +157,11 @@ struct perf_session *perf_session__new(s
 			pr_warning("Cannot read kernel map\n");
 	}
 
-	if (tool && tool->ordering_requires_timestamps &&
+	/*
+	 * In pipe-mode, evlist is empty until PERF_RECORD_HEADER_ATTR is
+	 * processed, so perf_evlist__sample_id_all is not meaningful here.
+	 */
+	if ((!file || !file->is_pipe) && tool && tool->ordering_requires_timestamps &&
 	    tool->ordered_events && !perf_evlist__sample_id_all(session->evlist)) {
 		dump_printf("WARNING: No sample_id_all support, falling back to unordered processing\n");
 		tool->ordered_events = false;
