Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5898ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BBC20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sUm8O6XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BBC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeGTNLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:11:19 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:35911 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeGTNLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:11:18 -0400
Received: by mail-pg1-f170.google.com with SMTP id s7-v6so3333853pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sJ3rGLoIUD7X7oBGR8Xn6/uTGdSMGiFVkeFzv/1mG80=;
        b=sUm8O6XEJZzLYt3hFNK4mw/6T45eyIiVhRqubbJ4SLg/J7US8UL+yO7kOsNsGgVq+c
         HzonsUKui2UfTX8fNRE9MUuFFGySR8hwWxfR9KY7uY+OYLUZXz4IkggB5gbdYg7arSfQ
         zjZmMZXwS/15jFqXAwXabsnqcwuYlT0AqnTQEV0Bi1ePF3ZRPp8jVd5XHF79Ji/WqpE/
         vycG+ZF/oe5MJrdCTwPxdfqiRwT0U6akQRvEunFiOj94SRNVeQrLYipGI7DIDeJZghKc
         1V8dpfXCgmXP/dSJ/TVCjrcx9AKAHfz8wL0ISAyi1ReVkZt/BuQQz3HcVDVO1t1A2Jd9
         6pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJ3rGLoIUD7X7oBGR8Xn6/uTGdSMGiFVkeFzv/1mG80=;
        b=TUXjSDCUBsbE6NqqgU0Bs9YciqI87Q6WLX79z4ahtudTB5JqjCqUQIm2WdS42ZBcCY
         6mbYvUIUDELu1LBn6gfhTBYtp2B1TUW9sos0+T6Fe/FvutIFaDvOaK1i5gjeCr/W7XiW
         IAG0tIM2xowX3/uDVUMEwcHkkibMac8vefT4r9wcSdPl4iWMppjOIggeqlgXVvt+Kew/
         WapfHUjTjLnY4zDl7NqWpuaWePRC95MeundDDLE6/a4gBIsozRBIdBpOMFmmDVZEBbZI
         4Rq8HLT5WPi+er5ZaiOwLI6pFhxbdPG0PjLutLyypjAUhS/h3pWHDKyYib5row3007xp
         df8Q==
X-Gm-Message-State: AOUpUlEcWrk2hU791V027CZvncsXQd/Ou2xN9Okzd3ELg+bnpt+ZXFEE
        PIee+A1fwn+KtHQZdxFlMUVueA==
X-Google-Smtp-Source: AAOMgpdCi9jreyJZ3HcipOk1CuHTu0kxXQ1Cgp8jqpNpQs6kbGYOofkTYuCPMXEfo+67ylY4Ec6cyQ==
X-Received: by 2002:a65:6699:: with SMTP id b25-v6mr1916917pgw.426.1532089399750;
        Fri, 20 Jul 2018 05:23:19 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id s195-v6sm6994407pgs.76.2018.07.20.05.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:23:18 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 45A91300254; Fri, 20 Jul 2018 15:23:15 +0300 (+03)
Date:   Fri, 20 Jul 2018 15:23:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 03/19] mm/ksm: Do not merge pages with different KeyIDs
Message-ID: <20180720122315.5lue3trrmvewvxg2@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-4-kirill.shutemov@linux.intel.com>
 <a6fc50f2-b0c2-32db-cbef-3de57d5e6b16@intel.com>
 <20180719073240.autom4g4cdm3jgd6@kshutemo-mobl1>
 <3045c925-f5a8-ae68-8f77-4cddaf040f9f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3045c925-f5a8-ae68-8f77-4cddaf040f9f@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 07:02:34AM -0700, Dave Hansen wrote:
> On 07/19/2018 12:32 AM, Kirill A. Shutemov wrote:
> > On Wed, Jul 18, 2018 at 10:38:27AM -0700, Dave Hansen wrote:
> >> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> >>> Pages encrypted with different encryption keys are not allowed to be
> >>> merged by KSM. Otherwise it would cross security boundary.
> >> Let's say I'm using plain AES (not AES-XTS).  I use the same key in two
> >> keyid slots.  I map a page with the first keyid and another with the
> >> other keyid.
> >>
> >> Won't they have the same cipertext?  Why shouldn't we KSM them?
> > We compare plain text, not ciphertext. And for good reason.
> 
> What's the reason?  Probably good to talk about it for those playing
> along at home.

I'll update commit message.

> > Comparing ciphertext would only make KSM successful for AES-ECB that
> > doesn't dependent on physical address of the page.
> > 
> > MKTME only supports AES-XTS (no plans to support AES-ECB). It effectively
> > disables KSM if we go with comparing ciphertext.
> 
> But what's the security boundary that is violated?  You are talking
> about some practical concerns (KSM scanning inefficiency) which is a far
> cry from being any kind of security issue.

As with zero page, my initial reasoning was that mixing pages from
different secrutiy domains is bad idea.

-- 
 Kirill A. Shutemov
