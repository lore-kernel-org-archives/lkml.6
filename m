Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr3k0eeXJ0u7tN2m2c13lsnJfEGSEpt/3ZdT8Ji0x0omWJkLvp5icpqo05CoC4iWmmKFEuK
ARC-Seal: i=1; a=rsa-sha256; t=1526280814; cv=none;
        d=google.com; s=arc-20160816;
        b=x2AJbDVANlI9GJgaA1ljGiHgDsa3K7nZ0r1zAMByFH7SOw3fqn83CZFBVqj/F/OfvH
         gUJ12JiIH/2F0LSMmJvGIHTB2eEcrgykyOrG0R9nBXJIDtOh8JuZDrbjv/KzHSPEIJmQ
         A9jOh99iSIuHNq8hmXq+6bTuz+Wwm+YOr8XUqkQfDec4oHdOjdUVoj+bdctRGmiTJ+ry
         w2GDbOlTCPqKRtrM5oxwE315YHKPh6cvGMrtmkxFA0V6RwUWs68U329iw/hOZRta5lJw
         n3H4A0vI+9FvbQ8pQ4/Ai3aZVEMwfvBAukIaYLi1n/Gig60MmgcT5D+So6k9fwKrJKoP
         JACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=07GocSUkq89ni/lP53U1e+Czq/voix0wM2/jQGly6tA=;
        b=UUcLmCjsb/Z1oLQ5tAJjwcI7/7hEH9u6/iYR547ibMnh0vH5QF98dEnLaK0Y/vrMkK
         Vu6vbLkJuYcg0hKSRXv70o8I9qnWNmcQIlszySrikMmoAlAYX8u44bRdwOA7RAvVnIPG
         3ArHGYcaQwcaHIxfbULFyenABUYwgypyfkNJxnn9Dl3y9R323HOlC/SMSAW1OuIDjOaJ
         2FT4ClYl7Zg0KRxX77ttquaSFz7M7won2XbL9mWj+UldyZYs3KBnXNLyEIwZa716TxVz
         bdDRppCrRxt8i0mbsSPppG5zXMXRP4h5MeoZw+DxUGiVUPTryAIEKvYWPUXJ/2jshJD4
         6ilg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=paaEWEBl;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=paaEWEBl;
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
Subject: [PATCH 4.9 11/36] perf: Remove superfluous allocation error check
Date: Mon, 14 May 2018 08:48:45 +0200
Message-Id: <20180514064805.141439579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421253442175407?=
X-GMAIL-MSGID: =?utf-8?q?1600421431175031297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -129,14 +129,8 @@ int get_callchain_buffers(int event_max_
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
