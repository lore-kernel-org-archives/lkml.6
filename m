Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeCMONd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:13:33 -0400
Received: from mail-by2nam03on0061.outbound.protection.outlook.com ([104.47.42.61]:34318
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752311AbeCMONa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:13:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Huang Ying <ying.huang@intel.com>
References: <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan> <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
 <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
 <20180221095435.xe5lmes7mpxca3en@wunner.de>
 <d0f6a588-23e7-123e-267c-5257c21bb38a@caviumnetworks.com>
 <20180221232040.GA52685@bhelgaas-glaptop.roam.corp.google.com>
 <305a9d29-4749-12bd-e0ab-903b58cda134@caviumnetworks.com>
 <20180222150947.GB52685@bhelgaas-glaptop.roam.corp.google.com>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <c2cb5ee6-570f-bc98-4e31-990a19d43ed1@caviumnetworks.com>
Date: Tue, 13 Mar 2018 19:43:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222150947.GB52685@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR0101CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::17) To SN1PR07MB2333.namprd07.prod.outlook.com
 (2a01:111:e400:7a46::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f8e49ad-90e8-4faf-c055-08d588ec978d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR07MB2333;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2333;3:gk2cNgT6LfPxNhxwU98tp/II4Lp82+ILAdA+dHJFMDfKfiWQ81xr4280EtMCH/8z49xDFhvtmZa631Qw+zcH1AppgCjTnv0/EPFks+12ld4oLlYvJbJU6Z5GtRC1q0mnIvncMZSXEgaKStFlSg0YoQxRFm4ca/RmQCKhVM4hgotnuPBf7Hnsw/qG8eHKiHe+a4phX8zUr19qU5qt9qwfIYP9L86Lh+tuxyC9ShqTofYqgfqn/GPO1MeYR+CEniSO;25:LZUYilA45/wGmWVFhWbkT6kIRRjhbNgddptZQY/2asr1EgnJslUXKBF0FZ95Eui87BvOEzqc0bgScgTvrLOHnkErQRwiIby/jCitU0LUxohQXxFDhpFNtAlqGsi8ixJdqqj80BQHafKKSeXGZ2HbSaXL39Qz6J/Ros8bRnjmHA7P44VcwoaIK749WGu33Q8Xfl5HgdH0W4hNVCFZJ5ObQ4Wq/4E/GrjwEDo4rB+vAt1SbsXFFf/Yt/q2n20KCyQ5bHrLftMu4XPAbT+s8rsU6v8mO+H3MmthUHuSFJ7ItTQamjPFENcvSNVeDgIuGwarPXqwp8OW0DB24007+Sd4rw==;31:s+YvBj7XxtMp4Ybvepqt8aZN3vtVWF2admmaIFnvb3r2NZBI0N4yw6dKCKMDWFR0UB3vxBBCsyY/KM/eCw9LrA51wmwjml0xu3XQf7HrfeoBB9UdM5v3+OX9Ma/u04B1tgx28vp+g7i2AKdBDcfTiUAfey1TE8gGGlS7HYOXHzAU2Fs9oF4whSJTko+utkW9q+A0i2qwNSFVYvojbTDXX4cXlLD3xRYYQ2dHQrYekDQ=
X-MS-TrafficTypeDiagnostic: SN1PR07MB2333:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2333;20:RQuIbnzZedUW121xZzoRDNY1KMI9pGuFT2wwDaJzZ32A2M2fse8gjrcatcKRC5YcSX6yMQI+A0i89jtwNNT5pjySOsbbN5ZgIZX7OFBWRb5z1MBwMsiXVUiYB6xQoWfLIREOdpQpIyHU+I6qS/wPEDKgWHS3r3KH8onA19iF4H+AETnJSTcfxTH4Ch4W8Z21ZjpsOakY7uOcRYnOZfC4hZ7WJ+RY109IRGc3BXm19NEjw7utdEQ+nF9zztWxP0hixVrEyezHzNbsQ3ZeNYd8/4SXtqnnchMHo+kVc6nWGiUolD3NPsyBRUUfD3jZHwT5Gw7xV6b85fqxnm9FzvamB4CnNkU+06rvfpaDJ+nPTaSQR9DVG/QrQTPN59Vafd99ON1Qq2Hn1O8Cl1RPjzjBUNv/UlgltM99cVXmuOA5s1k2FTvfbhRI/kTrZdv9q6Fyo5/VC/ugRPaxD1bG8/NM8iiI4KpGhaKePQ2pJYsYIsmQVGTqFd2GaFh/65Q8FOSuVMxMu4WkiDOOfs2olridYIonNCPaPQt0WFP1m7fgfN8ZivkAVMdjeNo2JSQwkVwKs+QSelv5onlfjBhlEn20KEUvGiOstbS+bRBhvQSvTuE=
X-Microsoft-Antispam-PRVS: <SN1PR07MB23338D8020BEB7254B116290F9D20@SN1PR07MB2333.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231221)(944501244)(52105095)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR07MB2333;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2333;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2333;4:db8Zs1pebDteuk7BmYENs/EuJH1xEKdIt1kwY3NMyPilPAAOAgVWYdj+b3DKmNOueVH7UlIL1O17DlPbGxbHXmtYNHbCS+isuYurwQcXH3NTalsN+XVOPFlLOCe+rVMMcyteEZs0rj4nxPkV2QBMoX6qlSpVdHYczDeyScVr/5FIrvlfuzAYPZ68N2q168cSJI7atKIpoq0rW3Q6sCzJQWgaB2TvljIMKY5mj2CY6rUpz+H4nsps1zcY+FrV1vsP8WbHQyLvJfIrjPmwn5t0v67BfAkgb2BJVVCqD2sLx4v3pGIDphaG2KRbenn2yeKJIiTBl6SD1LNJKHg+WX/w5YiOxAJPlF6s3gwijKd5Hx8=
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(51914003)(50834003)(81166006)(106356001)(58126008)(31686004)(59450400001)(53546011)(81156014)(105586002)(8936002)(72206003)(16526019)(186003)(42882007)(5660300001)(16576012)(316002)(7736002)(26005)(93886005)(8676002)(77096007)(305945005)(386003)(31696002)(966005)(575784001)(478600001)(97736004)(65806001)(66066001)(23676004)(54906003)(47776003)(64126003)(65956001)(6116002)(36756003)(6666003)(65826007)(229853002)(50466002)(6486002)(4326008)(76176011)(2906002)(6916009)(5009440100003)(230700001)(2950100002)(6246003)(6306002)(52116002)(25786009)(68736007)(2486003)(67846002)(3846002)(52146003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2333;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjA3TUIyMzMzOzIzOm5uYzduUUkrSHlBeHlsTE5KMVBXYXRDSmZ0?=
 =?utf-8?B?MFE4MUF1bElBYy9zV2w3K0JmNmxxcVd1S21wTDhkRXhhcmltdmgzMXZjZ2Rv?=
 =?utf-8?B?RUlUcFJ1OStGQkZXMVcxMGVtM3U1bFQ5bGR2N0Z3cWFKUzM0OE44bGtzUVpP?=
 =?utf-8?B?dHFoc0NrZ2pJN3RnY3EwbG05SjFmMnR6WGE0SHVOK2pGNTRMYmF5bnE0ZVVn?=
 =?utf-8?B?dUJQOFRxdzE1ekhqTFhlMFp1VXhwT3dZYmJ4dHdvNTNzZlFYNUpodERKNlkx?=
 =?utf-8?B?TkRpRGZ6QmlYNS8wZFhEVWxMRDd5cENleFJDTjVPSEY3bDFlaVlCWEowSjBW?=
 =?utf-8?B?MFl0QnBzcXNvL0J3emZNcG1NaVR1c1VyNkFxcmVjelJtSTFCOUpTb0ZtUDJ1?=
 =?utf-8?B?ZzdqMWMzdlZseThDcnRjOGFQUTZER1BDc3NtQllkN3BuYWRiSkx6d2VzWHl0?=
 =?utf-8?B?emU2MjZ5QnNZWVhQaHMxa2gzS0tpazRLWmdJZ0dFNWtON3JqUTVNNWlBVHdQ?=
 =?utf-8?B?QWRPKzkxcFdxdXljMVRGTnpCUGtud3hXVVE2YTh0VXB2Qnc5NFdobTV4cFNn?=
 =?utf-8?B?QUFSbzNleFhUeDFaQTVUamlNdzArNFNoME0xRExKK0RXYmNzb3BaRmpxZkll?=
 =?utf-8?B?bmhSWXRiOC96SUFuRlk1QWNRODhOMGFHUWpRWXNaWEZLMlhtRzZoRitXakxK?=
 =?utf-8?B?YVdrSnpHSDdYQ3lPVms0ak8waStOL1Z5aFdaQnBZRW03bmRhUTNHKyt1R0Fs?=
 =?utf-8?B?aXB0Zk1uc3BTUWZVUVgrRE5GNjhobklvd080djBPU1hYK042TFg4Z21aMTM1?=
 =?utf-8?B?ZGxaR3h5cUQvMy9NTUVBK1EyQWRXYkZFeDBPMDJ4QXl0WVN6RjBXT09mT2RZ?=
 =?utf-8?B?UEc1ZSt5WkpsblIxaVBsaWhMcXd1emFHUyswckxQN1k3WjQvQzZZWWNLRE9o?=
 =?utf-8?B?bVVHVUxWZ0REK1hVSjdZT01DMU8wWkFVUlJMdEhnUnhINzVwb3U4dVg3cEZm?=
 =?utf-8?B?T3FCVXhmMDZwbW1CMFVBaW91UEkyZmRuSmtyU1g5MmsyK2taNm9QUjhDdnpF?=
 =?utf-8?B?UUZkN1hPZTl6QzJ0cVlzT0U3K1VjM3Nja01uaHh4aG9MMEQ1OTlPeFhUWTRY?=
 =?utf-8?B?OFBNUmpMMUNTOXVkZ2dtWklaL2Q4RzJyb2g1NGx4RzJzaVFyNlFlMENueElH?=
 =?utf-8?B?SUxoZkNtK1F6RHVYeDI2YVU2bjZiQnI3SlAvM3N6VDJ3N3NPT25rODllRjh1?=
 =?utf-8?B?Y0pkM3NmbWVDQjBnanoyYndPaHc1UWRRQmxHRjNpQjVnVVcrNEplQWNpMHpC?=
 =?utf-8?B?TWJEM2FyMkZDakRaV0pyb28zVWFpRWRicmxLUVhjbzNiRFA2UjgwYnNsaU9m?=
 =?utf-8?B?QjQvMDBleW9Mbmd6QlVUWXJ3M2wwbTJqM2QvUm9lbHZZcGhSVnRQRStqQlpu?=
 =?utf-8?B?ZXpTTCt0MUR0bEtxTUg0SGpTY3BOcU9BQmFPWm1vakJjSjJORGRqSlIvekp2?=
 =?utf-8?B?RWhHYUpaMkY2YWRDK3JnZ00xT0dSMWh6MzR6Z0xuTkdoOGRuaW1qbkZobXdV?=
 =?utf-8?B?Y0pZeW1ONzJiVWtHZFptbE9HVWhnRmFrRHN3Y3JIRWE5SXBZdFBKeUh2dHBn?=
 =?utf-8?B?VGQ4Wkl2dmRZTURscjQyRUprcDBDcURIWlNJbWhaNnJ2b0orRzd4b2hwSFd6?=
 =?utf-8?B?MGxaRW9BTHRSeElRbE1CUFNiVUpVOUdybjREVWNCU0xabnp2YitqZG9OQ0lH?=
 =?utf-8?B?MGVWZksrSU94eVFXdTZxMkJqS29ET1lEdy9SaEFTczZYMHVCNmxRTDZMZE92?=
 =?utf-8?B?UTdjVGJRd0lCTFk4eUQ1Q0Rmbi9LL2E1ZmxSK1FBL0N0VnMvVEVMMzNyZmRM?=
 =?utf-8?B?ekFoNkZPRkRwYmZqRTJGRWhPcFV6OXVVUzVOZXNiTDVmYUVKdWtGZFJXandx?=
 =?utf-8?B?aHExVFZLRlZ0Y0lRdjZRQ1FveDY3cEF1eTdJSjJLaTI4RTBrSmlIRWlPUGVx?=
 =?utf-8?B?VHJIc0phejFoK203bEhDNmk0bEwzMDJNWHlCMzdiK0VCSEU1UFlaY1I4cnlE?=
 =?utf-8?B?aTZJK2w1M01BUFZCa3AyVnplNmoyOUVtK2x0VjNJNHhRZlZQb2lCN3A3aVdk?=
 =?utf-8?Q?Rwny06RJ4yfvM6sUmhRi+cYmEolJSjsULkm6KfwZRURF?=
X-Microsoft-Antispam-Message-Info: Sv4UqSp/6Ihf+r4cvY6/aw1LcwyJ0euYwGQy7Fq4MwbONL58vpfmG9RijnX5F9pJ2ROCH5+cSyRSN3j1McDk3XXbifE4axxfhv3spSSvnIaJDPGbEUlOyvuBpnUjbNOyN9oaM2UArF/fsvnaPHcgC/HZq4d0CWf75/VeYXvceIXqGSUpCA6OmI1TIH47oLbb
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2333;6:ahNGgcFhlexopFw0eqM8qgFnmwAyqW8zPQdIp5Q0Y+Q3CiW2Td9bWyMSKhX9C3QAYYyuYA5w0WEIkPRyyGwVsi0OKmztimO7F12ZnBRIsn0jVrjc4AkpJyEqPK+3EwoSc2YC4Jw8xWDTY8MZK5l6nVHLaC9G/ou7HvL9C0SChb8nhyKRSwbWqX+L9N7FVana7WqNUjqL5Qq9E43yCKqNM6ONP0A1mb8ZZVNlghIl9DWqwzclxNYXzIY98NA4Nl+VWTv0P8bwO7GihCwDC0Z8FCkhpA6UJ0W6naAK/zJi6vL2ehSdsvua51ppBAkDcBjczzPzZMAjViTbZH4EG8K8VSv1ErOQVvUU5iL3cgjP9jM=;5:oJISBbg4uiWh6iApb1qph8l0evrMviyTAIqbfclCL7g8X+b+a+NyoH2PJJAdkm5P4gBdstl877cVrmc+PNiO2vFV0VdCuq76k02vOTVPClHpkIyJnhoWeGS2gaSpNj59oJLgvdbgokW6UsLUiiSJr8des2wP6DzeFmHMq3WvYns=;24:9jSrS0HXLLAVF781GrO36R5W9D2aNeUBK080Fhg8YfY5mO76c0kQGsEXcqSyZOFxFJfsl0IrAYacW0VgL1YBKLJo9fCv9gwx29LviTUPJeI=;7:BH/ZTgE8FEylAeGf/KPZk3zI91ISntsgxUlUPeSBfruhgQorWeX9oiibcIHsr3f8WgySIN/K+GUY05wq/lMKBM1jWi2wZz0ETbYHxpAf5Cp8Ex7huySf2baAJ5+0z2T36mXOmlzoVZ1f/A7QFCxYKvI+Pz+BL75/bvx7j0+bacxqD5D7ztNFS653eM/CrIflGV5rpo1yMEGVauprG5uIJqXOPHPS5250g5sZECIPG2zZYurn/3lhFbVY2N2vQX1m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 14:13:24.3632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8e49ad-90e8-4faf-c055-08d588ec978d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2333
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,


On 02/22/2018 08:39 PM, Bjorn Helgaas wrote:
> On Thu, Feb 22, 2018 at 06:43:34PM +0530, George Cherian wrote:
>> On 02/22/2018 04:50 AM, Bjorn Helgaas wrote:
>>> On Wed, Feb 21, 2018 at 04:25:08PM +0530, George Cherian wrote:
>>>> On 02/21/2018 03:24 PM, Lukas Wunner wrote:
>>>>> On Wed, Feb 21, 2018 at 02:58:13PM +0530, George Cherian wrote:
>>>>>> I will explain the setup used
>>>>>> To the Cavium ThunderX RC the following PLX device is connected.
>>>>>> PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Express
>>>>>> Gen 3 (8.0 GT/s) Switch
>>>>>> There is no device connected downstream to the PLX switch.
>>>>>>
>>>>>> AFAIU the pcie_port driver probes PLX and enters autosuspend
>>>>>> after 100ms since pci_bridge_d3_possible() returns true.
>>>>>>
>>>>>> And later pci_sysfs_init() ends up doing a config access of
>>>>>> PLX which fails with a "synchronous external abort"
> 
>>>
>>> Thanks for the details!
>>>
>>> This one *should* be fixed by this patch:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=bf6c089ee2ac67eb22c0ff0ac9cc7f9ccd619d90
>>>
>>> Any chance you could try that out?
>>
>> I did try your patch and it works fine on the above failing setup.
> 
> Thanks for testing it!
> 
>>>> I have found another configuration where this fails.
>>>> Following is the configuration
>>>> 1) Connected a PCIe Intel i40 card under the root port.
>>>> 2) unbind the i40 driver and bind with vfio-pci driver.
>>>> 3) Run lspci in a loop. "lspci -s xx:xx.xx -vvv"
>>>>
>>>> I get the same synchronous external abort.
>>>> In this case the vfio-pci driver probe it moves the device (i40) to
>>>> D3hot provided disable_idle_d3 is not set. lspci tries to do
>>>> the config_access which fails with synchronous external abort when
>>>> the root port transitions to D3hot.
> 
> <snip>
>> the stack trace for this issue looks like this
>> [<ffff00000851bbfc>] pci_generic_config_read+0x5c/0xf0
>> [<ffff00000851c6e4>] pci_user_read_config_dword+0x84/0x110
>> [<ffff00000851cda8>] pci_vpd_read+0x100/0x208
>> [<ffff00000851bee8>] pci_read_vpd+0x50/0x68
>> [<ffff00000852d6c0>] read_vpd_attr+0x60/0x80
>> [<ffff00000833b224>] sysfs_kf_bin_read+0x6c/0xa8
>> [<ffff00000833a674>] kernfs_fop_read+0xa4/0x1c8
>> [<ffff0000082a6238>] __vfs_read+0x60/0x170
>> [<ffff0000082a63d4>] vfs_read+0x8c/0x148
>> [<ffff0000082a6c64>] SyS_pread64+0xbc/0xd8
>>
>> I have tried adding pci_config_pm_runtime_get/put pair inside
>> pci_vpd_read(), which I guess might be needed, in case the device goes
>> to D3cold. But having said that it didnt fix the problem in our platform.
> 
> Your original patch avoids this problem by setting PCI_DEV_FLAGS_NO_D3
> on the root port, so it seems like this must be somehow related to the
> root port's state.

This seems to be another issue and is not related to $SUBJECT.
Our Hardware team is internally looking into the same and will keep you 
posted of any further details.

Thanks for your time and suggestions.
> 
> I assume this VPD read is on the i40 device, right?  Since you're
> still seeing the problem even after calling
> pci_config_pm_runtime_get(), I assume the root port is still not in
> D0.  Can you add a little more instrumentation to read PCI_PM_CTRL and
> PCI_PM_PPB_EXTENSIONS for the root port and PCI_PM_CTRL for the i40
> device right after you call pci_config_pm_runtime_get()?
> 
> I don't see anything obviously different between the pci_read_config()
> path and the pci_vpd_read() path except for the
> pci_config_pm_runtime_get() call that you've already added.  I guess
> you could try using setpci instead of lspci to see if the failure only
> happens in the pci_vpd_read() path.  I assume that will be the case
> because lspci probably does config reads before it does the VPD read,
> and those initial config reads seemed to work OK.
> 
> The VPD path does do config writes in addition to config reads.  Maybe
> there's something special about writes, although I don't know what
> that would be.  You can tell I'm running out of ideas here :)
> 
> Bjorn
> 
-George
