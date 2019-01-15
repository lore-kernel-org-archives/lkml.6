Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E6FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B784205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547584193;
	bh=FraSvuqjoacjkEWCU2432P55qsIC2owhKSz+U6h5yMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CbkKMQf/6nNiGvQ95lAm2nDSsggwRTetvAANPRFVWoa3P3MTOIcgvZb9Oy/TR2kqH
	 Njj8VTVg8gZ61lxTg5kvj0WwDwSHq0Y0bWsZl1HrLXoYlGd9IYvkBLHX6OrvDgcYiz
	 SJ/ZOPQlqXyIE57bGhMCpIsXLiiisb0VDkzJ3wiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389862AbfAOU3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:29:51 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35254 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbfAOU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:29:51 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so3807968otj.2;
        Tue, 15 Jan 2019 12:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tCnBLY7pDOHeTztGfTnF5wrOSDSeTsb5tU2+EjofhJk=;
        b=hhp1r9AGFKFVt/T5YekmklD+/fY33PRv8IW+CG16oT9O8gQvBKBGCy53fYxBbXuWzb
         aFrvEfogOK2PGanEbhy8O9AdwyY9XukrKcRgA4Oe3j3Ss59Jmovgn8o62U5GWioPD+CM
         xXOyy5wt9DXK87KIBvewvcc1gB2EZGCQks1hZLa5ykNLdzUVTT8i7Oewr6wt3eHMgezx
         ROGaaM0P47ZmsOqxWAL65ybIr9uo4Sksqwxfbvk3EE3flzMQmOzkgUaDH6MBB6zZ/Dty
         RIX+4oha93YqXcnSbNM4AzJ9Moko9tM5GUQKjQGAix5bykg3Z9mJAaGPOpCQn6NgP8vE
         OV9A==
X-Gm-Message-State: AJcUukcEEKWEzbCVGJjvcPvjyZw+z/6pAJARAE/crkzPWkFhJao2A7oM
        ldR4MbfOdnkmICNht4cfcw==
X-Google-Smtp-Source: ALg8bN7fql/qJmCgN90YnJrAuiJTj+1MtL663JfMYlWIl0XcyAxBdrJZypf8XiUIXJn0RI2TeE1RZA==
X-Received: by 2002:a9d:2963:: with SMTP id d90mr3625345otb.286.1547584190263;
        Tue, 15 Jan 2019 12:29:50 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id r1sm1848442oie.44.2019.01.15.12.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:29:49 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:29:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Donghoon Han <nazgul33@gmail.com>, linux-input@vger.kernel.org,
        Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 2/2] Input: rotaty-encoder - Add DT binding document
Message-ID: <20190115202948.GA26482@bogus>
References: <20190107164249.2342-1-nazgul33@gmail.com>
 <20190107164249.2342-3-nazgul33@gmail.com>
 <20190115035221.GA151157@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115035221.GA151157@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 07:52:21PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 08, 2019 at 01:42:49AM +0900, Donghoon Han wrote:
> > Add DT binding document for rotary-encoder, keycode options.
> > 
> > Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Daniel Mack <daniel@caiaq.de>
> > Cc: devicetree@vger.kernel.org
> > To: linux-input@vger.kernel.org
> > ---
> >  .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > index f99fe5cdeaec..9986ec2af2d4 100644
> > --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > @@ -12,6 +12,10 @@ Optional properties:
> >  - rotary-encoder,relative-axis: register a relative axis rather than an
> >    absolute one. Relative axis will only generate +1/-1 events on the input
> >    device, hence no steps need to be passed.
> > +- rotary-encoder,relative-keys : generate pair of key events. This setting
> > +  behaves just like relative-axis, generating key events instead.
> > +  (Keycodes[2] corresponds to -1/1 events.)
> > +- rotary-encoder,relative-keycodes : keycodes for relative-keys
> 
> Given that keycodes are linux-specific, I think the property should be
> linux,keycodes. Also, I am not sure we need separate
> rotary-encoder,relative-keys property as we can infer that we want to
> generate keys from presence of linux,keycodes property.
> 
> Rob, any comments?

Yes, I had similar thoughts.
