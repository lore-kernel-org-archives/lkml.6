Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED30C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9FD214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r977oMpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9FD214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeIZJTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:19:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39692 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIZJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:19:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85-v6so9955126pge.6;
        Tue, 25 Sep 2018 20:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6j3RBHQly5jYgwNGJC/FobgcXfIu+QuiDwQz/UHZM+E=;
        b=r977oMpJ/EZOXD4x66T/ZrfW77RJV9BLyXFZZ5D/AAli7godqcVHxtyZuaiu1v/RdX
         L9I0UZ0oMx4QRtFTDf2MNgy88dWPXYuwL5b6XL4ArdpornoONHJ9Et+k625f6KFsjQN/
         QypQBVTpDm1Q1bJKvoG6Pr7kkZH/LiAOWy4O35kVfmu9NvYHS4PbOpYDZH8nEUjTnJ4k
         TMwgGy3uHzaVSv4p2hfS9ypgN503aKgKC4YRN10Wqwc426rk/oBfETZ2NPUqmJEIXdya
         L8/gzsi3c73Ath3Po7E+j/qc4Kopz52dWywiCEkrmRsWZTLF7C1trRHu4O8CC4P86d0V
         GB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6j3RBHQly5jYgwNGJC/FobgcXfIu+QuiDwQz/UHZM+E=;
        b=Y1/CPaPaD2hyL+XM3C8YE8guWv4fP3jP+gxRJ5Cnv+Hc3xTp4mhx9wmUVIa83u3XiV
         TLeOxk0wY+itBUizQw7wA1sF3SCfAa5FP0QI+PHR6AoVRIZc0RUKl3kjTnmUvxPKNvnE
         x2lKzoHZKHthmiAf14IGTBxtp4uS4zh1r42HWLoikm+GW2+V2F58w1kv6jF2eyUkKJHa
         xhISbG7qcF5tA4kJxla3YSRaOA4zwIaWHDQbmo3kUxl72BU9G8W1SUB2bTr3qvysSZ0m
         hEnEqqT6HS3a2+Xw58BtjPOTZfxr9Lk8C5MevmWWJSU/rOLDZT0atSymhcp7dknXUj4i
         NL5w==
X-Gm-Message-State: ABuFfoi3ZJY5ysdB9/gWfONDquPdsWix2Y+WJ+1ftdPasuLMr9dJOENG
        WbuCHvhS++Ljgn9LwZZzeYA=
X-Google-Smtp-Source: ACcGV61eCG1ak5Q0x/SDcC4utkRMyqVVvSd5EdeGHzrpdlWCH7NOznHlf/MWzT64zj2j0sW9q69tzQ==
X-Received: by 2002:a63:8742:: with SMTP id i63-v6mr3650057pge.27.1537931343814;
        Tue, 25 Sep 2018 20:09:03 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 203-v6sm4684105pgb.14.2018.09.25.20.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:09:02 -0700 (PDT)
Date:   Tue, 25 Sep 2018 20:08:58 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180926030857.GA458@Asurada-Nvidia.nvidia.com>
References: <20180925225930.31886-1-nicoleotsuka@gmail.com>
 <20180925225930.31886-2-nicoleotsuka@gmail.com>
 <4f16baf7-b1bc-c7d2-3dd9-ed10b78d59b6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f16baf7-b1bc-c7d2-3dd9-ed10b78d59b6@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

On Tue, Sep 25, 2018 at 06:52:29PM -0700, Guenter Roeck wrote:

> > +2) child nodes
> > +  Required properties:
> > +  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
> > +
> > +  Optional properties:
> > +  - label: Name of the input source
> > +  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
> > +  - status: Should be "disabled" if no input source
> > +
> > +  Example:
> > +
> > +  input@0 {
> > +          reg = <0x0>;
> > +          status = "disabled";
> 
> I kind of feel embarrassed that I asked for the reg change ... especially while
> saying at the same time that I would like to see this work for other chips
> as well.

Well, though I didn't mention it, yet I changed it to "reg" is more
likely an agreement than a compromise: I searched in the mail list
and then found this mail (a year ago though):
    https://www.spinics.net/lists/kernel/msg2455439.html

I feel it very similar to my case. So rather than betting Rob won't
tell me the same, changing to "reg" may reduce a turnaround time :)

> Other chips have different kinds of sensors. Voltage, current, power, temperature,
> and others. Whatever we come up with should support that.
> 
> I see two possibilities right now. We can stick with reg and add a "type" property,
> or we can make the index something like
> 	{voltage,current,power,temperature,humidity}-{id,index}

One small concern is a case of being multi-type. For example, I saw
ina2xx driver having voltage, current and power at the same time...

> I personally prefer "type", but I don't really have a strong opinion.
> What do you think ?

I also like this over "reg" -- "reg" requires two extra properties,
and itself sounds slightly unnatural to me for situations like this
one where we don't use it as a register address, although I know it
is convenient and common to use.

> Or maybe we should really wait for feedback from Rob.

Personally I don't mind it all to change the doc and code and then
send a v6. But eventually we'll still need the final Acked-by from
Rob right? Then I guess it's the only option.

By the way, I have two ina3221 hwmon patches that rebase upon this
binding series. And I'd like to send them out to go through review
first, but I am not sure if you'd be okay for it -- I don't really
like to change their rebase order as it might mess up something.

Thanks
Nicolin
