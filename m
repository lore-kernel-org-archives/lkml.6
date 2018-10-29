Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A171C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB7C20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSDfw0Ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB7C20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeJ3ESV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:18:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44091 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3ESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:18:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id m18-v6so6970204lfl.11;
        Mon, 29 Oct 2018 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JBSrFj3O8LNxKuKz0PuGBw2F7O3AoE7ZdTVHGW8CSiY=;
        b=TSDfw0OwfQAxcJlmIY4nTIl82Mq5rMVwdxCZlwAdBeMTudjDeD9iJJbL/9RhCo9l3P
         HSS6FkT1lOYQ3Xj58CO8ytl256mDUEL3BGe8ACR7uLgehvE0MXI4twNXrDNm2DTywOTx
         XPZjdrqRLtnQk/0IFoJUWqNX8WgOyoOx/zIvknXmL/iElmRszdVGB1YXd859CrWLiJiv
         mN0gT32pyVB0wYD0A18Yeuq5gUB/FfNOu+Ah03yx8KXlHLapFRnvYi+KUbwECd8o/r18
         31JWo/tdOYt/90PiBmmp1ckmo6drXEE+xgGwYiznNSfajbnqVgdgJEK3CIgw+LjsZL2m
         nJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBSrFj3O8LNxKuKz0PuGBw2F7O3AoE7ZdTVHGW8CSiY=;
        b=TXlBuLvQggYDg5Dc8lNQ9KqnufmMXzs6LRK7P1QA0OwMzOdYoMIj0eBTn/v6jmXp2Z
         GdGX/gVsZqdQ5aS/ffrK92VTK+ITKjK3N8xrYBaPzqxqaB4Xjekd6gwsgB0b4Nq4x6OL
         54XE02R22rMoEue9uxYvJPBVWrm1fSk52/rMIMmaOLXZbXZLGKBfAIfm1a9VagbPw1pD
         hvs3L0vozZRwti/sz4sxoiuT3Ih34Qj//CI0s4t7AtUnd5tqjLuOovWxX3JuIhXYHMv8
         3x+vvep5ca6SYsAehBqzQT4ubeLA0eShzz+O6ex9qFyKRvse9yKnytoX/xss4mB1CXHX
         PEXQ==
X-Gm-Message-State: AGRZ1gJtdgdaE+or3D8//pPbGOREaaO4+mUl/BN5P2ilxlSwowGc0peR
        djrePV70989xGt4DgCem6bkcXzQMOjI=
X-Google-Smtp-Source: AJdET5ckG+jRcFcSbIvNw2tSVzwhOVdgoCJ8g72cREZKxuHPpvNAuf7Og2LR+4rHGR7UC9SJaCMH5Q==
X-Received: by 2002:a19:978c:: with SMTP id z134mr7232lfd.109.1540841295393;
        Mon, 29 Oct 2018 12:28:15 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id 75-v6sm1136016ljs.50.2018.10.29.12.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:28:14 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <20181026102009.GP25444@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <6f554454-ab8c-92be-a2b5-543e609dc351@gmail.com>
Date:   Mon, 29 Oct 2018 21:28:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026102009.GP25444@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/2018 11:20, Matthew Wilcox wrote:
> On Fri, Oct 26, 2018 at 11:26:09AM +0200, Peter Zijlstra wrote:
>> Jon,
>>
>> So the below document is a prime example for why I think RST sucks. As a
>> text document readability is greatly diminished by all the markup
>> nonsense.
>>
>> This stuff should not become write-only content like html and other
>> gunk. The actual text file is still the primary means of reading this.
> 
> I think Igor neglected to read doc-guide/sphinx.rst:

Guilty as charged :-/

> Specific guidelines for the kernel documentation
> ------------------------------------------------
> 
> Here are some specific guidelines for the kernel documentation:
> 
> * Please don't go overboard with reStructuredText markup. Keep it
>    simple. For the most part the documentation should be plain text with
>    just enough consistency in formatting that it can be converted to
>    other formats.

> I agree that it's overly marked up.

I'll fix it

--
igor



