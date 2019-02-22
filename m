Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81027C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0A62075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550845887;
	bh=s6BF4/PNzdJ+sSy6I/MctFhxR7oNQwBeEVUesG5pIkw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VMDCzIVk2x8MXugPZOt/Px3dEUwuZS1QyjocC1tTLHJYXHf5PsQT2xjH+G23WgZRG
	 4yBz4HtWYfHSQ3AhAjXzLAfkDt+TKMnhAE2kuoqb88Pfj4VR1n4rLea86wjJkWYaoR
	 rSkBtuz5whXUcEYybleh6JvJqlveYOGoRwl13TUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfBVOb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:31:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfBVObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:31:25 -0500
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA17A2086C;
        Fri, 22 Feb 2019 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550845884;
        bh=s6BF4/PNzdJ+sSy6I/MctFhxR7oNQwBeEVUesG5pIkw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YfzRyGoawM7b1KmExRQJu838kXtImb93qLT6eGPejetQ58KNLO8UK6YAPCj331QZA
         R2jiOQxv3o/7qx5cUQq8OiR2iEfiZCPR4pEWMrpYIU9Ly/iHlMU7BaedWNZKqst0UZ
         H/4MavDw0NBCVKYYKZNsmk3SBzHhvu+s6j2CYgLM=
Received: by mail-yw1-f43.google.com with SMTP id k14so887155ywe.4;
        Fri, 22 Feb 2019 06:31:24 -0800 (PST)
X-Gm-Message-State: AHQUAuZqjPQ9fcryC+ANc9B6Gbe4t018eyELAWM/JeboynUYpW1tw7bu
        hL1spTR7YthD7jhSGUBtwBisk91D3edc/6MZHg==
X-Google-Smtp-Source: AHgI3IZEJaqo7nH6UOboxGM6fz3rpa1Wr0mgQfX7201HKIL66/rgTieS/Cv4twPagpoF6CKF4BN/wG4Cuqm9YQhW1TA=
X-Received: by 2002:a81:7916:: with SMTP id u22mr3554869ywc.111.1550845883877;
 Fri, 22 Feb 2019 06:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20190219141139.24216-1-bogdan.togorean@gmail.com> <20190219141139.24216-2-bogdan.togorean@gmail.com>
In-Reply-To: <20190219141139.24216-2-bogdan.togorean@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Feb 2019 08:31:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+iuEeXPewzYmHe43-57+Oskpk=ie0D5oYXoRAkW186Q@mail.gmail.com>
Message-ID: <CAL_JsqL+iuEeXPewzYmHe43-57+Oskpk=ie0D5oYXoRAkW186Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: adau1977: Add MICBIAS example in DT bindings
To:     Bogdan Togorean <bogdan.togorean@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 8:12 AM Bogdan Togorean
<bogdan.togorean@gmail.com> wrote:
>
> Add MICBIAS property to the optional devicetree bindings.
>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/adi,adau1977.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/adi,adau1977.txt b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
> index e79aeef73f28..87c16e6f2e7c 100644
> --- a/Documentation/devicetree/bindings/sound/adi,adau1977.txt
> +++ b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
> @@ -23,6 +23,12 @@ Optional properties:
>   - DVDD-supply: supply voltage for the digital core, please consult
>                  Documentation/devicetree/bindings/regulator/regulator.txt
>
> +- adi,micbias: configures the voltage setting for the MICBIAS pin.
> +               Select 0/1/2/3/4/5/6/7/8 to specify MICBIAS voltage
> +               5V/5.5V/6V/6.5V/7V/7.5V/8V/8.5V/9V
> +               If not specified the default value will be "7" meaning 8.5 Volts.
> +               This property is only valid for the ADAU1977

There's no shortage of mic bias properties for codecs. We should
define a common property for this.

But looks like this is already applied, so what's one more...

Rob
