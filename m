Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFC2C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EB520839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EB520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeILT6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:58:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43020 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbeILT6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:58:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so1998002edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxqJ5dO073NuhRnEqqvV+T/a8MYpcXhfTdWYM38yunU=;
        b=UfQShQR4B9DAE7ELpdbg5VHYeRjBaP0bn/a6wArXT86WNdQualcl3EehL4leyXRsND
         +skCKUVuQu+p6Uo97QoyU4Ind/KWUfVbXkIq8e1X5XBCgXsquH8NtVqNM8hTHQN8v1No
         r2NEdlIeGz87Av31qsFX8gUYCcyaIS4juwzItgb8EQplZ3HBUj+ePtlkR7bmNQaZHJtZ
         6BkupJVpv4MidJoPdv4VAIg1QNZB1cSxC3k0tHnOJ61eXMKOi8wVUD9DkFz2cyVi6IbU
         9QcKOBXev88lZ0+DsYoLhMKjTEmBctufbaX1I/yWgxLTzlHqznNIHr1EZCM6gMocpc2d
         94XA==
X-Gm-Message-State: APzg51BAFjNsZxCJsCYSHqppAQAzPiVd84+4GWfDop2u+ZNPtsixZDeN
        LrRXFRwC72r1JjDiJxsEPBQ96c4CRZ4=
X-Google-Smtp-Source: ANB0Vda7wBReoWp1yhtZFlGkMOeJ/EXB9nwsT/w7Sa/2TMtzxHk4uU7Ga0tLElnsAgHvDROfJEmt9Q==
X-Received: by 2002:a50:bdc5:: with SMTP id z5-v6mr3165076edh.46.1536764041331;
        Wed, 12 Sep 2018 07:54:01 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id m42-v6sm634437edd.46.2018.09.12.07.54.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:54:01 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v17-v6so2371159wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:54:01 -0700 (PDT)
X-Received: by 2002:adf:e486:: with SMTP id i6-v6mr1958326wrm.145.1536764040990;
 Wed, 12 Sep 2018 07:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180909190439.20425-1-contact@paulk.fr> <20180910114311.6fw3iwend3js7mcf@flea>
In-Reply-To: <20180910114311.6fw3iwend3js7mcf@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 12 Sep 2018 22:53:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v658HmGX0WfoDR_uv7+SFigchOtJAOU=VrTgFy5aAoV1HA@mail.gmail.com>
Message-ID: <CAGb2v658HmGX0WfoDR_uv7+SFigchOtJAOU=VrTgFy5aAoV1HA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drivers: soc: Allow building the sunxi driver
 without ARCH_SUNXI
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Paul Kocialkowski <contact@paulk.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 7:43 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Sep 09, 2018 at 09:04:39PM +0200, Paul Kocialkowski wrote:
> > This makes it possible to build the sunxi SRAM driver without building
> > for the sunxi architecture. This allows selecting the driver when
> > building the kernel in testing environments.
> >
> > In particular, this is necessary for testing of the Cedrus driver, that
> > selects the sunxi SRAM driver.
> >
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied for 4.20.

ChenYu
