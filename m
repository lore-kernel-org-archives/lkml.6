Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5245C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B4E2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmKk5CoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B4E2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeI0CDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:03:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42292 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbeI0CDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:03:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so94016pff.9;
        Wed, 26 Sep 2018 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=51mBzVRuDSxvzkUxZZ6Cmg60pCqyn7MPw2Gjd6mPjWQ=;
        b=UmKk5CoBlcSefy9eHeZI/2Fgu6LeC6Ajq6PXVWzl0cFMtqPOVusvogDa0gPLzuaFDV
         Edy+JqUY8e36+UqxUFaJ6naSX+eItt43itHLEtJ16tycGDcpDfzxnZRmxIkvpUDsHjB7
         wUmwA/MMAtT+Pi/QbFAlHvpeDFgUe7+PuuKxfMARyHFpmQgqN4+fyk7UTYaaFWRGp/Gl
         zGQVRrLCJshi52kNtzKdtIp2K7VsgbiGF2DlGd0+w+RC364iqV4mzHhdaq5W8DOG9Mmu
         SiMBa8llJc2z+L5X+BB8By3kvaa92O5Mezj5NFYAy2QSLHsXqiJie+lzEJpre2bC+rI0
         iMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=51mBzVRuDSxvzkUxZZ6Cmg60pCqyn7MPw2Gjd6mPjWQ=;
        b=hVM773z0K8XuAnSOw5Iq1NPi3ZgUbM4y2J9PVkYuk1/BfqOjrIWpju2lKyKFhv/8y0
         em88tKrxCTOAdYwHgQ8djUuJEp76VTEXIjKjLYRFTh0cY14Yocn9ActqWREFD999FuS+
         2qdkMJswi4vnsyE5TGzyKY0tUVB0Z0OSDlG8VOhqYBiQFZETyzc1eGiA0N7RAWEYFrml
         hbKm+aInUDDoEleahwmZZOI9iWk4ONotH0VVBpK+w7EC02ZUNs5YfYDIa6ubUEWzRJ4Y
         Dhz1Z/P0aTmLpzjNHawjtVNWW3FLFGvW5l9iemOyH8R7XLJoTh26Z2xTNGxjIOnI2Obo
         UeQQ==
X-Gm-Message-State: ABuFfogF6ouJ+RAiTlWZOUadnVYJmdmEIjcIpbBTeEmcOluONBTVXPOy
        a9sRRIDCu1VcY2lY2Q8hE5Q=
X-Google-Smtp-Source: ACcGV60uGlaUh64eO54/OIRBF4ad4I8nN9NAGLGanT0OnOJV4JTcqmaKP3iCEHlw68lrXNdT7gJUrg==
X-Received: by 2002:a17:902:7e49:: with SMTP id a9-v6mr7456043pln.149.1537991350105;
        Wed, 26 Sep 2018 12:49:10 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v83-v6sm18719785pfa.103.2018.09.26.12.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 12:49:09 -0700 (PDT)
Date:   Wed, 26 Sep 2018 12:49:05 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: ina3221: Add power sysfs nodes
Message-ID: <20180926194904.GA10595@Asurada-Nvidia.nvidia.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-2-nicoleotsuka@gmail.com>
 <dbf77a33-ae5c-1ac7-c94f-fa5505074adb@roeck-us.net>
 <20180926182006.GB6329@Asurada-Nvidia.nvidia.com>
 <20180926194534.GB18731@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926194534.GB18731@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

On Wed, Sep 26, 2018 at 12:45:34PM -0700, Guenter Roeck wrote:
> Hi Nicolin,
> 
> On Wed, Sep 26, 2018 at 11:20:06AM -0700, Nicolin Chen wrote:
> > On Wed, Sep 26, 2018 at 05:34:53AM -0700, Guenter Roeck wrote:
> > > Hi Nicolin,
> > > 
> > > On 09/25/2018 11:42 PM, Nicolin Chen wrote:
> > > > The hwmon sysfs ABI supports powerX_input and powerX_crit. This
> > > > can ease user space programs who care more about power in total
> > > > than voltage or current individually.
> > > > 
> > > > So this patch adds these two sysfs nodes for INA3221 driver.
> > 
> > > Ah, sorry, we can't do that. The sysfs nodes are for chips providing power
> > > registers, not for kernel drivers to provide calculations based on voltage
> > > and current measurements.
> > 
> > Hmm..I saw ina2xx.c and ltc4215.c are doing similar calculations...
> > 
> 
> ina2xx.c doesn't; the chips supported by the driver do have a register
> reporting the power (0x03). ltc4215.c was not reviewed by a hwmon
> maintainer. I think I mentioned before that you can find anything you want
> in the Linux kernel. That doesn't make it right.

OK. In that case, I am dropping this change.

Thanks
Nicolin
