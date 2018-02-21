Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932331AbeBUJ2g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:28:36 -0500
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:7776
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932104AbeBUJ2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:28:31 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Cherian <george.cherian@cavium.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Jayachandran.Nair@cavium.com, Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Huang Ying <ying.huang@intel.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan> <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
Date: Wed, 21 Feb 2018 14:58:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BMXPR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::30) To BL2PR07MB2323.namprd07.prod.outlook.com
 (2a01:111:e400:c753::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba2cb8b-532a-4fd6-e395-08d5790d76cd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BL2PR07MB2323;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2323;3:eLJtL+bVH0FO3bxTFb1yqTNgySrugRQhK9/m5sMKleBjkcI8wJmotYvSwMBgKIHqWtHHgUbVbxKYQSh/OrAJxCrfcWISygj9e1oJLXWae+gplyxNJNodudkys5AkO6tvKJ/4tGBlK/ExDlPTPy4ze7UDWrXy6SC62b2zPFzJZR4PnsiSwvtWfu7n35YRWrKQ0RWIE9nliwAgbDfBeyZXn2qDUkOUWC0ygH4DD28owStH0/KZywwRK5k7Gcw9IgXi;25:vZAmtbMAI8nb5HmYaNcqQwnwyq+VFa2LwU8ktlqymhnyvgcwZ48J8gG1KrHa7NEUuMQJGAAmxVNMBdtz88LrxhKA64aSADEnHNa1KWBZyOw2CUvpOXQV+S23Siezd1OroNqQUQOEaOx/VpD38EMj/xYkmnGlMK+7kC/6ORDZrgYntKFZMWk/mAbHT/EHVHgTBuwCtdTzEV39EecJr7tEk3AL2YYX7QscLJzskxVT3b4VLndimmKlWU4qHGELz6oBzliqN1u7GywSNo3yW6X2KorVVvLtCBijoXZ5TClQ28NPD+/wwrn7S2Tr7T+jVjN4kWtkIX0P68Vxtg5WiYp+Iw==;31:Pw2r2xSm+//pIwYnBuZZfRQPqNfe4AvcHQgFx9VbXVupqbBGN+TQFQUznw/M0JWKGNNhe3JTKKjrA/3cXJDaAe4hS/9QhYr0vRiB4ARL0RbAemEdHWXIPxzVHP20OUsWTd0qHG/YAkmBG8mMDVV+V8Dvfsx5BxtDNU5BVzYP6t5nTCurJXLPNkGWYJJbh2OF+/87n/Gez8ePhHaN4HCJ0PnfWNtgiLB4q6DzHcXx4Bg=
X-MS-TrafficTypeDiagnostic: BL2PR07MB2323:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2323;20:R00ui2RAnprp0Zbg5aOcXqN9FOR+NImmZUpOzPv+AzdzsrtpTpP8Ail4Xurs/2g5iaiP22+nQhulOWHoykDgJbAbKRDxO5eY489A8G7Ss/xE62fKiG7cuqivLW7sUsAa6716A5bsBpBvDS58Hh0IQ2wyAb9kim6khwehF7vO+TLRpD3luHxh8D/7gT29zLnW8WPXyN3zzmcdbZESQd0MhHafN3uplk9RF9+vVMPkzZQihzoDErYjmLnXxUoeBohOgGrh1Iq77AOku3ak4qS9qMgVJdRB3FPhMuB12MN2wEwdYkIYpVAirWmQY7IwQX8f7cxfmt2arQZ6FZ62cmcnx85hXPBw5vy931TArtzyFfhFDA+Tn63q9sOADSqyUXVnMnnanpcl++HQl1baq8CUH41B1+UtjpbNBCy5TLOxR9VP5E4JdyfsLGBztro/PsuEg+4aTGwQhh9CAfTZCKEUXoOHVOigkYmdyNtlTKbW0Spt0/Oy7SoPlUCpnz+MHE4NZfS+ZlSK1fXTx3b5NPw1j4uAXXpFlGZ6zMOsHhmLuSyXb8uFexZSl2ucCokG1MEOF6H2PTyLSQOsdgdNe9XU+qP2XRsesG4fMfIuvRPZlIk=;4:olO0SiYPmJOVHeQMyZVbIbAeHXRyj+4HvvniLifgrxXIjLC3PUZK1Oul8kyTqUHdps4PdvXF2vSCqIreaKXDL7BpwN0KbpGuCMGwz57/eWkVFGJkrC34GcFwojY1WaVoZ7dainuKPH1AwmbtrYxkB4s1KXxF4zy616LZjfpstrxYHRnE7y53vQiaoZIFx8m6+U8J+yKvEsqKFSQxrkC2jEh4O4ficcZmQbb0evruec6wQk/Q8vSgcxVM1Tfq/r3NujcCot6/xWBtuyLDm1Nraw==
X-Microsoft-Antispam-PRVS: <BL2PR07MB2323443562D73F317C16D98EF9CE0@BL2PR07MB2323.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001065)(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(10201501046)(3002001)(93006095)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BL2PR07MB2323;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2323;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(376002)(39860400002)(396003)(366004)(57704003)(189003)(199004)(36756003)(186003)(16526019)(68736007)(229853002)(64126003)(105586002)(106356001)(53546011)(386003)(26005)(77096007)(59450400001)(25786009)(305945005)(6306002)(93886005)(6666003)(76176011)(97736004)(7736002)(42882006)(2950100002)(6486002)(4326008)(67846002)(66066001)(8676002)(65806001)(47776003)(5660300001)(65956001)(16576012)(72206003)(5009440100003)(50466002)(966005)(53936002)(58126008)(110136005)(230700001)(478600001)(54906003)(316002)(3846002)(23676004)(2486003)(52146003)(6116002)(52116002)(8936002)(81166006)(31696002)(81156014)(2906002)(6246003)(31686004)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2323;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjA3TUIyMzIzOzIzOnoxRFcrbm10ci9TMVNtLzI5QkVpcWxtemtJ?=
 =?utf-8?B?bVpCdG83dXQvOVE3aCtqN25UT3VXT0F0bjMvVjdacXc0eitZbEk4MFdzVEVC?=
 =?utf-8?B?YWkxSm53MDRuTW5XVEV1TEtlZkZSTkFKWHNPT3JVaWpiZ2xSYlRyZUFTUTZv?=
 =?utf-8?B?ZmxNVXp3ektTRGNLbm9MT3pHR2JEZUVaeGpvWjEzQzc5djR1ZElqVGp1WnU4?=
 =?utf-8?B?aFh1L1dOVGZ1RDdHTnloSjdoZVQzMGtVRTI4dWEwNm9IVXM3aDBXS2JqMFV2?=
 =?utf-8?B?Q3NzVUQwUW8vZ2hUOGhiSHp3cDh6U3c3WEkyRGtucFpNK3J6UUM0VER5VVpv?=
 =?utf-8?B?b2lLYkEyWm5lT2FEVDVrVUI2R1d5OFNDRU9xN1NYM1I2OXZDTW5STVpsOGNN?=
 =?utf-8?B?ZkN5NEV4bisyNm1JVll4THFlSEY3OGdRbWJjK25oWktURnhocHRLY0Z1RXg5?=
 =?utf-8?B?TXI4UFNNNEdXUW5wQjBIOG01T1RFZEdqK3ZmUlJLVHNHbHJibWU3SUYzV25E?=
 =?utf-8?B?N3BDeU4zS0JlZGtFV1k5SXlSR2FMMUREMksyZG1nWitnb2lpdkxJUlordUpt?=
 =?utf-8?B?QVM4bmdzeUVEd05jUStmWEVNS0VmRXpHNkdKN01VK2x2dU52R0pNV2ZzelY1?=
 =?utf-8?B?WFhPbUl6VXFDZ0lmb2hYVEpRVHp3WmNvY2dscGxsY3A3RzR6emJVUUhsZ0x2?=
 =?utf-8?B?UGowd2l3aGw3OU9VdndQTmRmWXZnbFpyVWZJZkJ3TER3MlRpeFM0VDNTaHJO?=
 =?utf-8?B?c0ZKZFRwbkNaZXgvSUd3ejRYeDVtNnIxZFZocWFBazZhMTROaU1YLzZEK2h0?=
 =?utf-8?B?R2ZmUk1nWWFCOTNOQ2ZJY25QVHBwZStvdDZoWU1QTDZoSENPeWhKV2V6U1M4?=
 =?utf-8?B?YWloZStMbjZGeTladTRJUEpmSWdDODBvK2tiL0xHVEZEaGplNktQN1c1eFJF?=
 =?utf-8?B?cHFud1FGdm9KcDR1cjhSazJnV2Z5K3laS2xNekc1cUsrN0tVRTBWRkxzM2VH?=
 =?utf-8?B?MzY0Z0hwenVkc1liZlFjY3ZzL21RWFVJdDhBN1hIVDFpN0hMUW5KVkFnaXJa?=
 =?utf-8?B?dk14cTYvaGRLVzVjWnU0cWNQZzJxdWlxZlFkTllpOFd3a2pQaWZtWFhqeFJq?=
 =?utf-8?B?anpnU0pNZkFnUTlqUVErQXg5Ymg3dDNHWFNxYUpiY1NueXlPM0RLMDRDQjE2?=
 =?utf-8?B?MlhpZExsb21LWTBkQlpOZ3VRZSsyWnIyT3BRSXUwd0oxUWVYNGZ3ekhJcHlt?=
 =?utf-8?B?K2NTYTV4Szc2V1FQTk1Wb0VxK0FIZmcycDFpcWlXYWN1eGFGdXVyODVZMEk0?=
 =?utf-8?B?cmovSEh2MEtTYk5XcjF1azVxcERjVW5JNXFOTGR4UC9PV3pTK01TdDA3bmVq?=
 =?utf-8?B?NlM3ay93OGRFVjJ6YmR3TjlMYXpzeGJQb3Zwb2c3YVNyUGVpdEFES3RVamFp?=
 =?utf-8?B?UGpkTFlJU2s2ZnpqUklSdGl6RXlhdGsrSGZWeXYxRXhBeDZtNEpKVVJZKytl?=
 =?utf-8?B?RzVOMjRZQzJDNHBQdWM4cnk4MVlKWWF2MWlrY2hSZFZlQTJQWTJzU21rRmR0?=
 =?utf-8?B?RzQ0SnhKK0NqMXgzSjBJbHdYRm9LZTc0N2dXVkI4b0owRzhHbW5TNWN4M0FZ?=
 =?utf-8?B?ZUU2bHR3SWszWGpRZXR0QURaa25Fa2VuZ1RqY3JYaHB5VWJ2N1RGREswWEpj?=
 =?utf-8?B?MldidmhkZ09aZVlPZUgrRURBMWx5Wmg1M2U1cWJYd0dvRTJHQzZTN3lkUnYz?=
 =?utf-8?B?MU90SjZraDdHUmplSUdhaUdaRzhjZlA2Z2d6RmNPREp1bUxNSURoVEkvdUw2?=
 =?utf-8?B?djBmS2I0QmgrTTJFRGVXSklPMW13Y1ZhWlc3QmdJQWJQNm1WVXVTV2F4WU5O?=
 =?utf-8?B?eWs3Z09FQUg3MzNoZHk0eVNBZ3NHb1pYYTRWTTZlWEFrb3FVTW5Ed0x0SWNV?=
 =?utf-8?B?OVlHdDBoNG8xdVNjVFQyTDcweHhiOWtHQVUzUU8rcUxnQTkxaEtVMnZlak9p?=
 =?utf-8?B?d3FmZ1JHalAxNTRiWURzOTF2WElIR3h2ZHZWVDl0bUhFQkxTMHdZUktpQU9W?=
 =?utf-8?B?QVl1UU5iR2xrLzdDb0pPMWp0dDBWUGw2ZjBDUVg4ZzQvSVVHR2xtbTRXS01l?=
 =?utf-8?B?YUE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2323;6:ptT34SZiJWLVCdBb1RnQvgyMFUFN561TVNiHkGuJpcKpZO1rA7mmp/8+3gkgGroUnUeL4xV+s8GaCIiGMzsXE1YLTTYkwR+oSRcrSylw7GOaz1F/tWC8XYJ8QtYZIB7Zl8+e6Nhob2PKcKriKrcBcSaAbQ8qElD3wmWv3pVrlJ9DeKT3c36oL8bXeSGOFfqSKBS7Dhb4KyUPeeO+RNQiD4sVbJNH/yQFZVVx7FXENSMTyJ/anYBBy5ueYlDbSnqDSij02xMnuELAE86FAL1jpaeciMr/I9UoUM1LQdNyxE2IvqUCJFujd/C41eHSSE51zBbDRrMWZfmU4za9F/v/igzEpnpFKVKphQuPR/uK2FE=;5:aTmtHkG/aEWYZ7FJw4mXRA6DtXb6tu221f1hgSwZQsdhhPme8EvmDK/tmtdmiw2envY94RjZAULLP6jl8xIUQlUceXX4ckFSQz4mbS85d5Xr7trUTMEop8B+VyVew0fIwFNB/NfbddRMwxpZlrXh+n6VT7hwprdUJEcGGgSJFnA=;24:Lr3nTisZ1XYxO7HgnlufWZ3baHkzA4rhjLk/5hgK3TQOyDk1ZO8hvIFvz43sDeZCUaYW3cShHtM81fvoa7BQjA6sw/XO7GJahxYhsyQhx3M=;7:6yWAysVSEFhTJUhK1VPDx2iawyDP1yKgsEshbvukJZzGo+EW1grFG/nh030BtpqZqsoZc8q6yooXHtXXqEqduy8uygS8JKwq7tMumE2lsi7pD0lveiJtqgRTMD8CyBrnfuwuf9wb1GKg8p4WshkyxuVHyaSqPayWLJt+RF3IEnCtKCywBjFWjWRcXRmitXLHCyfX03FIsSdKYo10+2qu9cfcvYQDpYWz3iVqY5A86E26Ls1hugNoPKmvVlO879Qc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 09:28:24.3626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba2cb8b-532a-4fd6-e395-08d5790d76cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,


On 02/21/2018 12:30 AM, Bjorn Helgaas wrote:
> [+cc Huang]
> 
> On Tue, Feb 20, 2018 at 02:54:33AM +0100, Lukas Wunner wrote:
>> On Mon, Feb 19, 2018 at 12:21:56PM +0100, Rafael J. Wysocki wrote:
>>> On Friday, February 16, 2018 9:34:34 PM CET Bjorn Helgaas wrote:
>>>> On Fri, Feb 16, 2018 at 01:40:37PM +0100, Rafael J. Wysocki wrote:
>>>>> On Friday, February 16, 2018 12:39:00 AM CET Bjorn Helgaas wrote:
>>>>>> On Thu, Feb 15, 2018 at 10:57:25PM +0100, Rafael J. Wysocki wrote:
>>>>>>> On Wednesday, February 14, 2018 9:16:53 PM CET Bjorn Helgaas wrote:
>>>>>>>> I don't know how this runtime PM works, but maybe Rafael can help
>>>>>>>> us out.
>>
>> This has nothing to do with runtime PM AFAICS.
>>
>> The device seems to be in D3hot on boot, is that correct?
> 
> I actually don't know for sure what device caused the issue or what
> state it was in.  George, if you could clarify that, it would be
> helpful.
> 
I will explain the setup used
To the Cavium ThunderX RC the following PLX device is connected.
PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Express Gen 3 (8.0 
GT/s) Switch
There is no device connected downstream to the PLX switch.

AFAIU the pcie_port driver probes PLX and enters autosuspend after 100ms 
since pci_bridge_d3_possible() returns true.

And later pci_sysfs_init() ends up doing a config access of PLX which 
fails with a "synchronous external abort"

> My assumption (possibly incorrect) is that the issue happens when we
> read config space of an endpoint behind a PCIe bridge that is in D3.
> The PCIe portdrv binds to the bridge before the pci_sysfs_init()
> late_initcall happens, and it enables runtime PM on the bridge, so
> it's possible the bridge is in D3 before pci_sysfs_init() happens.
> 
>> The PCI core assumes that unbound devices remain in D0
>> (see comments in pci_pm_runtime_resume() / pci_pm_runtime_suspend()).
> 
> That comment was added by 967577b06241 ("PCI/PM: Keep runtime PM
> enabled for unbound PCI devices"), apparently because "some devices do
> not work again after being put into D3".  That commit mentions
> https://bugzilla.kernel.org/show_bug.cgi?id=48201 but I don't think
> it's completely convincing about the requirement for keeping things in
> D0.
> 
> Even if it's true that some devices don't work after being in D3, that
> doesn't seem like sufficient reason to keep *all* devices on all
> systems in D0.  We would normally use quirks to address device issues
> like this.
> 
>>>>>>> I'm not sure what the question is to be honest.
>>>>>>
>>>>>> My questions are basically "What does the PCI core need to do to make
>>>>>> sure a device is in D0 before it operates on it?  And where do we need
>>>>>> to do that?"
>>
>> When scanning the bus and discovering the device is not in D0,
>> call pci_power_up().  This could probably go into pci_init_pm().
>> Once a driver binds to it, it may choose to runtime suspend it to
>> D3hot again.
> 
> s/pci_init_pm/pci_pm_init/
> 
> That's an interesting idea.  I hadn't thought of the case where a
> device is not in D0 when we enumerate it.  We *do* make sure bridges
> are in D0 before scanning behind them (pci_scan_bridge_extend() calls
> pm_runtime_get_sync()).
> 
> Since enumeration should only perform config accesses, and devices
> must respond to config accesses even when in D3hot, I guess I'm not
> convinced that we need to power up everything (other than bridges)
> during enumeration.
> 
> Bjorn
> 
