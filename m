Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208FDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98FD213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+QoEsnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98FD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeHVCHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 22:07:30 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45501 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHVCHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 22:07:30 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so34955656oic.12;
        Tue, 21 Aug 2018 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JNufvX4YiVBjIU7FCFp9+wzeWVY68Er8U2mB3Q8ALM0=;
        b=L+QoEsnMHoVVKYawjEJ7Wz/Nlos5lWuD6FrqMJA239B5F7Y9/GfOS59I3lHH6MfqEr
         KGrOBjOVd3ClCYJIw7U2PTqFtjdw09lPOmoTF2XNlxxbuiqL55APOhGDjrjlDikxYYal
         UlLPyqcE5BS3QdKghaxmRBXBZ+iE7p7rsyzPRtTQARl55ePjVODDBW85kZQfFQDdu+sU
         2NmA/hvvOYuNv4P85BRjoTGWOAZUOt5/P7kdDK1Fat2QyxjywBGIdtgRVGHvb+w2nG+G
         aQ6ZemqlYcNOiMAlp9cM3SK0zBCGo0aKOQVGKSM1FHg/ta5wuZOS9pMWF+lvchrgXjDj
         FTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JNufvX4YiVBjIU7FCFp9+wzeWVY68Er8U2mB3Q8ALM0=;
        b=YiKD10/CN6zn5zLuOsbhzFZEipjW1oQQ9hNfY1xSSDV4dbdwO8lH8NoqI5uSo6HIf8
         3xrCVXCUDQiOMvFvoOTwAxF5Pz6PuJLnvCk1IxQ/9mUM5cfejWl8zLIkWQ24mT/cT7EE
         6O5zYZMNJ4Vub/YxwSvZqu8aEyAU+V+xmIbelSuDyAIdfI917E3pBUbcKS2zZBqY2WJX
         JqdAwbKAOgTVkos6I/zRCdDIFk6u8kOUxq68D0+wQbHIG95OY7cWb1uyX+py6cE2msjY
         SYdN/wHmWdxtfit1W3mjk7Kz6zYxRnr4hiahjKdAGWA/g4jU8Z6kej0RhvZmhcqQa0vT
         uhDA==
X-Gm-Message-State: APzg51DlnCZcK1Jw2sQrlAHdmjxkltVqo5QC1ulLC3GEZGaoc3NguR99
        Pnr6i6sUahCKu/8HvnJJSt4m3u+bLPxosA1AJD1QeWQb
X-Google-Smtp-Source: ANB0VdZOcAlYSQuijYo2TtbuXbu6ecK09kiu/RSMMt4Ln/BhOMyWOLsGxZnMQ/YFFj9vUbE9U5KCE1gX6Lu/OPxsa0E=
X-Received: by 2002:aca:d986:: with SMTP id q128-v6mr1267086oig.349.1534891525084;
 Tue, 21 Aug 2018 15:45:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 15:45:24
 -0700 (PDT)
In-Reply-To: <20180821220233.9202-6-wsa+renesas@sang-engineering.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com> <20180821220233.9202-6-wsa+renesas@sang-engineering.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 21 Aug 2018 19:45:24 -0300
Message-ID: <CAOMZO5AkVNiYMGdED9erL=YMaKcmtS5BzZxw2gO1KLXEaPnD7A@mail.gmail.com>
Subject: Re: [PATCH 05/11] can: rcar: use SPDX identifier for Renesas drivers
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Aug 21, 2018 at 7:02 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> To be applied individually per subsystem tree. Morimoto-san, could you maybe
> ack this with your Renesas address?
>
>  drivers/net/can/rcar/rcar_can.c   | 6 +-----
>  drivers/net/can/rcar/rcar_canfd.c | 6 +-----
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
> index 11662f479e76..051bf4ef4be2 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

According to Documentation/process/license-rules.rst the format should
be like this instead:

// SPDX-License-Identifier: GPL-2.0+
