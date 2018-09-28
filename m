Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CDC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32C4206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0la1++K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32C4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeI2CJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:09:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44287 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeI2CI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:08:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so5147728pgu.11;
        Fri, 28 Sep 2018 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qaPhD6rv8H89D7FJbfdnco6OZQTc6wBSoptqEJoVefg=;
        b=L0la1++Ko4JUBdPvRXO2icIbw5IY1p3cE22UDvKo3xGZ5qYOBLGt5wkhExKUJMfg6X
         6R6K5vdge37mQytFGnZVM7SP8HR6krvXygH2iRiIQLeZD4IkDHQSlfnFs5sF20qoSMBt
         OmA984k7WorJMCnrQEph+8GiHdcINRAN+Gij22EkxxRRCEwWE1JqJkyiOFOGpozv1cln
         z8Cwm3pu4Y0mUW8uEO4mbUPHyG4UD8jBgNM0mRautZ2bHc73mSuwnJYBmSQEoDkEmUB5
         /JTKEFGpDWsLCHRdmqXJsOWqMrupqQhk1a87ZozpMV7lfEORmB9frVrkKRneW4zpipwG
         OixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qaPhD6rv8H89D7FJbfdnco6OZQTc6wBSoptqEJoVefg=;
        b=tSTnv9Ii/VZjQSNa1gXn542D+IWzSoMNOAzZTnVCNa5J7u6mpXDFsvS/YhIxERQqkr
         oU853YhhjDcMEkLWeh0wL9huQM5rftsVCQqN6rYXeaJeQ9Pzmlhd/FKyQkYOxGwoQjM1
         GFR2TDJlmND4+rgYi0bllShp86EstPxeiojFGN+l3HMhbteG4P5nzrmi/YUgllu99yTZ
         I9+93y8kGHmyb4z1s5WGMViyRfW5pD0sA3kUeGoKev0057fRm/T9r8eRrqUndbNZ4QqU
         u+HVObfSOOSzSp7rpUOiCkl9zuW0Nt/FolIl7NL7DuXutr/G7SQeZN9pgt9TY+BIaR9m
         u2Sw==
X-Gm-Message-State: ABuFfojncJHDNpPueRiIMNxoQR9tGdht6AuhEqC4RhghMSbp8w1FopE6
        YsaeB9VPABEwl+L1S7t/rZg=
X-Google-Smtp-Source: ACcGV6365sUTWzdOq8ocJpwKVKkB1rOXhfyHa0pd1EIa1HPQ9PRuP/hM2OMrvXje0ogzebkHycxqMg==
X-Received: by 2002:a17:902:6907:: with SMTP id j7-v6mr112200plk.232.1538163823229;
        Fri, 28 Sep 2018 12:43:43 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 77-v6sm8181310pfw.159.2018.09.28.12.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 12:43:42 -0700 (PDT)
Subject: Re: drivers binding to device node with multiple compatible strings
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ecbf11cd-a140-fe7e-392a-bccbf8224d14@gmail.com>
Date:   Fri, 28 Sep 2018 12:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ Frank

On 09/27/18 15:25, Li Yang wrote:
> Hi Rob and Grant,
> 
> Various device tree specs are recommending to include all the
> potential compatible strings in the device node, with the order from
> most specific to most general.  But it looks like Linux kernel doesn't
> provide a way to bind the device to the most specific driver, however,
> the first registered compatible driver will be bound.
> 
> As more and more generic drivers are added to the Linux kernel, they
> are competing with the more specific vendor drivers and causes problem
> when both are built into the kernel.  I'm wondering if there is a
> generic solution (or in plan) to make the most specific driver bound
> to the device.   Or we have to disable the more general driver or
> remove the more general compatible string from the device tree?
> 
> Regards,
> Leo
> 

