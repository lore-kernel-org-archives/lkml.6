Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F9C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C7D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kmbgqxIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C7D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbeGYUYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:24:36 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46389 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:24:35 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so15817908oie.13;
        Wed, 25 Jul 2018 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Z7zZ2yxHRaCvZUdCS+kl0SYhgebxF7kwkeYgiQh5NU=;
        b=kmbgqxIRp6KOijzsjLa2ZZ0YkFcqtVYRPVNbEeRUgcTMbfbNnAMuLFfhea8yv9Pmq+
         /wdsEvWz+z7cLqqBsq6RjMl8WdwzJn3RafS+/0N67Dc1LbyPYadFnbhDHY1+0iKWeaoH
         dVj2WX3TVA4Eu0X9rtq+ebMB5E0uoCEtyQfum9J5j8VzddPAG2RerZYu0qFWkJo4TFvA
         0fzvxSMuV29fWYJUMM58+4SBZCYTO79jEDtCUDKhYI3tgx5k9PqxWNGBZy03JmBcMz/Y
         rOzfJr9SuZ4qqxRavHnNb9SmcnzOhmlQolx9jHiakksHGkAW7RIOds2UiM/Jt69J6dP4
         PHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Z7zZ2yxHRaCvZUdCS+kl0SYhgebxF7kwkeYgiQh5NU=;
        b=lHPtlgWmqkfzURPkfBXTQTnj3Yg2G9qKWRdRG8BKG9cS5tabhOuzk0ANgJV94+N8c2
         3mFf3qwsyCju7UobD579C2igjEHFp/w+8VNg6Q+BSsZQClBeVJR6ovIOwNCJNy1boJmN
         3fJ2owc1zP6H2CtNpo0M0h51aLcm8mX/fQythFhUJCmvBJDqK/uQ7DOX12B/kGt1Vd4c
         KDhNlRduDlR7SqmVu1dJNj4E+QBnXoy1xhc9kPfEetYMygKdU3Ki/dKfb49klLinOH2T
         u4ISlOLPU3nikgH77LW2fUXDIZ5A5JYF+h3s4YSAiU+dNKUfvjUHFakA8W/r9uqFoF8L
         WVHQ==
X-Gm-Message-State: AOUpUlEPL3pqWn122LhvQ6oHzLNn67cuHnOfYAPRee2kLvhMUr5mrmhD
        DS6gzLJcVwcipj1br3x9vfrT3WEn62IbqUrZp0s=
X-Google-Smtp-Source: AAOMgpeQWyEGSdZWZPz8wNoniQ7OQY60kQMVLW+B3kkQKGsYOKu48CBf0idQNc1lT3EGnETdGGJ6Lc73WQlcWmkjdgY=
X-Received: by 2002:aca:c70f:: with SMTP id x15-v6mr4816541oif.97.1532545894573;
 Wed, 25 Jul 2018 12:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180724125238.14567-1-jbrunet@baylibre.com>
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 25 Jul 2018 21:11:23 +0200
Message-ID: <CAFBinCBh-b=ie4hBMWdHG8KoLQ7qiRfo8vXfJ1PRcN4UPtg+uA@mail.gmail.com>
Subject: Re: [PATCH 00/14] arm64: dts: meson-axg: add audio support
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, carlo@caione.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Jul 24, 2018 at 2:53 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> The main purpose of this patchset is to add the audio devices on amlogic's
> AXG SoCs.
>
> Some codecs require some power supplies. This is why the 3 first patches
> deal with the S400 power supplies, even if some are not related to audio.
>
> In term of dependency, apart from the clock bindings you have already
> pulled for your second PR to arm-soc, this patchset requires the ARB
> reset bindings [0] for patch 5. I don't know if Philip can make it
> available somewhere ?
>
> Of course, if the dependencies make this patchset too complicated to
> merge in this cycle, I'll resubmit once the next rc1 is out.
>
> Jerome Brunet (14):
>   arm64: dts: meson-axg: improve power supplies description
>   arm64: dts: meson-axg: add vcc 5v regulator on the s400
>   arm64: dts: meson-axg: add usb power regulator
>   arm64: dts: meson-axg: add audio arb reset controller
>   arm64: dts: meson-axg: add audio fifos
>   arm64: dts: meson-axg: add spdifout
>   arm64: dts: meson-axg: add tdmin formatters
>   arm64: dts: meson-axg: add tdmout formatters
>   arm64: dts: meson-axg: add tdm interfaces
>   arm64: dts: meson-axg: add linein codec
>   arm64: dts: meson-axg: add lineout codec
>   arm64: dts: meson-axg: add spdif-dit codec
>   arm64: dts: meson-axg: s400: enable audio devices
>   arm64: dts: meson-axg: add s400 sound card
nit-pick: one patch uses "arm64: dts: meson-axg: s400" in the subject
while other patches that are touching the s400 board aren't
if you have to re-send this series: can you please use the "arm64:
dts: meson-axg: s400:" prefix for all patches touching the s400 board?


Thank you!
Regards
Martin
