Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeC0MFA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:05:00 -0400
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:54192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750898AbeC0ME7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:04:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
Subject: Re: [PATCH 2/2] x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de
References: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1522051559-23415-3-git-send-email-suravee.suthikulpanit@amd.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <a314c050-2c35-91bf-1e96-0c7cda0ae403@amd.com>
Date: Tue, 27 Mar 2018 19:04:45 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522051559-23415-3-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: CY4PR19CA0027.namprd19.prod.outlook.com
 (2603:10b6:903:103::13) To DM2PR12MB0139.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8161322-6ad7-4072-def4-08d593daf4f0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:uGO9iClqr3kajPH3AX9J7Pc8Bb6ye3tdoD3hQthplIei+dnTeVPPAZjoeS2D6W+9xDrxKpjxRtXcgQ9BG63/XczNVowtEDj6LOCkGYAE0XBoXAIc6I/cLAkkd9FBWiyUNVpJpNOfymcBdSKKieCN3Q4w56xltivmizi6fSAxDE3XpNhf3iUTadQzbd/PpZ/G32QlLiqIlwsyNeNMDvyrTJgkBxYuEes0BEzXGoKDXlStXncFPzofsRnDpxCl/Wzw;25:90JU8C0YYmb/hcWXilVtO+NDDzkBD0iBuVj/m26gdy3VSfVXpGKiY7Y0BBFZuJLUKrkeZuuXRX+K+1biN0n6aIcasuBXJ5efC37QQKR/7H0T67XUQV8IB2ZB4lFupkBgcmGXVmS+7hxy2R0hGR/Yfqhy07lQFtCTekRDg9HttZgbaS/wQPSI5rfIj1nGc94Nplja+cN1hN1zMNYr+80+xVY6Ymy0/hrn/Tz01x/TsTrlrB7S4QDWWp5CuKS5iXM0+lDPwrBU1LLZS2d6EL1PQzsJxX0az2I7HnKSp4CFjqfSciCebfNE9GEZjlHdv2DKM/yNPxlhG4DIqSkvNHAWmueGq7ZflW/QNE6bEw7FspI=;31:F2GEnkVmlhOrdJXIAsz+kAWrp2KCp0l7ctya7yLg3Z130tkOSxXSFu1QBngMS0odxrCXhNCDcf1ylUUjs1W8iKObiDK+t0MlaT1wBinfNKt+lFV9xkL9pNezv+i13LDorXW5J6rwedtEoMW/eflM0+zsVJW0U0nu1dgA+XMeRm90y6Jf9+w8mIfB0cqFSTaEOSqYwwbje9EbBgKUWsMlBb5Cyb2ou3FTwf5AQVM9dhg=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:oRZiPFyXvtnNbZ1ToeeuxTkoMDTdv6S4M64rcYPnMTsmH4xkRCIqjlP+RucdFZPea6UorsDSNyh3KZ+U6UQPyHEGwOzC5pcy4e8rVU6AxgLZjd1qb73d0XX747h24LHeUd6kJEvF6XKiYw/ge61q6eCoAPSphmZ9oJcrdt2qCRooyc9t3RQ/9xt86moAnsGEJ837XybzFBys3CDUprcXsThnid0BCfCXikuM41MG4aDcBJr1h0mq4N1oB5PWYr8oFJEx/OhH1YfxMHSxsv4BMcvf+xQZFZwsJrjTWArLJdi7ahvih/luZqHJjA0qwIHXt1E4jhmVRoZ+KIfvG9iY2BP61g4YHJGnBL3vcTxdyWBnx7kL8htCXi+Boqw9GmsPCImbYUk/d9DD9ZE47idk9LoPSoxXDeJflXqbvSxZUhUvY6CIgoFq2avxtGPAb7fldiRuYr2yUndPSlQUwAGKeAXcaGCubRWGiyFzuldC96lnVyw8hf7TS359iF2AO34R;4:gioF8/mXHBoKClEm3K61ahBNjBs5rGDQ0rL0h9ibIG3DnfVZGJFX8ryd6Edj0o6WsSwCgIAfeVey07/520hdjo5s0WKSyNySj4I/qx1bjCuYaeJXVpyUc9DsWXDkUOxYsDAhUBfFHwZZAFrtpyfG+VIqymnoK43qlodm169vBX+tzES0Ci+i6spCnbBbA0KMeofrGvotfh6O2ca7HgySBXGacwUn93Rn0xwUKMo6stFjdDNaimX0n9i+ZBnexH/AEtxPpxHrvSKC2FfhnUNH8FikvG3WtlSCCTOeZEnc6yGeQ2iyoljppOCKuJsKqiF+
