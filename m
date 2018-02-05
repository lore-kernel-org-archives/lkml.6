Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224AigPynTxUilm8+nZjEIQyHHYj9jlBzkFehgbqy28tEvK9n9Lqzx3e1SNEEx7zHpaVWNdI
ARC-Seal: i=1; a=rsa-sha256; t=1517855039; cv=none;
        d=google.com; s=arc-20160816;
        b=c76BRT7e5BWwYBM2dNVQ6F5FYZxBsHEEPip+UOaELYvxliNEmqDaH48t4/XCeKaWmo
         A67Ss0ONzsnQtdOkbAMjF+CxjHYQKQeoF32wmI2+YnJ9VXJgS5IbSFrocLUXNEWOoAlP
         bjMrEjE/2PGaBBEl9iDhm08eqiipQq9tXqscBGCUSkmTZOZNc0pYX+kjSG6SJ48fYdMF
         Aiw73q74Uk+f9vmJ0ePKiadpmpnFRzooeEQRmj9UNzf23GdQY/RBacGB5dNeuNLmxTZn
         W3RLVqQ1mE9UGH6SX5nH/n1GLEI0lrr2Smk5KzlSdp9iBrBHIQUGbwEKYnbA0Ndv90sb
         bpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0ySoIrfeqZTMrsWQDhJEcktrv+xRHxriDsiQxYrkZs0=;
        b=BsxD0m98zaMT5gPaVhvOhh0SUXxqld9FKDjhqFVdEEC4fNP71uPdw9fEP+bP0+yhnt
         XEIY7L93X9UOfaEUdyOKslhK7lSQmb/bYVbWqqDzzX5Gi+FE0vFW3QZ7n2oFp+jRrAbz
         A/H2kMYeBcMC7pgY8arve2jrdzFb2HCTr15FHYtE8PY3TY3G6oyo90Y6TfomKpM1AGIC
         dv1CeYvL9IPgNgJQmn5Ka5IyMaud52FWbOMUPw6R8s1D6ZFVaO3WkUixtijGgKl6jgK/
         ZZEmAR5JuXz9SpJ87aDXUDLKprTnr+An3qa7TeHRpPDeBmItkIfA/YTaPjZT06vkq9Cu
         82xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	ak@linux.intel.com,
	peterz@infradead.org,
	Tomohiro <misono.tomohiro@jp.fujitsu.com>,
	dave.hansen@intel.com,
	bp@alien8.de,
	arjan@linux.intel.com,
	dwmw@amazon.co.uk
Subject: [PATCH 4.14 32/64] x86/spectre: Check CONFIG_RETPOLINE in command line parser
Date: Mon,  5 Feb 2018 10:22:51 -0800
Message-Id: <20180205182139.902983726@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586365402935858?=
X-GMAIL-MSGID: =?utf-8?q?1591586365402935858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

commit 9471eee9186a46893726e22ebb54cade3f9bc043

The spectre_v2 option 'auto' does not check whether CONFIG_RETPOLINE is
enabled. As a consequence it fails to emit the appropriate warning and sets
feature flags which have no effect at all.

Add the missing IS_ENABLED() check.

Fixes: da285121560e ("x86/spectre: Add boot time option to select Spectre v2 mitigation")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc: dave.hansen@intel.com
Cc: bp@alien8.de
Cc: arjan@linux.intel.com
Cc: dwmw@amazon.co.uk
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/f5892721-7528-3647-08fb-f8d10e65ad87@cn.fujitsu.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/bugs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -213,10 +213,10 @@ static void __init spectre_v2_select_mit
 		return;
 
 	case SPECTRE_V2_CMD_FORCE:
-		/* FALLTRHU */
 	case SPECTRE_V2_CMD_AUTO:
-		goto retpoline_auto;
-
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_auto;
+		break;
 	case SPECTRE_V2_CMD_RETPOLINE_AMD:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_amd;
