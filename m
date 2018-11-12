Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786D6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CC62087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CC62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbeKLLmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:42:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:36655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729780AbeKLLmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:42:52 -0500
Received: from [192.168.181.61] ([218.18.229.179]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LpL4H-1fsRKY0Lob-00f96H; Mon, 12
 Nov 2018 02:51:47 +0100
Subject: Re: How can I get user space tools of erofs?
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "liguifu (C)" <bluce.liguifu@huawei.com>,
        "fangwei (I)" <fangwei1@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <cce741a4-8e15-a48c-070e-d16d71b864c3@gmx.com>
 <923d8f98-bd0c-47e1-63a5-512547d6a77d@huawei.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <24438b2f-1676-3718-18cc-7c99aa2a7741@gmx.com>
Date:   Mon, 12 Nov 2018 09:51:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <923d8f98-bd0c-47e1-63a5-512547d6a77d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:7x8X3nf77q7qq6f1xlC5bcMs0yahk+g4Uob038b9vYkeseZCu+N
 L7soQKCzl35NT0xz/bRTz14WFaaZZkJ3hfAyinK491v0XaFVnyj8o1cYR0UwuAcO/tvs8R1
 kLHZSrHmZw6mk9zzKMitxBnP7M7gW0CisJ+3kgP6AGxtjR1Q5lHCvmkcKXsTm+zy08QTPG7
 57xdS749uUggJxxiaF7LQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U+YrII3e6oE=:K1yTunh7IXGAguWe/YoDTZ
 QDY0reeFhbLL+29PD1ef/3OraegvWGNmIpqjqPg4Q1SRybwHWDTfFZWKYe6SXYcWRJLsVON8G
 9H6hIzDIpwXKmB18Brfsg9iNzOCGng+9FuA/rjlzXsDivmqxUXr68uN6b2tgS4XBHEFmPMksx
 9OkXpgET7PSBNmoAQwolw6WjyNO2aBvzeTeoxgxrxk4OUcsMNF+J6QsWi+e3VyJaGdAZKEQq0
 c/KV85na/IdNRC7pc+G+9+mkBtkZIvYZeBSGe7qEvenkAMCxaIePozDOhh6zmErJBIS8EQojg
 74KhiJK4dGZRA2f1zrl42s+7fnWRYJ+qxpsuG5JKiVmDcCBQsPnoYR9t4WCgKnE/JTDwEVvqG
 xvKWp23Grh2Y5ZcEUvVT15n422bWeQJ6uG7A87ayQdlkUk0ch5Xell7s4dkp594xLzazDT6VK
 IlB9T7Hxdg0Qm8O7s8GlkvvZLWG6t0eKGctFyZG6UsjUmhslyBbQhSkHU7z0PH/IRdtShlqjD
 v8uJ2FGcxUefdJO8n3wijoQmOE1gd5Q327iA4njWVYupZ47AI1dvMrktzOOE3Y/npxrc2Plqs
 7jXAqAsfMMfKWIRQX7ggUiDuQFT91DXLj4VGisNV5kmUVib2ZY2vpYgcikZeyj2mO3jxO2bm1
 uybHMEdK3ejP8R9MezHpdw/LGzmSpsXVcZmssSDSWxqcY5Nm/JeTVmqQwqwzXGbG+X7dhOuGe
 p8vv7bcVhtQG+HZQELYjZFkjslZ55ePjEad08BzD2EcTEsYvkeXzBJ2UF9AD5myMKz9K7ihzW
 RlFeCfL3k5hpsQQqu39NeWBZ86VFMvZAktCdf9XjhWxKEqcTYgkJGqOnQ27O/zLdOTLPVeYLV
 KSM8pw2qT/9WPG/Z91DYcuhYz312RQCWHGyz+STJ3AtRdHGTjwYUhn8LYMyFid
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Chengguang,
>
> Good question! It's in the final stage of preparation to open source erofs-mkfs (actually they are now struggle at how to properly spilt
> into reasonable patches this week), hopefully the implementation could be released at the next week. (sorry I didn't mean to delay,
> I have to put it in the first place --- successfully launch our linux-erofs products to the market)
>
> @Guifu Li <bluce.liguifu@huawei.com> is the original author of erofs-mkfs, he will post the original mkfs source code to linux-erofs mailing list
> and he will maintain erofs-mkfs together with @Wei Fang <fangwei1@huawei.com> later. You can contact them for further informations.
> ---  these piece of code is actually not clean enough (a lot hacked/dirty code compared to the kernel code) so a lot of cleanup will be done then.
>
> currently, you can get erofs-mkfs binary from (still sorry to say that...):
> https://github.com/hsiangkao/erofs_mkfs_binary
>
> erofs is now in productization for these months, if all things go well, you'll see that HUAWEI mobile phones on the market run in erofs in few months. :)
>
> These months I'm busy in solving bugs found by internal beta users and tuning memory policy in heavy memory workload for the best performance compared to ext4
> (we have native in-place decompression compared with squashfs/btrfs, thus less extra memory allocation results in lower memory memory reclaim / page-writeback
> for devices with limited memory, see: https://lists.ozlabs.org/pipermail/linux-erofs/2018-August/000494.html) in order to gain the competitive user experience
> comparing to uncompressed filesystem solutions. I will update a document to describe our core design and linux-erofs future roadmap in this linux-4.21 round.

Hi Xiang,

Thanks for your detail explanations!

Chengguang



