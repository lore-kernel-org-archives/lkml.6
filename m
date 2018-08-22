Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576392146F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6vxcsYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576392146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeHVIgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 04:36:33 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40365 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeHVIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 04:36:33 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so361537plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 22:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6O6laEgO6T25d+zfJpmPUFYjoUP6jT5KG0myq7REs7g=;
        b=D6vxcsYoNIRM+Ao9tWGTud8xEO4j7E+CdRHu052tHd+xNm4kTsNfCzKBYNaKE1i/T6
         vhhspQnVPIeyS+oQ/tFjwJ3gKJEzZciTLzg2GOiW+vi8scm35sVGdkCGzNAnDVu+RKot
         NsdNDDkTLxlMEXoMS19wCQ7kGaO2J/aDrebNzkGEGyl9crOpprIpZtFWit9TG7oB6T6S
         Um9GzNHa+CXq9MD6pK000saDBYo5Tirz4PH3WKNwp0B1IFT8hu2pahgSARXa+zZWVpUv
         mfklT6kg+aenBr+/s2XzxdZFmzKltTr1JxzbtETMy4OQ2N4HLn7J4v9fFzd6F4AQS4cR
         r5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6O6laEgO6T25d+zfJpmPUFYjoUP6jT5KG0myq7REs7g=;
        b=K94Smij3HijZrw3FCKEFil6yCYrv1avfgKFR0WD0lEbR2Z6tCJ5PPR8XgOth2fmB6K
         AVJYj2ILp9yzRaE7HSuzKsBtv5EooQ7SZ8hacRGLA2UBrkKPgU8TwEkr+7GsMx0tUOI5
         ZbfIH/+KFJoI/ZkDCelz6JA1TE2SGZEmHqS4T9JAqi8d6r3Scf4CN7iNW7X26T29bK/d
         HFOHbLKmgDqtk1RqprKVi1qUEaaS5OZUoqQqe4gifuC2VL7iG2mGDauUQ3+xnjjt6tqU
         QxIn1PcGbossmU0NTzhjgM9YoN0LPvR9rcn39Q2AlD0Buc46p+NaK2QPDsSS2Pqei4MI
         pCpg==
X-Gm-Message-State: AOUpUlHQVEHbzpK2MA9Z1YLJXHZytQmZiVXb3n6JUFWwVaZsmrQ++0D3
        kxTFCZuSjMf4pLwkQC42cZk=
X-Google-Smtp-Source: AA+uWPyDKnZ3F3EpzVzjN6x+MjY23PJh6uFMq4KyqNffpdvRKKJdmp+PUP40LblY4e/OezFb+ktG9A==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr51565744plb.99.1534914799023;
        Tue, 21 Aug 2018 22:13:19 -0700 (PDT)
Received: from localhost ([175.223.33.48])
        by smtp.gmail.com with ESMTPSA id g4-v6sm670476pgl.47.2018.08.21.22.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 22:13:17 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:13:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
Message-ID: <20180822051314.GB6876@jagdpanzerIV>
References: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
 <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
 <20180821095055.GA400@jagdpanzerIV>
 <4bef099f-b2e1-0327-271d-75662b366c07@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bef099f-b2e1-0327-271d-75662b366c07@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (08/21/18 14:43), Rasmus Villemoes wrote:
> > I think that sysfs input is always properly NULL-terminated. It may or
> > may not contain \n, but \0 is expected to be there.
> 
> Maybe. But it shouldn't hurt to make it accept a src size (the caller
> can always pass -1 is he's sure the input is nul-terminated) - I'm
> thinking a new interface might also have uses outside sysfs.

Makes sense.

> > E.g.
> > 	channel_dimm_label_store()
> > 	dimmdev_label_store()
> > 	pmbus_add_label()
> > 	axp20x_store_attr()
> > 	cmdline_store()
> 
> Hm, do any of those actually want the skipping of leading whitespace?

Hm, that's a good question. I'd probably say "mostly yes". The input
usually goes to strcmp/strcpy/strtol/etc. But we don't have to trim
leading whitespaces and can just let the driver error out [hopefully
the driver has a well tested error-out path].

> pmbus_add_label doesn't even seem to kill a trailing newline?

Sorry, I think pmbus_add_label() made it to the list by mistake. It doesn't
appear to be a ->store() callback.

> It's probably hard to create one interface that will work for all cases.

Agreed, that's why I targeted sysfs input data only ;)

> Dunno, looking at your examples above I'm a bit more skeptical that
> there is a lot of common ground. But of course there are hundreds of
> other store callbacks, so surely one can simplify some with a new helper.

Yep.

	-ss
