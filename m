Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D41C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF99520880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqYbV+M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF99520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeIYTtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:49:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38794 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:49:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so21777576ljc.5;
        Tue, 25 Sep 2018 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=52d1pkZEyyjMGUj1pGDGzeqH/kccnRWlg0ghfV1RZ4E=;
        b=fqYbV+M5L+JJPPksxDHImATcYppo/RDF4Mr8bx0WzLE2KdoNgpTY6bbnxcjefG7l7g
         tj8IwtYqYEo00gyLIoxwlu6wyI9QBNn96WE4wQqbrCX2NqjvLVzkp4g0T8ydxoA+U2If
         u/TkSCGH1Jf04Djl95nJkbSID9FSZXl0gOK/l+dKY0n/VLzesn4et+XzOqejQ5ZQfJgl
         7qBpqpmtcbQchwIAgAaqOhDuqobF2pMmnRNHP8ThfhohkvrjyYmzFuh2FHvlKZ/vGAgb
         0TlgM64hb0+pBePKpiz/XJh4LTs0Z9DMcsWweVkwj52dQ8FWHzbpBZ+Iwodn+f6dIoqI
         I+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=52d1pkZEyyjMGUj1pGDGzeqH/kccnRWlg0ghfV1RZ4E=;
        b=M6VtHTyVKiAVMsuToXIkvcvLphYYYZ/nFHILAKuzr1aSCRzZMhwInKeW+V13pu7MoV
         hgOpznQqyh4mbIXAr6La/VYpEtGZ/FmDGNT0CP2ZnOGpwDQ0mPtx7do05DeVkZKpfqt/
         z2rLejoWnkjFHbPQQNepKDNAAGemBQKhSZvH21j/8ZbhVqlkrrrxi8Fa7TL1K57fDQq+
         H2DXFQmNn7TIpWr0SrqkgpoxomjoqhuXkuc1GitWbswivuvC/1XXl0hbxQ7r9nOk0MhS
         +DydtCYNAYWIQJ3iLsHpC5PwiCw7Vc56k7WsE/bggQuiyEKUi4ylFc7KEg6daOPIzqnR
         qXXQ==
X-Gm-Message-State: ABuFfoinD2xvO6Q03EStpj3Tw4tQNs/5mlwrU0R1jBs57hDnQqMjvJkW
        MjGzD7A+WhKalRCj/M+gWXcQ57+K
X-Google-Smtp-Source: ACcGV60Z50DNXkC6grj2/z6KsMy3qLKqFAKY37HruCJ76WE4XasSIW5SVv9Nwt4GRSnUqlLZq85gHw==
X-Received: by 2002:a2e:59db:: with SMTP id g88-v6mr1025076ljf.79.1537882888415;
        Tue, 25 Sep 2018 06:41:28 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id p21-v6sm429535lfc.5.2018.09.25.06.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 06:41:27 -0700 (PDT)
Subject: Re: [PATCH v4 16/20] iommu/tegra: gart: Don't use managed resources
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-17-digetx@gmail.com> <20180924105246.GM21032@ulmo>
 <a9e2943b-1139-8838-5440-bd6cf55e9a55@gmail.com> <20180925100330.GF7097@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c803c9bb-dc98-0c5b-791c-0569f1d6346f@gmail.com>
Date:   Tue, 25 Sep 2018 16:41:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925100330.GF7097@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 1:03 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 09:57:10PM +0300, Dmitry Osipenko wrote:
>> On 9/24/18 1:52 PM, Thierry Reding wrote:
>>> On Mon, Sep 24, 2018 at 03:41:49AM +0300, Dmitry Osipenko wrote:
>>>> GART is a part of the Memory Controller driver that is always built-in,
>>>> hence there is no benefit from the use of managed resources.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/iommu/tegra-gart.c | 12 +++++++-----
>>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> One benefit would be cleanup on probe error. Also, we may eventually
>>> want to make even the memory controller driver buildable as a module.
>>
>> Please, let's keep that patch as is and re-introduce devm once it will
>> become really relevant.
> 
> Alright, fine with me.

Thanks, I'm taking that as ACK.
