Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E52C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4482083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGajBNrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfBYQ6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:58:44 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55131 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfBYQ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:58:41 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so12458374itj.4;
        Mon, 25 Feb 2019 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HF/x9SIP2c4LOJI8Gu/IIr7CYiRJWMzO7pgDk5/UdPY=;
        b=jGajBNrFpEYR81NnOiQvQDn66PDFAHx8qfbvW2kglgS++AbZLwBIrC0A2cpXU3WGPI
         +RXEtFh3ehN0ZPz064gxlgRsRg6cofNkKa0JqVy+X+TGsB5bIDDtlq9pLsxsXDo/SxuX
         gNPKrbN8VOba/0rzw8keGuBeJxwzP2mQ1cYk1Ul7v8H7+RLcqsoQEbAdjW6k+S0nq/jd
         AOtIHVrJ2FkvO2JToQjZr+lJsi1bVTQTScvvbAUn5M3v/1pqAivL1S7dMLgqNZ24WCZ3
         IHT/2jCwFA3sxWFKwIGxEWdm3GHWi9Iy1l9wAAYnpXLil9ObaXSlK1g2sOgoxUadaK/A
         mSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HF/x9SIP2c4LOJI8Gu/IIr7CYiRJWMzO7pgDk5/UdPY=;
        b=nfkj/uP1+qROUk3Irtb2RfZ2CSxEJ6bNLJhzQGDynM2a9TTEPACRBA8XTj7Y6Zz/3C
         64JdaE8KZALkcRN079ht4csOp+SzYukDuabPAhoBBvB53BSuqoiouhx4nM8dDGaCqhB4
         35giBQlQ1N5zTZKwVm77+EWgN4OvKSgObI58k5mGHdAM9PJf+VkqJeJHmBb0PWrYgk7r
         wlWiTWsjIfWk4/HtVUrsA4Hh9NmJJEnNo8ifcPjLw29YXiWsnGpYog2zOnGvOeVMKbkL
         xFsKpEbCIjPDsYAsLOQxVDvvKKfIGFtqUPcpJtchH6LFIMApWduxHGsNUR+p5bWX4PAv
         zVRQ==
X-Gm-Message-State: AHQUAubB8gfZHK/H/fghJTyCTs/lJmDPjn/ZjgMsC/ZobsXBaZ9Rx5eM
        BveZ5r36WHi8yAO0qHMZow==
X-Google-Smtp-Source: AHgI3Ibl91VylLRUlVr4VuwFQHvbTDSfHnPSdKOznY9rlV0fvSEq3CRG3u7TaOVcd3TlT20v9eVZ3g==
X-Received: by 2002:a05:660c:344:: with SMTP id b4mr10118861itl.51.1551113919952;
        Mon, 25 Feb 2019 08:58:39 -0800 (PST)
Received: from r (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id f26sm4003124ioh.1.2019.02.25.08.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 08:58:39 -0800 (PST)
Date:   Mon, 25 Feb 2019 11:58:36 -0500
From:   Robert Yang <decatf@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Support Trusted Foundations firmware on Tegra30
Message-ID: <20190225165836.GA12933@r>
References: <20190222193426.10747-1-digetx@gmail.com>
 <20190225040232.GA2242@qmqm.qmqm.pl>
 <20190225082155.1163ed85@dimatab>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190225082155.1163ed85@dimatab>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 08:21:55AM +0300, Dmitry Osipenko wrote:
> В Mon, 25 Feb 2019 05:02:33 +0100
> Michał Mirosław <mirq-linux@rere.qmqm.pl> пишет:
> 
> > On Fri, Feb 22, 2019 at 10:34:19PM +0300, Dmitry Osipenko wrote:
> > > Hello,
> > > 
> > > This patchset adds support for the Trusted Foundations firmware on
> > > NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have
> > > that firmware and upstream kernel can't boot on those devices
> > > without the firmware support.  
> > 
> > Hi Dmitry
> > 
> > I've applied and tested this patchset on my TF300T. Boots and
> > suspends/wakes using 'rtcwake -m mem -s 1 -d /dev/rtc1' as the test.
> > dmesg attached.
> > 
> > The exact tree used:
> > 	git://rere.qmqm.pl/linux tf300t
> > 
> > Feel free to add my Tested-by and Signed-off-by on the patches where
> > apropriate, and thanks for your work!
> 
> Awesome, thank you very much!
> 
> Robert, could you please confirm that v6 works for you too?
> 

Yes, v6 works on Ouya.

LP1/LP2 suspend tested with 'rtcwake -m mem -s 5'
cpuidle LP2 tested with 'echo 0 | tee /sys/devices/system/cpu/cpu[1-3]/online'
Tested with CONFIG_SMP disabled too.

You can add my Tested-by to this patch set.

> I'll probably make a v7 with an extra minor clean up and then will add
> all the appropriate tags to the patches.
