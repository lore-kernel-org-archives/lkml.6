Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeFEFTy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:19:54 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:19456
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751497AbeFEFTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:19:53 -0400
Subject: Re: [PATCH 6/6] x86/vdso: Move out the CPU number store
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
 <1528140269-26205-7-git-send-email-chang.seok.bae@intel.com>
 <8a41304a-3517-003a-badf-1ba8f7ababe4@nextfour.com>
 <C62C3F95-0DD4-4B66-89A8-4FAB819C8A70@intel.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <e8ce8b96-95fd-9cfa-29a8-155d74b1043d@nextfour.com>
Date: Tue, 5 Jun 2018 08:19:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <C62C3F95-0DD4-4B66-89A8-4FAB819C8A70@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::25)
 To AM4PR07MB3331.eurprd07.prod.outlook.com (2603:10a6:205:a::12)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR07MB3331;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3331;3:EA+K/NA4JE2vTRJrkS4PttdFKKKV16dhqPQPAYthb5MFohWsyK5wUDexIyC9XKLS3B2vqk7RHxvIuw6tkVIGUlPk7p5deS5Md0AvR+2wW8ytw2EtGJVj2P+IV7HhNoc7LEJTpP6At/jQY5psTKrwfkrmNL3AaaK9CJUKwUZAC1fpjuZfdDfWi/GMZAEC3WVboxVL5XSY3QSbUksqSmvhfYqQkbwOxYMf6CklMdGSiZId+BTB3im9XvmxDT4qDxUr;25:MXXjS1CYEYdwtxOxN4h3rhGsC0aClesr2TChPor0EoiEG2ypZgoUVKqiO4Dbstb545q9IPIzSsHOU6JT6f7M5q+O7TMa7/OS4QfaXV0t7vrWnAMJQtQ1DdP+HsfAB4mCxDDPiKy4b3gZzkV5eprhILb+UOVlIZz9dkTvzCu1bQXTDzELie9JNbvG88MJlgH3Bog0wjb1ibAq5xNlyBMl6lbUY6DsZqtsjPUk2ulRBxQYvAmEVYeK5OTZL5KaThWf2BI3ucYMkjdycjl5tLBR5HttSHnxwhuWIDki7/l0HdHpQVw52somVSkPXOfmBTLgokiz4dPOQtzHO9kjVO+FGQ==;31:AY+jBfvL8zsN6JEnBYMU+LYhggTKD0nZ360NPg/qkA6NCHSl/0143EWZ6NHTCOg+QEPyBpJVtm03zfofCCNkAdVNJvqnDomixIifptalw620+htPozpsH4QdxIzSKHJB6fycIEZptAS1OBmfKq8KhyWPRQXswvxsYVFlwW/yX3Lwxgc+sM/cJbWHzQ+bde2VQhCshFIcjtao5x1UzTrF9ZFH1HosE9PZJH5h6P2WTLY=
