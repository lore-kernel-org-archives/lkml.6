Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpcsQrjiwfkDKo9of5X78WYTXdmHI3IEkZZuUGeFLyFwSVeYVNd004mzrYANhTRwvB8n2d+
ARC-Seal: i=1; a=rsa-sha256; t=1526281097; cv=none;
        d=google.com; s=arc-20160816;
        b=OVF70sab2/uMcqSvEigLHlE+V6exz/Y8y8+PbIP4i0NISuSAZhbV8UPve4bZFt3Jip
         gT3B1VYRsCPODiEWfLxtWJqjGKw/1/26LoNlKVb2cvyqyQdSoHF/QDXesp/cPJ3llfg0
         XTxXSu839CC176HJKNP0fGEOgv20+siApkWUvs0K8GhJl+n+SaGPejARyo8k2Bpl7IcK
         GANDFjwu64r86c9xTsNb2GpYr7YR1YTvxEW6Xa7hztfFYtvA3SqYdnyR+b2iZAiwE40Q
         XZYbhRD8BkF3iratM3jBc45edXrCwf0VB57nRocrd+r7ViDowssJRFLYzjgxubbnk7Oq
         +xjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lxH2dhsw4nM4bBR4Eg57FFAzIoC81dw5IyW7Ba5ihRg=;
        b=WtnOqujvIQnUku3+KGMnnVuOaIGBSVSRvXwRqi2vkseXj/qNXIMVV8CLsxZCNcUP2i
         UnvKxgbUL5qrtSIFF3tDo9D7BnEIpSJQMxdDWcTyHuSW4jnCtfZYvXa/2pPKooj+mpdi
         MHMF3hhGeCF9p4GigJ4vAxC3msgoDcOSCFXCRy/O0Zs4pbDWcXjCbiRCdoU80hT1+G32
         QBPrFXCtidStpK26efjXw9GbBlIN1ArEreoLO+q00Utqwdm3ZGHaUuWM8MLV+dHb00YN
         xC94MG3C7NcLddzR7+sdjhFkXtwVwxZFaqw+4ZFVmOinP435kQD5ajW/VuWx9v008GAN
         +4cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Un6shHMi;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Un6shHMi;
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
Subject: [PATCH 4.16 17/72] perf: Remove superfluous allocation error check
Date: Mon, 14 May 2018 08:48:34 +0200
Message-Id: <20180514064823.770904806@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421253442175407?=
X-GMAIL-MSGID: =?utf-8?q?1600421727971272306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
