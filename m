Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755844AbeDZMwo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:52:44 -0400
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:36640
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754277AbeDZMwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:52:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
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
Message-ID: <d6754c66-afe8-db2a-5633-d33701e22f3c@amd.com>
Date: Thu, 26 Apr 2018 08:52:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <611911a3-2858-200c-d5f8-679c5f41ee3a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::20) To DM5PR1201MB0121.namprd12.prod.outlook.com
 (2603:10b6:4:55::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR1201MB0121;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0121;3:FEVGJ7fRglftHx3W4JimtYV4Z87sJupHps1wAqTeXxwCSeh7UU05MoOzqziXc603T5RraJCPIHob0GwByFjKpekF3flstP5mD6OJfS9u+EuoP6fgDCUOlEKcOg8COceLXei9VyaAhLdcJhjjT0MMpaEWSUDFOQ6bHAUi6fCLSoPAK9cOb1zhdDPyzzEYswn8SurJ34W70ETnPSmztOp35TepD1xqNCX3XRwGK2xlCW7jQ8nP+OvCUDhXkhMi17TT;25:2kcj92vmcxLMIbcSy86VyNNw5qqn9xzcicQ/n/obsQwBXdPTs8VdqhBVMSBe9CKBgeJpy0nE6/BXTaHRn6X11OSICR1X02AN7RMuFoTzo0aopO0eEp+seUVJ56prScz+DYhzYjRkLbPj1+CxOjfiBxWi7aGNsCQ5wgBC+GuoSqQwpRrAzVxuzbrpUbQberzds5rPIRYHan6ZiPX75TKxbUleEQjo7HK5Jwu5LiAGimdr9GuiCtqrPXSWq9WyUfE8rjddi4jt0cGri7GzO6YNBBUb0d+s/NAjZKqZ75tycpM88O1jVXq72Cfz3ZuSTHZf1+wgpXS5EKEepIpiO1EadA==;31:JHS/zENlGsiUrNsO7nwBhsJvmFaBtjGqo0lvUoPfJj820TwYD/90OvEl7UY88MT6vj52/CRQA/NZ+NQIs/H4Xnh732PWY+N31T7goC+GYwGZRg+To0MdbdGbn+U1w7xbi9SzYQBUvgA7o0CAE2XmJpZajfSoxhTAl7UP0mFrr7mjv43AZCniV5aF0EoNUyy9hixgDfUu01tuc6pZwVmVigN0aKfNsgABCzb0YgKZ8hs=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0121;20:GxKc0Zggv4bckSEygD0DnAt3MTKxzPCOd74RtE3BhAvLeG26dqo8oBtMO9rhNxyLedpkw6igkd83ryrYLxJvUBw+yDZMoMZQSljILO1RW8rBXrMu45sTUBw06c81kxiEP+T/2hrnlJHUw0C4+Asj5iKAYtn/G9q1Su0EX9MEznem58Ny2PdANkFHuQwRy88AHMqOg4VXfbxvXpTRWMsyBHrC8vlw7cJ4uRZg7Fx7rguVIbaZLtb3mrTeQMeuJkcRVUTRVnC6zhJS2oanTaRC8zL2KP3T0Lwvl8MAZiQQhT6dwWVPNfeRf4Ud9lcDmuoivom6HSDRzNKw+k0z8PPZFjvVVrVz2BnaWzpyLO3h+HOrDcsYwv5gVl+K+rakmuV461FsGqJr+mw8Vs7ooF902uq0XaTTjy+9Whhe5fxcU9J7/OHkqp9x75mKB2z32acRzE0o9d+v3HSzFrg8e/hHUWQ2c8zXfs74lX90cnM/pIybeu+7Wax04GnPeASRe7YO;4:TwNu/8ar2L0+2GpacerQlyWfzEMAK8S6dfhtPFLgi2SQwjTg8XWf4GyTajpgkpjfvvkNCSBKVa0MJDcQ0wPqnrYNJNsaD8nWjxEWkwPMESCyXdpUXDshb0cfTbvtEc/HJvYSye30h1mP/EcX9WJAO1mnWescm97MIlFz3qOKaq/69q01PKL9OKvF8bSwpJpEr1k8mn/lZXkvCkCaHjw93AsSrEZloeZCCE5eBc0/QHYCuXc1S4EbFdRmt7WjPLuONqVqMbzemQnUDQl4B6SnIdnYh80JNThX8PMMPPbAGS8Eg7FCnDsTzg5+BpwHdxPE
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01212ACA350B2811259DEA42EA8E0@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR1201MB0121;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB0121;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(366004)(346002)(39380400002)(376002)(199004)(189003)(230700001)(53936002)(81166006)(3846002)(72206003)(81156014)(6116002)(476003)(47776003)(6246003)(106356001)(305945005)(50466002)(2906002)(68736007)(93886005)(6916009)(478600001)(97736004)(86362001)(8676002)(77096007)(65826007)(64126003)(4326008)(16526019)(105586002)(65956001)(316002)(76176011)(25786009)(66066001)(26005)(59450400001)(7736002)(65806001)(16576012)(31696002)(52146003)(486006)(2486003)(52116002)(186003)(23676004)(58126008)(5660300001)(2616005)(956004)(67846002)(31686004)(6666003)(386003)(8936002)(6486002)(53546011)(229853002)(36756003)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0121;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjAxMjE7MjM6bVZBWlErbXVRL1NXR1UvMDVsak05Mk10?=
 =?utf-8?B?VWNod25EN1pRT0w2NG1lS0gzM3ZHYnpBNHpYREZEdmU5MEl2WVJMV1JXSVIx?=
 =?utf-8?B?dG1RS3ZLTEdUanVwcmUzd2YrbmNOZ2RQRTFPekNqODdkb001ei80SENuSXZD?=
 =?utf-8?B?VVIwcFVTTWpCaTdvRUI4N2JpV2VCZmIyVUY1R1Judk9oUjJZakdWeGlvWlBI?=
 =?utf-8?B?NUN4VlE5TlB5ZEIrbDZHWVgzTHdJeUw2RFZZYzE4SXVkZ284bE9HWU9SZE1z?=
 =?utf-8?B?VjNJOThON3JtVno4ckxtdG9jT01BNFUxTEZ2YUhqNGdrZXNPNERKRTZmR1NH?=
 =?utf-8?B?ZFZwVnE3QXo0MUVTMHNKQkUvN2s1cVZzRENZWFZDb1l2cjd3dkNMRTJPcVFP?=
 =?utf-8?B?cWhjd2NaVXRlYXZlUFR1MW1aSVJ2REJjeFN0dzZkN0hYRWRWa1IySjhxRC83?=
 =?utf-8?B?U0pJTjRacU50QW9xcllYN0F6amszS1VJVWJOVjFrajRsckd6VDVuZ0puU1B2?=
 =?utf-8?B?VVRmMjF4V0ZoYmFpb2VwS2ZzWllBTWxCZUpsYzYwTlJ3V1pNUHpvcmNOeUZw?=
 =?utf-8?B?Y0Z3Z09FQkNGSEhDbjlFLzNMMXV4MEpIbkoremFTcjA3V3FBUHNZOC8razF0?=
 =?utf-8?B?czdBaDNONEJueE5nY2xncFNXcUQzS0dtTDVHNDRrdkVGSElPR3d0MUtMTjJp?=
 =?utf-8?B?eWEwSkhJWnBJY1FTbnVZTnkxRWNvRlBZREMwSnJjRk8rdE0xRGFqT3F3dkRk?=
 =?utf-8?B?OG9naU50QnBmd0Jrc2dqWmsxS2s5RFVVbFR3UkdHazZOc3lvck9VcFNOUEJj?=
 =?utf-8?B?cWFkT2Fsd2JPa2ZnV0VCV3VTMU0vVG9DbmR5bWxhSm9xOFFUcmhHNXk4aVll?=
 =?utf-8?B?SEtlNUJ5NE96cnpURnBXYVhFV0g1TUJlV0pySDFKTCtLMGpaMkVNeW10c1Jj?=
 =?utf-8?B?MmdVMklzSFJ5T3hoMVVGWkxGbFBKSFh1N0NlNUZEa3BiOWN3TkJtNDJxSkY1?=
 =?utf-8?B?a2svMS9KT1BRYVhKb291UHdnWVpoVmZ2UGplSlRrM1J6WDlWQnJuY0QrZ2hU?=
 =?utf-8?B?REwvSll4TFp5TUVYRTJEZ3p5MlMweTEzcXhEQkpQVzhmd05UMTlscGJRR3dx?=
 =?utf-8?B?aTlwOCtJZ3R6TGdIZHRMN00va1cxOGVZSHdxUEh0N3lQalcwN0ttUGg4b24r?=
 =?utf-8?B?OEZBMjlkcElzMFlaUkF2bldrVkp0NXlMOGZsYUJON3g2ZnZ0S2M3R2Q0cnZ4?=
 =?utf-8?B?U0FZdWxScjFDZk90THdWMnlNYkxreHJiNHFNcFlMd2x2VG1zZVg4b2RaM01n?=
 =?utf-8?B?eUVxZ1JRYS9sM3JCZVEvZDIvaGlCbDNrcjZMbmpjWmFBS0dOMnNEUlJwSm5J?=
 =?utf-8?B?MXBuRTIvSHpKRkU4Y2xCM1o0ZmZia2czMWxXS0NqR3laeG5odll3UVJ5RytM?=
 =?utf-8?B?RkptQllPRGlnYjBKZVdtYitjUUxQakRKUVlpeFhEZnhZcktWQU9VaHhTK3VN?=
 =?utf-8?B?TWNZSjc5djBQS0VteHJuaFpOYU5WRGVBNFJQcDNMc08vbWI5LzVNNWVTS2oy?=
 =?utf-8?B?ajUxZ3RnWXEwVkRCYTRFOUplMEdWTW1ic2dBZ0pIOGJSblVBYUZ1Y29MSmtr?=
 =?utf-8?B?R1dBeG5WaVB1TFk3dDJsKzdkTzZHeUZRejBVbmwwZnRmZE5Jd3V2M0dyb2lX?=
 =?utf-8?B?N1lraGhxTG15ZDlnY3c3bURJNHJkMUNra2VHQkUxOS9xY2Z0VUdaSmM0cVgy?=
 =?utf-8?B?cFM1K2FaTlVWM0R1TnF4b1pORjNqeUEyTXh2T3Y5NWRRU2hET0VISFZnUkU5?=
 =?utf-8?B?RHFMa20yNndZVHlFSkQxMUcxZ0htbUxzN2duSHhqT09vQzlxajlCbFNpQXpQ?=
 =?utf-8?B?cUREdWZ3bG96KzJ0QXZ5M3hLQXArell2cXg2cEZKWFJLVEZrU1A0aGx0Zm9k?=
 =?utf-8?B?UXJTR1hxNndSSUNFd3AzQW96dlk3c3lTQ1pzajM2SUprV1EvdklZaTdKS0pJ?=
 =?utf-8?B?cW1vREhyQnZkOEdDYS9STHlvYlU2clh2MjQ2Y0VWT3NseUh2dEFER2hHTW5m?=
 =?utf-8?Q?twqk0s=3D?=
X-Microsoft-Antispam-Message-Info: umkfSrzCY9Eg9bMo+yHq2Do09LdA8twRM7+gWNwqsR/sy597GEsTmzO5KZTOnhrGXixkgUFuFrJ8mSilnCmaAd51GH8HdzfrEB+JuzqDiXNqw3Lr2OLmujyXD4l4xFaENobyw6RJVWK7L37sjJRmooJRiPs8qqnhmAW2Bm5iFOicOIx7dxLGpAn4+80CMzsX
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0121;6:e31WDM+wE1FsnNPcF0Zoi8zejvYXlAyUH2YlHeIny3X4O2aAeBJWubXlmMORvItxehV0t9+sOiwEprEymhRX0lBZ5ZvTpWr1FbnMshJiVQ1NdyS+YbmzuJxiV37JOmPg5pXTHO2XFDqdm8Gy73U1NEG5LqItdq0NrLNg1EnIZ+yPm+J/pcbziQOi2TevzGXOIwxkST4muFBOaHGcdcT+nZ0e1eqDKmbIi3LkA0YCNAA4iLxU2uJcfRZ6w55Q8WJQhORdIpDd+CLqptL/YNtQtVl/LGMTTfgSlYugJwFTCVnY5m0YW4OsTq2gfzzdwIcflFIR3SLmaBcT85wqa3DS/UzlCYWIDIQBqgcbK2S9nRe30wKv8XWlHQJN3cU9gcVEKUoHklMP4lp18Wn5EiuqbUeLFtLtjqQ7BobvU+o9D2tg3SPGM0qkb5lYWbxXfS9UeeJjQ2FW2Eh5sGVVhoJctg==;5:07oMA7C5vub7Ys4MBQK3xqDfCecg4+9wtA3D/7wypoEZEhEBkK0ICY+LNMQFXMZTJ2IGd1qnN9hJw05MkuWrxPWP+jCU9waxIR7yN+YWlcFs59cebNrYwvrxTLDLfMdeZJBWXENz3cPYRLs3ynkMgl6RcODXF1ZVfTQxKzCE32k=;24:VdxfV/fq9PxEI2cKqBBO0flPxKT+bcYXObrx/bQdRGVBdUKDIWtMXYxvpP8VIJNdeS2UfNs4DrlHHBVBIbgOAdxcPCO2+Q0ThKFAOQznx6Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0121;7:joViVL1tHh00alJfLiA742mzdqsoqpLkpdHcHs32gKEMmOghNhQjYhsgiDs1WJJqApIJ7PGMivvvvGVYejeJR1PWoWhdc+35mjyrLnE+hFBX/a++eEqBR+LdhfDTcXsCdnC2k8SPEnsNWK3Ux6qBvZXzZiGKjLvECc87Pela7bS3dNKSNIH3E18CLDOjjOXFBMfItaOAdFFkH/Od9lavPnrM3mKY5eOGfF4a+SRFhWdL6iiuoHdocdFQZ4caFFAT;20:cyeB+8bpCiWgiOK0pYCbPW6LFlzCCyfCaAtc9wseNmiLsSnNzfBchg+1c3D+q2XJefT6FMrHpiKBxuXSo2PYjVJfZ2utC7Vy1mrNNjVk5PVUg7DLx1999yapbVBu9KyqcoMU75OtRLbMIQZ/Nnln5/ihmJAf2ZQUYNKNtIrSpU/lO6LqfO0X8eGzavc9eE8DR7sWnJI06Hhk20Jn/MqqtfV3AQnHne8xeKb5yD9LcdeV3Py1CfTdDiAKVrU6lCmX
X-MS-Office365-Filtering-Correlation-Id: b4be6037-6edd-4e21-dd24-08d5ab7498af
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 12:52:40.2916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4be6037-6edd-4e21-dd24-08d5ab7498af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/26/2018 08:34 AM, Andrey Grodzovsky wrote:
>
>
> On 04/25/2018 08:01 PM, Eric W. Biederman wrote:
>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>
>>> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>>>> On 04/25, Andrey Grodzovsky wrote:
>>>>> here (drm_sched_entity_fini) is also a bad idea, but we still want 
>>>>> to be
>>>>> able to exit immediately
>>>>> and not wait for GPU jobs completion when the reason for reaching 
>>>>> this code
>>>>> is because of KILL
>>>>> signal to the user process who opened the device file.
>>>> Can you hook f_op->flush method?
>>> But this one is called for each task releasing a reference to the 
>>> the file, so
>>> not sure I see how this solves the problem.
>> The big question is why do you need to wait during the final closing a
>> file?
>>
>> The wait can be terminated so the wait does not appear to be simply a
>> matter of correctness.
>
> Well, as I understand it, it just means that you don't want to 
> abruptly terminate GPU work in progress without a good
> reason (such as KILL signal). When we exit we are going to release 
> various resources GPU is still using so we either
> wait for it to complete or terminate the remaining jobs.

Looked more into code, some correction, drm_sched_entity_fini means the 
SW job queue itself is about to die, so we must
either wait for completion or terminate any outstanding jobs that are 
still in the SW queue. Anything which already in flight in HW
will still complete.

Andrey

>
> Andrey
>
>>
>> Eric
>
