Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64509C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F269020647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UAdZd1qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F269020647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeH3CuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:50:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10708 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeH3CuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:50:11 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180829225101epoutp029f2e483e507c4e55f5dc60f5a361e623~PfKinGEjM2139021390epoutp02f;
        Wed, 29 Aug 2018 22:51:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180829225101epoutp029f2e483e507c4e55f5dc60f5a361e623~PfKinGEjM2139021390epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535583061;
        bh=a7qQ9hDq2RU1lG12s1YMnqlL27J65pi2BxqqVb+7ysY=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=UAdZd1qZhFDl5bfSykY1nBLwRDYJbe9s19Ie8x3SzPt2s6Aot2K2K7GJFMpoHKdIt
         ij79cIxpo6sadpVcUpyTWlikmer5+r6+YIvIGvSOuBp1UEStkS6/kMUovBz8fpqC3B
         VJatejHyd+prB5WNoswUFvf4e4LJF6+mTzlp/tac=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180829225059epcas1p1635ce95db1d8cafd0c3458938d79e5f1~PfKgDzLK52619426194epcas1p1e;
        Wed, 29 Aug 2018 22:50:59 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.C2.04211.253278B5; Thu, 30 Aug 2018 07:50:58 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20180829225058epcas2p11d847fd99651c34e83b8150af359e135~PfKfsn_Gb3058630586epcas2p11;
        Wed, 29 Aug 2018 22:50:58 +0000 (GMT)
X-AuditID: b6c32a48-089ff70000001073-b9-5b872352ae50
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.D5.03703.253278B5; Thu, 30 Aug 2018 07:50:58 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PE800KCMVGY0580@mmp1.samsung.com>; Thu, 30 Aug 2018 07:50:58 +0900 (KST)
Message-id: <5B872352.6030304@samsung.com>
Date:   Thu, 30 Aug 2018 07:50:58 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Greg KH <greg@kroah.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rafael.j.wysocki@intel.com, chanwoo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Add new name attribute for sysfs
In-reply-to: <20180829105738.GA26948@kroah.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmuW6Qcnu0weqrNhYTb1xhsTi3YAaj
        xdmmN+wWl3fNYbP43HuE0eJ24wo2i8cr3rJbLNj4iNGBw2PxnpdMHptWdbJ5vH0Y4NG3ZRWj
        x+dNcgGsUak2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
        OUCnKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslaINDY30DA3M9YyMgLRxrJWRKVBJQmrG
        9i8LGQua+Cqm3r3C3MB4gbuLkZNDQsBEounCRJYuRi4OIYEdjBIXn6xmg3C+M0qs7p/IDlN1
        rWUHK0RiN6PE5xtP2UASvAKCEj8m3wNq5+BgFpCXOHIpGyTMLKApsXX3enaI+ruMEh0HOpgg
        6rUkrh7YywpiswioStzfthLMZgOK739xA2wmv4CixNUfjxlBbFGBCImd87+BHSEiICPRsWQP
        2FBmkCNWnr0NViQs4Cwxcfl7sCM4BfQlJk0sA6mRELjOJnFuym9WiA9cJJr33YSyhSVeHd8C
        9Zm0xLNVGxkhGtoZJb68aGaFcCYwSnw4tZkJospY4tnCLiaI3/gkOg7/ZQfZJiHAK9HRJgRR
        4iHRtb4RrERIYB+jxOUXcRMYZWchBdIsRCDNQgqkBYzMqxjFUguKc9NTi40KTPSKE3OLS/PS
        9ZLzczcxglOclscOxgPnfA4xCnAwKvHwXpjRFi3EmlhWXJl7iFGCg1lJhJfrHFCINyWxsiq1
        KD++qDQntfgQoykwjCcyS4km5wPTb15JvKGpkbGxsYWpuaWxgaWSOG+VX3C0kEB6Yklqdmpq
        QWoRTB8TB6dUA6Pnnc+venPyXq5n4Pi7NvT5Ujt7n48M3Xdq5t1cfdBtivjPN2L350aeSNFM
        OSS7ZmmDes+ZFw/b3YucnP/sXt+b03N0h9+ea1tuhq01ZZM9Y3AiU5Yl9Ee8xBWdG2fmNWy5
        qSPCxbzL8HfWt+8TtN99mNl/d8kidvdjt6XioxMWy1ttY/EQmaCixFKckWioxVxUnAgAowru
        qIcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t9jAd0g5fZog7sblSwm3rjCYnFuwQxG
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFo9XvGW3WLDxEaMDh8fiPS+ZPDat6mTzePswwKNvyypG
        j8+b5AJYo7hsUlJzMstSi/TtErgytn9ZyFjQxFcx9e4V5gbGC9xdjJwcEgImEtdadrB2MXJx
        CAnsZJTYeqKDBSTBKyAo8WPyPSCbg4NZQF7iyKVskDCzgLrEpHmLmCHq7zNK/D35gxmiXkvi
        6oG9rCA2i4CqxP1tK8FsNqD4/hc32EBsfgFFias/HjOCzBQViJDoPlEJEhYRkJHoWLKHHWQm
        s8BuRom7/3+B3SAs4Cwxcfl7MFtI4ACjxI4t2iC9nAL6EpMmlk1gFJiF5NJZCJfOQnLpAkbm
        VYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5uZsYgQG/7bBW/w7Gx0viDzEKcDAq8fBemNEW
        LcSaWFZcmXuIUYKDWUmEl+scUIg3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB9MSS1OzU
        1ILUIpgsEwenVANja8OhFU6Tbq9/5m1/PMb7pNj2z/+mlAUnFk8MPH1mfnuVep+n058b25sf
        xoW0Xj3KGSQqEvvhePbf7x+itjwJ+z5tYt4Zsw3/rF7Wns7yTNZVDnVRO6CfsrLO5+68uAn/
        rvdwzvm7PsRWrEj0699eTrYq7TIT/4CzzjKRG3JF0t3i3sWWMZ9WYinOSDTUYi4qTgQAfRkM
        KnQCAAA=
