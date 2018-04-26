Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755914AbeDZM3D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:29:03 -0400
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:55488
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755197AbeDZM3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:29:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover
 from ring hang.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Panariti, David" <David.Panariti@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
 <DM5PR12MB244017F98FC732EB5DD86E0395880@DM5PR12MB2440.namprd12.prod.outlook.com>
 <b4309ea4-c1a0-5811-040b-4390ce6f297f@amd.com>
 <DM5PR12MB24408FF7C780D95307FB2BAD95880@DM5PR12MB2440.namprd12.prod.outlook.com>
 <87bme8bm9g.fsf@xmission.com> <d5a1b82b-a9c2-e6e8-1957-aab8acac242c@amd.com>
 <87h8nzt39f.fsf@xmission.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <7ea85f74-a52b-0e10-63ff-c0ccf2f63d8b@amd.com>
Date: Thu, 26 Apr 2018 08:28:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <87h8nzt39f.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::41) To MWHPR1201MB0128.namprd12.prod.outlook.com
 (2603:10b6:301:55::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0128;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0128;3:ZD1qNqf2PRrMUM5RRoI/0VIPeUvb4xfhsBtXpXNnosP+l9M1hlG4kziq7Vw0w0uj0zlvVbcuwlrn1hLPz41F9Ft8tWIWWr5OMnDuvYrX9p1stn1fUNT40Z5T0XHzMDR7BUTbSWa/QHQg3SW2EZuD8Vft6M15mhvq3sza8MaTr4C7kAogKbBOcYJEBwoWy1kRU3SwOJth/Xa9SwjNERd8MWQnybnh1idt5AEjxdeCxikrfV8eNGP8JAcfmXBP6pW4;25:Wi/b/mGf2noWk/zNRoeLiGbIbG4w0WnjxrRR4fafUb3Kjp79QOnkkCh4/36cwQrfaoSZMAqeshCIV5KGW2pXM7N67sGsuJ+Heb14FecOX5eAMdPH3yMwSDQi0HjR1mtCXKFOmq5KCWF2Wn0TnrWOETvTqOjBMbLknD3gIVFoBj+d7PsJ5IvBbcfqZw6opPcxDOHwVvux7GsQ81+NtR4mYcu3HkP3qPbFpM6ddiC+pT1CdkvUXWrulP5M1CJ2jvB2/n4WEVJx+UlyvZd3lR6RaQLUttQBwurnGOYrOz9mttFtIsfK4qqd7rWZMASNqg++vPWjugReVfhEqZPLm/Pcpw==;31:zEtAAOuh+8u1vKnvGrA7aYq3nXxKYM3PNh8pdl1QRHqTp0FJ0HC1cr/BkTWoRIN8JdCsla4r+0cLDdh+KdT1Kk1sxfp1ALjVNl8rz5gXiai5Na5/s9065tksT3um1zWp6fpyFzC0eoDNVNbwUkNqIGnjcyjq4wYNdnEtMKXq0BgRoIm1fuzkgRvEQoxJpwfgaZh//p1oifqS4ZLYSRJlcPi2pbJSFOpLIhKjEwBoNlE=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0128:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0128;20:sDGJ3XRoArsHZSRDBblJ2yHoiaJ1rw/Bw+1+kytv7r5CL6al3Xvj078lNe96PWmUytKnXc08a0HJTxe8RZQqEdXM2kGfNmLrpMWngwHOI6TzdHo7hpD2mwBOEnRUMDWyIjvkrTvrCybfwc5bsr4KOKRuSzJRc/Pxd8AN/ud2bmXRZ0CIuSjNg7mYxQfTNjkVlzAwnnToca2EJ0BGatgGqUU0duVSUoHUphlHjw54RyYzEYqI0EoIoUenUbaOrLcA4wpj2Z3ighgpFvpL4gwX8GXFpvRznMoef5spw+zWkKDKS4fkxkmp0Zlk7k04KHgP6Aqi9SXJAweG64HzRgeEYQmuwajUR+Pdrjn7jzZbUS6Ek4qSXk+vQ9ZBQ02eIqiJs6ZK+kwsorPTcObOAjyinjIicPixTTcE5lsv6gnrFnbbQWXLa8P8hAfSYildFzwD9ooUmMUztm/YOpi0e97SXSEZuRKiDYUvnddzBBih959YCLK4kL2QX3CuYm+NF5wf;4:cTMAKLK9en2LB70v/WvUvA/4yBMkWaxW+Xmi1/Bsc/sxW1Df1Cvlp0Qwv4pmFFLJCTgurpwVKKEKHGXmyBfU3yyzKs7EJvJ5BWBG6W9AHVDj/2WvIIrGc7azWGo2T0K9ls88lQvMYfEMaJlwAhIq4cPrf+XORJX8OmmNYL/fvkhuWA4dP1wtB0K3mH2z4nZmLX9CbUQhfcEdseg5mUQqIn2f4Iug80WulT5iFfNLHNhV+R68UhFZ9G8/aF3ZGIm4dzU3NhQ3ytjQK9awfZoGzOXvZOKsstSQjOJDniyLWjJNHoG2lpRtnkq4rStuIIXQ
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0128DF85CA83E19B9E6C7E97EA8E0@MWHPR1201MB0128.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR1201MB0128;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0128;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86362001)(31686004)(23676004)(72206003)(26005)(105586002)(64126003)(97736004)(4326008)(31696002)(106356001)(77096007)(54906003)(7736002)(6116002)(3846002)(230700001)(229853002)(5660300001)(53936002)(6486002)(65826007)(76176011)(68736007)(186003)(8676002)(58126008)(2616005)(6666003)(81166006)(81156014)(6246003)(6916009)(446003)(25786009)(478600001)(47776003)(305945005)(16576012)(52116002)(66066001)(65956001)(50466002)(59450400001)(67846002)(16526019)(65806001)(8936002)(36756003)(2486003)(52146003)(2906002)(53546011)(476003)(956004)(11346002)(486006)(93886005)(316002)(386003)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0128;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjAxMjg7MjM6bjAraTNwby8xY2lOSmV6WHV6WmNjYVVm?=
 =?utf-8?B?RDRkVDhPektrd1Z0UVhxL2NKcXdrUzNJQ0F1dU1TMXVCYXZPdEpVVEI4WEpK?=
 =?utf-8?B?TjRYY2tyR2xjUTNhMlFSd3Z0WGNwb0ZFdGZyc0p2N0trNDBrZ0FEcXIyRXRS?=
 =?utf-8?B?aWpYTjVNaEs5VXFIVk9aZnM1emphOHZONnVma2QwQmdiT3RKNE50VU5qa0s2?=
 =?utf-8?B?SlVYYWVpQ1d3YlM2ZDZPNEhBN3JLSHRrZDlWWVJwN2k5a25YdTdTcnNwUWQz?=
 =?utf-8?B?STJIU295c3poRU9RekFGTk1RZUx1R0JTbitmVVcwVHk3TWRXTlh4OWRvN0Ri?=
 =?utf-8?B?Tlo0WlVvMzk5cUl3dlpiY1lDYUh2aEpyRDlCbnBDb2FGYlNValRUUkU5d0ty?=
 =?utf-8?B?a1FWdi9VVmZ5bURydDM5dk9ra0NwdXM0TWlBZDVUeFJ6RjhjTGt4RkExd0d1?=
 =?utf-8?B?TVZJc3NWbGdObXZleTkxVE8wVjYyZEVLNGp1MTdqSk1GS1VVWHl3VlRNdUVX?=
 =?utf-8?B?R0VweEM4OHhHZWVoSFFhNzJFQTF0Q0VOSFQ5M0drbFhLSFpyWDhwNGtrYUR1?=
 =?utf-8?B?dUlkWDBOTURuL2FGOExWanI2WlhFWnpyNk1CUE9LcWR2eW5INHpJQmhCMklG?=
 =?utf-8?B?MFpab2xHS2JyVVRzQzRvQUI3VDJXQktKU1JGM2Faa3BkUm1yeXYyNC93aUFk?=
 =?utf-8?B?VGV6ZXlvZnlwTjk5STMyNmNhaVpKY003WVVpMjBnZTQ0TC9GcVM2NXNUVkNZ?=
 =?utf-8?B?UEdrN3dOY3ZiNjlxS3ZJREtPenMwYVVJbktTdDdmd3JNMzFUWC9lYVZxbE5H?=
 =?utf-8?B?TkxCOUNwTDVxUDdzNC9YMWZjcWVEaVEzanNEYXEwdWdDSmoyL3BrakZOa0dr?=
 =?utf-8?B?TlVtL3hod0pJczM2VnFwMGNwOVRMYkRlT24zTWZxVVlMNHBxcHI4cjZCSUNJ?=
 =?utf-8?B?RC8wbjZOY3RnNW81V3ROQ3pqMmFzd3BEUlpzbzgvcFJhQW5YdG1FMEZMd1dq?=
 =?utf-8?B?LzdMeU5pc2RjWVo4MDZUNXJyNE16LzBadGp6aVd2V2RCNy9pdWYxSEVWYUZ2?=
 =?utf-8?B?SEdZV3A3bnpNY0padHExQlE2SHVDbXhpRTlOd3J5VW55Ly8wZzkwS1EvQW9D?=
 =?utf-8?B?YmxjSHZxU1lYNE9PSGtyUmRXMGdkN3hqSEMvcFdaTm5WWlJMZ1lOUml6Qlhi?=
 =?utf-8?B?Q0hjSllUeTc0VG0wUG15RnhTSG5zcWJJdDRCcFhDbXU3SGlNMWY2YU1NN090?=
 =?utf-8?B?cTBCcmRZU3F2bzVYVVdwTTF3bTFXaGRjYmtmcVY1REpubGkycUN3VzAyNEVM?=
 =?utf-8?B?Qmx4R1NDRVhFQ2xrRXNUZkVIY2pOMVJWMG81emRCNjdTc1F6NFFTdWJ3UDZL?=
 =?utf-8?B?b2pwSVNSbHNoZTNkODA1MXY2MU9oSEdNRVA0VHdHSTYwRkUvMXlTVWNGVkZr?=
 =?utf-8?B?ODV5TFk1MU9HcFVMcmk3M0lrdU5QcVRKd3VzYjE2cUY4aE5LdGxSWndhdmVX?=
 =?utf-8?B?Rm94Ly9zNUNzUktQZFBuTGZOWmFXciszSTFpZnJ0OTdSZXVKSjNab0U0WXV3?=
 =?utf-8?B?S28wVHVTcERwbzUyTlpKTFh2dXFoUjg4Z1d5NnFRaUhqL1hxU294SnFwcjZj?=
 =?utf-8?B?amJmNHMxcUdrMmVWZE9iSFNJbkFOYXJ4MlZaK3ZkbEt4Y2xENjUwTVpnSWVw?=
 =?utf-8?B?dWpVU2k3U0N6UklkbDIrUUh6Mm9xeXFBTlJDNExWRC9hNFZqRTNBMUxBWng1?=
 =?utf-8?B?cFUyN0tUNWhJaEhQMEpkdUpRUmYrdnptcE9MMXBYWHkxM2tXTWNqeDlhK1l1?=
 =?utf-8?B?TFgzY0hxOHF4ZXhTOCsvUWh3dDBhckRVY2xOZHcrUXZIbjNVS3QyeStTcWhk?=
 =?utf-8?B?ZVdEaEVCRVp3QXdFK3dMRlluVzduMGd0OXVNUThXZU1zUm9pMG1zK0pUckJD?=
 =?utf-8?B?M0NFK2x3ZXhGek04NVk1aC9aUC9HNkdCL0l0ZFdocThUY2RRNENha3JZSTVR?=
 =?utf-8?B?UUFSdW1TVlNManNEZzUyelNmc3N2Q2dBL0VVTUtYMnRhbUQ5Mi92c2plYTQ4?=
 =?utf-8?B?S3ZRZUM1eFI3NUdCUjBXRXlZZ2JwdWFUZ2NBaHdaZFJvR1Bqb2RvNHcrY2NH?=
 =?utf-8?B?QVl0dz09?=
