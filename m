Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeA3JA2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:00:28 -0500
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:53600
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751273AbeA3JA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:00:26 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
To: Michal Hocko <mhocko@kernel.org>, "He, Roger" <Hongbo.He@amd.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
 <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <20180130075553.GM21609@dhcp22.suse.cz>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9060281e-62dd-8775-2903-339ff836b436@amd.com>
Date: Tue, 30 Jan 2018 10:00:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180130075553.GM21609@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: HE1P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::16)
 To CY4PR12MB1303.namprd12.prod.outlook.com (2603:10b6:903:40::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cda28168-472f-488b-858b-08d567bfe5e5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1303;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1303;3:pBWWXdZT3eSkr/mm5NsxLud9ZTR0XGSIOuM24T5MnxqkF/tI9QfLSJukL1NvzjBUmXU363Ih/WtcSYyrZ8bilY6WRgSIRhsmqS3QTd+6o+2SUAg1bohc1H6EpK9yqDY6nZ2hRAQLcwqj36xfbqk2Tihh9B0CZjLqZ/K7cE3dSnPshyOTzt0xX7Gae1/6FIki02IrO5DHpMoBw9NR1KPaVZ6M7eHtmNWZ5/VAOnri5g4INd9MpT3UGly2wnmBW/En;25:/cLW/6ZIDM9DDev3VN8OODX2Law0RdUiVcPRvp/9XfDyae4OqsLScDuC7xKqOKAUV9XheHTv1MldD9H3rFplLOdDZR/esjKz/sG7yKK+lOMeYDbSztXsU9A8EfNygkfMMXnkJrhVpcGk2STi5h7HOoAMrrNtEri8aT8eaekD4RSnjbGNA8dW3P5AQqk4bXB6RyRToX5+6c/7oHZyFxmJ0n6txcxb4JZyoEKC/E4NXaX50Vjme/0DiorNk7gJnu+YZyjm8H5ABAbkDaLQUYub0xuj8wGS52cOprAiTDrPkYFmIgr18NFxesSZNYmFUAFi8DsxjLwb8h6/m1lshDAXzw==;31:/tVCnBjOX2uEqN+V6naOVHdhMJbEjFjNg1ux2XeL20ZaUpd9e6yUhZHRQDKAr7pqGaw7pxV0WIQAu96ooDQkBzX7nYq4CGbe5tFJ2kF0M3vlxNSrw+6M/uK31EDxjIiLMPRn+iGnKl6yP/sQm6QnonxRidAVqNzEMrQoVo3oO3Net5qpwXKF0GlnEEanBHYwAqZkWCgj3Z5TgcChPwN1bQwDHF5QZlGincslxZ+ivjA=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1303:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1303;20:7XtmS750pqCG5ojj7Skr95qahLD5DV98xI5UrduxwS+F1WDqTYtPcKD3hBbC0GMCWf9YptL4pHWZ2Gn6sqUNz2aVQCCvUFim8CWQKxWZtowl5XwzPF1I5+iN0pGtLePT16pD7nyrLOBHqREHLzLX24cOXLShCxxiFZQmGLONnZawjuL2QUgexmyXg0PluYGlFhmEpq1teuF1jEbr9zbUwT9LR+z9nEo2YnIWLCTycoLLG5JQahwHW2/X5szfw2Do7ZHfgR8PiJ6PC5JsPWO3kOU037bJOjLbjgs1cqPc/pXyOv4MVLilzcm0MNyqAS8MxqR6P7h4tYllassUpU+aqUQ5jIwW2faqUKsCI3DWUDRkI8nyx5mNGP2674nvyJw0EQexAn9Ck5pheCTjNq7ctBX1ap7m/pNDyK2aD3LVCI790ITxT5F9UdnlUe1CvMj1rqfi/kh3FyA94BeM6cr9H3hMdY6TspdfvTjOwxOlfBLY0AI3m+QuiPNe4T+5rYtv;4:KQ3tZUiL8K8mOyyWOWKdLGXD45ZjX7743rDE2PDOjnaHzi4QaS74+V8duyWtjGKCO0I8yIx382ey2B7U66ILh1Ps+NQ5hmLBRaHC9EZBif65L/kyQJ/ajFq/7G+665lnVna6ZH2+gw0XFNtNhLM5KotOx2v1GS7eNxyNxn8AoD1Dao5hnmHfJWrMS50YOMm0NVF9iNRN14suAp4YeN5zDSu+6bHT+AbsoT+dEkJRJbP6HEcFYfDiFNIeLgKBDQvMkU2XXZfqXIhvyx7o1uBJu8mdcFjatfRPs8ZGNvGU6vSAl1dqKJS5QZe0qvvK/E3Z
X-Microsoft-Antispam-PRVS: <CY4PR12MB1303CFED128BABD83BB8EFED83E40@CY4PR12MB1303.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(944501161)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1303;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1303;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(376002)(346002)(39860400002)(189003)(199004)(377424004)(86362001)(16526019)(31696002)(59450400001)(76176011)(1706002)(72206003)(5660300001)(478600001)(58126008)(97736004)(50466002)(316002)(6666003)(6636002)(6116002)(230700001)(54906003)(2950100002)(229853002)(386003)(110136005)(36756003)(52146003)(23676004)(6486002)(105586002)(52116002)(52396003)(65826007)(6246003)(106356001)(64126003)(25786009)(305945005)(2906002)(81166006)(4326008)(7736002)(31686004)(81156014)(65806001)(83506002)(65956001)(53936002)(8676002)(67846002)(186003)(47776003)(8936002)(2486003)(93886005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1303;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMzAzOzIzOmhBRGFRckJvRGpGaStaTjduVzM2UWduN2ZG?=
 =?utf-8?B?NjNGWlh2S2pwdklHMWRGYUNLYmltOVRTMjRmTDZFVEFOTzhkZnpZaVAvQWY0?=
 =?utf-8?B?a1lmSnl3Z2FjVEhiODB3Q0NybzRyblZrRUlnMWRqK1FDRXJBb0FiQTJmb2hH?=
 =?utf-8?B?cy9OTzBMMFRWTEVoT0RUMTNCMzZ3NHRXamRlbUJ2Si9JdnBYVkRRSEpwZVhj?=
 =?utf-8?B?VWxlSVVpcjNBTE5adHJ4T0wzUVJJWWNCRkxMRmxYTVNYWElnWElyb3JtUXd4?=
 =?utf-8?B?c05wSjVVZG1hV3VxMTNEN3NDc3Y4b2ZKSENGbHJ0T0RLbHBoOWJ6YzhzU3Mv?=
 =?utf-8?B?bUNlZXhRcmRBWHNQdlFNcktxVHg3TWFaRGpDdWtpU255WmVEcW4rOWZEOGhN?=
 =?utf-8?B?YWZBYzltSW54eGFKVWNOVk1kOCs5eENvNUFqRGkrNDhjV0FnS0J0RDJ6eW9k?=
 =?utf-8?B?MnE5cWEwcGUwVUVsT3VBUmtoNGRDYkZlWGVEVVVydG4xbHJZUGVUd01KZ1dB?=
 =?utf-8?B?YzBCcWJNcTZBOTZhd2VpcG5CZmFmNXYrMForazhhWGYyMG9FNjNERFFRNXNj?=
 =?utf-8?B?NG1Oc3V5c00yTm5DVXhZUUN2YmpCbkdoUTlraGVvNHlxQVhxUlIwY2kwZ3Iy?=
 =?utf-8?B?WVZERElNTmI3SmplcG1vVStCU3B3RHIxUE5SajRrUnFYSDQvVnhNYVhndDd4?=
 =?utf-8?B?OE5FRHZLemxIWE4rL292aVJoZnJNWWRZYjR5Y3Q5VzlPUS9nSFJwNlZ0Q0FU?=
 =?utf-8?B?ZGpmRFM4TlhuNmtkNFRFRHE4VW9jc2JJbjVRcVhrd3FiVGVLcVE4MG5iTEl6?=
 =?utf-8?B?cTVoVG1KZnB5WjZTekF5ejZmcmpSRzk5SSt5RmdXTEoyUnNaMDJKNTkxcmxP?=
 =?utf-8?B?bVIzSDdnTlRVSkU0WUR6QnEwdjBCWjFhV3hVdDh1VGlNVVVPVXlwc1FhZm5X?=
 =?utf-8?B?U0QzWlMvZ2NxSjArY1lWV0cwUVFwbXVtcVpkcGRCZXJOemljU0FQY1lyTExw?=
 =?utf-8?B?eUZBTndBckhhMzc5OU5NV09tTVpRamVnMXVHYnZwcUdOay9Yc2YyNEhYM2Fm?=
 =?utf-8?B?cHV0L28rdFYyU3Nic2ZCTTlybGhuQ01OVjQ1Z2N1UHJ3UEtTdzVXeko5SW1C?=
 =?utf-8?B?aHBkb3JnbkNCbnRQWkRnRmJrWC8wV0lyb3RJaXhhUXR5Uks4SkFTa01jYzdo?=
 =?utf-8?B?ZmFVNUFmemc0UE5jcmpMcHhBOSs4NHFUUElleXA3YWZ1SzVPRW9vd095RzND?=
 =?utf-8?B?Tk0rOXRGOUZSUjgycjIyNFZHWURxVkVQR1R4YWZJNzdmQ1YrZ2ZqVkt3Q0dl?=
 =?utf-8?B?N240UnJTUFlWdlBzdm5mcGNmQjE2WEkwMmtSWGRLL3FRWTBnQ1NrQTFmblJN?=
 =?utf-8?B?eVVYSFQ1TjNycUdXWDZiYjhXeHJ3TWRlZTMzZVgrYWgwWFdpUm10WGpxQzRP?=
 =?utf-8?B?ak9VeEMrZzlMTDJ3YWJwR3lGdTYwODFxTFVSUFlkQkkraGNsRy92dWw1Yjha?=
 =?utf-8?B?UzNkNXFUMEZkcW1tY3dPcys5d3hkblVHOHppOUdsN2ExcCtyOURkdWpZaVll?=
 =?utf-8?B?djlaVUczbk43d0V6K2xzcHhZYnB0aXlBRnI1RHEyeUF2Ris1ejQyMHd5ck9V?=
 =?utf-8?B?ckFNUks4UkcrRmF1S0JBLzR4RTFOdVVlVTVIOVlOMjFVU0tpb3Btd0piOUpr?=
 =?utf-8?B?RlF4cFhoMkpCbjh2NmJabjV5NkJvMUIwSnhCc2ZzVWU5eEdPMTJOZ21hWHlT?=
 =?utf-8?B?MmN1eVhPYjZ5MVlrcUtzbVNvOGV1M0l5YUdGZzRhREZxSzMvOXF5bEVuNkNZ?=
 =?utf-8?B?bWtVZ3VtUjBCR0VkRnVnbG5vL2FGeGd6TnBBRE1mMVJsay9aVGJXdFltZERy?=
 =?utf-8?B?dmxSRUlsZUpwSitCWWNLRlVtRmRmN0FHL0R2SWxEdkRoTUhOWWNVSXpwd0p0?=
 =?utf-8?B?ZVNZTUNYU2t3PT0=?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1303;6:+J2DImCquUPJ7UhnIy3yBSIw6Oj21imGd73MUKjCLF4mvi0PjT/iB/EtAuxttms6DCt0rQVjrC4ZXGdpGll1rjML6eWMisKV5l8Brm3JdtEtAjvnoMu/J32RZ3Xs6ef1GzkYR6OazQKQHUkZURJN+w2/ZG1IcVhvK+JY8TcLG2bldfKnX3as7rvUeYZz5sII/ipIiUgGl1ITmmA9/9ABtn+nmqHuEENLbQuVwN2m/QfL47vCN4d7IxdFfbatSzbjMVFRUKbMwwX2oYS9rtHUhAiltRsn+YcBl21bcSiAzfMQvQQFuXta0mQyPscByfAExLe35ZmI/g/o+Ke5qS1zEdcEpSMysIUZmjXd7m8Ku18=;5:MPbk80o2jA15fsc1luNzR10VVnpnMT6F7RzCpuMwut6VGEJHTJ0Kb09Xqv5gu+s0vRZn7Dpjj5wUEPvkCqH+/oROpvCeBKyX5FtqDILzTJXErEFXILWvt8J4rAM+4GZn7itjqoggi/JT9iSzcFEIQ8/gOp0HXEDyYVm9chgueh8=;24:7UA8ZGoXNmSsS6ZObKkzXxXnYEC9AfYOkA/9b9YQYB73sLjFZeNEadfmtIDQLiEHtrrfPFcv5aN/KoV0kErD+i1TrupMwnR2tLvXJ4p/hs0=;7:Rxqv2lMEmWQw62mrP+2cyj9jEgBggpD1RDfwi/ArhTSZXbPH2529YIZu+FqKGFi3qmmzd2DssbhwpZbXZNiakcLmAXeTNf3ABRJBXPA1Lw0/6HrZEmkNcoUT20E9enqvs6W+fBsiHes/DDf3OjtgslID414RFXQsq87xhXa0/udzi0KUDJPJfSl3YeXWX4Lm9zTe0Opu9njcup00mDc+fJMm0c7zar3JeIG//skRLDhqvnFgVpnR0wGn6POgfKhM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1303;20:p8GoMWEGahYy8sw6Ppsd76oDIMfyuDQnJDLDNiJadERh7udH6A6xKmuoQR3YoY24dic/1BIbIBKhnbEcQxntwqW43cUas+Qnlve86dgSOuLFP1BCqYcbHdtiZv0sJNqWKYWsPG0JS5ch5FUSfjX0w/6n6wnli9yjN7eXYPbOj1VgT1Wx6kSui/ruoei7vlGeQl09DywR5YMjTRZqL3G+BGkLTDB5jq19JuAWpj5q4RnOreI5GI++CYJDCnuC29CE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 09:00:22.0286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda28168-472f-488b-858b-08d567bfe5e5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1303
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.01.2018 um 08:55 schrieb Michal Hocko:
> On Tue 30-01-18 02:56:51, He, Roger wrote:
>> Hi Michal:
>>
>> We need a API to tell TTM module the system totally has how many swap
>> cache.  Then TTM module can use it to restrict how many the swap cache
>> it can use to prevent triggering OOM.  For Now we set the threshold of
>> swap size TTM used as 1/2 * total size and leave the rest for others
>> use.
> Why do you so much memory? Are you going to use TB of memory on large
> systems? What about memory hotplug when the memory is added/released?

For graphics and compute applications on GPUs it isn't unusual to use 
large amounts of system memory.

Our standard policy in TTM is to allow 50% of system memory to be pinned 
for use with GPUs (the hardware can't do page faults).

When that limit is exceeded (or the shrinker callbacks tell us to make 
room) we wait for any GPU work to finish and copy buffer content into a 
shmem file.

This copy into a shmem file can easily trigger the OOM killer if there 
isn't any swap space left and that is something we want to avoid.

So what we want to do is to apply this 50% rule to swap space as well 
and deny allocation of buffer objects when it is exceeded.

>> But get_nr_swap_pages is the only API we can accessed from other
>> module now.  It can't cover the case of the dynamic swap size
>> increment.  I mean: user can use "swapon" to enable new swap file or
>> swap disk dynamically or "swapoff" to disable swap space.
> Exactly. Your scaling configuration based on get_nr_swap_pages or the
> available memory simply sounds wrong.

Why? That is pretty much exactly what we are doing with buffer objects 
and system memory for years.

Regards,
Christian.
