Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeEDOlz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:41:55 -0400
Received: from mail-ve1eur01on0112.outbound.protection.outlook.com ([104.47.1.112]:17328
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751605AbeEDOlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:41:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 2/3] kcov: prefault the kcov_area
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dvyukov@google.com, mingo@redhat.com, peterz@infradead.org
References: <20180504135535.53744-1-mark.rutland@arm.com>
 <20180504135535.53744-3-mark.rutland@arm.com>
 <2389e204-1b78-00a8-d69d-0ca4969be1fd@virtuozzo.com>
 <20180504143805.bwakjtfryrw7l2qx@lakrids.cambridge.arm.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <ed196752-fd87-1034-42cf-f62f8bae401d@virtuozzo.com>
Date: Fri, 4 May 2018 17:42:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504143805.bwakjtfryrw7l2qx@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0032.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::21)
 To AM6PR08MB3256.eurprd08.prod.outlook.com (2603:10a6:209:47::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3256;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;3:hi4WKKe5Z7LFk5ngwgfUitvFsQE/zfR1dhTLAeODfP2EYwN5503sFnVhZnpue/1Tw3E14COSoENQJ3NExajhL3lMIRdik57N50CSjCfyCGrD/y35uqz3oAQMFY5juLz9lIanoZvr9uxVgu8Gnn1gqHlzzynHpC2K9C/pUKEpbW6QjqvVP3J1c7E2QMBbAPFEZrkNwWIjPO5AXMgGu8wno4edz47oHfm8PPBoUYMN31Bpd08JmkGdA8vt/90EI6lr;25:mg3Rh47wZQztDYxoBC8fxc9QxIDv94+fVPrMj/5RoAdZhUbwtg0DdsstJqJu/X9hXrPuue56wlq3GibytjtWSc+bx/Ss9KqP+jXAwDAN0508Lb5I6ZT5nvFsPXcrH7BRnWXXV41d9KGLeuURG0B8R7Ahb5IAhYOedyc+6Cd04Qxk2+L7JCGA/YMpAGMofvsumaQ52ITLE9kApRJnfS+qAnNqaH/bJjmT/bSAKn9zQE6woKDF77dSU/SNVwrQGyyeDW8JiG2gMcL8AtKiXFJXOAEAk9dR+g+LG7OG2hpvXLYt6X8y1/trNlh0jt7VEb9zoRtYdRWddzHywQZkuiU9wQ==;31:jc/AnVGQB5RtItk9so9zwDURvwj/rcvneCQ7w/EIE4DB3KG4pmdIjEXoxkeCwlulpERXtpOTHr9fEqr71On7K3bypvWexvfh0Bc1GcFGUm5qX5Jw37fXXMqNaE7fQ0/Sz3X5kLQPc79+b82vlekxuDi3Rz/gLWuJLWULcd5bos9ADkUaYmf09x1PaXict274WKK99vPLe9wVlcnkMA4W4LdfiGPt/L0ljWUL8kovFy0=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3256:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:ufJ9inkiS6oJ2MWoKNu/g9hYR683QBPEBpFSODDuCjUey/Tygmbaq2RG7vnXUhghGlPQH4OTmmxWn6PDDvPQJrnOGaj/UtGLHEp8QmxzHntetq5ERtugIAHi5WgU9X7pbL/PnHc9Hp+QfTmkwHBIIjADt4zbTvxPeO+KDTWJyTLQuscqJmELIjeK75t0gPQ2RZ572cxJ/sLecBd+EuDS+4CEZbQEXhbMp/FQKxkIl9En/DDdkpOPVALEqQsqLwpAD/m3fK7EaKJtZ5g/2G+xOuQI8R66cbQ2q5KPQsAU6Ui1DzB3t3//BnUcNuAnggciD3n4whvXiSOkrzfYWtFp0eKlg4LY45hZ8KYCwlHrIB8/FCzGI/V+1kYkl5TLrPQPW8PpD1UhP+fzc5MEC6k3apH+ZNwLg9RHZjCLLYcZ9p1odhHDr+WhGuLSQgN1i9QyWKvXtuwd3OTDFO1FkzE+kwGGzf15KA+3jxetw7qXzIwgHQv6hq1kIcubti+AWzB0;4:97CHqip/1ux1UTd2gZlBCl9UhiDz48bV3s74DxmLHNZDzQJHIs2Ee9MncM+Q91axpGeoAYfDFZRLlwmYZhmdaXUFFUD/XdBUCmKD/ZSPs8VxrsoZl65y8YpI/3Od3N2TY7w06Xig+EGavkM6lUZAyx9IGPrYAsCznHQ2AWSwGGHQfO4n32gkknFCx4BmQ+CDjKiMUYkMwgbbPh7DkrhCFmHhJBLDb1R0ZH7sdUo/zzEZ+h7shILb9pH26t4ROmdpdgphm/wyozqXMflQKTgwEw==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3256FB27E5BDA5674A8C72D1B0860@AM6PR08MB3256.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3256;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3256;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(396003)(376002)(39380400002)(39850400004)(199004)(189003)(47776003)(386003)(26005)(105586002)(77096007)(64126003)(93886005)(4326008)(956004)(2616005)(446003)(52116002)(11346002)(6246003)(50466002)(230700001)(53936002)(478600001)(76176011)(2486003)(53546011)(23676004)(476003)(16576012)(16526019)(52146003)(316002)(58126008)(55236004)(66066001)(65956001)(186003)(65806001)(2906002)(68736007)(6116002)(36756003)(65826007)(6486002)(25786009)(6916009)(86362001)(106356001)(305945005)(486006)(3846002)(7736002)(31696002)(8936002)(97736004)(81166006)(5660300001)(81156014)(8676002)(229853002)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3256;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU2OzIzOk1aRHRlZ3BYMENCYWRBL3BScFYrbnV3K2ZJ?=
 =?utf-8?B?OTlNTEMvSGNKcEw2MGtLZWdPL0Rjd1d5bWY2LzBuZjFXVmptaWJQUDBib0d5?=
 =?utf-8?B?SWsydmZyeWdjbitZRVQzNTJVaDhHWlJTc01aMEJ3a3RocTYwcnVnaG5PV0Jq?=
 =?utf-8?B?alF2VUpNMVNNbnJZam10UnBFakt1UUpGUVh0YmhxTjhlUkNGMmZ2K21vUCti?=
 =?utf-8?B?RDFlUENTemYvd2pKZmZOMklDdFE2YWFoTjJ1aFFiUEh2RUVTRmwrUU9CU3RN?=
 =?utf-8?B?dDZDaUpheDJYWG1lSUNJM1BWdmNwRWdsejQvcGFjTGoyNUZLckh1cWZnOVBr?=
 =?utf-8?B?c1c1N1kzamJrT0xLWHRiQ3FCZ3hOeStUS1hEcUs5dEgzMkJlSk5XS0w2OUhV?=
 =?utf-8?B?dllCWk1DOWg5RkFCdzNlYUlsbktpTjF1OHh5T2VhdHdvbStrT1BRK081QjVt?=
 =?utf-8?B?bmwzS25jNXdmMXVDNjNDdmVabzdseThua0w2S1phZ3ZZbHpNcS81Uy82bjFm?=
 =?utf-8?B?cy9kWUNLZlpBeWtsK0NESHNOMjNPRnJkZTBheDV2NHVRVEFuVWVuck5ZTmJH?=
 =?utf-8?B?UW5SM1FJZnJQd0hUTlMzRlhRVm43SkVJTHdnQTFXOFhVdEF2Vm5VdGRFNnAr?=
 =?utf-8?B?SkszaVdIcllwNHZKbGxrRW5qYmp5eDcvNzdDYWd3OVNSQWw5NGEwd0psRUti?=
 =?utf-8?B?L25Vb0w0QlFxRFVWQVN2dUE0K0QyRzJyaUkwekxoRGxsRnk4eitDZ1ZURytU?=
 =?utf-8?B?WWI0WTBNYXZ5WGlJVElGdWN0T3NLT3JseU1lbXNsS2ZQV2NxRElMNFh1Y2FE?=
 =?utf-8?B?akpWZDFHMUkvRVlEMW1tUy8rYWYyd0xrR2JIV2ZLTHlFcDdsRkdXQ2lZdUcz?=
 =?utf-8?B?MFZZSHB0K0pkYXBycDk0d0pkTHgraEYvclNpOWdPelovZFNUOE9Xb3kvWTdN?=
 =?utf-8?B?NnNpQWxrRHI4VHY2R3FYTGxLeFpEV1hEQnpUc0dWaklGeXI3ZUgyTHFMWi80?=
 =?utf-8?B?d2hTeTBiVkVnRWMrVTlBVFBLdmQzb1dCWkM2TG1EZXhiV2VLaTV3Sit6cVFV?=
 =?utf-8?B?ZWdWMHV1NmtUWUlYeW5jSDFodE9Sa3MzdStiWEdoVC9iUUxzemZReXFLQ2VP?=
 =?utf-8?B?eEVRZkh5NHpXTXRpcExmeS9NSVdjbkFwbGlmcDl5aTJLN0wwVTZJNUNqU3RU?=
 =?utf-8?B?UVZkOEVnOFkxUmlGWTFnUjY3WnNUL2R0TE0zV29ZaHBiTVpoQ3gxbCtXY0px?=
 =?utf-8?B?L0FvaEFlYTcxSkhvUWh4SG9odUlGNHBkaTc4UjgvMStLTHNOcFI0WHhJK3Bo?=
 =?utf-8?B?SktZV1IvS0FMMk5Dd0UxOGJxVE9zL2FJOWtjNk9vdnhpN2FjeHhIVjdnckJa?=
 =?utf-8?B?NVJ5a1JHcldpNS80dGcybS9JTFdiTjFzeGZzMXpFR3NsalJLdnRMbnpIc1ZV?=
 =?utf-8?B?WEhiN2duWWdHZW1VWllqT0hZWFdEd3NVMFp5T0dkOEp0WnB3NlVSN3JudkxT?=
 =?utf-8?B?TEZXejducWdQZnM5M2JOOWF0VWt5ZVJ0dkk5QkR0UzF6UTZOYXh3eG9MWmRu?=
 =?utf-8?B?MGF0bE5rQUVhdjErSXYyTVY1d05neE90R0dNcElTMVBGd21vVGVDYkIxWGlZ?=
 =?utf-8?B?eTdxVHl3S2VFWnJPOGNKMVRDSk93aU81S2cwYVpkNXpON2VvRUtYVk0wUFNK?=
 =?utf-8?B?OE5XejFVeGV0RGdhd0FIUldrSE82TlM5NWR3S3R4Q1F5Ty9UY2ptMnAwWldk?=
 =?utf-8?B?b3kyR3Y4SE53ZEptQmJKWDZxMmZjN2plcldLeTBjMUNhZmJGYTNYNFZMRUNK?=
 =?utf-8?B?aFIzRlNxOVQrdXJLTWlIN3huSGp2TTE2ZEhXWDU5YWRuaUh5anJYWXZ1eFgx?=
 =?utf-8?B?NnhkVjNKZ1p1OExrYnY1VzRIT3MyY2owRzZiVHVtS3l3WDl0TzNNT1BaYVN5?=
 =?utf-8?Q?cVW+fly0cs1WNKmPNOuGAY2I2W6dS4=3D?=
X-Microsoft-Antispam-Message-Info: F3u60m7H7eRQeA+unwJcX7iV0fg57RoxhaqAwRu5rha7kZpx2ZTVqdc/Nji5YZZ2u/9dRdPz9BTyNWnBkA3kJpyaXue5v/T90YoGl4Ji1MXYogEJAYWCAhuCZHzQaOs8uW0wINAh1l7tWgR33q68f0VXn8r7f+baA1x2jwK90XTGIt9hAGGglfX+dGQdXYrX
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;6:XAM0H9tZcv1dRd5eJvVQSkpspVMO/NeHWBZYi/isQ77D63TLdpeFRYwi+bbU88bALUFPseavMxGpjEqziHeHOrQ74F8unnE7x6UisiCFTDGS+dBTMSahAcszIlZ0i60FG1+QUR9VBra1sMKw8xe8PTYlJrBC++70zK4oWt0vUpeSvFji/htxftmRZD7qKJmssi9DsQzzXF6r5l6fIcjPD4YnYtYErXtRWF0wOrnHtX2BPbKoVcmMC2yKgShw/qG3eO4VKpjfUmZ9jUhd8ly3ASTvt/3v8MIj5Cm0DoHxr48lvRsSj0r9gpvyby19FJ+Nk9Gw7cTZLCkTwhGfvGYUudJanjhkuTkpAlnbxWJPVxg/RDi2QI72eiOOwGcEvak+VZkjE2tH7r4Ckna0UW3VXbgunOXRcZI/daWdHnSpmvwm5i9vZrTVE07r91jxis4E54H3qBQ8x2cqPlWVFVF4lA==;5:vCr8fsTqAH0FZM6VLXke8VIKqocawNgdNBrDkhGRHRbny2tP/r1VJ60iRtqRJ2ZLeMmaIhaAe8H7kYYi0P9Vhc5Ggmp2pRe6Qg6179sADPZTTvuJXjjYGc84lbiVNkAJs4Olp/jgUVHL6uY/SRtnO1RuzpQF7f+N8Wjk/u18mF8=;24:EgX2NXRb3Tg5y6hig078wCzv4PqC6/l09Bpc56fPU0Dxz4RFwhzmC8T4ytl42E3urLMvoC+wWR40OG16wuV5nOPrFE8cCFNjfikC4gQwVM4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;7:QTasXGIVttu1X6YWKN/D6ZMqkFYzFCAG2VzrikW4hlYJmnc9AZvuRtWPbHwI+dl2ljXA9vV/p04E3mZrgEAWDqQIykGE1WesrL9qz4hoH0+eiQfiTBND8EQd2lITp+xLapUoCUjLTfO4wfJHhlQgfPUJOIOgc0fQWaMV6M1YrcEV6zAZx4/6x1PwpjDWPErDytC8mai1VurAzECF2VkU72Q9NXkqHYwAxqNkKVAbud1BbLSM2XJAGxy3tfDP06E3;20:cxYJKG9neBUq9yF4A9kE24AJAfKo+qk5Kv98PjZfSGW/beNnL7iqJ4QI2yxfW1HAITQVL2WU8XqChfrPJj4zxnDj6CTbN8mCMirYZa2Jf7ZRST07HXRXrwlopISa8zIWw8HcAdfbxsarifS1GRC2Xl5/vVws1WU+cN7wQnCooxQ=
X-MS-Office365-Filtering-Correlation-Id: 3b8f76de-3768-434a-9245-08d5b1cd2c0d
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 14:41:50.3604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8f76de-3768-434a-9245-08d5b1cd2c0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2018 05:38 PM, Mark Rutland wrote:
> On Fri, May 04, 2018 at 05:36:49PM +0300, Andrey Ryabinin wrote:
>>
>>
>> On 05/04/2018 04:55 PM, Mark Rutland wrote:
>>
>>>  
>>> +static void kcov_fault_in_area(struct kcov *kcov)
>>> +{
>>> +	unsigned long stride = PAGE_SIZE / sizeof(unsigned long);
>>> +	unsigned long *area = kcov->area;
>>> +	unsigned long offset;
>>> +
>>> +	for (offset = 0; offset < kcov->size; offset += stride) {
>>> +		READ_ONCE(area[offset]);
>>> +	}
>>
>> Usually we don't use {} for a single statement blocks.
>>
>>> +}
>>> +
> 
> I'll remove the braces.
> 
> Can I consider that an ack, otherwise? :)

Yes, ack for all 3 patches.


> 
> Thanks,
> Mark.
> 
