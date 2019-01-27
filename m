Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2F4C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B02F2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfRcgeV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfA0Npf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 08:45:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34809 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfA0Npe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 08:45:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id u89-v6so12031530lje.1;
        Sun, 27 Jan 2019 05:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gD0diEcJYXip57apvaI31OtlaTTImHgLdZy1DD0fwpM=;
        b=GfRcgeV66XLH7gF/BrpWDcyR3HqjeQtStrxMJFETE12MK+oReOX27IolkUzqtJvnoa
         XnVm+9ZzluuiOfnd2j4JBCRs/6XuwzeDmAfCUWKzCCLmW8tQHHzNVGMXmo80Z2ctXwyr
         xOy/tBYKJ1RGxEvZdPTDikVTRBn2zMSgxgwLdw0b0VF9Q5PEcp2IOI0s+1Z073675Wpk
         IGvCcTKU8Dpr3nUF5Ou3jduAsG5VXMsecKw4nxo+JvFmj1bvMKcgj08k7ZGS/eKQ2Nw3
         lbpQKIkIeFXi7MgJZMtHqA0kSVWTiKgDVMaeOq4CDCrznzzuOIurvAxCGJEP13e+JAZb
         3h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gD0diEcJYXip57apvaI31OtlaTTImHgLdZy1DD0fwpM=;
        b=tNE4XrJCQtET2+NS/VN80Hu/VhApH+F7LzZuTQiQRsDWw+A7GTcKJoUfiVKvkr+LHS
         zoAlGGKzgb/r+WESEVh5pE/ieTnIjhQCKhDHFiovjuyMfqHWP8tonklc6fAjRsKinVTa
         N3/9GfU2CjR7pUzRmUF1XHr7E1/d+mayZjZ+6MWttOQ0s6CTYvPYGaFtc8/exafMXen5
         NXTi3WRfzO6noMLfWKX2cnlngS+yLmwGFh6itwy6SQ3CKHyw+5jyMoEq85/eDuSdGZEa
         AloH/HVPFbwzf+ngioiFUptOD4+9224VVVma7eA4d9Bl9T5Rndb7oA43dd+FD7RfgThP
         gAtA==
X-Gm-Message-State: AJcUukcpsMm1HbZ+7Y9OYK9cJA/Tqlr6y6kyEzjIZ/JyE5eVhka5LmjS
        gAUiN0y6w9IliZFdmXYQDmA=
X-Google-Smtp-Source: ALg8bN7sNNQmBVk0nWnjWZCpvEMhb+2caLmpbjQ20j1vo35O95verYWxY9M401GeFoa6nmXRLbW2FQ==
X-Received: by 2002:a2e:8087:: with SMTP id i7-v6mr14108186ljg.179.1548596731697;
        Sun, 27 Jan 2019 05:45:31 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id h3sm2446962lfj.25.2019.01.27.05.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 05:45:31 -0800 (PST)
Date:   Sun, 27 Jan 2019 14:45:07 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: chemical: pms7003: add device tree
 support
Message-ID: <20190127134506.GA10793@arch>
References: <20190106171614.12615-1-tduszyns@gmail.com>
 <20190106171614.12615-4-tduszyns@gmail.com>
 <20190111221526.GA29234@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111221526.GA29234@bogus>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 04:15:26PM -0600, Rob Herring wrote:
> On Sun, Jan 06, 2019 at 06:16:14PM +0100, Tomasz Duszynski wrote:
> > Add device tree support for Plantower PMS7003 particulate matter sensor.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  .../bindings/iio/chemical/plantower,pms7003.txt    | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > new file mode 100644
> > index 000000000000..79eb538eb932
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > @@ -0,0 +1,14 @@
> > +* Plantower PMS7003 particulate matter sensor
> > +
> > +Required properties:
> > +- compatible: must be "plantower,pms7003"
>
> Looks like this has reset and set GPIO lines as well as Vcc supply.
> Bindings should be complete even if the driver or a platform doesn't use
> some parts.
>

Fine. I'll add missing pin descriptions in v2 then.

> > +
> > +Refer to serial/slave-device.txt for generic serial attached device bindings.
> > +
> > +Example:
> > +
> > +&uart@0 {
> > +	pms7003 {
> > +		compatible = "plantower,pms7003";
> > +	};
> > +};
> > --
> > 2.20.1
> >
