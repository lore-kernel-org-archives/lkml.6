Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrZ0LFpM5hwg8D2Ch1tpLMB4qvYiCmg68ix20QBa1Oh5YQEVkjGgrG0+kYtY22J/iTL7nG5
ARC-Seal: i=1; a=rsa-sha256; t=1526937733; cv=none;
        d=google.com; s=arc-20160816;
        b=vDkr67I/akAFDpDvk7GjwZRUMslzz51zeW1uzdh3Bg7phWQk+fzIxLSDpZX75L7jer
         GHS5DsmWkLKKTfO0+j+KWRvDBtcYSrXO87Btfxtt4WnUhI+oniZ7BUaN5xxwbXwxJt7v
         +xGapQHddjgC1pHCos7ke9ulofmxiBN+Nu0WBj1EfS/nY47mcAewfb6LfDXpUbpXk2go
         o7j1Nu5gAPBhciQ8x2OAs924yJSFtmQzf581iJNKYD49RHKBNJLgCHwj43Zjiqdczbo/
         6188fENZWmlbOWOf1Q8EWGwFajS29zdQ5/xGEu8DKX/CKtxJWeeHujojXMgRzhkJLS58
         FhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9ThqAKJgp108Mzg4wSxyYZ6+KX1ZsQksSEsFS0HCTpY=;
        b=xDGwH7uziTNelE3lCW0+2zCWO7r4pF4D81uUsqsbtsF9x1hpDF7f3EZgMm6jsue5Ek
         Uej6W0tYnln2clodZdtEtR8sBBtLvE6tXkjq7jz7rvsx8gE+Ss4HKQEQCZjy+CmXJXWx
         TPLiQ9oZ9o/fX1JGfCglgivb7IQi9ba2sUvzTg1XW2De0oWylh3reHgk1XsRrj+QZEg/
         2rFr0Ft8RbwU0woK+PK96nI35TyBle+JCF3aHtWuor1RZGlgSyWH8X16BfZSFGwQeeFC
         PoqKdWxA0fwxbqrQAjVgevffPto2SBYjklS/vmEYWEg7UKRHZW89YD3f/dQzSi0VZg7j
         +ieA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GVHFwEel;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GVHFwEel;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 74/95] proc: Use underscores for SSBD in status
Date: Mon, 21 May 2018 23:12:04 +0200
Message-Id: <20180521210501.231391706@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109900337483371?=
X-GMAIL-MSGID: =?utf-8?q?1601110260941493195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit e96f46ee8587607a828f783daa6eb5b44d25004d upstream

The style for the 'status' file is CamelCase or this. _.

Fixes: fae1fa0fc ("proc: Provide details on speculation flaw mitigations")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/array.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -348,7 +348,7 @@ static inline void task_seccomp(struct s
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "\nSeccomp:\t", p->seccomp.mode);
 #endif
-	seq_printf(m, "\nSpeculation Store Bypass:\t");
+	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
 	case -EINVAL:
 		seq_printf(m, "unknown");
