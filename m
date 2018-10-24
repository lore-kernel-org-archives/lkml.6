Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89014C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5E12064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUpMu5HM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5E12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeJXWb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:31:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36541 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJXWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:31:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id s15-v6so4896307lji.3;
        Wed, 24 Oct 2018 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4oigFIxbskxQ+7j0sOvaNmyhXD381TEaoqgq18GgLd8=;
        b=LUpMu5HMo/ylWBXkbU6ZEQy6GVx90KNbd+aWDu0yLoaiokqjUdXOKuzMXnbAGdgovn
         WfIztBwenEEY/GPTQ/ygbrvC+Us5EzwZWMd9MhbLf2CCTpRu0jkWEiHZkUeuaDJsftNy
         LcwpzSjevuss2oV/v2wblJAf6xwPZoXYtbixhWk2P0QuxkX8UwUBgzY1J8igdbYnCGt5
         s8N7ATeOgkBc6x2RNfHfzLLlMQqAdhXtWOrHo1lhhw12cFp6ALhl4KowkPzOggsdrYRY
         /SXajjQlrxy0VqtJdarjQrviHz4pVSkoy/nAwqsDyvmAt72C0el+kzkzwElbny961FMz
         kxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4oigFIxbskxQ+7j0sOvaNmyhXD381TEaoqgq18GgLd8=;
        b=Nuo3cBt/zFf2NFNP+RgLOxZ7LwuvzanGVleaknZc1VMTlDJi0CbS9LBbDMA+Wr96CZ
         hW6oWKo2db4BBsGoXAbcWwPkCiApKBt4HWYg9CvOnq21pf8PZ96ZQi0q8NcbTf6qfcH2
         aJAmoskw8oREmZUfWjp5XLeZhdaDnj6kQlrc33otpA0C7AwIbK09Z6YpmaEOhDjPfU8u
         jE4CuRgnfJsp3L3NwuTi0VzJSCZB/RdNO0wZo4DeZsO7dFkO0zOYhNyC10sOG/de+95k
         7m9VdVLGUWuTAnPeEy6tUKbusRqecI7ue2usqDd1Tu2kgqVFnt3vEFAjOGnKpErkcBDu
         LqlA==
X-Gm-Message-State: AGRZ1gKmmQ1hdVVDAG3gjqdmcnexzWyXfxisS4Iv1Bex80/TTwfXUiru
        GkUxt2v3a6XxAm74UEO0u/xbUsLoN2w=
X-Google-Smtp-Source: AJdET5fbSQ+PHVEsZDI7REDXRgFb8dtL3n5QN1wm5AfCwMDbxOo/kVGB8Ve/2K3BGrJpZtMkSbZsOw==
X-Received: by 2002:a2e:b1ca:: with SMTP id e10-v6mr1650020lja.38.1540389787662;
        Wed, 24 Oct 2018 07:03:07 -0700 (PDT)
Received: from [10.222.93.64] ([164.5.176.2])
        by smtp.gmail.com with ESMTPSA id 134-v6sm737953lfz.76.2018.10.24.07.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 07:03:05 -0700 (PDT)
Subject: Re: [PATCH 14/17] prmem: llist, hlist, both plain and rcu
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        igor stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-15-igor.stoppa@huawei.com>
 <1634210774.446.1540381072927.JavaMail.zimbra@efficios.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <243a8ff2-889c-089f-a1ff-c882933ca5c3@gmail.com>
Date:   Wed, 24 Oct 2018 17:03:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1634210774.446.1540381072927.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/18 14:37, Mathieu Desnoyers wrote:

> I could not find a description of the overall context of this patch
> (e.g. a patch 00/17 ?) that would explain the attack vectors this aims
> to protect against.

Apologies, I have to admit I was a bit baffled about what to do: the 
patchset spans across several subsystems and I was reluctant at spamming 
all the mailing lists.

I was hoping that by CC-ing kernel.org, the explicit recipients would 
get both the mail directly intended for them (as subsystem 
maintainers/supporters) and the rest.

The next time I'll err in the opposite direction.

In the meanwhile, please find the whole set here:

https://www.openwall.com/lists/kernel-hardening/2018/10/23/3

> This might help figuring out whether this added complexity in the core
> kernel is worth it.

I hope it will.

> Also, is it the right approach to duplicate existing APIs, or should we
> rather hook into page fault handlers and let the kernel do those "shadow"
> mappings under the hood ?

This question is probably a good candidate for the small Q&A section I 
have in the 00/17.


> Adding a new GFP flags for dynamic allocation, and a macro mapping to
> a section attribute might suffice for allocation or definition of such
> mostly-read-only/seldom-updated data.

I think what you are proposing makes sense from a pure hardening 
standpoint. From a more defensive one, I'd rather minimise the chances 
of giving a free pass to an attacker.

Maybe there is a better implementation of this, than what I have in 
mind. But, based on my current understanding of what you are describing, 
there would be few issues:

1) where would the pool go? The pool is a way to manage multiple vmas 
and express common property they share. Even before a vma is associated 
to the pool.

2) there would be more code that can seamlessly deal with both protected 
and regular data. Based on what? Some parameter, I suppose.
That parameter would be the new target.
If the code is "duplicated", as you say, the actual differences are 
baked in at compile time. The "duplication" would also allow to have 
always inlined functions for write-rare and leave more freedom to the 
compiler for their non-protected version.

Besides, I think the separate wr version also makes it very clear, to 
the user of the API, that there will be a price to pay, in terms of 
performance. The more seamlessly alternative might make this price less 
obvious.

--
igor
