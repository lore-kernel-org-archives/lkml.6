Return-Path: <kernel-hardening-return-12328-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsrEdLjeo7ng/JAufFXBHbeqWkK7OCubv8kZPTYFbailKiP6pQAQqEzbiid51X4rGg0fJ1g
ARC-Seal: i=1; a=rsa-sha256; t=1520607029; cv=none;
        d=google.com; s=arc-20160816;
        b=jyLNphrjWciAJSRUHc2v6ShoVkr7E3JhbOZpDgS/VkqdEJBYH4DLDCmlBBWXiTP2Yj
         bf4ybdXBCrH0itlmGNuj4AtiWu7Bo+DGLjRCbD+9vVSrpGIKtwBq7KYiL0PhmR3GubXM
         eqAEUfm5/MhPfLVpWr/0pExBVgrwicb4yI24s5y9BKS8VHS3zuuLwRb6jnHkNW5cG96P
         hwO4UIcfKob70tvZ9i24RTRv3ghudtRAiqqS/XQPB+O2ywr0EYt/08DTb/fwVvil7Ldi
         cgS80Yyvrx6ck4cs9mxKyPRSeMKqBL2nyJ/ffw5djLVBMk4DOoZoa1LzUJAWQtoIX1h3
         J7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=0RIaM1l0PqgTd0yOt3bcnltD1cIbcd3DwJiiLGLspxw=;
        b=fp50cHTcp1bkuUTioGc6LEtZs2fIUE6YgpHqKRtmF2voI0PFGpGY0ao3J+UWf1GKRA
         bRm6SvsLAVqulHbVzalsjRPoCQepU/kqhvGwG4fARLCMkFUkxb1idEUeSNg4w1uC9q/Y
         w0PuOyWoaWRLc2K2PEmY0Q3nbdJUWGEH1LA2BXhz5hKg6jvQqlFq7Hfujvbk4aSodhfp
         IQjvE9iHoPAOHtlnJaChAturkoCnXPPmVpMuWbka+gPwgIuoTXJJacQR06o0B1k4kdKI
         /M0zYs1/DFFlZRku00DzbK1sn8QUEg98ow7N8ZkoxRcf92PFWpXvpgntxxYKirn0LgUd
         vyYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Bk7t9/wA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oD1/9E1F;
       spf=pass (google.com: domain of kernel-hardening-return-12328-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12328-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Bk7t9/wA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oD1/9E1F;
       spf=pass (google.com: domain of kernel-hardening-return-12328-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12328-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDA666053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Andreas Christoforou <andreaschristofo@gmail.com>
Cc: keescook@chromium.org,  kernel-hardening@lists.openwall.com,  QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9k: dfs: remove VLA usage
References: <1520601833-4952-1-git-send-email-andreaschristofo@gmail.com>
Date: Fri, 09 Mar 2018 16:50:05 +0200
In-Reply-To: <1520601833-4952-1-git-send-email-andreaschristofo@gmail.com>
	(Andreas Christoforou's message of "Fri, 9 Mar 2018 15:23:53 +0200")
Message-ID: <87zi3hcnhe.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594466629940454496?=
X-GMAIL-MSGID: =?utf-8?q?1594472035918941275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andreas Christoforou <andreaschristofo@gmail.com> writes:

> The kernel would like to have all stack VLA usage removed.
>
> This is the correct patch.
>
> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>

Please use versioning in the patches:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#patch_version_missing

-- 
Kalle Valo
