Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C577220875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9f+yisH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C577220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFTNkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:40:10 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36606 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbeFTNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:40:08 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so5057998lfh.3;
        Wed, 20 Jun 2018 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8xhNyC33NNhsjTjvMk9gJDDjjr4j2c9DSnhZEZng08Y=;
        b=u9f+yisHtFAhzD+gTd4TvBvvqWOIH+d6SeHcbXAtQwB/d7pfsNLi+ko1jFEkYhz1NO
         mhsNibNPzlN9nmj93/QTvF6s0i3YxTVxpvkPJqSppLCZcVqI6mTPaBB/QqY00A3f8BZo
         NCbIzYLJwtEr0y4MdMctJ4S4DV8pbTr06tccTkBjO6838kHNFemXTG6oNEjH2HeOQZhI
         bbRDK5C3+6XjrPitW1kri8sBep8HxmrOueatp2+ad8KqEAuakXcxTcBBFZUE6k6Wg/Qk
         puyHOt+NFhecQGfV4F23fvgLHq/zA2V+a4v8ly/6K/JWFKBBGCSKENsGYuuIQj906KGV
         9zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8xhNyC33NNhsjTjvMk9gJDDjjr4j2c9DSnhZEZng08Y=;
        b=F5qLfljrQ/0kJ6fRtXHscXU5y3j1r2sbav/+hjsv8Z0mnibIXHBZF3KVjcl/oA+P5a
         CqH7nw2NCU7K1aNcWngQ/gFfoxgZhs00z5+1M4eRK29h2ZjBexYmwJxAa+Xhe1RlnZ5b
         usAqJp26k47De/8x0/fhXfT4p0x0W3sTSMy4uyhq8Csu9ocRyYoU49a/m4RAkPsm7ObO
         UgBnCbeK+tvE6s5Rp9hjvOdC8XIq1T14gyQu5ua2HMH+Egq9YmcIl9FgtA1lieQvxFWp
         QVBmU2mFNEbS8GYh2NciNsgt455qV2/bS4+UChSKBU6XzJXZySs2RamA+ED8PHGtf2Kb
         D3dQ==
X-Gm-Message-State: APt69E1KVQInNbMEt3ngxH90y9oYOs7WH7OpuMyzMxPCvWjWKowNx4+F
        N4nQiHZVa5XhJV5ZxBw0HlI=
X-Google-Smtp-Source: ADUXVKLG+onl7VnnL+fKmYPf2cjXZFUIzRZC4r1zyeXk5TvkdYjjpEjGTlKjkTl4vdAF0T//NMc6sg==
X-Received: by 2002:a2e:5549:: with SMTP id j70-v6mr15116769ljb.147.1529502007206;
        Wed, 20 Jun 2018 06:40:07 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id l41-v6sm431896lfi.21.2018.06.20.06.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 06:40:06 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 03/12] spi: spi-fsl-dspi: Fix per transfer cs_change handling
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
        <20180620073442.20913-4-esben.haabendal@gmail.com>
        <20180620132755.GF6242@sirena.org.uk>
Date:   Wed, 20 Jun 2018 15:40:04 +0200
In-Reply-To: <20180620132755.GF6242@sirena.org.uk> (Mark Brown's message of
        "Wed, 20 Jun 2018 14:27:55 +0100")
Message-ID: <87r2l1mv9n.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Wed, Jun 20, 2018 at 09:34:33AM +0200, Esben Haabendal wrote:
>
>> As of 92dc20d83adec565378254c0630e839ff5674e14, transfer->cs_change has
>> been supported for non-last transfers, but not for last transfer.
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Ok.  I will add the commit title to v2.

/Esben
