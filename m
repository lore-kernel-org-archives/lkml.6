Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967477AbeBNL2g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:28:36 -0500
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:7584
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967344AbeBNL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:28:33 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
To: Bjorn Helgaas <helgaas@kernel.org>,
        George Cherian <george.cherian@cavium.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <20180213150907.GD75542@bhelgaas-glaptop.roam.corp.google.com>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <dd104986-81e2-e7a2-353c-91827078bc4c@caviumnetworks.com>
Date: Wed, 14 Feb 2018 16:58:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180213150907.GD75542@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BMXPR01CA0010.INDPRD01.PROD.OUTLOOK.COM (10.174.214.148) To
 SN1PR07MB2333.namprd07.prod.outlook.com (10.169.127.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b4dcec2-df2e-4c16-bea0-08d5739e12cc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:SN1PR07MB2333;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2333;3:bZYyZiaVSMp2QRL5twfSAnKr/yLnjwF49eta4guFO81DCUGO9qFdbgZnbSI/YQiRHiI2N05xo9IXvO+FsLRmaKRXPkG1By6rmJjvO1alP8Qj5vpxCEGczSyjSuE2aAIer8d5kR8iaVeyG/wLKFtWlBTUTBqv1Uq0z1LIZlRkFuQavwxfo5WhtOqpDv1GxEtQgXfoy8fOKecEHoR8MO+bzEhJwbsHWe+SFIRGhxZ3bYIiZ3huktmc+jfs4FAvqB40;25:BoDzLmeaBIG9b1wTS9Nw1VkSVC2JCC4GvwOsLI3/9lw08eACTQ3JpX4HBI306it1BbLingtcv1DRt90bFZiTIBerWpq+VWzT/asdiIuXyS5t6wmNvHGLA4xmjyQ1vxY2bGyunZC4csiIEpO3IP/14R0OZ3cxeGGAhjV+TG2rHiacHMs4FpMFIXnSlDj3rhTOQCfB8sowENMEN/iDyRUzIsdFdyQAuMEjcBTB755yrnKyBhHxv4oMzqZHVmvoVerIrLxBkAFmrMtC2irrKqx7UpD9m6V9R9mIG7nGuW66t6TawFxnZ4c6KoQ0b3ulsT2MQBs1I8jIM8LCtZzXqKDc5A==;31:0BtcfqSy7iQaAKnW6qc615ZyoaKP2oEj5uQhcCgO/9WQsAC+eeDJs2d/szF1sB5qop0qQmbysgShNt7K3pDlMsjIfqD8Ep+LLI+HhfMbipVmBeu5iYByluBp2cLNYLl9RIlF/iWqYKjXAR7oIg0crKxCgCEFdIU0SvYzm8KiYVApaPKHs0auz5A1byrUepGchrrcyv4iK0bP5p1Ww81xmTo2aRXyZv0D++UvZxmvX9M=
X-MS-TrafficTypeDiagnostic: SN1PR07MB2333:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2333;20:yGxtOyN32RHQXi7gukHc/sPCfao68X3pJukpTDJa0DoaRayR+SDtxpW/uL045Gei8Htw62kKWg8clOVuahUco5qb7SB+6Xtg2lcQNKhh3bnatokZy3i/tn7DUaj0PUatj0+DBSfyD/snkPR2KAD6nkl58dNC4WOf7l8JorPFYhSfextyIXDnaPiIjsed8xuc/+3xaGqkX0OXyaDXK7RvknLtMbVgk0Ky0KGs/BA4PXL36ah8BXBaU+hAjwl5jW4E2zQI8+x4DaKrmd1dc5y+mEv2+mUpj9O5XXZKs5AZ9HtEEOa1l9k3+ERss6hS0kJzDHdU1xopC5Hh3mNbn+HeSY1+2WA4u74zRGaATrhizPhVgEymTNcXJNU3lbPO27uq+zO5YE79CvGi+ual+v+6C2PozBfVcyVF+MAnlIeI4V2lCyaPH2QfxdCag9hueckG4yEFYN5CtqVUfFUTxZ6gVgcKmeU9BRHlF8qPISHCSAiJWJHUGuohWEWWR0jV+eJsCI66B2nrnzYpNzradq4iRA0AkscW+STanL7UNhDHxOWtfWM0gDucRVR851sKII1ZIzVsTlAzWlj7I0DCPkrRfWqTo3eV6Mv36vCuYV8iCLk=;4:QIjbOT/fhhjpn2k97QmcIyT07CTP4p4hvSfZ1SIyy8C5l6KF0lfTNyLMOMN29oWkoCqLAPNACX8vqyfhHfIAVvaWB1oNzC0NwvQ3v1fMiHjMpD+aA07jpAcisiakIt8+LbWusisSi3CnAATI8yzjsN+55z8LmRK9wXxVsCRnJVGNiESALmiMnbjTktqLMOy/QOlsilNYI/2Z/x4ufHNBR5NJp1iyFUamR8ctSVimbOe6JHXxP6Rd1Kwf4V15CeEnnsmbHnL5qqehnCod16d94g==
X-Microsoft-Antispam-PRVS: <SN1PR07MB2333F87A80A6B5044389F2C6F9F50@SN1PR07MB2333.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231101)(944501161)(10201501046)(93006095)(6041288)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR07MB2333;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2333;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(396003)(366004)(376002)(39860400002)(51914003)(199004)(189003)(68736007)(3846002)(72206003)(36756003)(58126008)(110136005)(76176011)(65806001)(6116002)(478600001)(105586002)(316002)(229853002)(6246003)(16576012)(386003)(50466002)(59450400001)(25786009)(16526019)(186003)(53546011)(305945005)(64126003)(4326008)(106356001)(53936002)(26005)(31696002)(77096007)(2950100002)(42882006)(8936002)(7736002)(6666003)(65826007)(83506002)(90366009)(2906002)(97736004)(230700001)(52116002)(6486002)(81156014)(81166006)(5660300001)(67846002)(45080400002)(65956001)(66066001)(5009440100003)(23676004)(52146003)(31686004)(8676002)(47776003)(575784001)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2333;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjA3TUIyMzMzOzIzOjd5WFMwcllCWUsrRjF3b3UwREdFV3Y2clJV?=
 =?utf-8?B?NmpxaDN3QVJRT0EreU9OM2tvZ1JhV0plNDhuNGZoOEUyRzJDejlrY3lDYSsr?=
 =?utf-8?B?UjFCZnpjYWVEVE1IMEJQZnQrUE83WXdHVlhIeUtOSXlBcVZVajZlMlh4Ky93?=
 =?utf-8?B?Zk5QdEZyMmJiNmVTTEZjVThRVTh5cFRNZ3l1SzFTaWNmMGtDeTBWckIxenBD?=
 =?utf-8?B?VTRoaThmcFNTWGJ6VkxDOUVBSVdRS29LcW5WYnFTcEwvMXB4bjZxTElhSThx?=
 =?utf-8?B?N3Y3dTRVa1N2bkVZSmswNStuVm1UMlNxWkZNc3ZOV1FYcGthZVYzOGhMcXp4?=
 =?utf-8?B?VitOcmNOYzBneVlpb3NkcTMwdzFMV2JSRDZrMWUxenFsVFR2SjVnL2QzZmpU?=
 =?utf-8?B?NDJWaVp0OWRGSG92T21EZldNd3dkMmNuVHZhSWROSk9oOHF2ZnVDWEpybWYr?=
 =?utf-8?B?ZkZhMTBQR0U4d25mUTZ4cmNmc1p6Uzl2TTVqL3hpWFRKRHEyaVhWMTVORnpZ?=
 =?utf-8?B?ejNzZEFwWmcxdTYvQTBRRC9lN3g2S1oybTFiZ3VzUEpiZHlmc3NVOXJKQ3p0?=
 =?utf-8?B?NU9FMGdDd2F1OURCYjFuZGZLYThxQ3Z2Y2FlTW1QbnVYNzBIeDBEK3BEM0Zs?=
 =?utf-8?B?ZERJa0p2dDVjYTV2b3pYSHVCM2tLY0tEdWRaZEhTUG52SGJPZVJucDh3cWVT?=
 =?utf-8?B?UEJUR3pLZXFLU2xtY1hBMkJPY0FyTUtieEYrRmR4VmFKVGw0bWNMd2gzNjV2?=
 =?utf-8?B?dnNJbE9YcnZGb21TNm8wWFlnbzlzb21OUkhQckVHR3BYOXA4ZFRPU2Vwc3BV?=
 =?utf-8?B?RFJwd0txNzh4Q2lzVnY5SW4yekJYTzZMRFlpTEhKNnJURnMrblcxN0gyVmli?=
 =?utf-8?B?cVNOVkYxODNuU1cvOFFYcXFXMDRucHJMbjl1ajRLOUV2aDY3OEpkUUkvVFlG?=
 =?utf-8?B?L1doNmFGT1kwUyt1UnpwQm91d05xcnh2Vk5zS0taTzVQVWVUTm4wZ3FFaFFK?=
 =?utf-8?B?VTdjdkpBcXN5TEFDSkxGVnIwVEEwS1daeHIrSThUMmdLTXhRc1lsRUUrRnAz?=
 =?utf-8?B?UDZNc2VsZkF2KzU0WmJOMi9GSk1uWUxNTHhldGx2UG9vemtjYXcxMWU0QjBo?=
 =?utf-8?B?aitqQzBveWcvY0ozV2ZuQkFrVGtac3JvZ2dFanBxMmUxYmF0emJydGkvNkVH?=
 =?utf-8?B?TzNLYUVka0tMREVRcnVrNXlCWGJkeVcxWEJBMlJpYkU2bHNuNU9qQ0pQbVEy?=
 =?utf-8?B?VlZlUHBCTDZEWUpERkJmYzN3Qlpab3Y3aXA0UDA2WEFtNndxZUJzYzBaTDRI?=
 =?utf-8?B?TFZCSThOOXFZd3NjcUJBMFdxbUFjNFFrZ0puTkZ6N1k2MWVhRGNYUndXMGRu?=
 =?utf-8?B?cmFlaFAyWmlleVhMU09scVRNQzA4N3BLU2lYeHJVUlRaU0tPQXB1Zmwrb1F0?=
 =?utf-8?B?dlhtZ0JwaWNRcFVJQUlOZy9tdjIwa3EvanRyc1djMjNtdk16V1pwUjQvZzFB?=
 =?utf-8?B?SzYvY2VXTUFvRXYvUjhueTM3ekhHWS94NzJIakpGWUVCaDN6T0V3MVRhMzFB?=
 =?utf-8?B?ZFNBdm95WGdJQ0hhT3owWEF1Um5NUGovVmh3cHFsVVF1MFpvTE9vUWM3MmhV?=
 =?utf-8?B?WVZoV3g5T1hxY3lKMWxna28yTytPZFc3TndLYzZFc2dsZmV0TWlMRGtWcW80?=
 =?utf-8?B?VjlBYTNlUElqeGNySzVNTm5UK25BVy9MTVpTWWFmeGpVRXpXazlUQjgySmgx?=
 =?utf-8?B?T0ppTnZmaDRQR1pOL3VqMGR0OEU0UzB5RzdoVU9JZzhNaS9hckFJb1h5Z3dT?=
 =?utf-8?B?UlhPL1ZyMlNwOTlMYTA5SnNhV05CRW9iK3dVYk9MRXNCZ2ZvK2ovZkdjMko4?=
 =?utf-8?B?aFMvd1cwcG0vWWJPRlltK0ppTnpPTkJNV2JnVU9sV0ZyVmh4ZzJ3Y2E3TnAy?=
 =?utf-8?B?WHdaVUVkS0dVc050RmsraWRnMjVGUDJrZGpCRzBNN3p6Z2d0Y1hWc0thaGJz?=
 =?utf-8?B?Z3dHU0hoclE4RnhEc0lha3YyamFpOTdqSkczRkNaOGl2LzN4Y2JIQ3NkbGR1?=
 =?utf-8?B?TmlsOWxwN1p2bjY1bWYzQ2hBZ0lobEdPY2dmUzk1T2wyaHp6aE9GQ25ueTdy?=
 =?utf-8?B?VFE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2333;6:8foxfCRYYkuZGDGaRc4pZD4XSa8g3QlgjOaVGYc13HmPITSSerCyD3C3Xeu0h9ODVW+0YoVWQyxW+j6oImMan9BTtQfWq66N4VPiaZMcDxt/8+SC6vA+ls1Ym+vNJsL0sAvEPSfmTInUf8SYVQjz5uI2J/zzBiPHUjKs1U4EKj4NJ6h8I+/kF4OJ9cZzOARNfWEIUBgmczpu+jNOy69uyETHiPmtMHM2RthoeTIPKOjjRnu9jc35KLZO62+/7UhAidIkvNrCN3kKbHfuSc5HfCqVkfqA8gFBIpjSpd23MhB0rG4ZeWEYqqv/ADmHdAGiE1VOPxoskX5ALgQZfA18XIsXJ6AKZTKf0ALRPDXm6Ck=;5:DuTB5BbJL3HXO3o6GCujguuTuu2wYiDCgY2aSFZ9uGNLNbVr8pzNEBmXHhv6lUOY4x/is5prDUwi0fZKiB+uO5zuXJs/0UPaq3FGGTaYd62D9BGuSB/Heyhom5dI53Pqo2yhX/IxWWenUALfrP2BMj/IGoABHLOVl/MTIRUzMrE=;24:+KaTEZ5n10Z6Kw9gsnbiB3lRP8/xIuUbATNEy5iIuoeOrIHm9kUYGO46IuYcxJaJcr4GcWo6+MmFRuRH9XvdnQM0R77ilXjw5fz04VQzzxs=;7:3IVYyAF1NQNgLdTI23BQWsvgAek9wK88RjztVcFyuydbbrtrDTjKqSPvVKe5nrg3m8YX3X0u3zCFgAynHmnGNP8m9rU60hBzOWJ6OmUgQ2/VomxhLt1+Re+RNtB+z5TwKVFfP1Nmwk0S5Pi2Frs9FSbFMHAuUw+D9nypz7LEZUKdtJ3jCdIIQyk/Acm3T1gLYiwxetkn2mjV9ZB/BAUAdmWugWXee6//5znr6QYCulPhag3yBgJ+aSXvcO/na8pF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 11:28:27.2727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4dcec2-df2e-4c16-bea0-08d5739e12cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2333
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for the review.

