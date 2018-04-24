Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754620AbeDXJN1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:13:27 -0400
Received: from mail-he1eur01on0050.outbound.protection.outlook.com ([104.47.0.50]:2104
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754462AbeDXJNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:13:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Wei Liu <wei.liu2@citrix.com>
Cc: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Artem Mygaiev <Artem_Mygaiev@epam.com>,
        Dongwon Kim <dongwon.kim@intel.com>, konrad.wilk@oracle.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        xen-devel@lists.xenproject.org, daniel.vetter@intel.com,
        ian.jackson@eu.citrix.com
References: <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
 <20180417205744.GA15930@downor-Z87X-UD5H>
 <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <20180420071914.GG31310@phenom.ffwll.local>
 <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
 <20180423115242.ywdwqblj2aseu3fr@citrix.com>
 <61105351-8896-072b-abf0-757c7f6c0edf@gmail.com>
 <ce2ebb5b-fa13-0475-b0fd-6c330277d151@oracle.com>
 <30ddb005-96c8-f47c-2e23-4e0d354e5842@gmail.com>
 <a25a394c-ecf8-d8cf-15b8-eb8cb71d0a02@suse.com>
 <c4c426eb-5a35-1f8f-59f3-350d6e97d89e@gmail.com>
 <6089d701-5221-75b4-38eb-b23bc5dc30cd@suse.com>
 <85fc8f82-6d4d-9343-2737-85b7d7391168@gmail.com>
 <0657bbb5-5cb7-4c63-5490-fbfc7dec1e59@suse.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <8ca35dbc-5beb-98ea-ce73-eeb388bb3e2c@epam.com>
Date: Tue, 24 Apr 2018 12:13:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0657bbb5-5cb7-4c63-5490-fbfc7dec1e59@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.52]
X-ClientProxiedBy: PR2P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::24)
 To AM4PR0301MB1940.eurprd03.prod.outlook.com (2603:10a6:200:38::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0301MB1940;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1940;3:MDQUXKFL0/b68Xu5ECVyCaMgR0hexPgqgCiMY1S/T7w57V/TBubbvOD4sdHm2RCgIkjgAYLBHGUlCaPmvxWWh1hV8v5pXK9mRI0/+n5ltU96PtaZXZFnhY4DQVxwb/ZniotLnvKz9K0XHmyg6SA/nE0/vOf0WbX2OCJLpxcS95TmGM3/EaZbou/XOYjnr3RjqkA4S1R1doQ4UxgpQvwEOg3F4rIJHd3FPXldLjvMyM0scZQfcVOhVfCtalmbLTZY;25:/E23k02EcvqyvwlpUPNtJUhUAfoOXiffNg/YorRDmmuYC21sNk6xjxeg8YtVBdU9Qm2de1NDrUaIOha4lryddsxChU+sDWvW8Pi3L2mhdUx7PnC11GJ9g1u4avcCQ1hAdqrO8IGS0e1jUXbGZfEDtZVuwsdQWU4YidVihgmisV4txeSiepThfY4ZLXRqNsmZ/8cKNeQ33wsCVmMy9pWOEmabplxs4ajFQrHDn+vSXkhJo9i2ifpU/Jc2E3GOlUBVXp4/GZ4oKGH6q57J4lMwK9yzfe/eXYLApC7nbcAuXF/LiavDWuazme3Op8wGX3aGn8ZcYPyM6T5G1Ft18p4jcw==;31:uptGT792YoAEYmD3kUB//VDb1Tu/ERsZt4zQVt+1TuBTE5D8tWLRCd3ZxXC0crL0M5Kn6EyxZ3hX4mWISYbnDUWUGZLiAomRpYopDjGc4WtJVUqYdnSbw0zWn3FjDXUuV8Uvkb32cy6UR4QahhpZWAOFdwhz6hB7/JTeOZgRHiI8ut7NvWXQaD28tSrT6qyJY7nwZiU5xu1osHMLWTdjjYTXnHkM3BBsrX0AW99S53E=
X-MS-TrafficTypeDiagnostic: AM4PR0301MB1940:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1940;20:tWe8brjZrjiCmJxE/Ofps8pC9/i6stnutiUvpt3vG3BDmGix5Xq5/v7sFEDUOcQFibKh+U+qTLYGFg8gLYgTEk1yy422w+4Dmi9ouYOfU76aXqQTpeCz+fYZBVR89E2ShVxZXxrShaz3YHcrHCJetW018L6BapiYCkLjNXMMKU9s9WV8DHujbiCHzcXr0YIlexEg2iYOJUjttk1h2nkaHHWWLbj8EoprU0jidEy/gpBse46t4J/SX2u9Y1LJprrhWJ51SBeP/BXwd23NkD5w2AtQUa0yzB+obBVMGpsi/vxCAI5ngm2SXo3ymRFJY5azdZ/w73nudyfLYFPifpTGVQhZwfMx1Iht4G9DC9aGQEtPmmSw2F/z9kZYQWiCVHMbhsK01Z5yrcUg6Km8h92XU0AkiNwRoPw7ZgRyBPLJ43IGhv4DQY59teBx3wpIQzrDqUnKhBRNo+czvWLmbCqrw0qPwmehA27bVTEa42N5AoHAEE4TqY0ZLRNBsA9/bWFr;4:qCTQS+P1eVOmnT/SIGI6gH9kDS065OtM2nnw2GigDiflT7rwseVeud8eyn1eDzh6sm6qJybMTfxPZ0Ii4bs95jRwobNUioQiCpC9IKuXQoAufYsKwaM/wBSmZcj3+uzaS1qcB2DmguR5810TK9CjdRIv+YXHOCHgLAQyYwLIUkVNJObId9D9EW1YzFUpN4EMZiqAcMBdqaBohT+QIkZLkqUi6nXfT1lPZ5B3qlq9UxRephQVCzroiY3/lfCE9wjB5ZuuQAyVSW26aNOE10bOog==
X-Microsoft-Antispam-PRVS: <AM4PR0301MB194018F43C2949E17682D556E7880@AM4PR0301MB1940.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR0301MB1940;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0301MB1940;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(376002)(39380400002)(39860400002)(366004)(16576012)(2616005)(5660300001)(7736002)(54906003)(11346002)(58126008)(446003)(316002)(8936002)(36756003)(6486002)(956004)(110136005)(31696002)(476003)(8666007)(4326008)(229853002)(53936002)(67846002)(305945005)(6246003)(39060400002)(72206003)(59450400001)(65826007)(26005)(77096007)(55236004)(53546011)(186003)(31686004)(93886005)(50466002)(2906002)(81166006)(86362001)(2870700001)(386003)(47776003)(76176011)(25786009)(16526019)(65956001)(478600001)(2486003)(6666003)(64126003)(52146003)(3846002)(6116002)(52116002)(80792005)(65806001)(7416002)(23676004)(66066001)(8676002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0301MB1940;H:[10.17.182.9];FPR:;SPF:None;LANG:en;MLV:ovr;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAzMDFNQjE5NDA7MjM6TUJmNzNUYzRER3NBdjNxZS9rQ0Jaa2hE?=
 =?utf-8?B?Qno5MjI1KzRSOWRPT2RtbFRjbFJkMWNEYjVsaG9DOE5paEg0ZjVTUVg3R2hI?=
 =?utf-8?B?dGlaRmNXM0VLNXVUWmxPQWk1K0VwVzlxYjg5RkpjRXQ3QUl5U051TzNRNjNK?=
 =?utf-8?B?c2VnY0JYWjRsdEhpckgvN0pHbXpiaGhEemVSbW1UTHBEUlBBZDZlL3A3eUdF?=
 =?utf-8?B?OTJ1SUlWTzVYTERqOFNpZ1dFd0tWUTdGUnNwalRDZkI5ZDBWRFJ1dlFyN0s5?=
 =?utf-8?B?TFlTeU9VS2pIOVRKKzdzSTRJKy91NTlWWGRPVHJubkNHcE41MHFsT0RHaXMr?=
 =?utf-8?B?QXVWNXAzZHcycXR5YmEvencvbzZOUXR2WnZDcTJCZkFzR3k3d09WVTBXMlpw?=
 =?utf-8?B?dDAyOURUZ2NHK1diOUovWjlaR0R1UWk1bXFtZjJ5ejNIRWY0ZStCTCtuN3Fv?=
 =?utf-8?B?YnVTWFR4VHJaVXUxTTh2cjRKSGVzcjcwMzRKWHBDTFZlUDF4eGJPK1N1VElx?=
 =?utf-8?B?YUQ0V0VoQnpMdXNzL0dUTEhtTDhkKzRyenJNYTg0d2hleS9tY2xXSnJyZnhi?=
 =?utf-8?B?WU8yMm1pVDFNUEZkcURramdTN2Z0QTRNbGFGenNGV29laGtRV3ZtWGpxeWdi?=
 =?utf-8?B?M1d0VWtrR2FzUHl1aHJ5djV6YTZvYmpVdVg4dG5oelhyZ0pDS3lpVnAydU9o?=
 =?utf-8?B?WXFRTzZjVGhqOWI0cjhGVXJxempwV3p3aU5aZldmR21uOThxTFF0NHorejhO?=
 =?utf-8?B?TS9rK0M3MmFrSVdZWUtvZ0gzeHBIQXVHUXlVRFBMcC9WbXQrT212eE5za2ZV?=
 =?utf-8?B?RWlDODJtbk9SUnRTQWd1R3Vjb0lOKzRZZWtkbkJhL2gveWR5ZFdvRW4vQXBE?=
 =?utf-8?B?WmpseE4zclBLL1dUaWVHZ1JaZmhxK0pMRGtsK1JIbkFIQ1o3MUZ0d2NUbmtH?=
 =?utf-8?B?UDB5SDlGYlE3cmp4TXA0d2dOUXlGQlk1clJnTE9XRzl4MWk2OTVnQjEzQVJz?=
 =?utf-8?B?U3RuVEdDVWpWQjJjblV5R1c0OStMb2lWQ1MrNVRnelFOOHNrbC9Bb25VRjNR?=
 =?utf-8?B?aUJ4RUVkbEpaazJQaW5JdGx1d3ZhK0pXbURvenFCM1dESHZML29QYU9YVnpE?=
 =?utf-8?B?eExLRzJheEMwcVh4aWg2SVBMR3VpaGpMYUdvSFBMYURNNkdLR3lFTk9UVmto?=
 =?utf-8?B?QWlKenE0Z0Z1QklSYUlyNzVZL2NpNzBVYXhPaE8vNGVjcVd2MkV1VWRDOHJW?=
 =?utf-8?B?VmdzZkJnY2o2dVdWczFxazc2amRyVWpDUlIxa3dDVG5CcHdwK1RDa1RDMFg3?=
 =?utf-8?B?MldXNjV4bXNaWUJVblJsREY2M1JMOWduZ2Y2eXNpSWc5eFRVSS84VURqMWND?=
 =?utf-8?B?K0JIS1V2NUdDYzdLUDZZaDVrRWhyUG9oWDVjYThPSEVsTjBiYkg5T05pNFZi?=
 =?utf-8?B?SEsvWEVmM0ErUEU1QVFkdWs2a3ErbUdqZkhrWXJVci9NZDFhNk9DMmtBaHJR?=
 =?utf-8?B?a2sxeEpKL0Y0aGdwZGd4cWxNUnkxVjl0eERUTUg5RmVObWNFM3JVRGg4dHNS?=
 =?utf-8?B?VVF3U0p6OC85Y2gwb1dwdUoycHIrWGFDNnV6cDJDdkhHNHp3Tzlhc2tJSWor?=
 =?utf-8?B?WWRkb2FVVi8xeC8wb1BFaHRRN1JwUWpWRGNSYXl2MndVUHZrV2s3QUQzOXN3?=
 =?utf-8?B?YXlTdXhIbUQrVXRkTDhQb3dUcENsaTJ1aWlsUXF2TGQ3TjZoVlQrOG5SNUtK?=
 =?utf-8?B?MWs1VXBWZzJlK0taTjJLN2k4N2ZJQjNnNER6UUNjNVAyYU1uak9BVlB2SCtL?=
 =?utf-8?B?OHdGS0tqV0lxT1dFVm4wSTI5RGk4dHFEOHExb3JiOHB3NTFuMGhZYnRsZ0Q5?=
 =?utf-8?B?cUpyTThWZytEV3FOenV1NmZXR3dGckVVVEc5MUZNcTVDczNFT3pVS1VvTGR5?=
 =?utf-8?B?Rm5MelZYNVV2enZTNmdiYkswU2dNSHV3TCsrZGFlRHJTSWhTd1lST1RPb3lV?=
 =?utf-8?B?RGxSakRzTkVhVWVqTTVyNkVINDdsd2tBUnhqS1hLYmJVNmJsZDNkQmY1SURm?=
 =?utf-8?Q?JhYtyo=3D?=
X-Microsoft-Antispam-Message-Info: x0QT+fVYldC7cCjVgT+AFMXbmYVB4LHnd081PVKKO6L043wrT0fthUssvBUWM0IAi6zjj75mW4PSWxZughVnBU4EknO9zyNOJUiRd71AMlVUayHAlYUr1GpqMTKhz/mVMntiHSJ3LlXYkI1srlz3RezXzeMfZPoaV2W4RZZkcEVBoBNVi0Kc/qAMAueiRALg
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1940;6:LwfkxVQOuucQlBH79kXX4ukGiEIXgwXn58EodsPxlcAf8MUyWBPctcVq9dF8Q+oWrUpl/hAahGLehovBMxSrfT+JZSvEe9EDU7QNhxrOM3raq7Xvtt82InqkB/ZPCYx2xtY+5jg7E97y4GN+b97EfrD+h2Fx86YjjmpGTklP3Vz54rm2ZYu2jCMj0UJ6gpsFE9xiEh0/EgeArb3SXUjIzd8PgJC0nN6zj+0dcmzVqgGhh3Jll+gc/hW5vK64QOj9+p4HqpqjeXFlpUqfJly9fA9ld2u2nVNUyCjpY0rFClEGCvwiA3Eqi6WpvD4CZT29anavLL5vWDyR+LLlpXIY1ojKXvY8rc1cRw7aPyEFq5I1Qvus7i4s1Jz8zwsQP43Ggnf1uF4gT3NzNzAq1kExgsyxIeQfKCxuZ3y+e9Cr4qQSUwG0dONBZvwOsP8KU6jsrO6B9IpXIaFKc6PEXnXpcw==;5:3TyIByZgMG5Z32qZc+twc0rhgWcGZ2LMBkbs2rAFmApiUaJTxq2cmf7+ukI0d3uKwAy71UCSU7TbG1ixXeeqHZdwCTo6j8IigS1l7mtfeUB44oF4/KzXdRlnqp2fK0QCWHhcZHdMKVu9lRwt1caVa8miJxIozfzf6NKE7m4G1Qk=;24:lxDlf8zJ7aidGMiUBxnyC9QAdmH+G58CSVhSCEZr3nRK/Q1CUmFGgTfFT20tKg+j+FvSgrIU/8V9yy6DJYHsStqwGuxomFXDhk9QIVwdGUE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1940;7:ZGwE3dJLItpEpekf7kZtkuSsJAZrIrU5uRungW49P6n8R9Yrmk+yNSpWhqzN6QS/UC6E/+2juO3xg11u4+FxrBIMMeByzM6r069ExPr3gG10XZycvLk2O6jDl1C3fSE9/FwxxvTd/M9zIuAT9F/Ll2AQ4i935cl38cAe+zkKyST4buNjpRZp71cxqbkW89/KJEfPohSHlqsTsej0as9Eqvu+t/RpWjmC7QBIg3+/7AFuxuoR0HrrJdJnr8HcYUTA
X-MS-Office365-Filtering-Correlation-Id: cc3af158-2256-4801-900d-08d5a9c39e6d
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 09:13:17.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3af158-2256-4801-900d-08d5a9c39e6d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0301MB1940
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 12:08 PM, Juergen Gross wrote:
> On 24/04/18 11:03, Oleksandr Andrushchenko wrote:
>> On 04/24/2018 11:40 AM, Juergen Gross wrote:
>>> On 24/04/18 10:07, Oleksandr Andrushchenko wrote:
>>>> On 04/24/2018 10:51 AM, Juergen Gross wrote:
>>>>> On 24/04/18 07:43, Oleksandr Andrushchenko wrote:
>>>>>> On 04/24/2018 01:41 AM, Boris Ostrovsky wrote:
>>>>>>> On 04/23/2018 08:10 AM, Oleksandr Andrushchenko wrote:
>>>>>>>> On 04/23/2018 02:52 PM, Wei Liu wrote:
>>>>>>>>> On Fri, Apr 20, 2018 at 02:25:20PM +0300, Oleksandr Andrushchenko
>>>>>>>>> wrote:
>>>>>>>>>>>>          the gntdev.
>>>>>>>>>>>>
>>>>>>>>>>>> I think this is generic enough that it could be implemented by a
>>>>>>>>>>>> device not tied to Xen. AFAICT the hyper_dma guys also wanted
>>>>>>>>>>>> something similar to this.
>>>>>>>>>>> You can't just wrap random userspace memory into a dma-buf. We've
>>>>>>>>>>> just had
>>>>>>>>>>> this discussion with kvm/qemu folks, who proposed just that, and
>>>>>>>>>>> after a
>>>>>>>>>>> bit of discussion they'll now try to have a driver which just
>>>>>>>>>>> wraps a
>>>>>>>>>>> memfd into a dma-buf.
>>>>>>>>>> So, we have to decide either we introduce a new driver
>>>>>>>>>> (say, under drivers/xen/xen-dma-buf) or extend the existing
>>>>>>>>>> gntdev/balloon to support dma-buf use-cases.
>>>>>>>>>>
>>>>>>>>>> Can anybody from Xen community express their preference here?
>>>>>>>>>>
>>>>>>>>> Oleksandr talked to me on IRC about this, he said a few IOCTLs
>>>>>>>>> need to
>>>>>>>>> be added to either existing drivers or a new driver.
>>>>>>>>>
>>>>>>>>> I went through this thread twice and skimmed through the relevant
>>>>>>>>> documents, but I couldn't see any obvious pros and cons for either
>>>>>>>>> approach. So I don't really have an opinion on this.
>>>>>>>>>
>>>>>>>>> But, assuming if implemented in existing drivers, those IOCTLs
>>>>>>>>> need to
>>>>>>>>> be added to different drivers, which means userspace program
>>>>>>>>> needs to
>>>>>>>>> write more code and get more handles, it would be slightly
>>>>>>>>> better to
>>>>>>>>> implement a new driver from that perspective.
>>>>>>>> If gntdev/balloon extension is still considered:
>>>>>>>>
>>>>>>>> All the IOCTLs will be in gntdev driver (in current xen-zcopy
>>>>>>>> terminology):
>>>>>>>>      - DRM_ICOTL_XEN_ZCOPY_DUMB_FROM_REFS
>>>>>>>>      - DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
>>>>>>>>      - DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE
>>>>>>>>
>>>>>>>> Balloon driver extension, which is needed for contiguous/DMA
>>>>>>>> buffers, will be to provide new *kernel API*, no UAPI is needed.
>>>>>>>>
>>>>>>> So I am obviously a bit late to this thread, but why do you need
>>>>>>> to add
>>>>>>> new ioctls to gntdev and balloon? Doesn't this driver manage to do
>>>>>>> what
>>>>>>> you want without any extensions?
>>>>>> 1. I only (may) need to add IOCTLs to gntdev
>>>>>> 2. balloon driver needs to be extended, so it can allocate
>>>>>> contiguous (DMA) memory, not IOCTLs/UAPI here, all lives
>>>>>> in the kernel.
>>>>>> 3. The reason I need to extend gnttab with new IOCTLs is to
>>>>>> provide new functionality to create a dma-buf from grant references
>>>>>> and to produce grant references for a dma-buf. This is what I have as
>>>>>> UAPI
>>>>>> description for xen-zcopy driver:
>>>>>>
>>>>>> 1. DRM_IOCTL_XEN_ZCOPY_DUMB_FROM_REFS
>>>>>> This will create a DRM dumb buffer from grant references provided
>>>>>> by the frontend. The intended usage is:
>>>>>>      - Frontend
>>>>>>        - creates a dumb/display buffer and allocates memory
>>>>>>        - grants foreign access to the buffer pages
>>>>>>        - passes granted references to the backend
>>>>>>      - Backend
>>>>>>        - issues DRM_XEN_ZCOPY_DUMB_FROM_REFS ioctl to map
>>>>>>          granted references and create a dumb buffer
>>>>>>        - requests handle to fd conversion via
>>>>>> DRM_IOCTL_PRIME_HANDLE_TO_FD
>>>>>>        - requests real HW driver/consumer to import the PRIME buffer
>>>>>> with
>>>>>>          DRM_IOCTL_PRIME_FD_TO_HANDLE
>>>>>>        - uses handle returned by the real HW driver
>>>>>>      - at the end:
>>>>>>        o closes real HW driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>        o closes zero-copy driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>        o closes file descriptor of the exported buffer
>>>>>>
>>>>>> 2. DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
>>>>>> This will grant references to a dumb/display buffer's memory
>>>>>> provided by
>>>>>> the
>>>>>> backend. The intended usage is:
>>>>>>      - Frontend
>>>>>>        - requests backend to allocate dumb/display buffer and grant
>>>>>> references
>>>>>>          to its pages
>>>>>>      - Backend
>>>>>>        - requests real HW driver to create a dumb with
>>>>>> DRM_IOCTL_MODE_CREATE_DUMB
>>>>>>        - requests handle to fd conversion via
>>>>>> DRM_IOCTL_PRIME_HANDLE_TO_FD
>>>>>>        - requests zero-copy driver to import the PRIME buffer with
>>>>>>          DRM_IOCTL_PRIME_FD_TO_HANDLE
>>>>>>        - issues DRM_XEN_ZCOPY_DUMB_TO_REFS ioctl to
>>>>>>          grant references to the buffer's memory.
>>>>>>        - passes grant references to the frontend
>>>>>>     - at the end:
>>>>>>        - closes zero-copy driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>        - closes real HW driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>        - closes file descriptor of the imported buffer
>>>>>>
>>>>>> 3. DRM_XEN_ZCOPY_DUMB_WAIT_FREE
>>>>>> This will block until the dumb buffer with the wait handle provided be
>>>>>> freed:
>>>>>> this is needed for synchronization between frontend and backend in
>>>>>> case
>>>>>> frontend provides grant references of the buffer via
>>>>>> DRM_XEN_ZCOPY_DUMB_FROM_REFS IOCTL and which must be released before
>>>>>> backend replies with XENDISPL_OP_DBUF_DESTROY response.
>>>>>> wait_handle must be the same value returned while calling
>>>>>> DRM_XEN_ZCOPY_DUMB_FROM_REFS IOCTL.
>>>>>>
>>>>>> So, as you can see the above functionality is not covered by the
>>>>>> existing UAPI
>>>>>> of the gntdev driver.
>>>>>> Now, if we change dumb -> dma-buf and remove DRM code (which is only a
>>>>>> wrapper
>>>>>> here on top of dma-buf) we get new driver for dma-buf for Xen.
>>>>>>
>>>>>> This is why I have 2 options here: either create a dedicated driver
>>>>>> for
>>>>>> this
>>>>>> (e.g. re-work xen-zcopy to be DRM independent and put it under
>>>>>> drivers/xen/xen-dma-buf, for example) or extend the existing gntdev
>>>>>> driver
>>>>>> with the above UAPI + make changes to the balloon driver to provide
>>>>>> kernel
>>>>>> API for DMA buffer allocations.
>>>>> Which user component would use the new ioctls?
>>>> It is currently used by the display backend [1] and will
>>>> probably be used by the hyper-dmabuf frontend/backend
>>>> (Dongwon from Intel can provide more info on this).
>>>>> I'm asking because I'm not very fond of adding more linux specific
>>>>> functions to libgnttab which are not related to a specific Xen version,
>>>>> but to a kernel version.
>>>> Hm, I was not thinking about this UAPI to be added to libgnttab.
>>>> It seems it can be used directly w/o wrappers in user-space
>>> Would this program use libgnttab in parallel?
>> In case of the display backend - yes, for shared rings,
>> extracting grefs from displif protocol it uses gntdev via
>> helper library [1]
>>>    If yes how would the two
>>> usage paths be combined (same applies to the separate driver, btw)? The
>>> gntdev driver manages resources per file descriptor and libgnttab is
>>> hiding the file descriptor it is using for a connection.
>> Ah, at the moment the UAPI was not used in parallel as there were
>> 2 drivers for that: gntdev + xen-zcopy with different UAPIs.
>> But now, if we extend gntdev with the new API then you are rigth:
>> either libgnttab needs to be extended or that new part of the
>> gntdev UAPI needs to be open-coded by the backend
>>>    Or would the
>>> user program use only the new driver for communicating with the gntdev
>>> driver? In this case it might be an option to extend the gntdev driver
>>> to present a new device (e.g. "gntdmadev") for that purpose.
>> No, it seems that libgnttab and this new driver's UAPI will be used
>> in parallel
>>>>> So doing this in a separate driver seems to be the better option in
>>>>> this regard.
>>>> Well, from maintenance POV it is easier for me to have it all in
>>>> a separate driver as all dma-buf related functionality will
>>>> reside at one place. This also means that no changes to existing
>>>> drivers will be needed (if it is ok to have ballooning in/out
>>>> code for DMA buffers (allocated with dma_alloc_xxx) not in the balloon
>>>> driver)
>>> I think in the end this really depends on how the complete solution
>>> will look like. gntdev is a special wrapper for the gnttab driver.
>>> In case the new dma-buf driver needs to use parts of gntdev I'd rather
>>> have a new driver above gnttab ("gntuser"?) used by gntdev and dma-buf.
>> The new driver doesn't use gntdev's existing API, but extends it,
>> e.g. by adding new ways to export/import grefs for a dma-buf and
>> manage dma-buf's kernel ops. Thus, gntdev, which already provides
>> UAPI, seems to be a good candidate for such an extension
> So this would mean you need a modification of libgnttab, right? This is
> something the Xen tools maintainers need to decide. In case they don't
> object extending the gntdev driver would be the natural thing to do.
Wei is already in the thread, adding Ian
>
> Juergen
