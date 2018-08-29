Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E40C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8DA2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiUw2BLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8DA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeH2Mk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:40:59 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36711 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeH2Mk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:40:58 -0400
Received: by mail-io0-f193.google.com with SMTP id q5-v6so3814742iop.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yw/Yxtvuv8Xa96HSALZcaFF64L3lA5Dopqk6xrLCf2A=;
        b=aiUw2BLfkUeJPWsoBEgAJ9vuQWRuZ8tkH8mz2Dvp1SZzdeCkNCqTkDyXEQZFoSmghd
         Q48Xqs2GWnDR2OgQ8E3rUJ/jKVKKFhhmIrv4TzsuBzUxLuqvHYvxheXZNtj6+RY7iT4I
         1+zsEND7YaH6jasekwhiqIaw+uuwCvTrl6z3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yw/Yxtvuv8Xa96HSALZcaFF64L3lA5Dopqk6xrLCf2A=;
        b=G/fuc1TFpEaWqbRfdJQP6yDPJK+0FvxIk/+aqC+wrE0RowQsSxNpssjNcJ8Tik06J6
         qzRc7RaheK0UEL83TpzJJS/yp33IRfLE5O5F6eOK1ycNhb3peOmSAAFxv+rqktn3QSX3
         477e8+aMZdTUxlUj/zykcS8bqbXFndL1ybgQL4JfE246pbFFWqJE35J1g6byYjT+q9T4
         UZ88lfXJ671H/EwE4zU+B+jhfNBLM6uu8R3yXKbbOIQopnhsr61L4+eeS216TT8Etnwe
         fwFR2iW+wauXAeK4DwT+HNJ1RsTU9J9jfMvjiPhrcjbkR5ssf+1OniEu5CFxAIIiY1DZ
         nFMQ==
X-Gm-Message-State: APzg51BivNhkpEmYVNMk9AWc8QMKmec8hFTTg7g15BIqyYt5svZvkbd+
        358ZTBghMU0R6xsgfeoKHwHHwHEx+sXZwPzQNMmZOA==
X-Google-Smtp-Source: ANB0VdaL6EdLgK3XBegmXjq1CnD0p6Qfcw+ssIkccOyvtNV56qqNc7o2uHvPLNaAKrzrwUy35umo1NKm6gNNrLBxQ+8=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr4297564iog.175.1535532308467;
 Wed, 29 Aug 2018 01:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180807093226.5624-1-rf@opensource.cirrus.com> <20180807093226.5624-3-rf@opensource.cirrus.com>
In-Reply-To: <20180807093226.5624-3-rf@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 10:44:56 +0200
Message-ID: <CACRpkda4EyTkVSfm0JvBR7jJHAe1WSuFiTyRjDvWTfL2gi9uUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: madera: Fix missing space in debugfs output
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 11:32 AM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> The SCHMITT tag was being dumped without a separating space.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Patch applied.

Yours,
Linus Walleij
