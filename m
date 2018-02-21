Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224EcpS7JEyGmmczvIAQxS8LlUY71EHq0shAzOm4BSAeeefYm4ytk7L8Yqk2Vsu+DGNB1ydK
ARC-Seal: i=1; a=rsa-sha256; t=1519218011; cv=none;
        d=google.com; s=arc-20160816;
        b=pX4Z74BgM+2ivH8yHwsh5rYmOUBm9bHrZlaevdGcNBKKKP1vgrMTaNaluC8aOCQr/e
         YG/2od9P7Zw6HOJ/fmdt8TyUukMxDZjy3iz+2uaVKaEdM9Ft7Y9LuAC+e0IaShQ1E1ER
         oLliBsxiNn1DNTU3TQk3ACd6NmiIFdVLWXi+1Wt+T7Mamdd+huS2iul48Qk2ivOVvc2k
         yT2UXunDSqhO/8xaXn6ferNCqEb03ulA8VWxhx92MWiMTD45AIk/zH+GC+apLMKRF6Zc
         iUBVjUX75m/KBDTWpYLckP7E59CiDlnxn1HcLD0w83BHVfOUug8EJGuj5KzqvR/I5fdv
         Pr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EImWUuff15QmdRtahi6rSZCdGJp7uOiWsTkdeJj2Uf4=;
        b=SwnFqqqiB6fQpK1j576DMK9KxoJknyLi3nMCANNQEVK9ojtUBDx7I8y2BclTRvufaT
         yOsNCG1fqNbP8eeKcvJa7KFJsFFDY402qPfAPyeh4DhnAlNEELS7EWFcqimQ3zXRn72x
         nft5bfd/Co0evJGjhpy7yM9304ig3CZHOxf2rPBY6EdsJiWYvhFZVBD2qRGo0SuBX5aT
         +Sz9cvOHEpjgw135WaVUEHtr5wvTHKToxX20PtSfgh5+nRnPYHJSMOSfdg++/6uAci7j
         +CSWbiuXSiGXAdIaLb58AGRNGjSFjgQf13d825iLxWxv61pe7cAEPfCu4fGL4jOYD8CP
         mcAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 056/167] PM: cpuidle: Fix cpuidle_poll_state_init() prototype
Date: Wed, 21 Feb 2018 13:47:47 +0100
Message-Id: <20180221124527.604648140@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015545701185591?=
X-GMAIL-MSGID: =?utf-8?q?1593015545701185591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit d7212cfb05ba802bea4dd6c90d61cfe6366ea224 upstream.

Commit f85942207516 (x86: PM: Make APM idle driver initialize polling
state) made apm_init() call cpuidle_poll_state_init(), but that only
is defined for CONFIG_CPU_IDLE set, so make the empty stub of it
available for CONFIG_CPU_IDLE unset too to fix the resulting build
issue.

Fixes: f85942207516 (x86: PM: Make APM idle driver initialize polling state)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/cpuidle.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -225,7 +225,7 @@ static inline void cpuidle_coupled_paral
 }
 #endif
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
 void cpuidle_poll_state_init(struct cpuidle_driver *drv);
 #else
 static inline void cpuidle_poll_state_init(struct cpuidle_driver *drv) {}
