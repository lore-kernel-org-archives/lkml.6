Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeFEGD7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:03:59 -0400
Received: from mail-db5eur01on0053.outbound.protection.outlook.com ([104.47.2.53]:37002
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751632AbeFEGD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:03:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com;
Subject: Re: [PATCH 6/6] x86/vdso: Move out the CPU number store
To: "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
 <1528140269-26205-7-git-send-email-chang.seok.bae@intel.com>
 <8a41304a-3517-003a-badf-1ba8f7ababe4@nextfour.com>
 <51587908-9652-6a8e-0e01-f387e3ae5852@zytor.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <696f744f-be19-8709-e037-d3703bdc8f0c@nextfour.com>
Date: Tue, 5 Jun 2018 09:03:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <51587908-9652-6a8e-0e01-f387e3ae5852@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1PR09CA0065.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::33) To DB6PR07MB3334.eurprd07.prod.outlook.com
 (2603:10a6:6:22::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR07MB3334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3334;3:u8lIxEUWF50kEtcMcYA/jL/fsET8/nS2QHbkC4ZqOp2Wr2Gnnm/RGaxIEk6PVVkzI189R6oxDVMKMLvcWalfVQ2m1YUpSMl6LvIjUQQpBd44VPyFbswbwHR6PcJd5tnwFMG//CsTeIqA/3WionbEkT/k8I188kvhZTFzv56ioTVP2aGqKsNbbNNU4aBhRTY+ODPN7u7ykrs2aM/cZjd5MmUL1J0ouKAGoa/DxfZ//8Jbg8ExFCJhpXdAWDIu7Ze3;25:yS5fCcQ/rAvybMAwZjcVbsyJFp4HVbkuJP5UILDi/1Sc3OGO1cWl3Eu8Hck5dLJFaI87JShCq1+D8AloZJhLEqpSnu3kS2X7kYyHGToozM+TlgjW/OxjR/D3cNia0+1PSjWPOPEyFHahaSmXLsAT/Mz1VP+Or7Kwgl5lYKKHahGzrsR0U2a1Bii4om65K57Rn69lWvNO3sr95BHFW0Axadpvr5ms2G3eKHgNWXevUDfVBptVvAc1dGfYyHefRK68oC2tbHGZy4uxzrm6cHumvFiauGAdW2j8I5VfBWzkMZAL81gixfYIN/sV2H5sshNi902i9XffRKUuNBYJRDCtUQ==;31:n5k3LzamYd8GFrQWcj3PiWkMI7x/bCEXGiEG1M8oW8ca1V86h5gx4UaoMfsqPEL2o6fSOV9ONXkcPJDfNRw8KdKhX6J652FAAWE4zcGNAtBhor8pZJu99BP3W5/8FRS0JjN12k/HrGfFPe1TDSR4dR0CACmxgPSAKQMOzYEpDm7W8fUT3IhwOA9rgZ2LPonD6Te9ziZ8Medjxy9fl1NH49Zh3tYafG95aHPyDs9ArNc=
X-MS-TrafficTypeDiagnostic: DB6PR07MB3334:
X-Microsoft-Antispam-PRVS: <DB6PR07MB33349E8B882B6480E3D8C69A83660@DB6PR07MB3334.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:DB6PR07MB3334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB3334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3334;4:KQ30LU6UQW8rJFAfaoHg5cnnCRxf5y8IGd/4iDsDvcrVK+pDkDoaVX8GW/8IOa2ZreZRF/WBnzB6SjAVX771DxBFsCYwSPqiUbKH+bTkE7zlHMfgNFlgxjS+4s1r3xiiGaS+a27qp7yawUZuQE1eWVJdSXm8cfa0DElXGmUIigVS7hVjjq8IvAOXwSTq8quE5hv8BlqE4gz8DXttCH33vMei9UIR112N2kW6/zdRNE9wBVgvbqU+pMc+XNZ6zfvfk/T7GXAuwobEFZYbF5X8Lw==
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(39380400002)(39830400003)(396003)(366004)(199004)(189003)(77096007)(65956001)(16576012)(65826007)(316002)(93886005)(7736002)(561944003)(16526019)(5660300001)(186003)(110136005)(54906003)(68736007)(26005)(4326008)(25786009)(6666003)(6486002)(7416002)(81156014)(8936002)(53936002)(6246003)(8676002)(2906002)(65806001)(47776003)(106356001)(66066001)(81166006)(53546011)(105586002)(86362001)(31686004)(97736004)(76176011)(386003)(58126008)(31696002)(486006)(229853002)(476003)(52116002)(305945005)(64126003)(478600001)(11346002)(2616005)(956004)(2870700001)(2486003)(50466002)(52146003)(3846002)(446003)(36756003)(6116002)(23676004)(59450400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR07MB3334;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA3TUIzMzM0OzIzOmxsei8xRVUvUHR3TTA0QVFkMEFZcHNKRXVu?=
 =?utf-8?B?WFVNZElWKzcyVUFhZDQxSElQd001M3gxNWlMR3RYQURNUkZoQUdPVk1Ua0Y4?=
 =?utf-8?B?aVJ0dGpTTnVtZWhCam1URHQ2WXhZMjJMWXRkWTdNaXlTRHZjYW9wSkdackJZ?=
 =?utf-8?B?aURpd3JrT1lpVDcwOW1kbHczVllRZTM1T1pCTktvdk5yMHpQVXZYZG9nZmxW?=
 =?utf-8?B?SHhRY0drVGh0UDRQNDB4aEV5YXMzQmlaVVZYUUE3VzB2SDQwMldEL2NpMVhB?=
 =?utf-8?B?VTFNOFJoS25HZFVNSlIzMlo4NG8zNUFuOGtVei9wOGNqcW1Qam4vbnRkMFF6?=
 =?utf-8?B?OWJwSnl2VHlnYXY2bUlIWjVoSS9LRnFvbnZ4bzk0K0JLd3VpUWVqVTdWejVF?=
 =?utf-8?B?UjdveEVoMHdONHVkWXo5QnFFaXNVak9qMGljTERTQy9uaExLMU95YW1TZHVz?=
 =?utf-8?B?Q283MzRpQmFxWkczYm9GYUkwRnNvR0JPcWc4a0FKU09Fcy9FZzhsUVZ2WkN4?=
 =?utf-8?B?Y29hSTRPdWJXZXVCZWIwVVUwTk9SYVQ3elBmc0FsOXJVcDJKQzNicXhIdTdu?=
 =?utf-8?B?RTBrYXJRWUdqekVUZm1jTHplWkNjTmpVQWpsTWp5akNNRUlOMGwydXMwc3ZL?=
 =?utf-8?B?UUIvYTl1OVRXT2s0dkJFUTdzK3Y0TUZMeDhXUzN0Qi9HUkZ1RlFzVm5nR3lM?=
 =?utf-8?B?SENOVDhMWG1KVG5nTGZneHFHelJiNmV6aWRUNlhJU1pHTkhkMW1wSFk1ejR0?=
 =?utf-8?B?S05CNGhoQWNEOHFMbytuanJ0RnBYNWY2aFJjTWRpbjZxaWRDODN6ZmpNcy9S?=
 =?utf-8?B?WUp5UWRteDNiMk9wV3djdHpJcktBcThVcXpkam9makw2UVBzZzdNcnI0eXBN?=
 =?utf-8?B?RVhld3c3SnVkcC9HZzFOWERJQXZIL3BWUENIM0F4N0EwSUlGdVFXUGVxSHRH?=
 =?utf-8?B?ckkyajA4UDVOcXpvdUhpakVGeFlzV29hZnlSR0pnUDRjTmI1RnZqdGY5b3Rh?=
 =?utf-8?B?WWZEUlNVVE1FMS9lUGxscUxSWHduVTNINVhLdnYyQjQzTDJLNTIvTFNka3k0?=
 =?utf-8?B?NW0rSmtCZ1d1UFVpWHhTcWdJeDJpRHpJbjU2emE5TmtGUnJqN3lWUXZKaUdJ?=
 =?utf-8?B?Rkh1QjltN0pKeno4YXZoNmFDNWFtZHpycEpOVlF1elJBYjFhUkp0UGM1aGUr?=
 =?utf-8?B?YmF2QzhqQ29ZVUxOKzlhRU5jaTE0NDF6WjBPUlc0RTd1T3FFM2FlVXdSRkIx?=
 =?utf-8?B?MDhVdjdRYlZmYStmMHlCcGZLZ3cwbEMzcWFmd2hwbjNiKzNNQVBkSmpieWU4?=
 =?utf-8?B?Sk1NbVFRNGpOb3l5V0F5MUdJRGZPcis2ZmxsRWJlQ2hTbFgwR0Y3SnNQR2FX?=
 =?utf-8?B?RGp3czVaaDJuRlkrZ0lPdFJDeFF0SEFrblk2VUI1Z2pEUitMSjhYMXEycnEr?=
 =?utf-8?B?VytTVFozcE03QitEZDBnbmpScGVwcjZubkFIc2hGd0hpSks1Z1JCa29DOFhI?=
 =?utf-8?B?b3QxS045d0J3Q0ZMZmJnOURxcS9rMzkyZFhTcEFMNENoQldCWUQ3bjZZT3Fr?=
 =?utf-8?B?b1FnbFVTUHFacXlGQ2J0dmtBWlk0bWJvUWo2NHFOTlloKytYUmRzMkZxdDd2?=
 =?utf-8?B?Z1RYM2o5NVRwUlhKeXc4cTVDdncxSnBFTFp0MHhTdE8zRURwRHZOQ2pMRGJ0?=
 =?utf-8?B?cE9VamEwbmFZWUNpeWpuZVFDYUlYb2E2eVNGeGVRa2NXc1NTNkRpL2l6TEpU?=
 =?utf-8?B?c2dMVnBMM2tYVjZlUlF1elJma2NES01RK2F2bFdCYktuNW1JYU9KWFlQTHlZ?=
 =?utf-8?B?WEE2UUhrYktaeTlGTUx1UVcyZ2pBODMvWUFrMWlaREVkM2hNc1JuL3VEVTJp?=
 =?utf-8?B?R3JQOVNoUlZnWi9xaVhadFNZZlBrTExORUlkMFovelB6NGhVT3dzT2FLREJ0?=
 =?utf-8?B?WXZqaTZ2a2FZVVBnd3dzNS91QkdBYzJCL2kxeVQyY0JvMlVmOFN1Y05LQ091?=
 =?utf-8?B?TUFPekNlU1RJS2tReG5oVTlkckIvK0xNYTJjWWtuaVR6cUpmbUhaMFlVdldp?=
 =?utf-8?Q?530iOYSw6yaEXmVA0C/KNVhVx?=
X-Microsoft-Antispam-Message-Info: NxeqaIroDs6bPlqwC1bv2/NvTrZv97U03wqLDWZ1PhFR7Q6nn9Ow8nCY1Uij4dWROsQUhJ2rmkPgeWEPFAi/2x0oSYEcOGa3+yAp6aBoaDmai0cx0zImtQSNFvB+vVGsiw8bN3MRhcC3Yu3ELwNZ7FOIqJJi+qlH5+YwN6xchL1M5ILagKdgj8kyBc7AvOEa
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3334;6:DxQrFpw3nrCqdmKtgxSmv32LzupLlXi/bRraZVC4ochIv8biKgWWm+5NWY3lRXgyhqC9Bbjt+2dn9oICfawxYiIkDMXYtvsNdwMEuqdN0vNbxIMd5J92riVgP9XorEo+oNCp9VqR76ItCrS72IEDryHE57rMdGi4pyBLMUVERk/Fok3vtsVVmmQI+yKPagQ5YS1TFzD5k2d8wzA7W4PfABc6QGi5KOjBDzbi2U/bFBUNGs+bBN4gfcpfjQr//2z0YIqSNAbdEUN8GLlERBQj2ERhA+fXXYeqC7Hob1coS+MEynEFyZVnDyXX2j+fwrDOKxDUshJK000Qx1uJTrLAXHvKE5skcdoN7Zlx6Wfd9/dp8Hrr0W2roW/cnn39MHj2zmJisl6DSvw5vQ9I6ARKfgKJzaJZOqsCiBIfvkgKw4fh6B/uthfz5ZF0c7VGK0G10szsshvUwCRh33yWqHzwNA==;5:yMAnRPJtOm1pr82sTwwHZsEENyEzMDY6AYkPv5EevDDG3ncT6tHXudQLDckxTO2Y7itfuSIItDza4SmgEYtd9CVrpVPF/ZPiqp/30rEKRsJswy4i2EFn8V4qvZkF2cRXO+Kx9601tOcOaGn29NA64nhvvYzABhxClAj0VuTc6bw=;24:3N77fUJHgFSTEfExpXLglkyy0S+hsejzLe/1vCZYsnHR4D+pfgL9uEkPTN0ZmEpwa+2fWKJgOPi9CnCSEHCLFtl+6CmUYMkl0wVF1RhC9N4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3334;7:2kMvxVIfH6q0WyeKmU01Hu6HfBTxAaeOYedAGr6a3hLsCdDlDtl58zJk72cY5XcS7HWQkRtH60ndRxZXquQLQn2kj0jJhMJjUwtJRul07IwW9mi+rUjlmAyBIQEG751ABMysfKXLHQQJtVLdrIEhh4OXCYriIHB3+2K3TWu9jrfmpuxssJwVsiBuOzZr47wXO/JGmF1TlqwXT1sHk2/XyovlnjDBAeCXnHkiGsg6td/dAoDDI3cB3XMUmcxsNhXI
X-MS-Office365-Filtering-Correlation-Id: ea2540bd-f214-456d-4c89-08d5caaa1e89
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 06:03:52.6327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2540bd-f214-456d-4c89-08d5caaa1e89
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3334
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 08:36 AM, H. Peter Anvin wrote:
> On 06/04/18 20:57, Mika Penttilä wrote:
>>
>> This won't work on X86-32 because it actually uses the segment limit with fs: access. So there 
>> is a reason why the lsl based method is X86-64 only.
>>
> 
> <thinks out loud>
> 
> Why does that matter in any shape, way, or form?  The LSL instruction
> doesn't touch any of the segment registers, it just uses a segment
> selector number.
> 
> <looks at code>
> 
> I see... we have a VERY unfortunate name collision: the x86-64
> GDT_ENTRY_PERC_PU and the i386 GDT_ENTRY_PERCPU are in fact two
> completely different things, with the latter being the actual percpu
> offset used by the kernel.
> 
> So yes, this patch is wrong, because the naming of the x86-64 segment is
> insane especially in the proximity of the  -- it should be something
> like GDT_ENTRY_CPU_NUMBER.
> 
> Unfortunately we probably can't use the same GDT entry on x86-32 and
> x86-64, because entry 15 (selector 0x7b) is USER_DS, which is something
> we really don't want to screw with.  This means i386 programs that
> execute LSL directly for whatever reason will have to understand the
> difference, but most of the other segment numbers differ as well,
> including user space %cs (USER_CS/USER32_CS) and %ds/%es/%ss (USER_DS).
> Perhaps we could bump down segments 23-28 by one and put it as 23, that
> way the CPU_NUMBER segment would always be at %ss+80 for the default
> (flat, initial) user space %ss.  (We want to specify using %ss rather
> than %ds, because it is less likely to be changed and because 64 bits,
> too, have %ss defined, but not %ds.)
> 
> <action item>
> 
> Rename the x86-64 segment to CPU_NUMBER, fixing the naming conflict.
> Add 1 to GDT entry numbers 23-28 for i386 (all of these are
> kernel-internal segments and so have no impact on user space).
> Add i386 CPU_NUMBER equivalent to x86-64 at GDT entry 23.
> Document the above relationship between segments.
> 
> OK, everyone?
> 
> 	-hpa
> 

Yes GDT_ENTRY_PER_CPU and GDT_ENTRY_PERCPU meaning two totally different things is really confusing,
the proposal seems ok to me!

--Mika
