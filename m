Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A182145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A182145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeLCJtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:49:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35589 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:49:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so10158677edx.2;
        Mon, 03 Dec 2018 01:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMmI4PWI3/oxD5mPfhnmHTJzwbj8cjFnmjKPIvkUVWg=;
        b=oagIt3rRrJHi6zXSWLjIgDYNIoskpoAuN9HLfm0EEFHiHYIhbjuqtU+j49y5coBADI
         gqErwPR/IBsiqE7k0fjCtAZdaOGyotUMnW6dbGU8UVZWkeLtBVlNyaWYtsAWMRBCnl6d
         SJR7dyoyUsKsYU57MP9/2smbz1t+Ha8CprYleIGFk1pZA1NFxgCwXQGKiTIBzsmrIQfT
         nvyA3AmpRZuFOu8rkIpVD/Qp4XPu8FRfUaTSAlIfwZ3rIHrNDQ872H8wl8s9p8fIZ9bp
         xu2J0ai4W/J+Pc7NnfhUNlrIL0KK+N9jZPGUqP4NhT83jdRb0BGvfWL0BNYBm+Tc/f35
         ir1A==
X-Gm-Message-State: AA+aEWb4ko6hs9YagpiB4yLEJSxZXZw7G/JdanCpFSSaFonFFjRDBZ1x
        WzGFEbsllrkIWrcbPFs6eJjxlKQmRU4=
X-Google-Smtp-Source: AFSGD/Uw7u3riOy34HshdDSX/Bf7uZp9mQmna07lrkaGveOYHHdeClNoEdy5KrmNCEmq8Dac4dwung==
X-Received: by 2002:a17:906:e2c9:: with SMTP id gr9-v6mr12534540ejb.108.1543830525280;
        Mon, 03 Dec 2018 01:48:45 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id r8-v6sm2103289ejb.52.2018.12.03.01.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 01:48:45 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id r10so11364479wrs.10;
        Mon, 03 Dec 2018 01:48:44 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr12714638wrv.87.1543830524486;
 Mon, 03 Dec 2018 01:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org> <20181130075849.16941-2-wens@csie.org>
 <CAMty3ZC-4hnVOx9AYhm7uUCUHF=n_NoH3xV-3SyUXWxb_X8TGg@mail.gmail.com>
In-Reply-To: <CAMty3ZC-4hnVOx9AYhm7uUCUHF=n_NoH3xV-3SyUXWxb_X8TGg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 3 Dec 2018 17:48:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v67xoqV+QuVxDyBrUzzpab9vsbJRQBFPA0OS=h_bZ2H7Tw@mail.gmail.com>
Message-ID: <CAGb2v67xoqV+QuVxDyBrUzzpab9vsbJRQBFPA0OS=h_bZ2H7Tw@mail.gmail.com>
Subject: Re: [PATCH 1/6] media: dt-bindings: media: sun6i: Separate H3
 compatible from A31
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:42 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > The CSI controller found on the H3 (and H5) is a reduced version of the
> > one found on the A31. It only has 1 channel, instead of 4 channels for
> > time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> > "fallback" to a compatible that implements more features than it
> > supports.
> >
> > Split out the H3 compatible as a separate entry, with no fallback.
> >
> > Fixes: b7eadaa3a02a ("media: dt-bindings: media: sun6i: Add A31 and H3
> >                       compatibles")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> "media" text appear two times on commit head.

Just following what previous commits did. :)

> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

BTW, I know you've been trying to get CSI to work on the A64.
I have it working for the Bananapi-M64. The CSI SCLK needs to
be lowered to 300 MHz or the image gets corrupted.

ChenYu
