Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA235C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6575226092
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsRoDCZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6575226092
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965085AbeFYTvG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:51:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43586 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964852AbeFYTvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:51:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id r7-v6so1990991edq.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mwd0ZOAL9MeZYUExqaLViSnqH7P8GJ/zsNkVOE6cmWw=;
        b=dsRoDCZ84tSPGy6QhujCzaD5yUm2PoSSMEypMaX4h3dCZoZDVdTtdAeJ/mO25kTOZ7
         nzuy9iik4sy4U/DEgre6o0stommZjZS0QW1vZ1FkIqRlmumNMtbeEjaZ4kenRJ+zSIPy
         ufMsQI5e3c5jpNXabocUp6HHL+y4WUHgt0+EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mwd0ZOAL9MeZYUExqaLViSnqH7P8GJ/zsNkVOE6cmWw=;
        b=McJXSRTFaiO+oPcL6Zn6o5pqKCHkKuoZLEey1ZQzY4nCHjlK2+qCYOGhgCCOIzvLXd
         glfCKFXS3OJsiOI0gyihON/Is3HhWAQIAXVB9WG8jcu96mngSxp9PTyP7FsZSDIg6RtS
         padPKzKwIF0DhXk1AkiJf0NNEwqJZZGS3PDdwHlkoBR/iq3QVLdn5A04EStDo4b4Dvx9
         KpoRtR7qix70ONedyWZ/dGwZaGSIfFlcB1s3UBCStOMWF2fPP1GncBXGQV3YgpGtEKIp
         YVoeBYYjy4qqSxqRSWFK3UmrEBYpBBDRUzVYM1Nm3fJuX6WJnLoYdiPGun7XCdS7Ap6k
         iQRw==
X-Gm-Message-State: APt69E1t7m//HEBhX83/QUESMx78MtABtDkaJr8wKIqutK3qlWO1OjFq
        4D6jzmyjKUaxUI9/eNZqdvkJ+w==
X-Google-Smtp-Source: ADUXVKJ/RjWPA9Xtq2CiJcNc4beKm60gb8/lewTElqp/SKPas/3gtuZt3RqLcX++LHC0AVU5bpOItg==
X-Received: by 2002:a50:b376:: with SMTP id r51-v6mr12598005edd.145.1529956263173;
        Mon, 25 Jun 2018 12:51:03 -0700 (PDT)
Received: from [192.168.0.101] (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id d11-v6sm19330edh.61.2018.06.25.12.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:51:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX 0/4] bfq: fix bugs breaking bandwidth guarantees
 occasionally
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20180625194806.7619-1-paolo.valente@linaro.org>
Date:   Mon, 25 Jun 2018 21:51:01 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org,
        broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BFD7497-CA97-413B-9387-0A192B5D1835@linaro.org>
References: <20180625194806.7619-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, one commit message broken, resending ...

> Il giorno 25 giu 2018, alle ore 21:48, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
> during some bandwidth tests, I found some occasional but severe
> malfunctions (losses of bandwidth control). The first three patches in
> this series fix the bugs that caused these malfunctions. The last
> patch is a fix/improvement of the name of one of the functions
> involved with these bugs.
>=20
> I guess these patches are appropriate for next kernel release.
>=20
> Thanks,
> Paolo
>=20
> Paolo Valente (4):
>  block, bfq: add/remove entity weights correctly
>  block, bfq: do not expire a queue that will deserve dispatch plugging
>  block, bfq: fix service being wrongly set to zero in case of
>    preemption
>  block, bfq: fix service being wrongly set to zero in case of
>    preemption
>=20
> block/bfq-iosched.c | 131 =
+++++++++++++++++++++++++++++++++++++++++++---------
> block/bfq-iosched.h |   7 ++-
> block/bfq-wf2q.c    |  30 ++++++------
> 3 files changed, 128 insertions(+), 40 deletions(-)
>=20
> --
> 2.16.1

