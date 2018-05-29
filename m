Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2785586-1527631648-2-18396308217652875658
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527631647; b=aLMPCx9wk4IECCerIdacINaiNl8/8nzgfS3sJeRyajZ+g2yYaS
    emYoTwX/AGVqGiVxMrS3qnnh6STpwWfK5rtHJ2dzc2oiyUyPRLh0TKO3XMVhFvzR
    3UI1dK4wIgbYmgI7/yGOZ+k9txBQgyq4bBkmjNXdn0/2wcnKWsy26WZinZ1HaeCv
    8DFvpmW3nRr0DlDH8HI7yNcerHvE+zqk4snsxAXhG9hrjnCEuzzrbax8zFJaHs6t
    loOhMRHcy5ydttX6XE/xM5UPUnXWnTgY3q6iySJFvpRPv424u10OuuIe3Mks7zUX
    wwlGxryR/Dlxhbu2B3GvPApFbhncp4lG0H4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527631647;
    bh=GtCkl5z6/F4BLKCpP/q3Nyj6wa59NyQQji3kjMR2EXY=; b=MikyOvS9IfPb
    k9vDsLkvFRtCYRkXxdPxjCZQ+eC1W4Jl9YPjaDUu1+GUFQxx0OQsAat1+H/X8u/B
    BZFaYMAxQC8sMyVYFW95Vl2ezn1YDsSq9Vtb00+5UlIK38n6k4Z7VFbdqpntscZg
    5dtidFMfcMFfyToUomCQoSofeMY7r8mSnqKkpXOjP85TzoYVigA/B5HPgeR6UcmC
    KHWhBgTAVDaTvpT65AFi5TGZ1yljr7pOZMdo6g+dqzlJj2sAIxrn9k+l9qenLLBT
    BCKs5F3Kh6+r8iOeEDzIkcrRj2MofoYc0KLkjgNZnCdJn70LLLElt978fpwTPUfn
    N8LWwTifVQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=pgbY8KIE
    header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=pgbY8KIE
      header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNaALrmkRw10GWOFuA3zYvWBSfhMMwBRYUox/Z3LwJgatZskiEc2SZ5BownDIcA0B1ZaZ5qQKsbJGPJ8bkVQlHjGDdryI37R6QE2cRUHF9Cd+AfhyHlF
    W+E/ddJ/SJ/qkM6I8OwXe/4Vwr+R3IzUA11TfLBkn0X08J0tgnyHXytqY5yRpRMos8NPQMGLFXJM4ZnQjTlFsaaOR05Gygc3QYepHWS5rGVwmTi0a/hdvrxo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=FOH2dFAWAAAA:8 a=HbQu9tripaJC8aREG9gA:9 a=QEXdDO2ut3YA:10
    a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967454AbeE2WHK (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 18:07:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966957AbeE2WHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 18:07:09 -0400
Subject: Re: [PATCH 12/13] block: introduce blk-iolatency io controller
To: Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-13-josef@toxicpanda.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <99a187c9-668b-d27c-3d71-bc799b853791@infradead.org>
Date: Tue, 29 May 2018 15:07:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529211724.4531-13-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/29/2018 02:17 PM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  block/Kconfig             |  12 +
>  block/Makefile            |   1 +
>  block/blk-iolatency.c     | 844 ++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-sysfs.c         |   2 +
>  block/blk.h               |   6 +
>  include/linux/blk_types.h |   2 -
>  6 files changed, 865 insertions(+), 2 deletions(-)
>  create mode 100644 block/blk-iolatency.c
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 28ec55752b68..a4e800f57688 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -149,6 +149,18 @@ config BLK_WBT
>  	dynamically on an algorithm loosely based on CoDel, factoring in
>  	the realtime performance of the disk.
>  
> +config BLK_CGROUP_IOLATENCY
> +	bool "Enable support for latency based cgroup io protection"

	                                              IO protection"

There are currently no occurrences of "io" (standalone) in block/Kconfig
and it would be a bad precedent to add one, so please use that shift key. :)

> +	depends on BLK_CGROUP=y
> +	default n
> +	---help---
> +	Enabling this option enables the .latency interface for io throttling.
> +	The io controller will attempt to maintain average io latencies below
> +	the configured latency target, throttling anybody with a higher latency
> +	target than the victimized group.
> +
> +	Note, this is an experimental interface and could be changed someday.
> +
>  config BLK_WBT_SQ
>  	bool "Single queue writeback throttling"
>  	default n

-- 
~Randy
