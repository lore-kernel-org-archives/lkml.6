Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD8BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD7E2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFwQYfwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD7E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeLEP3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEP3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:29:05 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E359920878;
        Wed,  5 Dec 2018 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544023745;
        bh=6gc1GNYaPrXSCJxKpfbrm5xI1VFiB5LBLD6SMRFiDxo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hFwQYfwfhxfr0s8iadJIumbmNq4IEcE6TfDK8ZCNGQqf4Ncqzs9iZ5eeZfzgzZm31
         SEKXDBC9EVxRuHEAke1Wsk1sGZos3O5cj4YWSqtBudAZoXgGOl5PdOw19hhHUWfxSA
         JAM45ZOO/iq9LCVfmG7pJsuKayOp1N24HMCeU3v4=
Received: by mail-qk1-f172.google.com with SMTP id q70so12073138qkh.6;
        Wed, 05 Dec 2018 07:29:04 -0800 (PST)
X-Gm-Message-State: AA+aEWbxXjZ8bXaawN20C1SwlFr9CmDTZIlM/eAigm2+Cuf9m+kuW4Gg
        1OHjhcXpwm6DiCS4qJojLF7TvfB3Lf2isYEJwg==
X-Google-Smtp-Source: AFSGD/XGwOvsFejoVa8emjJgfZDHx/tRiZgl+dZ/r3fag5pCqkCYzWYE7oSuITKw95XUMKKYAtVXkJasWpHZtVesvXY=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr23275644qkg.147.1544023744129;
 Wed, 05 Dec 2018 07:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20181115071253.22558-1-kmarinushkin@birdec.tech>
 <20181204214313.GA7847@bogus> <7cbf1452-354f-07d6-2310-cadc4358433e@birdec.tech>
In-Reply-To: <7cbf1452-354f-07d6-2310-cadc4358433e@birdec.tech>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Dec 2018 09:28:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLirgcDwANbORiez0xtO1tEHDL-O8XdbZSP6R+WZF_HLQ@mail.gmail.com>
Message-ID: <CAL_JsqLirgcDwANbORiez0xtO1tEHDL-O8XdbZSP6R+WZF_HLQ@mail.gmail.com>
Subject: Re: [resend PATCH] dt-bindings: sound: Add documentation for pcm3060
 property out-single-ended
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:02 AM Kirill Marinushkin
<kmarinushkin@birdec.tech> wrote:
>
> Thank you Rob,
>
> Mark already applied this patch, with a slightly modified subject:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=fd7de6370cb62b147185834d60069568a21acacd

Humm, I wonder why I didn't have Mark's "Applied ..." email for it?
Otherwise, my scripts rely on the subject matching which breaks when
maintainers edit subjects.

Rob
