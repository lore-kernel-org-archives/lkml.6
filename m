Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA74C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E4E2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJnM2xae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfATJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 04:54:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40048 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfATJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 04:54:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so14359211edr.7;
        Sun, 20 Jan 2019 01:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6cNL5ToUtCNsr/CKvfB8RhbwkcNkmposyYLF5WsXX0=;
        b=qJnM2xaej1cC9JT9+UKiqJjCSsp4yBGQoNBjPHFoVNieeUD3xzNrffnXbuz5cGZBP6
         Ffa1aB5UbjsniPG9KlXUGRv04Cq6D+7U4w/WyMAxordNxBByySOfZgzoczWAG5T6VLip
         MbC8bK84rqf3MAW3iAXo+fbXWvfc854+pWI5lilzn6+EMdSiz8LaxBm+2s9kwiq80HmW
         Xi89C9DevR/UHbJbmrbUQ75+y1IxFxPnR75wJIAtifmSHBkymdFC4AOCIA0zxgdo4sma
         +KLzB9wtzpSYReKPJxwZuaK7UzUkWbASXFlG198g8mj8VG80JCVVAqHQlBKRuz8Wva8q
         k1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6cNL5ToUtCNsr/CKvfB8RhbwkcNkmposyYLF5WsXX0=;
        b=KLjx+nByIT374wqv76878ZCwM/LnR2vwkQdAovsN3cp6tepyKzNTOv5Op0Lg+Ucqa0
         WHssJyU9RM0hdVQWGr430YyqYx33Yz7LHDXseo10X3K00Z7UmwgdsYkScQPGr5GIeb2f
         dsDMkeckoKtKhlB7g4CAyV2B3yODvt54bZJgkeMrzvKA0bHMlmx5tsTtWvW50DUfZl90
         42AK/IW8KiD6aJ2gW4r2P5DENcR7vOCviBZUICbgcbFwlNv+ZFXwVv5v7OjhFMm1qTi+
         05MBP5vVEThtMNbXrIbXkUU+RkPcLaz9Qpmkx44z/vd/ud01TYP0JW5Ara5DwXtwN6Ai
         oA8A==
X-Gm-Message-State: AJcUukeC0EVuOHJ5IicTfn0DCxsv1Yzerc1PQCKMm1SsAg6WTFav9lEu
        lPlcj3JEk9k6ucnJ4z2GbyC5oqwYUstggALnAcI=
X-Google-Smtp-Source: ALg8bN6nxxziJ1hdtrCfwWxbX5KkBx4SnU3osNdATcCywXqHwZw05R8ZpHnnqCjhMezeffvHH3GTrjSVXQGQcC1sjFA=
X-Received: by 2002:a17:906:a4cf:: with SMTP id cc15-v6mr20897762ejb.157.1547978079939;
 Sun, 20 Jan 2019 01:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20190120023150.17138-1-angus@akkea.ca> <20190120023150.17138-2-angus@akkea.ca>
In-Reply-To: <20190120023150.17138-2-angus@akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sun, 20 Jan 2019 11:54:28 +0200
Message-ID: <CAEnQRZDzvmn-6YyoQRrWbkbH8d1ej8aFE1wFAiXQtqzHxyW2eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dma: imx-sdma: fix NULL pointer de-reference
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 4:34 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> On the imx8mq I get NULL pointer de-deference errors if the device
> isn't passed in during allocation.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Hi Angus,

I have already sent a fix for this:

https://patchwork.kernel.org/patch/10758203/
