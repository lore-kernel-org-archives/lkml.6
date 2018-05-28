Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424808AbeE1LRW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:17:22 -0400
Received: from mail-db5eur01on0082.outbound.protection.outlook.com ([104.47.2.82]:29588
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1424613AbeE1LRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:17:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>,
        Song Liu <liu.song.a23@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, kernel-team@fb.com
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
 <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com>
 <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de>
 <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com>
 <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <1b4ded38-f217-fafa-d920-cddf980a685c@mellanox.com>
Date: Mon, 28 May 2018 14:17:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:10::30) To DB6PR05MB3256.eurprd05.prod.outlook.com
 (2603:10a6:6:1b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3256;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3256;3:fEnWgoQkCNDPp2/3lga8JbJBrROOwSUuGmgOcJ+F/+yOqC5haNVtN71Bq6kPxbQJBEawPCDlEtexXsFoJlVRxEQDq/78YEMZQgUIwfUT7KPCg2RP9BoD1O5NqN35cxn3kKJiw0TSXz1ybTcgjRyuGxnUX5g3aiDamjTmIxDX3tQti5ZWEi1Pb4WIpwsW07675yPakQl7aX1i53+nEnfZueG1ewHs+4BEjc5YjvGAI8OpTQ9LLl/uc7X7cJysybpH;25:jodci2cnilLGrZvnMTXfOCEu+eJMdkw+cq6yaAR8Yyvocqz7EUMGwGzWKOIiRFx7OstjaaDmpGl/g3qjBusuxHjjyuGt1pVC5eoPSvAZfZqqP3zdkOOI9IAJd0jcBFBh2bUZa9dCypn2HcNVK1RE57uIR+hl5fGpxCydLXKEGkc/c3g5fAdU/M5WczeDXfGebCfIhJ1SLexY1C7ZeZ9YiumH552zIQ2O6hilHKQhOtGF2AqbAns3+2SKcTEKgI9sjl76OjT/z+iszxk/ehse8z3IhTox+4qZgmrxPuuveydPsTKvmmv9m0ByRTinDBvZRXBrITOlbDCsPpGZK94+IQ==;31:N2trRZvoxdztb7S+S4Mxzttj6YlCUvqo+ZB/VJDnwrnFYza7RIp+7rAyg/VjGWnd7T0VOERbF3vPcTqyr47z7dkSCeXFKOrIPshfPnDB2Ip9DqnqKGQq85pZzXv7kxDPwP1oUnceVrM8iYsJ41UH6VFc3L0Sjw0HoBBmkvCyHgxRG88bhkRi2brMv/0+3wj0YWoiGAWdbzH0ZNK2RxffCWT406a6qdpRukHLjEnKeYI=
X-MS-TrafficTypeDiagnostic: DB6PR05MB3256:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3256;20:+lIH9xoNL+84ZqOy2eP4Di3zrQtyQ9/HUY4GYnh3/EaQyNDfQAUT1O1UQOpHtN1NVj9bEktOjVFW7q04He/T8BGb/n0oJd3VFKie0dayhmaMUet+fJeVOwM5LNtn7m4jAoc5Zzm8k2goW9riT+Q9WzdwJQTL0Xiq24tyRh1LSTIkUc82kIC/HAUc3E9MN65xyutvYwwabFHvQsq/dCIqcPfTg0J+niX6kYHnlC30ijwdqGZ2Bcy5zQcmVUM8VC3iioSAWUybanPreo/8quVMykAciDSvFLKFDcRRkV+XgdMbQmSmXgFD1FvxOZ2y9dSBgYI6QdgeuABqPfhn9XFfyHUno6ouyuv1z7f/feL2dHTD6Xuc4bvnGtHFZGucS0XvAGNUd+p3YUEVMnXKcHWS96ObGPJmWqCMrV9+P4E9MVt8rKTCoe78ygM7AygYpoKB08vqe4ThcF+U1PbxnMg/4CYE8d5+FzprLncHeaROdI903dGb7eM+SQ0HXvxrxoSv;4:nOfx6+m3A9dwl4MX1iO9bO47kikqiDvR8DRuq8J6BQFzbPdaCo7v3/olMYHo4cJ7fhpoVbC7jJJ63ptxxxJAqNImpI6w3qxtwb9XUma3QwQO+yWxLB5OBw8/OiKXTpqJd0doaNQc1sUZIt2+b0x9b8n/E5dpaR0BF/1LfePzwfxXV5mW7+9SFnT0M2Hvp/REF7XTici9lJz/2AXthS5NO6ijrWeSqbdNSuO+ssOZnltGpwH98m4nL7gC/IlFpuundmF7d9v+55TFY+9KWRsEBg==
X-Microsoft-Antispam-PRVS: <DB6PR05MB32567C688A9CA3329747DD2FAE6E0@DB6PR05MB3256.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB3256;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3256;
X-Forefront-PRVS: 06860EDC7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(396003)(346002)(39380400002)(39860400002)(199004)(189003)(36756003)(6666003)(68736007)(86362001)(8676002)(97736004)(8936002)(65826007)(229853002)(31696002)(81166006)(81156014)(65956001)(11346002)(956004)(64126003)(47776003)(2616005)(93886005)(476003)(25786009)(106356001)(105586002)(446003)(486006)(65806001)(16526019)(305945005)(53936002)(39060400002)(31686004)(230700001)(59450400001)(186003)(50466002)(66066001)(26005)(478600001)(77096007)(67846002)(52146003)(23676004)(2486003)(54906003)(316002)(6486002)(58126008)(5660300001)(6116002)(6246003)(53546011)(3846002)(76176011)(52116002)(16576012)(4326008)(7736002)(2906002)(386003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3256;H:[10.8.18.44];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUIzMjU2OzIzOitaMzAxb3RrdTZSOGJLcDJwUzJNck5TdVpw?=
 =?utf-8?B?RDJXWmFFRmcvbU1NN3VCMTEwZ0lydUkycEp3WExqUUd0U1NoWGFnQkZkc21i?=
 =?utf-8?B?T0JRSWsxSUY3a3dxS01EcXYzUlZpOHMwWWZiOXVrNHYyRnp2ZUVuSm4vTTBV?=
 =?utf-8?B?alZwWkFuTzFOTTJOdTBYVjVqNEdORHdXNk9SeWVrcy9ERFUyTU45N2F3NnUw?=
 =?utf-8?B?ZDNJM1RVZnM5Yi84eDQxaU0rM0E5UUpBL1FHbFYzUTVwZzlrVm90cGY0Rkts?=
 =?utf-8?B?ZmRHeGI3T0JNYkNRZVoxeGpENThRcno2V1hQb0o1a3h5QmxIOXhwQWFQdjJ4?=
 =?utf-8?B?VGpBMU5IWlRJVnUxY0xZdnVyRkpyay9RY3QwbkJzZStpcC9uNC9tM051VTdH?=
 =?utf-8?B?QjBZZ2JjVmhGMExpUy9uc1dRdVBqTFg2VW1qOGtmVFdjY2gweGwrckdqZ2c5?=
 =?utf-8?B?YlNnU1U3ck12am82Nm9semkxbyt1U0Jaek96RGZHMTFkQUtVZm02SXQ3bHla?=
 =?utf-8?B?YmhlWE53SllKVnptNmcvUnc0aXdEbzM1dU5xYTVBd0JlR2tYYVcwOVVXazhJ?=
 =?utf-8?B?K21STVZTa1Bpdlk3RDU5K2R0SHhaSGVFQS8ra0QrMHVvbG9BR20wVyttQy85?=
 =?utf-8?B?alhMUU9DQzZ0ZVVSeUtZdTVLTC9JcWtLNUI5LzJ1OXhSU0xKR2d1UUJHN05T?=
 =?utf-8?B?R1h0R2lhYWNNdnBSM1AwZ0E3eFNUTFlSRUpRQUl4SkhiUzZsNWxXUjNsUXYw?=
 =?utf-8?B?dnE1MzZMR2RKcmRhOXN4cFBOVDd3MldGRzNSZmN3Q1JXaW1zOGIwRmZld3Zu?=
 =?utf-8?B?eEFxVFREa0FqNGhEaVhOVktsenFLVUNrMlRzNkVyZnZUYm5vMUNuVjhDQjE0?=
 =?utf-8?B?b0hpS1RaR3Jtdk02ZmVkNFVqRjF6MU9rMkNQUGlZcEFra0R0dlhjZnZnNEFE?=
 =?utf-8?B?QlBrLzUyUit2UmNxamw3SHpmUUVET1J2T3FRN0JZSGQ4M3VmcWxkbkQxQzhB?=
 =?utf-8?B?ejVpaGR2N1lzQlBPNWNXbzY1bHhCVmFFNUJiZVM0YjNIS25zbzI3ekE4TTNP?=
 =?utf-8?B?eWRpYkRPKzdxNWRTNjhRcmkrUGNva0piVERRNjBoczFSSlY0NzNtOVF2ajFC?=
 =?utf-8?B?S0hCUjc4dGRtUzF3aWR1QzN0dTNGVWVLZUdVVUFNMDdlT1c1TkVOSUltdHh2?=
 =?utf-8?B?Rk1KVmpnVElobzN6VW9zQmgrSzlzcXJ5MEIvcS84dGI2RlRTcVkvWHdwd01p?=
 =?utf-8?B?RXVzU2UwcGVXZStHQWREc2t6aDkvNlp6Vk5nMVF4TmFZYkhiaXphUU0rdHE5?=
 =?utf-8?B?NkNhMUx3M1lnZzk0L2FpOWZBbUNTbnRHSEozb2ZHdnIvL3J4QkkvR1FlN1RI?=
 =?utf-8?B?RUQ5b2ZqaFRqTEttL1lvalQvaXFHT1BDQ2UyRzk5SXZGOXBGSGlrZzQzb2kv?=
 =?utf-8?B?OWs0cHZwZi95bTk0WFlkdlllNjQ3Mk80dFc5bW1qTFhNazRNelpGcFIzbGJC?=
 =?utf-8?B?KzRGOWF6dGdobTR6UDRSSDhoWk9oKzBJWURlYzN6NDZORUkvcE8vL243RnlF?=
 =?utf-8?B?b2xaUFFyNjV6cGw0SHFEcWd6dE5mek1GUE8zdTdka2gzcE9QVHV3NmRGTHFK?=
 =?utf-8?B?d3BsUnloZmhudWRyaU5MdVpxVms3SWRzSXIyd0MxaEVBOHpFMzEvck9aRFpp?=
 =?utf-8?B?aDQrT0c3YXlmWndmcEdDQkxOekh0MiswdnFZQ09Sczl2cisvbVo0aFlpZ3d0?=
 =?utf-8?B?dFZvSzhHV2I2NmdORTJ2OHFGZFY2M2JqMVFFaVdiVjkxMTkvSTg3QkJWZnor?=
 =?utf-8?B?dzFTVVpsSVNHdUJQN2hlL3RrR1VTK3YwUUVWNVZyUDhncmt5T25uUDVKMmZU?=
 =?utf-8?B?VkNFRDk5WTdaUlNMZlgxbVlNNHZ3dDF5R2hwdWhvYW0vY3l0VTVHQ0FKaXpw?=
 =?utf-8?B?Tm1mNW5oVzBVamxRbmkyaG1ZR2RwVElNVWZGSjhlNFlTd0ZNK09OeGZaT3BK?=
 =?utf-8?B?STJOQ1RpVXo1OWpEQ1RLcTNka3c0NTNUOUhBMnhva1h0MURKWDZrakF5MmRQ?=
 =?utf-8?Q?Q1X256hcamw0chP21lqPOuvKf?=
X-Microsoft-Antispam-Message-Info: vm/ipyAyLCEK7yRa6L7+3YbTE3z92y7B8rCR3ANe6IYJpQCtdV8nGnQftceAHCY+UA4gxMe0pEU/UhgsAgff+Mb9wdDnSSQMgZOo/R+a7820DL2j2k7vAFc0u6a4qErTa49chLbUTTpHF2P1t0vX+zE1Ay27FqQYg/d9YlGnwYGaCpxLlTTSiH3WXrCnZmWj
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3256;6:KWImZ3zDmko0U42XWFDBr8LBkyiJ0fO9HIsY+X/ndthZE9SjghiuedjR/rtjEzDcA9H/62NvjFqf94SItpfJJHvufNELV9YC0DBTDkI4E8poMaSiqsrt63gnN98QIKfenU/EOID9dJOTdR0kVYIX3BFxNYM75vX6KjSHF8eH+3+xrgq+KZcgO+KYVrf6nvNzrjb9wZ8XqGW43BcHiMzmwPimFzdrS7icn2BEqw2ZJgXsObtW35p1SEvEhesGf68tEUMsXL+AtPmBoVaJaeuylkg+55Oi8rlqrZOXU1fXP2E04xWioZWRLljBowMpgWYkdkoIXufRn8BZ0FHXTUuNMadTAmcuw/mqu4v2VwGFoTSCah2VoHcW4PXBte2fRM+WMqOT+2wNrJUTKkkpaJA1O7a9nDD9oXoEEFq7bZ5/NkDlWUBGhRlSAuBAl6TXZBow0ibc2r8V3Mfwxehmov79fg==;5:70Vb9u/7WdVlZnXOr4BzvDM+lFez3QRb+aQ6DlhYRtszf4YfArpajymSu9wwL0BDo/BjNggJHUE5Pt2KHXqX93aCqqiIBVBxGrHakKsAvKmKbF4iKDBW4n8DRq4gVPqME8XgWjp0lPfYREFmWdU8Sus5rXNmKv6AR9StPE2qlLI=;24:30+8U9BHgCxz/b3jn3zEqDBSCxOFgkhrSPFIaxVwIqwgiJ8KCM9ZNs4dhP2Nyb3BAgoRuv2Wi7vMAG5ZARd6/qcMax67ed5z4HL3fBsdB9k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3256;7:Jlpz3QldfX4dNwZtf8om2VV4OtHIe0rZyPxihIfIr/Q9qsqjt5UCpAwXmSDCDd+Nau3qblHjr5SQ9HG05Ev06+XhlG/S9q52Wxqx0gadO1QsnqXKY9K8O0Bxtq0NZRwy4kXeB0OVx3m362ac6oOcAxouKv4/2YTITbPNl73Asi1NvXLj7KVsRFsl80DjcVeStw1xpPor41hGcSGcwq6sv+CMdinfmtWkOSRrOi1JUpIpPek9lHBoXqD1nN06h5TQ
X-MS-Office365-Filtering-Correlation-Id: aaa2b9a7-99ee-496e-9197-08d5c48c8bac
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2018 11:17:05.3882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa2b9a7-99ee-496e-9197-08d5c48c8bac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/05/2018 1:53 PM, Thomas Gleixner wrote:
> On Fri, 25 May 2018, Song Liu wrote:
>> On Wed, May 23, 2018 at 1:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> On Wed, 23 May 2018, Tariq Toukan wrote:
>>>> I have your patch merged into my internal branch, it prints the following:
>>>>
>>>> [ 4898.226258] Trying to clear prev_vector: 0
>>>> [ 4898.226439] Trying to clear prev_vector: 0
>>>>
>>>> i.e. vector(0) is lower than FIRST_EXTERNAL_VECTOR.
>>>
>>> Could you please enable the vector and irq matrix trace points and capture
>>> the trace when this happens?
> 
> Does the patch below fix it?
> 
> Thanks,
> 
> 	tglx
> 
> 8<-------------------
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index bb6f7a2148d7..54af3d4884b1 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -148,6 +148,7 @@ static void apic_update_vector(struct irq_data *irqd, unsigned int newvec,
>   	 * prev_vector for this and the offlined target case.
>   	 */
>   	apicd->prev_vector = 0;
> +	apicd->move_in_progress = false;
>   	if (!apicd->vector || apicd->vector == MANAGED_IRQ_SHUTDOWN_VECTOR)
>   		goto setnew;
>   	/*
> 

I took it into my internal branch. Will let you know.

Tariq
