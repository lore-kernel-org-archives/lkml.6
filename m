Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C795BC26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9620720861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLHrbY42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfATSAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:00:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35826 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfATSAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:00:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so14911340edx.2;
        Sun, 20 Jan 2019 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRhRxCRvJbRYxqEYTBLN/3841c+efnZUM2Kebudt8RI=;
        b=PLHrbY42s+ajY40pba6eO0lD1hISGTkGCUTOjg7hmLuajQJjOE6vdguLKFHkBrQ5Tm
         p11GpNToBimbhbOvhzgjFWqliFh/V5bqYyDy+0KgRzZURUeFMLwptscXNc8KfgZEDHS7
         c43hgoGl4hcJfYnzll5nInJjiNb9/OLc3W4lSGAyL+w+TfZCTpmQ3yWTCGmzKSkgToiw
         dvQ0hWosDgPpRqnr7bhIERhhnqzdjPBnq1jrL3A6Vie4fyIrZfkOyTF6yb6LiYL7dxcJ
         F+9luDEJXWc7+GrdeCt888uPhufLhrKn3tRq6ymtYH2XlHg0UmwNMzf58Cr1IaZWNIQJ
         /UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRhRxCRvJbRYxqEYTBLN/3841c+efnZUM2Kebudt8RI=;
        b=X4dd00JXoz9PaMHtydsOHXtULrFlxEXuEbgfPOtwJxSjr0ocuhVyorqIIu6S7xVFB4
         kvxXPISd1FNRvT12QFWqd5ViL8g5PxRB0shMoIzop/WkLG3rhvpw3plhL8QUzuq90tT3
         /uX7+OEwmsCajDYbf5j0BT0tzc+RuNO6iSoNcdbhGrSzt4uOcfH+8vpZbjgMqSG+nzSp
         oO2VKaoQvL9hRCe7EuxcbNSG5J7YA7agj5tRmQsLtNO0ppEfXB9dQXNx8wutqTQhMoAC
         EwpsMFQy7wLKVEWc0Y3JH44GMnCWYseCbXuRq1umZlneT8Gy43ilgUe0erX3H5y7BlWu
         FtYg==
X-Gm-Message-State: AJcUukeKqtvHGn1R/CW1pBgdkMp8h5G9xziokRY9B6e4QuxpTBeezAuA
        RFhU0K22CmriXK5+oEXJDP7aMNpOc90l3bfkvm4=
X-Google-Smtp-Source: ALg8bN7ZJoSJqCM5987xtMS9mA4Fjmt+MUeDyNThWj6N/bNPuZHCTSu3sfoGwQZhFVJviEvDPsTchXxaEuC7opd+5HE=
X-Received: by 2002:a50:9106:: with SMTP id e6mr22957020eda.148.1548007241826;
 Sun, 20 Jan 2019 10:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20190120023150.17138-1-angus@akkea.ca> <20190120023150.17138-3-angus@akkea.ca>
 <CAEnQRZBLLKotGy2t-f3rURnoUCjkxfuwrtYkirv6+kdAzidaFg@mail.gmail.com> <6cbbac1e98b74702fc5a9b915b7630f7@www.akkea.ca>
In-Reply-To: <6cbbac1e98b74702fc5a9b915b7630f7@www.akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sun, 20 Jan 2019 20:00:29 +0200
Message-ID: <CAEnQRZCwtbbJmTPT+J1q=5UvxjwZvkcoJxY3AJgBgXiPz0L2wA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dma: imx-sdma: add clock ratio 1:1 check
To:     Angus Ainslie <angus@akkea.ca>
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

On Sun, Jan 20, 2019 at 4:38 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> Hi Daniel,
>
> On 2019-01-20 02:58, Daniel Baluta wrote:
> > On Sun, Jan 20, 2019 at 4:32 AM Angus Ainslie (Purism) <angus@akkea.ca>
> > wrote:
> >>
> >> On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
> >> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> >> to 500Mhz, so use 1:1 instead.
> >>
> >> based on NXP commit MLK-16841-1
> >
> > Hi Angus,
> >
> > Thanks for doing this!
> >
> > I'm not sure specifying the MLK here helps. I think it would be better
> > to somehow add the original Signed-off-by and mention that the commit
> > was pulled from NXP linux-imx tree.
>
> If it was exactly the same patch I would have but as I added the lines
> in
> sdma_run_channel0 I didn't think it would be right to put signed off by
> "Robin Gong <yibin.gong@nxp.com>" as the code isn't what he signed off
> on.

I see your point. I often encounter this scenario when sending patches.
I think the best solution would be to mention in the commit message
the author of the initial patch which you based your work on.
