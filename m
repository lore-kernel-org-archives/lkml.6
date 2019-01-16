Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C498C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0327620873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547665352;
	bh=J9sR3hR/eMoiUT4UKUr7fq1T6PyLVac/imBYPkjLk0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X0IXlJEFeIQytA8nJKNO1g1j4FL1Y0g/aIpCT9jC/VlUiFC+ffPRFYFiwFXkct6Q5
	 eVU9ORMFYZkVGLqqJZVfXOXBLCVkEOrzAarn3yS2Q6tEJEJ9dRsca3kCarf7AmNkwf
	 wJW/WOZEbJJpeW6cCSGQ+m5UwlF/lF7CvlxJEnmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAPTCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfAPTCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:02:30 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E78F20883;
        Wed, 16 Jan 2019 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547665349;
        bh=J9sR3hR/eMoiUT4UKUr7fq1T6PyLVac/imBYPkjLk0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZAcm6/gEWnyTn1Wnjq7wJWxAXzTkmCqO0LRSAWvZwpRiI7F0z5azc06OP68+Gg7G3
         Tgid3K3Hf919qD7VCEVkUf9Lqs5gsNO3pAxshN9+LPzbLNWhv26Vokv8GTaHKvHy2N
         MuWYOzLVf3okgbRn5cwkWjoBs8HVfmbXxQRvHbSk=
Received: by mail-qt1-f176.google.com with SMTP id i7so8420110qtj.10;
        Wed, 16 Jan 2019 11:02:29 -0800 (PST)
X-Gm-Message-State: AJcUukcikHCsr6TtKN09fh71Hk8gIbdTkMWmyJ21sR3et5iIjXArB9Fh
        mePYM1OsbzxOjLg0T0Bsyl8fk+ijGNqZbPzALQ==
X-Google-Smtp-Source: ALg8bN5WJIHLM4/ai0prRwf544e5iT4/SbrSFQTWB1ILnn1xTHytoQ0Lhzm4U6St8PGzIr8tsLzfx628QwDLY9/aAHM=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr8284743qvb.218.1547665348477;
 Wed, 16 Jan 2019 11:02:28 -0800 (PST)
MIME-Version: 1.0
References: <08ea3e964c337df6ef532ac4586f488edab80048.1546991072.git.ottosabart@seberm.com>
In-Reply-To: <08ea3e964c337df6ef532ac4586f488edab80048.1546991072.git.ottosabart@seberm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jan 2019 13:02:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK_oHtYxCh+9yF11XoPoEVQ7yakyDDG-OJfQMgYhC4yWA@mail.gmail.com>
Message-ID: <CAL_JsqK_oHtYxCh+9yF11XoPoEVQ7yakyDDG-OJfQMgYhC4yWA@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: bindings: fix bad reference to ARM CPU bindings
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 5:47 PM Otto Sabart <ottosabart@seberm.com> wrote:
>
> The primecell.txt and cpus.txt files were converted into YAML. This
> patch updates old references with new ones.
>
> Fixes: d3c207eeb905 ("dt-bindings: arm: Convert primecell binding to json-schema")
> Fixes: 672951cbd1b7 ("dt-bindings: arm: Convert cpu binding to json-schema")
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpu-capacity.txt          | 2 +-
>  Documentation/devicetree/bindings/arm/idle-states.txt           | 2 +-
>  Documentation/devicetree/bindings/arm/sp810.txt                 | 2 +-
>  Documentation/devicetree/bindings/arm/topology.txt              | 2 +-
>  Documentation/devicetree/bindings/display/arm,pl11x.txt         | 2 +-
>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.txt     | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

Rob
