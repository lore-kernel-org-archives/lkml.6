Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB79C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DA9208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvjCc8P5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DA9208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeHXDkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 23:40:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34524 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeHXDkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 23:40:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so3642930pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UoCSvgQ7RQhA78+dPcHxGBrTqDUH9h2Z/zZv1xU16yg=;
        b=IvjCc8P5QSgmdTQstOJQdRe1c3HaGcxUMIQKc08hNihmkcqTr1PoxmjbpWWQ/LQcUt
         wWF+X9lhvj/q43fn8DGg/XkZq01X2sW0Hc7iY5nFb6+cwDjcysH98eD7purPoLZztVHH
         RlePVEOBImoZwOeQbeSQLMWqm655OF2kqHI0afzb8bOUHW6bGIXAw2ZLTfVKv+egU4/T
         omQGnUa5+hz06OhrlcL5UV5v8oDLYRbg2RP61DBroWa2feMieOtXb3+EJZdGC93gFz9F
         5pvfnA6WdPFqZ/xdRlgX2JmfVGDznvibYilinjv1WQuE3hL8wARRHn3lULxXcX8p79P5
         YgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UoCSvgQ7RQhA78+dPcHxGBrTqDUH9h2Z/zZv1xU16yg=;
        b=RPhPo8feaNQVxt/Ruyo+pcEn7Xnl7AD+rFfaFjPFqmVP5bMR0YyE85kcx6iMHTIySK
         keknpvJTyOo2c8j9+Igv7iqF/vU71Biq6ycheCIUP6OS88eclm6gmW8p39xEyxB+M/KM
         iQD7Sgi1S/iVrSamJrvF2t5MCVT0qj6QsA7mIGxzT1JKtax2M0eKBI/03+vPHRv8i6SJ
         E2xpFJ2KFJMCWCkSeCZVeruN2F8H2qIeQ9ZyU0mtbEdwfFurR42XRTaXXyoI+A+Y19ZC
         Q3zjGe+M5MmfDPEA6UlVuDQKrAmKxLPfXMtCaHR2a3X2LYwrTxfrAjeeEpQ4ebMnQW/+
         VBzA==
X-Gm-Message-State: APzg51DKvUCqhjqHs5aK10FDJy+4AOCN8ZoNFKZaq35OrDKIVw8cVa0e
        XGasN8uSdjJrhW+fOacoua8=
X-Google-Smtp-Source: ANB0VdZ9cSV0Y0rPuMqILcD+r7NYPGA5sVjC0u4K7p3MWcdish1uT/T7c9ee2sjL3YhEYkjSYeu3pA==
X-Received: by 2002:a63:d90b:: with SMTP id r11-v6mr4082150pgg.315.1535069290489;
        Thu, 23 Aug 2018 17:08:10 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t14-v6sm6116424pgu.0.2018.08.23.17.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 17:08:09 -0700 (PDT)
Date:   Thu, 23 Aug 2018 17:08:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     ryans.lee@maximintegrated.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        lkml <linux-kernel@vger.kernel.org>, ryan.lee.maxim@gmail.com
Subject: Re: [PATCH] ASoC: max98373: Added 10ms delay after amp software reset
Message-ID: <20180824000807.GF53155@dtor-ws>
References: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
 <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
 <20180823095107.GA5207@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823095107.GA5207@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:51:07AM +0100, Mark Brown wrote:
> On Wed, Aug 22, 2018 at 05:31:04PM -0700, Dmitry Torokhov wrote:
> > On Wed, Aug 22, 2018 at 5:21 PM Ryan Lee <ryans.lee@maximintegrated.com> wrote:
> > > +       mdelay(10);
> 
> > Is it really necessary for the CPU to spin for 10msec here?
> > usleep_range() would be better solution.
> 
> Or msleep() for that matter, it's not going ot be the end of the world
> if we delay a bit too long.

Frankly, I'd rather we did not introduce extra delays. I do not know if
we use this part, but on ChromeOS we are interested in shaving as much
from the boot time as possible and 10 msecs here and 10 msecs there do
add up.

Thanks.

-- 
Dmitry
