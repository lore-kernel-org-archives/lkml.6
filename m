Return-Path: <boqun.feng@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523454507; cv=none;
        d=google.com; s=arc-20160816;
        b=h8gttSvJX3mhca4c8DEin+yjvsTkJ4R4/DEgKJta0JI8ecCqmSRrBeKIz1pD/dwcTu
         8dh9R1hjAgVeP/r2kJf8slvMQZWBaA9ywKv1+RY+N7i7E3IfWcTncm9VBnuN7bzh6fTt
         7EIxIYMXbPCs8nbaCK0BzwfX/zmbNkpJhrRgnUJ8wEIhlQozwSSOgNgLYeIApnaHDKmV
         HnVEA//kDO0EG97kMsDkqt8MXMTI+uvPPIBDr6WCN4N1w4vmy5N0Q4/GZdoW8zPW6Iv/
         0JVK/bVvFBPVOnKjppM8Mtx2aRjw5oDHDg+w0hiLECFfkFcpmNgvmMdqS3YmRkrM1UPY
         7eKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=fcn2t4lvwrHBbt1lAwJt3QIBCECwgLZ+1SQbmPUh88A=;
        b=Uq3ju/Dx7eA+lb9czrG9V//G20VhgAofJ0KjuAs1rvMHLCEzb9zsONyFMUHtvzorIF
         Sneifh56rWP5c5Lu8yLDiLmUGphRgC9WAHsSoi3ikwcaHNnBmYh3ZUgHJaHiQ73VFtje
         Tb5VP12+nOYVhbyScTNR0LpB5MAA5uQCH6FxslcKq6swRyLCapE6nQXTrB8aZteCywFn
         YhlinLPk/N674TD5QzLWBNaRl9uUDJoOr/s5FSGWnJj/3r+i6iCsL+tj32C3vco57M4+
         CiLncM0KQf1sDQRZFdix/ZvQR8WqMoc6UymWKarg/gRwyLVVTo/tmQ7CdwiU1Ouiv0oe
         dcuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E1Qq1ALN;
       spf=pass (google.com: domain of boqun.feng@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=boqun.feng@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E1Qq1ALN;
       spf=pass (google.com: domain of boqun.feng@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=boqun.feng@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49q6RjKmbqqtlxqvs1ysJBUZIL2mMWzi3CCldZmXEO8ANFU2qhf1ModM1thXrDB+81XoaEUSg==
X-ME-Sender: <xms:KBLOWkPAq_Tk8vYAayuNmg4y0lKV7OKZlKP3MOVnN66PQz_NJdtCGg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrea Parri <parri.andrea@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC tip/locking/lockdep v6 18/20] MAINTAINERS: Add myself as a LOCKING PRIMITIVES reviewer
Date: Wed, 11 Apr 2018 21:51:08 +0800
Message-Id: <20180411135110.9217-19-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597457833413397070?=
X-GMAIL-MSGID: =?utf-8?q?1597457833413397070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Recursive read lock detection work touches most core part of lockdep, so
add myself as a dedicated reviewer to help people find me if any of my
code introduces problems or misunderstandings, also if they need my help
on parsing logs related to recursive read locks.

Besides, I'd like to provide any help for lock related code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e950b8b4a41..255e5f25df54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8243,6 +8243,7 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
 LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
+R:	Boqun Feng <boqun.feng@gmail.com>
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 S:	Maintained
-- 
2.16.2
