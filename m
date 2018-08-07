Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A6C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E549021731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2j2hXEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E549021731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390074AbeHGTZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:25:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42009 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390037AbeHGTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:25:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so14004052ljc.9;
        Tue, 07 Aug 2018 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEmzIpIJeMrr/tbenoFGx1EzF3o0ZISrz/y0iiZYYJc=;
        b=E2j2hXEsNrz7WNhQbvmTnlaID86uTIVE7wC5KjXGn64d/DthsNiXGvoyDuVSTEWY+F
         BPTxnlhaik2yYSOANh+oNBeh1WXAC3anJ/g0PAvoZzRM3WTGrfFnTTbctPtexddCAFcP
         nSPfYpuz2FhYHZgDAW6Squ7zpw1q3MaEjIHeSggBZHx+EARbHEg5K2uvK4fUS9ttWTRq
         c+OHw1ad8sDGSIP3Dq94rRLnftWvZKtNimoCJOscBB7BgXX0e0B3DLs6vJVaQh67zSWh
         incW7WhrCH7/1cJxgfA4xlgB5XO1Mr4Y2xBJHeb/PO2HE8Gg2mo/aDaBcA/0yhhlYehb
         SpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEmzIpIJeMrr/tbenoFGx1EzF3o0ZISrz/y0iiZYYJc=;
        b=crrOxGUkNO1N1cnFNf3QUJEZgrWp4QOXp8DrDAvuhaKYy/gYGBXB7u53qVtWYel6rI
         6fm75ZzewqKH2irsswMIw1yDITuheBmd5XcvHXTI9joS1k2cVDb2oHpKAVVHl9Hao+vL
         77o9A80+PoOq0SBJf+ohN31dPUpYcTDanK03/b0gQrT4fXDTe4aJLaw7CfjTaphc0jPp
         b4k2Ud78sSGGU2XAbydlNrCa5/zHv5aQR+txdW50SJRodtzXOJv+xiUgy9pjcDDTcS1p
         lAFv7cxvJd//sNXKZNkpMuA7dwYI+/BbX/65LI6qr7puluiBACPxQyyqgtq1CFw10Czj
         TvPQ==
X-Gm-Message-State: AOUpUlE6Jj+ppyDiKbNYmvRe35Ur+Cy/1rUdFdM+snKTDfSarXfnhmWM
        nUxm2Yg7Lf/8zKtnOIeOTSM=
X-Google-Smtp-Source: AAOMgpenz6j3OSFJmb831uDvT6MeTmQEzURgrDRCHtzPs0fONdMRNGmviLWlAVjYTvsM4poY7IonrA==
X-Received: by 2002:a2e:1301:: with SMTP id 1-v6mr15545786ljt.56.1533661822563;
        Tue, 07 Aug 2018 10:10:22 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f18-v6sm325264lja.85.2018.08.07.10.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 10:10:21 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for data read/write
Date:   Tue, 07 Aug 2018 19:11:22 +0200
Message-ID: <1593487.Cmi0mten1c@z50>
In-Reply-To: <20180807190627.4340aade@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-6-jmkrzyszt@gmail.com> <20180807190627.4340aade@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tuesday, August 7, 2018 7:06:27 PM CEST Boris Brezillon wrote:
> On Tue,  7 Aug 2018 00:29:11 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Don't readw()/writew() data directly from/to GPIO port which is under
> > control of gpio-omap driver, use GPIO API instead.
> > 
> > Degrade of performance on Amstrad Delta is completely not acceptable.
> 
> Can we have numbers along with information about where the overhead is
> when using gpiod_{get,set}_raw_array_value()?

Yes, as soon as I get physical access to the device, probably this or next 
weekend.

Thanks,
Janusz


