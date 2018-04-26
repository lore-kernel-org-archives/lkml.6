Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756031AbeDZUn4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:43:56 -0400
Received: from mail-co1nam03on0078.outbound.protection.outlook.com ([104.47.40.78]:57376
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754183AbeDZUnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:43:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
        Christian.Koenig@amd.com, David.Panariti@amd.com,
        akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
 <611911a3-2858-200c-d5f8-679c5f41ee3a@amd.com>
 <d6754c66-afe8-db2a-5633-d33701e22f3c@amd.com> <87zi1qq7t1.fsf@xmission.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <6e7f0d52-8d31-2ebb-47c3-865d676e8158@amd.com>
Date: Thu, 26 Apr 2018 16:43:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <87zi1qq7t1.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [199.7.156.235]
X-ClientProxiedBy: YQXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::18) To CY4PR1201MB0119.namprd12.prod.outlook.com
 (2603:10b6:910:1c::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0119;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0119;3:2Z+cavbj/pev8TX45aLLOYqyhuw5pFbOOyJ7DnHFQQHogWWoirUx3/5lD+QpBAT+QG4whqPhh24NNOL/+/D+qqn4blrCwP/oIg823cR40TNxL41QdwqgQD07OYLzJAyJa+y1SnttQkTeQ1FoY4QdmUH/MHnQe/TFo6SzqhUuf/jkFgM7brP79h3NR/3XlkcBmiabcaXSQEaCSAaQV1SU7YGDfE2okbAWcAppF5/j2ztT0zB+WUTP2CWxl4nx6M25;25:8+E9bXiPoqs+HkHkhZkcprgj2QZ8nfPENqipvkVqZUM6GMkcjvuuNAeMBguOyMIBHjR0uW54s38fhsBObiNc8VfyO4nVnqcmGu9mEI6+H8cJcXbv1mrUk+Za73HXSBTgNgN6LIUHovloWzHb7j/LPTdC8JASuuyzA3kLxKcw67FLzwM+EDb3itsIJQYbf7LnRRraeeEu+YVeol47oChi+NEQ8mu/eCCV3aPip1QHzxefFGV9Ms9mvSVkyMuvS/cYli328lkEpvkKonGeuW03oTA8nuDiF43EREjJBiKyhAv6lrWccwOuKc84XN+g8knZ4ybRnQWbkMfeSl3PtjyjRQ==;31:ykAqH+046TVp8ZszhgYKFMe8bTpggL7GIV1Kx3v1ZlNnKpDNE1jPVsml6c1CfpDrVO/xZ5DUBP0EUrE3WEw5hgFCBZBU/dWNgthBoNq9TIwKiQU7Ub90Dn+Wu9Ul5I5EhfI6Al9HBUq3byrLj9O4HkwC9wZTaaK+05yVVRoCF5EpVKe7laXBrFjOFHrWb+4XGQVSoJ7ycIRvb8WygIxFbdkhQZ5nLwuRLKhBGQamkmY=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0119;20:91jvoc4TJklmZ9NrgyxXMB5feYsXJZzuRUSb1nsrF9I8ySz6CHIvG8UdJ7kcFHMndKmHlzXB1KkOAo+vPI/4Kdk6VKv0CSq9raleOGcwRMVwsraD0RZuW1zhgQSZXVRZ8cUUmBTAEJausU/VXDDe1i0fxhbvCq1/kHqgulyiChqpoxvPPwAa5esqWwgGIJeVwxNYV52iccWwl7TtBLg7S0abGfm9TDrJ/vtieUxAVDeFSqHpc/kaUQh7OpMhZ8yHlbetq4/0p5M358ER0KQP+EOo2ZNusz1FKV5Z1hFLZbXMJh9pHsQyJaN+u3QFTFEj8c42OBXZh/PT6uvMVdxcJjNQrElisvlszvSH/W4uCpXGdrXgSfjcV+Ue2CVwCuA04B88nbvbi+x4oG2efRRN90+xB+uQbyq57Ib7P5aTLMU8E+s8zr5n1isqURGTnHghlBFAuC/sY2dbxol8ZRj6l9ZjQaHYotTKMzFhP3L7nmRRfr9in3/3ztHrYVsEl0/A;4:UarEa3AS/O+i9INy/a2RouKNsaAAvKnW11i+Ov/NdNYn7+GSi/rvpzT3yN24tghr4vTUw7s3eBf2IkRx1jsWna+N3TTN78UOTHXXJ96YrYyRmucG489gKuMsaz71Exz4dvuzL6BdgDT2WuWaUN+EpNuRTmipACpXFT7Xdga4RzkCNtJkY8n5N4aOtM9coVBOpDUzaTHz7p4UY779Wok4o53HFtgimwFDgwJ6m7gVrOs/RaBN/wX6XCay2JjIXYgt4nbsecymuGNkZm8zZ8/e+vOhVI2/wIt+kmOWXQbjbOe1vQi9YbJahxmEgNny8I5C
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0119448FE92EB4E2042E6AD9EA8E0@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR1201MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0119;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(376002)(39380400002)(396003)(346002)(189003)(199004)(316002)(4326008)(64126003)(68736007)(186003)(58126008)(230700001)(486006)(76176011)(67846002)(50466002)(956004)(81166006)(36756003)(11346002)(446003)(8676002)(52116002)(97736004)(105586002)(25786009)(16576012)(106356001)(5660300001)(2486003)(47776003)(53936002)(476003)(229853002)(6116002)(81156014)(31696002)(86362001)(52146003)(6246003)(305945005)(7736002)(53546011)(2616005)(117156002)(23676004)(6486002)(3846002)(65826007)(77096007)(66066001)(2906002)(65956001)(6666003)(65806001)(26005)(386003)(8936002)(31686004)(478600001)(93886005)(16526019)(59450400001)(72206003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0119;H:[192.168.43.101];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyMDFNQjAxMTk7MjM6ekNaaVl1dFZidFpUSGdsRzZOeHUwOUYw?=
 =?utf-8?B?Umg3M204VlhZZHJKcHM2bkM3dXY5bGZlWXJLT1piQ1lFcW9NTkFtY3VkWkZQ?=
 =?utf-8?B?Y2xyWTVXWHF5RGxZSWM0a0FIZHhGbTU1b3NmMlo4KzU4K052VE4zS2k3ZnZt?=
 =?utf-8?B?Mk5qdGVFUnlCUVpoZ0o5Q20yRFBPNFgrSXJZYzI3bmdXSHV0MlZmRXZKR3Np?=
 =?utf-8?B?c09OamRmT1RYYmt5OW9sK01iQkpFQU8vTy9ITVFGNU9KZHZEeVdkZlhpdVVv?=
 =?utf-8?B?VHZhTGsxTjhkMTB1akZOdklRaHFsbUxYNGYzb2VhTGM5SWJKeVJYOFhiUXVT?=
 =?utf-8?B?WW01T0gvL1ZBcHFIOER4SzJwb3d1Wk1QaHI3M2w5RGcxL2JpY0NMZWM2RzdR?=
 =?utf-8?B?NFovaTl1RXp0VjJHYzhrRWs4NHNuY1p1a3Fva3Q0T0o2dk4zVndhZTJUUGEr?=
 =?utf-8?B?ckozOVhGdmMyYm94a2dVeTVJN0hBRFZSY3QzOStsVC90a3NXcWFtVXJzbWIy?=
 =?utf-8?B?QW1zbkVVYnZLUXBFYjVtY0FFNk5nV002dUh5b2xuelo3WVA0V2Zzb3RsRGVz?=
 =?utf-8?B?QmYvNGVVNThkai9OUnJWK0JRcjVMcytJMkhGOUxxakJoaXRlcTBRK2ZFY2dT?=
 =?utf-8?B?cXZOcDZ0elZMbGdqK1VVaWdITW05UmxZRC9oTjgxK0o2OFM4VFhqRDQ4Titt?=
 =?utf-8?B?WjNaT09CL2hpN1lQcUoxYzlWUTk5dUtJOVZzVEdidHBoc3pVdkxSYVZpdVM5?=
 =?utf-8?B?NGNvRmR3RWs3cE4zbG0wWXFIRjcvWEpFZ3NFZmlSUWl4K2ZmY0t3dnRod202?=
 =?utf-8?B?Y01RL3B6MFRBOUwwR1JSL0k2cHh0dWo1ek8yVGhXYW5SSVZ5Sm01UzRiVnp1?=
 =?utf-8?B?bklqOWUwbmZxbzlvOTZKdEFhcDFPaWlUa3VJNlIxWUlTNXRsWXJFMG50TEIv?=
 =?utf-8?B?YkplL01ncWwwanlpMXFKTW41dy80cG02RXErV3lsWHpvQ0MzREhTQTdnNWVM?=
 =?utf-8?B?c1lxeHVnZ2IzUzBtTnFRQWFVRE9EV2Jpb3BZUitEUkVrMFdHYjBHaEJObE1J?=
 =?utf-8?B?bDh5ejRydnNwUWUvbXdkY1dadDRMNkF6L2hnRHRmU2IzdWlGOFNjaEpjSnpu?=
 =?utf-8?B?enpSWFZ3dElIWlJDd3FjY2NlSlFxUDMraTNsNVRCcUhSTTFrd3ExMDFOWmVB?=
 =?utf-8?B?aHZUcjJTN1UxWGRDamxLSFNRbjVhbWRDdUdmMmNQMjJFMEFudUlqaWZQSDJh?=
 =?utf-8?B?U2xiaURTZVdNMnhsdk5tbnBDMjB4T0JSTTJITVJvUXlpTHFpMzBueWNxV2NX?=
 =?utf-8?B?M25FL2FlR05SOHBtODJOWkxhQS9OWmpBUTFicElSSHVLQjVHcGw5Njd3b28z?=
 =?utf-8?B?RUxiclY2eTMyN2VmZFdYUEFnV09TWnYwaXNaR3dtTDdHdmplNEcwaWpvV2JO?=
 =?utf-8?B?cjlyNEpqODk2NXNZcFNjZWsyUHlwUWFpSlZZYVZWc1o4Vlo2UTdkb2RIUjRx?=
 =?utf-8?B?UXY0T0JjckdDQWtpVkc2UGVwZnROS1ZrT0pCeENCMlN0Tm0vV1BQbHd0WmQr?=
 =?utf-8?B?bTJEUnZBUUZyVHIwYTVEZ3MrV0pZZ3JUbWsrZUIxaDVYRWhvN3hUTGhsSk9H?=
 =?utf-8?B?OHhic0svVXlsUExnaGdta2EvdXRYNjd6QVg2SExGVkgyRkZ0MEwyV1Q2VFE2?=
 =?utf-8?B?STJrT3hSd1FpRFFVeFRwNWVvMUNtMFN4SUQ2OGZTazJXdWFSNHQ3ZldaUXZP?=
 =?utf-8?B?TTBkUVFnRzNVV1hNVGVmb1dMcDEzdy93MEdDSFcyTUY1bXV0WlJYbHVCTlFv?=
 =?utf-8?B?bVc0NTB1bzV5bjVuK1JGQnI0SzgrUTFMNjRMYUVoMkpQVmJDbmlOamVMRDhw?=
 =?utf-8?B?Y0I1NlBPWk93c3JsclpBMEIyb2dxYzcwK3ZYWGFuaU83Z1lWZTJ2QUszSUdF?=
 =?utf-8?B?cUNjOXI3N09JaDE1T1B6bFpuNGQweTJ3M0JtZGF4Ukp5Z2RYTnVHRXdKSWtZ?=
 =?utf-8?B?Z2Z3ckplOEZnV05vcVQ5RlR3WnlkaFd5Rk8rSGhFcW1VZlovY2NMUVFHNm04?=
 =?utf-8?Q?0CMvaqUt4BZpJBbwawpB6DfxepV?=
X-Microsoft-Antispam-Message-Info: 3OsCKDYbFy2Wvv2Pnd+y3jW+WP+6FObPim7m+74yVhIb1fms38CIRpu2/q/KSCb5Aai2Mrcb0JFQ8yW1M4Dopezcm1qqh1XDT3yUJvA8LS1AA7piy3a4UwbT9drWxl7DFpwYkuu992fyGweYbD7LoukLpHtdG15ZVQEQvwgUsyUxC5OB0L5Ll8sAzFGHTojb
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0119;6:Z3TBEtIAoXrFTjv8ETAYoOSIDaQ3XiFmrz/b33X9+I7v0biPPZifqjJ3yvWuGVZSYFiShu2rpM1HKnGyz5M62aJ+WHT27maGxc08bw1CgYcebKFQbbIoGxthzaXyCoNGh/3SUJG2dIVDYzWR99DQpXgRO5prMvoNbu3yGxpibrGx9SMNEyswcVtOlc+dTUvTnv1OV674JRF/wdGZxkDBguF2tiDBKXjf3epkKoRvRtT3Ub4ACXlWGa5pRvOr42CY1YjEOn443JanutAEv4nj2haJQPsemnpyiCLTv1vuTw+YTrUGml2VvUlg0grLJZNL+sHnm4g/aYEBz/13+9J8IIxQC/Sru0RnE77Y63dxI5X67PU3YkMwyj+c6qa0zv8oPKUhbP7XDpyygrs78rHpq3S2jxJVszEU0Yha6LM8Yg6AHvGBn2CIgV0fP3byREFUpa+Vc772EhKYgqQLJQZXQw==;5:CIvhVFlrIw+jXlwfeCCGNvJ5crVxWB+N/Lk1JAycz23xiJ+bPZkok1BcL9+mKEmmsNvodjR9ry0Lo2O7cdT5oiOxISLmOtqXcXxwuG7Q3c7V5X4Ai602D8QtcQzyMoO8+92FBvK0M7/uQwKiR/Qq1b80EwKduYtiPyOtJ4j5pgE=;24:n//u+ETa7FWZNGGdUYL9Tt8dM8SKuEoaTmNYrSrefW718OY9WqQ91mC+IfJdsOx0ba9DUCiGPDAWvN9lPWgufRm6b28//X/1olbh0HsHKP8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0119;7:bpf/oA3Y8pWabs0omzdUAY3GH/snoFw3gP0NyGpf7nrhmtegg+DxArXEWM3BjiyvS9lA7NtJyO9nbj++ARw74YzYyjgSvSvL5M5pYztOQXHcZqbr56/rGVm3sW4/ftNF9EGBMnEXNOdDddZog+9kvTSwLDFOCfHLSgG86geOxYt1pYs9IXdZxzaG7GLneySdYTRnHH4Cn837qclDpoNrDZGPaMo096AivbIzr6XyjrgJi8zSvaMWbA1bvXCbsJ5k;20:FQ6dsu1WStuAbQYb/P+sPb4ZPdOd1cJr+7AUndibeNJZp6A6ujEuWYBEt07GGdE3epgASi0tWETNPOZRK66eTB6sw8JMKbq3O/3rimq+0jpxPPDCKhSVAHkb7kmyFHwhc6wde8ZLKxcQmkcRAa/nlCmmngX4o47f2Xo4NhCFH1CrFT0Txt36LMU8BkbC1gyV+B6vdH+FuTNu/QFgDjGQF64bnTVnpyyeV68TDiY83P66YNowe1SInklsTSr5HX18
X-MS-Office365-Filtering-Correlation-Id: 03866ef5-91a7-42b4-5f98-08d5abb66abe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 20:43:48.1364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03866ef5-91a7-42b4-5f98-08d5abb66abe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/26/2018 11:57 AM, Eric W. Biederman wrote:
> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>
>> On 04/26/2018 08:34 AM, Andrey Grodzovsky wrote:
>>>
>>> On 04/25/2018 08:01 PM, Eric W. Biederman wrote:
>>>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>>>
>>>>> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>>>>>> On 04/25, Andrey Grodzovsky wrote:
>>>>>>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>>>>>>> able to exit immediately
>>>>>>> and not wait for GPU jobs completion when the reason for reaching this
>>>>>>> code
>>>>>>> is because of KILL
>>>>>>> signal to the user process who opened the device file.
>>>>>> Can you hook f_op->flush method?
>>>>> But this one is called for each task releasing a reference to the the file,
>>>>> so
>>>>> not sure I see how this solves the problem.
>>>> The big question is why do you need to wait during the final closing a
>>>> file?
>>>>
>>>> The wait can be terminated so the wait does not appear to be simply a
>>>> matter of correctness.
>>> Well, as I understand it, it just means that you don't want to abruptly
>>> terminate GPU work in progress without a good
>>> reason (such as KILL signal). When we exit we are going to release various
>>> resources GPU is still using so we either
>>> wait for it to complete or terminate the remaining jobs.
> At the point of do_exit you might as well be a KILL signal however you
> got there.
>
>> Looked more into code, some correction, drm_sched_entity_fini means the SW job
>> queue itself is about to die, so we must
>> either wait for completion or terminate any outstanding jobs that are still in
>> the SW queue. Anything which already in flight in HW
>> will still complete.
> It sounds like we don't care if we block the process that had the file
> descriptor open, this is just book keeping.  Which allows having a piece
> of code that cleans up resources when the GPU is done with the queue but
> does not make userspace wait.  (option 1)
>
> For it to make sense that we let the process run there has to be
> something that cares about the results being completed.  If all of the
> file descriptors are closed and the process is killed I can't see who
> will care that the software queue will continue to be processed.  So it
> may be reasonable to simply kill the queue (option 2).
>
> If userspace really needs the wait it is probably better done in
> f_op->flush so that every close of the file descriptor blocks
> until the queue is flushed (option 3).
>
> Do you know if userspace cares about the gpu operations completing?

I don't have a good answer for that, I would assume it depends on type
of jobs still remaining unprocessed and on the general type of work the user
process is doing.

Some key people who can answer this are currently away for a few days/week
so the answer for this will have to wait a bit.

Andrey

>
> My skim of the code suggests that nothing actually cares about those
> operations, but I really don't know the gpu well.
>
> Eric
