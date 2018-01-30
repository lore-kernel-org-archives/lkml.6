Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeA3Mmv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:42:51 -0500
Received: from mail-sn1nam02on0045.outbound.protection.outlook.com ([104.47.36.45]:24064
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751831AbeA3Mmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:42:49 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 4/4] drm/amdgpu: Use drm_oom_badness for amdgpu.
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Christian.Koenig@amd.com
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <1516294072-17841-5-git-send-email-andrey.grodzovsky@amd.com>
 <20180130092413.GD25930@phenom.ffwll.local>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <1670268a-863f-2a95-fd1d-f59e5ebdfcb3@amd.com>
Date: Tue, 30 Jan 2018 07:42:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180130092413.GD25930@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: BN4PR12CA0015.namprd12.prod.outlook.com (10.164.241.25) To
 BN6PR1201MB0115.namprd12.prod.outlook.com (10.174.114.140)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5d1fce3-8ca4-4cbd-ccf0-08d567def815
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR1201MB0115;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0115;3:+fBwKd5CYWsWbIchBP5/dj2LSw27sn/ZAR1ReLYZsw7uTB4j4OH68Nk0umL6+elN/AABUl+qeGMzuhjExyDVQ7wWhSW4DEEMxZ1JZt/5mB/EKJfi+q6YZiNPZpkK2sjqRcsm65mrKHbGf6jIBcDKZIvfKQuhxARUfiEl/X6Ao/xaNyjYt4Vm8E47l8RxFkQvn/4HeHF7pRh9AgtbHtGN4k6QmhjSk+c4KKPNwmhr58i/7NvmzoH1z4fyNaLRzdZL;25:07cug64Yz+NVw1Ocg5HowHA1bb0E03T9AaW2OP1LklM1gu5AJWHNhwPxuMr1en/HQpJYpaLRpBS/Ae4jmfcn/GYdZUMyl72jnxFg+XXr36xpQEkWCpRNSJwKZsfjcHr9dX7FKlGQ820idW6I6VMB3RS4ppn5hPtGk4BBfgD+t/7UMFp4SglpJm5uLTHlTzh2eaFnFFfxGcyGxmOz7Qcid1heCEghdxSRAN2LQdcQjUZ4cNrGpMTkdMGD3cJ7XsDGMLIwudBF5YDu98yNH7D83cUXHvll49grvFCnkrMY+nf1By6X8+hpCr9JGHgXj0FtNMwOX4FpA03LBag3vxhiBw==;31:VqY8ZG0lm7mOALQFycalb3iBRPx1RKXVUcyshWvibt5n5iu4KDGy7gj/PuhgjrXl72/1ZYX/04FBF18Bq53Wz7YhzCnBsyAn3HE6G0CMTpdqEZoI9Ay9jwV/mh+0zCOAA7pZo8NAGmyGEDNJujSKAnx35pTpl6Ufmdvn3TDnFTtLiodAYY8NVhH8PaQZIzeYmm5qVERsVhjqTn7W1gFxcv9uuSB8nJzs6uhpAT1JEWk=
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0115:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0115;20:LCXhxrgBERj8bJeNgFkgCAv9Q2blHCpDCc2lqYezxxRW1UkEM3y0Ne8tzqoGrSy04s9QOdceNs7NsTIsv4pWyj/NeI6sZ1LxSRMsyK1v91cIfLO3wwaF0crEyTrKqdub+Nih+KycnhyLZQcBINjl12RL7+Hpm6yrNEw+hYVSOIvvwCORZPBV8bmj8wLd1WQUIzbtGzyItw0q3pHM/gsNkH+BKd6gnAn26TjX1k+jo4LKmNnOIuo09wvpxp/lascHEbZDg1byLxnW97bG+eN+kYhSwtukA7JEA55Ofri3cphkMXT4a0roX0bUBaVoEvB4MCDZIeBcGKHvc9yqeVFpaQyHqpdiq6agjWA2/9IeFjdiwQU0v7XJeJ60duOURY/NaEUa4HmtQHHaiD4CRNGob4iqUP6s4+I3wRrR0PCJWgvrU84u0sHiVdukyt3EJGtKpRbXu45kKyjIT849lUiGJsCVod2jZDcnBr41mjlI150d8vqBgpbwwvZj6t2R5hQ9;4:0hVe6qOdAVeSDgmFsd5gHZn4Ic/aEiftFWyDPEShXUFVF5ImuESfFF5z5BoOUzb7NveKILnqIa643HxP0ibi2L4aaiRDCQVH136MYbUrCEHnp29jEGWGlCn/KWL3c0bQY41LItl9X/b+10/pBmJj0Re7/DDlXwhNya6DbzjLc5h8N2OwHNi9QalYNxjB+vt9X1UOIQ1vjk1zosNMB6iv69Nvsyy9bnEWov+BXTieu3eprb+yzdD54hStfjVcWCo8RR8Zjk+dyC5HNd8U2/NkPblBzpnYBN1rwUTfA4odY62PnyZEFZ7BW43QUt3mL5Ru
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0115FCCF7C2FDE5C3D38E786EAE40@BN6PR1201MB0115.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231101)(944501161)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR1201MB0115;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1201MB0115;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(396003)(346002)(366004)(376002)(189003)(199004)(58126008)(2950100002)(16576012)(5660300001)(316002)(65826007)(97736004)(6636002)(90366009)(53936002)(6486002)(31686004)(229853002)(72206003)(83506002)(6246003)(478600001)(305945005)(86362001)(230700001)(2906002)(25786009)(575784001)(7736002)(26005)(106356001)(386003)(64126003)(53546011)(50466002)(47776003)(81166006)(3846002)(6116002)(8936002)(65806001)(66066001)(105586002)(65956001)(81156014)(67846002)(36756003)(68736007)(16526019)(52146003)(76176011)(23676004)(8676002)(2486003)(31696002)(77096007)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1201MB0115;H:[172.27.224.115];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyMDFNQjAxMTU7MjM6NnZmRlc4Sm1FeTVJUlZSSmVFelVMb0lx?=
 =?utf-8?B?bXUwTU5FWGVGNTZncUJleTl1N2NHZ21hTVVibU8xLzZxWXhLVDJLM21SRVN3?=
 =?utf-8?B?VnlOaHZrYzR6VldJR04vMHR2cmthbUhaSG52RC9ycG4vOStBbGRVZkhHQzNv?=
 =?utf-8?B?TmJNK0I2eG45dXRQeno2ckhGTjd5OVoyS3FteWJSVk14TE5kaHlQN3QrRDVn?=
 =?utf-8?B?ZzNoVDE0UDR0N3FzdFFvTjdUS3RNMk1XVnUrYzZ3bVRvZ3BadXhoVERvbnRi?=
 =?utf-8?B?Q3ptMFl4aHBVK1B4ZmZFYVhPdkYwZmR5d3l1eVRRWUZzWVZZODBKY29LV3ll?=
 =?utf-8?B?cDB4b0ZUUXVWb0RKUndmRVloaXBtUjlJQ2hZT2JlR0RKVXdNbmNhWVdKUEk3?=
 =?utf-8?B?RURTRStNWHhQMmUvVitwVkxGZk80cXp1RUtFY1k4WTVCUWR6dVlFVm03cGE3?=
 =?utf-8?B?bjdMN3A3Nktxb2VuOEkycUJLemFtdEZBb3B6eFlpY3BPQzFsNzEyNUJjd3dl?=
 =?utf-8?B?a2FKRkdlSithcWs0ZEJiUWhKYzgxakc0NG85Y0dCcDhpdDlBUzByMlM1c25N?=
 =?utf-8?B?aUQzYW1nMGdiZkhmd3dHUmZDQUVBTFQxdzlkVStYdkw2VDhZTEhiZFJGWXA3?=
 =?utf-8?B?TWdFV3l6WGFidmxWd3RPTUNVUlRycXhQU2NiVHh0cXFjUHdReDBiNVh5Y0p3?=
 =?utf-8?B?dW9vbHJaSHlLNzg5Rk9rUGUxbTVDZ29KMHVGejBsNUIyM21qQ2FINDNCU0Vr?=
 =?utf-8?B?cXRCbXY0NVFjSXF2MXZXNEtEMGZhRUhuTnRaNUhicnd5U1VrcUNTMjQvRDV3?=
 =?utf-8?B?RFN5c3QvL1N1ekJnK0Fsb1NnY2ExYWhPMktaajdNZ0UyNEVVSTFIb29XV0hK?=
 =?utf-8?B?WTVwUUFjUXJSMXpVUGtYTUxCTTJ6QlVEMlkxTkhqY3g3MllPVXN2S3JST0hu?=
 =?utf-8?B?Qm9sazg4ZHIvVzg4RVBOeFlQOWJOZkRldkRjVW1oL0RJRWVlUzZZViszVUp5?=
 =?utf-8?B?SjBjRkRIU0RieUNUYVlWS0svM25CWEt3Wkh3N1o2TWlMenFCOXVTbjduSm12?=
 =?utf-8?B?Zy9SaDhRd0ZZbFhialVWVXdhbTByMHF2cmN1cUY0MVl5WjRGdGg2TnFLTTRa?=
 =?utf-8?B?ejk2dytZOEh4eFVHc01lOXdTeXlxanVUQmpXWW5IdCtVU3A4aWV1NVFVTUJr?=
 =?utf-8?B?OE53SzVFSWJVd0pmM3QySDZVSWJyc2xObWoyVjZ5ZWY4UHo2YXRScjVTWnZR?=
 =?utf-8?B?N2laeS9ZbHFCVWNhUnBuY0R4d3hXbU1NdUN2cnB2a0ZNZGVYVWtOU1NFMmow?=
 =?utf-8?B?b1M2S2dCakQ3MjVkcWw4bUZ1Wk1SeklpNkZmNkUyV2tqUFVtYmxNcGh0SW1T?=
 =?utf-8?B?aW5BcTBLTG5YS1h3L2ZkOUxvcjZBWFNhQjM1OEpxWERYOFd3QkNUS2toVHhR?=
 =?utf-8?B?UWdremRZVEhpTXR6eTJFOGJaRzAxMXFZWkpNRE13dzBxU2tzVlNQZWlpeUtT?=
 =?utf-8?B?azRSUzR3UDZyQ2lPUUpKVjdOaUgxS0hQMDBLOExGM3NlaXZwTHpBMGp1VzA3?=
 =?utf-8?B?NEpGK292aENTek9CTHI5WFN5clZ5Y01Qc1lCSGxpMjVoZHZUbS9LQlkrYmw0?=
 =?utf-8?B?UjBDaDBEK2MrbzFlKzBVTEZhNEtkbGUwOVhwVndsSUpjSTJYVnlSZDB2cUZU?=
 =?utf-8?B?ZlBCSkFDd3JDLzBRUldqYVM3V05waG5WWklnSkNEZGZWNUlzeVFtUXdYTS9p?=
 =?utf-8?B?T2xPOG5pdFhIOWpnMTZRN1EzejVQWC93MGkwWnIrZ2hEVnRISGdQcXFsOFNn?=
 =?utf-8?B?WnFwcCtYL1N2Wm9Qd0dPeDJNdEhuSjMxYW50Y01hRW9ha0QyblV3dnIvQ2Q4?=
 =?utf-8?Q?A7QnD+dyLHbYTe+Eof1QtJ0ZGyvPPKGY3K?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0115;6:WD+A30P30+8E76eJctbpbG4sz1jxvehm9FEhqv15UlnsBw3YIufwte4qJXK5BtN0XlxhtKN9waDlitl6S9DLzzuYr2BXO67eXgTCS8+fVy4q04E/4XUjsTtNmV/N0qzAH7yM2VJjN7bB+9wwYTWvVKtaSYE3zTb8FhOwquWe+2tIwJtklg1cyk+NEynEXG1g5gOj4jyIeJuZfIARFfQn1xBLvfy4n6Vnb1DY7CLVIrHSc4261AgKEc4L+jjYvk+guqYRCzhj1NWyEY390v3CJRi2G+d/2AqPcG7GQY0MsF/FS1jvbxPjU0xQ7fbCPqzeC3nPZd3D20DYQdXhfrb6p5rJSPY9tLcJf7SHStlmjC8=;5:hhfMpGL4ACGcRqVvfBnCnUScGSoZaBp3ab0mhgyOUkbViYFboG3ABLBJyIN/cgmpxBC5IV712SVy8Wd9LLJbP4sBl306URqKCfIrdlV0JAUtCp1HY5PULfKsTAXyW7BiFwvEwExZqBeqRBWwYJ95BXF+OBYSEoaY1zVy+NRCHww=;24:vub7qhRaKx3d/RsHIWv4aTSd3Um4Yewn076NevrsHFd+C1Ar7gdNM824aueyZh7Y7UNKtVoANRdcDQxpTYX+mWy3fbaSaIwkl+/iBhZkAsk=;7:iAev0eNACOdWgu7fp3bg3FUQMquppAmdJzDYvTCb1pYnsACCFHQAjyP88JhE/8f+SFEw9Mgs/H61CZy/6jpfJS2bPwWvx3sIRbsLPw/zah4E/W8Xy0G2TVmPoqL2RZs2jYEMHoleRKUeTiKmPgx66o3rwS1bkVPDh3IUZyy4HAGSmn3Z23RLsORdgdMTKfZ/TRUe2+h+mLSzIHc3JeL3sg74TwFkIklGzMyq5sgAe1h+Lp+iWgSRp5g2lVOz2o0e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0115;20:2DeXj8CuNuSjTpjNb57Nk6d1DpDnRGXXrgH8iyqEs8DCPRm1RaEwEtSgxhv7wERCog9eB8HCA/GVOznFLBj16IPKXcfJ6pZlGqRS1GJnSv0r5olI6sLZdVWtflq/2MaFtbkggg9k6dqVK0KlDbp6m1fOXImj2O42bR2sZKqdepq8oqE5tTS8KYyLHZltUNhVdf/8ry/3HqzVhcIQ3pQKINJVB09REN6j6OWTmKJU/UUlujqWlJVEk3qb2laoQ4TE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 12:42:48.1839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d1fce3-8ca4-4cbd-ccf0-08d567def815
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That definitely what I planned, just didn't want to clutter the RFC with 
multiple repeated changes.

Thanks,

Andrey



On 01/30/2018 04:24 AM, Daniel Vetter wrote:
> On Thu, Jan 18, 2018 at 11:47:52AM -0500, Andrey Grodzovsky wrote:
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 46a0c93..6a733cdc8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -828,6 +828,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>>   #ifdef CONFIG_COMPAT
>>   	.compat_ioctl = amdgpu_kms_compat_ioctl,
>>   #endif
>> +	.oom_file_badness = drm_oom_badness,
> Would be neat if we could roll this out for all gem drivers (once it's no
> longer an RFC ofc).
> -Daniel
