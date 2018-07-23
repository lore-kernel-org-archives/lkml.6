Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022FE20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aoBQxFZh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G6YTuVMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022FE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbeGWVL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:11:57 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:44418 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeGWVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:11:56 -0400
Received: by mail-ua0-f193.google.com with SMTP id k25-v6so1248135uao.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=r4sUffr0Ek90qYcA1OGQ81QwDvnIZGgAGSIDCrrMg44=;
        b=aoBQxFZhH26EoAbX0C6uCualGudX2NFFD6r+d4inwNaiJDh15BiVQUV4HY5K1ZED9k
         4YtXsuDuB962R+5y4qK85dJKdbSuqoaQTPogKbF1aZkAxxtdtJDmyjbOxPTyOXJchZG1
         X07NqN51OHAQjKJmcaQAbUI8Yr05lFLs7AW6PNudNIMDuCuuigRQ+M90AXNWlcPss3g4
         mecIfxNTHPyYgEot0ummFDaDTJr/v6YhHxsWfw0mKmyU3ADCQLPVoS02W+tHVwCVr3xT
         V6eMz3t2ndh8COL7cX0tP2NKaSO5zxH4DVD/xqLHGxIvZ8QhDMW5ZKuOM9U8+RIyAAH8
         AW0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=r4sUffr0Ek90qYcA1OGQ81QwDvnIZGgAGSIDCrrMg44=;
        b=G6YTuVMbB6/uMCwgGryMlMJD1FvJ8TAxi0+Iv3OKZhUd1o4uAhjEbmRkeq2SMjrGCS
         EX8m6toLS/fZt19/wpW+Aqzf3JVIezEgkHyaiw3WSNNqKHYaLYsdXnKvhYehHwXRBB3/
         8gzFbLezuUe2CvZHIWUXydvoduedadt5oIUak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=r4sUffr0Ek90qYcA1OGQ81QwDvnIZGgAGSIDCrrMg44=;
        b=LS8n9Clg4oaJg5bvJ7M3Lgbn75Mgeq6uU4okuWdsmf9kNF+RYmUwEp4VvD08QesYQX
         xp1EoEBjU+POBI3v1oTrP+KogbBNR1G2fom7RWXwxvIg8lYjNukfcJvQpJkv+0cjkfVV
         d5vfjX4FT31qXvTiH/WdFKky0/chm/PViPlVVhyawfl4xXw2C10fYvdS6rNLbrRR9gj1
         347WoejpX7xRU59R02HHMgRk1xxnfq5l7XvVxkXIhccraMsXgS46mkdQPvnZyjyqvb0P
         dsskoIN3+lUNsrY3IZCEu910UtQsGecw78O+fGqnFLnI3jy2ktZVFd2CyaTWZEOwXR+P
         YYGw==
X-Gm-Message-State: AOUpUlFatuBoiDX8HRD7cjZYmreZbgQh8EKHOWwTSGivzFl2r/55NaIy
        5OP1G7+FI0AsL/AfGuNiSCwnXKkImFmw2DT5clBA1Q==
X-Google-Smtp-Source: AAOMgpcqzPG5s8wnH9y0jNEdLhVMLL1P/yepZcNHMq5utXo8dN4cklXKY2pPWFRygnSKVlimoTR1UlJYxIltVzdh+KU=
X-Received: by 2002:ab0:4364:: with SMTP id k91-v6mr9828541uak.46.1532376546840;
 Mon, 23 Jul 2018 13:09:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 13:09:05 -0700 (PDT)
In-Reply-To: <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
References: <cover.1531531808.git.collinsd@codeaurora.org> <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Jul 2018 13:09:05 -0700
X-Google-Sender-Auth: 43ZwUjHa8EzenPmp93OMzt-LtKY
Message-ID: <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To:     Mark Brown <broonie@kernel.org>,
        David Collins <collinsd@codeaurora.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, Jul 13, 2018 at 6:50 PM, David Collins <collinsd@codeaurora.org> wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++++++++++++++++++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +++++
>  2 files changed, 196 insertions(+)

I know you are still looking for time to review the RPMh-regulator
driver and that's fine.  One idea I had though: if the bindings look
OK to you and are less controversial, is there any chance they could
land in the meantime?

Specifically it would be very handy to be able to post up device tree
files that refer to regulators and even get those landed, but they
can't land without the bindings.

If that's not possible then no worries, but I figured I'd check.


-Doug
