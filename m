Return-Path: <kernel-hardening-return-12332-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtdFpjAt3uJJNqNAws29DInRLnNWtXwSmDHRnX+FpDGYP/4xMpNauox5FMeXd0KOFDtJ0y+
ARC-Seal: i=1; a=rsa-sha256; t=1520620057; cv=none;
        d=google.com; s=arc-20160816;
        b=RY1fkYc3TilurbMbeFP5Jn+41FgkcYO5yhb2gJNN2E3Gbqo64m3/gPZK9y72RPxerf
         BjCOkNGzoosdwruv8i9W5djXPpqcS8I0K7domd+Sxpc17w+1omcPMa9BjsmQN1gxyNKt
         1b+X1Ih21Iu09aq8bt9QF2/LJmYzopWPDMFy4Qxvut1l1GDqR+uwnpIlVd8mjNQo347R
         Nof5arsMQDvISZs5ihfSt30CK1WQux8TtR+wx6SAzyfz5YGwT1R8p8DO32GDTThHlnzV
         YydWhJX38JXUKeNEGrZCjBbWLv0RMg+by4LB05+O4tKWo+oTvmw2ihPv7X0XRaszql/Z
         Ncog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=PhMrunpGteC0ADcXrOq3RDCWpQGR/3lHFKTXLA+dx6w=;
        b=1IhP++bhplTy7BlVEuQbjO11NpPsUCeWNBZVzpQJNbTaQdfZLAT6ZdmlP2+GEy2Zh2
         7oyjZKFxxaGnqSpePnwZ+6lr0xETLKVNhT1EOSfEH9bfMJWINnw9OPTrCcwoV4VIQcHw
         YOYd9d6KySm85Hhbvpmv7alXnm1SOAOzg88hsrSMb23LjTjGngfSTYaA9D2LtQDPiVKA
         5PUHqnnGQftmRJ3yFFA8m+JZ42Env1ONWdHPpQ12JOxa2KvK+cLfYBuhGrQhjIktYues
         FbXo0LL8gIItNWFcNK9L94U8Q/ajSV394Sp7S4jK9Lu3/AcuKsh2ErqwQ0pjr/nlpTvP
         7LlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12332-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12332-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12332-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12332-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 12:27:08 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] power: supply: da9150-fg: remove VLA usage
Message-ID: <20180309182708.GA18542@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euMjV-003X9F-FH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:36304
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594485697714454043?=
X-GMAIL-MSGID: =?utf-8?q?1594485697714454043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLA usage and replace it
with fixed-length arrays.

DA9150_QIF_LONG_SIZE (4 bytes) is the biggest size of an attribute which can
be accessed [1].

Fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

[1] https://marc.info/?l=kernel-hardening&m=152059600524753&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Use DA9150_QIF_LONG_SIZE instead of DA9150_QIF_BYTE_SIZE as the
   maximum size for array 'buf'. Thanks to Adam Thomson for the
   feedback on this.
 - Update changelog based on Adam's comments.

 drivers/power/supply/da9150-fg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 8b8ce97..7ea2188 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -92,7 +92,7 @@ struct da9150_fg {
 static u32 da9150_fg_read_attr(struct da9150_fg *fg, u8 code, u8 size)
 
 {
-	u8 buf[size];
+	u8 buf[DA9150_QIF_LONG_SIZE];
 	u8 read_addr;
 	u32 res = 0;
 	int i;
@@ -111,7 +111,7 @@ static void da9150_fg_write_attr(struct da9150_fg *fg, u8 code, u8 size,
 				 u32 val)
 
 {
-	u8 buf[size];
+	u8 buf[DA9150_QIF_LONG_SIZE];
 	u8 write_addr;
 	int i;
 
-- 
2.7.4
