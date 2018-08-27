Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922FDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0F8208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heQBEBO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0F8208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeH1Cn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:43:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36794 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeH1Cn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:43:29 -0400
Received: by mail-io0-f196.google.com with SMTP id q5-v6so544568iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dURr3UIQMJ8thueMnfh33Wd7F1/6XjH2eQORYekdtn8=;
        b=heQBEBO+mWfo07TngI+l6C7ctleQFA4NTyGXd9nX8QiiPy1uQe7t8D08GnVzQjlT6I
         QFSfSV0S2CYZV62MpGR7qrgzEKzH6eZpWv9IwaFDPo5Bz5dyRNwJtNmfFHOszx68MOUU
         jkx77YyKd3AN3GuorqlVJMeFf6GVtxjKsgjZO6F6XbJbiVTAXVSLoHhiSSGa7WuXDxuu
         bvQidefmTDxVEmhUwRSM/1wT49I/02JQabBYz5i08MpLVHYsn18G/0ycydAztF79wFxP
         A/bCCsrxDSlNI/M8ATkKvCZh3N8w77HxJEuffGHOycYtaJu+4szV8G8wHEwlvS3Sx3mx
         MPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dURr3UIQMJ8thueMnfh33Wd7F1/6XjH2eQORYekdtn8=;
        b=uCBq3QwXtAjNRPwkkdqZ1y4WIhGymTmAvuyyZp6xBAE2Q4iALsDaIia4uCZoMjMu0E
         XU7401NoDmzhEWH27f5CvqIRuqqu+n11/t3SibqsJ8ziWCM1CkyRF7Z+F7MaHNTUUcz6
         Cjx0BbQPocFGtzOhzqmeB42AImE/JO2+snaFaSUP5pjTHvYrwIszccnz0FGDy2eZQe1B
         gAvlAFOTDNJ4O+uHjrTttbexCrgij0jgbpU0a3x9vPlkQPCB5ahDpRFSYy7BHP1y82R0
         nu0+1NyTi1yMpgeLZ/IdH9Em4ICVXjjf7rkrdHycaPH6HyVjWqF2dx27j5r2LDYMMYiD
         xh8w==
X-Gm-Message-State: APzg51Djelxvbnx/EEBgsA7ywst4O7Cyy90KgkD1FgE2NbRVD5WfVBHw
        jErbFWC+Lrmak7NJTlHG/Zy/fTDwkMb5dFuwqOo=
X-Google-Smtp-Source: ANB0VdZeGG4uVKvrehoOXk9a6zUL6CYDC8zuJx7POZccxwLoWqCafQNU2z9C9JRJWWe9MMuVf962mw+DqlGbFPxoKzA=
X-Received: by 2002:a6b:bf04:: with SMTP id p4-v6mr12023011iof.15.1535410487819;
 Mon, 27 Aug 2018 15:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com> <20180827021326.GA3850@dragon>
In-Reply-To: <20180827021326.GA3850@dragon>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 27 Aug 2018 15:54:36 -0700
Message-ID: <CAHQ1cqFFDMJsi7tOj3DyiRp8scWJNg0kiu_=NMP4ZzZPbLXP-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: imx: gpc: use A_CORE instread of A7 for more
 i.MX platforms
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 7:14 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> Andrey,
>
> Are you fine with these two patches?
>

I made a small comment on 2/2, but otherwise both patches seem
reasonable (Acks provided in separate reply).

Let me know if you need anything else from me.

Thanks,
Andrey Smirnov
