Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB997C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EDD217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtfS6bzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfAWAaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:30:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43574 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfAWAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:30:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so216197pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bZHGW9UIzeo3jg9G6hlmccfpVJD3jkJYVrWsAWmLXGQ=;
        b=AtfS6bzNoQsWyIrV6i2nu48uWdnxzUqo77EaEHA7uqbmBF6UK9fNZgstbvSSBVv5Uc
         pgDefYjymoAVvpR7E3ZtQEj7xj9A+gZ3qH6rdWWoiGlw+9h8Ft7CPNu6gb33DOZANfi6
         BRj39FZSP385NhXy4GBibqQ8I46SBhm6sKZXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZHGW9UIzeo3jg9G6hlmccfpVJD3jkJYVrWsAWmLXGQ=;
        b=Ny3cdIKQaHJYweEtJOvQv/n4cnK31zsvslCGf/XSOfOwGMwStzBXQKfoErMkm5cx/+
         TS2+TT3e6CAyT0nQ4txBlr6dvz3eJ3koLf33LVnrm06mMOlBTt9rmc0hFHobesjCcyrx
         4lkfL5lzkewlweox18YemnMPLwvjvgg5LIONNyUHpPYq/5vVgf1aRK0hQefDani1Uxvm
         XR/2/4Jbs+H+jiJOxIaziLzboo8gLjKEkArZUrpJIYwVFdF/1dzA85aHUU+MPTirVqZ3
         y0U3H1HZyTxQuY0Zsc9Bkktt306s1Wx15OMcnRtRNG4eyyZIUZKjtC9rwCv9mSe14+4/
         j4SA==
X-Gm-Message-State: AJcUukcTbjKDyzinIRD0b7b7hvlzlxvutArXk6bP2zJOx1FFO5kxwQMx
        AfxsqEW+2ucdrztgq2uVH7cmVg==
X-Google-Smtp-Source: ALg8bN5ZTjrRVW/4/YKDlaumhB/VkjtzeMiCyE4Zw1B6paCHrsYzLOx11b5zUDX1tc4poCX6r+I7XA==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr90139pfm.71.1548203444718;
        Tue, 22 Jan 2019 16:30:44 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 15sm28538874pfr.55.2019.01.22.16.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 16:30:43 -0800 (PST)
Date:   Tue, 22 Jan 2019 16:30:41 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/10] arm64: dts: qcom: sdm845: Update PIL region
 memory map
Message-ID: <20190123003041.GF31919@minitux>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-2-bjorn.andersson@linaro.org>
 <154818353130.20280.17905705223316470797@swboyd.mtv.corp.google.com>
 <20190122192404.GB31919@minitux>
 <CAD=FV=UgQtPZj-EWCzqGqgAbfijjd+j7kO8XsXttJKfejEzBzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UgQtPZj-EWCzqGqgAbfijjd+j7kO8XsXttJKfejEzBzg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jan 15:10 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Tue, Jan 22, 2019 at 11:24 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Tue 22 Jan 10:58 PST 2019, Stephen Boyd wrote:
> >
> > > Quoting Bjorn Andersson (2019-01-21 21:51:03)
> > > > @@ -103,10 +138,30 @@
> > > >                         no-map;
> > > >                 };
> > > >
> > > > +               venus_mem: memory@95800000 {
> > > > +                       reg = <0 0x95800000 0 0x500000>;
> > > > +                       no-map;
> > > > +               };
> > > > +
> > > > +               cdsp_mem: memory@95d00000 {
> > > > +                       reg = <0 0x95d00000 0 0x800000>;
> > > > +                       no-map;
> > > > +               };
> > > > +
> > > >                 mba_region: memory@96500000 {
> > > >                         reg = <0 0x96500000 0 0x200000>;
> > > >                         no-map;
> > > >                 };
> > > > +
> > > > +               slpi_mem: memory@96700000 {
> > > > +                       reg = <0 0x96700000 0 0x1400000>;
> > > > +                       no-map;
> > > > +               };
> > > > +
> > > > +               spss_mem: memory@97b00000 {
> > > > +                       reg = <0 0x97b00000 0 0x100000>;
> > > > +                       no-map;
> > > > +               };
> > > >         };
> > > >
> > >
> > > What's the plan if certain configurations don't use all these carveouts?
> > > Can we mark the reservation nodes as status = "disabled", or the reverse
> > > and mark them as status = "ok" in all boards, and then reclaim the
> > > memory for peripherals we don't care to use?
> > >
> >
> > The code path that picks these up does look for "status", so I suggest
> > that we leave them all enabled in the platform dtsi and then let the
> > device's reclaim them as needed.
> 
> Does that mean we should add labels for all of the sub-nodes so that
> boards can easily mark them "disabled"?
> 

That sounds reasonable, I'll dig up some labels for the unlabeled nodes
as well.

Thanks,
Bjorn
