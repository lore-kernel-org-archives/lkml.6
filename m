Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933250AbeCSNSQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:18:16 -0400
Received: from mail-cys01nam02on0074.outbound.protection.outlook.com ([104.47.37.74]:8096
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932883AbeCSNSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:18:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Fwd: Re: [Outreachy kernel] Re: [PATCH] gpu: drm: Use
 list_first_entry instead of list_entry
References: <dfc1bc65-d6c0-8935-e787-4743d3cdabae@amd.com>
To: LKML <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
X-Forwarded-Message-Id: <dfc1bc65-d6c0-8935-e787-4743d3cdabae@amd.com>
Message-ID: <58065ce3-e071-aadb-4423-f6e3d4f68386@amd.com>
Date: Mon, 19 Mar 2018 14:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <dfc1bc65-d6c0-8935-e787-4743d3cdabae@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: HE1PR0102CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::23) To MWHPR12MB1727.namprd12.prod.outlook.com
 (2603:10b6:300:112::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a551c90-4d01-4014-47e2-08d58d9bdd13
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1727;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;3:W2iZEoHNwc7mchjV3bmfIYbNDH88agfwFS0n0JAKWTMxXgd2p4cszSG68wnh39nDsDJwEZJRUpJFCDmeJgMjwLXmJgRapEEbutCK+hyz4UlSITo56zTt7wTMwn6pbaE7LKDcjep6UndyWCmjP7YIXLL5+1HSlCqIb8wWnnx6H/64H0iRFEptIf67qrIiHs2MLuA77xlwUrczzh5GLydtTTjkSMx3lKLH4RyQGRki7UQvdD/eJBPJFdXLpH8wNsLJ;25:Zm16ClkNfkan7XnYdQ3Hg6MOd3vSL6YY/fdYQmfC67rny52MiHf4bMUztrf92cI8I/d0Pk1JF8464Kv3rRrVOx8PWU15Mov2LcDcR2pOo1W0OGw3Bui/eFmeNTq/zmMBGdJm6DMxn6+Pcg7US/ZlOZSN+W8SQioU0yF/fezgg+irnrBKxiToqU2duAVkkc47ZOY77Mpe0cY1+Vq16/bdOCxyUqik3y0lMw7qTdwEfr6sOKDfQvvXAXbqD7pRgk5V1O69ht4buhw9IdD35J3zw83PucOI1Gs5l3v+XawCXxW2+VJuAOfF1rI28P/VErw6KkpScQcTrqp+MDkpvUqjYA==;31:J94J4tztyi7Jf/KzdncBt1c4/zPmfGG2j4KK/F+x6aHP35R3du2UKzzmBCs+n4yP0J+MvhD7ZPnvhJAYjEoopKcViHe/t5fk7XVjSsETMv4OtEJKbcDe+6CuvK3WfKodhkkqkyOOlzNrgzrJQbIAjNanDLnXVAvtKcuVS3+DhcYNgvb5Lh8zCR5F/zybSVZ2bf6yRvtWc1HcVExkr8QCriF/f6fJcCowtkuNPP81IRs=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1727:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;20:dyGCr77G8p7Moj+Ou0m8Bb5HWKGoFTQGW9hpXZTg5WeNyfxje/ZIMvD5ixtN2hwVz+GhmU50HUpL0Ziy0iJLSISJgKwYxknJ97VYNML1cHK27MXm7xjiZ20iClfN1yHhMa/BSt0aNgGEd2vwGzz/ak9RH9bMYlKj6dCfw82bT/LpFMSdw4LjFjoSoEAARW8sinJzDj0+Njoj/ECcdB0JAPoZMOnpi1x0ulTAewNfu+YbtZDjy8KFsDbv2ABuIxtYAbjkmek5BhzswnZqoopXYWSqn5LZWgM66KpOdsGDkARy5zBfGPGDwK6S7ZNWDPNaXUVq/7774QfjD9AgJRfKQB8V3RSjfewnxgfWh7GlcMYqhvoomGx7OMJbS+PdTTuWwRe5knL6GSlBtJZEEXlFea2xvaGPAF8+Xksd6+1iZ5UUM6EjjZnnRh4R7ftvRr4YFzagyHYjOfLqXn0PhLjRW/VZy5+KPdwPGNH+518TdgYbQaOjtPAv0ZeMZM2+9c/O;4:7G6S/74tZCUuHejcsyl/3b1qIgoPIwtxVv+m5txVZWu9/8idZKUtY8efMiR6/RAQ/NVv5pQ1C2VAHapCPNRTazXmU9TRMI2Vc9xzYO2jgiegxtVoZiwAXiYk/b6Cl9a0pUtFFRteT9Xykes8l4g3KHSFE31DpxSQyhaVE0p79NWcOQJ9rWlsOvkMXS0j/mixjf01ZictTB85/UyeQokEK4EUtUZU6d4s/PTyGrWuHLaZ56ypKNnVnncVGtaFbrf7ctjY92qvkP6OppnGyma23coKxaAE4Co9qATVF8xTLIKncNhMZB228z1bW3xU1x1uCDAdkNvsg3Iz0uC5PSHzKSpB5kH4QVQJhWHW71jJB9UURi982sMtYgpXK+6cOyTfIs1QGEu/Li6nbRPBdixURM92soQ1ba2h5CG8Up4CHAs=
X-Microsoft-Antispam-PRVS: <MWHPR12MB17271DE172D5B54C32E3DD2883D40@MWHPR12MB1727.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228788266533470)(85827821059158)(211936372134217)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1727;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1727;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(346002)(39860400002)(376002)(199004)(189003)(64126003)(36756003)(6486002)(31696002)(67846002)(86362001)(5660300001)(16526019)(47776003)(65826007)(305945005)(50466002)(186003)(97736004)(6666003)(2906002)(6916009)(68736007)(2870700001)(386003)(7736002)(2950100002)(65956001)(65806001)(25786009)(46003)(76176011)(45080400002)(478600001)(58126008)(8936002)(52396003)(23676004)(52146003)(2486003)(52116002)(81156014)(81166006)(31686004)(1706002)(2473003)(6116002)(6306002)(53936002)(966005)(106356001)(229853002)(72206003)(316002)(105586002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1727;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI3OzIzOkJIcStpQ1ZqUFBhdzVGdW4xbmpMVWlOSTNj?=
 =?utf-8?B?S015c0VEdkJyenFaT1ZkQ1Vxd0RkODhtNGFoMUxBU2V4Y0JVUzVOTnhINjEx?=
 =?utf-8?B?MVFBNnZZbTBEQXE0QW1ZUEVnRVdrZU1mbEdvVll5NGJ3b25UblZXemhLWjcv?=
 =?utf-8?B?M0VyQWVUeklhTlk0alRtRERtZEpJNzRKQnFQVDBsM2RYMTEwVnBTSE1tVEc3?=
 =?utf-8?B?V0VBc1ZZaXR1SXFZYm16enk3YTNIR1IyUTFyUkhIMnZmTVN1dHBkYlhldGl3?=
 =?utf-8?B?WVRHMnBYS2xDVnVrQzNaa2J1cE42OGtkN21MMU9oWWNYa2FseUdzZllKbHps?=
 =?utf-8?B?ZE1JbWFiOHZ3TTZWT1NBWnZHTit1cXI2dWlFekpaZjVvcEJ6YmNUU0R3aEJu?=
 =?utf-8?B?ZXdMRzcyWkpIYm5LSlNJZHpMajRVbkQrZmR2em1iZHpsaXQ2aDBlNHpKZWx6?=
 =?utf-8?B?eGRTcHBVSzJuUVpRaHo0WjJ6ektkNzViZGkwcDhscEt0TmNXRUc1bjhmYWE4?=
 =?utf-8?B?VjR1RGZrWk13ZUxVZUpJMU9QbVlzUDBnblFpL3lYSUpXMnNKdUcrYTJScVdj?=
 =?utf-8?B?TXdsckpQYUVlc0NCYlJ4bGpudk95cEo3VlU2R0c2MzlONFF4UWxHOVBySkhj?=
 =?utf-8?B?Vlc2WHJMc0owaXFGWHBaMVVHSHNicyt0T0krWTRJWWRaa0dBNjRCdHFqK2Z5?=
 =?utf-8?B?WWp1bkFvNkdvTTdoRXdPWkRvZ3kxRTJiWXRHK3VvK2ljUGxUVDMrOC9QMmFN?=
 =?utf-8?B?Q2cvbFlGRllRSWlUKytzNGtKYWJrcGMyeXp1UzIraTdBMkN5elF5N0M3Z2p6?=
 =?utf-8?B?UkYvZDBxdDlOSnRSb1IvOEJOa3pwMkRKWmlQUTlEYkFsT2VKbFQ4WDJabHF3?=
 =?utf-8?B?STMyK2FzVmlNSWNpU29BbjJOQ1VTbUFxYmsvelJSa0R1NU10Mksva0pRdjg3?=
 =?utf-8?B?WUFjMkZad0R4eXZzaGtoaEg3Q2VOMjdSbWVibWV3a2Zra3RhLy9WT2MwamVT?=
 =?utf-8?B?b1hKUFJvTGp5V2NmajYxbkJyT3R4RXpPK0lrK3ZYcStaOWVkVHNWU0RUWW9F?=
 =?utf-8?B?ZlBWSktTOTc5cndORzFocUFWdWtrOHd6MHlhUUFQRzBPSXdod3RiUXFTU1lE?=
 =?utf-8?B?UlpuNzBzSjFOdDQxMzdYZmx1Zi9tZUM1U1BlZnVjWHlPQ0ZyNmhKd1NNalMr?=
 =?utf-8?B?NE40Sjgra2tTTmdvNG9YZnZick13NjcveW9XSzdjeTZndmkvZFFiK25RMys5?=
 =?utf-8?B?OVJTL051MTZDZXBKeXlkM2NTUEJmSUt2NGNhR2J4cW1hUVlpL3htVFlqcXdi?=
 =?utf-8?B?WFZKb2g3dlJONTFBRENWV21QWU4zS3o1VlltTmhlMlY5Wmx1M2tOWnBXdXJ3?=
 =?utf-8?B?V293MElrTENRTVJsVml2ektwRDlaRWxVN3FFNERXZURUa0hFTkxzNnJ5L25n?=
 =?utf-8?B?NHFqdEYvV1J3UGJISGxIL2xUTmFWWWhFT2hiTlU4WVJqQ3dsb1VjR2x3emk4?=
 =?utf-8?B?bHZWdThXd3dtNWdEajVVSmx6Y1NtU3FrVVBkTWdhd1p2R3pUc3dxQ3BNRmdi?=
 =?utf-8?B?NjE0YXdPbmNBUnpaZmR2eHBKckFjTHZIbUNZcGdHQ3cxZXU5R1U1UXFPcWsv?=
 =?utf-8?B?c2xMS1YxTVhvSmhWN3gzS043N05Oc0Nsc0dWT0VVUjAwSlN4bHRMTXNDcjRY?=
 =?utf-8?B?ZENOaFlqYm9wSFI0VS84U1AyREgzQXN0ajNFblpXZlJpMm5YMHpLUUVROTB6?=
 =?utf-8?B?TC9XMGVQZlk4L2lFdFBKTlNEVEZTZ3U4ZTI2T3dXdEtqWTBuTWFhYTlWNjc5?=
 =?utf-8?Q?qnW5CR/0ypTxr?=
X-Microsoft-Antispam-Message-Info: jznFAuuY/WZSYeW+gn426v8khVK+EeOHJQDipmF2MkNxzt+lqeM4mXVsWBGsJkP9o6yEeT9/+E7b1dMmdaWHfLpPNx+FYVEitIaLMrACYC4WRHKJJLl3JX5qdRDSVgeuB81NrpeptEUTW6u3LMIdENIbe5g9k5VYJNoG0i3+PIvQ4J02sQn+SM6wzIZiy3Ph
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;6:ztpSUgpMOedflwsLXaUb2ua8FrinVPqN0odXO908dlqeotd/oDV1ZVxRraFnTLm60S5yQwmEdY3cDd7wKGkqS9soUtSCjgPU6Z21Ydi7Sl3vr22Z9fp2PCNgUKLJOtM1A1hbjGETxlAgj+cDMO6GYAbfO4eAThVd6ytrZK0mortcw+XMornI8WwSToYMuv/DbPz/tA+LWnhQ58G+LowWd/G5ars+OLFeKmpHwQsJQ9FbJnDn5jW8gRdgfYBmQyVYO+sD8t9riArUtmesaE0hpmYGU2eEHGu0xTxb/oCXg+oGdseNcmZviJklEUK28PtCLbwhaxek7LnHwigEHqrtBOPaT9JOw9g1fmHSvA/HtkI=;5:TnDS6zLRZw3jsrDM+mOKvSgV9ELDKvQB9Vvl/FLLQ3i2ORrC3XTJbjxKv9ShivgAVNRArh0VIisd0qZ88jHDwwTkwlFIFKZOMpq3yJf/PgwH+uz8u5+Ujqf85T5tKdCZyQ94kptJ+hdohiS1/J2GeMAegXDlQy4CvDse7obDtts=;24:ZnhssU6LNLqWfAfig82z+b4iZptj+qkbY81vT1e992jtMWlraoNg820HvgMdunMtsjN+/A/AUOpsKIvP+NoPJafWvxKNg+/dUhmgg/uBSeM=;7:byls3bRLOaUn0zEG/2WFPYTJf8f1wZSOqAcp/dXbt19J9zd1ZjJdJRKP5iBGJxGAkAO4qx8HaNnZOUpISk3uiRtYQLbUyTR/9Sym2yqryITw+XhisnGFS4u5BkkKXRHXREKeD0uuVrmfPZA3VpmZGLmGVCeVAp0ZkaMJYsY75ZyGZXkar/idkxSVQ70Gx/NOQAJfr8paWyjb3Z4jk71jQt3IrN4piiMFLcfPXP3ng+m0usiDkE+HvEKqrlX3xafj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;20:33DK0sP3QC4qghDaJT9pWEaOD2fUj620dDGOqfc1n78WC8MZCfhEP4ZLWzNMKLt2cudhN4PGRt+FDQbW+H9ruFQqr92VWo292/pLAv+OZr1BCG3a3gnxLwtiJK/6IYFjTqaGbz8lA60bC+xqOqxs9Vn6OFOdbUqA/ICSIIWr+UnaoU/c1zw8tx2V0sDMKpxsYBlLd+h4Zt2ad6bVtu5wrqPRY6b1IyNh96WDJrKInpiLswP1B8Wa3+afAMIluPhJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 13:18:10.3612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a551c90-4d01-4014-47e2-08d58d9bdd13
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1727
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarding to LKML once more because Outlook decided to change it to 
HTML mail.

Christian.

Am 19.03.2018 um 12:06 schrieb Julia Lawall:
> On Mon, 19 Mar 2018, Christian König wrote:
>
>> Mhm, actually that patch isn't correct. What we grab get here is the next
>> entry, not the first one.
>>
>> We don't have an alias list_next_entry for list_first_entry?
> As compared to the semantic patch I proposed earlier today, it would seem
> that list_first_entry is useful when the types are different?  One would
> have to check the result of course, but a list eleemnt with the same type
> as the structure that contains the list might be unlikely?

The list element and the list head have different types in this case:
>    	if (sa_manager->hole->next == &sa_manager->olist)
>    		return;
>    -	sa_bo = list_entry(sa_manager->hole->next, struct amdgpu_sa_bo, olist);
> +	sa_bo = list_first_entry(sa_manager->hole, struct amdgpu_sa_bo, olist);

sa_manager->olist is the head of the list and sa_manager->hole can point 
to both the head and any element in the list.

The statement "if (sa_manager->hole->next == &sa_manager->olist)" now 
checks if the next pointer points to the head and if so aborts the function.

Then the statement "sa_bo = list_entry(sa_manager->hole->next, struct 
amdgpu_sa_bo, olist);" returns the next element after the hole to try to 
release it.