X-Microsoft-Antispam-PRVS: <DM2PR12MB0139E34E7C71791814D57BC2F3AC0@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(39380400002)(53754006)(189003)(199004)(97736004)(16526019)(76176011)(229853002)(7696005)(25786009)(53546011)(486005)(52116002)(8676002)(81156014)(81166006)(31696002)(64126003)(8936002)(53936002)(36756003)(956004)(186003)(4326008)(11346002)(2616005)(478600001)(6486002)(316002)(476003)(6666003)(59450400001)(486005)(230700001)(72206003)(26005)(386003)(23676004)(52146003)(446003)(2486003)(6246003)(105586002)(68736007)(86362001)(106356001)(50466002)(31686004)(65826007)(5660300001)(67846002)(7736002)(575784001)(305945005)(3846002)(65806001)(6116002)(53416004)(65956001)(47776003)(2906002)(66066001)(58126008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:wsp092918wss.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTM5OzIzOnl2L1pTRndkRXp6cGEzK1Y5R1hiSjNmYzBi?=
 =?utf-8?B?dkwzaGs0TGdkMmVTaHlVY2wrZWVhM2JuSWMyNFhuWW14V05PSGlOazNzb3BC?=
 =?utf-8?B?RHVwUk8xOUFGbGF5emhaRFVlWW5CdWVjR1RnNnRwQzlQYmx0ZkJaYy9iUGNV?=
 =?utf-8?B?UHpINXVIbzZ3Ri9ZaFBTaGZWb0ZIVGJTcTRlVVVnYlF5akFZUk44QjB5VHoy?=
 =?utf-8?B?UGUvYVhsSUZXOGlyaWk4dnArRWcyQnVzWHBtZGJkekN2eWVWeFROQTJUWnhz?=
 =?utf-8?B?RjFJVjNKNXVlK1F6UTFHTnFRNEpvQ242U3lBSy9JOGR5MXNNU250OHBYRjIy?=
 =?utf-8?B?aUhVYlFKS0drSlVLdHhEc0xwRmd5dHJQN0ZQNXVPV1dOUnR0VFc0NHd1MFpE?=
 =?utf-8?B?SWJKcXc3dEliWTdsbXdGR1hyeDBCWlM1bVVoT1JEOTliTzlvN0lHRUFLSG1r?=
 =?utf-8?B?Z0dYRTRsR2tSc2h3KzJFTnBBMldBVVFvNmpuYTg1MFJ4TnNVZjh3c2ZxYUVn?=
 =?utf-8?B?Y29zYll5ekZJQ3ppY2FRcUlpZ0FmWTQrc0c2UmhVaTBRT09zRmFDMTNCcVcr?=
 =?utf-8?B?RFBBR2tzTWU0c3E4K2xLQWVXZGNDVzlMeG5XNEYydlRRZm1GMGROWHVITWNG?=
 =?utf-8?B?OWVLc09aOEl1VTdlY2ljcnFOT2ZkcjQ2UkI1bUNFbk56clRndmd3WEpTbUtq?=
 =?utf-8?B?Q0Jpbk41VEU3QlBkQ0JqdEhnZWZpaVkxVUFoTjZPY1M2WlVYQWNKazZJRWFo?=
 =?utf-8?B?cWdDdER5QTFRSFdhYThDSTdXTEN4eFdncmlzcW5tdWJ2c2NHWCs1K09SSHI5?=
 =?utf-8?B?aVlkOFd5VXZzR05Da0xHdUtXMmtHK3J5dnNoSk05L1BrMUFBZ1BTY2k3OVVJ?=
 =?utf-8?B?OGVubjJ6bEkwaEgxbzZhbzRxZDE5MjZuRjExc2o5UHF1NEp6TmJGYW5wTkpS?=
 =?utf-8?B?NmwweFNWSkJpc3dRTEk3Wk1OeUd5amdaL0c0cXN4VmxNTmh6dkJ4SFZ2Kyt1?=
 =?utf-8?B?MmpyY1ZBU0h3NUs3cVlTalpTSS85L1FnSVZNM2pGZHhrY0JvMEgzUlVDT2JZ?=
 =?utf-8?B?V0xhTGJIMldUYjZRaWxTQWsxb3JyVW9sN255TXlNcFZsaUlGMlIrTUdmS2x3?=
 =?utf-8?B?YnZ5eHlhd0dPRlpud3Fvcis0aUpUWHhYTHp4NWl0VGVkUW8zaGpKN0pYM3VH?=
 =?utf-8?B?OEZNc3c5Q1NNRllDNWRJQ1lNUVlCTW8vTGpKVW0zdWZJQi9aeFlPVStjWjAv?=
 =?utf-8?B?OFM1eE9VVm9QTk42Z1cwNG5OQlBER0dmLzVtYmljSVZIQi9RWUZBWHhsT1pQ?=
 =?utf-8?B?YlJuVDhid0VvYmliNHhHdDNIbzFnQXFoaTJFMDk2b3BrWnp2cC9VbERCNkxl?=
 =?utf-8?B?eFJGWUxTY3lGZUlEYjdRdks4TWJTTkE2VDJ3UzRnSklVT29ncDdDek1MU3Nz?=
 =?utf-8?B?a0hDRVZTY3N1OURDSUlpMWtVUnVHRUEwd29zTGNYa2Z0cThBZDBVNHhDbXYx?=
 =?utf-8?B?MFA2Q2dybmZSOVU5aVIyYUg5eEh2Y1VTNDladlFwbU5LZ0I3akFoaWI1djVq?=
 =?utf-8?B?VDdVVHdyZEI3Tm5lVkNLN1ZaRzhKUjU1Nkpsc1NqZ0ozV3lieHRERWxTNTd1?=
 =?utf-8?B?aGJuMkJzYlBESmJBQ21aNXNRdEg2OS9NaUx4NXFDVWhJQVorQXdQM01zWjNl?=
 =?utf-8?B?WnlmZnFvOUxHckxIU211bjlzSHcxbGFPakVXU0tGSUh6SFJwd2FUeU5LdVJ4?=
 =?utf-8?B?YU0wYWhtZmh5bVRmd05pSFVhckw3VElhUzdrK3NhdFpQTkx5TWRLOGlvL2w4?=
 =?utf-8?B?RXNGT1hjeHlZcUJYdmN4d0htTmFlQllPVEp1TU44VVZ0RFl1Rno0OXprUTRD?=
 =?utf-8?B?S0FsTEVmdGdDc2tYMlptKzdnNmkzUDdwOElnTklUdzNCS3V5eC9hVHkyNHZw?=
 =?utf-8?B?SHowU3V1ZVp0QThob2Y1WFh5OUwxaUtPS09PTll0K3piYk1MSzc2SU5yZHk4?=
 =?utf-8?B?amE4ZkVwYjdIaTdaemtQYkVTTHpDZERHcml2QWU3T0tUTGM3cFNuUU1rNko5?=
 =?utf-8?Q?3LiG5ALnWb6nqPLCK6jktQjY5?=
X-Microsoft-Antispam-Message-Info: ZdRmO72yX0T88B/qVDACFZYhi1hhG7x32RoKutrnPlSBmOhMCQk4f8aOb+AJF3wgjkTUopZrvEuZWgw1WxPE816Aw1G9Qm6NE7gzKaC34ao7ALg4TeHQ3jPExaFVTT8iw/Vj1hrMKTJpFycxN2Aepaf0pAsHO6Y7inNh61UvpxdBY5Bbj8/g0rUAz7syMtat
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:q3cQZDc6zQ/WuRkbHlYQHGkurppPrBYKdZFj7W4S5oMyef+zUMOU32lf3qAhUx5L952RvOGcEDB/I1FyGTZ6OIaachG7kbYmkrU3J8TRWxD+PfxoV0QKGmmtQMiYEEvpjTQ6s4TtopOAvT+28ViPbKGXTMxsydAxYi+tyCYE6nekzfxfboDLcTop9jo8yL3kNX1H3mnwWoTJ59O1wdlv0k3kcg+e0dQzP1BWRAjTdcqDXIryzfgLS0nNxRZn2C8AGv0yeCB/EKKeVG2lxRAqnLyyNO/XMA0AILXxzPyHE47P2TQSNeeTa4DamNw9BeAq1Dh/IVytKk4fmw+JUAIsAScLfOGPtfgEsJQuwGkQ3wL+PApWEmPt+GVxYsWrQqyTEvD/pzMLhqOAL11nU7Mi5wLUZkh2lxEGDFOQjjwXrK1DXXXAshv562fZo/O3SuIjBsSppoHXfNABeQ1vLz2ECg==;5:TyQcdyO7JyOhtQpYTk9UzVK7odM0zOsYMsbqUWJfsWPSAIbGCzKDYUSiivcJJSnh8c8eup2AVz10VhoRl/U5hgbpdxKc4W/ua7jCJvbx8/xpYh+bY6OUjdzzfAygbCB+bRi9EX9NDfoBJTgp0/4vEGCI5kpXBRorSVyLHO+vg+I=;24:Buc1KpBbovpz3f1suPNoSjiSJ7P3duDNHaW3HJxfTHcpjLHTGnihW8/rSSU2TLyUE7oDLSq9z1U3rylM1rlRgzorDSrOKi1wc6lD0UzoGWQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;7:j1EbQE2adv/CNMNIzLWIfI0v3LoW+WFoYhCyFXJ8ecl+ArSunzzCxCke5KK3Y6DSaMxQuy1VazBBr6wKZ2z247wifXDTYXMQ7smW1s9NRtVRsgbKmTS+yIn+H6tBhOedSsvzf1ySyfZ8yE6UIJ1M1g7o8f9BH/qkHEDSg2D1VT6Q5PNQjgAxn+wRUeau4YnSqCCEvKc1MWAeFrg+Ir2unmITRR4dQpN+x5goolZKzqWvN7jjN/fZAN9zBAhkMuPc;20:SynWHgvkoMOSD/3k80xWe9Zu0EopjEZvA69LDZ2IlvAwoz0KnWaDEbeiacu3JgOXDoq8hLfaOQD0XWFa80kwOG2WwVfm0kruDCK9MSwden5dRBTh5jneS/oOUpKKeLFydZayGXi1jnLuI2hsGnHzBgnYSGZrn/94ANI7zpiCZkgkKo8X5gQhsi9Ll6liFiqq8308tHIvQy5VTuAQ2Rz1LXW9I36iu2qXi+G51fsBD00ynXBWM4GqwAL++TeWp8tW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 12:04:53.1306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8161322-6ad7-4072-def4-08d593daf4f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 3/26/18 3:05 PM, Suravee Suthikulpanit wrote:
> Derive topology information from Extended Topology Enumeration
> (CPUID Fn0x0000000B) when the information is available.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   arch/x86/kernel/cpu/amd.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 2c1a9f2..2b40144 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -338,10 +338,18 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
>   			c->cu_id = ebx & 0xff;
>   
>   		if (c->x86 >= 0x17) {
> -			c->cpu_core_id = ebx & 0xff;
> +			int err = detect_extended_topology(c);
>   
> -			if (smp_num_siblings > 1)
> -				c->x86_max_cores /= smp_num_siblings;
> +			if (err) {
> +				c->cpu_core_id = ebx & 0xff;
> +
> +				if (smp_num_siblings > 1)
> +					c->x86_max_cores /= smp_num_siblings;
> +			} else {
> +				int bits = get_count_order(c->x86_max_cores);
> +
> +				c->x86_coreid_bits = get_count_order(bits);
> +			}
>   		}

I made a mistake here in the attempt to clean up the code. I'll send out V2 to fix this.

Thanks,
Suravee
