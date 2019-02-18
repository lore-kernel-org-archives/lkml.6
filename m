Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC25C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6445217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlPaoM/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfBRROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:14:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41850 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbfBRROL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:14:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id t7so13085984otk.8;
        Mon, 18 Feb 2019 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9Ju8o7UI0AE5oEO08Wi6g50YqLMKlVnM2Sf/QzK7J0=;
        b=XlPaoM/yy+gaPvXUQlf6IVhNEhO4cWMtw9PNgcOtK5VapyrujCJK4FOLkoMVamEFhV
         Mwe9FKkHAGW2iZGhwGpq6I56RkEU4SqNMGlTvOVcSIh4ivP+lpG8EtwaLTYNYGsq9VHy
         7glXivZuZoFubR8VZ5a7TaL/KSTrpVfxFk2NZOZ3arNqziF5UVfcy6w3Nbnv5VPoBieJ
         v+WLD1XKGZ/z8PwGf6R0GOQAROBeY6Cu0trwEp0bRJiDAkItF4k3KQI26w08dFsH8BcX
         vs03CmgyN9zf3f2b/lXLPLXELrjcr+vAScslA28gSSy1cX+dFlObPokLv6/ITCRRBcT4
         kuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9Ju8o7UI0AE5oEO08Wi6g50YqLMKlVnM2Sf/QzK7J0=;
        b=Bv1azvVBiCuKPHLHLAhn6xCMh34k7Uoq6HGU5FWjiT/HTodmqSZstr9kAPvs+vz0tq
         MSJ6bk0gU506G6eXffMPB1pLhGomuOcNNSos5VypuZ5J9MnDOPwAS/SBZK97x3N+1y8r
         JIEsw7Dyc3+11hXHK0iLMJ1TLlNDiqFB+M1PdXs3HAFNcD2xKZi5Z8DXVVKoUR2EXMQO
         iyhChAIda7+NAfJyB+utharmSqMNqprhXBbS6hwqfwYqOR4CuLO6qhqV5O6Bfj+Wx2o0
         OkYkl2Q7mpoe6XOOo5vrT+aclmDKbaVEJNZVeeNJ+sBSeSuC4jXKNk7aFVxhvYWXhmbX
         hffA==
X-Gm-Message-State: AHQUAuYbhl66iX5gFgk49FICwO0YaC5pIekE9VihQ3QsRLXA+1ScNubT
        dxZWAMjjNWDaEjL+SbIfPtf9Z/Dp6vNy48AR2z4=
X-Google-Smtp-Source: AHgI3IYiqorHvlu0UFdovwaDJepUFtIFyU0xQLLdv8hhpT7WH6kAgAQBbl4JMYoHtfMXXpJ+mmgWBZNUvhxGG/Eyadc=
X-Received: by 2002:a05:6808:693:: with SMTP id k19mr14234489oig.77.1550510050977;
 Mon, 18 Feb 2019 09:14:10 -0800 (PST)
MIME-Version: 1.0
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
 <CAGngYiXPsj-TAZxC43UtAZYTkbztFtDB-z4jW29CthmaoeNy_w@mail.gmail.com>
 <20190213021753.GA19621@bobby.localdomain> <CAGngYiUvEpSgESzFGJOtYjLi+_xmZ18GwiSTxaaMjEmjk2pu4Q@mail.gmail.com>
 <20190218152224.00007920@huawei.com>
In-Reply-To: <20190218152224.00007920@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 18 Feb 2019 12:13:59 -0500
Message-ID: <CAGngYiXz=o6m41wsETbt7i9c6Ut=GsW2Kvf8cwhqSQnO6Jg4zA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

First of all, thank you so much for taking the time for such a detailed
reply !

On Mon, Feb 18, 2019 at 10:22 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
>
> So, what I'm reading above is worrying.   The interrupt is cleared
> by the read of the data registers?  I thought the datasheet allowed
> for an explicit clear?
>

I don't think there's any need to worry. The part allows us to choose between
clear-on-read, and explicit clear. Bobby's approach is fundamentally sound.

IMHO most of my suggestions were based on an incomplete understanding of
a) the interrupt in the device, and b) the event guarantees in iio.

I will respond to your larger reply properly soon.