X-Microsoft-Antispam-Message-Info: 3Iuh+RHBSAOKCO6bTCEvdXgCXqXR9brCOnb8azA4FVAJRB52jx8uVP8+hK2hqLCQ4U/G9Sw1kWmzTFLSJJACuRoe+5lG+AoLYG0PhsUVC6v//2Q1jrRFkmOReW13DA1vY/L+nJPHLLSgYTz4Xav32GmYgV4h+PH1C38jCqRzOkuWzIzazm9wwxs86NjLF4WJ
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0128;6:dSyohdysNjHcyxxr61lEtacHM1YwOrVjlBohIhXxjKFgeRE6aXnMufW1ViQahjDSG0LYonOTLMkxeqg29f5dBQupAFmDRPJgrwm6o4I6QlfXil4RpEDyEFuZnyNQUOiVLa70WnDa6z9XLT7/p12E+LqvLUuJmxQh3Pr91a20RYmRJnQRCaB05oaZu316GNUB5UU7YzK9xVBUVdol5/3NKxCj+wuIzY9x1twpjqT7j0+tF1iTpTSXG9Le8bGGPxRCdwVAZNdJ03RXkJArbp5JihKt79wiPOxBzfQB3ixPBll1A76l/5EYzE89fWtNyZ0IDG1baLxQIzkapNnUnAN326D5lqHpdvKuBoZ/2GTqxq6CX+s3wHJ9ltBOhMuAJKvIjeVs4v/8+twYIw53qgzCh99UBEveE1yNESWWC1UVLlvfM3oZuoepjQix0gVi6MRh1drJYZSmSRxAIeWItFGt8w==;5:k4SmvcPi9T7HMhpIO6/fsUCSJ2yKxJGoncQ0mgs50oPW6oOgPr9J6TJKLIeqiyEva3feAB9XEDV+GwG4hX4hq9lTT0vxyHWshL62di0e8rgBOfY2mipqtGDpjqExM6sGcYUV60dNguYPYP691lKHwl/0I/p1ag1ynEhjo9H6oug=;24:szcKWMb4n0m14ZkPkwLDiaO4JpQxZWM2l6fKuyaml5/czuGWVDB57ezyvpb5ZLhFP14SpJkwCe1spS7l6Wi2D5oqk1iYN7j3apXUb2F8nvE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0128;7:Uk+RVs7lfloDa4JuAxs3iIb8Cx1eNUToXa8KLHNI7FXslcM8CZqKHrXa9H/DJ/SWnz5WezWP7eEEnFB4vo9HWZN1KC9RodpqzmBae7qjX12yezq9yNwF84yzHB+TXcqLW2gWIxsnKHQHdD3g/RolGAhQvHNYa0P+Egel+fcGkQymkAwz4Rz6V8nM9mrcn0wZ1VGy3QHFnlxoEUe/sxo+KQaq+/SPNkIlvUnKGwWV72Z7opYd4R+iMzd11/zoweh9;20:yAXfSklMS8sFm3RLvXDtdU5txeqsCN4Us9lMozhiMHp/3cBAVdgiE6NoNwVnzg9Nz1xkYhV2fVI1yWoN+SU2gWr+6dPQ7HyKQR2rOFTkfdN8TqCAWFAZOmP0eub0DXjaTD8SKV7227rQpUuv1HY9cFr6Hx4vbFo1QTq9BNIxKuIv0rFxf2nSo+I0eStgjEzlRwV5Omkf+N5wsNjPIR0H6PfrxOvdp1NAcbimDpGU6+niz8j3iQ31IoFfMmPogPeK
X-MS-Office365-Filtering-Correlation-Id: 164f5848-c6eb-4eb0-b8db-08d5ab71499e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 12:28:58.7586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 164f5848-c6eb-4eb0-b8db-08d5ab71499e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0128
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 04:55 PM, Eric W. Biederman wrote:
> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>
>> On 04/24/2018 12:30 PM, Eric W. Biederman wrote:
>>> "Panariti, David" <David.Panariti@amd.com> writes:
>>>
>>>> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>>>>> Kind of dma_fence_wait_killable, except that we don't have such API
>>>>> (maybe worth adding ?)
>>>> Depends on how many places it would be called, or think it might be called.  Can always factor on the 2nd time it's needed.
>>>> Factoring, IMO, rarely hurts.  The factored function can easily be visited using `M-.' ;->
>>>>
>>>> Also, if the wait could be very long, would a log message, something like "xxx has run for Y seconds."  help?
>>>> I personally hate hanging w/no info.
>>> Ugh.  This loop appears susceptible to loosing wake ups.  There are
>>> races between when a wake-up happens, when we clear the sleeping state,
>>> and when we test the stat to see if we should stat awake.  So yes
>>> implementing a dma_fence_wait_killable that handles of all that
>>> correctly sounds like an very good idea.
>> I am not clear here - could you be more specific about what races will happen
>> here, more bellow
>>> Eric
>>>
>>>
>>>>> If the ring is hanging for some reason allow to recover the waiting by sending fatal signal.
>>>>>
>>>>> Originally-by: David Panariti <David.Panariti@amd.com>
>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>>>>>     1 file changed, 10 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>>> index eb80edf..37a36af 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>>> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>>>>>
>>>>>         if (other) {
>>>>>                 signed long r;
>>>>> -             r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
>>>>> -             if (r < 0) {
>>>>> -                     DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>>>>> -                     return r;
>>>>> +
>>>>> +             while (true) {
>>>>> +                     if ((r = dma_fence_wait_timeout(other, true,
>>>>> +                                     MAX_SCHEDULE_TIMEOUT)) >= 0)
>>>>> +                             return 0;
>>>>> +
>> Do you mean that by the time I reach here some other thread from my group
>> already might dequeued SIGKILL since it's a shared signal and hence
>> fatal_signal_pending will return false ? Or are you talking about the
>> dma_fence_wait_timeout implementation in dma_fence_default_wait with
>> schedule_timeout ?
> Given Oleg's earlier comment about the scheduler having special cases
> for signals I might be wrong.  But in general there is a pattern:
>
> 	for (;;) {
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 		if (loop_is_done())
> 			break;
> 		schedule();
> 	}
>          set_current_state(TASK_RUNNING);
>
> If you violate that pattern by testing for a condition without
> having first set your task as TASK_UNINTERRUPTIBLE (or whatever your
> sleep state is).  Then it is possible to miss a wake-up that
> tests the condidtion.
>
> Thus I am quite concerned that there is a subtle corner case where
> you can miss a wakeup and not retest fatal_signal_pending().


I see the general problem now. In this particular case 
dma_fence_default_wait
and the caller of wake_up_state use lock for protecting wake up delivery 
and wakeup condition
and also dma_fence_default_wait retests the wakeup condition on entry.
But obviously it's a bad practice to rely on API's internal 
implementation for assumptions
in client code.

>
> Given that there is is a timeout the worst case might have you sleep
> MAX_SCHEDULE_TIMEOUT instead of indefinitely.

It actually means never wake

>
> Without a comment why this is safe, or having fatal_signal_pending
> check integrated into dma_fence_wait_timeout I am not comfortable
> with this loop.

Agree, fatal_signal_pending should be part of the wait function.

Andrey

>
> Eric
>
>
>>>>> +                     if (fatal_signal_pending(current)) {
>>>>> +                             DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>>>>> +                             return r;
>>>>> +                     }
>>>>>                 }
>>>>>         }
>>>>>
>>>>> --
>>>>> 2.7.4
>>>>>
>>> Eric
