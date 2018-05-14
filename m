Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqVkUJHPD/YVXcjHI2SMBDI2MQUG0xCpyq8jahexiaibHk4asVdzB38IT7xYFarkKHTYeas
ARC-Seal: i=1; a=rsa-sha256; t=1526280921; cv=none;
        d=google.com; s=arc-20160816;
        b=fNaZ+EjW8nqL/sy5ctN/HomBMVYooJJSNHWcHWmEb447u+qQGEGPsiplYlNHaoV/Xd
         e9Y9TuVftN3/JyZI1ZS/tS+EXyr+nCS46HnUDSYwZsA7uVrLYoX9/f+qn/mGHr7quoiO
         PNV/QWLzRaBONvuFg36mCCyOi5Gr3kirqfkz7et7oFqO8sxldRzmVZn3qqcdHv9Jcn36
         Mq6xp2wV++pnYmsFwWEvz9R/ZhfDHf1oNjWb9ygUBHaRiI8dKGGBVxZHDKqZWA1w7ayW
         vTXD9FadHz5zeTlXcxBKU8zP7XDVM6ADUCN2ZgrsCdPX6CeOwQlfAmMuykkgxmHAN7X0
         M0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=o9dzs7CF1SyBlAmwIeGNUg3sH2Lx8kPMVslnbn0DNao=;
        b=XFeJbiMfjpiwkfihhWubf79OEHbzkw5aOZ0n/fmUlxHDSFcJLxw4ety7GSajQgMIJY
         jjxV5538iD9f9/vzBT+WDfOfcio83luOb+WUxmgCgnsVwUDfzjMb5HI5jhBLbUG51qON
         jfvIvtD++Wf32MuxYmGBSJSF/lof2cW4HJzgP+uNxILaXDBM8dOLramuhAyTtsfNSk7g
         ZbmjFcZYFqg1gRIEr9i4rCqKtxj9Qfz7tSMY/6H6yLkoiJRlBeetDfaFha8qC3ozs5pr
         oliWpyY1zRwCuxXFuWzOpAPboCe7fIlasj36rK7T48VCEbn37SoCXCuX7gRWfvctf/nV
         Y7mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YQfCTfrd;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YQfCTfrd;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <andi@firstfloor.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	syzkaller-bugs@googlegroups.com,
	x86@kernel.org
Subject: [PATCH 4.14 14/62] perf: Remove superfluous allocation error check
Date: Mon, 14 May 2018 08:48:30 +0200
Message-Id: <20180514064817.201290813@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421253442175407?=
X-GMAIL-MSGID: =?utf-8?q?1600421544016338686?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit bfb3d7b8b906b66551424d7636182126e1d134c8 upstream.

If the get_callchain_buffers fails to allocate the buffer it will
decrease the nr_callchain_events right away.

There's no point of checking the allocation error for
nr_callchain_events > 1. Removing that check.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: syzkaller-bugs@googlegroups.com
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/20180415092352.12403-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/callchain.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -131,14 +131,8 @@ int get_callchain_buffers(int event_max_
 		goto exit;
 	}
 
-	if (count > 1) {
-		/* If the allocation failed, give up */
-		if (!callchain_cpus_entries)
-			err = -ENOMEM;
-		goto exit;
-	}
-
-	err = alloc_callchain_buffers();
+	if (count == 1)
+		err = alloc_callchain_buffers();
 exit:
 	if (err)
 		atomic_dec(&nr_callchain_events);
