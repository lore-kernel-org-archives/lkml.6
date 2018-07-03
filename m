Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF5CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC6124943
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q28Ky1Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC6124943
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934461AbeGCSHC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:07:02 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43265 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934194AbeGCSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:07:01 -0400
Received: by mail-ua0-f196.google.com with SMTP id x24-v6so1813470ual.10;
        Tue, 03 Jul 2018 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pi25n1EAlvSEER0ah3U6jnVTn7VB61a/OjzWNsBxJ5g=;
        b=q28Ky1UtKUEfGGhRUc3EXy6CZEJw1ku65STQZ2SdCgovO52qxXC+WWxlKfMLXtiTOb
         7hUXjWco4gznOLAs7uUDn0ZBhJrEqTI4rLbK//fpY7SQ50uYtBYUwJMtzBzbfx4Qupsu
         HNgwAS9b9qyhm7BQ56Oe0l30luz/zQCc4E3r9sz8CSzMui7fXtud4604yqyrovMfC+jo
         gUjvdl40sPMSMME0AZ+4MHQ8sKz3KTVNd5FVBJVM2tT8w7f9eDXh1JTDhvd0xE7cGk+V
         NtnmmCnN1gzSG9PEu5fM3hPSGzRaxsnxz1HoVvPNnwHHJv4C4Ud4lGpUJ0ZUvQvsM7Rp
         dtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pi25n1EAlvSEER0ah3U6jnVTn7VB61a/OjzWNsBxJ5g=;
        b=bSdK4MqsAiXv4xh+KWjYuwIyz6lv1LhYUJmm1kwZtdJxtwoPZZkn3XnWdYXau9TDqb
         Jo/JRqz9O6p/sSB/LjaGrjNe19uq/5SgxQxRHJt/t4A6NA2zxdrxaPE04cBZA5G27Ohz
         yRFMfCyBihhzpAuCTh5zIGsxVPE35Xb6UAstfZNj9t8TR8jvKYCar9X70j7DlSV1q6Sg
         yED1YzqZ4MOI1q5W2TslkayF97OSOlA/bGdOeyE+IXSsV5D6gEK4e6/ZkRbOppQjUUiI
         3hss9vRutSTIF5b5BJgjfD8dMC0KqnHcK1OIV+XVUp98jxGCwEW5ySLuwk5k/tiDHGrT
         qvMg==
X-Gm-Message-State: APt69E1xjR22/NLjIblE8Nr07Njyo2lZ378AajvPj8DGNdVCxbTOtXg4
        vchlp1wxJJeAL56BjbxMluKyUv46zBW4QjKLHwk=
X-Google-Smtp-Source: AAOMgpcKPVsXyUSBcP3EDemi/M2Vn3KRgc+Amv3xl2DxCaZ8prWQpSb+cBHNnVRryjHCsMH5AnD+W1VIlHZGnEY3Z5g=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr18309009ual.28.1530641219219;
 Tue, 03 Jul 2018 11:06:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 11:06:58 -0700 (PDT)
In-Reply-To: <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com> <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 21:06:58 +0300
Message-ID: <CAHp75VcZjViSE7rxWALgvL20cLYq4si2XWU19UfoewXYiBcstQ@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:01 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 03/07/18 11:36 AM, Andy Shevchenko wrote:
>>> This is now in linux-next as commit 46e4bf08f6388 and it breaks
>>> booting imx6 (32-bit ARM):

>>> Any ideas on how to fix this issue?
>>
>> Oops, first of all the header should be hi-lo instead of lo-hi.
>> Does it fix it?
>>
>> Otherwise I didn't (briefly) see what can be the issue.
>
> I had to dig to find this: but Horia had said[1] that the HW was
> specified to use lo-hi and I think we ended up changing to that for this
> commit based on his feedback. This is also mentioned in the commit message.

Apparently I missed that part of the discussion.

> Besides that, it looks like we are hitting an undefined instruction. So
> my best guess is that we are somehow now calling a proper 64bit read
> when we should be calling two 32-bit reads.

Which is a bit strange. For arm we have been using generic
definitions. Only very few architectures use own defined macros.

>
> Fabio, can you send your configuration?
>
> Thanks,
>
> Logan
>
> [1]
> http://lkml.kernel.org/r/VI1PR0401MB259145C2DFDB5E4084EA5DFC98D20@VI1PR0401MB2591.eurprd04.prod.outlook.com
>
>



-- 
With Best Regards,
Andy Shevchenko
