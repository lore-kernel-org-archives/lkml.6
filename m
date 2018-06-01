Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeFALsw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:48:52 -0400
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:33860
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750850AbeFALst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:48:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] gpu: drm: ttm: Adding new return type vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>, Hongbo.He@amd.com,
        airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20180523185538.GA975@jordon-HP-15-Notebook-PC>
 <CAFqt6zZq_GN2gjv-noP4RsOV74xCBGQjgHYadCOgaETv0wu9_g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <04ea0685-0141-b12c-06f6-f246a318bfe4@amd.com>
Date: Fri, 1 Jun 2018 13:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZq_GN2gjv-noP4RsOV74xCBGQjgHYadCOgaETv0wu9_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM6PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:209:15::28) To MWHPR12MB1728.namprd12.prod.outlook.com
 (2603:10b6:300:112::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1728;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;3:ogZuh2EzhxbNQNp0SqVNYzoO0UPr+OFdB3KLmMUKLFn+mIqdf1EftleJ4mtepnqX/1M/FtXy2yMBIoptpvNV4HqVDxlBv/QtBorkZhu3o1HQKcjM4DxPvZ4YDDJf/odOsln2+crEnSmW5CXvv2Z0vw0XUX+IBvlYaCYhLqpgqcSA7JxWJt5TE/xzAcarZgYUyyyf37VnVS1oAzhMCpCk8pZ8in1J5HbIoMD0USpmLojPT07jE8yS0i1TLLJhfVEE;25:hwGCXAR2P4PBcRDIqOgwlv/DxVK2GePae7Z+cFWysNto8DnKKoTi66OTdiM10cHRzw6PikiLikXLkoxeEWWLGuIb1fBEsIQKDWd9ci9X2Vh1frfhT0SxYnaPAczfPBdO8XyVZ15+DYifxcY/Db0N2U8arhn0CebNR4bYXeyGubBWS9HKAsRflhy3QiDfrutdfwUunD+8Gw42XOc1Xb6ENnTyBqZr2HoE0eBxxIDhU6hSATIKIEggIWfYzZT482nw9zLp0WYPoViItlVyOQLy+WZgH7M6X7xaBgzQEqwxzZYlSfrnET+KPpO1ETe9INn/Nt8ZRvcyidFe9GKByZm2ng==;31:2TjgY9Lxwo10/fag9biZhbJEBKGQ0M24uJeMyCzGNuqSkjlEtuYYokDMJUTyiKSZuK85vU7gdtTxBnBsHSDfHrFILgOIF14MH4INkk+akk++TbnXVC1HGVUnT/DyZF92ZBbWNQGOkGAq8DGP9RChkQ8AQ3GIE3FjAkXQ8KDFY6poH2qyMEx4V0jM5eusGUvB8TbqL26bhK634dCu3p+Q1Jjbt6fdVAhK7m8e/DFTIGA=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1728:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;20:1JYuNtASCEvhDHN9PU6kRlZ76APJ+cf35y1tnrPo++MTh/rhieiSg3Pl7EA6RPIuTdSuJgT+jRFgEALxQH/DYfNpWtoaaeFfQg+RNrqtMVL9d1/MCDDmokQH2H34W2A3cAzhXGs0yUYpBtFf5xDFR64zp6dS6ob6M9X0J9Dz5LINOo8rqSxqYb28r2a2LAeU6t/+9Fp8XMqSVWxg8ITs3aHos2Og7QfiRhC1vbH4n/qOhHFFjuONchTiSdZdwAM28UFEyZXA0W51VrCe7957Ng1LBec6IkIanJH4R51+OGKfBXlLftlvNrNuS5j1XHBSKsX0yeFF/b3w7SmBoWOgvqdqe6T/SWq6Kt3QeltFpqdBUPsXFZ8D1p0X1ZeIqvaM+pMR4yFjlbVtEwv32RRr/90/G81VLVJOoobwgLq5U4z49UnvH2EZNXny45kLrbXmlc3mtJySMjS50WdMoCOuMTAQVnYS6nuupCdwZQoeZqSoUUxe/ePcTqdXwXfW9wli;4:DbL7QQJqhEHQGtFGQh+ywfcg2aL4nqQInS5hDxQo93qdgY1EFW8ToVAcuK33Zxy6fTFzvGF7fsNKKwy2DVllCVvszUM2inEwR36dHSDKfJ1AJcI53g/0nrvRaMbIPOP7ZFnEQNFfCSnTsi7j31dnoNEc0mm3KOoIl48IMVB8JaIm5dROvGM9YkrQzcYeWGVlEHvSJVM4LRpHvFCLB0qubv6OonJZ7FOsPhaxoHQC+f2zzwf9sf5PNGCyPVEBRSXBZdNiXHjLe5qtCUJZmoZkVvXaKc/B2d6JpB4l4AY+fy0kjmqOFSFHT1PhhJbrNj3HG0F2ACG9Tvhd8jvK9j3vGg==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1728FB388617A86FA03A042C83620@MWHPR12MB1728.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1728;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1728;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(189003)(199004)(64126003)(36756003)(72206003)(65826007)(8676002)(81156014)(229853002)(47776003)(230700001)(1706002)(81166006)(65806001)(65956001)(6486002)(67846002)(25786009)(305945005)(2906002)(53936002)(6666003)(16526019)(6116002)(7736002)(478600001)(8936002)(186003)(4326008)(59450400001)(39060400002)(31696002)(316002)(86362001)(105586002)(6246003)(106356001)(97736004)(386003)(53546011)(50466002)(58126008)(52146003)(486006)(23676004)(2486003)(5660300001)(52396003)(76176011)(68736007)(52116002)(476003)(11346002)(2616005)(46003)(31686004)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1728;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI4OzIzOk9na3BFaXdjZkJPZmF4K2FERnNlVWxSTXlN?=
 =?utf-8?B?b0oyRnM5Vjk5VlZSVUNwTUgwdEE1bW5CZnRuRVFWbE5UV0dPVFl5cDVyUXZ5?=
 =?utf-8?B?MTJyTC85RC92UzRLd3ZtRjBCcUNsbUJsL0dCS2lyZ0R0aWswYzlXVStIaVQ2?=
 =?utf-8?B?cUhaOHFPN08rMXhDQ3p4UDZkRUNOQndjZGhXbVc3VHA1Ymo0anZIbVhCN1A5?=
 =?utf-8?B?dW82VE13NUdkUW5PdURCdFRZL3FZVGM3OTFEZ1M3SnN2VWQ3eVhXQU5PU0VH?=
 =?utf-8?B?LzgwM05MMnQvVDVaSmxFL2FicWl2YlY1Q3JtS2hXbVV6Q1B1UFlCYVVRY0lm?=
 =?utf-8?B?dVJEUitIYVFlZVdDa3BQalplMnhzSVZjT3Y5NEVxWmEvZWxKS2dYK013ZDdT?=
 =?utf-8?B?c3hMT1ZtWUh5Y2tzTVFxTmg3RWc4ZG44TTBabGZ0WmJIeDE0N3h4Q3F6UFMy?=
 =?utf-8?B?cGNOb01nYllOSEhHOXp4eXBtdnV4dnh6Y1ppWlBKYjEwK21pMTZEMjdTbDRS?=
 =?utf-8?B?YU5MNjhCQ0Y2Qk5uMWI3ZFNLYnlRaVFsNUxHeG04ZG10Z09rTEFESWsvVTR0?=
 =?utf-8?B?V2x0bGZ3T21Tc05OaTdTbm5PNHZrT3ViQmFOMklPZDk1TExnbDV0MVpQTTRH?=
 =?utf-8?B?dWhRc1dvenlWS3l6QmxGZlJETFdiUDVndlg5QzAwUi95Wk95T1RMaEVyTnRY?=
 =?utf-8?B?YWdCZXl4TFUvOTZCZUphS1phSFNVZFBSSytBMTBmZGNCRzlXSGdMK3o3dVBv?=
 =?utf-8?B?TDFOYzUvWW9VT0ltSWZlVW9UQXZTMkJLY2pWNUZnZEplOStrSTA4QXZrd04x?=
 =?utf-8?B?ck9uRjVhVGxOeXl1V1p0RWF0KzJSK1lQc1VCRXEyMTdwc3FEOVd3TFNVN2NW?=
 =?utf-8?B?VGxKd0xDdEVnbWZiZHAzNDlRVFpqZEljK0NqK21MeVhZY0RNeXdaR2QvTHhU?=
 =?utf-8?B?aHQyU2VQbDFsbzBzZ1lvNHErSWxmMWdKN1p0ditnVEVpL2R4MFptQmVLMXYr?=
 =?utf-8?B?WC81bXF3VWVXSXhTVTN5TUo0Y2NNRTl1ZEJBL0ovMVdSenk2MGoxU0JRUlJ5?=
 =?utf-8?B?MVJ2UzBDMElXRUp2UkVuYkwxckprSVpzMU83cE02Yjd4SDRzd3JBUVhsYU9u?=
 =?utf-8?B?cFNtZFBObTNJOFZQc0ZTQjVnT3RBUXdQODZaTlFIM2VEOTRvWXRwVU9FSHpN?=
 =?utf-8?B?V1drcEtWZXJrU0RWRVRNa3liMXJOYXAyRnlldU1kOS90bjIxc2wyZU9XT1hw?=
 =?utf-8?B?MWhsTEkwSTZIdkZ3RGxDcVlMU3pTa2Z6bzhDYlorVWlOQ3ZiMmxob0N5aWxj?=
 =?utf-8?B?NzdnazJCelR5dTM1cFQremFZaFBLdVpwck9jTVE2RS9BaVJ6WW9Db25rRzFh?=
 =?utf-8?B?U2E0VXRlbE41VndCNmhld05ENDdYMjZwUFNKUmROK2tpeG5QKzMxcGVLQmlk?=
 =?utf-8?B?TklWWmt5Ny9hV3NzSE93bE1mL2MvdWE0K3pkWnZ6UG5KL0VFby82UUx4bzVa?=
 =?utf-8?B?MFdseHpxdW5qUEIzT3pyQVZ1QXZneDFGUitoblBNMTdPMFFNaDdhS3lFSGNh?=
 =?utf-8?B?MFFZektuNWtodjMvaDlacU1tcGo3Vm9NVkZ2bkhXSnFyMVRERmhpbWpubkVV?=
 =?utf-8?B?cHIyZlZ4UWFBWUNoRHN4QzdGYzk1L2VDVkxjd2hQL09ua3E2cHBGT2xTR1Nt?=
 =?utf-8?B?dEI3d1pWTnU5Yzk2RjdvUXFkQWRTWmp2RXZITFNvNmcyZDlkZk01UCs4aXpY?=
 =?utf-8?B?eXI4L1F5NGs3czV2Q1g5clNJZXFES0hYdEVmNmNYeUhnTW5CT2dLZ012ZkRV?=
 =?utf-8?B?ZVpuZTNjOVhUWjBBcmMxaWlCMEo1dzZwcGlHaTA4RG83eEZjdE9DNHQwaGhN?=
 =?utf-8?B?L0tnclN4SFZHd3RRRkZKR2V1T0h1dDdOTzhQRjQrZmRSL0hmclhndjlmek55?=
 =?utf-8?B?VjBaYlRuOEd3PT0=?=
X-Microsoft-Antispam-Message-Info: +rDhpuRWw+ZLK09dpJ8M7CqM1M7hHynnn1SfgDGrZil8/bchl0acHgmo9vfP+u2G94BIzL+jq608vfZB53DWOt0H2rpRQT9i2kjKOWuHk0mePELvWX4TooKt0DrLyecSJToArz0GYY+rppgvtKnYq3jrMtNDj7MSYKkxy25iDPErSyMFQK3jn6zaDl9IqRbK
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;6:wRr3FuuAs51WS3K7tJJc2TkIuV6Gk/Hqd3YQ5dVYt6n3YpoeAY1QEK5mb9xcUlBd0zz/PFtaEqY7mlDdbjUxsEpmDnW+oNAyaj9meCVsmIkcvZtaSk4p8FJ+fa51Lyrz6aY1r0VyAwsH4lpV5FiR8pqztn9cNV9Zzx/5xYV/oC9tUDMr7Npwf3IQQ9tEmYJS0IzTTe5520pKw7EIu2z+AOgaABS9I6hZLTw4Xgqzey1/nOaZda3/sHbRaiMevKMvD5Z7R+fO/TVrFvdPvycxfZyKZwW1D9le9f71xt2X9Ydjk9EICKu6XoGayLxB6jHx1vKw+FCTZaHgu5Zi0z6dSgYwTBP1Nsia+KHeIL/bhbkXfk5rHkv3Ln5YhLeFLZL5ufEs1hQ+vzRklx4r26b1nyUTWhaE+7Pwap2LjSjc60r8DwuvyjnvB/cJz1igJv5GZYNGzy8FaUrLaYvHldBwPw==;5:xye/C9jv9J5i13lMN1IH0NWg4SObboewIE9C/2d62AmxdfCyr2OGh1A7W9SIcn8Cx9GzWmp+YPtlhF0MRn9yD+QRoh/SwQjnE0CAr1wc//oWGtm82vQl9sa33NoEa1HW0dpA98X3uERQHo1o5MXqChyzx2woRDYMmwnu5ttizVo=;24:3RhEoQ9QZkUTjTKqqv/MqfF81Othh+tFlcGnNLjvQ45+0bfYPV8DZpWhAgIitqE2lZiCZGDc6Zxc/jnNxb29N1ZQVJyaylOpotqH8bIZB5c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;7:D24ZrvET3DwOLWmbHtuPHcTSx0UmX7moZjoe0PLOPD6nMO8cd+rXPH6dpELT3J3jpdxmHxLl+C7AzL+v7iphXUHyfTX4ttOXodt1GKu1YL9sJ6U9Aasomi8mRmQsyldLj6BX79uipiHKXRQ6uCbWUBZqbMLBtdYROTq3a4dGzafQNrZBmpfFju51a1SZrxeB6OyIYa0QCAedZx9j783crE9A31JNOwe2okO+2mkKWMSiTTcmWensY3LJkpP3EG/0;20:NT8AtApJB4EdH0hQtF8R19jmQ1gBIp7pzengTfeDkJZROI6jV8XdwjZtrTuqlLfh0oJnjq6/QxaRGEV9SbvLtuK3jzrM22bCGP/YSAQv1wZC/7adwBfNy4+vkG3dTZENRQ2oMiHS8GP6iGhY2j/eKosm//jx9r3oG6tJin8wA4ZIr2PHD+zdnAz9INfpECfXxWE6+8WtLXmCr36IcXaWmEVS0gLeafm1dISCCP4A6nZbsZRMYhSMG7TViFdtQGMX
X-MS-Office365-Filtering-Correlation-Id: 945a411f-914f-4d4a-b0e3-08d5c7b5a20c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 11:48:44.7510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945a411f-914f-4d4a-b0e3-08d5c7b5a20c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1728
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.05.2018 um 07:07 schrieb Souptick Joarder:
> On Thu, May 24, 2018 at 12:25 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Previously vm_insert_{mixed,pfn} returns err which driver
>> mapped into VM_FAULT_* type. The new function
>> vmf_insert_{mixed,pfn} will replace this inefficiency by
>> returning VM_FAULT_* type.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 45 ++++++++++++++++++++---------------------
>>   1 file changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> index 8eba95b..2d13f03 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> @@ -43,10 +43,11 @@
>>
>>   #define TTM_BO_VM_NUM_PREFAULT 16
>>
>> -static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>> +static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>>                                  struct vm_fault *vmf)
>>   {
>> -       int ret = 0;
>> +       int err = 0;
>> +       vm_fault_t ret = 0;

Please keep reverse xmas tree order for variable declarations.

Except for that it looks good to me,
Christian.

>>
>>          if (likely(!bo->moving))
>>                  goto out_unlock;
>> @@ -77,9 +78,9 @@ static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>>          /*
>>           * Ordinary wait.
>>           */
>> -       ret = dma_fence_wait(bo->moving, true);
>> -       if (unlikely(ret != 0)) {
>> -               ret = (ret != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
>> +       err = dma_fence_wait(bo->moving, true);
>> +       if (unlikely(err != 0)) {
>> +               ret = (err != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
>>                          VM_FAULT_NOPAGE;
>>                  goto out_unlock;
>>          }
>> @@ -104,7 +105,7 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
>>                  + page_offset;
>>   }
>>
>> -static int ttm_bo_vm_fault(struct vm_fault *vmf)
>> +static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>>   {
>>          struct vm_area_struct *vma = vmf->vma;
>>          struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
>> @@ -115,8 +116,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>          unsigned long pfn;
>>          struct ttm_tt *ttm = NULL;
>>          struct page *page;
>> -       int ret;
>> +       int err;
>>          int i;
>> +       vm_fault_t ret = VM_FAULT_NOPAGE;
>>          unsigned long address = vmf->address;
>>          struct ttm_mem_type_manager *man =
>>                  &bdev->man[bo->mem.mem_type];
>> @@ -128,9 +130,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>           * for reserve, and if it fails, retry the fault after waiting
>>           * for the buffer to become unreserved.
>>           */
>> -       ret = ttm_bo_reserve(bo, true, true, NULL);
>> -       if (unlikely(ret != 0)) {
>> -               if (ret != -EBUSY)
>> +       err = ttm_bo_reserve(bo, true, true, NULL);
>> +       if (unlikely(err != 0)) {
>> +               if (err != -EBUSY)
>>                          return VM_FAULT_NOPAGE;
>>
>>                  if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
>> @@ -162,8 +164,8 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>          }
>>
>>          if (bdev->driver->fault_reserve_notify) {
>> -               ret = bdev->driver->fault_reserve_notify(bo);
>> -               switch (ret) {
>> +               err = bdev->driver->fault_reserve_notify(bo);
>> +               switch (err) {
>>                  case 0:
>>                          break;
>>                  case -EBUSY:
>> @@ -191,13 +193,13 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>                  goto out_unlock;
>>          }
>>
>> -       ret = ttm_mem_io_lock(man, true);
>> -       if (unlikely(ret != 0)) {
>> +       err = ttm_mem_io_lock(man, true);
>> +       if (unlikely(err != 0)) {
>>                  ret = VM_FAULT_NOPAGE;
>>                  goto out_unlock;
>>          }
>> -       ret = ttm_mem_io_reserve_vm(bo);
>> -       if (unlikely(ret != 0)) {
>> +       err = ttm_mem_io_reserve_vm(bo);
>> +       if (unlikely(err != 0)) {
>>                  ret = VM_FAULT_SIGBUS;
>>                  goto out_io_unlock;
>>          }
>> @@ -265,23 +267,20 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>                  }
>>
>>                  if (vma->vm_flags & VM_MIXEDMAP)
>> -                       ret = vm_insert_mixed(&cvma, address,
>> +                       ret = vmf_insert_mixed(&cvma, address,
>>                                          __pfn_to_pfn_t(pfn, PFN_DEV));
>>                  else
>> -                       ret = vm_insert_pfn(&cvma, address, pfn);
>> +                       ret = vmf_insert_pfn(&cvma, address, pfn);
>>
>>                  /*
>>                   * Somebody beat us to this PTE or prefaulting to
>>                   * an already populated PTE, or prefaulting error.
>>                   */
>>
>> -               if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
>> +               if (unlikely((ret == VM_FAULT_NOPAGE && i > 0)))
>>                          break;
>> -               else if (unlikely(ret != 0)) {
>> -                       ret =
>> -                           (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
>> +               else if (unlikely(ret & VM_FAULT_ERROR))
>>                          goto out_io_unlock;
>> -               }
>>
>>                  address += PAGE_SIZE;
>>                  if (unlikely(++page_offset >= page_last))
>> --
>> 1.9.1
>>
> Any comment for this patch ?
