Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C032C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453C923C52
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htq8o7xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453C923C52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934408AbeGCRgp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:36:45 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46496 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934141AbeGCRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:36:42 -0400
Received: by mail-ua0-f195.google.com with SMTP id r18-v6so1747154ual.13;
        Tue, 03 Jul 2018 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8NY4DJoQ+auWNOnu/CCbxd7QbVY2b9rCae1kqPpSiLg=;
        b=htq8o7xIhjI/eePTYQ9Hyso2m4ayosSp/4OIHDWsiIFvh639SAi4YcdOLlg6xWOBwq
         Z4RUJzGowhZJe2xpxKf0yWrxHvmBZG4qRkUVfsRJWj6tQvVJrzXxn/D3rNvyvc83zqKk
         /5Vnm8zAe+ZNpG0mFgDD2HB+H+bcsahwfOv2SpP63XOWN+lM4lxtJ4/120t7Zn9ZTAOM
         zC1ZbK/o3du9DbBuuJsZKSF9Orwg6X1hkdc2IEuN1LjW87bCx9/e9hvjicqmS/BuG/vX
         C1ylR/yZmED+J27ZLXNkE+0curWWIlf2mLgt/4iaxUOmr1FPg8nD50jtVutb7peeOtgU
         kBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8NY4DJoQ+auWNOnu/CCbxd7QbVY2b9rCae1kqPpSiLg=;
        b=ebCDZFsndFWUPRpTLnexiOeCs+wlnnAlGMR8UA0JV6R3rB8EbEL+cnnc5KGGVZMd0C
         0Hwv3Lz6ngRyLhZHjkIPCTyl1KtPtwLN0GaAiOjGX5xN0tFu80u0qRMez+5Fn/RCy85Q
         JVj6fGKta2wSq74Q3T83bqYf0qQ9bPpbK5NpuT0+4nOIvgWepV0XFhsO018fhFIpeK0H
         bONA1sMMTwGMpCGToxXVQixIHpKjIhH5P+nAYzKEqobRpMmP5GilG5kB0URCDiihT3ln
         EAQRqVolYYsGzN4zz/AC1GN4gcBbCfS+tapau24XGpYmqDNyJvigljh3wEryll5Xrtwa
         vjZQ==
X-Gm-Message-State: APt69E15uXnsg+ymg32PaDpoIISpMenZ0a5XW785II7xO4cA8rk7Qb0L
        VPf+nOBuiyDdQu7f6EUZtb9NEHn6EPGZXQTE5SNKWw==
X-Google-Smtp-Source: AAOMgpcAmp0PnNC6qY05uQSyCYBAUYVL+LzDWZCpHutt0IPblMSbmbcvcsTlCsJsoD8mZmj3JWFYzz0iQ9cmKlPneoo=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr10805390ual.141.1530639402011;
 Tue, 03 Jul 2018 10:36:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 10:36:40 -0700 (PDT)
In-Reply-To: <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 20:36:40 +0300
Message-ID: <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 6:31 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Logan,
>
> On Fri, Jun 22, 2018 at 4:47 PM, Logan Gunthorpe <logang@deltatee.com> wr=
ote:
>> Clean up the extra ifdefs which defined the wr_reg64 and rd_reg64
>> functions in non-64bit cases in favour of the new common
>> io-64-nonatomic-lo-hi header.
>>
>> To be consistent with CAAM engine HW spec: in case of 64-bit registers,
>> irrespective of device endianness, the lower address should be read from
>> / written to first, followed by the upper address. Indeed the I/O
>> accessors in CAAM driver currently don't follow the spec, however this
>> is a good opportunity to fix the code.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Horia Geant=C4=83 <horia.geanta@nxp.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Dan Douglass <dan.douglass@nxp.com>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: "David S. Miller" <davem@davemloft.net>
>
> This is now in linux-next as commit 46e4bf08f6388 and it breaks
> booting imx6 (32-bit ARM):


> Any ideas on how to fix this issue?

Oops, first of all the header should be hi-lo instead of lo-hi.
Does it fix it?

Otherwise I didn't (briefly) see what can be the issue.

--=20
With Best Regards,
Andy Shevchenko
