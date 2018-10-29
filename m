Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0223ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89DB2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS6/LNDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89DB2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbeJ3Dz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:55:27 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:42870 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ3Dz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:55:27 -0400
Received: by mail-lf1-f51.google.com with SMTP id q6-v6so6918803lfh.9;
        Mon, 29 Oct 2018 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Vdgkgu5dqbHq7kAdM9OJ4GdnKQM3UrEPnn4ycmTJbA=;
        b=lS6/LNDw7uVCAu9TvA5A2/2wcq+sq29kMM+4KzPv/GF9Fxhb9VOt6aqXD4O15xOL6K
         5rWT950PxWqUJ88RLkuKGrMniR1P+4k3Ow0Y1LPjx1zGzRP7KpVU7WAqkdMrouXpf2qt
         unUwse4JPlxDGoVUQxTug95xw0jzZSGsKUPr8D4B12Y0Hxk6OKmMmxg1bZ7Knqa/98PV
         Lnj/3+ZGKFhmM59xltmXyuPmU8lFogzAEaiOyf0YS0QHWrbSIt6cAUmkh4YfnNBPb01S
         siyin1aAJOGLs+DtQdKsa8FZT70dvMTUtphFH71XkKwR+qbwNTKcZ4viNfyjTRA9RbtB
         wXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Vdgkgu5dqbHq7kAdM9OJ4GdnKQM3UrEPnn4ycmTJbA=;
        b=btKpMrdCmhYV6Dj93J7w06/3Wj6TD4nmsxfP5xEgq4p7hPGNx6sS+wkOhWw3fI8HER
         g9rVZz2072NjlisbyUdhbw2rKY+fSU1WSOrn/fv2qqebYJqfMmBOy3+EzIKR5fa+VBTD
         h0pLKTn/uRe1eSWE0BHRw3NNqcRgMCX5REDxDtFFXXCNrxlOjRAYnDdBvgMiyJlcyY7Q
         nE3IXUpYkBo61C8jOItH4K8R08C/lp+0oemnciMlEqfcLcOdWMULomXEbAw6iD4pWX7+
         +MIUgAC3hirEK0tKP66rm39rmgSC8VxFnxLUhjb+pKzRCCmoYEUfgUb41poHVMaWXW6u
         VQWg==
X-Gm-Message-State: AGRZ1gKmhAgIaOzyDmk5S5IOoKfklW0zJaRyJqpsQa2hSOie6VSyi3je
        /9DPTt/v/yArjG/CgWlLEjqt4nsbfBk=
X-Google-Smtp-Source: AJdET5eF1FVNwEKahbYih6rHErSOannQtX1jSqMfTJ9tmzfTVUrCt5b81RZbPuvliPGQBgEqs+KgTw==
X-Received: by 2002:a19:5510:: with SMTP id n16mr8953999lfe.68.1540839925976;
        Mon, 29 Oct 2018 12:05:25 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id q5-v6sm3199673lfj.85.2018.10.29.12.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:05:25 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
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
 <20181024230426.GA27484@rapoport-lnx>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <dc9f6353-f484-81ec-31c8-04a4b63aaad3@gmail.com>
Date:   Mon, 29 Oct 2018 21:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024230426.GA27484@rapoport-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 25/10/2018 00:04, Mike Rapoport wrote:

> I feel that foreword should include a sentence or two saying why we need
> the memory protection and when it can/should be used.

I was somewhat lost about the actual content of this sort of document.

In past reviews of older version of the docs, I go the impression that 
this should focus more on the use of the API and how to use it.

And it seem that different people expect to find here different type of 
information.

What is the best place where to put a more extensive description of the 
feature?

--
igor
