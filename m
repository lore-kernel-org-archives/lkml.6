Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225aBXLho2RmRXCdDshGKb9nLtiZ63qxm0USOdzmFpyjTGdNR1dzh9//WXrk4qjWEk4NBUb2
ARC-Seal: i=1; a=rsa-sha256; t=1519411278; cv=none;
        d=google.com; s=arc-20160816;
        b=b5blhmQNIkQyxZ849orM1ggAUGitASeUiG+NhgNF8xI/N+fYsI1NLebd5vwG0tYutD
         07irfTzNyqIT+LqGjhcTCVbQRVCmlCX59/zinOeAkRJij7Le9UpP7CnRJEQGA2xVL4v0
         26nEwgdMaQNR9IF62rW41ZQnqTOrSKWzC+bcEfo7MsyTmvwNJqi6LFQGGK/d5Tumy9E2
         7Sx5JCyOQztaLNrmzESA4YILFjMV5UiUohvcyV77ws8+xdF3jOxWKgzvSsv8Q2TMaT1/
         K82/BiiZsMlcuKpxEUwC96ixDmHDyLXpEN/jI9Vy2d3qgcwFJwptIIWKYAjp4UTPICBm
         9xIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KiPTVwYJFVmZZdYYvM4SEHBLi3ncyzmye2RndcCEA2s=;
        b=G9Zvm1vzktHl+E9Edjx2f4N8zAwqSMUeIxjJ/fCrbMDqFWwZeqBmy/7+ITB1ACiQe5
         lRfU7lcMxzoHenK0Lx5tm5DknQfPbTxT6aVmO434FNGdOGy+Ubc+cOfyw+NZBMHBR+bB
         d6/22BmJW06cB9HYP9EKnkTysepSzjScAvBeoXPZPA+CQy5oJ+FwqcxnyGeVZ93Id8qR
         Q60V8y4ldRjb2gHM7FQOnuGk/IKVnb3siUvtwCgvBMApHGQZyrhlfYJXYcjmogXhqPqb
         wZivo+rqicNaNUJHBNGysd0yyGqEQncz4ULloMVUaNJobWe7MSbEf17a5wWU2scWbWuI
         39pQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	torvalds@linux-foundation.org,
	alan@linux.intel.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 181/193] x86/spectre: Report get_user mitigation for spectre_v1
Date: Fri, 23 Feb 2018 19:26:54 +0100
Message-Id: <20180223170354.510966870@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218200797173841?=
X-GMAIL-MSGID: =?utf-8?q?1593218200797173841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

(cherry picked from commit edfbae53dab8348fca778531be9f4855d2ca0360)

Reflect the presence of get_user(), __get_user(), and 'syscall' protections
in sysfs. The expectation is that new and better tooling will allow the
kernel to grow more usages of array_index_nospec(), for now, only claim
mitigation for __user pointer de-references.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727420158.33451.11658324346540434635.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -291,7 +291,7 @@ ssize_t cpu_show_spectre_v1(struct devic
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
-	return sprintf(buf, "Vulnerable\n");
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev,
