Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4AEC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB4C2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/i3Emqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB4C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeICOei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeICOei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:34:38 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F372077B;
        Mon,  3 Sep 2018 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535969709;
        bh=RQevpn1QCfqczI//G+Dyhv2UOix2Bg+qPRE5EOcamio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I/i3Emqh++YZux5KCJJFrBIpOg9JYzIY5qfBXEE5uuPPpxKU6DafQifvi6/huB/EW
         tpgk3gOWzI8g+ZZ8I9ksTvjedP1oj71FNzaxwEsymv/FvwAjdTB5120UJvNkB05HGm
         j1x6cpA+MrUREp1QIifPItcmmdBc+24U7kcNVfr0=
Received: by mail-wm0-f51.google.com with SMTP id f21-v6so579431wmc.5;
        Mon, 03 Sep 2018 03:15:09 -0700 (PDT)
X-Gm-Message-State: APzg51ChurP1c/xqz2w58rJv5ASkE1LMaUqxHaBBfY+GaCSXtRvUmC08
        qyKKVRjLhyGGhWyqTqMR4JUG8QJS7puiLpUAaXI=
X-Google-Smtp-Source: ANB0VdbOw8uC4mOd0KVkY08bc2qj3WnUs8Z3ziT8puOPCmV03DkXVmM8pPtr9yW+Mr7PaTWNs/5EJYAMH9rF8D0HT7k=
X-Received: by 2002:a1c:3e8e:: with SMTP id l136-v6mr4741585wma.72.1535969707628;
 Mon, 03 Sep 2018 03:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <a582871f84c4dd588ae1651d1d9192cc80e2b272.1535964281.git.baolin.wang@linaro.org>
In-Reply-To: <a582871f84c4dd588ae1651d1d9192cc80e2b272.1535964281.git.baolin.wang@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 3 Sep 2018 12:14:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcx1AC-xp4TPLQrzbwrPmKWK0tB2F+=e+Nb8afviABPHQ@mail.gmail.com>
Message-ID: <CAJKOXPcx1AC-xp4TPLQrzbwrPmKWK0tB2F+=e+Nb8afviABPHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
To:     baolin.wang@linaro.org
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018 at 10:56, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch adds the binding documentation for Spreadtrum SC2731 charger
> device.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Add parent node.
>  - Add some battery standard properties.
> ---
>  .../bindings/power/supply/sc2731_charger.txt       |   40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