On 02/13/2018 08:39 PM, Bjorn Helgaas wrote:
> [+cc Lorenzo]
> 
> On Fri, Feb 02, 2018 at 07:00:46AM +0000, George Cherian wrote:
>> The PCIe Controller on Cavium ThunderX2 processors does not
>> respond to downstream CFG/ECFG cycles when root port is
>> in power management D3-hot state.
> 
> I think you're talking about the CPU initiating a config cycle to
> a device below the root port, right?
Yes
> 
> This erratum isn't published anywhere where we could include a URL,
> is it?
This erratum is available at support.cavium.com, You might need to 
register to the website to get hold of a copy.
> 
>> In our tests the above mentioned errata causes the following crash when
>> the downstream endpoint config space is accessed, while root port is in
>> D3 state.
>>
>> [   12.775202] Unhandled fault: synchronous external abort (0x96000610) at 0x0000000000000000
> 
> This looks like another example of not being able to deal with error
> responses to PCIe events, for example, the whole mess with drivers
> checking whether the link is up before issuing a config access.
> 
> In that sense, this looks like a band-aid that avoids the issue by
> preventing the use of D3, but doesn't fix the underlying problem.  If
> we *could* deal nicely with this error, maybe we could use D3 on these
> root ports.
> 
> So I'm not convinced yet that this is actually a PCIe erratum.  Does
> the hardware actually violate the PCIe spec, or is this just a problem
> with the kernel not knowing how to deal nicely with a PCIe error?
> 
This is not an issue with the way kernel handles the PCIe error.

