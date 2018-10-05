Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6FF20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Anq9FjmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6FF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJENmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:42:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46256 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeJENmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:42:52 -0400
Received: by mail-io1-f68.google.com with SMTP id t7-v6so9850393ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 23:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OdBYIndzx56flpF8YnTt5CJdXFIRCGJhGB0f1DFnZZw=;
        b=Anq9FjmCdQ23Lo5mhiKu+cWoqRR+KlUmgxdTP3/t8IQCOVebj/srfGPghCgSCeOVAE
         XqSLx3aLiw6CVi2voujUzY3TX9h5FlP99Q1Ke46ogPLqpoAFmS1rWMuO/GIvPKWO+kzz
         3aQFP4URR1+3Dm2/2SIweyAiTlWF4WY9z60cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OdBYIndzx56flpF8YnTt5CJdXFIRCGJhGB0f1DFnZZw=;
        b=VIRDF6nLorMBVENIkVJX4FDn3O1gxcU8g+hN1d+1WQ2kfqoclZOoPe9A+CpQjA6mNf
         W0mdGvE+MJDJypUnTaJrfbi96kEvKV9+JXpcxR4flw4mMnD5eJ0VItoWWCIzTLx9R5B5
         ypkGN7Sz9zfa1ut2t/MSqFcQYiPCHaDCdWi5sUI8gn6D0gg3vmE34eDQtqO7RPovXLhS
         Jchx3rtsEi7SA/zBC3/02sGntFD6lL6JXBKAPUElfwHB5JFSBbULJv9T2dnjAaKl/61o
         jOiqlDs36gToYoHBfA+nipi9+WZQgCpw5eZLj4ZnNlQ7q8ebnQxNw/IRdzj3KB/8VOGa
         VEhA==
X-Gm-Message-State: ABuFfojgHoEo6VTQv3ki7/0glXdEY4gYVS/fqvK9L6WErfjMdsTKzXiF
        lMK/65fwgIGTb8tYqtFqeABZ87W6exdaL1Zri8PUkQ==
X-Google-Smtp-Source: ACcGV60FIwB6/3y+zMANWlJnX2qKr9ExtL2eF6XbdrVvIVQnl0vD84PATU/gSJyeTAbvuwIehukUi2DlmmpR8gTbl1k=
X-Received: by 2002:a6b:3787:: with SMTP id e129-v6mr7184159ioa.60.1538721936485;
 Thu, 04 Oct 2018 23:45:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 23:45:35 -0700 (PDT)
In-Reply-To: <20181005023138.dg22cn4salb3p6zl@gondor.apana.org.au>
References: <1537449521-16182-1-git-send-email-gilad@benyossef.com>
 <1537449521-16182-3-git-send-email-gilad@benyossef.com> <CAKv+Gu9T7Z2oV8TEaN8uVdrFxGmmCKLh6ZjDnRnhgCmLwuVf4w@mail.gmail.com>
 <20181005023138.dg22cn4salb3p6zl@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Oct 2018 08:45:35 +0200
Message-ID: <CAKv+Gu_a1n2fWXn0U+ApXoRGDRLieOkbMo_ROq51gZc1sBxYXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] crypto: add output feedback mode
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        "David S. Miller" <davem@davemloft.net>, ofir.drang@arm.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 04:31, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, Sep 28, 2018 at 12:06:29PM +0200, Ard Biesheuvel wrote:
>> On 20 September 2018 at 15:18, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>> > Add a generic version of output feedback mode. We already have support of
>> > several hardware based transformations of this mode and the needed test
>> > vectors but we somehow missed adding a generic software one. Fix this now.
>> >
>> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>>
>> I couldn't find any users of OFB in the kernel. Any idea who is using
>> it and for what?
>
> Yes this shouldn't have been accepted however the driver did go
> in with OFB and it's been there for a while so that's why I'm
> making this exception.
>

Fair enough
