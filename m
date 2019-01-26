Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF65C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3182218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="W14fTDMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAZHwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 02:52:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37818 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZHwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 02:52:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id t18-v6so10253695ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 23:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d0NXBQe8aajlr098aMi4Ef9fbquF6GsoPb1AHlzJR8s=;
        b=W14fTDMsGq3FEMYqSmymjq0OJ9BYditxt3Vz+IFhmUEk+BJjlqDvkQbYijaePQaOcj
         E7P6ZyI8RDWkbxkGck2ZQy4o8UCfMugxzrfd3YQCO7KBkZkhlEBSw1ZPpvk2i21t7ugn
         vE+UXIr2I6dR11DN/TAP90su9L3n7WdosB6FqZ9eRm5LcfTnOzud5tcGOcbeGs1RK4XN
         t002SdOyiOK3HBzgGS5NAkJsXoEGEpDgrmYtkpGDrITiwDbLIhAteCGchK2Qjyzz6ZGj
         wbrbpXoqHN8VOpxyEQKspTXSPkLPiNbJsJh67ht8teK0NBYn+2R8dJk/COgr8E4R7RBA
         mCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d0NXBQe8aajlr098aMi4Ef9fbquF6GsoPb1AHlzJR8s=;
        b=GSkuDFd+VzucZqzfB9js+m2+u30Wk/ujZLyZ7sGd8VogrAuXWm/wivpHZsd309UZVG
         lX5ZrpljIT3J1wy3AamC5w47F7j9uInDCo2YqB4pVLXQfwzwkUCIf37//mYoTx58SqVR
         hMTRJlDm92KMcUPpQn76MX/XS29q1eeToP0RBAlk8BYWivGYXoNrPaWjQX7nV3yJ0XX/
         GC4T8QP9++s/zzVqxPbMkJjrkL3Hh6PQ+kS9vD1pcC2ZTD6gx5/CKTd2m6LCewFgKnXK
         b4ksHy9fQJ5Z6ku+DbvijO6EIqGU/XWy/q25BYWlbD//VZDWs6yLVk8ukrlh420/HAXZ
         4yoQ==
X-Gm-Message-State: AJcUukc7pY78nR0eZHsIcjMy4+pAD9e5EK1W/FpBvw5SmSwO4yu9ishs
        7Sp789y8jzaOt9+BxLtpkJ2jOg==
X-Google-Smtp-Source: ALg8bN4m2GN75I0rGtSXkI5EH+HWe0pWEil12JAxupwjCXz12H7RGzJlxVq4uLS7GUmzea2pkFlvlw==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr10740533lji.167.1548489151036;
        Fri, 25 Jan 2019 23:52:31 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id m21sm1962812lfl.97.2019.01.25.23.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 23:52:30 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
To:     Mark Brown <broonie@kernel.org>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
 <20190125174713.GA6939@sirena.org.uk> <20190125175031.GA25898@sirena.org.uk>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
Date:   Sat, 26 Jan 2019 08:52:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125175031.GA25898@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2019 18:50, Mark Brown wrote:
> On Fri, Jan 25, 2019 at 05:47:13PM +0000, Mark Brown wrote:
>> On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:
> 
>>> Having this as device property rather than a transfer property allows this
>>> to be configured one time in setup() rather than having to fiddle with the
>>> configuration register for every transfer.
> 
>> That doesn't mean that the coniguration should be done in DT though, and
>> given that this presumably is a property of the device there seems to be
>> no reason why we'd have it in DT - if every instance of the device is
>> going to need to set the property we should just figure it out from the
>> compatble string instead.
> 
> To be clear here: the suggestion is to add a parameter the slave device
> can set in spi_device which sets the default word_delay similarly to how
> max_speed_hz works.
> 

I'm confused... isn't that exactly what this patch does?  It adds a 
field word_delay to spi_device in the same manner as max_speed_hz.

I also added the ability to set it via DT, which I can break out into a 
separate patch if that's an issue.  Or is the problem that it's set via 
DT, at all?  Documentation/devicetree/bindings/spi-bus.txt documents 10 
other slave-node properties related to transfer characteristics; 
word_delay is just another such characteristic.

But again, I'm having trouble parsing your response  Is the patch wrong, 
should be broken up, or you just misunderstood it?

Thanks,
/Jonas