So with the automated change the code is still correct, but NOT easier 
to understand because we actually don't grab the first element here.

Regards,
Christian.

> julia
>
>> Regards,
>> Christian.
>>
>> Am 18.03.2018 um 22:51 schrieb Arushi Singhal:
>>> This patch replaces list_entry with list_first_entry as it makes the
>>> code more clear.
>>> Done using coccinelle:
>>>
>>> @@
>>> expression e;
>>> @@
>>> (
>>> - list_entry(e->next,
>>> + list_first_entry(e,
>>>     ...)
>>> |
>>> - list_entry(e->prev,
>>> + list_last_entry(e,
>>>     ...)
>>> )
>>>
>>> Signed-off-by: Arushi Singhal<arushisinghal19971997@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 4 ++--
>>>    drivers/gpu/drm/omapdrm/dss/display.c  | 4 ++--
>>>    drivers/gpu/drm/radeon/radeon_sa.c     | 4 ++--
>>>    3 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> index 3144400..646f593 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> @@ -158,7 +158,7 @@ static void amdgpu_sa_bo_try_free(struct
>>> amdgpu_sa_manager *sa_manager)
>>>    	if (sa_manager->hole->next == &sa_manager->olist)
>>>    		return;
>>>    -	sa_bo = list_entry(sa_manager->hole->next, struct amdgpu_sa_bo,
>>> olist);
>>> +	sa_bo = list_first_entry(sa_manager->hole, struct amdgpu_sa_bo,
>>> olist);
>>>    	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
>>>    		if (sa_bo->fence == NULL ||
>>>    		    !dma_fence_is_signaled(sa_bo->fence)) {
>>> @@ -183,7 +183,7 @@ static inline unsigned amdgpu_sa_bo_hole_eoffset(struct
>>> amdgpu_sa_manager *sa_ma
>>>    	struct list_head *hole = sa_manager->hole;
>>>      	if (hole->next != &sa_manager->olist) {
>>> -		return list_entry(hole->next, struct amdgpu_sa_bo,
>>> olist)->soffset;
>>> +		return list_first_entry(hole, struct amdgpu_sa_bo,
>>> olist)->soffset;
>>>    	}
>>>    	return sa_manager->size;
>>>    }
>>> diff --git a/drivers/gpu/drm/omapdrm/dss/display.c
>>> b/drivers/gpu/drm/omapdrm/dss/display.c
>>> index 0c9480b..fb9ecae 100644
>>> --- a/drivers/gpu/drm/omapdrm/dss/display.c
>>> +++ b/drivers/gpu/drm/omapdrm/dss/display.c
>>> @@ -158,8 +158,8 @@ struct omap_dss_device *omap_dss_get_next_device(struct
>>> omap_dss_device *from)
>>>    				goto out;
>>>    			}
>>>    -			dssdev = list_entry(l->next, struct omap_dss_device,
>>> -					panel_list);
>>> +			dssdev = list_first_entry(l, struct omap_dss_device,
>>> +						  panel_list);
>>>    			omap_dss_get_device(dssdev);
>>>    			goto out;
>>>    		}
>>> diff --git a/drivers/gpu/drm/radeon/radeon_sa.c
>>> b/drivers/gpu/drm/radeon/radeon_sa.c
>>> index 197b157..66c0482 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_sa.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_sa.c
>>> @@ -158,7 +158,7 @@ static void radeon_sa_bo_try_free(struct
>>> radeon_sa_manager *sa_manager)
>>>    	if (sa_manager->hole->next == &sa_manager->olist)
>>>    		return;
>>>    -	sa_bo = list_entry(sa_manager->hole->next, struct radeon_sa_bo,
>>> olist);
>>> +	sa_bo = list_first_entry(sa_manager->hole, struct radeon_sa_bo,
>>> olist);
>>>    	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
>>>    		if (sa_bo->fence == NULL ||
>>> !radeon_fence_signaled(sa_bo->fence)) {
>>>    			return;
>>> @@ -182,7 +182,7 @@ static inline unsigned radeon_sa_bo_hole_eoffset(struct
>>> radeon_sa_manager *sa_ma
>>>    	struct list_head *hole = sa_manager->hole;
>>>      	if (hole->next != &sa_manager->olist) {
>>> -		return list_entry(hole->next, struct radeon_sa_bo,
>>> olist)->soffset;
>>> +		return list_first_entry(hole, struct radeon_sa_bo,
>>> olist)->soffset;
>>>    	}
>>>    	return sa_manager->size;
>>>    }
>> --
>> You received this message because you are subscribed to the Google Groups
>> "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email tooutreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email tooutreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/outreachy-kernel/8b1e22f8-7a05-b66b-8825-7d4d97e46dac%40amd.com.
>> For more options, visithttps://groups.google.com/d/optout.
> >
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
