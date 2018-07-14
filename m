Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35807ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEADB2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4mvCmAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEADB2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbeGNQcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:32:36 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34281 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeGNQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:32:35 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so67555482ois.1;
        Sat, 14 Jul 2018 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t2Xs5cqFybH5t8/GLdmXoJt8KdzOX0S6x+TXn9TDS1E=;
        b=m4mvCmAv5l895C5/Vk6fZ6yBCYlfoLCfkYnnqXLs5qByc9ktwtgyl8WXLuCPP2i5zA
         8IGjbJu0ry3fzN/ZUsu8xeEZG3kbj8Qw+uMuI24p038CshTmWvVN85/L72Fv3khZpKaL
         UMRemGdD2Sh2SEBa19kfFqxDFRBy+zm4X9puUNplAR9URIErWQPmVyYfAz+TsDhMIy/J
         +ukEQQWtWqGqWOASQ5maPbKZKxWUn2B+Rw898p5Ko2ZqIrBadr4dxGJKoSENBQLTygOh
         8PF0hebg3fmpEm/VfuOQSH7KARodcdLIQ7az5bT8qbh4wnEZmexxAVSR7tL/yN8hRReb
         Gu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t2Xs5cqFybH5t8/GLdmXoJt8KdzOX0S6x+TXn9TDS1E=;
        b=RBvpyJtouzWRsKNu991dvx6xDdX+ryxEMpRsT18V4ZN7JQX/V5v6mfuOtXXWhpAoko
         /7BwuPFZUcjWUJui7m6doewnglBs8vUwHOTwHT9vqRrj/HwZ+m2mwIb334oGf4OzTVw7
         iyfMkTjg9ybnCFMs6xVglq+LHNe7TuNfS0Nry7p/FsVaoGoP05yBqqT6CpOT7oJehqjD
         N6M2Cdsg/DpAmmYfKbqNeC2LAKoLIo1JTX9rzwFs0875JsQtWwj8ezKif4eatrj7JX0A
         AJFUkG/DP5Gsn79PvqMUOO5MWn9UuM8QZsrkn/cSUnHlisB6yHo0MuXr2cAQEYKGke/m
         4ZFg==
X-Gm-Message-State: AOUpUlFy6lTxfVWpCJ+rmvxI7FXhVK9TjaxjwIQ0axtkSmhswGWMtJDU
        av8b/JM1K0pritQQ1HGvNG0/oNzGOBa5GHcpolo=
X-Google-Smtp-Source: AAOMgpfJJmdicJ3eNdAIgH8JOKuPCVtip03W/DL07tkpu2cN/4sxgqqqbVQy0iu1n0NCtb29b8aoTvYy3LjPdXDiryg=
X-Received: by 2002:aca:4886:: with SMTP id v128-v6mr12228520oia.69.1531584783115;
 Sat, 14 Jul 2018 09:13:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 09:13:02
 -0700 (PDT)
In-Reply-To: <AM3PR04MB131577674FDF0BC65BEF518EF55F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BSt4jdLWmXjNmTDAegGwtRWjbMuVAwdrnRyHWvSBuU5A@mail.gmail.com> <AM3PR04MB131577674FDF0BC65BEF518EF55F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 14 Jul 2018 13:13:02 -0300
Message-ID: <CAOMZO5DCsdwXK0eftcpwzT4my30HZLR7-H2c+V=ro+_fOMAWCw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: add power management support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Fri, Jul 13, 2018 at 10:53 PM, Anson Huang <anson.huang@nxp.com> wrote:

> Here are the details, i.MX7D LPSR mode and i.MX8QM/8QXP etc.' suspend/resume
> may cause GPIO bank lose power, so need to save/restore, for other i.MX SoCs,
> although no need to do save/restore, but doing it is NOT harmful, so do you think
> we should add SoC type check here?

I think it would be safer to restrict the save/restore operations to mx7/mx8.

You can add a fsl,imx7d-gpio compatible entry in the driver.

Thanks
