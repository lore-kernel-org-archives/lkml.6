Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C05C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95DC2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfBTO03 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:26:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34315 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfBTO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:26:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so26290843wrg.1;
        Wed, 20 Feb 2019 06:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iqbZ6SOvJVLW9ahCsACBtF6RPfSiZozNUarfAFIeCCc=;
        b=InZa4iRsFyb2s5gHd8HHc9qAugxFlLOhFgLVknjWmHQxpRchh2jgaABFNb5gQ357lf
         hj1lu0gzVrpUxtk4oo/8dgDV62pQVbwx0fCKz9NNpAT5qEICH+tP7Nqxs2ll8E6hEp7V
         dudGzvdp69mayJKWJilfompaNgecLqB4MisSdJpQjcjBiaOHYL/LBzxhYKUl9usJfn1b
         Gf46NvMIUtiQ1jLCtR40b+qg8N7GfI4gd2eaGdGkDceICk/HsE7S+P3axzkEcPbGpwak
         pq80RjrNv+Gtv6MdqtVK7xeA1Ww0203fmUGIQja/cO9bA7n0RmLZ3ljhCzRgrCgpiyxg
         j93A==
X-Gm-Message-State: AHQUAuaYv1yJSpL7dY/NVCRb1xQ4FoeTi6sQRWj73DAixDYs3mJavZBn
        3bcdK6mm3347ZSbz8DeXFEfeCPuXpeooT0vwhyA=
X-Google-Smtp-Source: AHgI3IYYYarY0qaQIu11oNCsNZJkPRnfMjfmjkGJsPvJ1mu1UrkvG21ek1Q2+Re5PFaKHWSenOBPDS/n932Al5iV4/s=
X-Received: by 2002:a5d:5042:: with SMTP id h2mr24742142wrt.12.1550672786290;
 Wed, 20 Feb 2019 06:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20190216151826.11584-1-tiny.windzz@gmail.com> <CGME20190216151918epcas1p25c2971b063cc66981fda6a67a8276585@epcas1p2.samsung.com>
 <20190216151826.11584-4-tiny.windzz@gmail.com> <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
 <abb56481-0cc7-3d31-2dae-ba602a423811@nvidia.com>
In-Reply-To: <abb56481-0cc7-3d31-2dae-ba602a423811@nvidia.com>
Reply-To: myungjoo.ham@gmail.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
Date:   Wed, 20 Feb 2019 23:25:48 +0900
Message-ID: <CAJ0PZbQ9sP5Kfkzn-kFQ2NCdxEk1fRB9WqrE5XD50K9F31ymag@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 6:58 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 18/02/2019 00:38, Chanwoo Choi wrote:
> > On 19. 2. 17. 오전 12:18, Yangtao Li wrote:
> >> This variable is not used after initialization, so
> >> remove it. And in order to unify the code style,
> >> move the location where the dev_get_drvdata is called
> >> by the way.
> >>
> >> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >> ---
> >>  drivers/devfreq/tegra-devfreq.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> >> index c59d2eee5d30..c89ba7b834ff 100644
> >> --- a/drivers/devfreq/tegra-devfreq.c
> >> +++ b/drivers/devfreq/tegra-devfreq.c
> >> @@ -573,10 +573,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
> >>  static int tegra_governor_event_handler(struct devfreq *devfreq,
> >>                                      unsigned int event, void *data)
> >>  {
> >> -    struct tegra_devfreq *tegra;
> >> -    int ret = 0;
> >> -
> >> -    tegra = dev_get_drvdata(devfreq->dev.parent);
> >> +    struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
> >>
> >>      switch (event) {
> >>      case DEVFREQ_GOV_START:
> >> @@ -600,7 +597,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
> >>              break;
> >>      }
> >>
> >> -    return ret;
> >> +    return 0;
> >>  }
> >>
> >>  static struct devfreq_governor tegra_devfreq_governor = {
> >>
> >
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >
>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>
> Thanks!
> Jon

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Merged. Thanks!

>
> --
> nvpublic



-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
