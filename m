Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8191DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FCA2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYGS9b9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FCA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbeLBJDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 04:03:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46359 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbeLBJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 04:03:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so9108144wrt.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 01:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E4frXRxd1NVD6OhvDRr9jQEEiRFDLLZYVaWl34FipDg=;
        b=MYGS9b9M/iqXORXtl00bQdDzq/mAtWoXgJsyW4UFhP8a2fVJgPdvvmtwpWx6U/pd1+
         TsZgoXy7vukaRKT0dJuqkGZCjCJgVrJCcWaN3lwZI5dPZ/YAT3FjyrZgbqdNfpyI2VBc
         2HXsaD/byglYl4KoDWEgqevVxboxquIVDRrml0pD4JU8gErOil1bTVzm8DV9Y+KCOYon
         AJgUd4SWx2o/R71zX+YkZK91zvV9dW+zxh+FQpdabEXHcaY8Pv0Tdgb6TK8GOkkKy+wY
         cQVsXVxCDH9eew+b7dfBmBy/lyFs7ayTIT+tt67mhOUt+kactZbWdc9g1bmDlDkiHuLV
         3nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E4frXRxd1NVD6OhvDRr9jQEEiRFDLLZYVaWl34FipDg=;
        b=XtNYM8ZYk5HqQakSZb2MKYEJgdkvsSsgIvpNt0JJICdyT7ebM02VuBDaUuD4w+UBhj
         r2m8z+aQTfKZ6Eot4HN6LuvMhEABDjMMvHXRwCGRURUP9f1pCLSsK8qRrXXFIDmeMSj6
         fvgNJL+0bkS2JrbTi3eSi1SgSXYadquJQoDlBHs6IhcRnordGgM1MzlSKfKlx1cdcaR0
         yj0VJqlXTKitzGGyOHt18FkEZptYl8Nw6KKlb/+NOIIZ3ZAi4BR/aBDADJ6t6q1C4H02
         83w0q1BOcH2K68kO7ORp5a9LiHkm6aKCNH0Wuh4dTYLe5a7soCaO/JtMy+x1JH5DpbkG
         ZZKA==
X-Gm-Message-State: AA+aEWbjn5OtC7FcOH2K9YlueC1HOngBYe7qnE+NJaONX1u3YY3ahcxP
        1pmLFBn1xrhZLxlmDm40pg==
X-Google-Smtp-Source: AFSGD/XCW6afZP8cFLhxw2hh2W+QLDczG1O6lLMDI5ZWmU3RB12e9ZDZqOJF/iCfAnGw3Px9u8PExg==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr5821955wrq.265.1543741377927;
        Sun, 02 Dec 2018 01:02:57 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id d2sm8582348wrs.97.2018.12.02.01.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 01:02:56 -0800 (PST)
Date:   Sun, 2 Dec 2018 12:02:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drop silly "static inline asmlinkage" from dump_stack()
Message-ID: <20181202090254.GA3896@avx2>
References: <20181124093530.GE10969@avx2>
 <20181202073338.aqkrezckv3mbqfj4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181202073338.aqkrezckv3mbqfj4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 09:33:38PM -1000, Joey Pabalinas wrote:
> On Sat, Nov 24, 2018 at 12:35:30PM +0300, Alexey Dobriyan wrote:
> > -static inline asmlinkage void dump_stack(void)
> > +static inline void dump_stack(void)
> 
> Why is it "silly"? An explanation in the commit message would be useful.

Empty function will be inlined so asmlinkage doesn't do anything.
