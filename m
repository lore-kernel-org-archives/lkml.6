Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqn+a6LpL1igogRSQ6jC6cIh76OD360VjNnrn6HOIkzr6TnIii46cu3z4cy5Jl9KVIxkrZN
ARC-Seal: i=1; a=rsa-sha256; t=1524837881; cv=none;
        d=google.com; s=arc-20160816;
        b=ES4GkkR7t+0VQTqbalW39bwLsQlY37wEe9RD4g881RUeRRJqkLcqU/byySAqhlNXlS
         opqPz53MaqkvIDw/yDJXyeLTuipsjypfILh0su2fZ3lz2Ug2fm3x4wBl/ho52gpCGZke
         Qk2XmsYVIKEYbNoLBJWijm22LyeQbqM1uWOM7IxOE8VU/CSfEkzjgUv0MfMGZv2EjNUt
         4YHZqdaVeZM1dPbbYyj9VA4b6/1Z3l/qU/iS/sxKupcszdzgTXQ2sMEt2lYmHufhChI/
         cZuWFBdChdc8NZDZbetQwKHF+0rk4qC2MmHRjh1JozEGSlCNqdcpsSqpEs3JWD2H8z5C
         FsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0DSueq/+gX0UD93NDbHZuGAKKJSmpKf5vj5eOCcKD4Y=;
        b=WEpnUIIwk2Aqvo/9Qwlq1HdnmND4XTau3Su/7tj8o/02ojQe3cDvHplyGry1zFOw4D
         M5fLT4zX505V4YsrWKA7wxnvFHVtji/peFasGcY4Y9sZ9qAMH+I8Bpxwwezw36uw0p+9
         A2bm/zl6x3c895rFOrOYfh0xTk70znJk10swV5pgEKUr/cJ4PCtSB38u0YdvI3zL5qSh
         j+2bnhOGnuu16t4gtv7w+IRSNE7RqX0rVpvIzzyPDo3NzSPimlO9KIWMG2R0DTzjXKYP
         QcqbAjH74MorzhdEtUqMkOI+kVTwTbb4FZYaH1jpjwFmsRB/Sdpl4uVShomFmtDnKkZL
         pD5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D466821890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maxime Hadjinlian <maxime.hadjinlian@gmail.com>,
	Akemi Yagi <toracat@elrepo.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	David Ahern <dsahern@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Wang Nan <wangnan0@huawei.com>,
	kernel-team@lge.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 18/74] Revert "perf tools: Decompress kernel module when reading DSO data"
Date: Fri, 27 Apr 2018 15:58:08 +0200
Message-Id: <20180427135710.657081841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908406958081736?=
X-GMAIL-MSGID: =?utf-8?q?1598908406958081736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit e2d054998b151e85b6305aa72264f67097bd78e9 which is
commit 1d6b3c9ba756a5134fd7ad1959acac776d17404b upstream.

It breaks the build, so obviously none of us actually tested it :(

Reported-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
Reported-by: Akemi Yagi <toracat@elrepo.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/dso.c |   16 ----------------
 1 file changed, 16 deletions(-)

--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -366,23 +366,7 @@ static int __open_dso(struct dso *dso, s
 	if (!is_regular_file(name))
 		return -EINVAL;
 
-	if (dso__needs_decompress(dso)) {
-		char newpath[KMOD_DECOMP_LEN];
-		size_t len = sizeof(newpath);
-
-		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
-			free(name);
-			return -dso->load_errno;
-		}
-
-		strcpy(name, newpath);
-	}
-
 	fd = do_open(name);
-
-	if (dso__needs_decompress(dso))
-		unlink(name);
-
 	free(name);
 	return fd;
 }
