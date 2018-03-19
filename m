Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs9m1EJW880qPuYb49BO5TSAPK+ZNmAEGeVAwYkZYvsrMgdi3uwURMA0TBXFbqDuSzd7Ptu
ARC-Seal: i=1; a=rsa-sha256; t=1521483282; cv=none;
        d=google.com; s=arc-20160816;
        b=bXlrwdk8tZP0R+1EkZjPnJ6tuXJkuBID7g5KT3DC+UVk9QRqy245q1qPacA8kBD51t
         o9SgubAlRQ556liOtpoUS8pPHx0hNO+qMVJwsgc4XKeSw2bo+ZUSqi3HVXpzCAKJOCHv
         wVx3jwp1Fxn/5+Zz3urVHzGVQ8EE7OP0RQ9jbILEVaRBu+yEusunInATzkdstQ3UK9U9
         +CPZgL1pPEzq8S4oq3s0Dfd7gdCUHrcKqQnVIVQs0j0m9nsLgepOv8KzqwIIEWOvf+Ow
         Gh5VR9rGs3GrSc2/XB8nrOKwzwUJwG3cZSYH+CV01tt3Mg9Mq9nCitTRqpdOnDERZ65O
         Ikgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X/MGcpbGItZNJuOUdf7exi9g+2NWQ5NCpMSvGxVwq28=;
        b=Lhxqs8z0Lhsz10R1pdrZ26cu0YHSG+ex/mx5MUczxtsq830oIEAVqpgu094yFIFLIn
         UC/okwFefa4nFhuGc0lghnKJaLgEvHXDooV9Jv0eRyWHt8BETqJZ2Km4hQG4y48rno+I
         U9rEwM4HpMcq0kEL/EcxnC5MH6yeXl+uBRhdpI8p1exxaC4q6rB34zBV5l5hCi7uSNAn
         +eAqytmRpJysO7PyzgBrIjlAC7AUiP5uPRms8Bm6gQBq7Td11BBYnGvsVnZIzHS1Cz31
         GzGfYe4mR+ImYoJZ7bbVRCWzTiN/JgVY1oBwZdWk3xk82crtCWrcePOTsBO17oBEeHmp
         dlLw==
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
Subject: [PATCH 4.4 065/134] MIPS: r2-on-r6-emu: Clear BLTZALL and BGEZALL debugfs counters
Date: Mon, 19 Mar 2018 19:05:48 +0100
Message-Id: <20180319171858.667431207@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390854736380946?=
X-GMAIL-MSGID: =?utf-8?q?1595390854736380946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2340,6 +2340,8 @@ static int mipsr2_stats_clear_show(struc
 	__this_cpu_write((mipsr2bremustats).bgezl, 0);
 	__this_cpu_write((mipsr2bremustats).bltzll, 0);
 	__this_cpu_write((mipsr2bremustats).bgezll, 0);
+	__this_cpu_write((mipsr2bremustats).bltzall, 0);
+	__this_cpu_write((mipsr2bremustats).bgezall, 0);
 	__this_cpu_write((mipsr2bremustats).bltzal, 0);
 	__this_cpu_write((mipsr2bremustats).bgezal, 0);
 	__this_cpu_write((mipsr2bremustats).beql, 0);
