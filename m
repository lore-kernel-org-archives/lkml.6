Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbeCEWMs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:12:48 -0500
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:31040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752508AbeCEWMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:12:46 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 0/7] x86/microcode: Improve late loading
To: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20180228102846.13447-1-bp@alien8.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a9162ec0-0440-3369-5c07-c6d58fdb7154@amd.com>
Date: Mon, 5 Mar 2018 16:12:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228102846.13447-1-bp@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:910:4f::19) To MWHPR12MB1152.namprd12.prod.outlook.com
 (2603:10b6:300:e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: def00dc1-be6b-465b-b0f6-08d582e638b8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1152;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;3:2HNgjfnAJffKGMHI7oaR3dUJkEq8ObKYJ8xbVwjiVkrOUqWD7MSdZp1OpNCQHn2xcGZTw8Dm6wVTdh1gAb7q8mpncvtajJ5aTzgHf/uKu+O77k+zPRHGsJ0m+TMoanvzwpn8WkmvrkjDEKwwEnwdEfI62BiKUPnIdvVz8K8bkHYBj7LleZ/AxY09TuWDpIS0hvpv2Hn3BFYOog50GHDXnqM7auwpeAsqGG0ux2I//EyA6iIbl0QJyHAZj2p8Zewn;25:w1yorE4rEottNWOKA1Yw7uHfyWNqa4VI6spHSE5TYGh7TPoeTdZqHZ5KmCxyY2lO19U+PEU7jZGsZVZpk7PdzVvRbtvlhQDMv4GwuWu/dTyaHXy+e9rE0Hw5u6CGUJ5q+9qAyhpbZg+rCN9CPvZqv0YeOclJ1RATblPc3AD9qc3NESYhQ00gm72jkkgDuXpqzzmtDlhZ0cWhR9cFWsc1owAcdARo2Nh358F+SDNwEOqn/TDdZuv70Yg5iXNo0WLuEg3/0AE5ZDntxWC1W4rOUFgrO7sdERUexVXeTqxsBoWnYXltQbBP5PR40Avg7No84eZNqtyGX5NcS1p7hW7ZLg==;31:z3gcNLL9HlGdW4VgYdcydvEVq8kIgo4KEnpoeqLGNmqIkqAhx22l7UcMGZ2VP+Bq03YxT0HHH271omXN21v9wlAwW4eKXjgq1uBjSrYBpiNMtJI6eahOPCD43gk61qLzvO2/K8xBXZLuxGI7lZ1VYxFxL3YfJvHbZUm7fZ1ZiT5R+IDxf/ZQV5L2iXbOkIUUtPA/QEBFB0Y766N3YvLGmbfVWMrrOIvdtZfv0ttEHpw=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1152:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:hOt1AfWtRne6MPABYYQthUiuiTFLAcoR7eG6dQU5vT52va1HnPowDpAPwprvEWVMNuYcTbu6ehv5j+T1vqEHprk1PHxRG9vTXThlxtW53Ry7AJrwiYxx0cyUmvCdUvIwUmKvMIZ8r6UA62jmnvEdiAneURig7wrSFDY4uU4oxWl2ql5VAhk72hLNADxpo/CiCDbSeUCbTqT7vG+qi4proj8TWXgvydSyiVCRNVdiNQVdeyKlpADubo+HGEmQjR9h5hnogb7NpICJhPZzBMx+FTod3HGONcWuUXQkYerfzKvae14sjcKMEbvwwh5NwOYYt5vKkfOUpjgDHlzTysOQayze+757SUDCzvkVtoqGYZysDEmx209rAcEqPB5mHOuZuLOY0HLTNjCCjeRQRAtZGttvmgjsd/TE6lBHixaug7FimL7he1hZQzOw/OcqjpQnzkl7oDNGsPBtPpqy7tlVS0C9UeiVGmqDOlgWqqF6PF37e/KxjvkZZoAqGx9hzzRp;4:GXk1iWDdjmryHUDSUni+iEtKuy7HX32pQVnUT32e/lZRHeZpSP49rJ1d4r8Ti9nMX61j/901sRJ86YuZqR6uuAxsSG7RzBRs4RkEozkGThqH6wXuXViSLdZnMR9sutooVPD7IKvbGFy6ijL0Cgfb2Plt/EtvNHLKot9I5dT8QSZ40W4vKNHA0OD+4NP4vM2jHEQK0Lzzer85Rv1ymc+309uKg547wmeR1E0wtbVVSsH0x/zEmoL8J0qlAJhBClTgx7hXEGarWPfbNdqdn4mJ73ezt5luc+Fr6zARKN0LeZm9YjdkFTRFgzvzt9vAifuf
X-Microsoft-Antispam-PRVS: <MWHPR12MB115240C401AA6FCC991BAA3CECDA0@MWHPR12MB1152.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR12MB1152;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1152;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(6116002)(3260700006)(4326008)(2906002)(230700001)(316002)(16576012)(105586002)(3846002)(36756003)(68736007)(31686004)(16526019)(186003)(26005)(77096007)(72206003)(53546011)(59450400001)(106356001)(386003)(31696002)(86362001)(25786009)(47776003)(65806001)(65956001)(66066001)(97736004)(53936002)(52116002)(6246003)(478600001)(229853002)(64126003)(58126008)(6486002)(2950100002)(6666003)(50466002)(52146003)(2486003)(23676004)(305945005)(5660300001)(8676002)(110136005)(8936002)(81156014)(81166006)(76176011)(7736002)(54906003)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1152;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTUyOzIzOkN3bElWUytubVY2MDMzdzByS1UyVEhUZXVa?=
 =?utf-8?B?cGFtaWVCendIQnlMMXZaWlVraG9ZaE5tS1dFeGt2aEMzS1F6Rm9KY090YjVS?=
 =?utf-8?B?dVl0UHBsbE8rdjdxcncxQk1DdXAzbWlNK2EvSjRSdEtQc2VTR1VtRW9ScXR4?=
 =?utf-8?B?ek5DV25SUkwvb3h4RWRGT0V0eGxDWXB1OG5DYU5iZGgrd0FuTW9jQ2xiUVVx?=
 =?utf-8?B?TmZtWHAwekpzOGN5OUYyRmhoa0FhY2drbGJ5a3krS2VjWmtQQkdEa09ydFlz?=
 =?utf-8?B?eFlieVgydlRoZjg1eDN0MzlOZWhYZ3phc1ZHdWVydzlhTXkzMEF1SUs3cG8w?=
 =?utf-8?B?UE8xZ0FQYXIwRlVhLzU3OHcwbWg2QUZhTnFKQS9udHdWUkhnRE05NmYvRG5W?=
 =?utf-8?B?eUJPNnhnejI5L2RPNkc5YUdibE1oY3YvWjd0K2luSlRwZlJlaW1YVGZiMis3?=
 =?utf-8?B?SERramJVejNKN2lLdlFFTFlFZmpIT3BET2p2NDFYZjY3QWpGZis0Z3ZaV3c0?=
 =?utf-8?B?cHZXT3B2R0oxSmtsTWh1Z1A3aFJFd1lWRms2VE42bkJDZ1YwQTd0b2JHSmNB?=
 =?utf-8?B?QkxhdjlFeW9nWWVDRUpnd3psMWRKVER6Zm95VHA4bXIrQ21TZzE5Z2R1bjBI?=
 =?utf-8?B?MmhLTDlxUm9KWGVhc1hkR0d0Wi9FTEN0TFo2ME9wcHFjaDJiWTRUYVRoVzBS?=
 =?utf-8?B?amdGNzNzdEt3Znp0dXJyZ0NxSFFVcmVDTFl5UlpQZ3JrdzhXOHIyWDVRSlI1?=
 =?utf-8?B?N3NiYVhIQ3E0bVVMays0NmxzMTRjZGpvN0JwajY1Szg5T1RnWGN2YU1DeE43?=
 =?utf-8?B?b2NHUkhSWFVoWWNFUWpZWXFsSjR4N2VLenhjYXkzZ2FidytnTjVZaGtLdnJI?=
 =?utf-8?B?a0VJMkRXWTZXeGt3YS9PMU1tY2Z2NnA4UW9LcDVKc25pMU1hY1ZlaUpoVDEv?=
 =?utf-8?B?Y1h6WEsrQk5wZ0lpY0NkL0RsL3RRb0h2YW1XblpPYVg2ak9Rc1NsOXU4a0l6?=
 =?utf-8?B?eGF6N3oxcW1iUGFPQXVEVWdwTHVSWGU2UC9XVERSaHM0QTVZem16ZXg0VjM3?=
 =?utf-8?B?cVNQRXh2UXY3aFNtRFlLUmN6T0M0T1MycFUxcmNDQm1Bdk91dnZHc25GbllH?=
 =?utf-8?B?SG9IaFZ1SC9zTjFPbHEwSXJtbzlTZytjdmNkbUVrWWlYV3ZYa0VZU3dOL1JP?=
 =?utf-8?B?Y3hzdUpWZmYzNWtPOGIycVNoQ3o4WXNFWTYzSUQxV3U3c2xIN3FBU0QwUXRX?=
 =?utf-8?B?M3hxMGtDK29GdGRxUXAyNEF0L2Q2Qkx0NlQ1d2pHV2RLTlhzK1YyS251RHVX?=
 =?utf-8?B?WWxZbFM5ZjU0TG5RQVBGcjJOM2JrbHVrNkI4eTBkL3dORjE0RmRuWllwVEZE?=
 =?utf-8?B?blBFTTdnSlhDRGpQcE43Nk81VEJ2a05aWDRjSVdZaXl4MGJpc1UvV3pRWW81?=
 =?utf-8?B?TU5xUE5rSGt6N0lpaUVBWS9oZUFzWmwveTdOWG8vZ2Z2bXBjZFpMZG9DaTRs?=
 =?utf-8?B?Sk81bjRHZk03VitaZ0o3TVdWOWVTT2I5OTFCZFV6QUdCc1lpM2dMVnJQRmZV?=
 =?utf-8?B?NVhmSXR1N0VHSm85OFd1TDdHQ0JqK0Y5ZWxFZFJtZ0xwKzN2OUR5bGtMM3NT?=
 =?utf-8?B?QXZWL3FCanByTFlNT3NZUlJ5WmtlYnc1UTdJK2ZCbWZnQUVidmpFaVRGVGVa?=
 =?utf-8?B?VW5NNVRRTXFOMU1JMHQ1YVk3MUFTa2tqbU9IVEoyeTAwRnV0NUtTaUo0b1Ar?=
 =?utf-8?B?TVpzZXR2NDYxRVVRTDc4NWMzMFBDa3Fqbnp3aCthdmc3MXVKa1NONExQOWxT?=
 =?utf-8?B?bUJibVpFV1djbXk0Ty8wSXB4cDE5VkxyOTZnOTFPdld6aEpDc1FqakYrSjBK?=
 =?utf-8?B?MzdmUW5ReGgxVHFyWi92dUs1dWpsYmdqQkRFdnBqdVQ3dFdiajNBeEVaY1Br?=
 =?utf-8?B?WDNjaXlBMjBRPT0=?=
X-Microsoft-Antispam-Message-Info: 2lKEwEkXGEhs+9DFilfpKXgzTsNZAPIQo6pMmrSRhY4yH4jZSMWJPh/V/lR4bvKMwZveiz/Sukb8gT4C4p3OvAxuQXYn+rjrOODVPLVi8fOVLsEhw+OEGmPpwvuhz5TiyBHikMC18aMdqo3+MDB4NRJLEbwIbu2YfSPc2cg2+O/YWnoy8E6r0frPrY7AWIEY
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;6:TVDTPN6hBU2JEsDguaDzsnvKUJDz/IIbfGQvSk5+RSX3L1pb/3YER1wpB20V+OaBJFbvwXPa0e32d5EkBBycN9FpqYxnHe7fCtLV4hCKfzCgtiWF7vKizquJpyx3iIgknPs2pXVoj2BThgWH+FA73armvrWslYjeYcJriy1yRiTVvaU5GPFtR36jjY+ywrDrASmtL8EeFM6YRGJ549w4VCZRkLxnv3VNwCVu7mhyA9XHgv23JN/YgW9NVgD+1sOHo+190aYSMaTVq0/xTNFjk1DwYROnNlvd3sW9tYdJr7+BXmG2QWlYfEE6reHm9V1Sdb788pi7BVhL42AOeeFo2O+6AQtwgdhXZtwF1lYLGcw=;5:whjSSiMzzilF/wtk3zWIPANHB07cUjZsnq64udfqOtVf/i2/VTmx9kBcCiIQLFJh9g7UCgT8kovYpBcVzwKMyJ84oNQPv3vcBeFP4N7tJDMi0cchMSpg0zzWZNbWQj1Rou6HqXAb1IGsUEVwOFrai/KG8+TupvGAnXvasxWvcpc=;24:SBrGoxQbuTd1vv4dqnfbhWfIhIlmhccU7SFnzE+QyXq0qKA4Oi4Z3L8zI7me6OyRrvOFiCIX4qyyhc3/YGyUGmQRWOPFQHOZBI5cxPNMROg=;7:fhC+7tQeZI8chrGYCEEnHv9/gVNSQyyMNN/n7N0KlaONFj5zcS0safS3N7TxxCIF5kElf38SwO99Fg7UCXhNAPNgoIigyo6P/xkOzjS0rFj0RNA2EoUruG0p0ORfklOvsuwgd6o/oixN6v/CEX+33H6zvJPVpxjwGDrX206LF2hgn+QRkcOJRXV/oNdY27fZApy5cM/zSG+MKqUCFcq+ndrd+z40XbktGPUCLDHmHe+V3IWkkN06LijUooRuQO48
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:05OGiuYOSgNEezSEj0HJ4WY7/wmDSPgLl4f4P/OXrFzUijnHCUNJjSYB9xVYr90eTedBvOaEvGKKCMqa1yV1IZAKZZN/2BrezmIP0DbYgfk4TUTD/4sSe3n6LHQg2kQyBaUi7riOCrijEEwlINaB20gsqUlTcJ1u+tdT5nnbKBX3Jpjir1PYSKs/g1cAkistDDVB9aGDvGyzckoY6LA29LSaUqKZyJd10lzkvP5JbQgquKQUU/1LKXHyg4ibG3oI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 22:12:44.3353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def00dc1-be6b-465b-b0f6-08d582e638b8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2018 4:28 AM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi,
> 
> here are a bunch of patches which improve microcode late loading.
> 
> Before you read any further: the early loading method is still the
> preferred one and you should always do that. This patchset is improving
> the late loading mechanism for long running jobs and cloud use cases -
> i.e., use cases where early loading is, hm, a bit problematic.
> 
> Ashok Raj (4):
>   x86/microcode/intel: Check microcode revision before updating sibling
>     threads
>   x86/microcode/intel: Writeback and invalidate caches before updating
>     microcode
>   x86/microcode: Do not upload microcode if CPUs are offline
>   x86/microcode: Synchronize late microcode loading
> 
> Borislav Petkov (3):
>   x86/microcode: Get rid of struct apply_microcode_ctx
>   x86/microcode/intel: Look into the patch cache first
>   x86/microcode: Request microcode on the BSP
> 
>  arch/x86/kernel/cpu/microcode/core.c  | 158 +++++++++++++++++++++++++---------
>  arch/x86/kernel/cpu/microcode/intel.c |  48 +++++++++--
>  2 files changed, 159 insertions(+), 47 deletions(-)
> 

Tested on my Family 17h (EPYC) system (including taking CPUs offline and
back on before and after reloads).  I'll try and find some additional
systems to test on, but for now:

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