X-CMS-MailID: 20180829225058epcas2p11d847fd99651c34e83b8150af359e135
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122
References: <CGME20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122@epcas1p2.samsung.com>
        <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
        <20180829105738.GA26948@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On 2018년 08월 29일 19:57, Greg KH wrote:
> On Wed, Aug 29, 2018 at 04:34:06PM +0900, Chanwoo Choi wrote:
>> commit 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for
>> sysfs") changed the node name to devfreq(x). After this commit, it is not
>> possible to get the device name through /sys/class/devfreq/devfreq(X)/*.
>>
>> Add new name attribute in order to get device name.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for sysfs")
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 11 +++++++++++
>>  include/linux/devfreq.h   |  3 +++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 4c49bb1330b5..2145563d5ee5 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -620,6 +620,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	}
>>  	devfreq->max_freq = devfreq->scaling_max_freq;
>>
>> +	devfreq->name = dev_name(devfreq->dev.parent);
>> +	if (IS_ERR_OR_NULL(devfreq->name))
>> +		return -EINVAL;
>>  	dev_set_name(&devfreq->dev, "devfreq%d",
>>  				atomic_inc_return(&devfreq_no));
>>  	err = device_register(&devfreq->dev);
>> @@ -1261,6 +1264,13 @@ static ssize_t trans_stat_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(trans_stat);
>>
>> +static ssize_t name_show(struct device *dev,
>> +			struct device_attribute *attr, char *buf)
>> +{
>> +	return sprintf(buf, "%s\n", to_devfreq(dev)->name);
>> +}
>> +static DEVICE_ATTR_RO(name);
> 
> You need a new Documentation/ABI/ entry for this.

Thanks for comment. I'll.

Best Regards,
Chanwoo Choi
Samsung Electronics
