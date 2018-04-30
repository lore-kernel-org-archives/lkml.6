Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoeO/I3xMngGm0uibvvgVVtlZyDc5uyr+lH1reR+mI7745nE1sWGbqLZQp/gQDP+0uvkQuy
ARC-Seal: i=1; a=rsa-sha256; t=1525116241; cv=none;
        d=google.com; s=arc-20160816;
        b=q611Uj9AWZDBDBT3KFP7grx5//mZJraXrv2YP6dKwe0VIa85UvLaUfWpGDxqlSi3mZ
         UzrI33G+wSnh7SrwrWGz8ZzK8LZUSOkd1+z9pH13Bpp+iwcWoeWLYXFRVYoggp+xoBZN
         pE+lf9DoPgSgzPMnFwMsDsDQA+WYtenk8BaPGjaaHKKy2FhSnGcrPkn/eJ4VYnE3jNMh
         QrTfPE+6KT0PdLosfZ0TY8/tRQQUkh7l03MArCSgTu28nnH1+uAvPH3yJdXB1dhnWBjP
         nT0PZnJN9l7v1oxFzc6p9dWwPDC+Oe9TqxG2HCFwZ6HBBEdJGur7vncwgzDKJJBryIQC
         KjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=rXJNAbJhwkYSt+SjngEVzRVKqZAW1Cp8Q6F7GYRihso=;
        b=tqw619Ocfk5pUniCVPTab/8N+sGdM1+NZu9hwVQoUNvMN0a5FCeUROmzGtkLCoiV3/
         8rAO+xxtxDZAn8j7hlXM0IgAI2/Uz7pQz4Hb9AmiTSJDMPwbeFSQWxjbuXvCAHIF/O2M
         MSFRGFoy82Y778/4Z5wc1XISe/8YlhfRDbR/HihK5G0IX0zw7kaXeLiTOHb5QB3hvOgq
         W5I7ks3tJ//oO4AGqk6M+Z5fXAJ2UEn7/KmUJh0kYe+r6fehpcHJi2vs8h0WU+pJ9gGV
         vt8qUSSJAxhQaj873BHp0BoVgrPypaVq0WLxG2BFPWn2Kv2ex9mHWm8/WAANAsP3eizF
         NDaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3329D22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pavlos Parissis <pavlos.parissis@gmail.com>,
	Lei Chen <chenl.lei@gmail.com>,
	Maxime Hadjinlian <maxime.hadjinlian@gmail.com>,
	Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Wang Nan <wangnan0@huawei.com>,
	kernel-team@lge.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 25/25] Revert "perf tests: Decompress kernel module before objdump"
Date: Mon, 30 Apr 2018 12:23:32 -0700
Message-Id: <20180430183911.857177527@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200288393399936?=
X-GMAIL-MSGID: =?utf-8?q?1599200288393399936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 091b3b4ba55daf8b28f40794aefdaa0bdb5af7a1 which is
commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 upstream.

It breaks the build of perf on 3.18.y, so I'm dropping it.

Reported-by: Pavlos Parissis <pavlos.parissis@gmail.com>
Reported-by: Lei Chen <chenl.lei@gmail.com>
Reported-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
Reported-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/tests/code-reading.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -141,8 +141,6 @@ static int read_object_code(u64 addr, si
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
-	const char *objdump_name;
-	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -204,25 +202,9 @@ static int read_object_code(u64 addr, si
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
