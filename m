Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpPI1SEWAH43Rs1VdBWQlkHUMTONEHGMUyve3u5VhcArbWYeyb1fRNjk4aed+jwCqGEPLRd
ARC-Seal: i=1; a=rsa-sha256; t=1526937389; cv=none;
        d=google.com; s=arc-20160816;
        b=GoGELc//PPOxO6AK9LF5a1T5VXJThCQcOGI6yXSoLn0bVauwDIcB1Hz95R3YCvJCWa
         2K+LVcEa5dge4szlgibhEPsMzOXdR8FCxSyKmYjup27r315J0tuvt3hQysDVZ7x1Y+eL
         xBmA4t170qkxo+zt3yaEZlQwrJD6PpdRY5W3FKwA7U5JoEcj+IAeDy8jwyPM9TzcsUkh
         /whBzcN1enuRAX9hXsf+17zu14o30KN2k3zNtBm20XHrsmvckxdxesLjvlis9XdrN1/j
         puQ15Z8+gJrGTAnzPnwz9ex4UTmV/9+WfZBoIWl/Su+m30j1d515Xn7ycPV1FJuDW0X0
         plUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=7D4v3Ye3sch1dJOQoi7qKJ7tBu5CtYmagmxIVWjbsrg=;
        b=h8MtiBClNlEAE1n7Ybn4BnNXCI4/g3/Heyb4VLrEb93vRWT9Dtm+AjIhL/IyOB0oGs
         +eGXObY+meop91wW1tp6XAXuv/KdJS0tekt19pJaP1ol18/w0/Es+D8p/aNO9LzcAjZE
         /k8B5VkjOu2F3vfAxt28m2VVz6qNSlwf5f/u351bIiUKXHPxowMVVsm82OBgnYE3UVUg
         jI7TYsDXBSk5jivVWL6HOoK0LEurkP3ZCfEBp5f9tiWRTU2RuIr+wpo7EQIMWifvrkal
         PyoD/EBjVQIxnfSe6qI1VyggTN3593NeAng+WFyb0ScOVFckMG82OgBZWo9orK6SDRS2
         Zc8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qBwahe0Q;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qBwahe0Q;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 65/87] proc: Use underscores for SSBD in status
Date: Mon, 21 May 2018 23:11:41 +0200
Message-Id: <20180521210425.869248770@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109900337483371?=
X-GMAIL-MSGID: =?utf-8?q?1601109900337483371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit e96f46ee8587607a828f783daa6eb5b44d25004d upstream

The style for the 'status' file is CamelCase or this. _.

Fixes: fae1fa0fc ("proc: Provide details on speculation flaw mitigations")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/array.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -347,7 +347,7 @@ static inline void task_seccomp(struct s
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "Seccomp:\t", p->seccomp.mode);
 #endif
-	seq_printf(m, "\nSpeculation Store Bypass:\t");
+	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
 	case -EINVAL:
 		seq_printf(m, "unknown");
