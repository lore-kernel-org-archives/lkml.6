Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx481ADe0x0Z0DnUD62Y6MJBJ8aWlQTGxGFrdu01FPQ2i/d/SpzdLdU5euELmG2HOTe71Zoux
ARC-Seal: i=1; a=rsa-sha256; t=1523399188; cv=none;
        d=google.com; s=arc-20160816;
        b=se5aWNmo5GIjWwP0Ugz8dIVcfQ0jVtKGRw1vMDx0AmJoFv9FjbxbJjAhDEqxvpk2Su
         J+r3eggViYGGEL48CARsCPq1jKv7qgmQ7YXMgpq+k67hRLYbJCyw5ihK+urEVJoo199E
         JSnRXt1C7jNEE8mhdHmm9JpeQ+RrjRoyRoLFvuwpKSGo5JGZjsua4g8KnmfpAFKLSalo
         kBBevH5nKfaucQpP19R46hXTnA4ah372u11aWtlkcSLLnaulE18zyLwB3mamiSpHdHte
         rk8ANOQtWu/zS+kPapmdyCpPtR+/WQk7tKySbaHAWE2J63QbgrrD1di0OsUyuzIy3isB
         Wncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h4C+DiDZiJ0XkFkLbJuZgRE7+hPy416t5uUYJcDaqmo=;
        b=YtsnSntXxMFbIlshcMUHHJ/h6p8GOQ9BbXWGdP1QS/ulT3sIEou39+xF2S92P+nKVV
         A5OfL4mfGBfIyXu5KxsI2D/w1YRsNaSXoK5CbUbIGlqpW7rxflTM+DH2WCrUrnTkLDAO
         EtZSZZs9lRtBFw3tw7L2Kjj1tDkhim4IPLawHgN9VxP6kCG8G6bYqCR4bgaVFxfMz4tZ
         bBzG64vZhzjhIc9ONInBcU1LKYG1TC1BIaRftOkSFqFmBqZ10jOxTk6C/Z8w5/wW7FtV
         3JGWLCJouHngnMzKktYrthvzEnutU/uKCCpgzAOdgySM8dH9Ssbuw33t1DyU5+jfYeSW
         K8eA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	Thomas Richter <tmricht@linux.vnet.ibm.com>,
	Paul Clarke <pc@us.ibm.com>,
	bhargavb <bhargavaramudu@gmail.com>,
	linux-rt-users@vger.kernel.org,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 010/168] perf probe: Add warning message if there is unexpected event name
Date: Wed, 11 Apr 2018 00:22:32 +0200
Message-Id: <20180410212800.657227015@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399827388871320?=
X-GMAIL-MSGID: =?utf-8?q?1597399827388871320?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>


[ Upstream commit 9f5c6d8777a2d962b0eeacb2a16f37da6bea545b ]

This improve the error message so that user can know event-name error
before writing new events to kprobe-events interface.

E.g.
   ======
   #./perf probe -x /lib64/libc-2.25.so malloc_get_state*
   Internal error: "malloc_get_state@GLIBC_2" is an invalid event name.
     Error: Failed to add events.
   ======

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275040665.24652.5188568529237584489.stgit@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/probe-event.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2625,6 +2625,14 @@ static int get_new_event_name(char *buf,
 
 out:
 	free(nbase);
+
+	/* Final validation */
+	if (ret >= 0 && !is_c_func_name(buf)) {
+		pr_warning("Internal error: \"%s\" is an invalid event name.\n",
+			   buf);
+		ret = -EINVAL;
+	}
+
 	return ret;
 }
 
