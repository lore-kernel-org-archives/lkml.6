Return-Path: <kernel-hardening-return-12953-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48QddjmdWUUfznhcPBAcbN61Cvro/PL8HV9xUYRWthkFaO8V8x5+VfkstTExgisrOGZre1D
ARC-Seal: i=1; a=rsa-sha256; t=1523350764; cv=none;
        d=google.com; s=arc-20160816;
        b=CzUdE0B6Lk3wgWBmq+5YuUN5BcOHjds/9C0dhv16XyOFRsncw/jjQ7pMm9JHPjrVxn
         s0QTyHGpvu7XUss2toc8Tfwur8cZSFsVvdvkmxGjCJ5SoUliiX7WahYquKuGAoX8WZvf
         8xPbPnCG4yMBDSsjKcZc6ed0oSRNWsJpb7R71Kbi6h76sw1lOsON4K4igVElD0a9ecr3
         IynZxZ3Hu4uVD/0vzQuWllviwMFf2ppTtkivMF765VZ2gtMQ/Pl+e6qwYudvGWEAjzrV
         Tdp6kqjzHMq/WyNAswE1O+Uq6N4qg6Zt309Dyvg3qpUv4tWsLmTz59SKnGP0IwmFrDe9
         2pUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=gEgzNzCjMDXeEVFZGAmtmmP8nbzjoMD1Urh9c9PtS94=;
        b=XJ+PnbGcqoSD2Ab91JA2HOlnue+r+3h2V9c51iuNZaLtTTJd2p2EJHGERVWiABRQWA
         nI2tPcpOIYrf+BmFVL2MBHZxlgl4G9QfEMNLMI8TIlbQxR306gIyb0K1iw4xu6Qtz1kl
         a+hXhklEpLMV9eH13vJmcJh50wVf7chAAspNwKmd7ILY6ilIIEaOitd1IdPdY4yadlZl
         BPd6U4g/9oiLiEcsM9jmRHCCeYhe/+eoTeyFanPxUmbJAzxXecoWtJ3eTfNt85AeXsEj
         9Ugf6tOwJgR8JYQT4W4DQ+16n3zsBt29dh1fPzQcEaCRCyRcdzRiPonbBuB0aLUZmKcn
         Oi2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GbH8jBjt;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=B40lk+un;
       spf=pass (google.com: domain of kernel-hardening-return-12953-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12953-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GbH8jBjt;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=B40lk+un;
       spf=pass (google.com: domain of kernel-hardening-return-12953-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12953-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32B2360AFB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] dmaengine: dmatest: Remove use of VLAs
To: Laura Abbott <labbott@redhat.com>, Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>
References: <20180409210603.3575-1-labbott@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4491bde2-cf38-5103-0634-1986ecd32a7c@codeaurora.org>
Date: Mon, 9 Apr 2018 18:48:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409210603.3575-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304199213101990?=
X-GMAIL-MSGID: =?utf-8?q?1597349051712992898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/9/2018 5:06 PM, Laura Abbott wrote:
> +			/* dst_cnt can't be more than u8 */
> +			dma_addr_t dma_pq[255];

This is 2k stack space on 64 bit architectures. Isn't that a lot?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
