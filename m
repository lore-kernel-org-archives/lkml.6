Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48590C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0290A2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQZ+80j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0290A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeJ3E0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:26:12 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:36174 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3E0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:26:12 -0400
Received: by mail-lj1-f173.google.com with SMTP id s15-v6so9033216lji.3;
        Mon, 29 Oct 2018 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NUYptIum6tI5/3Gjw2sGCgiaZibf6kTLo5FT7lE3Ed0=;
        b=oQZ+80j9ZNTFDQZ3+7wA76aU32gcE9UmE36beLaKnPG6s6ZjfgxookcO1eSMaMNH0n
         WE94ypKV77boBmHfcjBmVMvpPwYYYPdmbvErFCDoBAyV57Lh8mccjLcOTSENhehGga8s
         OSqRawJLzRn5IFNIxfXQ8gexLg/4lOJBissZzKWWImI4WgXQpt7SCJz4Gdlm8jWojgmu
         ZQhNNtkhoXq8tG/D4oJa0J/QouOUt0iHVxL47H14gB7K41PSOunElvPQRzeGd9kQ6XZH
         8YC/tQkJWKha49WAR0V2dV25l3WugorNsem9DjbRvFX+l98s+MjUGjfNyMiL+rtgX5XU
         IU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NUYptIum6tI5/3Gjw2sGCgiaZibf6kTLo5FT7lE3Ed0=;
        b=ImrxUPtUJciIoh7MjQUrHDajdAXof//5d6lwAOCBZqgMxnyJYZHMTzh5djCeBx2xWf
         x+82EMZTnzZpmzBmQPRDR3bVvUQ3Om7SIbYn6qDA3/OFVoQeaQQZbmmkEWuaQ1ocnrv1
         oROskJCmvr8IWuBuMMIma62NLCn7Pa7Gluh5M8LYXAxrB4gChEK/C0ILgvt7qDkqctpq
         +P2d4G0JpwY6G+YiGqzzzBCNyCI4fN2biSCR3k7fTf/ClQU50eWOLpy697cI6fiakgmq
         Rg2Rvm5WE0Mx3OC8Fvw0TgeR9vvOLSdg+p2QvuWbUEJuh4YxnPo8L6mw93cqWRn6wlq2
         v6hA==
X-Gm-Message-State: AGRZ1gJo+UcptBHieBoJZvHwH86ozB7c3EuKyYRfoEQfLM+QXH1Xy/iS
        3lruySRoc6Ga42sM3kvY4ehsuy5mETw=
X-Google-Smtp-Source: AJdET5cYI9BVmXsSReUZ/+VmeINZesPQ1zW1S/8WmxMy5IMQLBm8wp5DfMYjk9Dde7vds0be5mAehQ==
X-Received: by 2002:a2e:484:: with SMTP id a4-v6mr10077366ljf.27.1540841764367;
        Mon, 29 Oct 2018 12:36:04 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id p192-v6sm1996315lfe.7.2018.10.29.12.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:36:03 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Markus Heiser <markus.heiser@darmarit.de>,
        Peter Zijlstra <peterz@infradead.org>
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
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <094556ca-ea87-9c4a-2115-600d2833fb2a@darmarit.de>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <c3a66398-a1be-9fe9-9108-93dc6a9bbcde@gmail.com>
Date:   Mon, 29 Oct 2018 21:35:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <094556ca-ea87-9c4a-2115-600d2833fb2a@darmarit.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2018 12:09, Markus Heiser wrote:

> I guess Igor was looking for a definition list ...

It was meant to be bold.
Even after reading the guideline "keep it simple", what exactly is 
simple can be subjective.

If certain rst constructs are not acceptable and can be detected 
unequivocally, maybe it would help to teach them to checkpatch.pl

[...]

> see "Lists and Quote-like blocks" [1]
> 
> [1] 
> http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#lists-and-quote-like-blocks 

thank you

--
igor
