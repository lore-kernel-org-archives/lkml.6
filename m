Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs7HFErsIs4OrLsOS5foOvy4x6zT8WgKXAK4zlYkI2dJX9nLe7RWE1RiYOhyCppWw0zGYxd
ARC-Seal: i=1; a=rsa-sha256; t=1520641193; cv=none;
        d=google.com; s=arc-20160816;
        b=dCfSmqsdGsvD7FZnCjp93lhvMZrrRx1BNzNS987fNeH0uaT8grlW9tcmjZUqtVnnZP
         cPFVjw6n1VKUUru/hFDP0W9OOwXptgCF5OQB2o5gew4NI/PNovfT7RZO/82tfzgLD1/a
         6twe5p5yuwpvL95d6EPLoOywTkZXOqR4QwebAdW7hTVMvYY94wI2j5bw5/zZQGsHF4JM
         598a4ofgdTLFDcTmmPVE/K5Hns+kKc9p1hn7QTZeYQ2qL9NDRbq1LrgbSeZHg8/RI8XD
         TnZGRbtf669em1PXZ7xz+weGomRn1zZyMXUiIA4Y7ZCitfspWwWXaKsAb5Goidh4cR8i
         COpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gxSnFuPvqWbtWXTiSmt+Jg3GImSMHSkMFaX5wwcf2hI=;
        b=IP1AxYaRqGduw53nezD3m+CkYFlrg9GEjziaJAx3P8JPqGpSDkAxlYtBl1oDU0znWG
         hjVtGLoqxMWuK9Wz3VY6V/vxk9DzBNRyy+jUrUxoEvGIFRmraSnO4YpRMBXz/mNRASrL
         pA6Ehww7n35aCdoCRZe7fZavRjPz0E9Xj86lPmRgwc2mquO/wwPTrFulYAosmny+Qc0o
         91h38NgqnfuWrzj/CV0tb29F9cZgVbOpzk5TFwy4PNbItNhNbJNo+4eL+1d0LE8a8mXF
         ovFFJzmo0mAZtYrp2MjzRSMDzO2vuMooyqTAT3myPJ655CJjApmFB5HRI6ft4WcO9cl+
         HzaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@suse.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	KarimAllah Ahmed <karahmed@amazon.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kernel-janitors@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 16/36] x86/spectre: Fix an error message
Date: Fri,  9 Mar 2018 16:18:32 -0800
Message-Id: <20180310001808.223312534@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507859737766837?=
X-GMAIL-MSGID: =?utf-8?q?1594507859737766837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 9de29eac8d2189424d81c0d840cd0469aa3d41c8 upstream.

If i == ARRAY_SIZE(mitigation_options) then we accidentally print
garbage from one space beyond the end of the mitigation_options[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Fixes: 9005c6834c0f ("x86/spectre: Simplify spectre_v2 command line parsing")
Link: http://lkml.kernel.org/r/20180214071416.GA26677@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -175,8 +175,7 @@ static enum spectre_v2_mitigation_cmd __
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n",
-			       mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
