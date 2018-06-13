Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7EC67C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BEB20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtmJnDjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BEB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936024AbeFMQBo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:01:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42847 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935697AbeFMQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:01:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id w7-v6so1646193pfn.9;
        Wed, 13 Jun 2018 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UplNA1aK0Elz33EWQ9w/0AecY/TuSBQIq3FqQgV78YI=;
        b=jtmJnDjQmMfhGJz7tb2K4zBVGa/7ZBYDQRAIzKynYDksvqDUM1ohXLA3lqFJIbL03P
         zbg4JkC7JC5wrrlejZgwUtsBK0V6rRX/2o03wDxZ8zOmQ524MjDlU6VPsEck2vV9TyT8
         mknHJ8JFzh49H3hoMinjSc1Hk8ssoG7UoUOBLGVee/6mGhJjgFCaaTly6ZT+fKnF+SJy
         kdwh3b4VeD7alF3LDFiIJhxeMfHOM3Ymc7P93qAKsu2h31mW2i7sQh2moBE2EiG+GiRX
         oiDYnSSnjru65xbgnyRo0CfiY2yxsBbwlU6UlPDSOvZ+xhH1SeI+M++Z2fvbK3no66Ox
         bgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UplNA1aK0Elz33EWQ9w/0AecY/TuSBQIq3FqQgV78YI=;
        b=TCrAj/tW6c9QqdvhRn9WMDqIl9XFaJvntkn+otR9l6iUCb31ydYrL6GQavNWMpYDvR
         xx8Ts/DElIKv9WXjjbxywHjMPo2yiFKcsTtu3iEjtC4etRfXkULguohjdWVDd21Zwuyb
         WI9uykyMt6LcxbTV87l1LdSSrdKLBUvNnxZ7+AerTtaXK+57BcYz2g7qxAy1LbhIO99B
         NVHp/Cxco6p/IxJmwojos7L0d8t/kzaj2+4EA4JMN3UvJY1OcezNkE71SR9oudj+5ycS
         Wk/CzQPVVd4EnNMb+QcKGHc4TVHK3NKicSuTvI4hw5abi+Y6j786Xtmp59/wlESQ54b6
         H4KQ==
X-Gm-Message-State: APt69E1c1IfLXT4PgnXab/tWfobV1OY8Ou0ERffOKWB8UNXMDS5VyN+F
        tNSzSORT2UBPDnWWm2fEeg==
X-Google-Smtp-Source: ADUXVKICBopij0ZKpHQmSr9IK4F6Cwn8i1rqYh7ut3SB3osSFDSj1o4fs04rdsS2uGvS63OTlxyDNQ==
X-Received: by 2002:a65:6517:: with SMTP id x23-v6mr4658609pgv.268.1528905701085;
        Wed, 13 Jun 2018 09:01:41 -0700 (PDT)
Received: from arch (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.gmail.com with ESMTPSA id i7-v6sm10904701pfa.34.2018.06.13.09.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 09:01:40 -0700 (PDT)
Date:   Wed, 13 Jun 2018 17:01:29 +0100
From:   Craig Tatlor <ctatlor97@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
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
Subject: Re: [PATCH v5 1/4] fixp-arith: add a linear interpolation function
Message-ID: <20180613160129.GC10090@arch>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
 <CACRpkdaKMr0qm91Q4LyjBGyKG_H4vvMr7bnRJeai+f2Eg-9r0Q@mail.gmail.com>
 <CACRpkdb-GeOUSPQeJoMe-My-ZugdPWn0DDVQST5e7XFzt1TmHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb-GeOUSPQeJoMe-My-ZugdPWn0DDVQST5e7XFzt1TmHw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 01:12:45PM +0200, Linus Walleij wrote:
> On Wed, Jun 13, 2018 at 1:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Thu, Jun 7, 2018 at 8:12 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:
> >
> >> Adds a function to interpolate against two points,
> >> this is carried arount as a helper function by tons of drivers.
> >>
> >> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> >
> > The linear formula seems to fit the most natural form of linear
> > interpolation.
> >
> > I bet some John Carmack algorithm type people will soon
> > start to optimize this... :D
> 
> For your entertainment here is some sunday reading:
> https://fgiesen.wordpress.com/2012/08/15/linear-interpolation-past-present-and-future/
> 
> Yours,
> Linus Walleij

Thanks, interesting read.
