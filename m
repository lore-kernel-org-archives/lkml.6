Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeDFQy1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:54:27 -0400
Received: from mail-bl2nam02on0054.outbound.protection.outlook.com ([104.47.38.54]:21897
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751412AbeDFQyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:54:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Fri, 6 Apr 2018 19:54:02 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: James Morse <james.morse@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Klimov <klimov.linux@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: entry: isb in el1_irq
Message-ID: <20180406165402.nq3sabeku2mp3hpb@yury-thinkpad>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
 <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [58.11.97.202]
X-ClientProxiedBy: DB6PR1001CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b7::25) To CY4PR07MB2901.namprd07.prod.outlook.com
 (2603:10b6:903:26::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb10a94d-7924-4565-1100-08d59bdf092f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2901;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2901;3:18iU8ryWY9UVD+yWL3VR+TXWod3s9HXaljFDw29SY+GI8rih0kyusqhLTcnOVBgaGmnep9Zrxl/tecN6CLC+5M5sVb6BEBu0gtbcMmXA3UI/vMa02Lo4tI/UvCeth9Lc1+vCEjmRtS8vP63LhVjG4FqVXn5rIvVdb5/DrbDxqNhBYAQktrGYgZTqR+ayqfF/bQPT316N2D2B2dIkOnjaRsjVVmRRo82WqmiiUUu0+dwLfl1QGZvz1EFuDu9kLwQx;25:Zjdu7w4/pro1xuaupZx1C5uUZPONIXt4xLE3YZLCZcAobEXik2CNhDK1Xg5CQGmgTxkKes4e3p2QluD6p3niB1Kisjm81GNzf8HCeoSFjRsJtGqKRylVQbMDjTfxzcZzF+nIffhHkRworltqSSxNmR3svCtv6dZ0kgtLmQX0Q9iXMQY2akbFzkq3D1UXQuN03uxMeqn1BWBsjqaLbNpdFvRLNmeuvhhS/I2Cd4LoiSoXaVflZHZ0eQOL80JhSRQ2gkH+bVWocAYrWQMVmc8oEdKhMIbAWJv4yIxlORAW5fu/8RriDny8bE1TZ0kzpFsUgGnvOnhKsYKHFJ0Kz8Bbjw==;31:T0rxVGN9DUlbaQOpxPmL5mKkmhsZft7L29UNpmHjoNv+BqrVxxbygUej923lcWro00DLlohoy8Q2f9erbCHOvSJ9ENxEeE6aomdos4hRAfbxFWo5HVcxiZ5eQbMcDRwE7CU9sNrtFQ1DQD4Ah0Winqgq8NN2Yt2/Xws9r5oYK1yhrz1KdHYu5N5vgqEzP4M1p99J1sIZS7m6vwS4ofebq8La6qGe00HWF8coml3QdpQ=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2901:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2901;20:2SGzRrrIL4q1EXicik7pUKSByYe1fTCPU2imvRT0uDGCOMT7YSkWNb63QnDqXBXc2tbQ/drmymeZ+jPU7hm5DeiqipsVmNgNq9cnHqOaKNikg3Sqg5TpOEnv3HlJ8diyORbZcEHRQf9J6c4hR9C75L7mzcjNhcQ7mRbVyy8LCuaDealgQOv7I8fyCAp0ayQ69M6ZB9DLxDqNvrCvighifsB4tRvOiFTB2tEv/xqSpiawDFjwnZ4oCZgO5okjdDMnApUMuZxOsOEsWWqI2E++5no0/tzF2b/fywrsfpirrEmAQVp1OYI2X/CXxB+wRdbg2hhT6fPZuo5jEz5joh8tL/6R9zBvy2/Q6DDBZuDLPlDwMWLbbB1/aWLGNz0WGBcIdduus8x1CTw4I09llx6b4oRX+tLviaFKqvuLPkutLZPyRgD/2ApPO7p3F40kr2n89+wFkg+vwg/cS424Yov8YuXg5vO4mkxVLNdlu+IfRDQT/VphhhkiKoFHzq1TH8AKrruf/VXMRIk6fuBXjUowWo/OxAZdNd5mlamrfDG/6GkXyse6zaQkMrmKbpmHS2zb2VU10SsBctfk5gaKPoc6DWTsjV71hrKzk3vFoyQo7ws=;4:FG+qfryTpW/A4RRFbTPeS62S8Ao+FcV26XXsHD5KTXPwDTx5iecc5yTx2TVYMaEwDE8t3MvGJchJkmzR+4t26eDBHgxOS3/OODgGZhyCceDV50igZqZdJI12+PsWd2LaF3EUoU+POLihGfi3weFccYV0qIFcgacKwmO1Lbia8dFc6fCSxoSdkfGz082tWGr1vhOyAIAGuzkCSL2b775ltU5hvS0e//FCJfRzfmuQ2OeoOoD+2F1paN1wfREdHD5uoYCdiXqNNlgD82oo8W4t/w==
X-Microsoft-Antispam-PRVS: <CY4PR07MB290106E70B84526CC129B658E3BA0@CY4PR07MB2901.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(3002001)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB2901;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2901;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(199004)(189003)(68736007)(23726003)(81156014)(3846002)(476003)(81166006)(97736004)(316002)(58126008)(6496006)(26005)(8936002)(42882007)(16586007)(76176011)(33716001)(33896004)(2906002)(6116002)(50466002)(1076002)(186003)(8676002)(52116002)(16526019)(39060400002)(7416002)(5660300001)(47776003)(6916009)(6666003)(4326008)(66066001)(106356001)(956004)(11346002)(229853002)(7736002)(478600001)(105586002)(54906003)(6246003)(53936002)(486006)(446003)(76506005)(386003)(6486002)(72206003)(25786009)(9686003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2901;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2901;23:S5M2K9XB4AppWa9bRLyMyQQZ5rSyiN1swTEtPRwef?=
 =?us-ascii?Q?8oDMvDyabGob8M3ULpV081PimU9vcLTq2AJt+A4mqW1gdcudugyrECpWeSIx?=
 =?us-ascii?Q?yaFRPm03fO9lvigFws/hxwJfjWx6hr9lT7NmoxV4I57O7/Fz2eGDGu8QfnM5?=
 =?us-ascii?Q?jIWFJwhdHxXTvpuCL3zDJdl/RAxQ+qPpziSQhsYpqyN+2iFOA0vGFmVdDxHm?=
 =?us-ascii?Q?nkGNrhafJH27wOAeFZib6es0Lqj0QO5PHtvKR+TzoJTathp359ABjNmDfrZE?=
 =?us-ascii?Q?rurrSs3BOWqP8PFdzFPgio9SEHI+6W+zGfDwyS/N4uNH4CD5WZhkIOKj3BcC?=
 =?us-ascii?Q?Y9KOOvzjZ9DkYDyK/QR8CQvKXu2+4J0p0vXjkMIoE36jKRJgsI/XWOj3ljKJ?=
 =?us-ascii?Q?Jwbnu+zq5V0+jL3iqEYfKrjuj0V1GK70fA9Gho/nDrYqJYSuIV0vI5pn9gNk?=
 =?us-ascii?Q?09yBBBUrbyJArhSTBodg+XyC1zTE+ZbB2XREc2R8b/ac7w7pQ/BepciOWoLk?=
 =?us-ascii?Q?ANtSVnSTt6hPhsgBnDptbBOi6Qa6Jb2stRpzT4oX+oVDcS87g+XKweoX6kqR?=
 =?us-ascii?Q?nKOQ3yEFY2JxlbLNFQ0HkrNKZ23XGx+qMGlj1WpPnFMOBHmNwNQAKeIoRWJe?=
 =?us-ascii?Q?gv02TQqkoEJelILzkgPkzTKOmkfbQjS3XWKLv58zbYC5EERE+c9G0NvhFShk?=
 =?us-ascii?Q?m8E31/Vuzm3IG8aESEwxPVHO8m02DRLRzgKvNgQgHh1O3XqDp3pnWJcpsKdu?=
 =?us-ascii?Q?JJfa4SByYkFkhJvDdfKUZ+2s4gz7X+tDQQPSDnvASgJcG93nzRPjnOTVBiHg?=
 =?us-ascii?Q?g6oR32HWKhqdAcAvtSxl/nXU6YVUD1X+t7Pzd4d2Tf1O0MZlbsOa8ZAwutik?=
 =?us-ascii?Q?ydpNeagDTe2B2ncdOKioKMMKsc7W3Q+oEZoAyiTh38AoS4A2R0MDeun9y2Sx?=
 =?us-ascii?Q?Kei8BRQgOYlozciOtaGhEaS/X1D1CconzFrCfZVedfsFoyhkeaGAbcMlF5bF?=
 =?us-ascii?Q?TI4BMGeVgIjb0Y/l4B6vfSyphi7y83v+iq3eCkfbEVc4LuklQrz5jJTTk0lv?=
 =?us-ascii?Q?4n1zXCxXFErUciGhEDaQeAAp72jv8um884TUJ/EgRvSL0iOP5KgSws1LSccZ?=
 =?us-ascii?Q?sXA9m/fo4tXQAT/NG5+ilQ+DBtaNFI5xnaZgfKDxXR0ZlVyzs5J/K7Q3ppzX?=
 =?us-ascii?Q?KD3rAfwoHhB1n5taiEerwrOdBlOXBIJUv7ub6qzXvG3+/uy93thcy3F3BESQ?=
 =?us-ascii?Q?2JRpNRRgvfjQv9iEHmM2XOsq5JB1806MQ7JJAjSAIsSeZCoX9O/AlT86F4ck?=
 =?us-ascii?Q?WfY74V6kPDx+iTYptYfb4YwBahN/SId1Gg2W2OUswatxhCxop8VqipCKILUZ?=
 =?us-ascii?Q?eQNzw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 1FYINEXTtc7eFFm/mHVgxWYJ9bFuV3O19FEItHGVFAw9pye0ziAIrkQ/ztdLhM/KsTASgGqVMWoCkTNLGwV4m+dCSxthIu3JzhbP+EQvA5V9NWhjKptIweCz4Y8pKHIRFBrOoEulKE7Wfbh8FJQLAMP+KYqRAROjORzSklp9DpnjoChHsJsKtjYhuCSvNdqM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2901;6:sdU1blV2+TjX5xXq21UjURGfgW9axyKtfk/9S60j9a5R4e4A14DTSiA+WeQCulU3wwN9fr6zfhFFXBKi5zq5lCM5RGaQLUxUfiWMOYN07ok34FODSGPwah9RBtTtAySMoPxKypTOSpzH/gbxSACqmqIYNh3dOWegtVbsjm0lLf5H9XxW/4O3TGHv7eLi9M+w+zPKdn6ufYslMACSGt6mqP8qapg4qRSvlcrdYV3yRx74BGwKs+egALap06Ip5irYsPbiTKiS7nmGYjwYnb2SdTYXg8YhrOeN3+/eLZELN/ulGXayquCVvuQKbb9AqycZEWl0ejCH7tjaYecRt4viSRknqMKEOlO5HvfF15/4P6Wv1xvTPw+eJllbJQMlMxLlw2O9qE+J0XB6dO+Ii1UGjk3/FjQr32nfIPiyni24EGlfyIVQkopEm/v9nXMJizJGZWxg/uvuaFA6pgtcbgVsKA==;5:+wUlmu77CfWa3zbTXkDTDL3ld97uJ4PW7a73NU3cAxICX+YKHZk1+nwWnM6Ylcpx6Juvsd+EEpQki8yxRFZqyCzavELr+dDHrZVoavKe9mltRqC6qZE1cTYaT/NjUw1oVp2XMlzXiiOfpoqeTBOEBe8qm4SLYyD0PvNW5BDO5rU=;24:+zfBtFMtbaw2KNmQ7h3/PexqoDhDH+kbztDIb4WYjwTbZjiDjbHwY+JttCDDQjhOWcc8VajzHocn2a7ZgIQ3h6U9ZaBxbVogmPIJFQ5fQRQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2901;7:17pG8Rzbm+owSUv3YS88OCPjNMd+lx2f1y5t22MtqKMwVRCnqHMPKgHZ5AUX3Mjs2+6PmHg/UHWYp/UWq5ZdgDjmkV6Jk3xfMqSE9R7Tn89gyGHiJ3qiFzPvAfMQBU5OnPPW55u8+O7neOHNbXAPfeAWPMekWeULk2fflw3wJkRY38JFwb8DM5UbEufqtWG+FlVqdXJgoqakLzCrZf2Au7YHtJDdA5dQap4jL/mMWP371gje4DzDsMoNkPxhDrr6
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 16:54:16.7197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb10a94d-7924-4565-1100-08d59bdf092f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2901
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 11:02:56AM +0100, James Morse wrote:
> Hi Yury,
> 
> An ISB at the beginning of the vectors? This is odd, taking an IRQ to get in
> here would be a context-synchronization-event too, so the ISB is superfluous.
> 
> The ARM-ARM  has a list of 'Context-Synchronization event's (Glossary on page
> 6480 of DDI0487B.b), paraphrasing:
> * ISB
> * Taking an exception
> * ERET
> * (...loads of debug stuff...)

Hi James, Mark,

I completely forgot that taking an exception is the context synchronization
event. Sorry for your time on reviewing this crap. It means that patches 1,
2 and 3 are not needed except chunk that adds ISB in do_idle() path. 

Also it means that for arm64 we are safe to mask IPI delivering to CPUs that
run any userspace code, not only nohz_full.

In general, kick_all_cpus_sync() is needed to switch contexts. But exit from
userspace is anyway the switch of context. And while in userspace, we cannot
do something wrong on kernel side. For me it means that we can safely drop
IPI for all userspace modes - both normal and nohz_full. 

If it's correct, for v3 I would suggest:
 - in kick_all_cpus_sync() mask all is_idle_task() and user_mode() CPUs;
 - add isb() for arm64 in do_idle() path only - this path doesn't imply
   context switch.

What do you think?

Yury
