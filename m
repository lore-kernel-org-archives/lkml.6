Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D7920651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GTP5qre6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405886AbfAPRMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:12:39 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55410 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfAPRMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:12:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GHCTtr122280;
        Wed, 16 Jan 2019 11:12:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547658749;
        bh=9yh5RvztSaWujiBz6b5nKhFLd6k2r4HHS60blovpu98=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GTP5qre61HuKblMR9JAEyiPZjOZt9NV1BMJ/wQdl8wUXUNVyQwgsvsWQoUMvqt5b5
         J44LvlzCiaLd8AxRGmW4QWVJDc4ecu4/xNxWUAAyLOQK4pae8Ei2O00lFevakVn0YY
         gAvoHwhfS4Z+xV6ifdxECW3dgZTYSeVvdbpkRu90=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GHCTGU130209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 11:12:29 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 11:12:29 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 11:12:29 -0600
Received: from [172.22.93.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GHCS0k029522;
        Wed, 16 Jan 2019 11:12:28 -0600
Subject: Re: [PATCH 11/14] staging: android: ion: Allow heap name to be null
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-12-afd@ti.com>
 <20190116152807.phyq5pqrmbkj6oxk@DESKTOP-E1NTVVP.localdomain>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <39453e0a-2db8-3a59-1909-e02caa9afa31@ti.com>
Date:   Wed, 16 Jan 2019 11:12:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116152807.phyq5pqrmbkj6oxk@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 9:28 AM, Brian Starkey wrote:
> Hi Andrew,
> 
> On Fri, Jan 11, 2019 at 12:05:20PM -0600, Andrew F. Davis wrote:
>> The heap name can be used for debugging but otherwise does not seem
>> to be required and no other part of the code will fail if left NULL
>> except here. We can make it required and check for it at some point,
>> for now lets just prevent this from causing a NULL pointer exception.
> 
> I'm not so keen on this one. In the "new" API with heap querying, the
> name string is the only way to identify the heap. I think Laura
> mentioned at XDC2017 that it was expected that userspace should use
> the strings to find the heap they want.
> 

Right now the names are only for debug. I accidentally left the name
null once and got a kernel crash. This is the only spot where it is
needed so I fixed it up. The other option is to make the name mandatory
and properly error out, I don't want to do that right now until the
below discussion is had to see if names really do matter or not.

> I'd actually be in favor of making the string a more strict UAPI than
> allowing it to be empty (at least, if heap name strings is the API we
> decide on for identifying heaps - which is another discussion).
> 

I would think identifying heaps by name would be less portable, but as
you said that is a whole different discussion..

Thanks,
Andrew

> Cheers,
> -Brian
> 
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  drivers/staging/android/ion/ion.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
>> index bba5f682bc25..14e48f6eb734 100644
>> --- a/drivers/staging/android/ion/ion.c
>> +++ b/drivers/staging/android/ion/ion.c
>> @@ -467,7 +467,7 @@ static int ion_query_heaps(struct ion_heap_query *query)
>>  	max_cnt = query->cnt;
>>  
>>  	plist_for_each_entry(heap, &dev->heaps, node) {
>> -		strncpy(hdata.name, heap->name, MAX_HEAP_NAME);
>> +		strncpy(hdata.name, heap->name ?: "(null)", MAX_HEAP_NAME);
>>  		hdata.name[sizeof(hdata.name) - 1] = '\0';
>>  		hdata.type = heap->type;
>>  		hdata.heap_id = heap->id;
>> -- 
>> 2.19.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
