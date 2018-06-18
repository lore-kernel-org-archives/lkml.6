Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880ECC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4AD20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ANqylmC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4AD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935341AbeFRUYT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:24:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45942 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755310AbeFRUYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:24:16 -0400
Received: by mail-pl0-f66.google.com with SMTP id c23-v6so9624527plz.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=Kx1DsHBZCqF/P76ODHHbeTa0o+finkCNcCRAs1TZ5g4=;
        b=ANqylmC7P54f1R+9Noeef4tOY2gWIsf1rpi2vYbtNC7Qi2THMGGLiiJoctdba90W0F
         T68qew201/eNSHCAr6stKUnJDHYFctnUh32pwBgKT8K4HZpE/Louxk5CkTKCNCYoYH68
         bedYaY8kKqlKkt1yes+mdBU4+WJkIAMoMRgn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=Kx1DsHBZCqF/P76ODHHbeTa0o+finkCNcCRAs1TZ5g4=;
        b=HMM5B6kDdm9VWuHYiZgJf6K714TgK81gjn4S2ziEd7fn3e3Z0FGn3P7Vgc/ROBG/i7
         PdIvVUkRpEPbKq9cs+50nWA5z1oRoQzYwFphAnzdASyvTjUT3OJYMag5Rkt4Ekv5gOBe
         sUIbezJmyKrTN+RQSdp/2imRc+iJTQmTKNsAKgrqOHkXZWGKAIrGrGz/dF8JZmAxT9FP
         hg6um0cqkgDVPdx7EZFZH3Gj9r7kNoMrRhi3WCz0IxcarE8K662DaDylR2O0R5FIcs3e
         bMtnzISvU0TDJYMzOaKaCGGNtXnnGPV6nUsTj59dCtz0I6xnWhVVgVfmixD3rJJbXRr/
         moxg==
X-Gm-Message-State: APt69E36EnF4bNEjUnPh0U83a5LrPnvYFeRdi5J/UWed4+5MJInv6pWl
        /7qRfcQJaIiesNBQBgkWCsKaRg==
X-Google-Smtp-Source: ADUXVKIoXQIOGqfG/s02EKcb18W1idu/sPU8SPnCWQlTRovbLRpVDpD0E7w19MMCxFj61AMH93Il0g==
X-Received: by 2002:a17:902:28c8:: with SMTP id f66-v6mr15772592plb.60.1529353455814;
        Mon, 18 Jun 2018 13:24:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id h8-v6sm19309340pgv.29.2018.06.18.13.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 13:24:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180618182123.GT14924@minitux>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org> <20180618182123.GT14924@minitux>
Message-ID: <152935345439.16708.16472364970375601294@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Date:   Mon, 18 Jun 2018 13:24:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-06-18 11:21:23)
> On Mon 18 Jun 07:12 PDT 2018, Vinod Koul wrote:
> =

> > Qcom 8996 and later chips support prng v2 where we need to only
> > implement .read callback for hwrng.
> > =

> =

> The hardware still needs initialization, so I think you should expand
> this to mention that the initialization is moved to secure world and
> that's the reason why we only implement read.
> =

> The question is what happens in projects with other security models.

Can we still read the PRNG_CONFIG register to see if it's already been
configured or not and then bail out if it isn't configured? That would
be better as long as we the system doesn't blow up if non-secure mode
tries to read the config register.

