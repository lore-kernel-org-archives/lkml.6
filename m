Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7652ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD4C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABfCtMKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD4C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbeISXO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:14:58 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33312 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731514AbeISXO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:14:58 -0400
Received: by mail-yw1-f65.google.com with SMTP id x67-v6so2616804ywg.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTAfN7iBnuqfTM/Wb91dnjpM4yrsmApQMl3NFYkxKuI=;
        b=ABfCtMKVVkF17eUvKJCGhnM2kHPHdavbMPWwKR0TwW+IkFTwYG4sTyoMDoSRuDbARU
         E4hyEV7JIVU63pcg8fwzN6SDFwsdPbD7AnvANbaQedxuWg7cWGd8ZuVEewDTDYjvtdmt
         uoOrmQt1+zvv7DSAuBP35XuSd1LiE2gQr789ESydmijdmad9VeOWMb2up9CuAC5JA3FN
         p1d+foedwBki8lwUIUuIlY9j7zaAz3+easWmn0imBrUu4LwgjhdRcX5IVuHOvPzaiXWW
         m6l/QJ+lliZuCA7NNfqv2WX8KTV2CvF6H7EfoIXigMorg8amO6zfqOUjkE2/3d7Kc4gi
         zfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTAfN7iBnuqfTM/Wb91dnjpM4yrsmApQMl3NFYkxKuI=;
        b=i6RFT8ZGnbP/tB2mnIKzt9oz4NHXcNHJ+iRMSb+Eq7nxBwztqLhXlTkt5q48FaE3Ih
         diMihl1lZ8aOTd4BYEYuiI22g53Imdf4YJO0USFC61bcbk+ui7URtNSR8wwYwn55uWnH
         uT+gY6ppUgtCBJiNK27Fa63W3qGJEW696YESVScX51+7wXSIR9nJJiKqV17i95fsxMZw
         CKoXtymappkPaS+9Egqd6ec59yf8GeAMV1BzeMWs8cldj7WTsNZOtcYXo+62mx5RYpcA
         VGbFd/xVu83pSAnHLHnu6i6TvI1RSrPtjb7fB7nLrgspQ1M6ic0BaBvqHODapngpe56w
         oWXA==
X-Gm-Message-State: APzg51Aw/+g1vEFw6CvVA+zmQUvjdwLFTJMxSDmZe93fqTBMJ18vwBTn
        csMrz7YfU6xyyB3zo6ECbXOcdNPxjby7PQafdS3CUg==
X-Google-Smtp-Source: ANB0VdaZ/3QPNHSAG7UwdacOVf/AHnYG0wYEn9O7Aao+dys4OBIuWwFf7dhGmgvYUWv/l2NKlFfNkopVcVLm1KZTX+4=
X-Received: by 2002:a81:78d5:: with SMTP id t204-v6mr15802154ywc.340.1537378560171;
 Wed, 19 Sep 2018 10:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180918153621.71984-1-mika.westerberg@linux.intel.com>
 <CACK8Z6F4+N1paQTSWcomnwLpLEHoospSOT3M9bqFQZHHfWmahA@mail.gmail.com>
 <CACK8Z6GfeJQSMN=m9hrFE2DFwpCNjNb57PqGiXFDD19Y=SXgnQ@mail.gmail.com> <20180919084002.GR14465@lahna.fi.intel.com>
In-Reply-To: <20180919084002.GR14465@lahna.fi.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 19 Sep 2018 10:35:22 -0700
Message-ID: <CACK8Z6HCqN83rtEsV0EzSUcYdkq2Fx+QmOBrtW+ud5V4-ucCvQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: Do pin translation in other GPIO
 operations as well
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        casey.g.bowman@intel.com,
        "Atwood, Matthew S" <matthew.s.atwood@intel.com>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 1:40 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Sep 18, 2018 at 03:14:44PM -0700, Rajat Jain wrote:
> > Also consider fixing the checkpatch warning:
> >
> >         Errors:
> >             * checkpatch.pl errors/warnings
> >
> >             WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> >             #48: FILE: drivers/pinctrl/intel/pinctrl-intel.c:764:
> >             +static int intel_gpio_to_pin(struct intel_pinctrl *pctrl,
> > unsigned offset,
>
> Right, it is currently the "convention" used in Intel pinctrl drivers so
> I did not want to change that single entry.
>
> We should eventually convert the whole set of Intel pinctrl drivers to
> use unsigned int instead of unsigned.

OK, Thanks for the clarification.
