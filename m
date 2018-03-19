Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELurOScMxYEPFHaypjhBTG4EITLRpEC68/V2N++IYTHV1oGKpDykdCNvCwAFuXNpSSfJ3mXa
ARC-Seal: i=1; a=rsa-sha256; t=1521483832; cv=none;
        d=google.com; s=arc-20160816;
        b=wnNtsxObmgwcJ3IxNRR9l9jpk4WSmrQr4a1yUyiQDruM0hYiJDuGlrJsOv9SJPZ2IV
         S0cymLWQuc0BqLC67b0y2ocjOjAIxXN2KCvLTFWqrsGKA5l4uEnvJPo2QXh5Kab6psTM
         p6b/sRM0b9GkmqOdEIBMnMqtAXznGhYEEwP/zvdN3FEiWsUUCKBqbTsvHZo/qpPfVo0K
         1klwQQ4MTxyHZi1w+WS3MiVoQSqjE+NcBRrk9W9QDPPjlqt9OlUjv6Ovd3wm2UJkzBVT
         qxUxQDnTdlg0rG9jglG39m0MP2v1WJDZny8Gc2fKHcyUCddkXdoD7kosPYDIcJRDpcBz
         JSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SzZIjV4qZGjiEaZ21Unzqw11HLL/pI1Tw8VBL/Sh2XY=;
        b=zM7mUuw9w0f1dvBMvvzCYfOQggTEBediPo70Me0QxRwQhRdyXRH4DCcDWocnbikKkR
         yMWj5i71LzCAAW2/z8whIepuazziMW0xRU8mxakEqgLf8923d4BQZoTsr8iFEZ/fREz0
         L6fAezs7B1pL+3GMtMVsmRbgbfsvITnAaOhL6TwRsRDDhLuwBh+UcjIEq3KQBdzt10bN
         gW7n96aJN/adMzqk5gGHcIwt6X0ufBxJy1AQjp5BYGq3HTRI0c9MLiJq7uphCUb2Tcc1
         /O09NifBL2XSKYhYkhx6N0ulj9dkz2F+ZoBGLLnuRgQLYv8E/Xak+su/oQxouSaR5scw
         95fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
	Paul Burton <paul.burton@imgtec.com>,
	james.hogan@imgtec.com,
	leonid.yegoshin@imgtec.com,
	douglas.leung@imgtec.com,
	petar.jovanovic@imgtec.com,
	miodrag.dinic@imgtec.com,
	goran.ferenc@imgtec.com,
	linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 132/241] MIPS: r2-on-r6-emu: Clear BLTZALL and BGEZALL debugfs counters
Date: Mon, 19 Mar 2018 19:06:37 +0100
Message-Id: <20180319180756.657075473@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390854736380946?=
X-GMAIL-MSGID: =?utf-8?q?1595391430762442254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>


[ Upstream commit 411dac79cc2ed80f7e348ccc23eb4d8b0ba9f6d5 ]

Add missing clearing of BLTZALL and BGEZALL emulation counters in
function mipsr2_stats_clear_show().

Previously, it was not possible to reset BLTZALL and BGEZALL
emulation counters - their value remained the same even after
explicit request via debugfs. As far as other related counters
are concerned, they all seem to be properly cleared.

This change affects debugfs operation only, core R2 emulation
functionality is not affected.

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: james.hogan@imgtec.com
Cc: leonid.yegoshin@imgtec.com
Cc: douglas.leung@imgtec.com
Cc: petar.jovanovic@imgtec.com
Cc: miodrag.dinic@imgtec.com
Cc: goran.ferenc@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15517/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -2339,6 +2339,8 @@ static int mipsr2_stats_clear_show(struc
 	__this_cpu_write((mipsr2bremustats).bgezl, 0);
 	__this_cpu_write((mipsr2bremustats).bltzll, 0);
 	__this_cpu_write((mipsr2bremustats).bgezll, 0);
+	__this_cpu_write((mipsr2bremustats).bltzall, 0);
+	__this_cpu_write((mipsr2bremustats).bgezall, 0);
 	__this_cpu_write((mipsr2bremustats).bltzal, 0);
 	__this_cpu_write((mipsr2bremustats).bgezal, 0);
 	__this_cpu_write((mipsr2bremustats).beql, 0);
