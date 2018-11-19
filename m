Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1FAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522DD20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwPG6lay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522DD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbeKTAdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:33:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36374 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbeKTAdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:33:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so2619250lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MJhMVhosgyrpYix7xMtSztQRvF5ipcPCD/qbbZuqMk=;
        b=hwPG6layG6sV7UdNWQ5dJvC7gXsNUfDcg2KLZ5R/lIRrPtImBSL1otT0W31KeRxDeF
         z0RVIG81AWjGXfvjOfavU4nNu1nmvN1ZGTnhvlBxuznMPCMwguoeEHH3m59zsxRSjCrj
         ZKdRtcWuaxaL5kSX6fhaM1nc0iQCRiCruxN8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MJhMVhosgyrpYix7xMtSztQRvF5ipcPCD/qbbZuqMk=;
        b=tYRasJTUS+h0I9DaZMLrKt6lh0dCKOn7VReQYl24Cz6j8kDCnLHxdWVNCDFar/FU0u
         PjqnpiVE+SU05EVAFr/sySb34blmWckVYWB2XIv78qo7qY8buuYfAW8SfFruZ2H0kMSj
         us01ILbCnzRsE5Qx5cKfhxgOI9T2kHfHnDQrLkx3k3J7X4QqEyDOq3jBTAAHniv4AOp1
         YV9xc17BtNPhqOd0rejmQRvC+Opvfwh+xgPB4iPMy7MWFm/N2HOTH+iA06KdAcjVYjqL
         JMbOTv4pMxNO4itg95+Sa7XhvDqfaI4HImAR2nu/O7VSQ7eWczcf70gN1XyoEFWsbGHF
         B0BA==
X-Gm-Message-State: AGRZ1gIgAkWBN0AQ7LQLu3DLjteJlBUYZsAlly9B+xEisdokqDdzlVi4
        s7PoNdcdONRbu5Qt1iDfZxGn0DSLsIvZsvmZMII49jz9UFo=
X-Google-Smtp-Source: AJdET5dOzy3zYMqUJrws/K+b9UcjM9vEhpxtIP/DluIAZVlGwO4JVCD0PSOf9NE9M3aiZTnDukxsH8ndA3rUUFOmpfQ=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr10192339lfd.149.1542636599694;
 Mon, 19 Nov 2018 06:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20181116104910.GA10265@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181116104910.GA10265@hp-pavilion-15-notebook-pc-brajeswar>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 15:09:47 +0100
Message-ID: <CACRpkdZLGty8zGr3MrxXS4CkcD4oqSOBCEZ6LiUNd8x2goL_3A@mail.gmail.com>
Subject: Re: [PATCH] drivers/gpio/gpio-grgpio.c: Remove duplicate header
To:     brajeswar.linux@gmail.com
Cc:     jrdr.linux@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sabyasachi.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:49 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:

> Remove linux/gpio/driver.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Patch applied!

Thanks.
Linus Walleij
