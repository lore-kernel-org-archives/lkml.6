Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B1C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6061620835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndu6Dm/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6061620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeJLDWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:22:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37677 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJLDWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:22:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id u6-v6so1986805plz.4;
        Thu, 11 Oct 2018 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DuW1aiYefdF0Tv2o+IsJrEgiwQNJdIVsYUzvjrXu+uk=;
        b=Ndu6Dm/C/wZ7EkgmC+V1RZ3A7DOMQgG+gfVtuxgCtQf/ENjoluo+yS9FUHx38lYvA8
         ENmYqeVfXSmBgDH8HLmG2L1Hxud0hDj9oM2jOJRlUI7Sw8eDp6sma2dMrchysEaL+NfE
         RTe/LxIZ9696qPWl8UBjfe9zQTgV9Kfx2a010hqYDsdN9Qo69xAX09Y99Z86PhQGfdfe
         CRvS3OGZDya8TMbnfwnOEgbdzrsGtfedWCJzGuEGzM4yxEuBu2Z0mDCl1MbGd2L4hPmU
         0f+yafsFn/WRj7n5f3ycoo5K0XolG7ZnEignCrMx3hmpn946ufZ15HhFhCkOBGFWGU6w
         yXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DuW1aiYefdF0Tv2o+IsJrEgiwQNJdIVsYUzvjrXu+uk=;
        b=eTPc6yQ38Prd8mpvjkSMiKKCFekuFSAVal+CkIXuNHBDjPdxSmnScEkgj7Et77Sc/M
         rA+9np3X8e3AoUKqRmlMGqXvynSMkALNEK2+dYbqkNltQPwKchWiuotLVySGc4A8Ylam
         w4PXd1bg/3du/EkkkoGKcoiRr1gkemckwG0AkfcYP9W3ZdSJ8KdC73M1K2lswHPLdhzG
         NJpT7ewMZ38jAOGlRYSnKea1HIDEXX5H4T1kQKQq0ttDEqm3cg90kMLF0dl7deP3ybVG
         0tIGN9MUuP986NYFkYiNQ1fzZTakjBCmPg2SvU3FAbN897XV4M2PDGkXF+rmPYR2aHOz
         P1NA==
X-Gm-Message-State: ABuFfogU+fDS9/pLJok/Bg8Vj7hHGtYbagTcby+lDxxOOhcAFhEQ/zvI
        qKr2q/NOum7Il8SWpSmVb0c=
X-Google-Smtp-Source: ACcGV61dEcpn2XTMyu2fQ+OBFBD4RphdPrjRl3KvB+LQncMZ5BiBgWTHENENZfhMF9ywih1epbdruQ==
X-Received: by 2002:a17:902:bd8e:: with SMTP id q14-v6mr2933909pls.49.1539287607810;
        Thu, 11 Oct 2018 12:53:27 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 187-v6sm47511061pfu.129.2018.10.11.12.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 12:53:27 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:53:23 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Add operating mode support
Message-ID: <20181011195321.GA5567@Asurada-Nvidia.nvidia.com>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-3-nicoleotsuka@gmail.com>
 <32c22986-544e-aca1-12bf-9080667cf499@roeck-us.net>
 <20181010230906.GB1706@Asurada-Nvidia.nvidia.com>
 <20181010234300.GA25480@roeck-us.net>
 <20181011002411.GA10379@Asurada-Nvidia.nvidia.com>
 <20181011193152.GA4854@roeck-us.net>
 <20181011193658.GA3828@Asurada-Nvidia.nvidia.com>
 <20181011195025.GA7038@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011195025.GA7038@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 12:50:25PM -0700, Guenter Roeck wrote:
> Hi Nicolin,
> 
> On Thu, Oct 11, 2018 at 12:36:59PM -0700, Nicolin Chen wrote:
> > On Thu, Oct 11, 2018 at 12:31:52PM -0700, Guenter Roeck wrote:
> > 
> > > > One more question here, and this might sound a bit abuse of using
> > > > the existing hwmon ABI: would it sound plausible to you that the
> > > > driver powers down the chip when all three channels get disabled
> > > > via in[123]_enable nodes? :)
> > > > 
> > > 
> > > I would not call that an abuse, no.
> > 
> > Hmm..do you mean that you aren't in favor of powering down the chip
> > after all channels get disabled?
> > 
> No, I was trying to say that I would be ok with powering down the chip.

Great!

> > I was thinking about having pm_runtime_get_sync()/put() for channel
> > enabling/disabling routine of in[123]_enable.
> > 
> 
> Not sure if that would work. It might end up waking the chip when a
> sysfs attribute is accessed. It might be worth a try, though.
> 
> It might also be possible to utilize userspace runtime attributes,
> like setting runtime_enabled and setting the idle time before the sensor
> shuts down. It would probably be necessary to implement not only
> activating the sensor, though - we would also need to to ensure that
> the first reading after activation waits until the first read is
> complete.

That's true. Thanks for the input!

Nicolin
