Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46494C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1274620870
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIbJ5ch7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA1Fsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 00:48:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45846 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1Fsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 00:48:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so10887140lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 21:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNa/AKfePOVHK9K7W4j/u7n0HfgDZMiX/6VClOrFgmg=;
        b=MIbJ5ch7Tkn32fh4s3dVhXJP47vG0N3140zk5hgRAOsWD+yOAR5xrgM0QPfUeAydQg
         Bphr+l4YgsSgArm3pC8zN2t0YLrJZGfVO7WgKRU60B0g6Ki23LJ5NvI3O6lKMjbQ9EEp
         JCA7w68Sh8tyGrVxBTKLsUpcF68+6shRX0G4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNa/AKfePOVHK9K7W4j/u7n0HfgDZMiX/6VClOrFgmg=;
        b=iHTc7LxURSKJXVvi4k9nNzPcPJHfywacqvDazmBl8Z8U3ovFfakIpfzp/ho7SYBNW7
         XTKnlK/9+JdwkrM5tGj21qL4268VKgQMBu/JNMm7+64JghfnD/IbrvJumprYRzmiPt+1
         E5uVkd2O8777FcoENw4TkA3MKqOhwbI/BZgyxq7hCYZEtRhs1203LxGQz9vgd06kTLkK
         J88Rg8WSqfPDCXJLbG/ipzDsu/W/e78yeQK5wL/L72RNyXvSGp8kOSWYy+ajEqVCqheN
         VjFYyMhb5+Z3V29lqSBF/BLAkJr9TPjxTLfkDjXwinTli0PDDwUz/0oIlTgU61QqIXYg
         8UCg==
X-Gm-Message-State: AJcUukecd/YSeDGPj4IHq3y+F7jOXJ/S+QCnyzMReTWeFifWBHxfJorw
        kwzwD0oSAnXsUG7hCdfFE1O/KAOgXX8eGbyjJf9lVw==
X-Google-Smtp-Source: ALg8bN6onPtAmIp6B46J6+oAxs5RuHGEg2kayoumohnGb/TC/Na2jK7vnzs337YWkWO3FgGLb/Eg2/KSLI3pB2h6ONc=
X-Received: by 2002:a19:40cc:: with SMTP id n195mr15046378lfa.40.1548654514545;
 Sun, 27 Jan 2019 21:48:34 -0800 (PST)
MIME-Version: 1.0
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz> <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de> <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz> <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de> <20190123124658.GE15906@leoy-ThinkPad-X240s>
 <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz> <CAMz4kuK5JgfZF7uXa83xC3eVCrZ8+wkZRdKq2s71o_QjT=OhGg@mail.gmail.com>
 <s5h1s51120e.wl-tiwai@suse.de> <s5hwomtyr6o.wl-tiwai@suse.de>
 <CAMz4kuKZOpAXG=Lwii5Cb6q2EKoMUJOEmDz8X=dmVv+JivWf=w@mail.gmail.com> <s5hk1iszy4o.wl-tiwai@suse.de>
In-Reply-To: <s5hk1iszy4o.wl-tiwai@suse.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 28 Jan 2019 13:48:22 +0800
Message-ID: <CAMz4ku+eiqPAETMhGJ3=fQKfzJEORvjmr+51-oJZ5B5AyQcvkw@mail.gmail.com>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Leo Yan <leo.yan@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, bgoswami@codeaurora.org,
        sr@denx.de, gustavo@embeddedor.com,
        Phil Burk <philburk@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        mchehab+samsung@kernel.org, sboyd@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        anna-maria@linutronix.de, Jon Corbet <corbet@lwn.net>,
        Jeffery Miller <jmiller@neverware.com>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        joe@perches.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        colyli@suse.de, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 at 21:04, Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > Erm, obviously it's not enough.  Each attach / detach needs to manage
> > > the refcount, too, for covering the cases above.  It can re-use the
> > > PCM mmap_refount, though.
> >
> > But we've used the DMA buffer file's refcounting to manage the DMA
> > buffer. So is this not enough?
>
> Unless you manage the PCM substream refcount (or block the state
> change), the PCM stream itself can be released (or re-setup) freely.
>

OK. Thanks for your comments.

-- 
Baolin Wang
Best Regards
