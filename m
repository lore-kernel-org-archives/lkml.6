Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF43EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548EE2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D91UAdzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548EE2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeIFFKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:10:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45376 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeIFFKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:10:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so9416648wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qW/LP2qYlFpItMwBZQEls8h5Jq8RZdvDdQB2xyA8m/4=;
        b=D91UAdzdA+89BdCHfd01q2jYzln878WaFyamxr8QU+O34Lv01MIHKpUa9XH4ad+njA
         y+SdDdyJFsvxAJuNCgLgeJGyRaJff6v8T7YjSoRC2jy03S/dFSoQW0KpE0g6mCA5uT5C
         bBHaiz3LqILLzR2EaCcqrv11klszyrJnnB2M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qW/LP2qYlFpItMwBZQEls8h5Jq8RZdvDdQB2xyA8m/4=;
        b=k4LiZSnneYEF4ipNWBu3E99Zi0esQzblc1d01XDXTBOnikjJHB741g2Yeub4dYrLO9
         hyxKURjwvk/E7fM5FZ4Operyvov9fLE9sZCGIv5KBmDyp2uuw8wvdSBPMzP8sAbRH75D
         tbpPomFlb4XNWVTd29xUalOStZwIf5w7f1LN403AkXdXiHcJ4fwlYyhk3J5o4nooaP1a
         abfZKAecCRKoHl+VfgZJTpbbN45IzS438SmXlfHoaav9F2u9XqOp+0E5p1yOvlkVIQU3
         JC7GbMOfEZDbZOCtVomMmpS7yMCtFoQQiNp+wFjINW+LYAqIVq/hW2pTpr4VVsxyTW9S
         HFWw==
X-Gm-Message-State: APzg51Dp1hZiZjGXo45LewFd668U4COT663+zZ/3uWCCQVgMFeHNZOqt
        1ctMMzyrhQ0SlvCMRUGVqOcIo0vz4Wg3pXvwmIY13g==
X-Google-Smtp-Source: ANB0VdYIJk21GRiV6/wz9l+VNH2i2/Yxzvw/kzk+HeIJG4+C9hjU13kJ1ezwlim/Zs84/9NaViBAGFrsAfOJwDnHi9w=
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr185712wrf.206.1536194281911;
 Wed, 05 Sep 2018 17:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <aab0c4b467f69c693ed1e24e9fc47ba20b3f9f4a.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <aab0c4b467f69c693ed1e24e9fc47ba20b3f9f4a.1536138304.git.ren_guo@c-sky.com>
From:   Rob Herring <rob.herring@linaro.org>
Date:   Wed, 5 Sep 2018 19:37:50 -0500
Message-ID: <CABGGiszyQpJCB+QAoYwNwsDAhgdWQ3Ud1eR7U1xh9BMYzMKzjw@mail.gmail.com>
Subject: Re: [PATCH V3 18/26] dt-bindings: csky CPU Bindings
To:     ren_guo@c-sky.com
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 7:08 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt

Please make sure DT bindings are sent to DT list.

Thanks,
Rob
