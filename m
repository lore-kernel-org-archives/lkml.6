Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeDXPwX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:52:23 -0400
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:31872
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750842AbeDXPwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:52:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: David.Panariti@amd.com, oleg@redhat.com, ebiederm@xmission.com,
        Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <a463c05c-1236-67a1-1ea9-2498647d698c@amd.com>
Date: Tue, 24 Apr 2018 11:52:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b::4]
X-ClientProxiedBy: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To MWHPR1201MB0126.namprd12.prod.outlook.com
 (2603:10b6:301:55::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0126;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;3:65k50L56gJ5HChdvqXAodzXHDhffbktRcqDmUWkdDCNO0rT7GDaiPPz7ROOMdZLZjKKdvln6TZbEm2ST/gDOEWBVYlr13B1s/iIv+uFXxASmZsxMlK5Hu2wZjpf3YJCMvDTzI5182TD/FUPv3T8bHFxA45MuAYnts/Y8dSoS73CA/844FAumb6Zz35sh0cuPRGkwQs8CNaSFfzX+xe2QG/dMCdPP82b39w06wUjXLSkyUYE3xhiyXD3gMRh16xuC;25:MbM4Gp2ZjPsOXxwhv1025K3wAIqwy/tR0GFYvq6cAm2gTr0ZZAYzUuZJoh1M9UN/DGPaZzClK714lTePeMeFBhgTqSvRoNt0BvlI3BWLZGU3TBzDXOUNDUAqdio7ELvl/MLUkzhK3FJrHxz5IMlM5vTAFGMn/1yh+utMWiK7ZGUoxIJytvqnHfLQWGylOcg/IdP4GSsEf325bsWNSoyyEHpY0d5su/m5fe/Ag+ARfeGS3IQoz4nwLCbwZNPzG3OTneJc0v4eTVpXFkHRDfJkXkKxCMi0xc9QjYuy+bMamHcIwB/kkMu3+O4Tye6Gd568xCCfbVjYKVHfGNPjIx11Uw==;31:Qfde+3qqMolc+l8U6ODrzJ+ibS1NBeGFaU65/L9adozcH7+ICKYaNTqsycqcbB/fhC5JwXpMh52olis4SVFewy8EkKkIhVLGm9wUfQtMvyOLvhssiC2rI/qxldFl6kSKy6VRzwMnIlZEnLXJxCF422vX7mCLVGkevnj5JNzIbaA1EGfiy4wI0cVC/x33K2cFUMyDRApe9GDGt1FUJr499ZCBeVr8SP3GoS3y0rqKPA4=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0126:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;20:fQGpfysmzfVr45B1nsw15KZ+OIYx9Q9nXG9OXBo8w2aosP6XZLDRX18ZSkEZ9LY84RHyZokmSM5STGUmRGGUO+Y6tY8wN6IM41Z4IhPdG9Mw2pkiqDxQdb6F23pToQaEiIBqijD3yYcmRAC8rjrKfSUubFqEc0Mw/EcQR4QH7k5R6X37ICqSkCYMDKuTjzwRUh793Y51V37ra3mRRkzlTz9cgj3wdJyHBkqa618soau87DH0NyiY/CLKNWul1vqumCdUqoB6oReXJW2ulC5JK2sexGY+J6Z3ExR6v/hYPnQtDW5FXJwI2gf8xJ+aBvsFuVSskcNfmx1Lt9tlYucbq/blXQ+uF/qWi29mi76YYhU749Ah/773pRPxRRov03QP/BcZ4avSy/nsT6bpIG6BvZKyUPA/5gyEKdI/llZpSB9k1rk4BIi5x70fMHgHR39ZQJM5+/zainx3mYHLPULBa/izmFCttLUMuPfbLxhIMiHSeUNVDlXGMxKub6joujNo;4:c3dkAlN4lsm3vX8L9VkZXDDBEnHJKJ7u2WtlNEekVe0565vtrhtNoeefaPp9zI6b+7GHgszUye7G0+P1Tby5ji20vVvv3gZjYtXN87FwAvirra6gCYZ7+yVtimyBwdprgMQduhHhbdGBcjlQ0iHJnKva4xvUMrocrB5g0ZzN+Z6xrVwumGGevZKNDUmf/6n9ToXL2wc5DGOpYugvhfyz6ZfssOB/OY/jhAU7mNsIi10/aH61Hu3u/CXSzoMoj/Iukdwu5MnGVMuN+h3RLXdIAE7F6sJeWPkeVYiytMfbfqz1T6g3tRKAHWzJI+S79ZVx
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01265CA02227774D31F4A26DEA880@MWHPR1201MB0126.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR1201MB0126;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0126;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(377424004)(50466002)(64126003)(58126008)(316002)(4326008)(2870700001)(486006)(6246003)(478600001)(65806001)(6116002)(65956001)(46003)(7736002)(2906002)(67846002)(6666003)(97736004)(47776003)(105586002)(305945005)(52116002)(31686004)(31696002)(81156014)(76176011)(386003)(81166006)(106356001)(59450400001)(16526019)(53936002)(68736007)(476003)(446003)(25786009)(72206003)(11346002)(2616005)(86362001)(229853002)(65826007)(53546011)(5660300001)(6486002)(1706002)(8676002)(52146003)(52396003)(8936002)(36756003)(23676004)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0126;H:[IPv6:2607:fea8:3ce0:41b::4];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjAxMjY7MjM6M2l6bnpPWDcxVzAzeE9XbFVnR21wMUJL?=
 =?utf-8?B?VkpINkk1QXlpVFRpdmlRZXRBZ2lkMHRNby9Bc0VtZHh0ZlJ5Z2pFcDZGYXRs?=
 =?utf-8?B?SVJ3UE5JTU1QcUtaKy9NNjE2dmM1ZnJZclVEbEdlUzh6UldSKzlmZnBzMWk1?=
 =?utf-8?B?K0pNTHhMdHUrUXFtM2JkQmhjb0g1WWlHaXBKZFo5L0FweGRWZHpBMTBaL1A2?=
 =?utf-8?B?L3haZGFUQmNZc05Bc0dyNCtQekFsdlVYZ3VZRmUwU1FFRWdyYUIxUmNrTjF1?=
 =?utf-8?B?VDdPK3NVTVpRdkNRSm9FSmZOOGxFSVlDeStFdWlJVUdtcHRGZ01DK0tieVZm?=
 =?utf-8?B?dFliVVIvWm1CblcwQUZFZUNaQlRPTkRMS1FmV0RWTTJZZXBhNjBSS2Jibnhu?=
 =?utf-8?B?Q0NDN09zdFhDOEt5UzBGM2NUdENRd21BTk5UTDJvTXBXc21hc2pFU0paczF1?=
 =?utf-8?B?d0NacDl1ZnZZZXBKcFJwcUhtb0pya1VuMEpoN2djN2pKamw0bXRhWkxPcmgr?=
 =?utf-8?B?QVI5d3YyUWIwaWJUL29DK05IMytGMmdRVzlHcUxWTlQ5VUVCcjlvZU9pVnJ3?=
 =?utf-8?B?Nis3Q0hMT0ZjQ1BTOUF5cFdtNE0wRGZZRGs5ZmZGTTVHTUlpRUdibktLY1cw?=
 =?utf-8?B?REY3OE83cCsrM2lyVlJFclJRZHYxMXF2d0NPeFQ1dU9MWjNQdWhDVFl2UzdT?=
 =?utf-8?B?Wml5SDJ2WmlEVlB1WE1XVlI2MXNOU0pCcjBhdmJ4bE1RTkdsQ3Q0RzBaTFRJ?=
 =?utf-8?B?SjUyT245QVg3YkwzMld3ZG9YSjRPelBYQzZiYlA3dmxPWEJadUdWMTl1ZE1v?=
 =?utf-8?B?RjZtRXVFRG5OdFBqSGM3S01nV01rclNWRTdMeDFyRDNFbkVIKzM2MElLaGRm?=
 =?utf-8?B?dGxhZHgybkg0YjhNTVllcjRKZU5MeEJ2UHhFMzREdCtBSEFoM2kwVW1QeEs0?=
 =?utf-8?B?a2ZFUnRWWUFGWm1OV2JUeWlNeklORnprYy83RmtWK2VSODF3UEVDTSs2MmRa?=
 =?utf-8?B?cFJQSnBhVHd2MWhOODBEY3VSbHE2YkVyRFhDdzEwOXZCL0Fta002eFRtazN5?=
 =?utf-8?B?NUIwN0JNNklmcTJ6T1FtYTYzTFJlTGF4eG12dFRaOVpEQ2JWSUJ5MWtCdXFh?=
 =?utf-8?B?RlNJczRSS2NRTVRhczE2T25IVDd5cDFmSVRGOW51My9za1AxMXJ5UzFtOVhs?=
 =?utf-8?B?LzhvT01DTnkra1E4a2s5MHQ2ZEorOGNwbnZDWGlub20wcUZEQjIyWEU3YkFY?=
 =?utf-8?B?ZEJjTEVrdTBXY0hoTDRxVjhvWmFsVGlEdisxNkJBWHF1d0huMnV2Y3BSU3VU?=
 =?utf-8?B?V0lLRWw3TzR4ZU9LVXpBRDBJQ3NCNzRCYUt0MmtzcVdTZ2pKaHdZNW5pa0Zl?=
 =?utf-8?B?dEhQV3pscE9zQ3VCUGdrc2pEY0VyeE5MUDBnTWtWVWYyNVBxVjZnMTRHSlVm?=
 =?utf-8?B?OVpNeXBMVmEvbVZaS3BIaGVoZERjU2I3dFVGTEhTNXZyRlNZaEZZQXd0V0JF?=
 =?utf-8?B?V2M5ek1QMW9oRUpkQWpYWDlSWVhrdld4c1FnRXQ2akpVdkRlUVNIWDNFUjJF?=
 =?utf-8?B?NEppK0kyWXEvUXpYY1pic1hnL3oxWXlhV1BLVVA4UUVBQXljeVhvUUR1SWVa?=
 =?utf-8?B?a2Jua3Z5SlRZVTBQRWUwMC9aWGQreCtWNE1jandGMHVaVWtzK0ZFY0lFVmpS?=
 =?utf-8?B?ODVLdVFuQUpXc2wweE15TUVJaXFaU3h2T05sWFU2bVROandkN0kxaXcrSGxr?=
 =?utf-8?B?T3R6bERxQm56b2t5K0tlUGtjYnAvcEVJdkIzNmFJWEx1Qlc2NDJWNzRIbXFN?=
 =?utf-8?B?UTI3Q2VtbTRuREdKMnNjVnBwOEhJNEtaeDJqOXpSVzdxMHR4aDMzVEZlNUFr?=
 =?utf-8?Q?18mSRQ1kLE8dPopZX6JSzzm9GfZTuT0Qn6?=
X-Microsoft-Antispam-Message-Info: Y9yDHOYLKunsqPo5zPmmjsLFZFWIO5a2xvUu5kA+zZoPvYfGFNpsWkffzNx0S7hUdeT0YDonkXWayKMM6C6C6BCw5ogRfZ4mt+WQkl46gM3MlCNZnSATw43vx51pZQ8MDE2NzPe4achvue0/sGeAYbLonkH4ViR5Ihq4fnOMutFJf8u/G3rI9QEFzgU8Wn6k
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;6:zRxYRAq7ZHfNLiWQCTbZmIEtaOuAk3B+Y/i+R4w4zNBwFJ6adLRlhy0/MQEM4EyzULGAthnn8iulfwtjwjjPuNKMx6wVBDl6+009tZrlPuEMGSl5Jt2caVayt3QPBuTQ6MsbVGy1EaRo3O6vt59Gd7GFRVq27YG7bVNFgzTd0Xp3N9IpLzAE7E8HyFks8XM2V63psf7mkr9PkbOL3Y661fA0SE82APRz5bXcYiq3auKHUOn0bNhqx5ybyI/Uoc5fTbtTNEQdmzT/WSLvrXO/OY0nRoDAHgcB2P/xXsroNKZnOvboGBmq+cCYG0jxDeoavqj3DAdC58Eog/1Y8EMYHvDF1hGpTbNMnlJmKZmGdNWA7Q7KT91ecGCb4HoIiQ2f6iesPgRQO3EPzfw7Hglb/y1t9pJQkhlbG96nDrbUtM7l3JuDh74+G3Fj0wMMN9lcB32CMZ4zwWkrBqGnNvpgSg==;5:6ySYNp0BBeqpA2JCiC3qtZxJUmauMcF39OayYo9ciJhNVVEgde5F/HNyNHskETuhfDG+MV645PYqeP1T3tXpYyiitcNvuISQtlwfKbs8Fngf63y4B2NhJ37lxPSbZOnNtj5wJq+LobxgaUeOeCIXxYNbHdKEHgEeV5yHzaaRyLc=;24:h3Wg+20oB5SCmfxb5yunijtZdneGPRo2ab/8Vb7Apo9zgWFM3o6H0re4KondPVRF7dh/gEz6vR48glHqRMc93YTOtAFJyZTX3u8dbOonUuY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;7:BqtthMaSfrcapBvI/nXsKvNc4Vg+vzqJOJx8XppIyu8+oGVOGWYyckvd4FIKu9BWQna0yB146r7/3CYhd0DOGSj0Pm4fpusB5MgPRQ48UDwqQbf+nClFzzyc3uz8mRUSF5A7ZDiMPmG8Ekc/R6J7Kd85gICPD96UyzEJ3o64GnZlNdrcOhLB50yDpVikpBROV1lFV2Rc2bN7Pj+ve4mIHKR6H2rQD4mxIEcsMCBnj+CihxTpKJ2mRXV4Y9+wQoMI;20:rIXlxsgceKY9k1tdWsn+mICzs7M0br9NW6MbBPcVelvRv/X14WcaH/w83sp1AHuzZziyHyf9w5cV/gQ9WI17sp+VSo5TAaOtUqQOBawZ8lSzK2Ynodt0fILxfZhh/ul1tF2z+P9rmPCaMSIr3a9W3DoGM0EIdVKizlpQ5d7OCkVB71EhLi9AHnt2xptA/m00pLiRrvqE9UEfoXnyQ9JpKQ98Ex5d/L8HroprqS7NoJ4ZPXMQjPSDPFuHI+vdxET1
X-MS-Office365-Filtering-Correlation-Id: 50fd9477-638c-4a6a-4bbc-08d5a9fb5859
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 15:52:11.6613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fd9477-638c-4a6a-4bbc-08d5a9fb5859
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0126
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 11:46 AM, Michel Dänzer wrote:
> Adding the dri-devel list, since this is driver independent code.

Thanks, so many addresses that this one slipped out...
>
>
> On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
>> Avoid calling wait_event_killable when you are possibly being called
>> from get_signal routine since in that case you end up in a deadlock
>> where you are alreay blocked in singla processing any trying to wait
> Multiple typos here, "[...] already blocked in signal processing and [...]"?

I don't understand where are the typos.

Andrey

>
>
>> on a new signal.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> index 088ff2b..09fd258 100644
>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>   		return;
>>   	/**
>>   	 * The client will not queue more IBs during this fini, consume existing
>> -	 * queued IBs or discard them on SIGKILL
>> +	 * queued IBs or discard them when in death signal state since
>> +	 * wait_event_killable can't receive signals in that state.
>>   	*/
>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>> +	if (current->flags & PF_SIGNALED)
>>   		entity->fini_status = -ERESTARTSYS;
>>   	else
>>   		entity->fini_status = wait_event_killable(sched->job_scheduled,
>>
>
