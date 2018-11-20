Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6AEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC832080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8vxFEXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC832080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbeKTNSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:18:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37669 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbeKTNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:18:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id 80so221218pge.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 18:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W9aL9ykX88NSPE7+sMeumq/IC/Ndf6IJyG6e/7w4838=;
        b=U8vxFEXQZqsAFGjqxZSDsq9F1xaGPKi1lR5xqvMhMZhrcRg9Hfka8ofgPSGuXFsqf8
         lBZSeRvWou2IahhEr+bNdUrlr6ppoDu7vf8j6jWcnU6N0Ee5h+XBenTpDkeQmEtjGYL2
         bkunUoh3QY1pTfDB3OpO1a5D5zvv4RZzA9Xdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W9aL9ykX88NSPE7+sMeumq/IC/Ndf6IJyG6e/7w4838=;
        b=hAlEY/ua1OUjC/UlFTWb9//gTH6q9CJpeiF3t64PE1PhqraBwXMQQEArl4ue3GeByv
         X2U/uqyWikaPZNzX2dPXrZ3x0JHSdyTxI4gOzY8fUk++l6zgdpS+JapZ9FYVl9WTu12/
         kRE8COipjJlVntBLJ8094ZvswgLd1gMDXr1aDBwbgmT6mj4LcJx6cab7haEP0KChxkUe
         SPUjC5D9j21fnYAgv+5FJ5FuaUSWRlG7zGglizhY25VU5UddUI0lnVmb2nMJwGcJYPSp
         Hvw+OpXzNX43PpnY9ow7gDM9uSwDqD/3//ZKoISFYDA+YZn9jIfbS2FhLNInkcK/7HNj
         SuMA==
X-Gm-Message-State: AA+aEWZg2LSQJrtzCGEuA1vEg33+kupBjuCvv3OTDX2eAq2IFymZSex/
        m6t1kwfo7i3snosaM16zHubxzKiNQQ==
X-Google-Smtp-Source: AFSGD/V2pZmb/vVyldDySk46Y1nbIovGWC8m7neXrNCCvQacy6r3uFqvqIAnvAgur5M+PTAAZObkmg==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr242464pgd.416.1542682294236;
        Mon, 19 Nov 2018 18:51:34 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:7280:70ee:bd9e:c1c9:b807:673a])
        by smtp.gmail.com with ESMTPSA id p9-v6sm41532360pfa.22.2018.11.19.18.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 18:51:33 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:21:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net, service@rdamicro.com
Subject: Re: [PATCH 01/16] dt-bindings: Add RDA Micro vendor prefix
Message-ID: <20181120025123.GA5885@Mani-XPS-13-9360>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-2-manivannan.sadhasivam@linaro.org>
 <e8749128-00e1-551c-8285-fcaef8029484@suse.de>
 <20181119172958.GA20692@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119172958.GA20692@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:59:58PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 19, 2018 at 06:22:02PM +0100, Andreas Färber wrote:
> > Am 19.11.18 um 18:09 schrieb Manivannan Sadhasivam:
> > > From: Andreas Färber <afaerber@suse.de>
> > > 
> > > RDA Microelectronics is a Chinese SoC manufacturer.
> > > 
> > > Cc: service@rdamicro.com
> > > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > 
> > This one is lacking your Signed-off-by, all others that I was CC'ed on
> > had it.
> >
> 
> Yeah. I thought I have to only Sign off the commits which I have
> modified. Will fix it in next revision.
>

Since RDA is merged into Unisoc Communications, this will also be
updated as "rda Unisoc Communications, Inc.".

Thanks,
Mani

> Thanks,
> Mani
> 
> > Cheers,
> > Andreas
> > 
> > -- 
> > SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> > GF: Felix Imendörffer, Jane Smithard, Graham Norton
> > HRB 21284 (AG Nürnberg)
