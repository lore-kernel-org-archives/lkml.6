Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9649AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B606258CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC/FerZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B606258CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965907AbeF0RAP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:00:15 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33606 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965299AbeF0RAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:00:13 -0400
Received: by mail-ot0-f194.google.com with SMTP id h6-v6so2980739otj.0;
        Wed, 27 Jun 2018 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=okXeCmqFDyacHTrF4ppFbJwlkLhH8Jtb996Wi/IJfhM=;
        b=jC/FerZtNGTvjSWUHEVvN8REi5wVJqyOiJhZM6h6BuK4OOvN3tQvrY7Q8FWYZm2Jng
         erPnA1n3mTGor9BDtUxm7XXvQIqM9IQxZEfuO6EfYTcqfdIn44r5VkBFyoeGfacjz5ig
         1fqln0ytd4m2R8xVZls7sX/7dmT3klMD2IRzFsUf8XKC0yGju4pLy0AxTr8xdqu8d/Ra
         OzekTzosZSpQbqvF0V4+BNItpLRVUxkneh2WnaGbkxFdzhy0kiBm5suQqz1M+3UWWd+t
         76IzEvNORmdBuX9ssyUH2yhJa7uaVlOmQNqehrjX2mzqG7A4kNW7LS8/MmKRiDpyUXfL
         Gv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=okXeCmqFDyacHTrF4ppFbJwlkLhH8Jtb996Wi/IJfhM=;
        b=AhbMnMHe0pFUF9P4PNmKOvX8McVF7S43IAhAS+MTPVyeMpz3E1DAjARPYiCswc4/ID
         TI6E1lxRdF0eNrB6iM6+zS6NOaao/B+dqw/YJvtUeXF67B5BHmkMMXoAYwyBrGkFsfKf
         RVX/qdIg9K9KSiTkRBx7tcw2SAHwfWc1NSyVdZRkX4v42G7TuzlFZqeQmxn1RZIREPYn
         1PhBtAItoluBIR7GO5SiFvARNPy+NSVJFaM+TLQOwRb+KQpwXwu8nb84FhS6HCWQ7lsp
         dk+eRHhlxgBGeFCgWJJP+j2oWmO2SZzxokTez/G8gC5inu7cwgrEIFoH0tQdaZYDgI4C
         B9nQ==
X-Gm-Message-State: APt69E1fLSnnShjqyNp138gcLxl+jxImNMzn4VIAko1k3YEX8+3F6WWs
        fcuiFsU5qc+OWqKS1HGD76r0BDBVQ0P/w5eJrUI=
X-Google-Smtp-Source: AAOMgpfuUMxZjJ8iefzjpx/JOH2ig+kzcDUZnrEvCIo7STf3lRYefhdl3AXsDS7C985/1qG61YcsgFJ3nl4hztgtRcU=
X-Received: by 2002:a9d:6288:: with SMTP id x8-v6mr1570303otk.159.1530118812187;
 Wed, 27 Jun 2018 10:00:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 10:00:11
 -0700 (PDT)
In-Reply-To: <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
 <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru> <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 27 Jun 2018 14:00:11 -0300
Message-ID: <CAOMZO5B5PS7a6SFfzX915AkRoDpeFVV7P0hrG9A51yWRFy5X_w@mail.gmail.com>
Subject: Re: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     nikita.yoush@yandex.ru, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 1:46 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> We are now starting to give Andrey Gusakov conflicting
> recommendations. For the sake of moving forward, can we agree that
> this and similar comments are relatively minor and defer to the
> maintainers to make a call which way to go?
> This way Andrey has a clear way on how to move forward with this set.

The approach in this patched looked fine to me as well.

Maybe we can have some feedback from Shawn?

Thanks
