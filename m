Return-Path: <kernel-hardening-return-12980-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/UNBbnrNT6uwuoZ/qeDd4fLMjFHOw7Dl4NEb4XDhnMaTDtiS5n43pqXYsx89yS4Q9B3SG1
ARC-Seal: i=1; a=rsa-sha256; t=1523500030; cv=none;
        d=google.com; s=arc-20160816;
        b=mUHBieH9DZKCiIN4jcyxfzcaWQukvHWnz7eIVt4eA6LAD2jbgWAmAW71FO5fwPA1Ww
         /bgNUtD63dw4qFNrdY7QnWdMw5zVfgfWuggzYjkCVXhtrsLz6z1SWjEC3X7rfm435hCS
         FYI/lqQJTGHxe5iyNpqc84MEN5/DiEsQ3wIy8J90OXy63tW2ONJLHcJg2N9RcHQRhvKc
         PM5Kd50fhFcFJQhV8a7vSFrio5gzEUKPz00wLVg2TgPJ/wrJIgSX2fq3pAlBsTtpv3pK
         /8heghpqGP7Ms3QITOcPpSj/ef8RVFuw7irQLs5wpSKVWXReGRbvVkPUwTlp/OzQ/+Ht
         BU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=7HS/b2AuMk/Ghh5gPoPBWgVs16UxmWBdOYEzCnLSxIw=;
        b=nlp7/+ko9the21afYALhOznWJBVd0USikiOozyChQLUg22fMtcVlSejsQPahow+7qG
         ztNoyLhIpIJ6wRQhReCMvw7L8uiDFWD9SajyjPRhVOJ6a/JrWAaDMTgUISD1Adg4gy+S
         AluXMDjwQBfjhHNY0cbu+hZgD0IgM3WQn8MEc9G39nETEzqGW8KzQ6uhCSixnOx3XU57
         QVBEyrh11G3Elzh+aDSwzdOMUy0bzjK3nQpqqHd8qKH70pjSg8nv4iDfFcj95w5hP4hg
         JO3TTtbTbs2qjTyZntmqZ09SXezr2s1ORSB54+EF30BlgY8yYMw08tWuIT6oMVDqjwMx
         ZZ5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YLpCQ3Lz;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cbn655Dh;
       spf=pass (google.com: domain of kernel-hardening-return-12980-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12980-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YLpCQ3Lz;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cbn655Dh;
       spf=pass (google.com: domain of kernel-hardening-return-12980-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12980-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F275F60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCHv2] dmaengine: dmatest: Remove use of VLAs
To: Laura Abbott <labbott@redhat.com>, Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>
References: <20180411010216.17702-1-labbott@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <70092ca4-1b42-d438-83d5-068a22618baf@codeaurora.org>
Date: Wed, 11 Apr 2018 22:26:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411010216.17702-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409665574809172?=
X-GMAIL-MSGID: =?utf-8?q?1597505567761120061?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/10/2018 9:02 PM, Laura Abbott wrote:
> There's an ongoing effort to remove VLAs from the kernel
> (https://lkml.org/lkml/2018/3/7/621) to eventually turn on -Wvla.
> The test already pre-allocates some buffers with kmalloc so turn
> the two VLAs in to pre-allocated kmalloc buffers.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Switch to using kmalloc buffers instead of putting a large array on
> the stack.
> ---
>  drivers/dma/dmatest.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Reviewed-by: Sinan Kaya <okaya@codeaurora.org>


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
