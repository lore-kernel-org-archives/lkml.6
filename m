Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeDQPsl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:48:41 -0400
Received: from mail-he1eur01on0120.outbound.protection.outlook.com ([104.47.0.120]:26686
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751187AbeDQPsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:48:39 -0400
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=nokia.com;
X-HPESVCS-Source-Ip: 10.145.164.233
Date: Tue, 17 Apr 2018 18:48:19 +0300
From: Aaro Koskinen <aaro.koskinen@nokia.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 4.17-rc1: early boot crash on x86_64 & pti
Message-ID: <20180417154819.GA12557@ak-laptop.emea.nsn-net.net>
References: <20180417150130.GA11166@ak-laptop.emea.nsn-net.net>
 <20180417152801.GB11166@ak-laptop.emea.nsn-net.net>
 <951f1bf7-4965-b6f4-fcf8-a22d96f9ef2d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <951f1bf7-4965-b6f4-fcf8-a22d96f9ef2d@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(2980300002)(438002)(3190300001)(189003)(199004)(16586007)(316002)(54906003)(106002)(478600001)(305945005)(68736007)(58126008)(1076002)(2906002)(8676002)(97756001)(229853002)(8936002)(53546011)(26005)(23726003)(81166006)(966005)(81156014)(77096007)(22756006)(86362001)(44832011)(76176011)(53936002)(46406003)(4326008)(11346002)(47776003)(97736004)(476003)(7696005)(336012)(186003)(126002)(33656002)(6916009)(6246003)(356003)(59450400001)(26826003)(446003)(106466001)(55016002)(50466002)(5660300001)(9686003)(6306002)(486006)(18370500001)(473944003)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB3887;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT008;1:IVBpx9TY/7oWy5OkN0PzxVicHHUTirCytqEi4CSL6IKPlqajvlU19lLVh1zUiHMIAFBq9f1bVjSlhsUhGsdJSM2zdHZsuWyU9FK4MozUP/K0JwdbP3NNkaImxYwYDtrg
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:VI1PR07MB3887;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3887;3:AZsitlvFatmaoDFKqz9iWF+TTsBIiOCbq94UYMTdGRRurMdVTN6Tn7Hqigr+9Ib50tHVDXCGRmzLkosn21Dh3i3W7CD5up8MuHHW6YQKayBdL3ymynEYL9iB7PjzLnBWUlrkKQpSk+97TlmSXOuDBawa7o5mawM6HszGZebpfxPTZrY1HVE7fpUI876reGur9MtIQoNFVppxsgqYKfB3sd+zEN6h4VwmVPqNmAmbXaopMT9U+FoMZKTGEG3mHZFZeBQdlYC54XB+qhsKU2sXYhCoqGLjI6Lgl5D6AFfRe4tJaXNE2CiCF8CyYVYhRuZRhM3IUPtngNZPaURNoJKsec0xU6RR4ViiJknMSszBw7U=;25:oIgXFI6VTucl5nI2b0/5MmdbiOlx7upVSR1s72/UkZJFu3VNMlSQaMZmOZlXbU3M5s/OzgXo7iVjKhbmJExUJxon2p/iTv3w8UnHO7NYkL9UCXHo+RCk7Mf8Vb82PW0L/K8O0L8YeXz9z8/emUUgK2T90Di7J0L6vp3Ufkb/4URIgpP3FWvlwWJ9Ws4OMyZYIx7+lPVAJPjge1ckwSRcHiGIYt9t3UaibE5u4Fwe51OrXIdb/knkM8/CkDQ1rghbkRISjxj82XmeO5ks3hKr8gS8I/M3ldIk/Mi6CrU9DsHcfP2GEBf1EEqun5HyAcJf9Yk636ve5CbuTxKgFovPSg==
X-MS-TrafficTypeDiagnostic: VI1PR07MB3887:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3887;31:xN/dxKbjUZ3g9eJWlq0cJHy9Es4zp7/0QsrlsgsRjKUJr+YliY4jIW14ATHS7WiqibOOpQS4JilR5TZ/YQedW/I1lvcsbYB5PKbmPJmpiuhCXxtphTzoUx3sBByasgd+scUtsaVDVMjI5gKdy29zklH0slG6fOBmyZ9E9TqG6TYxNRmCK4hSva+QeXu9VaKSn6hEMMV6z82TWcyKp6ZXDuVjd6sa24M8yQIdYgLbShE=;20:3+hmDaMjM1Ur7o/ek2OfkebYxJwZnA/gM4g1TFAQ8ujZddgoFwuR2dpiKdVqAHtEz3/4DH06gzZPPhuG+X9T7erarNRdsITSFK/COdq9+IIsxZ2QiY+4zm5im+aaFfoq1i0Nt2c1I2b/iasOfeO6tfy68+TroJWCiBIOeLAk/9vU0BdpKV/OWtLvQnvv1BsxlGLIyFVSJpjA8LX+kktKm2I2QVI9XBrBC0BYdDTk4zzoq8qnfcoDOakIkq9wlJEuWZEHwn+Th5Uv4IejIiRmT2NvNQyG6Zrd/KiCbBRujDUa+AYlOa7EkEXNXBheuz+kBjRAgi8hoQjX8ga/SUaZAhxXSrdGBzwlGgcirH7K/Fgj6IBMMuTqQ7g4j+zeneJ+p0JNQsKIGHkRMrD7dKixwmfDEjxq27bzjPxejFREnZRKJVh2Iaf7mvAJcHbzkkyNaqvzwdfsCQyyYeJkCD77XH3lpLKTcBpPrHX6oTnz5qPOj7ratSrY+eVGEHnWkyqNa4meIIRS5Wp9E3sRGlYom+vWJt6Jl5Wu6EBToNjr1SZEEZWoMx5c0wT/OjoxMVNLdANR5fYu0bnzqTsPk9GY4Xl/MYZPjUBRAY0K5qyDvHY=
X-Microsoft-Antispam-PRVS: <VI1PR07MB3887B200A40A7D42ADE2200BF4B70@VI1PR07MB3887.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(11241501184)(806099)(944501327)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR07MB3887;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3887;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3887;4:qXKWD8aUl3tmP4TOEXiIUS8bt/MFO8SdbrBF5DnVDXLBuVg35xelN5ePcuOT+CzgyrJhM46qDZysVobmp1lYZ08VK7tafrHeDA6ycR3gCHmzz73SUdilgDIvU7ed77w44j+NPyvuR3wA9JlLcIFcyv5LPjia0kejoWMeMplaFlcgvR5fGQgo6E3VLs0vzTYuusiSCrap28lCWpDx0kJED+wJoC5C2nUjBzVve3lk4yIecaAtPqJSO6oitmgh27ZyKndEmdO9HDoCeTrJ5A9wwA==
X-Forefront-PRVS: 0645BEB7AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB3887;23:q7Y6Qmn+MDHU+lA6kwahUylVPRcHBo6/IRi1Q5Hp5?=
 =?us-ascii?Q?8S+F1wp8xBcgnECJKWRjqly99bL+ag+fiA/ZsBfQ2kayTkRh+UAe4ksgw5JQ?=
 =?us-ascii?Q?T7C0VhGez7sy54Fc9hkcqGwVVYKR4ZtgC5bP3PAi6/47qxFdtkA5lsxPqgt1?=
 =?us-ascii?Q?VIkn/DRb6fqK9X+44FGkvHYsJoYQfwAHG8cOFb5KEKPe3ns1ej6C/eazX0No?=
 =?us-ascii?Q?3iVd0SfKUk5gbjrBr25X9vwWHuAPf4HWBF6qfkHbQegjrc7I7PgOXotmQxSb?=
 =?us-ascii?Q?n8XkmgusMisb7oH97Hgzeh6i3941yx4OFbDjYc7qmRJ0J6At2Of9T2KFwrP4?=
 =?us-ascii?Q?WZ7DzO+6C0V266zAX29iAW+Mge2+W0847v8yC9XKDzaT1GEyQG2fj3w1yMiJ?=
 =?us-ascii?Q?GCNZhSNm9nxV3Jqxht17+yxnVWii3yzvWlW8st1vkB1Ym00xpdVdozt/inQP?=
 =?us-ascii?Q?Vq9DRVbcyZgTFj/x4PnUnTM8zbqng9/GCueJfmYkcQGLDYNSQGjn/0tR2sVo?=
 =?us-ascii?Q?Bp3+bHTIyc0qF9TLlIE9b1K1+eROz/TO8N0OUhsfd0NKY0WBKbDMimLKwJ0T?=
 =?us-ascii?Q?RvsBbQp6ZIHu4bAycOAe4hnoEJfwDy72OlvK4MO7J4jfNvN4Tp9KMWmfvqn4?=
 =?us-ascii?Q?ItF6ODnxLzQEPNDNOo2Lcqk24hMmK1l29IjUzIWmlZ615K4MMC5SeLNKvmq6?=
 =?us-ascii?Q?KfFdb2gLBi281ZZLNZKhuL3ZOmQHXRNdFyIriB4SdsP2TJmdcgKLXbZBMDbe?=
 =?us-ascii?Q?hjwuVMC+q2HVBZXCO39KOVUBeg33fwoUsAZngdNlmTSDy2xXMbxE2vtEKPjt?=
 =?us-ascii?Q?4jb0374I41aCEM8zBx7WvDAalYkV5KXnaRTPrtqwoDKpKECYoeZRs914JI4E?=
 =?us-ascii?Q?cv+TFIdU8woI2WKVCHw+pmrOymrYSqH3qVtAThh4WtDD3+0Q5k5k12JyrQKy?=
 =?us-ascii?Q?3RUQu4+VphIpXvaAmQpc8RQaveL1hFZJtLyuMTQKF0inoCXMByXRmf36Lz9Y?=
 =?us-ascii?Q?m0+BtOJxjdkchcUYbV7nNeRMcDxzY1AY7HUiDCvBaL3YG4FugeGg6vYuiZxO?=
 =?us-ascii?Q?1RfvIB9NIX65VnaoXv008VSZnxtdDXY8pPlDRcF3hhWHpQhKcOv0Oa0QdgCx?=
 =?us-ascii?Q?RcWN1iIX6bS8C6g4yrgJyfzlxmGTM0loBT6Nb24JADWXbKkWUQgNt8/5Ij6C?=
 =?us-ascii?Q?xp8N1qo7x+iIXSG0a9h/pBOmceFTooz3IPgYxeg+hN/qq+aY0eapj2v4kkTp?=
 =?us-ascii?Q?NrdycdFkuRmWnWUoYQ447BMBWa0TM9vehyjFv9gnGWu9VxQ8bbnFPeaVrb8p?=
 =?us-ascii?Q?1YR90EzEIjNNkGT4EcIZM9yq8ocHASolWW8xxU98SgiN8LhFdq/jlw8gHPnT?=
 =?us-ascii?Q?tUi/EsJct3XbhJg7bU8FZ0IswM19LPnroxo0gB5p91ZusNWQX6ITXVuTnfx0?=
 =?us-ascii?Q?UYVlrWGKg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3887;6:LU+ntmUFbBAe9wer4vdWgmNbHp1jsasR5k2aEVn+A6/DT8+YqC6L3Ddigb/W4esXrmwqBPxpowFjP5X7WRVJMPQn8uftNBQ5Z42eBrly0xrr5/9Gxo+fQKbhFC4DAmwLDfURdDue2LmdgaIrDtFq+DWUBuEjXsAwScZ+LjJcBrhkOsks4woMGokWGQ8ICUMdcNZOiwYZoF8ftxnd9KNk0Of1p6/okKweJsul/C5TyFeI8lQ/f57d3cbKglz5vrm1X5bnFqWXlgHuHICdV08Me+bcOsKeOdFlOXxoMxCfscKS7MaUhbWGpVZ5/zfVvpX8v9nQO6ntoJdP+YJh+vW/YmP/kM/aFbf7os3i/oJQv3eXyy1hNtfp9TlaHGjRqs/EUYgGYYNSlqUQ67FGltbLXSINuX7Ue2KkJzqZUxuDYSuI7ZNJqSDw2gt4SjJR3U4kkmAwTNcUj21p8LtBoYhnNaTpYOMPphhfFvRzeY+tyL/41VN4ihCFuqH+l8bh8inh;5:FQ6AIMUMIx/X4QNpMNt1Kvpfu4kSdF33TiO6+Hoxo6Elj/UrlGgaUfe8qSeLCz/TK74GIwIrCuhe3MGnjJQ8E9yXYFmXTABbY81uxDQqw9kNW7uMUJ+nSu/QtchO2oagDrdcIEXPqLU4SaZ1RtP50Y3rzc7oKT+/EZztQYpvEoA=;24:3gQ7tc3VIIoBpHRSnwzp5qvnqsoktq7e3NhgsofsGwF3cMlfINuoupLaZ50DgGQASQiEVQazW74CCarHyf4wxfLmGQU8t+//tXU12PBB6pk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3887;7:lBxrBPdCX0i1Q/FUkh484LkzKYxxJUTgKd41YEhQGOalw3fYPKFA9v5uoxQI25CsQ6LQc0Qf4XfC70c8Pm6wkffC7CTijz+xat9Ir/0T6VDOtp6eTqYOB+8n7SfhaFvgDk9M7RM+eTsf3QEiF8p48Ozyg1EypBM1ZXoE+Y6r1CHs1RNfmiEWfOvWzCnuwBFYg23GN7Aefivm+ug9czH+1z+6TZfe7o0arkqpw4Recq1DIjD4djp7HJWwdQX9k6Ce
X-MS-Office365-Filtering-Correlation-Id: d69a0b74-b41c-4e50-0ce7-08d5a47aae58
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:48:35.9202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69a0b74-b41c-4e50-0ce7-08d5a47aae58
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3887
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 17, 2018 at 08:38:18AM -0700, Dave Hansen wrote:
> On 04/17/2018 08:28 AM, Aaro Koskinen wrote:
> > 
> >> [    0.000000] Kernel/User page tables isolation: enabled
> >> [    0.000000] ------------[ cut here ]------------
> >> [    0.000000] CPA: called for zero pte. vaddr = ffffffff8d000000 cpa->vaddr = ffffffff8d000000
> >> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/mm/pageattr.c:1189 __cpa_process_fault+0x4d6/0x510
> > I started enabling more .config options, and it seems that enabling
> > CONFIG_XEN_PV does some magic to make booting work... But I shouldn't
> > need it.
> 
> You're using "-cpu host".  What is your host CPU?  Also, could you send
> along your .config?
> 
> I'll try to reproduce this.

The config was in my first mail:

	https://marc.info/?l=linux-kernel&m=152397738329562&w=2

See /proc/cpuinfo below:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Core(TM) i7-3820 CPU @ 3.60GHz
stepping	: 7
microcode	: 0x710
cpu MHz		: 1199.707
cache size	: 10240 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb kaiser tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 7200.22
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Core(TM) i7-3820 CPU @ 3.60GHz
stepping	: 7
microcode	: 0x710
cpu MHz		: 1208.276
cache size	: 10240 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb kaiser tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 7200.22
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Core(TM) i7-3820 CPU @ 3.60GHz
stepping	: 7
microcode	: 0x710
cpu MHz		: 1207.836
cache size	: 10240 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb kaiser tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 7200.22
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Core(TM) i7-3820 CPU @ 3.60GHz
stepping	: 7
microcode	: 0x710
cpu MHz		: 1199.926
cache size	: 10240 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb kaiser tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 7200.22
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Core(TM) i7-3820 CPU @ 3.60GHz
stepping	: 7
microcode	: 0x710
cpu MHz		: 1235.961
cache size	: 10240 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb kaiser tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 7200.22
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Core(TM) i7-3820 CPU @ 3.60GHz
stepping	: 7
microcode	: 0x710
cpu MHz		: 1199.926
cache size	: 10240 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb kaiser tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 7200.22
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Core(TM) i7-3820 CPU @ 3.60GHz
stepping	: 7
microcode	: 0x710
cpu MHz		: 1199.926
cache size	: 10240 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb kaiser tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 7200.22
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Core(TM) i7-3820 CPU @ 3.60GHz
stepping	: 7
microcode	: 0x710
cpu MHz		: 1199.926
cache size	: 10240 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 7
initial apicid	: 7
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb kaiser tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 7200.22
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

A.
