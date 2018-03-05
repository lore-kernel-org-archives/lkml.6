Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934831AbeCELrm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:47:42 -0500
Received: from mail-sn1nam01on0046.outbound.protection.outlook.com ([104.47.32.46]:20918
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932942AbeCELrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:47:39 -0500
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
Thread-Topic: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
Thread-Index: AQHTsGFsSC26PGMebEmm/OMzPYEJ7qO5evoAgAfSfxCAADo4gIAAACZggAABk4CAAAHNYIAAAUAAgAACMcA=
Date: Mon, 5 Mar 2018 11:47:35 +0000
Message-ID: <BLUPR12MB0449D174A98BC6740FDB0D4684DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1519800242-2442-1-git-send-email-Monk.Liu@amd.com>
 <fa9f8ade-000f-a9b5-0bc9-0dd3f10d9722@gmail.com>
 <BLUPR12MB04494D7F15FC7D557D58488484DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <f40975c4-c5df-c06c-9a6a-a96705232461@gmail.com>
 <BLUPR12MB04491D607CA17302B4E5524584DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <210b7a03-f309-8ab6-0f23-17377660e664@amd.com>
 <BLUPR12MB04495463743D454E9384C2B684DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <3baa1046-79b1-7c6d-644f-9aa921733ad2@amd.com>
In-Reply-To: <3baa1046-79b1-7c6d-644f-9aa921733ad2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR12MB0690;7:qi+WOsOk07uZl34ozNE7NR8UsT9e/CT1g2bohKSX3dO07HUy4iN8kQrNZzV3t0MACl9zTLMHr8xrW/NGkQfPIeU4hpmZWNrzmOYfRRP0PK7mH78QCEOC4WTN1k4EHJZB3doO9KmA9TnMhJFstOcTllg84RtVxL/R/XjgzaqID7CltoQd6vo1oMdBBbQDWFUQOoOrd1r2OfusngqqAEEsj/Sc+1DJtyVN3sO3aJ6RXEAQdvmryMSEZBLx4pyY2VG8;20:FM0oZHF5n++zCz4A8dryBqHQBRLp66UwrVs+v5nIyZWBjNF+9d0hXZ0vePhmve/RjCmzbk9OFIeTgJVA4LDnsj9NGoeGrHwHI/li/s2AN/RHXOC8Xg3bamKrJlIMI5ud7HVTMr3YoVHivXZtB9eJqv/SIqnPKDWTwFa8AxJ9wNdgvs9CuvjeqCLQwYo0NEKDIvKGKtRHImZCyEb3CLJwZXQQeI/jkyKoWRfhG8gXuQIN+ZeivpP4Rt7COg9VnQsE
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39380400002)(39860400002)(199004)(189003)(13464003)(6246003)(2900100001)(74316002)(305945005)(6436002)(59450400001)(2906002)(14454004)(8936002)(106356001)(3280700002)(86362001)(26005)(97736004)(55016002)(6506007)(2950100002)(316002)(68736007)(5250100002)(6306002)(9686003)(5660300001)(2201001)(7736002)(229853002)(2501003)(53936002)(478600001)(25786009)(3660700001)(76176011)(33656002)(53546011)(6116002)(3846002)(99286004)(966005)(66066001)(7696005)(72206003)(8676002)(102836004)(110136005)(81166006)(93886005)(81156014)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0690;H:BLUPR12MB0449.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc4409b4-e41e-4b0b-ea9e-08d5828ee33b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BLUPR12MB0690;
x-ms-traffictypediagnostic: BLUPR12MB0690:
x-microsoft-antispam-prvs: <BLUPR12MB0690BFA4F9B5DBC0AC3A9B6784DA0@BLUPR12MB0690.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110)(217544274631240)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR12MB0690;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0690;
x-forefront-prvs: 06022AA85F
x-microsoft-antispam-message-info: 6ReN/D3icpJLC2ZmpTHUOMHEJ6wDwBkG1tA1rvcA7UoLcIa5lzVeGUP1QpsSQpgMXEIUMk87TITOiPYSKK9/YqTiJIUcx1UTRnkKPq9Qb5lp9w1+A2pWxnsXDJkxC4fVthlvf2nODrJ9OpS3qzsSmTe7ruVpapRqeeZThNTBBtjkT0Q+s1TTiMgXfB2p1SSquTEqyO6Ujaq8gSwG3azxpEUCZ9mnJb5dOon9QuDffgJo/TMZCM1d41DH4xsgf9W6yy7vM6cbE1PReZRYGOCzfrb4fXnZ/Clzae9yNVaWMJU7wVm6rLvg3GdeiXoirlBZmAid4mfYpA3l1kDtw2n4bg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4409b4-e41e-4b0b-ea9e-08d5828ee33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 11:47:35.0553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0690
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w25BlkPU024514

Can you give more details ? thanks 

/Monk

