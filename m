Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE53C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062E4206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uta+e6d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062E4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeIXGKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:10:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43736 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIXGKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:10:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so8271228pfi.10;
        Sun, 23 Sep 2018 17:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t8eNVGf+mb8xAyFzpH/TeE4oZrfbbhxUCkVUaQHIwkw=;
        b=uta+e6d+edYbiA7B3z7kS6pxbCBvSB6di7oDc3xEx5wTKoy+okwnVkSK1XUjd+2JTe
         OA4huIAYms0GUZcp/c2nF3CzR9Non+WpvHt+wBD1+4JPaRjASuPuda4i2ZKZjpulFVCX
         5e4nLJ/pR63XrHNyWi5MqMKHBjjJjUSjbxOP56xSsP5lOb3k6xyYHIp6wpmabza3P91Z
         mizxxN3HOZnF4zpudZOILs9EszE3SvcHL8jqHf/940IIWV9bYu91nRDdZQRz3Jkj43Ow
         XVvZYLdI1N7gf/wXxDhBlJzZ26RCGIB8HIvVv4rC4EgY4sORcNLS/v3fVuGja9TSQNEm
         kM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8eNVGf+mb8xAyFzpH/TeE4oZrfbbhxUCkVUaQHIwkw=;
        b=VLLkG4JmOiZs8BYmBbC8/YKBaM55oBG+mADytMyjQZqoUzEgK3AQz5xc8N2GDG8d5H
         F8jSjJL80ORj7xQiqn/vLHxasM8n/eiXEmkp7Yo4zq2/0N8rya1lvQRyChjkBVoqUgys
         wCGzf0cTWLA33zqJY08wx6Lemrtsm8xAv+VDqW/0co2QgV5fWrxN6gNt0DVX+2FcTh1a
         84wOi379o6VABVWuxk0YBVYocVAoIP0qf11PIV7+/JA93zIaPLK/dWT0TXz6g522NMOB
         kQ9w0FbaqiF9nhq0zIEqAN8YmgeDefu0Ht1QUnPF2ipogimOuDMXsthCA2ZRpJ8zjgOb
         EFIA==
X-Gm-Message-State: ABuFfoiXrh+vWznxVT+HrdlFbNCT05yr48u4ftrTOUm1fkV/8sF/O7Ao
        MQY1P+7XDrcvKlx1QSm1m/U=
X-Google-Smtp-Source: ANB0VdY/ojQcN0iNdaDo3KnRbGjqL+WAwfsxQAzGI0bfCKspgscigw21poh7GVKFYbtri5BByLUM/w==
X-Received: by 2002:a63:7d43:: with SMTP id m3-v6mr1431071pgn.341.1537747833424;
        Sun, 23 Sep 2018 17:10:33 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id a2-v6sm33087394pgc.68.2018.09.23.17.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:10:33 -0700 (PDT)
Date:   Sun, 23 Sep 2018 17:10:25 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180924001025.GA7496@Asurada>
References: <20180923041118.8743-1-nicoleotsuka@gmail.com>
 <20180923041118.8743-2-nicoleotsuka@gmail.com>
 <353ccbbd-94c8-72eb-eb98-8a0507431e15@roeck-us.net>
 <20180923053151.GB9960@Asurada>
 <ce76fdf2-2894-96ad-d2f5-b2c25f197ee4@roeck-us.net>
 <20180923060120.GA8872@Asurada-Nvidia.nvidia.com>
 <fe5c9570-70f8-d54d-509e-fce3733a4145@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5c9570-70f8-d54d-509e-fce3733a4145@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 11:36:22PM -0700, Guenter Roeck wrote:
> >>>>>+  Optional properties:
> >>>>>+  - input-label: Name of the input source
> 
> Just noticed the "input-" here. Please just use "label".

Will fix in v5.

> >>>>>+  input1 {
> >>>>>+          input-id = <0x1>;
> >>>>
> >>>>We'll have to find a better name for this. Feel free to look up examples in the
> >>>>existing devicetree descriptions. The one that seems to be used most of the time
> >>>>to indicate a channel index or id is "reg". It should also start with 0 - there
> >>>>is no real reason for it to start with 1; it only makes the code more complex.
> >>>
> >>>The reason is that the port start from 1 in the datasheet.
> >>>
> >>
> >>Maybe, but for me I'll want to have something that we can reuse for other chips.
> >>Having the index start with 0 for one chip and with 1 for another would be
> >>confusing. It is bad enough that we have in[0..n] for voltages and temp[1..n]
> >>for temperatures. I would not want to see the same in devicetree files,
> >>and much less so on a per-device basis. It is also pretty common to start
> >>channel numbers with 0 in devicetree files.
> >
> >Understood. I search a bit and saw most of "*-id" start from 0,
> >although I cannot be sure whether their Datasheet/RM/schematics
> >are counting from 0 or 1.
> >
> >And I also found a transposing example:
> >     Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
> >
> 
> You'll always find an example for anything in the kernel. In this case,
> it is for one specific chip. I'll want this to be reusable as template for
> _all_ hardware monitoring chips.

I see.

Thanks
Nicolin
