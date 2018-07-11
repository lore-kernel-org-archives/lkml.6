Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06939C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01C120C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lcfRTn7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01C120C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbeGKNuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:50:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44039 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388012AbeGKNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:50:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so18250007wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOFNr9EQACoofPpfltQqWBpn8tJTD9ODeJurkbREViQ=;
        b=lcfRTn7HoKvFaYlg1AIAAmjy+eg7jEmojHzf6YNakR/0n6dyCSdGd/7PMwQlKjv0dF
         t03uTd5ygSxCIfKl1kSuidXdRUvWnf0/3mWPviFzw/1W6DVx8jM5wHzs4XnVng4y7Xs2
         2oSJnwQqKl7XMBkiAfXkUfwkvvzHt5qYYW2EQgmmf8VghKnDZNFN+k/7IGAU7NIeyDrB
         MNbyZ7XXOtUaM/P9zMp/T4g447gpxuVf4gsuHvy9RmDOIt0VgGGVRGKyyULHclo1uRM5
         djDrzKtvuZCXn2UsYK9DTcx/W9KzKUnPYcZkYBG6W+2x9aA5KzSPGc1Shp//RgJELvub
         wE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOFNr9EQACoofPpfltQqWBpn8tJTD9ODeJurkbREViQ=;
        b=cFE+h6Ab0K9vonocipWGDPmZERilEzjKINOwnujmnpmIfgtJHx0IJu7RZXPZyqXQXy
         J6ARcEzPPPyJmmCsjhSAyBQJ2miT2wLiOfVMaM3SmkjlYkMqInmc5G3Z4NYlIsBeQI4b
         FN01HFXWmiUtS3neQCGpWpNwS8VLbDzrd+2mM+I+C8odZ7LBJY/OWos5El+GzWPf02XU
         mh74GHzIIngZxpo7gDhJLahhAlX1MXIBA6RnIqSnIFdhBqxX749K0mFzYLukCF3EhQ44
         ymD3x/lAYBmfEMYEeFQfbMZ4r88U569LNlzWecWfC3EIGyXRHKkhKq3JYtDa7+ma2Zqx
         3YEg==
X-Gm-Message-State: APt69E3hDA+p/qSvI5rCPh2ciL0gyvYat2S/jOcHFOHyGR8XAnYtwyeH
        4JBFxZtfc1pwMffcXkuY0cmQBA==
X-Google-Smtp-Source: AAOMgpe0njoLAgnKR7AYjNTHWr7iPMxy6HNl0o+f/hOKhWnj3Eo0fxYlaNeEps+ePl8LQHpIlbkr6A==
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr22745214wrr.227.1531316754062;
        Wed, 11 Jul 2018 06:45:54 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 185-v6sm3490195wmh.22.2018.07.11.06.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 06:45:53 -0700 (PDT)
Message-ID: <1531316752.2708.113.camel@baylibre.com>
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>, Yixun Lan <yixun.lan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        qianggui.song@amlogic.com, sboyd@kernel.org, khilman@baylibre.com,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        bo.yang@amlogic.com, qiufang.dai@amlogic.com,
        linux-arm-kernel@lists.infradead.org, carlo@caione.org,
        linux-amlogic@lists.infradead.org, sunny.luo@amlogic.com,
        linux-clk@vger.kernel.org, xingyu.chen@amlogic.com,
        Rob Herring <robh@kernel.org>
Date:   Wed, 11 Jul 2018 15:45:52 +0200
In-Reply-To: <454887b2-6d29-4fe9-ee34-400363671746@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
         <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
         <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
         <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
         <1531216472.2708.71.camel@baylibre.com>
         <454887b2-6d29-4fe9-ee34-400363671746@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 21:41 +0800, Jian Hu wrote:
> > > > > +static struct clk_regmap g12a_mpll0 = {
> > > > > +       .data = &(struct clk_regmap_gate_data){
> > > > > +               .offset = HHI_MPLL_CNTL1,
> > > > > +               .bit_idx = 31,
> > > > > +       },
> > > > > +       .hw.init = &(struct clk_init_data){
> > > > > +               .name = "mpll0",
> > > > > +               .ops = &clk_regmap_gate_ops,
> > > > > +               .parent_names = (const char *[]){ "mpll0_div" },
> > > > > +               .num_parents = 1,
> > > > > +               .flags = CLK_SET_RATE_PARENT,
> > > > > +       },
> > > > > +};
> > 
> > The previous had a predivider (1 or 2) in front of these mpll. Even if the
> > predivider is usually set to be a passthrough, it is better to model the tree
> > correctly.
> > 
> > Is this SoC any different ?
> > 
> 
> I am not sure the difference, I will confirm with IC design guys.

I suggest that you have a look at the (upstream) axg and gxbb clock driver for
this

Same goes for the fdiv gates.

Last, please trim your replies a bit. It will make easier to see what you are
replying to. 
