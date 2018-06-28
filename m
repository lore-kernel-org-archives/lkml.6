Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5389C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D3926FFA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="TEDX9UF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D3926FFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933908AbeF1HGX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:06:23 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32995 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933017AbeF1HGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:06:20 -0400
Received: by mail-vk0-f65.google.com with SMTP id k194-v6so2255199vke.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1LZJr6f5vS3JQkmyoG7iPNHmXfruFsg9pthoHDriIV4=;
        b=TEDX9UF0RkxNfjhGNWVtJcADgZGuEK9PUugaCV1CodgbHuKSAN/ryR1r+jimQhCDei
         Vr3Tm3lFMsMcy91EkUygnHM+WWqgfFKtV0P1QprO93B/ipEU72Ml7Lrf2au2uaH5evZe
         F9s5ZuofsSOTIQe17OKT6SftX/x66PV7LE3CiAevse6jdHvu8eyPrz4lDqzYr80zpal/
         69+aVyKYZXxAGZWI6EKEN0UN1ASn2K6ES58eUhi/2hU8SgIzZDP80EjTx/+B6sT2uIfl
         5rMd9XpGFFvudtoh0yKYhZ64QFzkwAUjtWdxdq4H3of/bo+bbokuRBc0p8vM7eGRU9zJ
         Gdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1LZJr6f5vS3JQkmyoG7iPNHmXfruFsg9pthoHDriIV4=;
        b=kIf1vTN2EnUj1V86pMESZDDbT8rujiGmRmvujygvPb1qWtQP05hExf6d3FYaPbmJP+
         UmG8PZsW2165JIeXIHBpzB3wLVVvkjQO89TIkUOKv/qtlafCTE1O3gOsjZvyLmVMybP2
         C/If/HL+uB1CH66Yv74HQAhtEtMPS2IrR1zrEWzKO4ST2pdWaRlBB9iCbnCHta7DhVE1
         OAXhMSThEgNEIWKZRVy/7xmpApA/QHK0n1WvLV6z9Xnv6BGwsW5YEEJ7A+CJQL/wGx1l
         /FQfuxCxlubrMmmb8C8fs52Rr5OWDOAkIUkTByZDjKaJoYY1PL6DYFiRh5i6RzPxtW4e
         yHbg==
X-Gm-Message-State: APt69E3qYM+WjldyPUjvolS9vr3I6IecgJGyLbYfhz+gbK2o45qZl7IH
        0LZhJsBLMCk8lVTy6oOp0KTv7+F1S+dX5GVpP1M1p4zd
X-Google-Smtp-Source: AAOMgpdFZg97/uaLzUKlm4piEH73EDX+SDk7YrFC/woTbS4J9QUiDlEi10W+ljdj2b30sgqfJEk7uOnRrKfVJx0VCQo=
X-Received: by 2002:a1f:b393:: with SMTP id c141-v6mr5574412vkf.37.1530169580132;
 Thu, 28 Jun 2018 00:06:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:4de3:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 00:06:19
 -0700 (PDT)
X-Originating-IP: [217.140.96.140]
In-Reply-To: <CAOtvUMc0j+5+uYZH9=kwV=Ptx_df=qSRceGsuouf-FuV7Mkw0w@mail.gmail.com>
References: <1529581652-31294-1-git-send-email-hadar.gat@arm.com> <CAOtvUMc0j+5+uYZH9=kwV=Ptx_df=qSRceGsuouf-FuV7Mkw0w@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 28 Jun 2018 10:06:19 +0300
Message-ID: <CAOtvUMeO3XuFUZvauc_z+bkSqnO9bJdK77oeDJ4CpTVSAiK3wg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: fix finup
To:     Hadar Gat <hadar.gat@arm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Ofir Drang <ofir.drang@arm.com>,
        Gilad Ben-Yossef <gilad.BenYossef@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,


On Thu, Jun 21, 2018 at 3:25 PM, Gilad Ben-Yossef <gilad@benyossef.com> wro=
te:
> On Thu, Jun 21, 2018 at 2:47 PM, Hadar Gat <hadar.gat@arm.com> wrote:
>> finup() operation was incorrect, padding was missing.
>> Fix by setting the ccree HW to enable padding.
>>
>> Signed-off-by: Hadar Gat <hadar.gat@arm.com>
>> Cc: stable@vger.kernel.org
>
> Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> Gilad
>

I took a 2nd look at this with Hadar and we realized we can write this
in a way that allows
for more code sharing. Please drop this patch. I'll be sending a revised ve=
rsion
in a second.

Thanks!
Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
