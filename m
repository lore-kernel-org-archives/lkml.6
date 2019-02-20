Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7407E2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="J/Ylsb72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfBTNJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:09:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45422 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfBTNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:09:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so25846563wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KIBRzC6nTwsgZsllJXcWpYUI1qjPsYTUFcYp1DPsGgg=;
        b=J/Ylsb72SWz+3+XX3OKv78JNIFsHj3LT41oOIFm8yY1xhWUeM9gv+wUfuDUP8idmLK
         mUUW/2QNTjxEHEuwBcRAYgAiUNkNmzH9hzQ7QmzDlFNUYunR0+moIVpsKPcq8RvYdFyP
         g1loGcQWuKWZRmgPxyOmaAt7MM5ftMSynJEco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KIBRzC6nTwsgZsllJXcWpYUI1qjPsYTUFcYp1DPsGgg=;
        b=cLLOvCWxAbU1dKVYOs4Q9grZ+2T10BHHP363vnEtv0yt+bVlMvTGnbSeIcLZJyd/WR
         Q4DMEN4g3ZHmdkBtZv2kkj9ZSf+m9I7YFZF2l4gsg2nVd/lqwZbW2ehaoOQjX4b7F/+9
         yVcEDyda9/lYQ32oU8fWsPz0O+0r7E22w37EEF6Ofsl4QDiS31tN334wOtQgT7j5Wyi5
         +rk7x6VJDJYp8Y1QiERcWLDUbdfbtt9h238DonnExLcPxSLXx/XCgt+WGS0lodvbNH7x
         I1W1vH3RJOw66gZKy3PmCkEmV86M5vXzBMc/tBc8aOcaOs5c438QtuXkOmAO7hnq6Mhn
         EDNQ==
X-Gm-Message-State: AHQUAubAt++qA0mQZx5cNSCHZ+UlkRKkCoye4hejH1CSyarOzP2HDNZM
        13f2PZXNRjMRCpahBmwKBuw87w==
X-Google-Smtp-Source: AHgI3Iaa4idPeSMe13nU5ox5H/56egp7QpygTvZs0G6f1rBnafbkMNEGQVU6igYpGlDlYMR1YpcIhQ==
X-Received: by 2002:a5d:6641:: with SMTP id f1mr25190287wrw.279.1550668163803;
        Wed, 20 Feb 2019 05:09:23 -0800 (PST)
Received: from [192.168.0.107] (79-100-158-105.ip.btc-net.bg. [79.100.158.105])
        by smtp.gmail.com with ESMTPSA id d24sm60634790wrb.47.2019.02.20.05.09.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 05:09:22 -0800 (PST)
Subject: Re: [PATCH 4.19 01/24] bridge: do not add port to router list when
 receives query with source 0.0.0.0
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ying Xu <yinxu@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
References: <20181102182839.725385066@linuxfoundation.org>
 <20181102182839.913422845@linuxfoundation.org>
 <07d315a2-d735-3d8b-686c-9c52acf91bf1@newmedia-net.de>
 <20190217164809.GA24091@kroah.com>
 <7978727a-eacc-779c-771f-f4c3013237f3@newmedia-net.de>
 <0425449f-f6d9-c492-d7c8-ba202db88d26@newmedia-net.de>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <962f3d1f-23eb-647c-74cb-b277212299e7@cumulusnetworks.com>
Date:   Wed, 20 Feb 2019 15:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0425449f-f6d9-c492-d7c8-ba202db88d26@newmedia-net.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2019 14:48, Sebastian Gottschall wrote:
> *reminder*
> 
[snip]
>>>>>    }
>>>>>    static void br_ip4_multicast_query(struct net_bridge *br,
>>> Is this also a problem in 4.20?  This patch went into 4.20-rc1, so it
>>> has been around for a while with no reported issues that I can find.
>>> Any pointers to the reports?
>>
>> i need to check this. i found this patch in 4.9, 4.14 and 4.4
>> the rest was picked up from the mailinglist. according to the git sources of 4.20 and 5.0 the same code is in there as well
>>
>> i just got the report from users today and was able to reproduce it with iptv streams. just by disabling the code it was working again.
>>
>> Sebastian
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>

Could you please include more details about the setup that's broken ?
Note that we were warned[1] of potential breakage from this change
after it went in and regardless of the suggestion from the RFC we'll
probably have to revert this patch.

Ying Xu as author of the patch, any thoughts ?

Also adding Linus Lüssing to the CC as he was the one who warned against it.
Note that the warning was sent as a reply to my breakage fix, but it was intended
for the original patch.

Thanks,
 Nik

[1] https://www.mail-archive.com/netdev@vger.kernel.org/msg272944.html

