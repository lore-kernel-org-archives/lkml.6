Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340D7C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA79C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2UhK/5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA79C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJ2WiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:38:20 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:42961 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeJ2WiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:38:20 -0400
Received: by mail-ot1-f46.google.com with SMTP id j3so1758173otl.9;
        Mon, 29 Oct 2018 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJ93arSwY3/qv0PvD395uTpM5/vKjRrCYpDWhkLHETU=;
        b=A2UhK/5Oa9Sv0y+2TWaDbzfbAQ9obFCZsZfcj/RAOKAZ8z4a4Doz2C1xOgER29m1iQ
         0OEdte3BaS5atXAXmpBmQRC8OiIY80Pwjqgafb+vrVXTjP1npnzlOjGPkkD9DEKOo3wJ
         DRvoKPCfpYGae89jf9II8AG7GyYXu2xM1OgetM673YDS38VexyDyYYosnNCB0brPQ4X2
         lD3Utk2FCt5npdTJ0FKRRzZr0tq5JM5zsKQAArAcgAWXeYxWZAbOZop3tYgmYTsucO0Y
         /jw5Q84k3ZPQzC1v6z6eoa5B1mbyVZE+5WbTtGv8QFTsKhAX1+Ob2jcwulvAUNlQkY/8
         b4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJ93arSwY3/qv0PvD395uTpM5/vKjRrCYpDWhkLHETU=;
        b=bTCAIKJuO2+CODBorG7r/5T0ozZLUuKUt1gCkwRrOKxHrpN9YwcpxgVT+fN9wR9kGH
         pv4bLpPwpLaX5/QjO1czgImBTbEDS2yubQ6PSlq6uc10ML4uEUdqrd0VhEQIQv6qZqOM
         u9P+ZatqKWItd8Q9UXuwP7ZsdThCpbip8ql4wHQdztn62f/RPKfM+OlnhBcZg0noVR7t
         +1VejDVfkHLUu2PHrc9FZgNK5UXqgK0i9cpBUrHZ7PQ2svT+qNS5M5OjiWtz6LrOCYIB
         y+z1uV9yd9o1ipkeASYQVHq2lG7Z3mRABPGtTgl1UuLVxKeyEUb0nIXIXVScRzXs93u2
         I5gA==
X-Gm-Message-State: AGRZ1gI4xZ8yX0LHA+tECC1+K5NCPS1JP2tBjKD3ZEqgoJR/xq4YlmWU
        lzk5irUtzjBkItUs/il4R2hwzgqzfXpUA9yBEDY=
X-Google-Smtp-Source: AJdET5cfCwe25LIQ1tHZ3hxhGdiIla0zFKB/hy/QTUW7nzMZWlJGP3pVEcw3ES/lfLybDleptbe0qiv3CR1Zrw91ars=
X-Received: by 2002:a9d:437d:: with SMTP id y58mr2267793oti.287.1540820974251;
 Mon, 29 Oct 2018 06:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181022113306.GB2867@w540> <CAHCN7xJkc5RW73C0zruWBgyF7G0J3C5tLE=ZdfxTKbrUqs=-PQ@mail.gmail.com>
 <CAOMZO5ATm4BRzPEQOU+ZD6bHCP2Aqjp4raRYhuc+wNe0t4+C=w@mail.gmail.com>
 <CAHCN7x+csKEk25CF=teUv+F5_GoTe6_3Yqb5PODLn+AmCCm88w@mail.gmail.com>
 <d78877f8-2c23-2bf0-0a9c-cd98b855e95e@mentor.com> <CAHCN7xKhGAXs0jGv96CfOfLQfVubxzsdE9UjpDu+4NM6oLDGWw@mail.gmail.com>
 <bc034299-4a32-f248-d09a-0d1b5872a506@mentor.com> <CAHCN7xKVUgpyCb5k7s0PNXW-efySSwP25ZGMLdbFnohATPwKhg@mail.gmail.com>
 <20181023230259.GA3766@w540> <CAHCN7xJaY_916OLHvaN_q1FwM2vqH5UXzVxLAS4DuEV0icPUXg@mail.gmail.com>
 <20181024140820.GB3766@w540> <CAHCN7xKbAuTmic+L-a2o1NreSCmYBKzzvmHuUTGZtVHELFoirg@mail.gmail.com>
 <CAHCN7xLP13PDT_VhV_iQzRB+VS7N4AxY+BObtLpz4bJ6RfxfWg@mail.gmail.com>
In-Reply-To: <CAHCN7xLP13PDT_VhV_iQzRB+VS7N4AxY+BObtLpz4bJ6RfxfWg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Oct 2018 10:49:41 -0300
Message-ID: <CAOMZO5Dkwrv4k=KGit+4wFFSr=ec94OpjUW56_D_aamjNPQH6g@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     Adam Ford <aford173@gmail.com>
Cc:     jacopo mondi <jacopo@jmondi.org>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Discussion of the development of and with GStreamer 
        <gstreamer-devel@lists.freedesktop.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Sun, Oct 28, 2018 at 3:58 PM Adam Ford <aford173@gmail.com> wrote:

> Does anyone know when the media branch get's merged into the mainline
> kernel?  I assume we're in the merge window with 4.19 just having been
> released.  Once these have been merged into the mainline, I'll go
> through and start requesting they get pulled into 4.19 and/or 4.14
> if/when appropriate.

This should happen in 4.20-rc1, which will probably be out next  Sunday.
