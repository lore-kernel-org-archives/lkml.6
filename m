Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC63C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF82220851
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRoO1BmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF82220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391188AbeKVLcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:32:55 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51349 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbeKVLcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:32:55 -0500
Received: by mail-it1-f194.google.com with SMTP id x19so11768487itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 16:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Zlg4960n41Dzz5cVWKUSwyCASFva94vHU0qiZv1sIo=;
        b=aRoO1BmPDIBILIK3edbZmcpSb0Un3qcl998/RfnVQMpn11xXD5ahdMT5A+XThve9Ds
         wv3q0p3wyY2cT2BW5hB+XQ7egJE5GlODZ1y0FxqR3J8eeZTSgooWu+YTKdBbqTQN5wgE
         IyW230pu/1Q8XhsmRtc+NRw31mo+symd1wh2jNMu5Gw2ciufA8/9UwXwiHjrIQfjG4aK
         cHWNhX/gENM8Gl9u+FLGkeA1XtUaJoIkeZzM77jiODz3hZLkPc7nJevL83MElnBW4stc
         0allvVRKiImLm7iop+pdatJmMesr8HAxuKbEyMPx7/BL/oKDQcW9MDucCg6qbxbBdtmT
         aCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Zlg4960n41Dzz5cVWKUSwyCASFva94vHU0qiZv1sIo=;
        b=IPqH3WRBnV5lrZ2iQ3jc+lJGU/ia20EPChs/rqy/iy28A520scKk02Q58X4iYPMWcb
         xNOS/R9sVSv/o6dqofI0OwXH1fU+bi5CIU1lQjvFL/5m3nXaGqFzTJ3GrI69wjnE9QF3
         7qlxJ5h1DdXrfzt00CQ92Xl0/taJQP318e4C321XzC778kpUFF2U/rsncBsla6PbiHnl
         bWYuvQ+5HI2sQoFU64jP7STeYfxcFlX6vsyxmgqhxIkqvHyqZt0ypcnvsO3a9LEPjVmz
         PaSH04ieLArf8LJ4R0n8SI5vu9ugCutnCNh7dUeyK4jLAEsZEmDYoZ0gGZfZ6kwJL38u
         +Ncw==
X-Gm-Message-State: AA+aEWYeDBGhiOSfmfrDsJ6g83VTuWiRMQQL/gdvjWE6jh6chmfHB4/C
        w2A6o0IARMlTyIY72MDzzixeTYvHGkeg/1m4Q+w=
X-Google-Smtp-Source: AFSGD/W1iFbcrDI2KQ2IajAmZI756yHxeYkNruvC9hUXJej12V0kzP6uG1Dx+gR2winI0bCYbvrXYZZX2lpv9BEacs8=
X-Received: by 2002:a24:108a:: with SMTP id 132-v6mr7586794ity.78.1542848163979;
 Wed, 21 Nov 2018 16:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20181121124342.21987-1-tiny.windzz@gmail.com> <1395243f-2c08-6079-e8a8-79712179fe57@gmail.com>
In-Reply-To: <1395243f-2c08-6079-e8a8-79712179fe57@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 22 Nov 2018 08:55:16 +0800
Message-ID: <CAEExFWtSwPwCFUH73GvoWKhbz8wHZbJC0fNsO=rRzgrSzEBYkw@mail.gmail.com>
Subject: Re: [PATCH] soc: bcm: brcmstb: add of_node_put()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, olof@lixom.net,
        treding@nvidia.com, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 3:23 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 11/21/2018 4:43 AM, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node returned
> > by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
>
> You probably copied/pasted this from a prior patch, the function name is
> soc_is_brcmstb() here, do you mind fixing that and also providing a
> Fixes: tag?
Hi Florian:

Do you need me to send a patch that changed the commit log or refactor
the soc_is_brcmstb()?
For example:
https://lore.kernel.org/patchwork/patch/1015523/

Yours,
    Yangtao
>
> Thanks
>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/soc/bcm/brcmstb/common.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
> > index 14185451901d..95b777fffee6 100644
> > --- a/drivers/soc/bcm/brcmstb/common.c
> > +++ b/drivers/soc/bcm/brcmstb/common.c
> > @@ -32,12 +32,15 @@ static const struct of_device_id brcmstb_machine_match[] = {
> >  bool soc_is_brcmstb(void)
> >  {
> >       struct device_node *root;
> > +     bool rc;
> >
> >       root = of_find_node_by_path("/");
> >       if (!root)
> >               return false;
> >
> > -     return of_match_node(brcmstb_machine_match, root) != NULL;
> > +     rc = of_match_node(brcmstb_machine_match, root) != NULL;
> > +     of_node_put(root);
> > +     return rc;
> >  }
> >
> >  u32 brcmstb_get_family_id(void)
> >
>
> --
> Florian
