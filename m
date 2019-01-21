Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39CEC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD10E20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548087177;
	bh=h6dKq0tGJ/aO3g1QcEsyhn55UZB7OLD0Wdk8buu4F5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fYkTIRTQu++xLby0H84dnKYKpv5fwcSw3N5AxCvlHl8TS5ne/ExzxC1z4+RW1/1Oq
	 sGHzhO5epPY8c+Y25FHOVgnTjPBWbtUDQUThMerGMXT/67g7lHtqJO1P03IfwSFwBq
	 cMDQioyPn7bAbK3dNVzb/gl9JJCWJiys4BDE8u9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfAUQM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfAUQMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:12:55 -0500
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B9B217D4;
        Mon, 21 Jan 2019 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548087174;
        bh=h6dKq0tGJ/aO3g1QcEsyhn55UZB7OLD0Wdk8buu4F5w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YmZz0+K3Wlr0YZo0c+gc7KlJGx4xEFsRjx5/DnuvAAP0rF38wjqVzJufQ75EwijHn
         g3yz2ZdZWQhZ1hDTbUtHer8NhOYUA+70jd1HhPBQCFVnA0drRnO3UaugNDeXnaU3Dj
         ZoebhRSuSGHO7Y5IgmmAg1p1byX/Eiew5ZYhWmys=
Received: by mail-yw1-f48.google.com with SMTP id g75so8238885ywb.1;
        Mon, 21 Jan 2019 08:12:54 -0800 (PST)
X-Gm-Message-State: AJcUukdv08znk375i79Rd90rXKxtdILhcpOEPXFRqwIwJowfH+oFRcHw
        I3fgR4bPLJ4+/CrxZy7ALjlQpNgZRsME8ZK+WA==
X-Google-Smtp-Source: ALg8bN6GoeOGmdKZ6ggf1HGHVChgJb1ZQO+c5LNC9LZtKIv05GCMG+EcQ7N2FTx371b3598ryr5EZmu0zYLmZhtqPAA=
X-Received: by 2002:a81:ad64:: with SMTP id l36mr29310125ywk.114.1548087173909;
 Mon, 21 Jan 2019 08:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20190109164343.164205-1-tmaimon77@gmail.com> <20190109164343.164205-2-tmaimon77@gmail.com>
 <CACPK8XebHzVAO2TX25N24S0Pgg_0xA=7GN3j0oXhSyD4LmL4=w@mail.gmail.com>
 <CAP6Zq1j=oPdVXZKBteBcaLVZcvoU7M6YbfGhSCaC44Ld9AQ9Ag@mail.gmail.com> <CACPK8XfFRigW9pN4JLrH+KcE6ACJUzX0qJV8xeph_DkfKWgBEQ@mail.gmail.com>
In-Reply-To: <CACPK8XfFRigW9pN4JLrH+KcE6ACJUzX0qJV8xeph_DkfKWgBEQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Jan 2019 10:12:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLn3wCpAWDTQFsrvuPJqWurTDNcu=j988PpHWtuW4Po6w@mail.gmail.com>
Message-ID: <CAL_JsqLn3wCpAWDTQFsrvuPJqWurTDNcu=j988PpHWtuW4Po6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-binding: iio: add NPCM ADC documentation
To:     Joel Stanley <joel@jms.id.au>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 7:48 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Sat, 19 Jan 2019 at 02:12, Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Hi Joel,
> >
> > Thanks for bringing this to my attention,
> >
> > I think I will leave it the same way it is now because I will like to develop the reset driver and to handle the NPCM7xx SOC resets.
>
> You could also do that.
>
> But I was suggesting you use a phandle, so you could then find the
> node you want without searching the entire device tree for the node
> with the correct compatible.

That's not really any more efficient. You just search the entire tree
for the matching phandle number instead. Well, that was true until we
recently added the phandle cache.

In any case, it you plan to move to the reset binding (which would be
good), then it's better to have nothing in the DT and add something
rather than change the DT binding.

Rob
