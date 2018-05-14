Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZokYM4EaMr03x2cb5TUp/k+bDSadsevBXsplao0G4VqPgVJa43QC2BgCmUckdsDz1AM2+pG
ARC-Seal: i=1; a=rsa-sha256; t=1526280644; cv=none;
        d=google.com; s=arc-20160816;
        b=ViuwagJzoKRvNQ1/F6KOS1RLmoj7KxtYHNyweCgU6dHCdouoRWMfqV9qL4E25XvA2Q
         6J9feHPzlx+YXYSDStzl/1mVVl2NjJ7Pr/D89RQsl/BbDY7kN6133qEx79KaoziNsESO
         fhFGt6cZTzkn4z6antboqQFzAkbf88G+Q9Bafyh2x4lumjfsc/+FjG1kkwNqghBNLoSs
         C9jn61Jk155RAC8f+Az/YMSYKla+GRooJ7u0SRzskVay/5FuGwXADPfQGta9uNk6wiQw
         goclz6FJz9FdRsA6dJ9Hl4NqR9c/ttViiuCRY727PFgkabL+Pkl59+iD+tSFufPvraM5
         W9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AfUx7EeFC8yQashgsBulbLBBEGY7jWPkiNM8uiwbbBU=;
        b=Z6CVKYy2lSqTpQyB7cw5EZtsshNivikXL3ll5MxHi/5T0KnUNPdT51qwrU81HhCqlG
         vVO9xsYzRApF2ytI3eqMSo3ZgpglvgI1AJNQ0QIrigebr5Ho8EIpXmf4BYsqAebGR8sl
         gdCPhzmOufiIZW5EFp+PE11l0pfMF0gtjLUTPoIljtVpIqmTEoUxa0Hyci8uxhSsOg9q
         IXKzTTso70RWymTTUSSYPH9Qd9qSHDOmyZMVF8lxcqyc4OZk0CvLFXeehs6FY8IMLttO
         tLzQ+g4iSfq3uQkeOfSqhFtilrc9L8Y7gBD/bvW11E+Kc++rKY2h+3J5fhgMPnMM/axU
         YF+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KpAdIxmj;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KpAdIxmj;
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
Subject: [PATCH 3.18 17/23] perf: Remove superfluous allocation error check
Date: Mon, 14 May 2018 08:48:46 +0200
Message-Id: <20180514064704.781902231@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421253442175407?=
X-GMAIL-MSGID: =?utf-8?q?1600421253442175407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
