Return-Path: <kernel-hardening-return-12475-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvLiNMFgaNqVg1DgNN164fsxaflziqmNteDs1ILu/gl/EGPWKs3PrZawDh73vzmaHGDdIw5
ARC-Seal: i=1; a=rsa-sha256; t=1520881708; cv=none;
        d=google.com; s=arc-20160816;
        b=F1KT7JeW2LKoqVDc0POeloXNIQ8D0OnyvN6vgg7iEbHYYQ3crF5iJ42Ya5YZcma/Uz
         WClOL9FScGQ8TO9UBtFBlZdZlCjNBrnAhv/uv8BEKFbrD5FmvwQSMUf18joY76DRWHtx
         lwsMX14ErTjVQJHVw0O+M58Zq02R5P9rQe9kiECG087bFn+xOEflswUD7HCyeUWSAUEL
         iCBACSHbn+2nWWgQXWvJpS++aIqWpd5ZgPua4s1nw9xtxZLxnT6542JHV8NJ+/M6duhT
         ULiwkS+DeA0Gi5oKVrzi07Q5Kz1saXTvuNe8j+hTVCeJK6IzgG6lTdLQ5+naI3zEcF8x
         3VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=814xLhRUpRuwt+v0hqw35QM87k8COH0Yt9BtHUPjeCE=;
        b=VdsPGU8yebFBo+WFWVNcen72QWFdZjXkq+cvVs0jqmfBtwZNLHq2uzdK3Vaocw4aHR
         ox8W/6hp/OkV/XEdrY8LcDZ2WLF+puE8cpQK28+xuUw4ddNxT4PrcDnt7VHAVesv/gCq
         TGpD65tqN3FZuXzmq7arA366kZIVzZ1CoMndE0jrZrtSrM/fBm8bwr+QRYgdFfcSMC5q
         LsdsJSj3S/ag47O5HCKJSSbNJ1cXtu9uEBuZTWAeuraV8SWr8jg8QO29B8nZheocDfyV
         lpKEjIXWreXgPAuJZuOv5BopdohUr0AO17lntPNGcyqI8iTRMMLMpuQg71Xi6PdBWlqO
         aCuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12475-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12475-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12475-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12475-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 15:07:57 -0400 (EDT)
Message-Id: <20180312.150757.1880237990834088910.davem@davemloft.net>
To: s.mesoraca16@gmail.com
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, keescook@chromium.org,
 santosh.shilimkar@oracle.com
Subject: Re: [PATCH 1/2] net: rds: drop VLA in rds_for_each_conn_info()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com>
References: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677115997192072?=
X-GMAIL-MSGID: =?utf-8?q?1594760058644679703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sun, 11 Mar 2018 22:07:49 +0100

> Avoid VLA[1] by using an already allocated buffer passed
> by the caller.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>

Applied.
