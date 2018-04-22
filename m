Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+qNeeuZ12Ky9vB6OWM2Y4tAECO3DPeKpSOooYPfrG1AeMC4Z6Ufw0Let7uOK6qGXjTbWDh
ARC-Seal: i=1; a=rsa-sha256; t=1524406607; cv=none;
        d=google.com; s=arc-20160816;
        b=KiCHvXUck3Tq7m8PwQXArUnhQ4EcqWEN0xAcp2OnTklGzEokaPlTt/QzCu691xDaC8
         ywP6S7ALtf1O0jUbrtkIMySNmeOatqlRNqCcuyUms3QX9zSevKkmKkzvLn/LNIWwsRps
         tRlg1nLMXTBo/i8U56tbsJ/DifRzIt6206nA6iLH79ycvSwKu2G6mW0s7IK2R1ak9s57
         miIdM68yzVPq1ugOk8szDmvZZyHP4E4zXkN9z+hO41aPlJe5T4Jiy6LJ572OK5Bsxf36
         ZMohN6jtHxkxd0vTSgJHR37W6fCDVljB7+EoSlui7WpiwCid9TQIXpUZmkyHNg0qTYAU
         Y3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4GsVPi3Vm9NY8AX6aR5z9FOx3fKfsS7C7bBkLDRZxHI=;
        b=iHCUuUs4VXc25xyASI3CoHY0Ci1777bMRIu6UEVXQTfkcEfpfcZcXaQpW+PH1UZnjH
         JdqGEl7ufLnJ2MD2qqNbzrC24iAlDEHOlTmsqT3gcVXRmwgGwQsloLHedUjxrHCyZ5ql
         J2YR2GLrQZiCFAGJUCiWwYOM+/ly5t9rOFMv5mwaA+3zJKLFYUbgjOYtwdWi20rBsRDH
         3GTGcyJn3fQUGdtzLWZ68tU+IIxeTrmqxQwqK9AreZIgBVtg5f24aegnzRQyxdO2q2XP
         7/NSugKwqXUIER4UcUODFt/r7C+lKeJDAyVvrB2pUufZNPTfVeT2wwdI4IlagMjNl4di
         EkTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.4 08/97] Revert "perf tests: Decompress kernel module before objdump"
Date: Sun, 22 Apr 2018 15:52:46 +0200
Message-Id: <20180422135305.110944943@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456183194462886?=
X-GMAIL-MSGID: =?utf-8?q?1598456183194462886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit b0761b57e0bf11ada4c45e68f4cba1370363d90d which is
commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 upstream.

It breaks the build of perf on 4.4.y, so I'm dropping it.

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
@@ -182,8 +182,6 @@ static int read_object_code(u64 addr, si
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
-	const char *objdump_name;
-	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -244,25 +242,9 @@ static int read_object_code(u64 addr, si
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
