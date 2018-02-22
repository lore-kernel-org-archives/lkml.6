Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932530AbeBVNOA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:14:00 -0500
Received: from mail-dm3nam03on0049.outbound.protection.outlook.com ([104.47.41.49]:22607
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932348AbeBVNN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:13:56 -0500
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
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan> <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
 <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
 <20180221095435.xe5lmes7mpxca3en@wunner.de>
 <d0f6a588-23e7-123e-267c-5257c21bb38a@caviumnetworks.com>
 <20180221232040.GA52685@bhelgaas-glaptop.roam.corp.google.com>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <305a9d29-4749-12bd-e0ab-903b58cda134@caviumnetworks.com>
Date: Thu, 22 Feb 2018 18:43:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180221232040.GA52685@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: PN1PR0101CA0029.INDPRD01.PROD.OUTLOOK.COM (10.174.150.15)
 To BY2PR07MB2326.namprd07.prod.outlook.com (10.166.114.140)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15512bcf-4597-4b6b-0d63-08d579f61fc1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BY2PR07MB2326;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2326;3:5XH7Up8dpjwmTvMl9ybh15roNDuAufNLmfgr6bygJD28X6YOHa2QKfdVmBzksf/ROe8akl3Vu8unMb7ZRqBvYaPMKGeLEs30HBo5Uh3rKjUeKX3L3cMnRVwdtIlf4jXxIJelly7Rziy0piYz3siHNuas7nktmY8U2xKj0QU0WzrzO58WbAI0RO3liUv51bcRbX7tMzVEkUp9eds8j0+6q/uAJ2P9hd3JAUL29T4phmo1nTjEMo/cBQyf4XjMya4G;25:WvEcmptxexVnmrmzS4VIBB4Kf1JPD4S/W15qk2rNU85TJvly0YYrA+MVmvprFJmENpPfhNj8QgQkbBYxLxcsbFki4uVwM9S463fALh63VNy0rnNMGOQChWcjYjCJ2ITyahWtE0ePTtKzE9dRV6UfZ8kc7yOqcid5JA0c+mR+cXvS6gynAW6VdOuBsksAPFPuand2O5yGgaesbWKMlixQLsFGYJXPOCGDCS4GBRThPpNlFSvlzOWq0P8Jb+045OtYEqdRZaSc4rSyFnMhZ3yGXFBimgJpLYTNQZsTWy2/SWqRAF7VuZF43RNqap41irpcgKDEm2bSKWbnZdX0KoGXsQ==;31:NUafDwotf6+F7Z+ZyshKcjX8Xk2xPejqo/ot1KORaJQHZERu/8RiH7SwXiyHEKWUBkvPBS8FtKYS4CiNrfM06B5ls/QYzBMY706GTq380qzSe+GUYHMHpXIMdzK4IVhSPrwHdxZhvcllt3a6gB7F0srK1H3EDbfrCqe3C2oKOLnlSPLXSLp9F9pfPWhKKBHvY4sRehE4ZzT8q9cFfHJ+BkI+ie70hRK6xUXgU5MO6Jc=
X-MS-TrafficTypeDiagnostic: BY2PR07MB2326:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2326;20:rbSjwgyrWz01yhNKMpudI931KgjssQ+RibAslKoIURKjX3fRjGtq1N69MdzsNRqQCgovq3QMMeJD37hKaFA0TgYoeRA5afs+uOuTWZXuHOpKbA5pD+5rLyCnb2ov3ApkCYCmya8mPYGsOBkQgWaA5wwrFMKK6O+g6jvK33Nwqi43vrl2+TZFEHVQ0KPFaA+zQ/1O5nuYqPn4yXTOng1uQwLp1pL7/qDQedWbgDmmhGfB8nYDgkqJqlHg2yZahz0QV0qcO2sx3v8O6vkCRcnaHWXQgm1j/mH6nwNs0m15I8VLrWl9vDsJae/gQ0Xy+Dj6VH284BL8urGAbL6Ej41zwV1UEk51YpDcxkGUjHqWVm7U5+FAfrSYzzdGPsqmimQNLi73wiwPwyORqEFA8LBuJJ4TpFT7+D8fubQ15d7uzPzEEiztsUShsqCEYj3BmKFggrvpYDs634mHKWB2V3jdlAtX5+SA5u4UG4kwUusW3EuQXC5WeroGDHWo5aPK7iEwLKwOb0l/y4tdkKjkAa7uSQv+pBGEAxfEBnCfgI2AZ3nFoXLpICXNSUzmmS1rDpvyFeBjRqxixVFRFHJSDP/j9Pz2Y0rpXEEGZhW9bI0v/zk=
X-Microsoft-Antispam-PRVS: <BY2PR07MB2326E9D0E3540FF833BE4450F9CD0@BY2PR07MB2326.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001079)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(3231101)(944501161)(6041288)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR07MB2326;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2326;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2326;4:0BoQEmYJkdwDnraK5DqqB+vJE6OTLD3quUTVwoyT6AiXHZJEX5y1md7wwd6hhiLpySn9C4kge7fXSr+uOXTmsRjK6SzLGNYOOpPDdeoLVmiu4G/sCSpklh0LHwN5o5Duwhnw1L8omrFetr/y87YIE4Y/Ikx7k6B/Iw0mVrm7glmjfL8P+4CNcmGdwX8/S6vnHUsPI2MElPB7OfwU0NMsGXoUfnK1LfhyWf+YwaxoWvEAmX1olBUxqzvC6d6uNj5cZaUkYRb2jX7YGaSXUWAlyKGDMyx6QvVhrKcmrzscrF1/bbueqibcCbxozr3EoJ7baYLdOTzzreUeXyrbiGSaY8LHq/vG8DyjqAfvn5/TOZs=
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(346002)(366004)(396003)(376002)(39380400002)(51914003)(189003)(199004)(5660300001)(16526019)(8676002)(186003)(6306002)(16576012)(65826007)(93886005)(81166006)(316002)(81156014)(58126008)(54906003)(97736004)(72206003)(31696002)(386003)(2906002)(53546011)(478600001)(25786009)(305945005)(7736002)(50466002)(26005)(90366009)(42882006)(52116002)(59450400001)(6916009)(4326008)(966005)(6116002)(67846002)(53936002)(6666003)(8936002)(230700001)(6246003)(5009440100003)(575784001)(2950100002)(3846002)(77096007)(105586002)(65806001)(23676004)(6486002)(31686004)(2486003)(36756003)(66066001)(76176011)(47776003)(229853002)(65956001)(68736007)(64126003)(52146003)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2326;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjA3TUIyMzI2OzIzOlhWVmc5d2FKcmhoakF5b0xPUHlGZlR2b2dq?=
 =?utf-8?B?ZU5CTzR1c2RITHgwV1NwMXJ5YUVwZlV6TnVWdU1vQXp1c3JJcG1ZbVhYR1g3?=
 =?utf-8?B?alpXWk0rN2RQamhFUkZuYjdPQjlWdXFCSUFuY1RySDNrQ0xwZVFyZkZYWnJk?=
 =?utf-8?B?UE1TY0tpNmpEa3RYZ0xpUmdUMkJ0Vkd1azk3RXR2azZIZDlBdUVKbHJkbXo3?=
 =?utf-8?B?aUV5VWtIeVpYVGxhQUtkYXFPbGc5MWRhOXVrZUpka1l1VldjbEtEck8vSTdU?=
 =?utf-8?B?NkhodVBaVzhTVHJ2QnYweHBuN1hEdnlrRFhtempPOVMyMEpFN0FRUjdxd0lr?=
 =?utf-8?B?SURtbTY1SVpLdFZQTUFlK2hIWXdmNCs1dkM5bWxNWVo3YVd1RkJSc2pIRVZV?=
 =?utf-8?B?SEtNanNuTTBFdlVYMXNIaFVVVVQ4dTMrNUVkcUcrenc2QkxMNGsrNVNHYmVw?=
 =?utf-8?B?UU5ENnN2a1ptNDlEOXFUdEVvL2prd0hiV2NIN0s1YTcyZXRCS1VOUUVWZDI0?=
 =?utf-8?B?Rko0U1E4M2VQNDIwbXVPRDB2RmhOTVo0cEZ6YU8vdExVM2lsMTRCeFBabTJl?=
 =?utf-8?B?Y0swOGxwNnNqZXQvS3crVHQ1cUcxRGVmZjBXeGphT1piQnp5alhNVVZiU3Jr?=
 =?utf-8?B?bWg3S1hTYUQ2WlRsa3JnZEY2YWV6cVhoREFpR1E0YTZYckpTalg0NVNHb2tN?=
 =?utf-8?B?K2VlYzFBQ3FURXllL2xLMitFUkI3NkV0cmFXNktjOXRRcUxLQ1NHdm0rZnc1?=
 =?utf-8?B?WWZiUm5RRW9qUGc0M3R5YURMVTZyTC8vaFNaL2ROYTJpVURXYTV5Y0x3THk5?=
 =?utf-8?B?ZEJSNFJlMmlWelQrbThEMk1DYnRUb3lqcU9QbGVMbUROWXFBVWs3ZXhXUjNV?=
 =?utf-8?B?d25RaXlrVUdPeFNwdHlJSWlEUDc1MFFBVjRuVVpZblI0d0N1M2gxa09SelFr?=
 =?utf-8?B?RVJ0Uk8zMVRrcjB3NlUzeldyd0lWZ24rT1lWR3hTdkFKdjVaS0xmaGl6WmVO?=
 =?utf-8?B?VVZIV0N2QVJ1UDhrWklFUFMwY2M5QmRaeXQ4ZTlSc0tFRzd4dWQ1RUg5SU5K?=
 =?utf-8?B?T25PNzdzTVR3VW40SlJhaUFENVdCR3lZaVcxL3pMblhMV0pKTkprMkdmd090?=
 =?utf-8?B?TVdQTVN4c3lvTUpTSGUwd3BHVjJGQnB5WHVDVjlmMG83UkxaWGppMlBxUTVZ?=
 =?utf-8?B?cDhWS1lPME1qZXlQY2JYdHZ4VzZIeDBrNllTNkNtL0Z2QkNnZ3dadlk3QnJp?=
 =?utf-8?B?RDNNUk1HOU5VWVhHZjV4SDVJYnV2NSt3TFY0QjUrRU5CSXdUN21lTC9xbk5S?=
 =?utf-8?B?K2FIdVc4R0tRUkRsai9idk9maUpiZEYyM0ZsN1hINEpaUm1GQTc5b1A4UzVt?=
 =?utf-8?B?QjZlaUZFOHV2bElXT1pKekdZbkF2YWJJR1VlOFBvVGVGdWJDM1d3UEExOVA0?=
 =?utf-8?B?R1NSYVpQR3U0V2RNZlZvQk4xV1ZVbGs5SVFidVoveTZ1TGRVUVNrQnIwNitY?=
 =?utf-8?B?cmJJOUUvSkpYZjNaZzFPdU9oVDFTVCtQZ1Z2Wkg2eVJTd3VyUHZYVWtwNE9P?=
 =?utf-8?B?OGcwc1dIU0U5WUx1TzZvMDZhZ2ttTXpOeXMxSWpzazF1M2xuc3JjZEtzWWJa?=
 =?utf-8?B?Znlmb2xqV0FrZGhaZHNlZC9ZRFVuVTJJRXRHdGErUDNDM1JTVi95ZVgvaENp?=
 =?utf-8?B?aytERENGa1FVRDdGR0FXa24rODZLTTBhKzNxeTJYQ1VHa1Z6TFk2aFhoWjcy?=
 =?utf-8?B?Z05rZEQ2WUpnTFVsTTRwWDZLRGg4SGxUajFqemdodU5sSW15eDVSUzE4b1di?=
 =?utf-8?B?UGs1VFlDVmpYQzhuLzByM3pmVTZPWjNOckwrcUJ6T1MxRjc1ZWpWczNhZXh3?=
 =?utf-8?B?QTdUZFJrZE9IVEV1SWR2MDRiQWpad0tDWGY4ZjBrQ1YzZDRsT3h4R1JPY3J0?=
 =?utf-8?B?WDBuYkQ1M1kycm8wa2xjRTVHQU9yM09jbzh5ZUZqOTFMcnBRQndlZUVrWWkv?=
 =?utf-8?B?TktRanBheFJzT2FTZjVtUk13TUZFcmRNNUQwRVdrNDVYTTRySXJ0TDhjaTBG?=
 =?utf-8?B?L24xRnduL1V5b3FyUExwSmhUSWlZZDdUSDhaR2x2YTV5WnFySDZjU3ZnV2NR?=
 =?utf-8?Q?yCceQJ+396owckF/hQEF05RN6hnqmXyf9Qw2SEMquTLP?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2326;6:UyFaVUU3e4Pf8gTtdXH0Mxx1cwqUXWJh3EgFmYhYP4thK1bATdCOdXkdOnEemkJOqbmYw2nqR0MucPR0wR0sj5V72kkkQ9na4SBqa3iJo/TyyuNJYRcWkoZR59zT5jRzHN3UX10qphqDGeKoHoRUcEFdVBcM0wDL2EXCWmwI3D7Ri6e+sIaf5PYP8GSQCQQ4/+omP2LaiLRyUkDdDZxXdGTJMd7ksSttcmBWoyqhm0ueZ22Q5wJXf3IMF9Uk0lJLDpjbP+739GwQDILz7suPWUKbVi3W1U3YAn9nvu1LXu8RMFGc+PY1/2BSc43MWDdHKs3r4mLztYPmkUbgkPMMPMwrdLdQ+NEVqF4SLoD7dBQ=;5:I2wdOtLudUgeE/FaVDGgdO2ywhZWt+f1gXNm6Zo2fqIOoDcBIsEQJM/0Gde2zHNWDyx8RsZrxQKMbImrDN06YsTx5oobkfyvmVGjYG8r6lBCtSn0IYKHp4BDpSDfJuORCAGMKyw/5y374klk5AQrc9iYsYYEU0OmRM8jInUM7+o=;24:uSEmQXEEOggLxahQhoNc4TUCFEVrtAleFdnPkF0NyJqpQPVC1UDGrNoT2s0rWaBQoEQv6YxLiVzMfYC+XPNWIDEClumdzzcV/OTw0XPjSio=;7:S6TRD8VNcqdGJdryrtnbUEFBbIqVPhWGD6T09nUM3miCdcvUiFchz03Zd2Yf+PsRX4QsDuxfefFxcXGXnxmH9lIP/c77iSFpYV5zx3/sZMOb7ZwEn8/x/XjmxRQqvWfJ6mihWu5GNcTVfs/M4pWRjfRrk5hajlgn9Ey3ecFtD3XLHkfqU0FwhaGxA7+c2zN1Qm0nlvPp2gmQ7qma5CWdHWHDi4kHqj5SvlnfdnjEtE+9gyMUJKOWkGTqWQJ5XJD3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 13:13:49.8515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15512bcf-4597-4b6b-0d63-08d579f61fc1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2326
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 02/22/2018 04:50 AM, Bjorn Helgaas wrote:
> On Wed, Feb 21, 2018 at 04:25:08PM +0530, George Cherian wrote:
>> On 02/21/2018 03:24 PM, Lukas Wunner wrote:
>>> On Wed, Feb 21, 2018 at 02:58:13PM +0530, George Cherian wrote:
>>>> I will explain the setup used
>>>> To the Cavium ThunderX RC the following PLX device is connected.
>>>> PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Express Gen 3 (8.0 GT/s)
>>>> Switch
>>>> There is no device connected downstream to the PLX switch.
>>>>
>>>> AFAIU the pcie_port driver probes PLX and enters autosuspend after 100ms
>>>> since pci_bridge_d3_possible() returns true.
>>>>
>>>> And later pci_sysfs_init() ends up doing a config access of PLX which fails
>>>> with a "synchronous external abort"
> 
> Thanks for the details!
> 
> This one *should* be fixed by this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=bf6c089ee2ac67eb22c0ff0ac9cc7f9ccd619d90
> 
> Any chance you could try that out?

