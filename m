Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B726C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A39B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UdEvaT6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfBZGOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:14:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43460 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBZGOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:14:07 -0500
Received: by mail-io1-f65.google.com with SMTP id y6so9597240ioq.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAGfwsuWOjEyNn+5oq6Xgc7y+OhDDkQ6tGalsuizZrE=;
        b=UdEvaT6nWFT4Oz9piC5gvVNxPrm0dc1E5w2j3qgSfCJz+xGJuw46HgyH+P0tQGztmr
         6D6bU6gVdHpEy+FGw/xMjP7+zxpwErPtj8ID4A4tUnZ9ycRTiQKPtGxyrTT6nPwkG0c4
         fqeg834ZYS9BEuBGjyKcQP+y/6BemwqsmeMLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAGfwsuWOjEyNn+5oq6Xgc7y+OhDDkQ6tGalsuizZrE=;
        b=V2b9hxcgkm8f/ivLb9fGkdCadEEcf8CoQx7ijRGI5+yOcg1U1DM/O3MpCfGZb+ipcv
         ukdB5Lc3PnxIoxdTbJHZSBRqIAbT+HrF39ZfKFlRdAtk84IwdjUiOBhrMbbTRkStOW57
         nJdG3UpvuIBa1ikaudUx4W34k9oeMnjyoPeQ70JW2j8WZBlVJLYYJ4YyZx636mcb/N1A
         6QRGYhr/tx8CsnRZSn9JL246R7B+/hTV981Fzb7eAmkTtLLhRayKupLozv0A83oXpXZ7
         nqKvLKwqznK9H7dP1tc5y8M/pyXfftHHOnXdFfEy1w8PlzRRvYYca2HLCF7FV03ZpKbN
         p7Lw==
X-Gm-Message-State: AHQUAuZ2dNhKVOPKdvxnrUMcLqPcFc647J1Etaix/4rmVKyL+1NdBwM+
        +yARhGV2siexKTgfzdsz0OkKdLRWPAi2ouv8Mga9+g==
X-Google-Smtp-Source: AHgI3IbxDzIrpanJ2+YaAl7qKk6oCLYLJx9jYazZXu2cehlgG0COiIJkfxFvwVfNVzphy0m5VBInp3fwF1u3tG2+VAI=
X-Received: by 2002:a6b:b790:: with SMTP id h138mr10880686iof.114.1551161645885;
 Mon, 25 Feb 2019 22:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
In-Reply-To: <20190219101629.15977-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 26 Feb 2019 11:43:54 +0530
Message-ID: <CAMty3ZDpy5YX3V+6e=UtY=a9Lgiw-NEP1JPQn4_LKL3mYFtrvQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] input: touchscreen: Add goodix GT5553 CTP support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Feb 19, 2019 at 3:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> This is v6 patchset for supporting goodix GT5553 CTP. Here is the
> previous version[1]
>
> Changes for v5:
> - document bindings for required regulators, which are need during
>   power-on sequence
> - enable, disable required regulators as described in power-on sequence
>   using normal regulator calls
> - update the proper commi messages
> Changes for v4:
> - document AVDD22, DVDD12, VDDIO as optional properties
> - use regulator bulk calls, for get, enable and disable functionalities
> Changes for v4:
> - devm_add_action_or_reset for disabling regulator
> Changes for v3:
> - add cover-letter
> - s/ADVV28/AVDD28 on commit head
> - fix few typo
> Changes for v2:
> - Rename vcc-supply with AVDD28-supply
> - disable regulator in remove
> - fix to setup regulator in probe code
> - add chipdata
> - drop example node in dt-bindings
>
> [1] https://patchwork.kernel.org/cover/10816901/
>
> Jagan Teki (4):
>   dt-bindings: input: touchscreen: goodix: Document regulator properties
>   Input: goodix - Add regulators suppot
>   dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
>   Input: goodix - Add GT5663 CTP support
>
>  .../bindings/input/touchscreen/goodix.txt     |  3 +
>  drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++++
>  2 files changed, 63 insertions(+)

Let me know if you have any further comments on regulator patch, fyi
Rob reviewed it already.
