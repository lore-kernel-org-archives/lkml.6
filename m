Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B00AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FB72075A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZssLbtQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FB72075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeIJHb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:31:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45327 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeIJHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:31:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so9651794pge.12;
        Sun, 09 Sep 2018 19:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=woGasLP9eCFLFm0cWT6vds2/J7Cc+SSE5nrEGOq4k7A=;
        b=ZssLbtQg8gAU9yG51GyLuyRa92yH+lfd0i2tl/YMcmzSmzOQ/E1yV/csrQXOl3GxRO
         3j4kgLwoiknN7vLZnsBS4NqUCnD3k9bDPw3Q9v1+Bb4YZ45gmBZH/UnNKEejbEPB6+Sw
         0ZZjQvl4Taw5GhgP5H2wr7p1Cn2aDfVsW+JInpCxdkNjHfbHFME5etoFJRFaHwQcunvB
         WUGjlkI4CtLXIeh/GVqU/dNmsSy/G0UWcf9eA4WJwibvgInH9QSh4zCojTXchgDTCu7p
         k6cJuw1q1DhLQJ6pqWC5IEv0PZ14CE1JcHS5E3RWVjCjZ7XiqP+U0J/63ZyPZ+Bxm48Q
         eetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=woGasLP9eCFLFm0cWT6vds2/J7Cc+SSE5nrEGOq4k7A=;
        b=myyw79XnH9IXkRJVainpvCLbr+jHUT2SRtKCwr3W0Q9sZDk4vRMFWvi84TlYacr8U+
         7YrP+Q3uzQePg5rTgsTA8zkckoTJM9PWZWR2k4H5ImoDid2c1U7cMWRxm4CYCUedi0pm
         k6T/MjHYwhgnjocJJRW8DE33pr80cqaibabqKOV2evaNfeGH7OsAtWO+81bOUV7q2afh
         J2/CN7aIFAliqwSypW0HahXM46WN6iS3bEQjrY8Gx8hbzNPkbJRtDcCS1jK3tN7EuwJ/
         R2S+Ox/qEnXhx+VSzkgP85mlqJhECTOLlgPQejz/GsTvQ9czrqEvXyW5ebvcYuE/NoRZ
         V6Ug==
X-Gm-Message-State: APzg51B2BccFg+VEZvi3R/lO6DzMX86j4OVU8FV86+l4ofej9gmAZSDb
        eacTPKUNXm+bXkQLNo9OIqgEEDzn
X-Google-Smtp-Source: ANB0VdZNE+IE+RAU3qSwwdwb5itTCs3IjnhMnH4Rue3nh47lmZlrO5TmWE2i1IzvFIwTYbEMXHm3gA==
X-Received: by 2002:a62:57dc:: with SMTP id i89-v6mr20565299pfj.45.1536537146945;
        Sun, 09 Sep 2018 16:52:26 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id w5-v6sm17222389pfn.44.2018.09.09.16.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 16:52:26 -0700 (PDT)
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     Stan Johnson <userm57@yahoo.com>, Rob Herring <robh+dt@kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frowand.list@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
 <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
 <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3d806f12-dd6f-63d7-92e0-0a79904dc4c9@gmail.com>
Date:   Sun, 9 Sep 2018 16:52:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/18 10:04, Benjamin Herrenschmidt wrote:
> On Fri, 2018-08-31 at 14:58 +1000, Benjamin Herrenschmidt wrote:
>>
>>> A long shot, but something to consider, is that I failed to cover the
>>> cases of dynamic devicetree updates (removing nodes that contain a
>>> phandle) in ways other than overlays.  Michael Ellerman has reported
>>> such a problem for powerpc/mobility with of_detach_node().  A patch to
>>> fix that is one of the tasks I need to complete.
>>
>> The only thing I can think of is booting via the BootX bootloader on
>> those ancient macs results in a DT with no phandles. I didn't see an
>> obvious reason why that would cause that patch to break though.
> 
> Guys, we still don't have a fix for this one on its way upstream...
> 
> My test patch just creates phandle properties for all nodes, that was
> not intended as a fix, more a way to check if the problem was related
> to the lack of phandles.
> 
> I don't actually know why the new code causes things to fail when
> phandles are absent. This needs to be looked at.
> 
> I'm travelling at the moment and generally caught up with other things,
> I haven't had a chance to dig, so just a heads up. I don't intend to
> submit my patch since it's just a band aid. We need to figure out what
> the actual problem is.
> 
> Cheers,
> Ben.

Thanks for chasing after this, and the current heads up.

I agree that we need to understand what is going on and do a real
fix.

-Frank