I did try your patch and it works fine on the above failing setup.
> 
>>> Then you're missing a pci_config_pm_runtime_get() in pci_sysfs_init() or
>>> further down in the call stack, rather than a quirk which just papers
>>> over the issue.
>>
>> I have found another configuration where this fails.
>> Following is the configuration
>> 1) Connected a PCIe Intel i40 card under the root port.
>> 2) unbind the i40 driver and bind with vfio-pci driver.
>> 3) Run lspci in a loop. "lspci -s xx:xx.xx -vvv"
>>
>> I get the same synchronous external abort.
>> In this case the vfio-pci driver probe it moves the device (i40) to
>> D3hot provided disable_idle_d3 is not set. lspci tries to do
>> the config_access which fails with synchronous external abort when
>> the root port transitions to D3hot.
> 
> This one sounds like we're missing something in this path:
> 
>    pci_read_config
>      pci_config_pm_runtime_get
>        if (parent)
>          pm_runtime_get_sync
>            __pm_runtime_resume(dev, RPM_GET_PUT)
>              rpm_resume
> 
> It *looks* like rpm_resume() should resume parent devices, i.e., the
> root port, but I don't know that code at all.  Maybe Rafael or Lukas
> could confirm that?
> 
> pci_config_pm_runtime_get() knows that config space is always
> accessible unless the device is in D3cold, so if the target device is
> in D3hot, it will leave it there.  I assume that if/when rpm_resume()
> resumes the parent bridges, it will resume them all the way to D0.

the stack trace for this issue looks like this
[<ffff00000851bbfc>] pci_generic_config_read+0x5c/0xf0
[<ffff00000851c6e4>] pci_user_read_config_dword+0x84/0x110
[<ffff00000851cda8>] pci_vpd_read+0x100/0x208
[<ffff00000851bee8>] pci_read_vpd+0x50/0x68
[<ffff00000852d6c0>] read_vpd_attr+0x60/0x80
[<ffff00000833b224>] sysfs_kf_bin_read+0x6c/0xa8
[<ffff00000833a674>] kernfs_fop_read+0xa4/0x1c8
[<ffff0000082a6238>] __vfs_read+0x60/0x170
[<ffff0000082a63d4>] vfs_read+0x8c/0x148
[<ffff0000082a6c64>] SyS_pread64+0xbc/0xd8

I have tried adding pci_config_pm_runtime_get/put pair inside 
pci_vpd_read(), which I guess might be needed, in case the device goes
to D3cold. But having said that it didnt fix the problem in our platform.

> 
> I'm *really* glad you're finding these issues, because on most
> platforms we would just silently read invalid data (all ones) and the
> caller would have no idea what's going wrong.
> 
> Bjorn
> 

Regards,
-George
