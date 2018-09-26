Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323CAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84012152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhwfEtn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84012152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeI0CMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:12:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47028 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeI0CMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:12:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id d8-v6so93367pfo.13;
        Wed, 26 Sep 2018 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fAL5be0qBDxk2IQ8EFhPh0cFiVBpanT1WtL3hXbOMMw=;
        b=XhwfEtn5bs7rNbVYG2SZkEJUrZwG4cEa2hVzeuXn7tET7WF9GfNJxsc309CJP9DbVD
         I/4WHMCjHCZl3zFFZdXy1pbZsYg+ff9V2VFCRujjUmLdFszF8HvwLTgfDn7IldT51pYv
         LimP9LPhFPXP4WAPOQSJqWIr78f31bcHyA0+OGnKQ6jMCbDpKxdOJE3KhHSS3i/ZkM+i
         v9Fda9UkmVkkewXQSMb5TlOhrQPGNenxettEFDl0sfz8Ea+0+d0NKGDXjVXoB/zXsZjO
         OOfDkdjPsTpjc3vJtvlMq2ZsDQ1fQ/8E8zOrKAVJoMm0MryTv0btX8vksoPJ9rfomB9U
         GkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fAL5be0qBDxk2IQ8EFhPh0cFiVBpanT1WtL3hXbOMMw=;
        b=jPcpCq21nqkccdn5LOLSx3nGDb5XbVycyu4q4Tkl2Wp8tNCZT7FcTnw3ejoS0RNaZ1
         z77Fg5uvdWu7hsQFen4pthdD+O32yi6m6OEnR4TGEl0uDepd4/wI6O3Lo+H3lX3i1C3F
         pnywpOSOaniSsJXT6E6wASvA/zACHsy0kQRCkXL0LUfrvtQl0ILGFzAIs29vRDD5GyRh
         y7GEKsMOpW2OeVRGPIIcGL06KuD2z/G+PI0WHHPaofRKn/GhOolV3A98fECNEyv0okac
         YYUoYmJ4PmC6Q4qPDzxbatpLklIoRg4Vt4BgnbPZIQB1O3UP+K1q8FAARbZPq3ckJIQJ
         h2Hw==
X-Gm-Message-State: ABuFfoi2O0PdhNyCp2Uuw9BiDIzbdEWDwrmh65iIQE/egnpwOK/FpjvP
        VMGxz0tz+veYfG7Rb06ut+s=
X-Google-Smtp-Source: ACcGV600HMGMNnBoyYxYzuMPqE2S0s5p/GdbRJiD8TCu30d0IxDymKaB8DFQifROCnf3rAfqT2+PFQ==
X-Received: by 2002:a17:902:59dd:: with SMTP id d29-v6mr7587919plj.34.1537991899542;
        Wed, 26 Sep 2018 12:58:19 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s27-v6sm14808255pfk.133.2018.09.26.12.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:58:19 -0700 (PDT)
Date:   Wed, 26 Sep 2018 12:58:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Message-ID: <20180926195817.GA19695@roeck-us.net>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
 <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
 <20180926180243.GA6329@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926180243.GA6329@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolin,

On Wed, Sep 26, 2018 at 11:02:44AM -0700, Nicolin Chen wrote:
> On Wed, Sep 26, 2018 at 06:06:32AM -0700, Guenter Roeck wrote:
> > On 09/25/2018 11:42 PM, Nicolin Chen wrote:
> > > The inX_enable interface allows user space to enable or disable
> > > the corresponding channel. Meanwhile, according to hwmon ABI, a
> > > disabled channel/sensor should return -ENODATA as a read result.
> > > 
> > > However, there're configurable nodes sharing the same __show()
> > > functions. So this change also adds to check if the attribute is
> > > read-only to make sure it's not reading a configuration but the
> > > sensor data.
>  
> > One necessary high level change I don't see below: With this change,
> > we should no longer drop a channel entirely if it is disabled from
> > devicetree. All channels should be visible but report -ENODATA if
> > disabled. In other words, it should be possible for the 'enable' flag
> > to override settings in DT.
> 
> Hmm...I don't feel so convinced here. The status in DT binding isn't
> exactly a setting but a physical status: if a hardware design leaves
> a channel to be disconnected, I don't really see a point in enabling
> it in the runtime. Or maybe you can shed some light on it?
> 

You are making an assumption from your use case. It might as well be that
some or all channels are disabled in DT by default to conserve power,
not because they are disconnected.

> Meanwhile, I believe the enable nodes are necessary in either way as
> users could decide to disable the connected channels, based on their
> use cases, to save power.
> 
Agreed, though I would not say "necessary". "Useful" seems to be more
appropriate.

Thanks,
Guenter
