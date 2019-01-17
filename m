Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E190EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE3C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LWBTFxmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfAQVpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:45:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfAQVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:45:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so12739444wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rPL21ki1aX4oJLzX3r8m+1Cfs4ZHb3I5O5QskE3L8Ro=;
        b=LWBTFxmtoOfyZbWPElrNoiBI+uVNot+yh7tmwVW+3pKXPkJoeQa5ZmjNXa0hNE3N5Q
         bozQo2NBA7zD7t8tHdeajCje2oESw/ASW86WgsIW+KC2RMhXKYwuDsLDJyuXUQ2aJUrl
         XU9yEFyCO4sACCAZHngXc98XpanFrWkOXqz4k5Qgbw8si96LGwUc6mVObpWKiJbwX9U3
         ASZQTawU6GROgFKk1XOl7UkhZ8JFOvrIxn0+EQPcpWrTUqyzELf1oApYGLXhY4Gb7zjY
         K2AlthgtxOrYA5beCcMsykRqdEKmI1gc85bgxxat8zan/lZuUVEMp+LaXQuOCfcHBKp6
         CXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rPL21ki1aX4oJLzX3r8m+1Cfs4ZHb3I5O5QskE3L8Ro=;
        b=sAyZ8TzFG5p3+qfQ3EWlnVo/rMmjxZkRjB3C585ZC1s6uWK590YJ1afMooAShIFq+I
         5k9XTlwFCWO7hjwVinAS1lM3sQv1u0oqzCX6sKSpf/4KJLjmEGYFT3UYWVuts+uitkt2
         xUxyNmFbnFBWZ0mFA28mXQtgHY8rKTvCuQhqf3RwBl9TExPrm6MgmAhIwYZJRbMGTvHB
         Y+zYG8NK/uGVz9xb4av4FA+NpKI83DnmoSxWSR7zutFN+hQSEpDhFFWPoS5Pw4vT5viP
         /ZKX9FbrifhSYCVLh6qT4ncuAoxagRFP2YuhVcG9ldaV4xl60VxWL9WWkXwiAMXsmMS9
         k/xA==
X-Gm-Message-State: AJcUukdahT2haGSEBQDQxd4H7aiyVf5uKwUdmcMmdZCMh3Gef9lS2qo9
        waPBjsnQr6ijJv/FtGX6XZG+Dw==
X-Google-Smtp-Source: ALg8bN78J0TErC42Kn2qhyVgFmlOo3FdNsKSHaFh4az+h9weFMyzE+ig7uoKNXkP1/7nkdHtFRwoJQ==
X-Received: by 2002:a5d:568c:: with SMTP id f12mr12828997wrv.101.1547761520408;
        Thu, 17 Jan 2019 13:45:20 -0800 (PST)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id p139sm78005569wmd.31.2019.01.17.13.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 13:45:19 -0800 (PST)
Message-ID: <0dcd4c655bd9477d7adf2c6e32a1f0ebab18cee0.camel@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: fix g12a buses
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com
Date:   Thu, 17 Jan 2019 22:45:18 +0100
In-Reply-To: <CAFBinCAdJu2C-LWspiHR4vVr=PUD2HGNi4zz+CSJP96ZE4GoJw@mail.gmail.com>
References: <20190116165236.8330-1-jbrunet@baylibre.com>
         <CAFBinCBFge2tir-MXw+ojTxzW+7n9Uf4FzCahrw0MDzAYV2SSg@mail.gmail.com>
         <f7289814e316ad5879848fb8c379db396f615828.camel@baylibre.com>
         <CAFBinCDhryOWHmRKp7GhWp2O+NpJziEgHoUE4HKVitTPDMrrBQ@mail.gmail.com>
         <ba1f56258e7873041a0f75996e376170563c9e6e.camel@baylibre.com>
         <CAFBinCAdJu2C-LWspiHR4vVr=PUD2HGNi4zz+CSJP96ZE4GoJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 22:20 +0100, Martin Blumenstingl wrote:
> On Thu, Jan 17, 2019 at 9:39 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > On Thu, 2019-01-17 at 21:27 +0100, Martin Blumenstingl wrote:
> > > OK, but we had incorrect documentation in the past. did you check this
> > > with someone from Amlogic?
> > > 
> > > I'm curious because there seem to be two different approaches here:
> > > 1) hiubus name and offsets are being fixed within this patch
> > > 2) aobus is being dropped here and re-introduced with a different name
> > > later
> > > on
> > > 
> > 
> > because hiu exist and aobus does not, for which both the name and size was
> > wrong
> > 
> > > approach 1) can also be used for the "rti" region (at least in my
> > > opinion, the patch doesn't explain why it can't be done):
> > 
> > THe patch remove aobus (instead of fixing name and size) because, of the
> > multiple region documented covered by this 'made region', I did not
> > anticipate
> > which one will be required and I did not want to add them all.
> > 
> > Better to add them as needed, which is want I done for pinctrl as you
> > pointed
> > out
> > 
> > > rename "aobus" to "rti" and change the size to either 0x1000 or 0xb000
> > > (both values can be found in mesong12a.dtsi from
> > > buildroot_openlinux_kernel_4.9_fbdev_20180706)
> > 
> > RTI is added here:
> > https://lkml.kernel.org/r/20190117103151.3349-1-jbrunet@baylibre.com
> > 
> > I don't really understand the problem ? result is the same
> the actual problem is "me" as I have conflicting information:
> - Amlogic's buildroot kernel (for G12A) uses similar bus definitions
> as the GX SoCs (for which there are public datasheets) - this is how
> Jianxin added it to meson-g12a.dtsi originally

And it was the same for the GX family. AOBUS in the DT while there nothing
about this in the memory map. Keep wrong patterns does not make them right.

I'm merely reading the memory map here

> - this patch does it different - but cannot check if this is correct
> (no public datasheet is available for G12A or AXG) nor do I have a
> "big picture" of upcoming changes

Yes it does it differently. We should have picked up on this a while ago,
since gxbb at least, and we did not. There reason to create bus that don't
exist in the memory map of any recent SoC.

Creating bus should at least require a start and end offset explained
somewhere. Copying vendor DT is not enough

> 
> Cc'ing Jianxin: can you please review Jerome's patch and give some
> more details on the memory map on G12A so further contributions can be
> reviewed easier?
> 
> 
> Regards
> Martin


