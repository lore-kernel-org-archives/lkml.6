Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281271-2-9757399242028205139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281270; b=iGBSgNHhbztS1sn38PlpbnkfKHvxJy13Cm/ru6tQdptcdklfsv
    Ty1pkjwWMuzONvABL/OkHw71hemvYy9Es5zyX2RfEQriahs/oq7OYJ76ivoYr4kw
    72/YeDkSfp9fL2RwUUlLgkd49iwlVfdlRax57CIH10nKhOetV/GRtRc2QosyqOuE
    9KteopWFCIXVgPVxPbACaAXivvsSynN8e7MHbwIzrQvT474IcA5YpeS5zNTe4rm+
    FCUqypOhk/NOQn44jYgGQkWwfaSH97HkYD1S/zsHsXViZ/h3ro1wtkJE2pKaM2+6
    t70mmXMdBVPDt0ni8V8nMPzEuZe8coLkZkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1526281270; bh=cGPPeep5R5xezWClpcpZic8HmJ4EarRZT0lD6TlBI1A=; b=A
    +tHx9RdmUf9xBSxr6PGrCTQ+kOf1BhKHoZ/8lJZqLarTrMO7MJBkDjiMLUnH7NX2
    2n35MHcguZBOBnOR+1q1LE1+kNM+h/YfkAtobLvPwoADiXA72YTqrDnv2nP9MBDg
    rz0W1BP0QV2xbiVqXugDauFkHOWHprDkbBR2vH3YAZl97Sisz03j7xNeC/VJKx9t
    y1WMqsuGQBGIeKVQhg4D9q1z/NKa/dG28b8bXqbeJYdssWr3NI/yM9V2Q3YnW/ev
    BwXNDKt1+sYpO7NdutUmrh9alI5iP24qgro2mJE7PjRqGbF7aVHCEb7mF0T7aacQ
    q19H5SilZcKVW41vTz1hA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=SQ0tMlJt x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=pass
    smtp.mailfrom="SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org"
    smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=SQ0tMlJt x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=pass
      smtp.mailfrom="SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org"
      smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC0XRG6Q4YX808w4PtcXPf7cnS2DlJbcGnF++20Axz+7kRfMyUqejBwDjJ6SnEIheo3HOhbmTHlrwhLmBA6MuBwc/PWo085sEC9QusOs3FeTK+YXZqOV
    4F3w5M88mKmNXWmDrKTiSAD1vxg3bD7V7r4PZBd+nbI8rXzVzoM6VB0Fr60obQnOJKgfxsKrNbMw04M1APo3SfVTAYvqE74yE7qjBG+L3EpsuEEc0+FbWWSL
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=FOH2dFAWAAAA:8
    a=gnbuhwpKAAAA:8 a=ag1SF4gXAAAA:8 a=jgO6SH3aC7yEc3PU-okA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=i3VuKzQdj-NEYjvDI-p3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <songliubraving@fb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	security@kernel.org,
	=?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 67/72] tracing/uprobe_event: Fix strncpy corner case
Date: Mon, 14 May 2018 08:49:24 +0200
Message-Id: <20180514064827.843194643@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 50268a3d266ecfdd6c5873d62b2758d9732fc598 upstream.

Fix string fetch function to terminate with NUL.
It is OK to drop the rest of string.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: security@kernel.org
Cc: 范龙飞 <long7573@126.com>
Fixes: 5baaa59ef09e ("tracing/probes: Implement 'memory' fetch method for uprobes")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_uprobe.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -152,6 +152,8 @@ static void FETCH_FUNC_NAME(memory, stri
 		return;
 
 	ret = strncpy_from_user(dst, src, maxlen);
+	if (ret == maxlen)
+		dst[--ret] = '\0';
 
 	if (ret < 0) {	/* Failed to fetch string */
 		((u8 *)get_rloc_data(dest))[0] = '\0';
