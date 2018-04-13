Return-Path: <kernel-hardening-return-12984-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49hOUx8DkmGN5emLNgZw//fCri+MnF6ia9eBj1W8x/wjPkivdC5xLwWOivwlG7U6r4cROvn
ARC-Seal: i=1; a=rsa-sha256; t=1523584107; cv=none;
        d=google.com; s=arc-20160816;
        b=oGHXNEHs1lY930rE9kpPWr4t9oPDCKwehbFCbDXzAmGR8KTZeiO0xy0hraua9MHTmK
         doxqFQdrkQqxWSv4aI7cfSnel0dMp43pmvDbKhNzfGyL69UQDfcwjeveM7YgNPigmEyy
         6Zt0tFGp41JhLql/y9QMpXxLDuq4U/mt08UipPv5HiZ/QeNHBEy+j5wmzq3N6Knh09q/
         xmlw9qPORvuLunhUOrMgjJSPj/gpnPBq8a3Ndg0je5/tks5H6KcU1CnIqG73J4FWlR1I
         L8rRysgHMiTuKuEvrdp7a8scKrGOQYOlxkd3ltsnrT3qVNLcr7YRvCTUMdIkcKNCky6S
         JfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=/yYJXRnOaMeXNKc4hwh4uOBOobMm9l/gsV6tTRgSAwA=;
        b=AKAkScbCNRgJFY1gINQS1VZshTpjstrcNdwYs+obgCjSZgWEU1w//xEPjsxSKue/Yp
         P7SIXhbJKC8vFjHZtQOM4o7CcsAhCsnHAmc8Oy12Nj9ag4Hfy1ZBizoBvTUM/zknRbPg
         w2HAT107pKPruqnYtcfuodVIeFq37pMtotyI0cdn/ZBERPNFcl5uzr+Kz8am4XRGTO0w
         yNIw8tA1mVrbh6639fYYaCqpTp91YxkZOu/bjvf7VNQFn+LmtdCqxEIe0AHrMuqklyse
         Zzq+3rzf2WJjYCk4VuA5YrLjEaXj4zuXieTGvkpAiM/fvWM0Mfk1XlT/8imac85Yn6ya
         +Gkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12984-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12984-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12984-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12984-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 12 Apr 2018 21:48:04 -0400 (EDT)
Message-Id: <20180412.214804.685830742109478351.davem@davemloft.net>
To: labbott@redhat.com
Cc: isdn@linux-pingi.de, keescook@chromium.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCHv2] mISDN: Remove VLAs
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180411010429.18074-1-labbott@redhat.com>
References: <20180411010429.18074-1-labbott@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409800222276851?=
X-GMAIL-MSGID: =?utf-8?q?1597593729231221996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Laura Abbott <labbott@redhat.com>
Date: Tue, 10 Apr 2018 18:04:29 -0700

> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> turn on -Wvla. Remove the VLAs from the mISDN code by switching to using
> kstrdup in one place and using an upper bound in another.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Switch to a tighter upper bound so we are allocating a more
> reasonable amount on the stack (300). This is based on previous checks
> against this value.

Applied.
