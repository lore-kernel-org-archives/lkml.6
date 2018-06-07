Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ayOICWsoGVvyfAAAmS7hNA
	; Thu, 07 Jun 2018 12:43:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A0542608B8; Thu,  7 Jun 2018 12:43:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEXq7kPq"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0F9E3607E7;
	Thu,  7 Jun 2018 12:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F9E3607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeFGMne (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:43:34 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32842 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeFGMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:43:33 -0400
Received: by mail-qk0-f193.google.com with SMTP id h7-v6so6444749qkm.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8jcHIO5M5eC0KSj3+NsblS9FR+TlbhcP3F3bH+2fw7o=;
        b=vEXq7kPqcOYGA7ehrkm38LYHCOGltndgrghLrvGuTYeQANRs2wg9nu+m/p0ekkunoI
         vFaEvsMY43uF/9NFdQ444agSPKSb8SlBOE8aHOi+6Y7WOSPuDGcC1wQoqYzzedPnYNlT
         OOf7NYsGnQCjYwJUSG/YWiMdKTyJsuoJCr7vspVuum9m06SRf1XUSnXvZ0FIfDWM1YE/
         te8aBicX6+RGG+Thrlf+O0OB1qG5oLRduU5m3bCmayTG5l74SCbOpfG8QwBC4AZCeSLT
         jjr9Nslbdv6XPfIbtkm0Vwkr7jSdiqc4gQagVoRJCiAZgRKdIN0wRHlBfJRtiE8sJCKh
         Ms2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8jcHIO5M5eC0KSj3+NsblS9FR+TlbhcP3F3bH+2fw7o=;
        b=nxqRPQmrMq/dcn1Pp099xEmEGtay+hw6qF2kvGRzgwwMu9AI0wQ5EK3UyzKR+czNmD
         TRTH7q90WQmcRoDgaOlsaHOEgqcnmSgY46GBisDVz+O95NDV3doG2B5B3s/KPKLuvbJ3
         PD6GSQVjYvxxxCmhJexOZJhNJ3xTxUZZtVsq1vuwsWfB36dUu8/LNAQADV9caFwzgNbX
         +iIuMzocAHofaoChZ9lvUnPLkd9ZqRqapMYidWVApV05ZqX7M+94eTmbIYqXIfyzfRUo
         gmEFbm35Cui/6zpS0sjsUEFMrc28k6h3lbz/UoVX1iV03pzMAY/Zdr3Uq9oJqGb1CV4/
         VTww==
X-Gm-Message-State: APt69E3T0HxEHPc54lzSrSYtr/DIf5fpYLaRGo+Rf3M4EVuA5QP5P/E5
        Y5R2JrTYugYIGqyi+/Igv7vmainJp+maZEKfon4=
X-Google-Smtp-Source: ADUXVKJH2bvTIjB3JU34L6TCtIKvHwO63u0dwijWiBY2tQaXEwzAABGjgxRq0HvIgX3f8pJrS2cSHhExKHEdR1Y0XGE=
X-Received: by 2002:a37:129d:: with SMTP id 29-v6mr1283152qks.263.1528375412409;
 Thu, 07 Jun 2018 05:43:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:4716:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 05:43:12 -0700 (PDT)
In-Reply-To: <22cb30ea19ad4ab1b341836c5f672ba406cb2b4e.camel@perches.com>
References: <20180606201556.GA10832@ziepe.ca> <22cb30ea19ad4ab1b341836c5f672ba406cb2b4e.camel@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 7 Jun 2018 14:43:12 +0200
Message-ID: <CANiq72kzLg2Y2oV0PNTGLP-2ZzW9q_GitR+WSAyHjNZJ2PPbnA@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Set IndentWrappedFunctionNames false
To: Joe Perches <joe@perches.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 10:18 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-06-06 at 14:15 -0600, Jason Gunthorpe wrote:
>> The true option causes this indenting for functions:
>>
>> static struct something_very_very_long *
>>     function(void *arg)
>> {
>>
>> While a quick survey suggests that the usual Linux fallback is the GNU
>> style:
>>
>> static struct something_very_very_long *
>> function(void *arg)
>>
> []
>> AFAIK the above describes the more common choice in the code base?
>>
>> Not sure who's tree this is supposed to go through.. Andrew I guess?
>
> I believe so yes.
>
> I expect there will be more refinements to .clang-formata
> as perhaps more people experiment with it too.

Yes, indeed! The version I committed was an initial approximation --
don't expect it to be the "final" or "official" one!

Cheers,
Miguel

>
> Acked-by: Joe Perches <joe@perches.com>
>
>> diff --git a/.clang-format b/.clang-format
>> index faffc0d5af4eeb..1d5da22e0ba50c 100644
>> --- a/.clang-format
>> +++ b/.clang-format
>> @@ -382,7 +382,7 @@ IncludeIsMainRegex: '(Test)?$'
>>  IndentCaseLabels: false
>>  #IndentPPDirectives: None # Unknown to clang-format-5.0
>>  IndentWidth: 8
>> -IndentWrappedFunctionNames: true
>> +IndentWrappedFunctionNames: false
>>  JavaScriptQuotes: Leave
>>  JavaScriptWrapImports: true
>>  KeepEmptyLinesAtTheStartOfBlocks: false