> If you could include the erratum text and reference to the relevant
> section of the PCIe spec, that would be useful.
>
The relevant section of the PCIe Spec is the following Section 5.3 on 
wards (subsection  5.3.1.4.1)

Configuration and Message requests are the only TLPs accepted by a 
Function in the D3hot state. All other received Requests must be handled 
as Unsupported Requests, and all received Completions may optionally be 
handled as Unexpected Completions.

>> [   12.783453] Internal error: : 96000610 [#1] SMP
>> [   12.787971] Modules linked in: aes_neon_blk ablk_helper cryptd
>> [   12.793799] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-32-generic #34
>> [   12.800659] Hardware name: Cavium Inc. Unknown/Unknown, BIOS 1.0 01/01/2018
>> [   12.807607] task: ffff808f346b8d80 task.stack: ffff808f346b4000
>> [   12.813518] PC is at pci_generic_config_read+0x5c/0xf0
>> [   12.818643] LR is at pci_generic_config_read+0x48/0xf0
>> [   12.823767] pc : [<ffff000008506f34>] lr : [<ffff000008506f20>] pstate: 204000c9
>> [   12.831148] sp : ffff808f346b7bf0
>> [   12.834449] x29: ffff808f346b7bf0 x28: ffff000008e2b848
>> [   12.839750] x27: ffff000008dc3070 x26: ffff000008d516c0
>> [   12.845050] x25: 0000000000000040 x24: ffff00000937a480
>> [   12.850351] x23: 000000000000006c x22: 0000000000000000
>> [   12.855651] x21: ffff808f346b7c84 x20: 0000000000000004
>> [   12.860951] x19: ffff808f31076000 x18: 0000000000000000
>> [   12.866251] x17: 000000001b3613e6 x16: 000000007f330457
>> [   12.871551] x15: 0000000067268ad7 x14: 000000005c6254ac
>> [   12.876851] x13: 00000000f1e100cb x12: 0000000000000030
>> [   12.882151] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
>> [   12.887452] x9 : ff656d6e626d686f x8 : 7f7f7f7f7f7f7f7f
>> [   12.892752] x7 : ffff808f310da108 x6 : 0000000000000000
>> [   12.898052] x5 : 0000000000000003 x4 : ffff808f3107a800
>> [   12.903352] x3 : 000000000030006c x2 : 0000000000000014
>> [   12.908652] x1 : ffff000020000000 x0 : ffff00002030006c
>> [   12.913952]
>> [   12.915431] Process swapper/0 (pid: 1, stack limit = 0xffff808f346b4020)
>> [   12.922118] Stack: (0xffff808f346b7bf0 to 0xffff808f346b8000)
>> [   12.927850] 7be0:                                   ffff808f346b7c30 ffff000008506e2c
>> [   12.935665] 7c00: ffff000009185000 000000000000006c ffff808f31076000 ffff808f346b7d14
>> [   12.943481] 7c20: 0000000000000000 ffff000008309488 ffff808f346b7c90 ffff0000085089f4
>> [   12.951296] 7c40: 0000000000000004 ffff808f310d4000 0000000000000000 ffff808f346b7d14
>> [   12.959111] 7c60: 0000000000000068 ffff000008dc3078 ffff000008d604c8 ffff0000085089d8
>> [   12.966927] 7c80: 0000000000000004 000000000004080b ffff808f346b7cd0 ffff000008513d28
>> [   12.974742] 7ca0: ffff000009185000 00000000ffffffe7 0000000000000001 ffff808f310d4000
>> [   12.982557] 7cc0: ffff0000092ae000 ffff808f310d4000 ffff808f346b7d20 ffff0000085142d4
>> [   12.990372] 7ce0: ffff808f310d4000 ffff808f310d4000 ffff000009214000 ffff808f310d40b0
>> [   12.998188] 7d00: ffff0000092ae000 ffff808f310d40b0 00000000092ae000 000000000004080b
>> [   13.006003] 7d20: ffff808f346b7d40 ffff000008518754 0000000000000000 ffff808f310d4000
>> [   13.013818] 7d40: ffff808f346b7d80 ffff000008d9a974 0000000000000000 ffff808f310d4000
>> [   13.021634] 7d60: ffff000008d9a93c 0000000000000000 ffff0000092ae000 000000000004080b
>> [   13.029449] 7d80: ffff808f346b7da0 ffff000008083b4c ffff000009185000 ffff808f346b4000
>> [   13.037264] 7da0: ffff808f346b7e30 ffff000008d60dfc 00000000000000f5 ffff000009185000
>> [   13.045079] 7dc0: ffff0000092ae000 0000000000000007 ffff0000092ae000 ffff000008dc3078
>> [   13.052895] 7de0: ffff000008d604c8 ffff000008d51600 ffff000008dc3070 ffff000008e2b720
>> [   13.060710] 7e00: ffff0000091a68d8 ffff000008c09678 0000000000000000 0000000700000007
>> [   13.068526] 7e20: 0000000000000000 000000000004080b ffff808f346b7ea0 ffff000008980d90
>> [   13.076342] 7e40: ffff000008980d78 0000000000000000 0000000000000000 0000000000000000
>> [   13.084157] 7e60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.091972] 7e80: 0000000000000000 0000000000000000 0000000000000000 000000000004080b
>> [   13.099788] 7ea0: 0000000000000000 ffff000008083690 ffff000008980d78 0000000000000000
>> [   13.107603] 7ec0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.115418] 7ee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.123233] 7f00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.131048] 7f20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.138864] 7f40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.146679] 7f60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.154494] 7f80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.162309] 7fa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.170125] 7fc0: 0000000000000000 0000000000000005 0000000000000000 0000000000000000
>> [   13.177940] 7fe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.185755] Call trace:
>> [   13.188190] Exception stack(0xffff808f346b7a00 to 0xffff808f346b7b30)
>> [   13.194616] 7a00: ffff808f31076000 0001000000000000 ffff808f346b7bf0 ffff000008506f34
>> [   13.202432] 7a20: 00000000204000c9 0000000000000003 ffff000009660000 0000000000000007
>> [   13.210247] 7a40: ffff000000000000 0000000000000000 ffff0000092c2d3b 414d48203a6d7665
>> [   13.218062] 7a60: 3a73727474612043 0000000000000024 0000000005f5e0ff 0000000000000006
>> [   13.225878] 7a80: 0000000000000007 ffff0000092c2d25 ffff808f346b7aa0 ffff00000849bc1c
>> [   13.233693] 7aa0: ffff808f346b7b20 ffff00000849c100 0000000000000000 000000000004080b
>> [   13.241508] 7ac0: ffff00002030006c ffff000020000000 0000000000000014 000000000030006c
>> [   13.249323] 7ae0: ffff808f3107a800 0000000000000003 0000000000000000 ffff808f310da108
>> [   13.257139] 7b00: 7f7f7f7f7f7f7f7f ff656d6e626d686f 7f7f7f7f7f7f7f7f 0101010101010101
>> [   13.264953] 7b20: 0000000000000030 00000000f1e100cb
>> [   13.269819] [<ffff000008506f34>] pci_generic_config_read+0x5c/0xf0
>> [   13.275987] [<ffff000008506e2c>] pci_bus_read_config_dword+0xb4/0xd8
>> [   13.282328] [<ffff0000085089f4>] pcie_capability_read_dword+0x64/0xb8
>> [   13.288757] [<ffff000008513d28>] __pci_dev_reset+0x90/0x328
>> [   13.294317] [<ffff0000085142d4>] pci_probe_reset_function+0x24/0x30
>> [   13.300571] [<ffff000008518754>] pci_create_sysfs_dev_files+0x18c/0x2a0
>> [   13.307173] [<ffff000008d9a974>] pci_sysfs_init+0x38/0x60
>> [   13.312560] [<ffff000008083b4c>] do_one_initcall+0x5c/0x170
>> [   13.318122] [<ffff000008d60dfc>] kernel_init_freeable+0x1c0/0x27c
>> [   13.324205] [<ffff000008980d90>] kernel_init+0x18/0x110
>> [   13.329416] [<ffff000008083690>] ret_from_fork+0x10/0x40
>> [   13.334716] Code: 7100069f 540003c0 71000a9f 54000240 (b9400001)
>> [   13.340805] ---[ end trace fc992038acd29ec3 ]---
> 
> Most of this dmesg output is overkill -- I don't think the timestamps,
> the register contents, or the hex stack dump will contribute to
> understanding the issue or helping a user match a problem with this
> patch.
Yes I will update the commit log in a better way to capture the issue.
> 
>> Fix this by adding a quirk that prevents the root port from
>> entering D3 state. This is seen on both Ax/Bx variants of the processor.
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> ---
>>   drivers/pci/quirks.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 10684b1..2eb08a8 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1154,6 +1154,18 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
>>   
>>   /*
>> + * Cavium's Thunder-X2 Processors root port doesnot handle cfg/ecfg access to
>> + * downstream properly if root port is put into D3
>> + */
>> +
>> +static void quirk_no_rootport_d3(struct pci_dev *pdev)
>> +{
>> +	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM, 0x9084, quirk_no_rootport_d3);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xaf84, quirk_no_rootport_d3);
> 
> I assume this is really only of interest if we have the Thunder-X2
> host bridge driver in the kernel, right?  Could the quirk be moved to
> that driver so it's not included in everybody's kernel?
> 
We dont have a separate driver for  THUNDERX2 PCIhost. It uses the 
pci-host-generic driver. Instead I can have the changes to be under
#ifdef CONFIG_ARCH_THUNDER2
#endif

so that it is only included for CONFIG_ARCH_THUNDER2 enabled builds.

>> +
>> +/*
>>    * Some ATA devices break if put into D3
>>    */
>>   
>> -- 
>> 2.1.4
>>

Regards,
-George
