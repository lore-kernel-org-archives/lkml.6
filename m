Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeECVMe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:12:34 -0400
Received: from mail-ve1eur01on0121.outbound.protection.outlook.com ([104.47.1.121]:53708
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750822AbeECVMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:12:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 1/3] drm/sti: do not remove the drm_bridge that was never
 added
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180502074025.12421-1-peda@axentia.se>
 <20180502074025.12421-2-peda@axentia.se>
 <20180503090648.GG12521@phenom.ffwll.local>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <bd8d12f7-0c71-c96b-80fa-54de7de39511@axentia.se>
Date: Thu, 3 May 2018 23:12:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503090648.GG12521@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: LO2P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::30) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:C/l4t8LvtwjaXM2kNOgqT7AiGRvmiJ2sr+EO3G8IMsFuhqNT8mNanOSZ1lD/43aF4WEbFPlNPctDlE+jyUQXlUoN2EC73XgdDfNITCbOqos5lwtrqPTK764s4XvFjYS3aVVrAFnwkPw+ajg9w/mnG/DGDkEVd6Ixt/RhJprjVjhj4Yz2WZ68mKQZ4YKOfWiQ44Mx3pqiH1ft7swukwGXWbdYID+g9+qRCF6TWKSVfbIlHLNvEHRxdpIc+UZZ3yuU;25:Evxw8L09Sy2FsgIZh6QyXry0l2oeIOptKol14G4Bd/JLA5Rosg/jI6VIDjhRoI5W0fOereGWU6idpw/jIfS1wkL1UWkA0Ugwz2aqBGPgSmlfMoZaTZAEg1BwMXr+s2WKCU+zDIgeXnqx/wDrByzz7EAJvC+wUBPid//MkJv5M2jV4ufhMLBlQloj5shW1UNyInqUweTgsEFKDfNfcn4lq1RCYiKkgIBUlBrAGHKHNPZV3Xrr5nw5MtyOI63XUCZNQplVk6Fg4cdK4NY0oiva0T2Q7+BwL9hgqG8NLam1pS8ogcJJPNh7OSncJH+9I6A2cG6qZaG3EID3Xir6HoSl8Q==;31:gi8rk+eYSFGFs36EILXUrIrWNey0iYvWPZn6QdP3nkUZZa+ONGHMc+PacXRrWoSH4b9lqnJy8LOGycUdCMmBwayWiTtKzMSDDylLe22Jz8BV0OPhxNZyDFalRxxmro26um12wXu+8tJoZdhimoiA7Zb3ws7XRSMgNAgxoMvBbUkeLRrtCWDipDgWUprb1DR5Q/kEojq3DczS9W03jADx2U2uZ51Vr3EnE9WYvFR1KGg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278419D521F065CF1EAAFBBCBC870@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:QKl8Gu4B4OngNXgih0EBWnpgqnwcs3LJ4Jon/tBZyNpJ6zT6XhtZxeNIffBhgJxmQXICjioGZfpUuD9JL1xmB2s/fC1ET3g4mnTquJmOdTntveOFrZgmRAo+YDMBMIziFh+xuR/DDoyy7mJjIXeKRn9Lm6E5+imFn1CAk6nEslNljA0RGA/9BCVr5T3U7kGvaVOM5HWQ7Tah7BMTfLRXK3iLnEEpBoobLDO0+3DC3ge7UhqX6sZQ9A1mGJaJJgsQpNqr+YqsDZDSv/XsDo34XyWs4E9hufO/9AIbRz0+1o2Uz82CXbXkqo8yp//MxZ+fn9qU0v+ZL/xU975Cf6YWKU2KBFU7uI5WmQG2/UHIzJk=
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(366004)(346002)(39380400002)(39830400003)(189003)(199004)(377424004)(31686004)(68736007)(81156014)(36756003)(105586002)(86362001)(65826007)(81166006)(5660300001)(478600001)(8936002)(50466002)(64126003)(966005)(2906002)(106356001)(31696002)(6486002)(6666003)(229853002)(7736002)(186003)(16526019)(7416002)(74482002)(6116002)(3846002)(230700001)(26005)(110136005)(65956001)(53546011)(77096007)(305945005)(8676002)(6306002)(53936002)(5890100001)(58126008)(97736004)(386003)(65806001)(316002)(25786009)(6246003)(3260700006)(2486003)(47776003)(36916002)(66066001)(11346002)(16576012)(486006)(2616005)(52146003)(23676004)(476003)(52116002)(117156002)(446003)(76176011)(956004)(921003)(42262002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6bDFsZURyMlNqUnd3NGFyQlQxTGI0K1dw?=
 =?utf-8?B?ZG45MnVKWXdCOHo1Z0g2bHRHakRpVGFRUnM0ZE1tK1BqNzlZQmZENTZiR2Zq?=
 =?utf-8?B?KzBLZmcrajBHTFpXODc3S1g4Nml3aktIS0JuSmM1WS9tQ0h1QUJycHdsTjRX?=
 =?utf-8?B?WmxHNlFuUUcvdys2QXhvWGYwZnRSb0NHcktPdXZhbzZwVnZkTGlhZDQ0bU5M?=
 =?utf-8?B?NWRBVnIrZmh2RUZDaDdJK2NwU0grTWFBei9FRHRINWgyeWlpSm5XNmUzdllD?=
 =?utf-8?B?L09meDdNOTlHbDhZc2JGOHBFcW52TzJyMVFEM1NKZEV1aFRUa2E3elFiUEF0?=
 =?utf-8?B?RHVPaHgyTzZRUjRRcEZwdWkzZkJtOUZxK2xFR0Nuc3ZtKzlEMThWekdFOWNP?=
 =?utf-8?B?Z2s0aU5XV3dZcHZTZDd5dzBFTTR4c21YdE5BcUZDRThRZlNmUGYyK1NZUWl6?=
 =?utf-8?B?ajgvakIwYzdsdkpZNis1RDJuZ3kzRDgyZ3ZsT3dFdTVmbW9oRzRIbHAxV3h6?=
 =?utf-8?B?d3pSVWFFVWg3cUFMNVBpWFJ0b3J1ZXRTQzgwLyt6OGRZelRMSmdPL3dQT3BV?=
 =?utf-8?B?SEwvS2ZDYlhxYUkxNTlSWHcyVGIrWHlvSld0bW5KMTNBQjNDRys5eWt6L0pN?=
 =?utf-8?B?dlhHRDQ2b1RBeVNBb2xCeDRoR2Rkbnp6b2lVaDdmejhQR2Zkb3pZeUdYWDZD?=
 =?utf-8?B?U05sR21IVnFMWDkxUUpBTWZvUDd6QWhCZVB1Q0NZU1BLc05uYnYwN0dZRzIw?=
 =?utf-8?B?WmFGWnd3eFBqNkNRcVJhNVBOaHBxYXJaY3hNL3hqb1d0c3RHRmZkbXgrQ3Ri?=
 =?utf-8?B?OXJlczZDa2NMdzNoRkpsYS9wUDZRZnZreFJKY2lPcExhaUpaeDVMZFMraGlW?=
 =?utf-8?B?M2VZTWgybmc0YmdDWlJKYVdSN1MrRlMyWDhnZVNFaHpxaFdqNjAzdGFxeTY1?=
 =?utf-8?B?MnF6MTNMZ3ZvMWd0R1BqVGw1c1B5T0ZmOGVBWVQzKzFSSVhKenhrYjZRODZT?=
 =?utf-8?B?Y1hEaXZtSG9WRE9Yd25jNWorRFQ4b2dBdHUzQzMzZEJOR3BCeHFLL1VpM0JT?=
 =?utf-8?B?cGNjV0pobVNKKzkyWEcvSGxxaWJWRW5Ddzl3aEJhUS9OWnFqaXBmTGNoOG5u?=
 =?utf-8?B?Z0JsWjdhUGFCVlU0UkY1Q1FvaS80NTIxYkZOUzVRS1gvWUhBU0t6V21lVVN6?=
 =?utf-8?B?N01ZRlNrSVptSk5JNGkwOUFaS2szUjRWNjBVa3VocXc1VVBtQXNyWG02QllT?=
 =?utf-8?B?RVRia1p2Q1A2SmlvVGlWUWdTRTJ1ZDJSQStxWEVuR2QyRjVSaDBxQnlrOTBl?=
 =?utf-8?B?Q2FaZkVnVHVxYWNiUjg0ZFp4OW81WUZURGNQNWNaNU4yMHZ5ZlpPbVBaWVcx?=
 =?utf-8?B?WjA2Zmx0SFAyS3FmVWVQYnlTY1lQek9nSzVIQU5TYXhrQjN6VzFWQ05rQWtO?=
 =?utf-8?B?NEMrb3Mrd1Rsb082T0FJT20xbzFUeFJ5aDVXQ0pHUElCTCtsYURBOUxUYXFx?=
 =?utf-8?B?bzV5eFNhY0xUYXk0QzlzSGtkK0htSVZOQlJGZDRXcXNnVzdacHdxVjB0d253?=
 =?utf-8?B?YTQ5dFpWc0l1MWpGRE9CYzFYV3VhbjN1U0dsbHc3aWcyM084aW0vcjNzRWJa?=
 =?utf-8?B?MlZ2Qk4zNXpCSUUzL3NZVmxaRVZibWlrallqWUFwRFgyNzlWTE9YbmtKSWtk?=
 =?utf-8?B?QUtWWHdVNVRGMlJWSUtKVHlGeFN0NE9iVWo1Zk9kY0FPSWdUcCsvZkp4aStr?=
 =?utf-8?B?UHpWaHVBbDVEeVZxbzQ3N1VWUGk2ZHBlU1cvTlpmMDZpK1FvWHNqRS8wSkND?=
 =?utf-8?B?VStOeHBoOTBZWFZIL25MMTBMRGlNUjlGVWpUTUdtOU4xWW1Ba0NvbDlrK2h6?=
 =?utf-8?B?YU1nMllNR3VNcFI1anBFZ1FvSkNKRTlnODVoNW5Ra2Frd2pxeVNNLzNoRzgz?=
 =?utf-8?B?OGNFbUg3d1dWK0VtOTBpRTRJdUxJRVF2ZjRxWXQvb2c4bGswZUxqUG9KSTBl?=
 =?utf-8?B?cG5oTzBrSHNZdEFYbS9QUkZvVGk5NWhkRnAxa3FjcFhJTzlGdmlvbG5iZEZa?=
 =?utf-8?B?Y1FMY3ZLaU5IZFhSYWNUejlhWHBlKzNUeE44a2IxQTZvUG05MFNWL2pEOU0x?=
 =?utf-8?B?UlZ4R0RPR3ROV2d1T1I2VkljMUVKT3NhamZ3bUpIQVZCaitHSE4rSUFUd2JH?=
 =?utf-8?Q?RR5Ki8cEmuui9akA2d5vr7Q+jb9+bqEG4eLUnSa9cI34=3D?=
X-Microsoft-Antispam-Message-Info: FXQPUCUmcRT9IwijSYTEistoozZYLoWeJx+EeZHVDBzWWPWmd5XiA1C2AYtKBxh9rVgBqz8rmPVq9j9EmAjGs5cdvt9N7Jx2t8ppNf/T1vtJxMZTrfHVnLG2eOloh0TiuKRNC8U4Mrh4EXU5Jv7XmYia4Z1K0n2Uy1w8jceRd4SlMXklYCyQYH6bQxW+2U4M
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:bhSrAeop+Vz1aBCLRPMYNGw6bX2YtOFzn5M+Y01alPJyhoeigoR0718pu1WQB70nd506TM2wPiSOJ+AsGs+2xEmbPoQVGSMDb9ZtL/+D3Ji4x/NxtEZHciINngYLKM0bqDNoTMsQJqMwEBjoO5fv6dneK6wxJ9MWGCQAFWCbpdQJndsiZB5Onvcn38PBd4VBNe2bE+r8/ReyMt4Sj7rYusoBKXj4nT54m2nP6vV2JSM6c99smGNJtEVkeJbxSVprz2ho+11vAux751hDooJC5BpZXMl7fDicA+aN4sVxgqnZNz90OSG2g/oX4FDi4ZMWfdhxcHW1oBGRkzU4r+FNi2lN3pNXhdNHT2WgLskw9pjWzjmswzE4p3kSacsZZm5b1wxGouYhMErSb58lXh9OP1cEhVzwe+UaKu0XubKW6/+8jY2JYrJIqfQKhqQS2qmslrTiAGm7DFEYnLNCTKHtxA==;5:bZRqNlyeO8A0AENHwuudoDUqtVlFNRIYQKd7eQ66x4mqNOgxzN0bScLRV+oPqcmBe0GsMfNVlTi+bPD2mHTzVAfs5rgNFfmZXm/CgFzYoSpBDC4X801SEU5SDTc338FzgtPZfTCsZ80NZB2AJKhocY/UR2zRTrWiOmoP3yZ50+M=;24:8J7uEHN9jysHcTdW99H7MbgW0n3IlaqpMMzrKUHlHbViuBL+MtwKuItJrrdjwbipsPa5mEfwREY2+O0KETqItolRMN/HhvMo6i7QVukM6z8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:ESALgc4dR0jAVTyoaQ5KXJlLXI4FG8IehbzcmVHd0FrPm95aO9jD+UrvEDzlJ4XvHae/gjP5CAp0ghjpvWJUkDJNSbhoqWL3oJmBH5Vafqz1HIftKFuhSuSOadtm0hoMkT5h7Zcpu8ljl72bl/pv3wI7L8r5z+35C/XHnm4/mmGh67RsnTusOA97jp/LuEsRCOMtP21eFqvMRSC98WqVFvU5et6gO15ScpWO4hUrevZ8Fp7fRFPkCv80lxloKAoI
X-MS-Office365-Filtering-Correlation-Id: de4e3897-8e7f-49e0-b9b8-08d5b13a9229
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 21:12:25.3408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4e3897-8e7f-49e0-b9b8-08d5b13a9229
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-03 11:06, Daniel Vetter wrote:
> On Wed, May 02, 2018 at 09:40:23AM +0200, Peter Rosin wrote:
>> The more natural approach would perhaps be to add an drm_bridge_add,
>> but there are several other bridges that never call drm_bridge_add.
>> Just removing the drm_bridge_remove is the easier fix.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> This mess is much bigger. There's 2 pairs of bridge functions:
> 
> - drm_bridge_attach/detach. Those are meant to be called by the overall
>   drm driver to connect/disconnect a drm_bridge.
> 
> - drm_bridge_add/remove. These are supposed to be called by the bridge
>   driver itself to register/unregister itself. Maybe we should rename
>   them, since the same issue happens with drm_panel, with the same
>   confusion.
> 
> I thought someone was working on a cleanup series to fix this mess, but I
> didn't find anything.

Ok, I just spotted the imbalance and didn't really dig into what
actually happens in these error paths. Now that I have done so I
believe that the removed drm_bridge_remove calls causes NULL
dereferences if/when the error paths are triggered.

So, I don't think this can wait for some bigger cleanup.

drm_bridge_remove calls list_del_init calls __list_del_entry calls
__list_del with NULL in both prev and next since the list member
is never initialized. prev and next are dereferenced by __list_del
and you have *boom*

I recommend adding the tag

Fixes: 84601dbdea36 ("drm: sti: rework init sequence")

so that stable picks this one up.

Cheers,
Peter

> -Daniel
> 
>> ---
>>  drivers/gpu/drm/sti/sti_hda.c  | 1 -
>>  drivers/gpu/drm/sti/sti_hdmi.c | 1 -
>>  2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
>> index 67bbdb49fffc..199db13f565c 100644
>> --- a/drivers/gpu/drm/sti/sti_hda.c
>> +++ b/drivers/gpu/drm/sti/sti_hda.c
>> @@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
>>  	return 0;
>>  
>>  err_sysfs:
>> -	drm_bridge_remove(bridge);
>>  	return -EINVAL;
>>  }
>>  
>> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
>> index 58f431102512..932724784942 100644
>> --- a/drivers/gpu/drm/sti/sti_hdmi.c
>> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
>> @@ -1315,7 +1315,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>>  	return 0;
>>  
>>  err_sysfs:
>> -	drm_bridge_remove(bridge);
>>  	hdmi->drm_connector = NULL;
>>  	return -EINVAL;
>>  }
>> -- 
>> 2.11.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
