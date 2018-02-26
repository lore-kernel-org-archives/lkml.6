Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeBZKq4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:46:56 -0500
Received: from mail-ve1eur01on0133.outbound.protection.outlook.com ([104.47.1.133]:23337
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752550AbeBZKqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:46:53 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [tip:x86/mm] x86/mm: Consider effective protection attributes in
 W+X check
To: Jan Beulich <JBeulich@suse.com>
Cc: bp@alien8.de, brgerst@gmail.com, dvyukov@google.com, glider@google.com,
        peterz@infradead.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        boris.ostrovsky@oracle.com, dvlasenk@redhat.com, jpoimboe@redhat.com,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, hpa@zytor.com
References: <5A8FDE8902000078001AABBB@prv-mh.provo.novell.com>
 <tip-672c0ae09b33a11d8f31fc61526632e96301164c@git.kernel.org>
 <cd48304c-4317-6b5a-bde3-113645df8f81@virtuozzo.com>
 <5A93EABD02000078001AB9EC@prv-mh.provo.novell.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <702b0f08-57a6-0ee0-d2e1-1310c00351e6@virtuozzo.com>
Date: Mon, 26 Feb 2018 13:47:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A93EABD02000078001AB9EC@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P18901CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::13) To HE1PR08MB2827.eurprd08.prod.outlook.com
 (2603:10a6:7:2e::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8abfc281-91c1-4a5c-e1f5-08d57d063d36
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB2827;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;3:ScIjPZ7qAsCmHIaev8/GOuK/xF/JAp/8tVA3MtbNZkJYqCfaGwvKof9O8otpSeAucEAwXn8MGSq9yUs/iHSWnLdytX5epZrLbjIqckCCKGjzSWWLqpBJ8dD7cE8z88WCq+jpJldPj9/5seACGuVSXW/U1cchrrbEh0qyX6OO9CGntegPcwNzxyGaOPwpsJ+n1iM8FEf6+tOggFLG0aQZK33+mscIwHW1N5A5l5hKOsJFML1Eqlb53wvroQSuX/fs;25:bbVqHZMV0B9O7GBfV0bydF1s5RwEPhFylOnDxT2xEniqqvE/cLHGYQEl+SFLLTaYAT26Qrm3A3WlbmIC9Ukf7auX2A8UbpRIg1qlLSZ13nbMMizrroaC+Iz9xL/G53cRBC5E51fD20WgH8I/ZX5U42ZH32L+BHrt1VQiFY818mp1uOL8g2Bo05IKIeXOoQwXrI6ROqddSekAD76lax2dW11xUn5Ep9EaDejpMQMzrMwvgaHRYdF639AjWq6WIwtUGsU23CqpVGJIR50hwNG0tO/7lixmN1mw/g6JUcuf7jOxTUcxGrf5dk+FBlIx6yQFsEzAVesHjpU1b4p9/m03+g==;31:8eDms/UOgkIS6CG4vIFLiuaX5mTzAsxUe4DjmIyfJJpBojNtvtYrTsSa6PIvWtHkXq5n9tzoTYplWGkagN7ApGBVUDm3TBQGt4+u59CbFA3L8NdPeyO6CIN3l7clNkDg52lJfQ5CYQzUjkv3uwr4eLGfMl8Ppz5ocNlQxg36xV7jRYxVX72AUT3ZpXWFuXni1eSAFjbKoBqJQIRJrkYFQmExNXLaGoJnn8PakMMzOSM=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2827:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:Bcvl36BtY7N8HohnltE5+02GYH5O0y2QleegzjHTRl/Z3bRIUjenKSr3jzRhFgDDKuHl7JoItsoYUlKMGXaB4SEjNelZhGshf/+dALulVcM3L8awnZbinm4vUB7IJldAVa4o76hyZubfz4h7BurD4J3p+qL3HVd72+KkCbCS/fxdceGKQHjKWXsj2/U36DWrFoqUh7W3iVeWjJVrslI2ULfVCyLZ4oRsuDPPdw+ehp8PWZ2B/cbdDQ/1KxezLHfBCKHm2UYNrQM4T31wCgsqtyzvgitnrf60ha0qUhYzHgF+brj5YZxv7l11NNIb/zx1r/iw5kSoSwzui696TpcIircUGzSDLKuCUxsEat4DpHEFLDi4KcFpb2D5YIgvlqbrsNRVNBcEXpCCWjdeth4rYpra1CCPKNmHu5Cw1EVUOx9QuCfY2XjUkF/veAky+JI0cyUg8Qp/qWLheYNWzXECKP+/U8thoL5XL8nPqAC9946FGGTGmmT8XdpnbHX/xe8a;4:I1Sg/SMG5+ZCjsPKxtfSnI55FbaUZi4eUW7iFr3Fh/F//r9IzGpcpAzAMRyB76WopAfWzL+XV682yfkwn7O6Wrs8rNOeqMZ9g599H7yfNjR2QGVJORoIstLU9FIaGu3dU/gJSc7kyeCMogfU6QtvT9ioU/JAB2InWsde2B7h53OVcJ1Y2K1+V/UwyYWMNog1Xdp3PE+cwwL2V6iC6rTUZdY87+wtQinIffLK9IKA8nMibvKOdj1EO6xK24NG167zZiAtnpebUS8NdtXKSxXZTA==
X-Microsoft-Antispam-PRVS: <HE1PR08MB282771448F114D500EF2C0DBB0C10@HE1PR08MB2827.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR08MB2827;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2827;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(346002)(39840400004)(396003)(39380400002)(199004)(52314003)(189003)(7416002)(53546011)(55236004)(6486002)(81166006)(6116002)(23676004)(65956001)(68736007)(77096007)(478600001)(93886005)(36756003)(186003)(39060400002)(53936002)(26005)(105586002)(106356001)(6246003)(3846002)(64126003)(229853002)(386003)(4326008)(31686004)(8676002)(6916009)(97736004)(230700001)(52146003)(50466002)(6666003)(66066001)(65826007)(2950100002)(16526019)(2906002)(2486003)(16576012)(76176011)(58126008)(52116002)(31696002)(47776003)(25786009)(5660300001)(316002)(65806001)(7736002)(81156014)(86362001)(8936002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2827;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4TUIyODI3OzIzOkZZTmZiRktyVVR2aW82K0pkRUxKQXA1c2c5?=
 =?utf-8?B?VzdBNGxob2FFckNBMUFjQkdsNlMxVnlmcElONzNLYUJITDN4Smd4RG9RUUNv?=
 =?utf-8?B?ZnF6VnRvK2RLT2toZzFramNsRFRYTUxvQTdoWUFzbnl0YUVMWVdrRjZXd0Ew?=
 =?utf-8?B?M0lsNzN4Vk9odWVQc0pKcVlrcWhrWWhYbFRWV3cwYWM2dTJTM0c2dDZZaXZn?=
 =?utf-8?B?RlBrRXY3WGhlK3hwdXpxQnlNQ3dvajNYUm1UcjRtNVkvNUZmakgzdWRNOWdp?=
 =?utf-8?B?bnVEU3FENDJoODFHNmFWOG5FRWZ1WGhzT1R1ZkIrWXc2ZllpSmdrd3hMSjhw?=
 =?utf-8?B?NUdDclNLaE0xM2Q0ZXdNTStTQVpzTlY4RGZWb3BqTzhkT1ZVUXVjck0vTFc0?=
 =?utf-8?B?aHFXOHQ3TWRpaHlvMkJoZnBHZFcvRHVDNXVIcU5qak9vWnU3a0JMdWd3RkNQ?=
 =?utf-8?B?bTg4Q1VueWJwK1BNU0p4c3pxbndMYVljWStvRUJONmdhTkt4VWFsKzZjbmdq?=
 =?utf-8?B?WjUxVU51REM2RTlnYk1jdEpqS0ZrL3hwODAvNngwZldjQkx4Sy9NeTJBSmVq?=
 =?utf-8?B?S1dXVUx2ZXZMR3NYRjFUWnRJeDRoUVpQdTFkdjkvKzlkYnZacGZ4TmM2Ny9r?=
 =?utf-8?B?RjJRdnU3Q0FXd0hwOXhYaVZ2bG5BY1NQT3JIUlBpcjNqc3dIdUNyemhlRWR1?=
 =?utf-8?B?bmhQaGtLTlFpbjIzRXdEaWxFRTdkbmJ3RnRNdUk0ZURpaFVTcEdiMmcrczdI?=
 =?utf-8?B?MEQxc3NzSUxaTUtmL2JUQVBGcFk3aHNRSGhOWk1MSm5Rd05GNGZqTVhOZVJL?=
 =?utf-8?B?OGh1ZFJDa0lXNUlCaEV5RXJwNk1jRk5KZ040TmdhR1hHdGJmWHhJMGtueExQ?=
 =?utf-8?B?RU83R3JXSW5QUkQ1UUNGM1BUREhMcTZWc1FPcm5NcHczeTBUaG5NTTdUYkVB?=
 =?utf-8?B?RUZGc25ONHd1bzBFdzFmdGJ6TXMrb05jb2tSWmh3bHdKU05FaGJiSGc5STFP?=
 =?utf-8?B?b3J3Vm5WdEY4YkM5NzhPdVUxbmgySEpDcTRxMGE1eFVhWkx5K3NZZm1malg5?=
 =?utf-8?B?dkFtWVQvOURvSVQzbFZQR2E0em1vdjh4bzJNK2NIT09PK1lKbzJxRjYzajBj?=
 =?utf-8?B?cUFNNkROQ0g4UmxYMXF2OTBiRTJoS2craDBUQ21WWUVZYUsxdmx6cFRpb0RY?=
 =?utf-8?B?bExrU2R1VVdocEt1ME5hSUtNVGdYZGFkMGJSQmx6aFREYjR0WHNMZVhocURU?=
 =?utf-8?B?cDl3WDhyMUZVdTBLclViZmZob0RnQ2h3NDRVS2U1UzF5dDJlRnBFSGRvQmRF?=
 =?utf-8?B?bVQ4c1NCV3dWZGh6Y3lROUFJS3dITjlUN3JncWhPOHJaSlZIUzI5Z3pmenoy?=
 =?utf-8?B?bDNwd0NjUmNUbmlXMzVFYUhCS3pyVFVNZFRNOVFvN1pnZkw5M0FtbEk4NDJP?=
 =?utf-8?B?di93TEFVaGphdkNYSUhsWXFkRy9HNG9uQ0RDNm5uYlI4ek1QQXY5UDYzZzcy?=
 =?utf-8?B?NmZmUHI5d2RDaEFGMjVoRkY4WDY2NS9VaUNxSUNlNGhScWhGMUUrUko1Qkkw?=
 =?utf-8?B?UFQ0ZlhuS2pHanZodHc3OGlkbWJRL1Q1MFh3ZStWazlpamltTDRqUmNtWDhS?=
 =?utf-8?B?T0s5eURGUCtjUUlGTko1Z3AwTGVXUFJ5K1ZDWVVRemdvdGlrQ002alE5bVV2?=
 =?utf-8?B?OFFabk81QmdOR2x2S0NmK0FQL0ZUZGJEbFE4eHJDbWZ6R2E3R3pVZHhFTEJy?=
 =?utf-8?B?TlYrdWhsK3dGNjlCQTUxTEs2VkFVTi9lZGNqeFFXcmNTSG1pd1ArcDI3bk9D?=
 =?utf-8?B?SlZoOUwyMktuSE9IVUcvRjZmMkY4MGN6Y1lVZnZ4N1NXUGxVeEJ0TTNYUlUv?=
 =?utf-8?B?bSs5ZkZKUDhvMDNQQmlwMER3OFVzOEF1SDZJdTh2cXZGK2ZPVU9xWnFaR1dh?=
 =?utf-8?Q?N9pCXN9qNqm6Oy8t3edS2xhhP4hq4c=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;6:q4o+XSWjFSYJ/9SQidw5+MctabNmZEPrnBuXWFkQf4E+4lyLKpmWF80X+h4x+to5lDOH/5G/6WPERNLxqe1i1Y/GyesUuMvlyx3kWoe/3BXsoMUds62Fq3U6dMvcE6HqlVewm3+Mt8ZVBTfea6wakHalu5ApZYxKJ11yzdg0EewFfThWNo23iViVtIT0yI/Z8Fm9VIKAdTsVzRUTJyQ3B+ByVwZGp8Dhdl2k0t499TFKGrFjEfbE77IAwsASygGsbDCMLguUsBlU30uEfs2BmGu5FoeIjlOaJPzjfMV+mPnFxXluNJBe9yjqcr0/zfaYDGR50DCF3p03nbdyVIiaoea/YvYFx/WQ6qD4OJ4NkeY=;5:xPO55iYbIRMreVIXzBYfl7eYlZaElYjwLTqYS/d1ES8Hyft+sinwA6KCItdQ+IpAPDg2BT0WWOaaub8d2qiXTh9TpOLtLEDwJN1DtEi/4egnoao+HhXue0HrAwoLVeF77Jmgm3kdhHVgRG4wDiPyd/O0rgujxl3PUXEZgpXpnrU=;24:wuCZYPEN+pn23+LeWCZQgnZrHY5R2ZJr/g7iSZgnRWewgn+OLYrIFegGGLzNERZgFcYPir8/Ix672FjIIpcXABjfaY5aWIzsHUaDKR5FQx4=;7:fDwYV8duMXrh59rkDbN/rTvXOYrbB8YygGFSFaXaELDqHG5aFGt1Oib+0o0opCMgf7TINOjSxqX49Wm4esP0xB1U/YyC2TjozRgX0p4GJyPsaLMlTobn+CLyc5wMdE5XZ9N2dyWBuoinS6Qs3BKOMQyCxPvO+ZGBXva3hm8JycGODil9gHWFdDvDVWDJOYRhHAoWMBi44BmX449LxuFfZp0OY6GthDS2HH4zwZdAG+gpwDU69BW6pKEdBUKX6HpI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:Et+xJbK8/4wn+t0ZDjVuuH+eB5upvWEzdKJbYBE77aM1RLhQTB/ovJyP8+OH/53csuv3b8cS+SYgMIQvGEfVX9/6U8KY8JHww84DlTUcve99eaw9hF5PlL/vfgi87/lPQEZIH+1LZahR2Pl2FGWTjdcxP5MF+ABzrt6YN7toILM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 10:46:48.7763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abfc281-91c1-4a5c-e1f5-08d57d063d36
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2827
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/26/2018 01:08 PM, Jan Beulich wrote:
>>>> On 26.02.18 at 11:00, <aryabinin@virtuozzo.com> wrote:
>> On 02/26/2018 11:48 AM, tip-bot for Jan Beulich wrote:
>>> @@ -351,7 +362,7 @@ static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
>>>  	    (pgtable_l5_enabled && __pa(pt) == __pa(kasan_zero_p4d)) ||
>>>  	    __pa(pt) == __pa(kasan_zero_pud)) {
>>>  		pgprotval_t prot = pte_flags(kasan_zero_pte[0]);
>>> -		note_page(m, st, __pgprot(prot), 5);
>>> +		note_page(m, st, __pgprot(prot), 0, 5);
>>
>> Isn't this disables W+X check for kasan page table?
>> Methinks it should be 'prot' here.
> 
> Might well be - I actually did ask the question before sending v3,
> but didn't get any answer (yet). The kasan_zero_p?d names
> suggested to me that this is a shortcut for mappings which
> otherwise would be non-present anyway, but that was merely a
> guess. 

kasan_zero_p?? are used to map kasan_zero_page. That's it.

> As to W+X checks - I can't see how the result could be
> any better if the protections of kasan_zero_pte[0] would be
> used: Those can't possibly be applicable independent of VA.

I'm not sure I understand what do you mean.
If we somehow screw up and accidentally make kasan_zero_pte writable and executable,
note_page() should report this. With your patch, it won't work. 