X-MS-TrafficTypeDiagnostic: AM4PR07MB3331:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com;
X-Microsoft-Antispam-PRVS: <AM4PR07MB33312CDEA6CEE107A307111B83660@AM4PR07MB3331.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM4PR07MB3331;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB3331;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3331;4:aUHAVEIjCeiG+jHzK6scalfnWtqVuasr4UzvqJfgrP16W4HfilSCYOwCxQzLZxmqyfnh+K22eq0xFALsh5ot2g6r4R2J0krOCmWEngoPfTA3JL0zSk/WpnqiXGDZZnUmu2I8q0eDQWUnJ5GCo0qR9TP08JyKbvCWkMaA3wx67qodoDSNWtjcEv4Coh45JQfv6qez2gGCc4ghK93ITzc8idXNj0hjiuY1tU9htOR+891HMNK20FMsEv0c0B/1vvVJIzNlejWnkcrgYvurrK/rCA==
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(376002)(346002)(366004)(396003)(39830400003)(199004)(189003)(6116002)(106356001)(68736007)(64126003)(3846002)(105586002)(86362001)(31696002)(305945005)(6666003)(7736002)(186003)(16526019)(36756003)(77096007)(5660300001)(26005)(7416002)(23676004)(2486003)(52146003)(52116002)(31686004)(65826007)(53546011)(386003)(76176011)(59450400001)(25786009)(8936002)(93886005)(4326008)(6486002)(81166006)(8676002)(81156014)(956004)(476003)(2616005)(478600001)(486006)(11346002)(446003)(229853002)(47776003)(58126008)(53936002)(54906003)(2906002)(97736004)(65806001)(66066001)(65956001)(316002)(230700001)(110136005)(50466002)(6246003)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR07MB3331;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3TUIzMzMxOzIzOlRzeXlQZW1jb0JkQjRrLzFlSFU1eVB5QmtD?=
 =?utf-8?B?dGlUOXp4SmhjcUV1M2phNk5BdHBrbnM4T2pnaE1OMGRRUE1KODM5cnpIV2Nj?=
 =?utf-8?B?L1F0Q2loZXp2YUY1d2g2RXd4anl6V0U4T1d1WWo1MmNkbENxN1dEQlBTNkIw?=
 =?utf-8?B?cTRLdU5Sb3NZOXk5MzBHQTVjZmJNS1lvYXdobEd6U3FxZ3NsaWJwaGZlNXpK?=
 =?utf-8?B?N2hVVWZSVDdKWXkwa2IvUURpZ0xVSkgraTVRZTVnSG5iVGk3MHU4NTNjM3BM?=
 =?utf-8?B?QU5jKzJJa1VnN0lsc3hZdjhTalFaUHc3OTNrK2l3UlhnL05BYVZGaHFHTVlT?=
 =?utf-8?B?OGJSeXNaQ3hSM3d1T0NMd3lSQVh2enRzUjdSbnRwc2FIb0QwSitobVhMUUlV?=
 =?utf-8?B?Nm9QZWhMdzQvV0x4ZXcyenFvNWJJdFY4MndpMUVueWoxQXJ2d0kyQi9mUVZl?=
 =?utf-8?B?eHZRTXJFUlF2cXh2M0pVeE01bjM1Q1RWWGVOOFZtRW1hMFVWczBoUUJ3QXp2?=
 =?utf-8?B?bnorOFM3N0lHRVlwWlJXTnJhV3hHeXpHWE04U1kwM3Jta0xMMTBFT2NYK2t3?=
 =?utf-8?B?cWpKNDJneVpEZGd0UWxTY0xhTjVDdnN2eVdOeWRYbjhNVmgvTWdUbDBUQmVs?=
 =?utf-8?B?TVloWWhEbSt0Q3QrU2o4SDZMWXpPQ05pWmQ5UDY0UUN3UVNmbVZYY0crMEp5?=
 =?utf-8?B?VkZWOFZFNnNQdHB6Ym13NTZjYXlSb2E3WCs1V0VtUWFvQVVGOU5MU2VzeG9P?=
 =?utf-8?B?ZktzRXhzS3duTEl6eW1HVTNUQkFJWDRFTGYwZk5waDBxeTVyVmJnQWVYeTlH?=
 =?utf-8?B?MDFqZ0lxa3h1eEtCbUdMVG93RndUTkRrNXlzRE94d0hwUW15by9kRHhLUDZV?=
 =?utf-8?B?YkhVaUs0RHc3MnJsVmhLT1RiYmxTai9IcndHbDRub3hjR1dNQldpd2Z3czlZ?=
 =?utf-8?B?REx2VTdSUlZqUTdGaTJjWlBNSEJQSkdiOG00YkFrQWp0ajdYTmtVZXhtdUxH?=
 =?utf-8?B?NUZ0L2ZtN3NxYk01YnRxYVdhTEpOM1BmTlBIbGhWaW5ldkhWN3Zvckdpc081?=
 =?utf-8?B?QUpjcGU1RjIwTnhidm5sUXJsbWZ2NmhHcHJkMTEyOXZ4ZldUNy9xQlZPQVRN?=
 =?utf-8?B?L0x2N1c3dGw4RXNJUkFCRHhnVFZwaE55NzY2bWFuZEltQ2hzZmYwRU1ZOUxI?=
 =?utf-8?B?SFVZbHh0TTZ6Qlp2MU51bm1YYkZCSVNZbitDY2FSQm5pU2F6Y3IrYnJKREtE?=
 =?utf-8?B?TWVZZFpCR2tTVUt5ajVkZWRtaXVLMm4yOUJUY2dOZ3JGN0g0RGhKanU5MTMx?=
 =?utf-8?B?SDJZdmp3Ry9SRXZyZFdhWEZDT2t3dTVOa2FMN1NVZkZJQVQwWFgrdDkrZCs4?=
 =?utf-8?B?YllZT0dUL3ZlK3RiVlExUFVYMWVjbFBhRHkrZmpqb1QzejF1TGp2SlpncFhq?=
 =?utf-8?B?cWpGQktJTWl1dTJudC83YVR2OWJNRjUvam94RnROcFJQbWkvaXFrWnJ6d3lF?=
 =?utf-8?B?L0tTUGd0cVZpTmcyOENWenZwVDFPdHduSE5sR2cwY2dUQ3B3VjNGYWxTSVBE?=
 =?utf-8?B?M0dadzk5YVZDWisxc0tyVmdMKzhKbm4zN1BpVXljQzZKNkdLeDBYWWFBN0k5?=
 =?utf-8?B?ajM0eTVTMitTUDZzVEhBeFZhcUlwSW01QkVJT01VNEp2RFgyRkJIZzlmcGtw?=
 =?utf-8?B?cWZpOEZBV1pueFg0cnZzYkRVMXN1Qy9tYmFvQzNkQjhlL3QxNEpTUkd5N21H?=
 =?utf-8?B?bi9oRnYySlBrT0R2YzNCcTRONFpKUjA0eVFtc0lwNlFuQk1VNjFYNFVFenhT?=
 =?utf-8?B?NHVjZlgzVzhaam9RVCtSY2diWjlrblpqVjR3aEZhZ1BuSC8xdy9ZZmFJdGU1?=
 =?utf-8?B?ZmNPSkRRRm5iSDhZQWRhZkJ5Q2NSUmpZTVJQcTB5TkVlRXJwREt1LzlEdjQr?=
 =?utf-8?B?SjFZam1FN0NvNjJ5eG9oZExPRU5BTVozTEp2U0dPb2ZrY3l6RHUrdXFCR2dM?=
 =?utf-8?B?cTJvK2kyQlk0Q1k3N3JjRTN5NkcxMTJSYU5IMm8zZCt0UzFqbWtONEkwWGMy?=
 =?utf-8?Q?gLb8=3D?=
