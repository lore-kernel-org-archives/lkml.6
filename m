Return-Path: <kernel-hardening-return-12323-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvRKJVmwMNCpKb6Pih+AxoPXRahP8I8tJGmfl23yVEhSO/sNgBiGaODH4lwhxcuymYMhTL/
ARC-Seal: i=1; a=rsa-sha256; t=1520602497; cv=none;
        d=google.com; s=arc-20160816;
        b=RJcQaXBysksN98h87cnJpA7NlalHyKGBbA5BNlV3lYvnmojEUvO1SYY2r2HPIi7eAV
         hjbjfBH1+7un5/Z3Ghap2pnwaiW7SrsUJyyNHpJAgN1fjjM39DD2LYLel9Ax6iRYsiHX
         4YCOBNcJ8qNcYsGDR84gqmThpn+dRq6qnXlwzCJ4ieKkq1jZRD0gYElgtlFH1gh2+sRZ
         hycavC4uI5t3lyFLyuF/liufSc2HjC6UfRLiJGiNIS5fGdQVIYiheo62BWyuag2fRQT6
         Uc3s3+bTfn7SBTuEGqmW2Fwb5un/orrCe2xoO9a7+AdEinzDfmqnSepNGmG2D/cptLLT
         g7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=qZD/6NPnuu1NKyj3aHn1hqHnqzF0edXx9ZSpe5nCVQk=;
        b=Fcj/09C9VwJI9uYoOz9pkBwFo7USr1MydQdUNH0XUMIBQvEPX2gOx2WHek5mYy2DLD
         9gTr6j9+xIOF6lmbiuhuLnQLPJG04g4hl2tkHvljpp0k0u2Sve6Y0l0vCD7LKdnOJrOh
         itoB8iZ5z4rhoWsdAq4yzc11Bf3Ac4V8KjY0OItrOQP4/rqmGKgxp89qDwTxIK2kktEq
         IOhVW8GD9XIJZUYdsg1e3MbF130Gwp2dAUjeiAXFHEq/E2yzxdPtEDVKtSvBrribS6xa
         FSUJ8hiEJ5X2fIUd/68Tyrve/dAzKO9nKJ0+q4gGx1py1HhsqmASqf/1aUti7p8oTX2M
         kWFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=duUpD+UV;
       spf=pass (google.com: domain of kernel-hardening-return-12323-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12323-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=duUpD+UV;
       spf=pass (google.com: domain of kernel-hardening-return-12323-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12323-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9k: dfs: remove VLA usage
To: Andreas Christoforou <andreaschristofo@gmail.com>, keescook@chromium.org
Cc: kernel-hardening@lists.openwall.com,
 QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
 Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1520601833-4952-1-git-send-email-andreaschristofo@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <fb0bb0e5-e037-e006-ca11-45eb8a8aa1b7@gmail.com>
Date: Fri, 9 Mar 2018 05:34:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520601833-4952-1-git-send-email-andreaschristofo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594466629940454496?=
X-GMAIL-MSGID: =?utf-8?q?1594467283935654283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/09/2018 05:23 AM, Andreas Christoforou wrote:
> The kernel would like to have all stack VLA usage removed.
> 
> This is the correct patch.
> 
> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>

This is a lazy changelog really.

'This is the correct patch' has no technical value.

What is VLA  ? Sure, _now_ its pretty clear since we have floods of 
these patches, but...

In one or two years, people reading it will not understand the logic of 
this patch.

I had to look at the source to understand what was going on, and that is 
not a good sign for a trivial patch like that.
