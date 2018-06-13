Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B0B5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AB7208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIx4p1wS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AB7208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935350AbeFMLMu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:12:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38037 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935328AbeFMLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:12:47 -0400
Received: by mail-it0-f68.google.com with SMTP id v83-v6so3284655itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mgeI4a8+2rRfM580R67qEpicU3fZbbj/kzMeULj27NA=;
        b=XIx4p1wSA2AvIAjqVTYeG7+RxmCgwrFIpzZ25DegsYv8M9DMr2oOQnsy4L8gtO20zd
         owtplfbMykRpwds8S5dQQcJ5hpkOJwl+wp+xEovL7BxhR3ZgkzEMqg5jF5btdXXsbS2M
         MgjTQfVzpk8Z/bi2KGdmkHuJ57mwRVXDdIr84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mgeI4a8+2rRfM580R67qEpicU3fZbbj/kzMeULj27NA=;
        b=QFuSx9GLrXA2kTnNDQYcD2CikrXHcUGmeJ4Ka8TPqrf7Pr9ZlTl0bFt5QfhsaKyb8r
         iaFHjG0UH/nQ9WypEDJAV5oiR9vrOBY5YfsHz0ngcQ8WmHR8CLXf17mBnHpDXBmXO2Zp
         moTa/5EIGC3RuSZoaXRCIcpQxUEVtODmUOu8gVMHIArGUvZ1qTtH43o38LSJCWGZ/Wbk
         QatEzDF2SbA9G92GiyvCIbNpt2UPHXYBe1VW7SAnNiJSz8p9QQTXuXDak7dtjAQjvrAA
         VJAK7cqyR78ifDD1J/o8JZODZVysgh+dNfciBrjJ6aXHrQuVrIfAKZC+Cs8AvG/LHKhJ
         yEVg==
X-Gm-Message-State: APt69E3GGifSIOz2XrnwSwF096zn6x9zYsX5ibWGzyzFPCNgE+bP+6aY
        tmXhedkK7pNQdZFXNRKXpWRH2RchX9ubJ11J3UePaQ==
X-Google-Smtp-Source: ADUXVKJC77AEOupsOxD7YNiN+lHYgQYKUgywR+5cH6JOQ7hOAT6RPypn2lxEWWhIWh9Mj89AUsHE69p6FOgh7Ju9nmQ=
X-Received: by 2002:a24:690f:: with SMTP id e15-v6mr4150547itc.70.1528888367161;
 Wed, 13 Jun 2018 04:12:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 04:12:45
 -0700 (PDT)
In-Reply-To: <CACRpkdaKMr0qm91Q4LyjBGyKG_H4vvMr7bnRJeai+f2Eg-9r0Q@mail.gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180607181306.9766-1-ctatlor97@gmail.com>
 <CACRpkdaKMr0qm91Q4LyjBGyKG_H4vvMr7bnRJeai+f2Eg-9r0Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Jun 2018 13:12:45 +0200
Message-ID: <CACRpkdb-GeOUSPQeJoMe-My-ZugdPWn0DDVQST5e7XFzt1TmHw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] fixp-arith: add a linear interpolation function
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 1:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jun 7, 2018 at 8:12 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:
>
>> Adds a function to interpolate against two points,
>> this is carried arount as a helper function by tons of drivers.
>>
>> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
>
> The linear formula seems to fit the most natural form of linear
> interpolation.
>
> I bet some John Carmack algorithm type people will soon
> start to optimize this... :D

For your entertainment here is some sunday reading:
https://fgiesen.wordpress.com/2012/08/15/linear-interpolation-past-present-and-future/

Yours,
Linus Walleij