-----Original Message-----
From: Koenig, Christian 
Sent: 2018年3月5日 19:39
To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot available

Am 05.03.2018 um 12:37 schrieb Liu, Monk:
> But the thing confuse me is according to the design, if driver keep 
> calling reserve_shared() prior to add_fence(), and with lock held of cause, That BUG() shouldn't hit, so there are two things in face looks weired to me:
> 1) by design in reserve_shared(), obj->staged should be already NULL, 
> so why we kfree on it

No, that is not correct.

> 2) in fact, amdgpu can hit the case that obj->staged is not NULL in 
> reserved_shared(), don't know how it lead here

We reserved a fence slot without using it, so it is still there when
reserve_shared() is called.

Christian.

>
>
> Any thought ?
>
> /Monk
>
> -----Original Message-----
> From: Koenig, Christian
> Sent: 2018年3月5日 19:29
> To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org; 
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when 
> slot available
>
> Am 05.03.2018 um 12:25 schrieb Liu, Monk:
>> And by the way, I add "if (staged!=NULL) BUG();" prior to 
>> "kfree(obj->staged)" in reserve_shared() routine, and this BUG() is actually hit, The stack dump shows it is hit during the vm_bo_update() in gem_va_update()...
> That is expected. The staged handling just makes sure that there is room available, it doesn't guarantee that it is actually used.
>
> E.g. we can end up reserving a fence slot, but then find that we actually don't need it.
>
> Christian.
>
>> Besides, the whole reservation logic still looks a little weired to me ... especially this staged part ...
>>
>> Thanks
>>
>> /Monk
>>
>> -----Original Message-----
>> From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com]
>> Sent: 2018年3月5日 19:22
>> To: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org; 
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when 
>> slot available
>>
>> Am 05.03.2018 um 08:55 schrieb Liu, Monk:
>>> Hi Christian
>>>
>>> You are right on that part of obj-staged is set to NULL in 
>>> add_fence, So my following question will be why we kfree(obj->staged) in reserve_shared() if staged is always NULL in that point ?
>> Good question, I haven't wrote code that so I can't fully answer.
>>
>> Maybe Chris or Maarten know more about that.
>>
>> Christian.
>>
>>> Thanks
>>> /Monk
>>>
>>> -----Original Message-----
>>> From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com]
>>> Sent: 2018年2月28日 16:27
>>> To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org; 
>>> linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged 
>>> when slot available
>>>
>>> Am 28.02.2018 um 07:44 schrieb Monk Liu:
>>>> under below scenario the obj->fence would refer to a wild pointer:
>>>>
>>>> 1,call reservation_object_reserved_shared
>>>> 2,call reservation_object_add_shared_fence
>>>> 3,call reservation_object_reserved_shared
>>>> 4,call reservation_object_add_shared_fence
>>>>
>>>> in step 1, staged is allocated,
>>>>
>>>> in step 2, code path will go 
>>>> reservation_object_add_shared_replace()
>>>> and obj->fence would be assigned as staged (through
>>>> RCU_INIT_POINTER)
>>>>
>>>> in step 3, obj->staged will be freed(by simple kfree), which make
>>>> obj->fence point to a wild pointer...
>>> Well that explanation is still nonsense. See
>>> reservation_object_add_shared_fence:
>>>>            obj->staged = NULL;
>>> Among the first things reservation_object_add_shared_fence() does is 
>>> it sets obj->staged to NULL.
>>>
>>> So step 3 will not free anything and we never have a wild pointer.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> in step 4, code path will go 
>>>> reservation_object_add_shared_inplace()
>>>> and inside it the @fobj (which equals to @obj->staged, set by above
>>>> steps) is already a wild pointer
>>>>
>>>> should remov the kfree on staged in
>>>> reservation_object_reserve_shared()
>>>>
>>>> Change-Id: If7c01f1b4be3d3d8a81efa90216841f79ab1fc1c
>>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>>> ---
>>>>      drivers/dma-buf/reservation.c | 7 ++-----
>>>>      1 file changed, 2 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/dma-buf/reservation.c 
>>>> b/drivers/dma-buf/reservation.c index 375de41..b473ccc 100644
>>>> --- a/drivers/dma-buf/reservation.c
>>>> +++ b/drivers/dma-buf/reservation.c
>>>> @@ -74,12 +74,9 @@ int reservation_object_reserve_shared(struct reservation_object *obj)
>>>>      	old = reservation_object_get_list(obj);
>>>>      
>>>>      	if (old && old->shared_max) {
>>>> -		if (old->shared_count < old->shared_max) {
>>>> -			/* perform an in-place update */
>>>> -			kfree(obj->staged);
>>>> -			obj->staged = NULL;
>>>> +		if (old->shared_count < old->shared_max)
>>>>      			return 0;
>>>> -		} else
>>>> +		else
>>>>      			max = old->shared_max * 2;
>>>>      	} else
>>>>      		max = 4;
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
