Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtNsOMx26LYKIyPNQBdyvaTTdMm65r/xzc3/RxT+o+nbFIAibLDAH2dBM+nG+w4/8NQQDWm
ARC-Seal: i=1; a=rsa-sha256; t=1519412177; cv=none;
        d=google.com; s=arc-20160816;
        b=x+YqB4qLtULf3mB5y9Vnco0fhLPy41AQe6MsKv/HRVuTxfXuP3nWdFhZ12LgJj7D3B
         mRJaAOiHB7cWA9fEigOZoH7r5h1SBwIJHWB6GLlXfNXP7OdHjGrTl27QYLNKmpEXLuig
         JuYJLVrGfchrAwSGIZbkaamFh69P0iHNo73g/XImVGVO74PztAkcLegHLtPc17OR/qFS
         NP21Dj4BqJG32snycScP22gF0h9Bqf+LiB2hUklEkKciXbupytHMnNtqAt22TZL7trLj
         eXC1WnUuozPYz1TwbvEAokvHqrIRLfqAJOoFMubzlR28CVdSQiCuJEyjVSHCgP/zB2f9
         XuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A8d9PZ5fOgtd/NDkIcMTyF3F+PdSiCqQn3aBNVJmhxU=;
        b=d5Vb4yOm5Z4DVEAc4N1q4NXu6BJ14mVBkhhrzluQVfuQ3ERvvPMSXKXxzcZITWM+6b
         hV6cLkAb+PldQZTgThckd8lpwmM58iUSJL7gkF8uFtnhgyElrKHwDFU3LLfHoZ9pRmZn
         BavTXDlbI79KFU+KRy1qLyL4W9xWu1wr+2WtSs4OarBSfQyLaLp1vRqGEdO4Wu4hEA07
         VqRTonNo/tI4PiDpLWg4aaSvg+X1dTgPLANXFPg2b+0Wa43dTkIDrv1gm979UFrRVnao
         GZYXLZKgZB+HKrIWmWd7ush6s7mdFKyAPRYK1AemXseifkrFLgqMzgxfhhb2tk1AMXeq
         wjtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 150/159] xen: XEN_ACPI_PROCESSOR is Dom0-only
Date: Fri, 23 Feb 2018 19:27:38 +0100
Message-Id: <20180223170801.113515446@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217631266638083?=
X-GMAIL-MSGID: =?utf-8?q?1593219143011999524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>


[ Upstream commit c4f9d9cb2c29ff04c6b4bb09b72802d8aedfc7cb ]

Add a respective dependency.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -258,7 +258,7 @@ config XEN_ACPI_HOTPLUG_CPU
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
           This ACPI processor uploads Power Management information to the Xen
