Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF1DC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5C62089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMRhZXc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfAUR7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:59:22 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51544 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAUR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:59:22 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so17608426ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GIkKZS9024nvngV6e2KIorYK3XJmAI8zh9FUlk87wCM=;
        b=WMRhZXc0UjFFWdsPF5yVyvY4vVSav9F0z0zPtSiW7IOPv9kh5948WERCDs5DGh3hMk
         lm1Labs/Qzygsebmyx+r5zGHAfVxPKJQv7rPRLbDKlvdtl7Sy/xUwFJF9C6M2ePKqBFn
         6aDTC8AZztniu4pmAMtevm9JLMXa+7Aq30OX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GIkKZS9024nvngV6e2KIorYK3XJmAI8zh9FUlk87wCM=;
        b=MSx2hRp9/03JJtQyNp29xC0waN5WzAbd0Pix045sXKDH9fk2VjmsMMfkoU0SSh8dX+
         k7VDqe713yxv8w9/MX8GrWTD1iNlq/QnOUq1kD2JWMM2H4ISqTxic1EV6KEyue8lpL9q
         Ye1yNN+1BNCEUcVOd1wwL5TudI9BUh0cMjv1zjMZanZ6meIRKwjxcItwsR3gnrnRHj3+
         SzfKnWvkCJV0SYxao/LZwywRRdhYIui9ZMUfLfyqWiMtnCaRvHbFjZbWQK/kPg6Aw5vV
         SSfhePTAL1vniR09N/AwFiXVnyY/dR6kXSP+IA7uQxgahwhqtl8qtBoKigFPYZrd6+8q
         oxgg==
X-Gm-Message-State: AJcUukdXcxHZ24wG6RoXnjnyzLnVYOUCxKi/oT4zNYlfYbdHvXkH9qpU
        3xv3v5YcN+MP3QKJb0Gmn0i6d2k1fVBg8Sytjlf0xw==
X-Google-Smtp-Source: ALg8bN5/MqM7BpuFo7CWNk6ZT0kxRzlT1oWjjnVQX37laAUT7VGktD1Giho0GQi7FYskMQsT0Kk2rKQ0kQG7DqZhdI0=
X-Received: by 2002:a24:710:: with SMTP id f16mr220842itf.121.1548093561061;
 Mon, 21 Jan 2019 09:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org> <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
In-Reply-To: <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 18:59:10 +0100
Message-ID: <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        David Zhou <David1.Zhou@amd.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Michel Daenzer <michel.daenzer@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 18:55, Michel D=C3=A4nzer <michel@daenzer.net> wrote=
:
>
> On 2019-01-21 5:30 p.m., Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.org> wro=
te:
> >
> >> Until that happens we should just change the driver ifdefs to default
> >> the hacks to off and only enable them on setups where we 100%
> >> positively know that they actually work.  And document that fact
> >> in big fat comments.
> >
> > Well, as I mentioned in my commit log as well, if we default to off
> > unless CONFIG_X86, we may break working setups on MIPS and Power where
> > the device is in fact non-cache coherent, and relies on this
> > 'optimization' to get things working.
>
> FWIW, the amdgpu driver doesn't rely on non-snooped transfers for
> correct basic operation (the scenario Christian brought up is a very
> specialized use-case), so that shouldn't be an issue.
>

The point is that this is only true for x86.

On other architectures, the use of non-cached mappings on the CPU side
means that you /do/ rely on non-snooped transfers, since if those
transfers turn out not to snoop inadvertently, the accesses are
incoherent with the CPU's view of memory.
