Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934254AbeCELjq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:39:46 -0500
Received: from mail-dm3nam03on0080.outbound.protection.outlook.com ([104.47.41.80]:41011
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933405AbeCELjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:39:42 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
To: "Liu, Monk" <Monk.Liu@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1519800242-2442-1-git-send-email-Monk.Liu@amd.com>
 <fa9f8ade-000f-a9b5-0bc9-0dd3f10d9722@gmail.com>
 <BLUPR12MB04494D7F15FC7D557D58488484DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <f40975c4-c5df-c06c-9a6a-a96705232461@gmail.com>
 <BLUPR12MB04491D607CA17302B4E5524584DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <210b7a03-f309-8ab6-0f23-17377660e664@amd.com>
 <BLUPR12MB04495463743D454E9384C2B684DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3baa1046-79b1-7c6d-644f-9aa921733ad2@amd.com>
Date: Mon, 5 Mar 2018 12:39:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <BLUPR12MB04495463743D454E9384C2B684DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: VI1PR08CA0221.eurprd08.prod.outlook.com
 (2603:10a6:802:15::30) To MWHPR12MB1312.namprd12.prod.outlook.com
 (2603:10b6:300:11::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9850fcc-10b4-4dd2-fd5c-08d5828dc75b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1312;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1312;3:biUQsWJQGD4A6phnp2vSz1Z4ipvGb3CklpGf+Ykn8pnPVTzYDXYSr1zsCWKAVmRqF/NLET1F4SVMET5TdAoVpGkqOj1BCnFhXKWI6BZg2CGpk0KP60whEC2+RcnA9GcgY0M/Yr+qlEMChPK8w2bsLyPDxvNH7DOF7QkWrePsOr1pCjgM0BaXOYRL5Vs9g/7yxuRozFXY95mFLU34PqzzZ+pUABEIBMCkHmUF7uF+d90vnAvyDf+yhohiR4+TnToJ;25:tYf9couW5HZ5TYO3Qhf3U/W6Lao1TKztxzQ3+nABeYxJ5GkSG7O3oWxTBpXeFG8E+VXmE8rv60tCu4vFwgAB7KyPMhN11hnjjnihaQVkyqxGfUhftRbqUgpCcaXBOplhzfThgqNQRavcZSm18m3iHcwi+lJxARcijoZdiZWqVf4VQ7Aj+Y4UWzEPt8HrkjCnFkCzQJ31+5KOfn3VSlzao8IOKkY+wbqvop9wl/4X/A/IyVyeuxL4l2lmK8wor4TPqDQQPk8sznlLNEFAR0adVu+69yBcZMkCV2BmuqIatYbfY1243TCY95aKHeAsj09MZZDUa+AZLFMIBU7gugH7Yw==;31:GVGHG8GeS2nQAvBFkJhDRMnLJqACLwS/Wtq6sPVs+WiWlpmOm32olgNMMxdiLPEo0mZvTLGygMkOKQVHTwxwnTa20p1qdCapCxnH0TwasWqqTpNJ4Pb50sNawps2a+1JO+Km95M6RvR0NcwRXe5e7VJCskwEXsgE5sRLUVfLElLE/uG8T2GccEdjIGpE3WDttAANRqvwkopwsdnBQnLPXT445b9CztS6W/kDdIpXhLo=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1312:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1312;20:bs6hLj93FXizkaNYAfIV7/euh17ITy6HuLljmH0JA5vi/cbNw53dJ8CACRSPDc+2zsrwJSjX9AdzcHSArD7rkm72nK3wV/GNmC371PjqR+Tr3g7V4HwLGDskGCFI27hLw3Pt77T5QWQJ2NaeF1JNNVLEgKkmNan/WPNZQgDvkA9Rtch8vvyAwNTkd3xhyp31UpDtjC7TXYk+r22CE8H82DaBvYiRmsk+KWwT5yVU8xhbuZmLuJkaa/eDb1vxuKykU2zVGUUMXNuOcnCyTw9fkr0tHpNnuMGroOoEHqW9d/8Zx+J08lSVJAhvC/Kuh/JZIp8lMQg03zBRXBiFgP54dxpL/3AOr6GQW368V6P1TZIprSIDI3nQ3sYS04FlwO97s1Doa7Ya4u9PB5+JPBNNzzM53ZjdPbZTLASF2eGEI1k8XZoO/vh3FDzhklgUZitr6r8Z6i5pih8QZvePNnX5aTf1pAKM/pO8TMrcI13hNiZCkMshjoTv3pSDqLDhCnXT
X-Microsoft-Antispam-PRVS: <MWHPR12MB13126597A2050D595642BAA283DA0@MWHPR12MB1312.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(767451399110)(217544274631240)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR12MB1312;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1312;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1312;4:tDZtxhxhITjinNXIs46Yej3Mp7O658N5TwkHij222Lki9nel1v1C0PDvMHLUoWOJzJoKIffWA0NCUGQ/duBtfBW73q4sZAz97mqLmo+efT8ehPAsfLRXaCDmfQHtWagwc7rP/UfoS5yBOA1yne82VZIU+qR9Ijw+GT5o3qA3E6Tal1gU/SjY1F763YW7KX3Glq3VyjnKS/Ja/cbP5Kbb6MH0xNF0AMp3FEICHXNWLa/pNjdxM6tsLyclSMHZEdtoQKyvuT/4KabO0oNFNBuwx9aKu7HLQKaL6CmBAcjtB1VXYXqk9fikbDBl/YjdrCTFwkWy5uP//AQWa999/7vVQKntsOMOWFdM80N+5dgahxH5i2NOcwmmQKDdpwx9EcaHwFEz29KZsb732c2nqSzMjhjWL6ZYElvtqX2Reybm+Sk5iM5/sc8tGfmaVq1FnIkG
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(13464003)(53546011)(2870700001)(53936002)(64126003)(6486002)(31696002)(106356001)(2906002)(6306002)(97736004)(50466002)(1706002)(6246003)(16526019)(65806001)(25786009)(966005)(6116002)(86362001)(2201001)(81166006)(81156014)(316002)(8676002)(5660300001)(65956001)(72206003)(386003)(186003)(2501003)(52396003)(67846002)(59450400001)(52116002)(110136005)(52146003)(76176011)(2486003)(8936002)(46003)(23676004)(58126008)(93886005)(229853002)(7736002)(105586002)(31686004)(36756003)(305945005)(65826007)(47776003)(478600001)(2950100002)(6666003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1312;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMzEyOzIzOkxIN1NlWTVBV0tuVzJvOGF3Q0tRa3hXclRU?=
 =?utf-8?B?YkUxMW1aZHNuSzJYRjlvdkE4akV4UHFLR0wyV1hadnR5VisvLzA4QjNjbzY3?=
 =?utf-8?B?NXlRS2lyN2dXTHQ4ZDNMRm5kV3E3L1RYK0kzZ0xJN0tUOE1jQkZJNnZCY1pD?=
 =?utf-8?B?R0cxaWtsZ3BZaXZ0WUQxaVRWditBemdtZVBySGlrWm8yeTR2VW9jYmc3U25n?=
 =?utf-8?B?akRDWGVqSW13SVk3ckxyUFRCckZKdk9oUURvUjR2ZTBrclQrVnpWbGk0MGxF?=
 =?utf-8?B?V0ZacFN5SEU0QXBXQ25ibThEa3R1OXZhSUtFR1ZmdWI4Sy9mTkxnbTdsenV0?=
 =?utf-8?B?VVdzZXU3emxORFZ6UDJOZVR5TXJicE1MUUU4SVJEV1ZZMTUwREVtdjJXWFp4?=
 =?utf-8?B?amgrWENXWjV3SHpjVHZCczlzei82NDUwV2xQWDRyaHh3dER5a2dRa3RGU1pw?=
 =?utf-8?B?NFpOQmZZK2RtVzBodDB0K0tMc2REYi9YTEFhMjNyYThKWXU1WldibUN5R1ov?=
 =?utf-8?B?bm5WM3JiOXFwQXZKY1oxU1ZxTFg2OHU4MURoTG5vbmxlVk9wT21sUUlOTUJv?=
 =?utf-8?B?VXY1dHQ1WEd5dHVKS3hSYlZiYUFoWitPWWMyOWJSTlk1VzJ1eEJieC9hRTFt?=
 =?utf-8?B?ZVRGQnp3NVZ3ckpRR2tsRnFDN3JkZDBpZlI0bEtZbEhWSVBGejJOWEo2amxx?=
 =?utf-8?B?bStXNlpaVXVSRkxUeTVFSkdqK3UwUEwxTGNrSkw2Mlc3ZXg5WnoxbDRDdjJm?=
 =?utf-8?B?aS9sQm5HbG5SMEoxc05PaVVlelNyMHZqQ0R5VlA4MXI3cXI4c1NVbS9Rc2ZP?=
 =?utf-8?B?QkhNa1hyMzNGZXRZVEpiM2w3V2lEaXE5NjdFVll1UHFVbU9EREFOYVFhUVJU?=
 =?utf-8?B?clJXVDRqRlgxVTJpY3JrZnA4Sno3QkdCUlVaVGJlL05XTytiSEhHTGkvbTdK?=
 =?utf-8?B?UkV2Y290M2NEVTJXY3EvRGE1NVhQeXM3d01Ld2pncG5uQ0hEU0h0d3IyTGdO?=
 =?utf-8?B?eXRsQ2xWRnQ3WjR1aVBzUExoTzkvTDJNblFtWXJFQXBheHlTbzhkQmVVdG9u?=
 =?utf-8?B?TE1uWVI1ZmxNd0s5U0pvNFZ0UUF5TlJHUHU2d2RqYjBuTFRHd1dVVEsxRmZE?=
 =?utf-8?B?TkxPaE94MmZyMlMvT0RTVm92aDhzMFRsRHdEWHE1U3ozT0J2bzBaT3g5QWdN?=
 =?utf-8?B?ZW42SW5tdUI0dzlTTUpvak9xMElUN3Z1SStjd3VvOWkyK2Jvb1UxRjVBaDFa?=
 =?utf-8?B?TkVLeVBVa0lTQTh1VkZPRTVLMmYyTDMwQjVudlBxbkdDOHBWTlEzQlBMOGNv?=
 =?utf-8?B?WjZDS0pWcWxJV2VKSGZpN0U5cWdJTjVXTWovaDNBVG10bmhRTUJoUEFzKzl2?=
 =?utf-8?B?dFN1MGNUQnZFQUdUc0daVGJ3S2svL0lCaDJoakkvVjlubGhkazdaZ3g1eUhK?=
 =?utf-8?B?QWkyRUMrQjMwNnpzNmNnZ3pZYi84Q1k1eDdQcmJWenZJRVJRZEt5WUVDVndW?=
 =?utf-8?B?SG5sTDJqeTcycTZBZ25adlFTNDhqTTRUKzFvTVVGYy9lSkhwbGpFKzIycGNW?=
 =?utf-8?B?dWRCOFlHNE1QRWpKNXBMTG9jSVg1Slg4cFBoQXQ4WUloUjRObERVSXNxOEY0?=
 =?utf-8?B?U0RpVllqUHBEMHV1c0NOVFF2L1A3clpWTG8vU0UrM0lWNndTQjVrYWtzcWoy?=
 =?utf-8?B?MkowWXlsT1k3aGI3dXpoTTdNMTFMTUU0VC9wTUkxd1dYZHBaUXFJZTVGYTU3?=
 =?utf-8?B?VGpUWnhTUHhKbVBvbHVjREtyS2xvOEJZWTF0anNQMWVNc3FrdjR4SzhLd21Q?=
 =?utf-8?B?clNxa3dmeitFd0NhYngwclNiTGVJUnVQYWttWlFPdk9GYWw5Y25oQ0dpWVUy?=
 =?utf-8?B?VWxtT3BqVlFBSzJ1Y0dDOGxPendWTkNtTW5ibVNQazRyaUYySnBhaXVmQWxs?=
 =?utf-8?Q?vsQWDDkzUZ7AKQ9tw+Z6GFLuz3H8MU=3D?=
X-Microsoft-Antispam-Message-Info: o1s+yxyEkY5SB46t7vbV8jfO8NFlJ9hTpO1gbJl0fVzZSpqgAz3gprGIJeEdVfJzhqGvZGDN4ymKZbHzK3GgtoF3L3bYqwmpW96tbhGM+/OPsZquYHfIEP8hdjiQd8mMGXJZQPgwVvtARCoFbOpyVp0FEWzFfNwVy3sDb9+/irddT4treTFexL09PBVjYQUh
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1312;6:R9L8x5GzrHMBqVX2fEucozw9hQDpzK1dvhBoIihL2d52+BwqbFtF5MpYaXOJiarMLNsyzz1wzMwBvyKpKtX7HKbBLFuCvpbCkK1KGf2MH7Up9wPUyLzLnJt6HuXxLdbPJcxdMEU7CiEusPJ42u+9CA4cj80eA0NpmAFW3+9UNuZmPUVUtBjKZyKgixAT5T3KHkLTg3qEbWpybUiLtlaCOrQT590CbULyc0J2Kl4gZo+GzfE/BuURpaoaw6SBINXjv9gQsUVuuU18Z9tHv3ZNinmDHMHlBbGtkABV3BvFmqzMd4oNfiXFxRQ7qIsq1NVDGqrx7TnNyFRJiSVURDsmejQGPmU/EU7u7y//m9Oo+qI=;5:9O1JOX25nbQqExp06XFTPfozLgH1kltZbrBSRj1pQ2S1eCOdiap80ZDnuKxGaq6BqluCIu+pZOGjR87qmmE0+9NLkXnvoKxtHMrBeayQBmO5MZ6spxeDje2wjgTX9ETITEeJWG0n/yjkIWypH/SfZeaapR+ZqDKDH6TCzXwJ4UI=;24:acU7CGIVNrn9bMMXXsLOtBFwN6nDYlnEgPf1EqRNGn8sr9tPke0B+0ltyreoYvHEb+rULf49IYLcnIA2cgqHn7L/+kioVcz5KZFZemiZaRQ=;7:dQaXZ2/kscaHV+2ontYM+2K4TMosYdy1njn2XRWuZw26Hhoxenhwjx3nfAWT5i2a338T9jZMdprbbttTvr/hpPvfPQyEO3Xc5E2CvFmFIZeCoYEqV7fcd6BW+MH3s70DMyinbTNiR2oK2FlDEP3UrLuvDiyXHcWFIZpN4uH3Fmpbu/xU7byIlFu38Lk/PWbCezDQOhlwbRXPAKSBDeHXsSSH6YJzbNBhQQVpQcDLVt54BHws4ibMrPOLVuVAqAeC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1312;20:7+f2aVY5O8eps8bVFs8LFkOWhwjmoRIhRB9JLtqwbTn46qPov8+I5DphaVOpaQYb6cp2on0rHIS52i0hQK1DFvWnzcbiDQ04rTdlnIwzZuWXH8/NYAV0cqCbCCZyhB+B02CAcqV1o/X0+rKACYG3bTJLnu9zD0t93YN60//a5cGdCtp9LJdz8iINf5tgcFgA/fY90AGxVaXl4B90oBFe3ByqPfgCRrWiFTziUBy0s0sb/ECHA+kGsb905ZJNM0Ah
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 11:39:37.9487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9850fcc-10b4-4dd2-fd5c-08d5828dc75b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1312
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.03.2018 um 12:37 schrieb Liu, Monk:
> But the thing confuse me is according to the design, if driver keep calling reserve_shared() prior to add_fence(), and with lock held of cause,
> That BUG() shouldn't hit, so there are two things in face looks weired to me:
> 1) by design in reserve_shared(), obj->staged should be already NULL, so why we kfree on it

No, that is not correct.

> 2) in fact, amdgpu can hit the case that obj->staged is not NULL in reserved_shared(), don't know how it lead here

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
> To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot available
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
>>> You are right on that part of obj-staged is set to NULL in add_fence,
>>> So my following question will be why we kfree(obj->staged) in reserve_shared() if staged is always NULL in that point ?
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
>>> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when
>>> slot available
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
>>>> in step 2, code path will go reservation_object_add_shared_replace()
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
>>>> in step 4, code path will go reservation_object_add_shared_inplace()
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
