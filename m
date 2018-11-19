Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2214C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F682080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik7Cs9A/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F682080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeKTIof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:44:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38572 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeKTIof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:44:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so5204286plb.5;
        Mon, 19 Nov 2018 14:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rLLX9URkTWMKOpnP07dPOtlBBjEGkANC8hu782U5cTI=;
        b=Ik7Cs9A/YQbz2xSiqs4oQ/gF/joEIwQmsLJ1SG05IqGuZDQai43K2ThSwwybErYcId
         1vtSWaLtSrsHgZihiECRHTwhcJM808Pl1PlanVkZBZVb1ElhzT6kRXk90DeMgn0T2rJx
         ExgSbueZ+Oyy8yew+b9msLgwjfy2H9TXlD71JgAvu0Dfgw3wufB/mvv2Fbc3I4i2D3lg
         YqZx4TYRmmoIp490zf8grmrnZFZYQP1JQODyO7tQfl08lsZq3LYRTXx/i9M73d2hza53
         R4x4Ldejnan7Kt4ScqcB/FRsAkj9j+xX3jfPILBj7bBxqt/RtobJ+fFcDAjZJGKuzXB/
         KA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLLX9URkTWMKOpnP07dPOtlBBjEGkANC8hu782U5cTI=;
        b=IfsJnL5rqdLyxuBt8SvW7daKIYpyIao7UqGmnAcGN4a8koloGyrO2wW7qGv2U2UiZi
         kzZKI9zcNTAVexd8U5RNmTwf+xuKdZbOQnABfvsgkzPrRYXDmXQYR46fwFXaL3JAoMfE
         WBsXtFY74yvq3F5E2E1IkUjT6YO/dnm8xbjy1DMkVfWYr3G84P1bblGaeyeEUFpwBF6z
         djvUHcamlAMEni7XiRNyVarouTpf1Bk3sjjROO5H+qFj/+1tRbfOy0KbTHKsZdVyEtaq
         VeBAlBDL0GosjQE9cJpICFFqVupiLkwiax4rBNCXbhsrTtv8m8T9ExS51AojsV9moJuG
         P1Eg==
X-Gm-Message-State: AGRZ1gLCKO4FvLy26KG0mcZPAYG/lonBTyWysibM5SH9NP3lppc6l8qk
        ibCw6qswKqr7tBe7aOJv/hc=
X-Google-Smtp-Source: AJdET5dKEpsRoMLUCSHCzLS2DEC32nXFkGrQUh64jbBdFZBcZjoYJDpXiDOXNmzmDQ0TJ5JbrXOJRg==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32-v6mr24003490plj.39.1542665928282;
        Mon, 19 Nov 2018 14:18:48 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f64sm82953944pfh.0.2018.11.19.14.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 14:18:47 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:18:43 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add single-shot mode support
Message-ID: <20181119221842.GA26382@Asurada-Nvidia.nvidia.com>
References: <20181113042353.1507-1-nicoleotsuka@gmail.com>
 <20181113043248.GB11205@roeck-us.net>
 <20181113045823.GB26327@Asurada-Nvidia.nvidia.com>
 <20181113172102.GA21714@roeck-us.net>
 <20181114001141.GA14925@Asurada-Nvidia.nvidia.com>
 <20181114172330.GA25592@roeck-us.net>
 <20181117015131.GA10407@Asurada-Nvidia.nvidia.com>
 <20181119174559.GC27435@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119174559.GC27435@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:45:59AM -0800, Guenter Roeck wrote:
> > In short, other than exposing it via a generic ABI to the user
> > space, how about defining some policy to maintaining it within
> > the driver?

> I think that would be a bad idea. It changes timing for everyone
> curently using the driver. It also effectively disables monitoring,
> which is the main purpose for using this chip (and other hardware
> monitoring chips). This is indeed a key difference between iio
> and hwmon - the main purpose of chips in the iio subsystem is to
> be able report data efficiently to user space, not hardware monitoring.
> I do not think it is appropriate to use iio requirements as argument
> to change hwmon driver behavior (and vice versa).

OK...what about setting a default mode via DT? I didn't expect it
to be possible until I found this existing solution. Though it is
still in an iio driver, I don't think this should be iio specific.

  commit 023e30fb0d3a3b9d6b8dc9e47590aa544d58a22f
  Author: Adriana Reus <adriana.reus@intel.com>
  Date:   Tue Nov 24 12:59:49 2015 +0200

    Documentation: devicetree: Add property for controlling power saving
                   mode for the us5182 als sensor

    Add a property to allow changing the default power-saving mode.
    By default, at read raw the chip will activate and provide
    one measurent, then it will shut itself down. However, the
    chip can also work in "continuous" mode which may be more reliable
    but is also more power consuming.

    Signed-off-by: Adriana Reus <adriana.reus@intel.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Jonathan Cameron <jic23@kernel.org>

Would it be possible for me to apply a similar one? Since hwmon
driver uses continuous mode by default, I will add a "one-shot"
property instead of "continuous" -- all existing users won't be
effected unless they place one-shot properties in DT bindings.

Thanks
Nicolin
