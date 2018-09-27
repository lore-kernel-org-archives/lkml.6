Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4A7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC26E21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRaSr0tC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC26E21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeI0Hvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:51:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42675 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeI0Hvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:51:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so620852pff.9;
        Wed, 26 Sep 2018 18:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D7I6xTfT/7sUYa7/Oz+UIWJjNYUfcY/0Skj7gMv9VjY=;
        b=lRaSr0tC3srINb1Wuzrg/aVtsFquEu2tMD7yT+etkiqEWaaWC6FwRnQTW6c43quDLv
         tqCy11AuFBfeVCIP0SF0cx3O7LlrsCAoceROrWbzNkD6G2bAn7j4CkDVDefoCdzhWmV5
         EpdYVSlohuG9vv3KzDqswsvTvNbEFFqMeakhdcgeNo/VACdgtwW4S7V4tRwgt3Ygd/Nv
         4IKYYBDlyMf+OJ3YV+VU5YDODF6sa+lzPEUSmbdHnHRlowAi6kmUDAp518rZ4Itu3MeD
         rvmjKSfOFIZrOudKbhSgaPwciPvdmk6qWWw2UooAh3Jb1tv2fUGtewySzslsoI7p5fMb
         7miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D7I6xTfT/7sUYa7/Oz+UIWJjNYUfcY/0Skj7gMv9VjY=;
        b=nvrX3dOYx+uwAJKGrR0KO/IViy3ofrm4pg7r2Ax19/QiQ56jMpRuaGZfWxkNWDIEat
         QugVUEWjVL30PFGMy04l7Ld/grXw9sgFAlw2gS3hQc/FSiQGC3eXbVH1bEPJ60RW9hwq
         rJViCXzdgHg9f716VyMEH9xg3wSI7m5MoHYO0wU4IM3yciVpz1Mcp+E9AqE9jl4l29Yi
         ltDAY8J5iS/WfavROXLovH+1zzmf58bYHagt6wgt+CAjsEEAUSyx3zJcJFgly6wUWP/y
         vmZOC4L4gcxwEwf3X//bx4aIAdnJgklDgy/WATUdm0SpR62klIdMeAnkSi44gUvx5sb7
         tIIQ==
X-Gm-Message-State: ABuFfojaInOLIlaPN4Z0o8ppwOr6UVEf9lLzQn1nwHp3ZPZk43666Ep+
        TZW/elUwz4crAW1dxYNpzDM=
X-Google-Smtp-Source: ACcGV62xDWGK7FisQ0oRQp7YHYKoCvF/A7PSJqXppRuRqtl6dBFh8k34/oR4iTWb1asgE4SH580U7Q==
X-Received: by 2002:a17:902:26c:: with SMTP id 99-v6mr8372476plc.341.1538012157915;
        Wed, 26 Sep 2018 18:35:57 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f81-v6sm764304pfh.46.2018.09.26.18.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 18:35:57 -0700 (PDT)
Subject: Re: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
To:     Rob Herring <robh@kernel.org>, Andre Kalb <Andre.Kalb@sma.de>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM6PR04MB52394FDB1266388BCE1374E3FC030@AM6PR04MB5239.eurprd04.prod.outlook.com>
 <c0bcc2c1-3058-db4d-ca4d-4e56c502891b@gmail.com>
 <DB7PR04MB5243B6ADEBCB4B53B5A161F8FC050@DB7PR04MB5243.eurprd04.prod.outlook.com>
 <CAL_JsqKc1-Rz6iBJ_dpDrEDoFRpTaLR+1voXdTgiJjjG65druA@mail.gmail.com>
 <DB7PR04MB52433D93A8536DC7F71E169AFC1A0@DB7PR04MB5243.eurprd04.prod.outlook.com>
 <20180926210537.GA3143@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a3374cea-32b7-92e8-21a3-8bc14ed5ee2e@gmail.com>
Date:   Wed, 26 Sep 2018 18:35:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926210537.GA3143@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/18 14:05, Rob Herring wrote:
> On Thu, Sep 13, 2018 at 03:21:27PM +0000, Andre Kalb wrote:
>> Hi Rob,
>>
>> I have used an other hardware to check the patch. I hope it doesn’t matter. I added few lines at the untitest.c. All existing unittest use an attached sysfs, therefore the bug isn't detectable.
> 
> Okay, can you resend both patches in one series rather than pasted in 
> here.
> 
> Rob

I don't understand the need for the patch to __of_update_property_sysfs()
in the context of the current mainline Linux kernel.

As far as I know, there are no callers of of_update_property() against
a tree that is detached.  As such, the patch is adding complexity
without adding any functionality.

-Frank
