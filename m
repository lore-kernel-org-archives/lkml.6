Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0D4C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074FC2170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3+YAGN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074FC2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbeHGPFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:05:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34485 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbeHGPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:05:34 -0400
Received: by mail-it0-f66.google.com with SMTP id d70-v6so15274105ith.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=XBmZmdYv6J+mPcsqBH35EmTgp7GdoFNFZbKDMJE+iS8=;
        b=P3+YAGN1FNUzrtf/Yc+VCbQeF91usFj0jFerOakzKRC8pZb5EqpRj0EVZuC/K6SCPj
         aJHKsxO5sBiJvuwqBtIW9h3bYlHnL9erGurcj+Ks+m9WTJU5MWCWq0QSErH496Fj5B5j
         NrVyL3h+YLY1u3yiqpN8GhwPdbQ39x/Jpmzjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=XBmZmdYv6J+mPcsqBH35EmTgp7GdoFNFZbKDMJE+iS8=;
        b=bwSTpMvta16MJ77KQaZ6bkb4ikO8qD6mnB4mIU8CHcXt7if/tzRxeJJ1nUvL33Fa+9
         tLTr+/1Y8f5CaiaJGj86stYcl+sKyBhX4Yt4h18y9P8hZL+ymNSaFVVGT1x+gTttNBEb
         CuhF3x6ObrHxGafgkX9FuTylmn5tMjeSAx2MRObU/PTOSxonFMVEhIZJVIu9J01mYu68
         BKo2q3N/ZGCqn2WQXThAVZnO+VEB9SgSLuG0oMij4YiU5sxMPAwGPqlHOUMm6GCJULNN
         S5JHZ530eyi22vi1yvJfyqQtLsGcMVFCgQO8ryBoSFfJMC4AXAW29525genTZRZhAWB6
         keHQ==
X-Gm-Message-State: AOUpUlHQI6ScQ/Oxru179juDxbJVstJzI5rx6a46+22gkYxxHQDn4f7G
        B+jSdR8HN7TpR/tdid5BVHGHdPIm5dyy1Uh4RLfo0g==
X-Google-Smtp-Source: AAOMgpfdUT2v/wefYztPX0zhdkpPAGUmd3zOljA1wTGWJIQB9FtJkLxNEnUafgplipK3XrI8f4afWmi4/DE8/8BhxPQ=
X-Received: by 2002:a02:bb04:: with SMTP id y4-v6mr16701644jan.5.1533646283105;
 Tue, 07 Aug 2018 05:51:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 05:51:22 -0700 (PDT)
In-Reply-To: <20180807031526.GD5048@thunk.org>
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806230437.21431-1-Jason@zx2c4.com>
 <20180807011937.GA133621@gmail.com> <CAHmME9oTApV-zHD60QPryaoQf45ODpG25Da5FgB8c+LO162gWQ@mail.gmail.com>
 <20180807031237.GA779@sol.localdomain> <20180807031526.GD5048@thunk.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Aug 2018 14:51:22 +0200
Message-ID: <CAKv+Gu_Dr1KvEOMdkhxZtq093MDgvcP_G-5=JMmqsx+zYV-=mw@mail.gmail.com>
Subject: Re: [PATCH] crypto: remove speck
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 August 2018 at 05:15, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Aug 06, 2018 at 08:12:38PM -0700, Eric Biggers wrote:
>> I mention this because people are naturally going to be curious about that, e.g.
>> speculating that Google found a "backdoor" -- remember that we do have some good
>> cryptographers!  I'm just stating what we know, out of honesty and openness; I
>> don't really intend to be arguing for Speck with this statement, and in any case
>> we already made the decision to not use Speck.
>
> Let's be clear --- the arguments about whether or not to use Speck,
> and whether or not to remove Speck from the kernel, are purely
> political --- not techinical.
>

Whether or not to use it may be a political rather than a technical
motivation. But the reason I acked this patch is not because removing
it aligns with my political conviction regarding Speck, but simply
because its contributor, primary intended user and therefore de facto
maintainer stated publicly that it no longer had any intention to use
it going forward.