X-Microsoft-Antispam-Message-Info: jY81coi21lVnjjbcMobhNuF8o9ovAEnwHs+fGq11Tkx9b2ZHhiaPKz9gtCkHZ0XGSwKh58t1iDp7Zu3aT4tGE5orxqChQVuo9JMEjRwVCwnlOV3Y1WsJFbXmEycp1owceqpNovegB4kcHSyYl3ftrWcxIwwUlkDY1zimwiLBsxNyf1zOj46bKrg62EXSM7ZC
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3331;6:B01D9jJhC2884VqpsRx2s47wp3KxYaOXYw2mz50pzrCKgBFV8Bfgc0sFx/5Uw2tHTFTxSe+fKRFTZq9AS95sYZ7ExDJG5cSlEgOlN8a7VAQHphvlxGiJPwWiUxKjBCJCs9Isl5jdqWXEjAqIfGHBxfH3BrIJDnjTn0oXhS2Ob4Nk5BRIiR4FOoyMeG8Zt7+cjYK0+ktQ/q91qjm7n3nmhAJ1QM9rP4486tQCL2zLKEpRR68qQfp2fIJ5foMQWU+q73/phHbbDRYjdWGsDb7x2ym+ATAQ4mSOpSU+NLkqd5KQ2eA1aEVPS2H4mj6/NwW9vA7fega7vLOSEdvhuS/fYxCydJccfFhuc4XKH8GmA0zGn2GI98XSHMmlWOXnq4RLqgGDdm1MfxUyFLDHaWLfm2Ctrn6JiTTr1JbqhQuiCRasuTQRG2cCESSnC5AR27wckq/9V2EiliQY6zs+EHKXog==;5:zYGS2NxukpqJy2zwud2c3Jf0b0TfwZIPwrRiWZ7Pp8hYsZOsSPGBL5kZT9tO/QKBNAh78kq/DBYYwl/0YBFNUXwJPO7tMifKaFs3JxnMURfk6QFPgmSHbmifs3wu1kzCrhrJ98w3SYJYfiVkTC2WButfcC+SWxszwQDW9L050Ag=;24:K2Bvg+VkLZgVlK6YO95dalZJt1GK4EN3iYE6VsXC7UvgkPU6h2qnAF6N2OG8D3ZFdZOFY6gQ7RsKukStlbXw7NaFFBntGbvK1y7DnLFmNyg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3331;7:OMUeu7ytcLKTmfiJmvql8p9sZ80U2oUynbqnzHFLoF2c4MCTF4+eyP90+b5EXoonJcgXqe9Vv6LRdaCQ4QvjuSH1CrhJ0yZDcxhnwvqi7DNn+WaNlpzMzGdiitZ+LGNA2X9HvRkSWpdgTLRP7XsughZA+JGmTkWupQzo8UuxBo3PcNT4Whbk6RhHahw/LXie+MwGWFuC6dBquArri2UH7hF5VVMq7g8RSBOt58aBjehGVXQGjcsxIIiRWiZrWB7G
X-MS-Office365-Filtering-Correlation-Id: 0a1593ff-beda-423d-8908-08d5caa3f659
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 05:19:48.1810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1593ff-beda-423d-8908-08d5caa3f659
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 07:44 AM, Bae, Chang Seok wrote:
>>> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
>>> index ea554f8..e716e94 100644
>>> --- a/arch/x86/kernel/setup_percpu.c
>>> +++ b/arch/x86/kernel/setup_percpu.c
>>> @@ -155,12 +155,21 @@ static void __init pcpup_populate_pte(unsigned long addr)
>>>  
>>>  static inline void setup_percpu_segment(int cpu)
>>>  {
>>> -#ifdef CONFIG_X86_32
>>> -	struct desc_struct d = GDT_ENTRY_INIT(0x8092, per_cpu_offset(cpu),
>>> -					      0xFFFFF);
>>> +#ifdef CONFIG_NUMA
>>> +	unsigned long node = early_cpu_to_node(cpu);
>>> +#else
>>> +	unsigned long node = 0;
>>> +#endif
>>> +	struct desc_struct d = GDT_ENTRY_INIT(0x0, per_cpu_offset(cpu),
>>> +			   make_lsl_tscp(cpu, node));
>>> +
>>> +	d.type = 5;	/* R0 data, expand down, accessed */
>>> +	d.dpl = 3;	/* Visible to user code */
>>> +	d.s = 1;	/* Not a system segment */
>>> +	d.p = 1;	/* Present */
>>> +	d.d = 1;	/* 32-bit */
>>>  
>>>  	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PERCPU, &d, DESCTYPE_S);
>>> -#endif
>>>  }
> 
>> This won't work on X86-32 because it actually uses the segment limit with fs: access. So there 
>> is a reason why the lsl based method is X86-64 only.
> 
> The limit will be consumed in X86-64 only, while the unification with i386 was suggested for a
> different reason.
> 
> Thanks,
> Chang
> 

The unification affects i386, and the limit is consumed by the processor with fs: access.
The limit was 0xFFFFF before, now it depends on the cpu/node. So accesses on small number cpus 
are likely to fault.

--Mika
