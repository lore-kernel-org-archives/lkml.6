Return-Path: <kernel-hardening-return-12509-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtLTFKVExwbORBjLgziL9Q1BvbFmlQiE3O2Xp/yU30L+SGPx/K2lmssCqEfysZsIQENpsoQ
ARC-Seal: i=1; a=rsa-sha256; t=1520959947; cv=none;
        d=google.com; s=arc-20160816;
        b=BRxRExvQfgfOgL3OetZoPBBCU9jdaTvJ0Aq1JG21igC4FOty8Y3f6nBtuhHCKroftZ
         b6oJbml2B+fZaVq8Vy/MTHjMMSkmeLcIJQbZ9xGLbU45HGQxwr5FDb8Brl1eoR5aMyyK
         UMrYYezXLblGJe8mLF5o5KYkDEdXQ9YBxdlUlR2zj4N3qXIh8p0V9db+qn94rvKZvElE
         +Xp3SbrodDMLA2Pb6YeuxmBLbVE/iEKzdGMgjtyhShOeX34FkOwM/BlrGtGUmbiod4/I
         tXhHiAqYZfft8c4zrOAnHwPjPEMovOKAc4H43hiMg5qegWUBru7uzXeydhISSmcMQLaI
         MtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:user-agent:cc:to:references:in-reply-to:from
         :subject:content-transfer-encoding:mime-version:dmarc-filter
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=TjJordkG1w7r1AZKXEtHU99qe/zUXVimWew3VAbjdbE=;
        b=PFxkuBYq1oneUdPYhWAw6+UYfVS3fcR0117jgTfn4Zfd4usBc4Q/SJJAklq0Hnkmuy
         OJMgUg/0twYt2P2FwZ9cqQoiBPbrxd+bJuHtm/vvTSgcZRUR1TJx1XqmuH+9ARus9EKV
         Ks5JJo54A01i0SZScBX1K1flVu68FZSAWORwSUUZH/A1eithz+b0sYQdk0LVK1+boTn2
         lWnpEN13o3y4XJWHT6aA77MztfF48bnvIbflZe+XPBuWm4gP1+/5Ia0jZxO6TDAEdtZp
         6YSvhtnKCoRWh4cHijqOs/YKWcfWNwPHzmFNx5Q373tzYRqlI+aPwoAmZJJsrTFTtY6d
         6uog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CsN1TdkU;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VpxhhpgP;
       spf=pass (google.com: domain of kernel-hardening-return-12509-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12509-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CsN1TdkU;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VpxhhpgP;
       spf=pass (google.com: domain of kernel-hardening-return-12509-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12509-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6929E60853
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND] rsi: Remove stack VLA usage
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1520819022-15238-1-git-send-email-me@tobin.cc>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: "Tobin C. Harding" <me@tobin.cc>, kernel-hardening@lists.openwall.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
 Kees Cook <keescook@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180313165207.BB0FE600C1@smtp.codeaurora.org>
Date: Tue, 13 Mar 2018 16:52:07 +0000 (UTC)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594842097481042325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Tobin C. Harding" <me@tobin.cc> wrote:

> The kernel would like to have all stack VLA usage removed[1].  rsi uses
> a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
> is defined using a magic number.  We can use a pre-processor defined
> constant and declare the array to maximum size.  We add a check before
> accessing the array in case of programmer error.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

There were conflicts. Can you rebase on top of wireless-drivers-next and
resend, please?

Recorded preimage for 'drivers/net/wireless/rsi/rsi_91x_sdio.c'
error: Failed to merge in the changes.
Applying: rsi: Remove stack VLA usage
Using index info to reconstruct a base tree...
M	drivers/net/wireless/rsi/rsi_91x_hal.c
M	drivers/net/wireless/rsi/rsi_91x_sdio.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/rsi/rsi_91x_sdio.c
CONFLICT (content): Merge conflict in drivers/net/wireless/rsi/rsi_91x_sdio.c
Auto-merging drivers/net/wireless/rsi/rsi_91x_hal.c
Patch failed at 0001 rsi: Remove stack VLA usage
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/10274983/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
