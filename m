Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489VaZ5RrGdQ5oQCjWLvUWMPcJXmcWnao/HNgR9o9NuavL5cMr9L7+NJV04qX0iG5rjA7Bk
ARC-Seal: i=1; a=rsa-sha256; t=1523981410; cv=none;
        d=google.com; s=arc-20160816;
        b=BEyIv/hKYOTudhR62FAdKYkgTpEPnEwse0+7x8iqcj+BOcDNqkdqk4CiYFnLjCompZ
         fZEpfbUaM/mBMkNOZj1QEq5l3BBviAGXtCQTXxZN9W0v+lCV9zVBFoi9YT2bSCVM8z7i
         KwmZd7hNX71mgOKJM8H1YhzuxkL2JtRC76A4xD6tYr62VF+H+xpKXfPyQYCVfGqGgaz3
         UzX1rdAYn4YR5l8OUo5FkmTzeAxXPQnene58xwhifXaA/EW7qDFikoYwyQsy/qN2z3xi
         srhjdibK9V+yjWi2LnRxYqN5Zu6mzKEZ35xUxOpfGQ5VDgk8qAkrCzjqDeh4LM+WKxV7
         zLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RYRs53b01d3K2vFSPna4W8tqcZNmT6PDzJC2d+9Insw=;
        b=UMALnkbMxZW9QWBuAGI4ldreI1SHihDelplnnv63CMFLYQwt4XdpGOfNF3YS7No4QS
         5r4VTtjgEOqJdS93O2FocmVr9EyEgLIt5jeiOy9zkJ8t6bRwzdivSP8rNAOwsWyk/J67
         Ti4nPxG2HOkv3CaS17bSQSLqiX9/7cJdo/NCNmYq0PL2ZJqbkEt5TtGuw84W0VLhEWWF
         YP9mYu39LkRtefJ8HidsK+OIC7iCAmCSEvdLuTyFdB82qsi0jVmayH27LFjfMpv3MbW7
         zG5lYzrxmx5Fs9+WmDtsYVla3vleLnXTMud3bf2HVFeyHrZvkcQpUEp8bU8gZPcj6Spe
         KiJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pavlos Parissis <pavlos.parissis@gmail.com>,
	Lei Chen <chenl.lei@gmail.com>,
	Maxime Hadjinlian <maxime.hadjinlian@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Wang Nan <wangnan0@huawei.com>,
	kernel-team@lge.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 52/66] Revert "perf tests: Decompress kernel module before objdump"
Date: Tue, 17 Apr 2018 17:59:25 +0200
Message-Id: <20180417155648.152933169@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010331907044022?=
X-GMAIL-MSGID: =?utf-8?q?1598010331907044022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 7525a238be8f46617cdda29d1be5b85ffe3b042d which is
commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 upstream.

It breaks the build of perf on 4.9.y, so I'm dropping it.

Reported-by: Pavlos Parissis <pavlos.parissis@gmail.com>
Reported-by: Lei Chen <chenl.lei@gmail.com>
Reported-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/code-reading.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -224,8 +224,6 @@ static int read_object_code(u64 addr, si
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
-	const char *objdump_name;
-	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -286,25 +284,9 @@ static int read_object_code(u64 addr, si
 		state->done[state->done_cnt++] = al.map->start;
 	}
 
-	objdump_name = al.map->dso->long_name;
-	if (dso__needs_decompress(al.map->dso)) {
-		if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
-						 decomp_name,
-						 sizeof(decomp_name)) < 0) {
-			pr_debug("decompression failed\n");
-			return -1;
-		}
-
-		objdump_name = decomp_name;
-	}
-
 	/* Read the object code using objdump */
 	objdump_addr = map__rip_2objdump(al.map, al.addr);
-	ret = read_via_objdump(objdump_name, objdump_addr, buf2, len);
-
-	if (dso__needs_decompress(al.map->dso))
-		unlink(objdump_name);
-
+	ret = read_via_objdump(al.map->dso->long_name, objdump_addr, buf2, len);
 	if (ret > 0) {
 		/*
 		 * The kernel maps are inaccurate - assume objdump is right in
