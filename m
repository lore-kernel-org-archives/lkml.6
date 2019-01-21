Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFBC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E554E20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iNng+F4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfAUOau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:30:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48364 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfAUOat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:30:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0LEUcvW078902;
        Mon, 21 Jan 2019 08:30:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548081038;
        bh=LofKKZaIxg/eNHhR3aW7yKb4VdXVlJz3p+laRi4U8q4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iNng+F4AK1HqBaX8KXdUG+E62X09NhA+j8ZKJISL09dyYEy0YUEJRp7i9v3bUGQH+
         uhgWe96JDmX4RhC5yXPDivXhFdyywgI2QOiB5UoMAIquxExDIxga8ZykSlk6jfAoyg
         zvaVM0h/Mb1V/0xhVv7So7pRHKGXgyCD2oOYoXGM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0LEUchw060682
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 08:30:38 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 08:30:37 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 08:30:37 -0600
Received: from [172.22.75.231] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0LEUbJa028006;
        Mon, 21 Jan 2019 08:30:37 -0600
Subject: Re: [PATCH 11/14] staging: android: ion: Allow heap name to be null
To:     Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-12-afd@ti.com>
 <20190116152807.phyq5pqrmbkj6oxk@DESKTOP-E1NTVVP.localdomain>
 <39453e0a-2db8-3a59-1909-e02caa9afa31@ti.com>
 <042dd3b1-9a41-2a76-270d-1c992d782c40@redhat.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <5c8fecd6-e8d5-127f-8271-8f91d8bfeb49@ti.com>
Date:   Mon, 21 Jan 2019 08:30:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <042dd3b1-9a41-2a76-270d-1c992d782c40@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 1:53 PM, Laura Abbott wrote:
> On 1/16/19 9:12 AM, Andrew F. Davis wrote:
>> On 1/16/19 9:28 AM, Brian Starkey wrote:
>>> Hi Andrew,
>>>
>>> On Fri, Jan 11, 2019 at 12:05:20PM -0600, Andrew F. Davis wrote:
>>>> The heap name can be used for debugging but otherwise does not seem
>>>> to be required and no other part of the code will fail if left NULL
>>>> except here. We can make it required and check for it at some point,
>>>> for now lets just prevent this from causing a NULL pointer exception.
>>>
>>> I'm not so keen on this one. In the "new" API with heap querying, the
>>> name string is the only way to identify the heap. I think Laura
>>> mentioned at XDC2017 that it was expected that userspace should use
>>> the strings to find the heap they want.
>>>
>>
>> Right now the names are only for debug. I accidentally left the name
>> null once and got a kernel crash. This is the only spot where it is
>> needed so I fixed it up. The other option is to make the name mandatory
>> and properly error out, I don't want to do that right now until the
>> below discussion is had to see if names really do matter or not.
>>
> 
> Yes, the heap names are part of the query API and are the expected
> way to identify individual heaps for the API at the moment so having
> a null heap name is incorrect. The heap name seemed like the best way
> to identify heaps to userspace but if you have an alternative proposal
> I'd be interested.
> 

Not sure I have a better proposal right now, I'll re-work this patch to
force heap names to be populated before ion_device_add_heap() instead.

(do you think that function name is now is a misnomer? how do you feel
about renaming that to just ion_add_heap()?)

Andrew

> Thanks,
> Laura
> 
>>
> 
> 
