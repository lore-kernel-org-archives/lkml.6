Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu8FKafMRUCHeyZ1W8TAI5G3Y0E4FtA6ZmpcKV6iMNJZJEInZBbqZyDQj29d+iacpLglOHX
ARC-Seal: i=1; a=rsa-sha256; t=1521483963; cv=none;
        d=google.com; s=arc-20160816;
        b=ZTJxMdvv/U+TV9yDcg1zL8/2+XffAzi2UQAqAH8ma8KKYIP7EmQD05isOLmIoPAkEC
         ZkWAcMzXIVoTpT2EI2TKOIBQLDN9H8mewRBC9holRMFPbBagb6tu8bznsE3GsSHY05nm
         DXFqADbUgedsN+hD1jRh23yeWZK2UQEyl3dFgdrlAC0PJXP+oXY7gbMUVshm9k77qodY
         +X5IaMxYu+ExkPgTkf46bNhn/TwFl+avkqXg1QCBRWto2K/q5tf42qZWuGh14eZEIUJo
         I2/qJfOazcDmDj+cOxem30/lg8ZVjKOBwr0msaYj1zUDafhjxN2GMUl4lElmLAQGgqwS
         Ng8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jwpOkOgpRXnKl00tb/+AD5gNPR/KWIU9BMwia3ct5X0=;
        b=Q68EFjp02nICpLdOOw/Xfo0E/y8uzYX1mvFxjeJZB3dl2Gj4Jbg4VdYT8BKDlWUxou
         cPKT+CiLMqZDJZb/IZ4LKDexS/uxQ+0DnWVrRfIOiS0UmDoViJHmAtT60iueRoLlfswF
         lL9FOuT3XP/E9gu57qY9tP10Pd9G/lcEftd2ZES/PNrffJ0VcDTAdOnVmiOde8QnbCu6
         Jcuvm+ubk2FZAgl9ub8XhODEQbUXMOfWDatwGVtZ4yAqHnk3yodpFU3dZGtRpiLvE/h0
         7pJly2K5pT5XUFHOEdYOvwGaV2z8+hU3En/wDZSkreT4cuykFWKc21/gtj1/3BQn6Omf
         WqnA==
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
Subject: [PATCH 4.9 146/241] perf session: Dont rely on evlist in pipe mode
Date: Mon, 19 Mar 2018 19:06:51 +0100
Message-Id: <20180319180757.228986745@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390656543207317?=
X-GMAIL-MSGID: =?utf-8?q?1595391568135687906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -139,8 +139,14 @@ struct perf_session *perf_session__new(s
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
@@ -155,7 +161,11 @@ struct perf_session *perf_session__new(s
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
