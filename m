Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F9BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D66620684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFgvpfdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D66620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeGSUks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:40:48 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55613 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeGSUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:40:48 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so11541128itl.5;
        Thu, 19 Jul 2018 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iS2GgiyWWWpvgTQenXD6VRfE6pOocKynOnIZDpEtluQ=;
        b=UFgvpfdJczXQSlA3avLfzfI84FEK7/CwH87fbCeJrkPx2iEySvaW9grFL1N/mdiw86
         Mk8vk3qnByrh3U32bAESxp9pWVyXX4zF2M0YuQqeG4H+TjGk0+N+PLaftBwRLhcHLKbe
         FU2hZpqQLp1JcCn4yvqsptYO8GQ7WXuJoEwhMs3iWtM92pvE4DvDQx2Fm2J5aWMtu/JT
         qI2AbmeuLPwOwEO6BABnEOimo0y/GTV48irqjcfP1ttwh0IPCIfJoPKfyJhwH3xg7Yza
         /dW5rSEHSqQ2HH1fZojdZKLW7+ANPQVgN+ZMs8zgTsiElLJK8wyxvA4+pt2RZgbofHFC
         2Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iS2GgiyWWWpvgTQenXD6VRfE6pOocKynOnIZDpEtluQ=;
        b=oDp/X2LT2IGE8+Yaa+6vF9HZSeaVnwOBn4H+a1bhbMIuaGzBnMVMis3CSH1sw91VDy
         JOKYumb6SMzGXuw533KT2S77SZ/6WHu2wgZFCScFuDXXhbrqGL88SiNideZ73Eo/MryH
         JHHcjrvBh6AMqsEk6lY9Q3Jpj5He1pdLf2pBumzR4RyvcH+ZXrRf6oN9dLpD7+FKrw9Y
         TmlvuBahvuTjM93hPJfPV/ihl23PrqMO0r8K5aXtxPllTBt6okCnwOrW8oZr7MDvKm37
         MU3LVmrUh11JqFqUnrCexjA4dIXuaAVRiSW2A1eayXnWIi2kOm3nF0ztHVX6m6efBEof
         ehKg==
X-Gm-Message-State: AOUpUlHD611CMImZZd/g1DZxvmEmPGPqn0R89JFNu3Hrooxs0yGC1HCY
        0mZIqXnyPxE+X+oA2GgodmcNW2glCik=
X-Google-Smtp-Source: AAOMgpdKu8C6XT+RoMxiZ5/GoFFiy3/qbLd3QXlZ2eOziM15y3BtZ5sfQQAQjeODdpzd7duEfA3Ovg==
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr10966382jam.61.1532030168501;
        Thu, 19 Jul 2018 12:56:08 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm189583itb.29.2018.07.19.12.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 12:56:08 -0700 (PDT)
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To:     Sinan Kaya <okaya@kernel.org>, bhelgaas@google.com,
        keith.busch@intel.com
Cc:     alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <494a5df8-0987-3a6c-30a4-a3c9ef4ed1f3@kernel.org>
 <37509c44-64fe-4140-c776-53c3346cbfe5@gmail.com>
 <da6335db-1e6b-c19b-4bbd-0f5523484e0e@kernel.org>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <61c8a5d7-d520-e927-071a-bf5620bc0f4e@gmail.com>
Date:   Thu, 19 Jul 2018 14:56:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <da6335db-1e6b-c19b-4bbd-0f5523484e0e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/19/2018 11:58 AM, Sinan Kaya wrote:
> 
> On 7/19/2018 8:55 AM, Alex G. wrote:
>> I find the intent clearer if we check it here rather than having to do 
>> the mental parsing of the state of aer_cap.
> 
> I don't feel too strong about my comment to be honest. This was a
> style/maintenance comment.
> 
> It feels like we are putting pcie_aer_get_firmware_first() into core
> functions unnecessarily after your change. I understand the need for
> your change. I'm asking if it is the right place or not.
> 
> pcie_aer_get_firmware_first() should be called from either the init or
> probe function so that the rest of the AER functions do not get called
> from any other context.
> 
> If someone adds another AER function, we might need to add another
> pcie_aer_get_firmware_first() check there. So, we have unnecessary code
> duplication.

We could move the aer_cap and get_ffs() check into one function that we 
end up calling all over the place. I understand your concern about code 
duplication, and I agree with it. I don't think that at this point it's 
that big of a deal, although we might need to guard every aer_() call.

So moving all the checks in a pcie_aer_is_kernel_first() makes sense.

Alex
