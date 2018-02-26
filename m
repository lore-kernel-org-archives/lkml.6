Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeBZOKo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:10:44 -0500
Received: from mail-co1nam03on0063.outbound.protection.outlook.com ([104.47.40.63]:10240
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752652AbeBZOKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:10:39 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
To: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <helgaas@kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: Multi MSI with multiple End Points
Message-ID: <d1cdbe97-8ed4-c4d5-0b1f-8d281b44871d@xilinx.com>
Date: Mon, 26 Feb 2018 19:40:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(305945005)(5660300001)(3260700006)(36756003)(9786002)(356003)(65956001)(50466002)(106466001)(59450400001)(336011)(26005)(77096007)(186003)(65806001)(65826007)(6666003)(64126003)(5890100001)(8746002)(8936002)(81166006)(8676002)(81156014)(4326008)(31686004)(47776003)(63266004)(2906002)(36386004)(23676004)(67846002)(2486003)(106002)(58126008)(110136005)(478600001)(316002)(31696002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1460;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT053;1:nIc0li/wl7JBbwrpVnljZi1IKgGWBPtK0QBziOTMbC4BfyM0AMDsyyyirPwv1MmTILYfxZhoLvWBCGRzoKkCDKn5KS2NZaek2jMpbFxGzMbNnPX593mt6ejbgFELnFVs
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c15bcd2-7c9e-4ad4-8c2e-08d57d22b541
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:BLUPR0201MB1460;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1460;3:lSSarEMs0xU3vxpyjrYkg0s356rvSrqgjfMJFjmF35H9/ImOhujCukVrvHz3QUzaLeyrbNBzrNHdJGsdinQOQxFW8rYLNYV/To3QJwbYi8MqEytK9ibSw6T0xEzUc340IKZ2d+faZuFxHCJrRZ+Tb04Um1ZyG8/rmRw3Z8AjxvP+XHt1ArPf5rAXLLMgC9WkWGgxyssdLTwj6osxULutUcS+x1o+ulIBTjKA0fV391oonWx8caXG5ClTRq43ETtkEQpjDWQrxMC++yiezMUPuqd0pcPVc9tFvbVMze7md3G4+pYspmEfoovKqQJAoLNmRMYvWgUb1haFNB8Sm2GRs6TAdmMlkupEruQg9MesxmQ=;25:v+iMElyxL+1lNihA+bBWDQWVUkUdjme1ya0N1ASuiv/79OZ4PKrw6/STJX++fMfeXWkRnGayHB4Gnvph11MfTIy2Sn2Hgi0YclojHjyuqpD5sLTYCc5yK8DTRo53ioeKwu3x2ZoVhhCmXcMuv1vZu1VV2+R6zjZ4fAqwSlhF0p9uSzDNwl+QMYpER6zd4saK8plK47qu2OTGbbAbFWJe81h4Z4cMd0KSPk2gS+LonrUBLQaKtbZggdSXz1p4uZIqnIQP8+oT85dWiHfDvju820L980/cxTL278SkK8PR/Fja+mV1MGqls7Hb8ObQtiCFx1WSiW3FCK3xCETSdcuhJg==
X-MS-TrafficTypeDiagnostic: BLUPR0201MB1460:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1460;31:UzY401lFmXhUTv+i2aNHs3fwx6wsq3PKqFY9qwmMqHHQCOyRP1I8bMDnqZkCK54SOtejrcrlveSEpPXnOd4kL/itMvWIS7IDwbO3GobuglSJMxpvJ2NayStj52WclInI5YuGbphjHPMsvKwOaCKXtXaoghOjB2UoAyopGTSMCVsItDQwbvNT3S0TIXK93W+Sj7n1jWNunpXI6qkhkCs5udTshIYwq7fxiNPqtvMWjpo=;20:agSAGShiMmuClJp6o/Qr2/6uKLCrnm3o4OkfDMhlUC4zfoBiJkRC5Y8Wpo/hqJMWuCS9ZyGJQxS38Z9hcVqpjQUjIZh2mBf3xK+Tspiq7pl/Rt04C0h/UWHY6VpOAFq3RQgHkOwAAvuE02fI19VgBkmxND0Vrw+H7TnWpbjOYCedW0cw+wa6hNUPNug2j0cktZ1kkPENW6u4YslY7UbJbzOGRLWjLYK7+cjpDHaNtnjyx8If1kMzyaAKvXV1tPq9iqpZnAYqVrlO7FDhyLiOminRG/MeYzdLNVm9L5dx2xtVOENUe1AXUx0zGqkSky4KdhuAXOAS/kSD6N8wVpmLj+9+YRDBw2f+Vbfd5lSOgNPp2asObGPtI40F4tkHBcl/8PG1zbmSqVp7RYVYI/ueQGc4u/WmcDCgQ1ULd4Z+5zB2Hdbx5RWELKIdXuDqtE7qcGGvewqrSGVUVvReuxpmrkJIRGtjWxZTEJH0R/fmXyV4FDShZGL0ToGrOI8WH8YT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR0201MB1460F5248C411F3F6FAE2170A5C10@BLUPR0201MB1460.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231220)(944501161)(10201501046)(6055026)(6041288)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BLUPR0201MB1460;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1460;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1460;4:rQMv0aYf1iGyhqW12k+RD7AwVR74tVxlCq+FMRpi4iZwRrKoRvI1wTiRaJC5M84N+dDVyv0h9yCNnOZ6ids7de0to1j2mvRF3OEN8p4rTlVfGWJllQoGH4xcVU3N7uYA5y2yz9kFk1MJc7ozOXWsf/2+hKkI2YSkIZUl7Px3H/anMuotHWtbMZu//wWLKLwi9RXoO1YdwOiTbao7dt5pKoPplddH6SLX7FEoUq/pEv/+oV0Vsp3t53+y+Eg1EonWA5pgDgGu/qE9awca3WJHFQ==
X-Forefront-PRVS: 05954A7C45
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAyMDFNQjE0NjA7MjM6ZUF1dmVHTzAza0lCSlFjWC9vQzlPUStv?=
 =?utf-8?B?MlpvT1ZRRkNjaGp6VGlGQWxzVzY5SWZyVElQbVBJdEw1eERkVHA5VlIvRlhy?=
 =?utf-8?B?ZWRDbzdTdHZXa0ZtaGpUWUMxbXpCVWJ5U1ZLd0ZCc2c5UStuM2grdXhkNkVC?=
 =?utf-8?B?NzhsaG15OGgzN2tzSXdPYlFJOGxWTUloR0pqbWdpOEp2RGNNVUtwZjNlSTdJ?=
 =?utf-8?B?OTgyOTBNaFN5VmplSGFyMlFnMFkxcFpadWJBU2loUjRQQjlwc0MwYjBsVkxq?=
 =?utf-8?B?OGNEZ0M5UVpKVXlUTThKL2xWeEIreWhScE96a2gyWDdKMkdySjBQcVJ0SEFx?=
 =?utf-8?B?UHdiREloTGJPZDVZWGxDcGswVnlra1ZiOGZ3UmhCckxuK3IvRS9WNjlIUUVx?=
 =?utf-8?B?V0xsVVhVVGdkRHY3SVZDZE4ra1lWeHVoUGc1L0NaV041QTh5aVoyTHZyVHAw?=
 =?utf-8?B?cjhqaVlMWW1Tc3RyLy9MaitVYTF1ZVdyd2JmZzBCakIyTzk4RWN1azhqcXZ5?=
 =?utf-8?B?TmZyVytianJob3BDdWRPQXZXT3ZUc0twcnIrNnpKMFFUeUN4M2FGczVUWHBq?=
 =?utf-8?B?SWozRXYvVnNRUjZSU2VhemhpaXFYUmxkc0ZnUFhjSmd6OFcvbU5ITHoydXA1?=
 =?utf-8?B?Zks5em0zQmVkdE5vOFhyOGpVeDVONzVlT0hBSTBwcHBTdVdVS2kvWFRNdzdW?=
 =?utf-8?B?THIwRVdXS2trSjhFWXBUZUIwMFNaK2Z5RzM4Q0JHNjlVOEhIZUFoQ1p5a2h3?=
 =?utf-8?B?WE5GanRXblBkdWdmMFFyM0o3L1JyaEFZSSsvS05RcXZucTZlSElhT3RGQ29r?=
 =?utf-8?B?RG56WklmdENQcjIwVzFnUzZGc2FrYlQyb1BCNExOU1VzaTlLNWk2UWEyc3dD?=
 =?utf-8?B?WDZOTDhFVlpxTXVVNU9aTjM1R2JMM1ZCNzV6cEdQZGdqM3ZUMnRDcmxVcVZp?=
 =?utf-8?B?dTVydnJlM3JqcmdoOGlLczJxN3dlMTVRenFpY3FFRzh2eEVSeEVZcjl0YkYr?=
 =?utf-8?B?NVFTbFUzZDNKdURyQTVRZEl6MjczKzArMC83d3FVSVdRUGlBanB1eWlFTDFU?=
 =?utf-8?B?T3FDdkV4aHk3WExKTXNXZVlnNHI0NVQ5c1VKcE5HYVhXU3NWRndPWmpkOG5H?=
 =?utf-8?B?dXl5QWtXYitXdnhwcllzZlovK1o0UHNkZVE4Snc1VXFya3R6T2YvR3B5U05Y?=
 =?utf-8?B?TFhiakxoeWw4Y1dxc1E1elE5cU1Vc0JhbzkvUDI3dGFrUXVNblNTRzNTc0FL?=
 =?utf-8?B?a1BYakF5YTVVdWU3K0JiTVJGbEZwVjQvd0hUbEJDK3UyNnkyd3RlYXpIR3Fq?=
 =?utf-8?B?R3UyVW1LQTk2cHlnb0kzNStoMmhrVDNtS1R1TU5JMTMya1hxR0pwd0d4L1J1?=
 =?utf-8?B?V0RCTFVFeTNYQlhORENQNnI5UWpybFhNWWV0ZFFNYVJYc3EvYlNycmtMSSs4?=
 =?utf-8?B?QkJOL1lkSHVKSndlVlFQTEpjdFBHWDF3NzUzQ3djaHN0YmN2SUo4R0JWaEU1?=
 =?utf-8?B?dDRHdktqMjJiRGZsU3JXRWc4TkE0SHRKc0tGVkMySHFZQzBNODhmYlN5TkND?=
 =?utf-8?B?OXhaMFA0YnJFMzRzNmFDekJheXlpMWJJUT09?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1460;6:e8+IQ3rerw15lWAtcw4NoJgjO2oReS9jSPUxrSFarLeaV+kUlBPUFTXyv6mGJ9rqZFSpysb6h0K8/f7jXrT7py4+S/wRTt0lsT1Dv+U6hX0kRgxr69jc8vTz+L7jPVlO18nCsOSsOTNBp147qtU5vq95val8s5cs4FUUaKQbTWpQBuA3DFMSIc1oXYYINoqd8CizV9kFvE7Ywz+6ePCTjW2oZnMxcVkuCxEfMcQKBLj1ubHAm6+TDmCAFvUI866RtUbTuOZ+KXXi/SAVqTkfpQW4dtJkuEc6WSOv4Y7XiAmRXqa1FFKt4lbmOrMDRZZmgnzNN0+UnZJQ2swZM+WbDDFSORFLnk4I81kH7ozjsWc=;5:5QVfeXE5LNcz9kcmQ2y/txXXKY1UQKE9rZLxrL3DynUgwByVz47Is3KdblRORAzMhCbOXi3pLQgvNzouQRNggNIdC/KfsHvlAzhukoeG5S6hwtBYHPXN4NXoH2b+FiqOrPmTeT9fMQwBF1VhtA2zeW8zE82VS6KMt66QvY4+gSk=;24:QV9ObSKj/vZ8FXS5pgXCEfXqysn22zgyC+/9jVifXVSAB2xbJeLFP5IpwzrNF6SmeAyvjPD25UyTK13IweG1Gu/ySvZ4A475fomWZD72EX4=;7:RxHeal7d5lupyER5OxJxfWMQI/cE/8DiRVJn9UvRHCIYvzGvV12ZqjySz/p0cOT/ZYxKD6Ar52HMMhHQsuKQKpq6bwqgLNmeY6aMPFzZDdh0V7+OB8RX7LpYUFE1ImUeIZV1zOQDZ4a8ktw8l1jAXZhsMk6fpCETWQu7r9g4Ye4NhKXncbf3XPB9I8eqdl2li/M+bgkXLHF0j4YXVV7I7Bi/N8QUNR2TFA39pbDdl6YUF6/m29U1rSbam9ETUe/C
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 14:10:36.4406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c15bcd2-7c9e-4ad4-8c2e-08d57d22b541
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1460
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1QEBaCe022541

Hi,

A switch is connected to an RC with 2 EP’s, the RC supports multi MSI.
1st EP requests one MSI vector, 2nd EP requests 4 MSI vectors.

If we are programming hwirq as MSI data (hwirq being obtained from
bitmap_find_next_zero_area, with number of zeroed bits being requested
based on number of irq’s being requested).

This results in 1st EP is given zero as hwirq, 2nd EP is given one as hwirq.

If we use msi data to retrieve virq (use msi data as hwirq), Since as
per PCI spec lower 2 bits of MSI data are modifiable  for 2nd EP, if an
interrupt is raised by 2nd EP on msi data zero, but this is already used
by 1st EP, so the current EP’s interrupt will never be served.

One way to deal with this issue is, using bit shift operations on hwriq
before programming to msi data and at retrieving.

Is there any other way to handle this ?

Regards,
Bharat
This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
