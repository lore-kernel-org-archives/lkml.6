Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC258C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546202173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dNid3tld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfAJKeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:34:46 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:32924 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfAJKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:34:45 -0500
Received: by mail-lf1-f54.google.com with SMTP id i26so7953301lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OqOhCieBDsuj4Y0QmowZiCSjRoE3NQCiR1vLTa8e+bc=;
        b=dNid3tldK02Gr+68KRqDPF6DnySSSBKEEZ6fU7FR6gKZeQdpyyEYEPbOUhXNg9m0y9
         ziofpKxqVHok617LaMu86rQlZJUSf34/wMNE7rz6NzKd6KqSjgSKBQu7GbfXX/KAoCNv
         aLBAz8cdIIcQZf2xgu87OptjG5Pe8SiqeK1JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OqOhCieBDsuj4Y0QmowZiCSjRoE3NQCiR1vLTa8e+bc=;
        b=b42BLBxAnTeL+dJeTRxNNQBKhSPRdpkoFuBdzoXNdGFoJkADh/ZU6pV4Yvl/A8vXfa
         t60cgBquItcrzg44KqkqTxhBrVOC4SViGWRs2mnNm4iuEjVq4dMvyZ1/Hu0waKve/Slr
         t7Ig76C7WS1pKvCJ8JbMPEMmihFCtNU0Owxtfz8Ldh5EQrYPpJvxKBzX7vRkqD06nW5S
         Brwcf2o+VblGsiZPa3zdPyp166ebCSR0Ne58o+wgw7Wp3/9+eLq0vCX3WWSJoU9IJeBf
         kEEFwsdewTTxPO1KhT37XuFvnzHHZ7+9EcKwe8cR3foyTtdmMy1H7fGoa00h4SHRQyhL
         SIPw==
X-Gm-Message-State: AJcUukc33J6NWGAzK2oDJ47CZQXTmlI4J6B+Clgu52RTecJnlKDbFE4i
        1fqtqaP2f3Yj8AjzkkgdT3ynnw==
X-Google-Smtp-Source: ALg8bN4pPvg+jRWYmdxUi4X2rUHwnvo9VZgn1cTsGnfy2GsuyTtB+HtgmJeruf1ABGG03s4Gw5BM+w==
X-Received: by 2002:ac2:51af:: with SMTP id f15mr5255864lfk.44.1547116483520;
        Thu, 10 Jan 2019 02:34:43 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g85-v6sm1799326lji.17.2019.01.10.02.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 02:34:42 -0800 (PST)
Subject: Re: [RFC] Use plan9 C extensions
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20190109203119.GR6310@bombadil.infradead.org>
 <CAHk-=wjjkLv-8oAZPLf=pp4z_-VFpWJw+wTJYevqq0bWWY=L9g@mail.gmail.com>
 <CAKwvOdmOt7xhnLYmNsgJbD=6aM2BKjdqUyeARxinsT4wpSVaew@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <75e59b18-50f1-3300-a574-72515bda46ab@rasmusvillemoes.dk>
Date:   Thu, 10 Jan 2019 11:34:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmOt7xhnLYmNsgJbD=6aM2BKjdqUyeARxinsT4wpSVaew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2019 00.55, Nick Desaulniers wrote:

> I agree that something like builtin_types_compatible_p() in a macro
> could help make these functions more "generic" in the sense of being
> able to accept either a `struct xarray*` or `struct xarray_cyclic*`.

An alternative to implementing all the generic functions as macros is
transparent_union:

https://godbolt.org/z/TK_SJD

If there is an interface that takes a "const xarray *" one would define
another union type

union __transparent_union const_xarray_any {
  const struct xarray *xa;
  const struct xarray_cyclic *xac;
};

The obvious implementation using _Generic fails since all expressions
must be valid:

https://godbolt.org/z/X0bvwO

and _Generic is gcc >= 4.9 anyway. I think an implementation based on
choose_expr/types_compatible might have the same problem, but maybe
there's some clever way around that.

Rasmus
