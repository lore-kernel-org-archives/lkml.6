Return-Path: <kernel-hardening-return-12424-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtPwz6+gIknmUeigh11oYDuFvK1T+ceJspNzN3cgV5Rf0X4ooBxXv1iyWAoiAbZMLlk/iJv
ARC-Seal: i=1; a=rsa-sha256; t=1520847985; cv=none;
        d=google.com; s=arc-20160816;
        b=o6G44+GTrdcWfKiEIrFFtA7i0feQliowxtJ+gqMAppeWuweVNvO823CQfQM3Us/iDX
         VHtRs7Ages2m2AyGF1/2+4jD9qACkeEQ/xpRQoyAJxegBoSPQfo0OTQsLnBHf3eJN1e1
         WVGaVFVbyB7WFf3mHEh/xCqUtMFLkW26Ynv5VbkD3eJ9y4/5ubuAhaUc0oDE7sYAv85w
         Yf0lEUN84n4Q1xRx2RekB08EnAqGEqeEkrLboTClYcGhFuaUucntDCEIpJ5DGXclYk6P
         C1GjSBugpFtm+i308KzmJ5iWF8qlBpXd4DzTJnlSa6Q5F7Bi5TJdPnK+SZ53mJdtffqD
         CFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:user-agent:cc:to:references:in-reply-to:from
         :subject:content-transfer-encoding:mime-version:dmarc-filter
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=p1yG6uULYPGLIbpXR0qPrTPMlC+n4oGGYe4UiOSoIf8=;
        b=TCu87P8q/b3wtJyjBvUMRiNuE9y5xNBG103Gu3KPTC/ITIxWulvkDjDswAaTp89NyJ
         yB7RuAVCiYPBmr8cY04UwQ5xq47LjtytDLDXEjfLsyLqj50G2kUKTdFYmAem/91Jc6Wi
         Qw8ypbrXQM4SHYXZGzzy5mfEvLeyWx2HtHhZA6kht7VB2C5xp+wZ0DBz4yKd75CAm/Co
         TtON4SzZQKylGGGWat1Xfs4zKTwkAZsRnsDXuq3g9IgBbHEMbC+EFhqbhQcwIYhL0X2q
         2krHgqs6CUVMzIS5syKUWJGSapILc8g6IUMvq8UXnVG23RvpwhMsC9cDKJc0MdiVWLzz
         yW6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Wrq003mm;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QVbEnIUP;
       spf=pass (google.com: domain of kernel-hardening-return-12424-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12424-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Wrq003mm;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QVbEnIUP;
       spf=pass (google.com: domain of kernel-hardening-return-12424-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12424-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F31060585
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND] rsi: Remove stack VLA usage
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1520819022-15238-1-git-send-email-me@tobin.cc>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
To: tcharding <me@tobin.cc>
Cc: "Tobin C. Harding" <me@tobin.cc>, kernel-hardening@lists.openwall.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
 Kees Cook <keescook@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180312094606.286BE607A2@smtp.codeaurora.org>
Date: Mon, 12 Mar 2018 09:46:06 +0000 (UTC)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594724697638352916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

tcharding <me@tobin.cc> wrote:

> The kernel would like to have all stack VLA usage removed[1].  rsi uses
> a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
> is defined using a magic number.  We can use a pre-processor defined
> constant and declare the array to maximum size.  We add a check before
> accessing the array in case of programmer error.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Tobin, your name in patchwork.kernel.org is just "tcharding" then it should be
"Tobin C. Harding". Patchwork is braindead in a way as it takes the name from
it's database instead of the From header of the patch in question.

I can fix that manually but it would be helpful if you could register to
patchwork and fix your name during registration. You have only one chance to
fix your name (another braindead feature!) so be careful :)

-- 
https://patchwork.kernel.org/patch/10274983/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
