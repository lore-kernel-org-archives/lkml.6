Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C089BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878AF2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218182;
	bh=H2+MumtGZP9D/c/gCgyobZB/B5bqmZ2Z8Nz/mVhAcsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EG6irl55OWBUK1WzyAjzpDPWqknA29Tkzwpi7UGlOD3s+DZvDmDes6/XOLKeGfbEI
	 G7Wq+qlG4gFpI3br5GUgdOCXesFZhtRx+1CSxhpB84ozME3qythjWaTno90HmLyglR
	 /LPUvVNqkl188ridpWoqt9UUft3FBjzoKN328Vus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391631AbfAKOtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:49:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40339 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391608AbfAKOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:49:33 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so13285026oth.7;
        Fri, 11 Jan 2019 06:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SkSuY7KYrBpDBLfeRoZ7d0Kp310+i18pSDvVIWDGic8=;
        b=SOvKhqEfnbPgzz5Ie38H20mKXp19P/8ZlYfhaR74MhrI33jBuRQ8/mUb3kjaZbByEL
         XDTMz24xFvFTWkJ24daX/fXAACz/s9lrrWV/mgU4cscQvepqitc+1/v54rHaU7nqoG+9
         QdoBw06Q+L1hDQbNRjb0W3rY2A61ZjyCWoJ/y5J3O+fLGmKjHkFPrSXTrR4Tj62DnUVy
         yg8SSqfUw9YDFo8GO37/81FPPz2wlCV1IuZiEsGEjn/bMm+1FBeYyx5H0WCEOSRPlO3Y
         WXn30XORv7tcKejcDduojcWF2RAkvq5VGXeoRzWP0K3jHkIOhO9zGeNEb0lC0tA66AdB
         6r0w==
X-Gm-Message-State: AJcUukfmCJBrY8uw0rbqcweulUATjm9yiCZ8nwBFMvZlQzEkOYkbnR/q
        95NaHwTFoAelDyCaswEx1Q==
X-Google-Smtp-Source: ALg8bN50tT2iwFNdKETVqqqi+TUoM+Yi5iI3WMUE0nIETEzHmLC93g0F+m6SB1V5R4My/fCmqkMnfg==
X-Received: by 2002:a9d:468:: with SMTP id 95mr9653190otc.312.1547218171901;
        Fri, 11 Jan 2019 06:49:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s17sm34622800otp.36.2019.01.11.06.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:49:31 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:49:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: display: bridge: thc63lvdm83d: use
  standard powerdown-gpios
Message-ID: <20190111144930.GA15806@bogus>
References: <20181229070649.21308-1-peda@axentia.se>
 <20181229070649.21308-4-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229070649.21308-4-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018 07:07:31 +0000, Peter Rosin wrote:
> The name powerdown-gpios is the standard property name for the
> functionality covered by the previous pwdn-gpios name. This rename
> should be safe to do since the linux driver supporting the binding
> (lvds-encoder.c) never implemented the property, and no dts file
> names it. At least not upstream.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
