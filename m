Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELvQcy93BHXP5f2sbA5geyb9MsdJzZ7GIERKnko+r72M1KfJ2AZltF7KOlNyE1o2G7RuMPj8
ARC-Seal: i=1; a=rsa-sha256; t=1519947256; cv=none;
        d=google.com; s=arc-20160816;
        b=M/D2OU/yXo0qwv+bwSS42ZvAey/ZIdiifzoKss/YUGE+zkmcpOUfSE5A8lHY5rgHC8
         JuhtML4y7KXY0jOwxY9Vs8hhZm4lWl1/XY/RHocEIXeY8n1FAKwjqzuyjhHTQK9/jDxU
         SiLK/Hux+oNer4G5m72GHwD1qS7NXq7+wMqsxDKPYxP9XXoAg2O1sN+yAkb0aatRyEbf
         fcjPDyVrc9VWe6l7huxkIV383y/v+lxR3/bly+uhYSWD5NK6yMnknd8fEHK1SVv5A/MV
         lOaowaryoXCZHqJx5zuhnS6Qz+zKV1IwwinBKjE+UxCFladpewJ4rC3uZxWyaObBI2kX
         UOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=H6jNcB9I73rk7A4LzAq+EzIbQYZOn9X7NU0jjGRtQiY=;
        b=bod6EQEo0N33memUYY1RAN5TvuIYV0jdfWE4V3FokoPJ77G/p68J587SzcsB6Ynu87
         EwSPhXIim87Pvgw3ApHeoo1UfSruNiAbRodusuFAeVaZgttyiAE+AeGB3iEXon9T4zYF
         +5Nm86vdXRnSjzc26uSmfjVTD6UpMyEAoVr0Mc37DtWfbiPMqDM60p3C/qw44tCx+fsO
         vkV92s3galH4Xq4zCxShwv30S2bdUPp2dpKNG3XDehp/Hek58l0YC6EHu4CE09ssnNHO
         NBBor1nB/8ht4oimgK5DqG4nL3rvTXgdJqvVoYi3KPBwgv5s8mezFcD1JSGjDDurlYyk
         IS5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 17/17] Revert "staging: Disable lustre file system for MIPS,
 SH, and XTENSA"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708565.7628.14283641203455668904.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780214051615691?=
X-GMAIL-MSGID: =?utf-8?q?1593780214051615691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reverts commit 16f1eeb660bd2bfd223704ee6350706b39c55a7a.

The reason for this patch was that lustre used copy_from_user_page.
Commit 76133e66b141 ("staging/lustre: Replace jobid acquiring with per
node setting") removed that usage.
So the arch restrictions can go.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/Kconfig b/drivers/staging/lustre/lustre/Kconfig
index c669c8fa0cc6..ccb78a945995 100644
--- a/drivers/staging/lustre/lustre/Kconfig
+++ b/drivers/staging/lustre/lustre/Kconfig
@@ -1,6 +1,5 @@
 config LUSTRE_FS
 	tristate "Lustre file system client support"
-	depends on !MIPS && !XTENSA && !SUPERH
 	depends on LNET
 	select CRYPTO
 	select CRYPTO_CRC32
