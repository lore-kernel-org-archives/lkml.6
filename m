Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeDXPv7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:51:59 -0400
Received: from mail-dm3nam03on0051.outbound.protection.outlook.com ([104.47.41.51]:21792
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751239AbeDXPvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:51:52 -0400
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
Message-ID: <6a4ba810-e00a-6446-f3c8-a3be56f24589@amd.com>
Date: Tue, 24 Apr 2018 11:51:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b::4]
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To DM5PR1201MB0124.namprd12.prod.outlook.com
 (2603:10b6:4:55::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR1201MB0124;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0124;3:XkhxdpxwnytEzyXXgTf7un5CPXYwMonmiwn4etC8qs2JsGPTb8MHlFfo73cOl9+OZkqLt7Dynep24ffXGIx5q9jLN0t3GYBMuxdAka+oG2i/hPvEJxWduZkJvL7/fmOGNHR8yNy8yGyhBbBCO4+xqm+eCFr9bTCNJjkjnV+s3ikeDJz9GgW5mbu8d/r+5HwdHbTnkFR5SRooDFJCeoglyuoitKHVMrfWpxP+any2QGpLPR4SYqaTnZSryAghHLEZ;25:wIm0akRoPgPCgLeXwNq2jwIGeOI73PbGieys6yZIbTiMBvcKHhCGVF0VRFL2DcE/uYOGjRqWXX9J66j2E7dv4mSCuYe3ye8FH/eXBmBTnqATlfSSDjIgVHrPKn1O8uMB+gipdyuf4YcZSrhONhGyviC0EFRvRbV60XB9RBao6d3+RT4UdECkgZs4kc9OJghx7MF6uDLDYJQMpSOlTgVDJ9Diq0P0Povc6/bEZUYWrbm69ViOXwaclm20k1kpUNdcHYoHuTg6+BlILX0UpJX5fbzfVizgwP0u4oB3CsFB0JesYigoEGr4J0yeXF07YFTLh7/4mzBYK90uVGVgVXZ/Rg==;31:CllH4U8OJJTDpZum6fycxvADgLqbVXkPFFpkO1Dw7VEkRCBMIU5Sx2xXCAGM3LT16/ZQCuVF8+L+qgRn9honjpr1cmQ2/n6CRYgJ4sPXKRnk7pnJ/elDVwnCZPLW8mtShMvBmTUYoHnexLdr+WcQgAv+yxJaFIIqILyxqlMCFgFchgOWxrMwsuKsl48VbDBXkbhtFsDqaOytN5yN0q+9bQRcZhKQ2Idzb0P8gP1J5W8=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0124:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0124;20:FyCRXIItk4bELkJh5oth3o875GvdMe78XR8pYYp41zWqBDXt0B6AUIIlCnk9OXcz9LCBxsQAqgNnLYBZqC3Ck6JJzAvTRpqhDhow8ox/A3u2PZWM3CkXpEXNvTpEtPRcdBYL3XrJBCQ/dDRNBDKy26HHzJpyw3acBINe8oyt3BFM8zia27L2lqmELwyLjjVvI5f1swNGJSo10tKg844rEs1VpVbG2gYZeKATD8m9EgS4b/TJ6O5owpS7eQclSza4YZ/0bkbGso0k9G/tQily2Z69RB95rXy44JFXe261Lw1tnyt5i5OX7iCc+Z9OK9P0xS0SURVuCYTGsl/lLLefQ+FeDpqwBpa3VIu7p/81lKaB+wTIjReyj/332pfDpNpWlxS59cnIAqBVavpw3YYlxBnwfOa0/hZ7Og/EXkrr8C2KGy/KPPKRYSiX9u/54VwT/2oCKOirclSATcTg1e/+/jy3oQUFJONySiVDCxfYZFIVvuohc367zIcHBYeK9fN8;4:U8CxzLiMKkQ70PtOFCEewUXohDC5Zck1DfsvcRv79e8OODQ/cgFW1QN1AbPpz7hDtjMOBid7zcWPpBikhvMPlpCXVTurjAkpkp6GuujH8Q55lyJuOKQxjtmQXZp5OLv9IyY2s1oC95RvVmaqox7QTfdnJ+PZvKUhOD3gkzGhdKiEKD5OVNt07XOvoLWTTCioYYw0XjuvqhoiYKfsd7mphfnwBjfVXqyatiU5NcCp+q2p8e7yNTVyF83V0zkLl8Ud4ZthdfiJoZbruFIdegFGbqSKbM1z2VRiih1ERn4jfxV9h27C1EaAKhg7/akyUAZk
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01245BE7F6AF1E4E4C493288EA880@DM5PR1201MB0124.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR1201MB0124;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB0124;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(39380400002)(376002)(189003)(199004)(377424004)(6116002)(8936002)(4326008)(1706002)(97736004)(68736007)(2870700001)(2906002)(50466002)(53936002)(316002)(65806001)(36756003)(6246003)(8676002)(47776003)(64126003)(81166006)(305945005)(81156014)(65956001)(7736002)(106356001)(76176011)(2486003)(23676004)(65826007)(67846002)(52396003)(52116002)(52146003)(53546011)(105586002)(58126008)(86362001)(5660300001)(2616005)(25786009)(31696002)(59450400001)(386003)(486006)(72206003)(11346002)(6666003)(229853002)(478600001)(476003)(46003)(31686004)(16526019)(6486002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0124;H:[IPv6:2607:fea8:3ce0:41b::4];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjAxMjQ7MjM6b3o5ZGhTK2tIOFBZSmxpMUUyaEs5ck1O?=
 =?utf-8?B?elo5bWZVV3ZSZUFhMTZGd1ZKcTRBaThIQ2kyc1oweU44Z2xRaFFhenRuMjh2?=
 =?utf-8?B?SGFWYUo2RFZSZmpGQzdzdHJYRWUyYXZyTTdnNVRhSVQxNW5sNktVTTFDRHAw?=
 =?utf-8?B?WkdVcEhHamlmVTd2bURUUjRWQUtrSDc3UnA1RVNLdzhIVWswMlc0SHNFTnhM?=
 =?utf-8?B?K202SnVheGkvTVoyNGdyVkI5NjNLSk5FTjdSS3dyN0hwNXRtMUNuWUI1djdJ?=
 =?utf-8?B?RzJGYWF5MzJrd2tPZVJrcDhjZURyS3c3SjEyaXNPUUM2Ukt2R3B3OS9SYmx2?=
 =?utf-8?B?azJOYlRiWmJlWTU5YjFNeFgwWmFEc3dDeCs4YXFwb0wwS2NLMFo0YllIMm9w?=
 =?utf-8?B?S29FUUwzL3JsVko4eCtyNUdWLzVqRzlOeS9rTktSMjdYNWk2eC9rZlA1THIz?=
 =?utf-8?B?RjhlT0w3UVJsc1RFRU1UVnlNUGRrNkdxUDRaY3RCL1R0Rkx6WkUvRDNhTjhX?=
 =?utf-8?B?eEN2SisvSVdaSkxxYzNwVXZ2ODM0YnU0ejMxYzljVjJHRzF6MG9na1RVWnFt?=
 =?utf-8?B?cUNjeFhuSnduM3A1TElIU25QaSt4djRtRjZzNThMY1FZSUlsS2ZVV3hNQVk1?=
 =?utf-8?B?dk10bXc2YXY2Mml5YXdsQ0EwQk9SampDUHQ0b3ZoT3hvRlIwY3BjcTJjNzln?=
 =?utf-8?B?QjcwNVdXRHQwY2pKREhnQTJzb2FvSVYzekpoK2dCZUtPSHloMmV3c09Cc2J0?=
 =?utf-8?B?L09SNXVSZmJwZWhFRGlGdUtTUElEK3Z1RHYvczRyVlBJeS9GeHRXcmpVdk1m?=
 =?utf-8?B?bVdENHNSNkM0WWZKb3o5bWdsdDVNZk1rQUhtTGgxa3RHc0NHdXh1MldNSFZL?=
 =?utf-8?B?RG9FeWpWVVdnbXZCbzM4Z3Y4cU50M0xCV2lhUzNtcjJyUzBwa3R6bnZ6aytG?=
 =?utf-8?B?VWd0cld4ekVhMEkvWWlscHlWMitWeXlCdDJ6cHROZW9MZU4vdStkbVV1WjJQ?=
 =?utf-8?B?T3NmNUVWM3UvcnJsWFVCMFRWQXUwYUtSV3UxV2ZpbVJaYU0vd1FLaXJ5VWRF?=
 =?utf-8?B?R1RzR0tXRUd0R2hsTjQyWk1tb2svaWJOSnY4ZzN2OGVVcmxzNWFWT1lacXZj?=
 =?utf-8?B?OWsrQXR6L1NwQ0NITlFlR1lYQlBScTNQM29qamd1THBZcmpRWkU4cE5yRFBZ?=
 =?utf-8?B?d2dOTkRoQzBMa0wvTG5FM3hPa0VxUUpnWUt1eXNaUlErUkpYcndkVkFBdTkw?=
 =?utf-8?B?a3pRTi95NXFZbk5sZXBVTG5XZm8vRXo3ZTdpWXAxUW1wMUd0ZUZjL3FzNm9L?=
 =?utf-8?B?bXRYR1VWNU5sRmRaNUdvRWpXVDNGc1gwUjNFaUsyMmoxSG53WnRkUmVTV25v?=
 =?utf-8?B?YUEvdUsyTEVzKyttaFhjUnlOeEtqcTJkVkVhbXJpS2xIM0hkTWRUQm1pbVZ4?=
 =?utf-8?B?MC9DMmQ1bjBTWlNKK1BVUkc0MlFjWEJCejFtcms5djdzVEFDUUF1WGZwbi9J?=
 =?utf-8?B?TEw4dUVhWTl0WmpKc3ZZZHZoQUdLaEczckJRYkxQVmxhajV6Q1FZekNCUnhR?=
 =?utf-8?B?ZUE2dW5SVXk1WTlqcnE3b1d5aEcxbTE1em5ob2RKY0pqVlBmU3NMUC84NjdZ?=
 =?utf-8?B?NTliZDJlYW16ZXVOZk1qRDFoT04yYkcycGpGVjE4VnloaTErdnk4dkFJbk5x?=
 =?utf-8?B?R1EvenVucmwwcHFvOStvUk9admdkcno0bnpXNy9IK2RYME9MWG9kczN5QXdn?=
 =?utf-8?B?dCthOXBuTnFkbmhhTmZGakVOOUFJUm95Vm9OcloySzcrVWRmaE9abFVpVVdh?=
 =?utf-8?B?VkFKSWFjRnpzNEVibE0ra1VhdXBXY1l5WTlzZFQ0dTlyV05Tb2d5NVozRkc3?=
 =?utf-8?Q?Y57UBEokwW3cpxjwdsdAgREl826XjlAi10?=
X-Microsoft-Antispam-Message-Info: O1wQl4c2W48Ot79w8waMkTj5PQ1f52Uhr20/p4sHT5wfGwy4TMoOHu6WB7DfU39pGqR05rLeIb6WG0duDOes7JwLOv93hCsOq9ypxHHfKMb4QuUiSyiCTqti7GR0AgV1CpzPf59gVAHoQDVlJEgxoVuh3uMp5lVUSCEhcHoUvoQIKbG8Agxv1J4vWBOE8g0d
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0124;6:gPlG9FQjYeWjf338h1xitesJQ5XHWYChsQnch0LyyXPf7vPRIe5KErajF/G4R13H8Rk8wO9lo3pX0Bzjitk01nt4ICQ3tWrbn1/PXA2M0ZG6h7nQ8vh+vL5TtuqV2d3gQqe8WFjRT+mzRPijhN6l+LZ3+HrdYm0M7s/5UMOy/+HPKy5W4pU1j1JgMcF7s1J13f0YyKFTYYUsELcYV5YfSZQoHKZfijq9Hhh03v1GkFZrA0OIVd/6cQrzjs5OjJcV+4LFx4ZiGHOAAbdFhXJK7Boi1gvPJbm/uYEwoTzw9ZPXNtyg2jdHMK/bySFNUxPF09G4dspBxlfLfpWNIvdmGdmCIvwF7L8H/fPirBt3Mpzb8Y8ZL7DFm93F41daZPnujPweVkC5Yp+SvNWqRdP45Xeq10JGhGCr/R2gYvVOLgamIGdCbR9f9DPYllZPpfKiFxL/wmP5n1K/HVe2cT+KjQ==;5:rRREsMJB9o3+ZQUUub7Fp1kS5JLc5PJpwuCdMddiRTfy9WqlZEDv83q1113/tv6+8RyKTtOp1oogf6TVWuGwtfQZSqkyKMgtA55pWI/zekU0pzRr42HZwEW+iyAxmltLPKrxlJWx0W4ZtDFWjgCsZ0YQLGXbvwGxBlqe5GUXOjI=;24:Bx01qHsBm70VrJHLPDJl4kefFTGossuBl9vblHcYscYptxARuplQBlhemzIRX2l4L/66gH69P3xVMSvaerCm3hz86IN9PZIXk/2U5sIYcTs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0124;7:KS50NWB+dfBKCuOo6ENOScKbVzXBjyedZfI9L8S3a8V8JpHv5pt4V6LfdEnXxjj/Dz7kBBg1nMoLlQSnec3ZpudrBGQ+Z7DRbvHDp54WbOQt03gOYnSrGiYm7FIUZq+kn3UzhFJ4quekxblQkVBDxl98pl0AvsCT5ucRlWH1IB5abf7xJlboAkJ/GdR0nP8gzNONicOu+WnZE+ILKc0IhPJHSDIn8+Czy4iBOBC5smUmYzPkfRJsLA3XOEvqUvUY;20:9V5RjMfaUpgF8Kx4Y5rMje4jT+FT6GbS0LZMwcRPPn+TWOHQwEHaKiU22wbABUtNq7v8NpsyaFBALov1LqjS5VVWM2VcOw3WlS4GksMZhezgHyzZ6Y71hnM44AvIh3mO4NJY+U6h2gpAVUQre18RTQ317OK1P6d5rnsVVZweAKqgkMbfJUh68gg+jUILt9FZviN5wgE7UoJJIsKyw/VeR1/AobaHQYqrrpm8Bgy1awPdTzfPr/n7nrzdHTiiZdZ7
X-MS-Office365-Filtering-Correlation-Id: e3de17dd-b13f-4a46-f798-08d5a9fb4b4c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 15:51:50.2701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3de17dd-b13f-4a46-f798-08d5a9fb4b4c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0124
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
