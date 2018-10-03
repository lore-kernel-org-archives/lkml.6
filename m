Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6DCC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4519821470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpuwnjiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4519821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeJCWxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:53:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38555 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeJCWxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:53:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id 193-v6so6179423wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l/kgTbonsG3ZqXt9huXM0JfpFIu/MAijLq8BOM10KGQ=;
        b=SpuwnjiMCOo/xmc3hB/LtaTyWJsQjyi0DRE8N1E95n8UoXLUNZLsjlcZmaLm0adBkm
         hOC428+nrMkn94kD/gbrD7+D4MPQGx58YX88dfedOulA+PjL32uON8KRcc0vJDNxDNN4
         S0tM+dgbp2Pon9842aUp61GjM+cXj3QqWG6Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l/kgTbonsG3ZqXt9huXM0JfpFIu/MAijLq8BOM10KGQ=;
        b=jcZ0TLOMvqI/4wmoIwZP/2SbJbeZ8avDs/m6oV9o8MAvS+iotGP2RePFep7zeHGsLp
         bWhaMohP/NzUL6NE/inm9Cjbe0eWtcUakNoE+IWTUEIGgqMWpiVU6ndzSzNhF94z96+o
         RL72uT3lVoyi+m2WjYxtjznVk7okdQT+dsQ4S7vOoL4ETglHkVu3DI10YnActoGX35bT
         jcvA1lLBi9Ikhu5jbVUGyvczBSrZ+uHVX5Op3baGti/q7dSi0DgGB/+46BZ4Ue6h0gQT
         WOIg0qbZdphSKT2R/Wv2NJZMLJFZfaS213Gno6lVWzPpp0FlaMSvYE3tri/2eNeZozuy
         KlXQ==
X-Gm-Message-State: ABuFfohJ7aklpOgY0SegzGln9aWmoGeDgQAC05pxqCaAv3O/Bu7ALyBk
        aQKAoK1VLtT1NdJkcivWhDp+Vg==
X-Google-Smtp-Source: ACcGV62Y2BAeDBO1bcBeKMpjPjIdV2/puT9ui2E5ZPAp1CzZp6EVStL32ThvKaQUq4ouhBSUxZ4IYQ==
X-Received: by 2002:a7b:c216:: with SMTP id x22-v6mr1879862wmi.65.1538582645385;
        Wed, 03 Oct 2018 09:04:05 -0700 (PDT)
Received: from [192.168.43.112] ([31.157.182.99])
        by smtp.gmail.com with ESMTPSA id w4-v6sm3037824wra.83.2018.10.03.09.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 09:04:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1538582446.205649.22.camel@acm.org>
Date:   Wed, 3 Oct 2018 18:04:02 +0200
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <843B42A9-DDE9-46C4-A3AE-616E8DF3946E@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
 <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
 <1538582446.205649.22.camel@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 03 ott 2018, alle ore 18:00, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On Wed, 2018-10-03 at 17:55 +0200, Paolo Valente wrote:
>> The problem, in particular, is that bfq is a complex beast, fighting
>> against a jungle of I/O issues.  You have to be really into bfq, even
>> to just know all of its features!
>=20
> This is a problem by itself. I don't know anyone who wants to have to =
deal
> with I/O scheduler tunables.
>=20

In fact, I designed and am constantly improving bfq, exactly so that
you don't have to touch any tunable.

Thanks,
Paolo

> Bart.
>=20

