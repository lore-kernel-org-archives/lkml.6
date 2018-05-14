Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZookj6qZl4+e504Rs3/41kExMRVHPUlkEG/oYoNZfPQEQUlVAGTPXj48Y0/ZZ9c4dH1SSvL
ARC-Seal: i=1; a=rsa-sha256; t=1526280739; cv=none;
        d=google.com; s=arc-20160816;
        b=Vp/GCa8wYudr2087WIwibSe2cd7pwe760eNF808DHmm9e5/MHaYU5Dfs/nOccE/lHw
         LFgYU2cxcvt/dzvBR6Z0GfKWmk1LOQweib0oqXy7qmoUdnXM+SbAzZULUMPcjeWI0Oz9
         phIPC0l1k3kj5hGCu91ucPd+g1alh6JrQdfXI+YS57LqENTu0voL+MumhH3tGcnhhBzu
         qg+cU9IpksexZk8dxTUw3B3XTyhIbvqr3u/wYJFFORwy2JtG1A5GwY941igseYZCAwX/
         zj4YlU+5lqDLL5pAj2rIIvOp8eCNxX38J8WU8LEkRRBcBc7Ty4lu1IkM9zG9NIhg344S
         m+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HZfToDwv1HZBhThgsUvgvEro68siMYA94Bf9TO57RFE=;
        b=MWLhnaSdy+PcAXEQlQfIgFkaWrmqGSRDSHqV7jX6Jf3nyjzcD8/+ZtLOzqLeNed0FO
         rI1Em5aL+5m2i+ROhXal/vvldfjHi8klJ5TswM/AkTUYOj599jVtL5VgMX+dAzS6+M8r
         1ClkovNycalRuxZyaWkv3134tFVFE+/VUY1kqgMOUzJg7q5pq7qVsqYogNwXAlgwnMQx
         nxsJXgbfNW1U3Z3nqGHkpc0ZwLTpnWJ0GLcXv+8jDMd5Ay/TlhKS3nBM4Y8qbuyvOh3A
         5ajT4Hc1JmnOKqWNUkuvw1ZZ8fFzuBP61l9vmGQPQ2paywdNNQxQ8O0a/T7YLiX+h9vR
         uBhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Uqd9cBfy;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Uqd9cBfy;
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
Subject: [PATCH 4.4 39/56] perf: Remove superfluous allocation error check
Date: Mon, 14 May 2018 08:48:44 +0200
Message-Id: <20180514064758.448944787@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421253442175407?=
X-GMAIL-MSGID: =?utf-8?q?1600421352457292813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -107,14 +107,8 @@ int get_callchain_buffers(void)
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
