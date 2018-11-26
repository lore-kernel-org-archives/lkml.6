Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589EBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F52320855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBBWHpt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F52320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeK0FdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:33:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0FdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:33:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so20050314wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHOdq4lualx1rGOBVWcptA21DhoiHiOyMsMnk/QCYJ4=;
        b=CBBWHpt3ZNGWamjfbR2CGjNXLiK8y98dNwum8d5ce2UmXZQqd/wVxZfEGAAXEX7S50
         q/2TY9A/s6voqQo0QFVcQ3B9pwHiNuENvO76N4vAUyNfQZonFsoFMWZi2JyMZsYsMoTq
         uW9BZeqqvK96CSiHK0vJNItWFhDQXw5SVMta47/U10ZZ/lSA3bwhPfQbIdn7wW0PgZ3h
         3KgGpCtbqOjUbnfeHhkFyeF31EeDiKquHVPK9mCb65GEmFyQezMC6XTvzi1ickA3h0DO
         j1rcyEE77+5nhfqXUkBoN+oDjTTA7FB1/6QT5izj++f9NfyiCxTQjBqSs1UUOec6VekK
         /ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHOdq4lualx1rGOBVWcptA21DhoiHiOyMsMnk/QCYJ4=;
        b=mskOuhckxZSu5UfoYwf363KNU2IsYyiztH/gU/q4Bf+4ZUxsOdb0WmAmhT/TInMJWz
         omZ5eAriKDL5+Lrbm2Oya/Bs0S0FtPGFOydXz3eTwXWI4MwG8pm0aWP5WXTMfx6lcXPC
         mLOzARXcQaT5HVcwxqRrDQstqrjiGeIQQVx13GiIe2hYo52hkYrNpKOtQBnuvf0+uRLL
         yUNOVm/QKUHUTaMD3H/OqooMfTS3eyBEGE5aEbtqJorPbdFcNeJhs693P+UWlxrb3dc9
         wpqRJe64kt7RoiKkvQH+0IkYOYy3CRAZ3sPi40d1tiRVL+VtPqYfvCzTyIw6DXhb9lzn
         ak+Q==
X-Gm-Message-State: AA+aEWalsAlb3q2R34tbIdPnv19IwSxiZPg+xcOWET8oOrc9z0dMI8U3
        tyBVLyiOcTiyyzPK7p4Va3tjTWNBT+DRlzxI6Uk=
X-Google-Smtp-Source: AFSGD/UsDWePGF3eJ6NOsootPYDFUfdq+HxvJ1AEVk6cF/kOSoqibiyr/+xWeCGod5oW8JtehYBA75y6jYAOzb6syH0=
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr17208727wrg.52.1543257497401;
 Mon, 26 Nov 2018 10:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20181117181206.10267-1-andrew.smirnov@gmail.com> <1542636653.2508.8.camel@pengutronix.de>
In-Reply-To: <1542636653.2508.8.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 26 Nov 2018 10:38:06 -0800
Message-ID: <CAHQ1cqHSNMMMcgaL1dBZxFc-h_hGSQpCZo6x+dwcQmqz9UP9dg@mail.gmail.com>
Subject: Re: [PATCH 0/3] GPCv2 support for i.MX8MQ
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 6:10 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Andrey,
>
> Am Samstag, den 17.11.2018, 10:12 -0800 schrieb Andrey Smirnov:
> > Everyone:
> >
> > This series contains changes I made to add support for i.MX8MQ to
> > GPCv2 driver in order to enable support of PCIE IP block on i.MX8MQ
> > SoCs (full tree can be found at [github-v0]). This series is _very_
> > preliminary and by no means is ready for inclusion (it also has some
> > unmet dependencies).  However is should be in OK enough shape to get
> > some early feedback on, which is the intent of this submission.
> >
> > All other feedback is appreciated as well!
>
> I've already sent out my version of the GPCv2 i.MX8M support on Friday,
> but for whatever reason missed to CC you. It's unfortunate that we now
> have 2 slightly different versions of this on the list.
>

Well, assuming first come first served, I am guessing this is your
adventure now.

Thanks,
Andrey Smirnov
