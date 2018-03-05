Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934493AbeCELZd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:25:33 -0500
Received: from mail-by2nam01on0069.outbound.protection.outlook.com ([104.47.34.69]:61001
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933983AbeCELZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:25:26 -0500
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
Thread-Topic: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
Thread-Index: AQHTsGFsSC26PGMebEmm/OMzPYEJ7qO5evoAgAfSfxCAADo4gIAAACZg
Date: Mon, 5 Mar 2018 11:25:23 +0000
Message-ID: <BLUPR12MB04491D607CA17302B4E5524584DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1519800242-2442-1-git-send-email-Monk.Liu@amd.com>
 <fa9f8ade-000f-a9b5-0bc9-0dd3f10d9722@gmail.com>
 <BLUPR12MB04494D7F15FC7D557D58488484DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <f40975c4-c5df-c06c-9a6a-a96705232461@gmail.com>
In-Reply-To: <f40975c4-c5df-c06c-9a6a-a96705232461@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR12MB0433;7:QE/wszU6zkDh+xcfswHcFHb565jtEgJ6DsGQBBdp3JYZAgmL1A2QF0HI3/nGiQA0spmvYq0caZwqu4+11pT6aKiuMphax5lTTSHfk7k6X/K0+QzHIbijX10JKe2Ufz4Vk3oh+JC/oczXoXIknvefCGqnMccG2OsopuKVFun5YbhM7aKFXRNP7SCAJFwqQyCGHLpvFU5klLY8BvUzbOaib0xOtm7Gp0SsziMuwbCTbGxTjvPnngO3AYUIzt7wFrdz;20:VWyMxMj8TdIQtVP2y3X+Ov2IwW2+4DABnymXllfUHEZCWnattYZ1FtB9xCpL3krqHP7wd3AIxyGdWZfFLhL3gXlAor9tl/cHKkxa0R9VZbP014afbgG/WgGRBC6QeNQxUE040ko2/UMkDHzIJ3IrCoad9EvU/pDXJdqRAcnFMPAek4qlaqI9QUVH/eXCO4Fvge81T/B3pMVhazXIH2berFz/EdyPGMCUCtdiYUhWjmHXBSiWy1u5BnvIVnqiDBHP
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(366004)(376002)(199004)(189003)(13464003)(229853002)(9686003)(55016002)(105586002)(81166006)(81156014)(6306002)(8936002)(7736002)(478600001)(6246003)(53936002)(33656002)(66066001)(74316002)(5660300001)(2950100002)(86362001)(305945005)(6116002)(3846002)(966005)(2900100001)(106356001)(72206003)(8676002)(14454004)(2201001)(25786009)(3660700001)(110136005)(316002)(102836004)(6506007)(53546011)(26005)(99286004)(76176011)(3280700002)(7696005)(59450400001)(2501003)(5250100002)(93886005)(97736004)(2906002)(6436002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0433;H:BLUPR12MB0449.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cfae22a-e3d2-43f7-b855-08d5828bc978
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BLUPR12MB0433;
x-ms-traffictypediagnostic: BLUPR12MB0433:
x-microsoft-antispam-prvs: <BLUPR12MB04334868B82FE3B5CCBA81CA84DA0@BLUPR12MB0433.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110)(217544274631240)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BLUPR12MB0433;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0433;
x-forefront-prvs: 06022AA85F
x-microsoft-antispam-message-info: bEBQHjfryjHaHlonBGZi8cxeAXnLHMnonW4WHp4dYBKGeqibSKhoZ7rAVTIFi6YkPv7oijwq9s25E7ZiMykwymbA4qRXUVtFgseic1Smwk7cSu6e7cmLvjCMe4cjDmrItbbdCusPHCQtMuFjH7cZX1EXShBiMK+54clwjsznhrZn6AczGyiiRv2Xg/R9Gs/Ts/tRbWX7JkDObmstEAq7tpiNab2B6GRAdRWCZjBIBJ3mrHxDfaCN689ShgJmP2hlyhX92x7zy+A+p/qOQ6MlkcULIaNBEB2U+XKNw5377locmjJDpauj8prokZMW9baarAN6WFJEItIncmZ12n5XDw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfae22a-e3d2-43f7-b855-08d5828bc978
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 11:25:23.3709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0433
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w25BPdXI018839

And by the way, I add "if (staged!=NULL) BUG();" prior to "kfree(obj->staged)" in reserve_shared() routine, and this BUG() is actually hit, 
The stack dump shows it is hit during the vm_bo_update() in gem_va_update()...

Besides, the whole reservation logic still looks a little weired to me ... especially this staged part ...

Thanks

/Monk

-----Original Message-----
From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com] 
Sent: 2018年3月5日 19:22
To: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot available

Am 05.03.2018 um 08:55 schrieb Liu, Monk:
> Hi Christian
>
> You are right on that part of obj-staged is set to NULL in add_fence, 
> So my following question will be why we kfree(obj->staged) in reserve_shared() if staged is always NULL in that point ?

Good question, I haven't wrote code that so I can't fully answer.

Maybe Chris or Maarten know more about that.

Christian.

>
> Thanks
> /Monk
>
> -----Original Message-----
> From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com]
> Sent: 2018年2月28日 16:27
> To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org; 
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when 
> slot available
>
> Am 28.02.2018 um 07:44 schrieb Monk Liu:
>> under below scenario the obj->fence would refer to a wild pointer:
>>
>> 1,call reservation_object_reserved_shared
>> 2,call reservation_object_add_shared_fence
>> 3,call reservation_object_reserved_shared
>> 4,call reservation_object_add_shared_fence
>>
>> in step 1, staged is allocated,
>>
>> in step 2, code path will go reservation_object_add_shared_replace()
>> and obj->fence would be assigned as staged (through RCU_INIT_POINTER)
>>
>> in step 3, obj->staged will be freed(by simple kfree), which make
>> obj->fence point to a wild pointer...
>
> Well that explanation is still nonsense. See
> reservation_object_add_shared_fence:
>>          obj->staged = NULL;
> Among the first things reservation_object_add_shared_fence() does is 
> it sets obj->staged to NULL.
>
> So step 3 will not free anything and we never have a wild pointer.
>
> Regards,
> Christian.
>
>> in step 4, code path will go reservation_object_add_shared_inplace()
>> and inside it the @fobj (which equals to @obj->staged, set by above 
>> steps) is already a wild pointer
>>
>> should remov the kfree on staged in 
>> reservation_object_reserve_shared()
>>
>> Change-Id: If7c01f1b4be3d3d8a81efa90216841f79ab1fc1c
>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>> ---
>>    drivers/dma-buf/reservation.c | 7 ++-----
>>    1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma-buf/reservation.c 
>> b/drivers/dma-buf/reservation.c index 375de41..b473ccc 100644
>> --- a/drivers/dma-buf/reservation.c
>> +++ b/drivers/dma-buf/reservation.c
>> @@ -74,12 +74,9 @@ int reservation_object_reserve_shared(struct reservation_object *obj)
>>    	old = reservation_object_get_list(obj);
>>    
>>    	if (old && old->shared_max) {
>> -		if (old->shared_count < old->shared_max) {
>> -			/* perform an in-place update */
>> -			kfree(obj->staged);
>> -			obj->staged = NULL;
>> +		if (old->shared_count < old->shared_max)
>>    			return 0;
>> -		} else
>> +		else
>>    			max = old->shared_max * 2;
>>    	} else
>>    		max = 4;
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
