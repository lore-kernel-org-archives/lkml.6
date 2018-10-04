Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE3AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59542084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/L/6XlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59542084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJEDOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:14:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39085 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJEDOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:14:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so10528221wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8EHvDEausSOaV9oneT8yLoGwoW1HYz1GamChxquWiVI=;
        b=h/L/6XlYiABBMAMIE5tSX9eYTPfzoVPYUunQ+sjrejQUv6IBeCMI265wkktKY3bAQS
         hW6gZrmpMA5e1dWCyyT+wSXSlNm84d0cCZjpMhcSasoIEhnu55GKdkAGgg4YK25AaV7q
         I5DOkOUgLYLT1mg9Z7kJFJzI5EjyfOE5FbKpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8EHvDEausSOaV9oneT8yLoGwoW1HYz1GamChxquWiVI=;
        b=OR4qrtWpghd8moWiBfoinL9/sttreuf6TSA+FS7EY5m1PwHVzhcyaEwd+dP37yYdVB
         soh7/1hsGKQ+Qzk+UZC5vmSQa8ha2gaJ6u9CGI3GNBRSsNRhRSkmJsE/PkDa5m8D1Rtf
         Upv4fdoszNRR9+V5mScEqS0ZgZm38oO5juZFEpE79MS/z+Swxm9X+RZUgHf2mbUpVNE5
         bzx6+Lxg0Qa03VRz31+T7vjqXsTjFwLr41N7GSKCIVyYfwHjPdp6nXPlr5v+SqHMuFjH
         HxAyP2PrjTlYCnpI9s+5BOXSnGQtaIbBUWaeB3d7xGgyN3Rw+tKaXMHGSfYih6ZZyyOz
         h07A==
X-Gm-Message-State: ABuFfohYr7yocD089mwK0wZJDHHBpWxfLlDAn2aJB4MuzO13osG+xqkC
        8kD7CQxm9XZ5t5Vq8B7keepqgw==
X-Google-Smtp-Source: ACcGV609ODRWekh808m5ojYHrdV7+5In6OmEMMlJexP7OnHP/xnaESK0SnI/Qfk0w69gxh+KbUbcfQ==
X-Received: by 2002:adf:fdc2:: with SMTP id i2-v6mr1793146wrs.276.1538684371410;
        Thu, 04 Oct 2018 13:19:31 -0700 (PDT)
Received: from [192.168.0.100] (146-241-9-213.dyn.eolo.it. [146.241.9.213])
        by smtp.gmail.com with ESMTPSA id r8-v6sm7758522wrm.14.2018.10.04.13.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 13:19:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20181004202553.71c2599c@alans-desktop>
Date:   Thu, 4 Oct 2018 22:19:34 +0200
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
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
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <466C47DB-02D7-490C-91E3-8C7AA41B8D79@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 04 ott 2018, alle ore 21:25, Alan Cox =
<gnomes@lxorguk.ukuu.org.uk> ha scritto:
>=20
>> I agree with Jens that it's best to leave it to the Linux =
distributors to
>> select a default I/O scheduler.
>=20
> That assumes such a thing exists.

Well, as of now the default is more or less in the Schrdinger's cat =
state :)

Metaphors apart, I do agree with your point.  As for me, what you
point out is one of the core issues at stake here.

Thanks,
Paolo

> The kernel knows what devices it is
> dealing with. The kernel 'default' ought to be 'whatever is usually =
best
> for this device'. A distro cannot just pick a correct single default
> because NVME and USB sticks are both normal and rather different in =
needs.
>=20
> Alan

