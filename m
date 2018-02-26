Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeBZMpm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:45:42 -0500
Received: from mail-db5eur01on0092.outbound.protection.outlook.com ([104.47.2.92]:35105
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752690AbeBZMpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:45:39 -0500
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
 <702b0f08-57a6-0ee0-d2e1-1310c00351e6@virtuozzo.com>
 <5A93F56E02000078001ABA78@prv-mh.provo.novell.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <66305b15-fab0-8549-9219-1cba21ac9e5d@virtuozzo.com>
Date: Mon, 26 Feb 2018 15:46:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A93F56E02000078001ABA78@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To VI1PR08MB2830.eurprd08.prod.outlook.com
 (2603:10a6:802:19::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a12778-308b-444d-736c-08d57d16d502
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB2830;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;3:fm5r7I7ggTEIJixIESRGUQXo2fpvOlxfUMDn7B0Sq6UBwfdIuIZRDztuWZl8TmRIeCBxkCdaNSNKIu0eKwoKlvLyTp4rcg/4Ik2A9ywIFTEIkA21c6oxfQW/j//ZMW6LXeBV6g/BgCbL0FmnveBh4khmeRnTFEnonFDQCEps0c/khOLhAEsizotlhMiWbV/WdTa99fzJl/jWbS5y77h3Z7du4r2aT9Yev+WOigwYgDhBOp6+fj82ignIAg2t3QIe;25:YLisa7fiSVAMf2ObBOv1wP1lUblaKxJv7i/zIE9G3G1/7oX9JXtGgI88Afh0niDnycer5W0ZIz4j0S7BwiHx0cnpSgJ9Cj33WI+cSlSNH6+pRbCHwAjB8ILYZSNM1GgHzZmE3eqAOJg7lCMSW/1RNdZiWKNQO8E28dTZawQeJAdwRSq9u5+YYHAUYv04OLpwRQg3HRhsmHbwu37R4i87t4SPikPKcWJuJWfjAuFh43q2eAS0f9RBU3zHxNEMhdKlsEaT0LhjlpflJ7LAsM65uKkZ19fkyPJlstULdcWgOdE4TMA1ckwxL0F18DX1oYPJqO5j1n/Y//Yn+lOkVZP7QA==;31:9Dgm1jQ5hMdrZ2vRkUKwV0xyo41hZt5MMscjAdXaXB16Wj0K6kIPWW5tkI10iYFFSa39Usro/8Gsau+xnvSleUJuPIIzdQP4mkFExjWxmzkmCpjnkljrADIgq54W1TkfaLSjFmbuHMWnJe01X3lGIhOEUa3QuKKPxmCV4LPnq9Hj8qxfREyZidwOS3cEwsh1xBLCvvRsr7/rU2OMQBpTfYib/aqZOuVAEcgvgRp5PUk=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2830:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;20:fA3/ANkkFAK4hdjOmjdPJHKaKA3vl7biwE5ISjBTGY4P5lRa+2l88COIhsJ+7TpICPM7GcZ+ipocHJDNzeQcb2yCrS9ggK7Gz46fZkFOOEwpCjR6NZ+59AX3b3x82kYmgIbDKlplkXV0EOR0M5GG2TvOY4g6nAU2MGNCHapLuOUKJXDa1KE86ZeSoqN6kKDNrq3cuDDoR51ZLTWulZXqxPF3O+cZLOPSTcZQ8Ann8sEG1/ZEhj6zaTZ38XcXjJikWTS8sCs0B/uzwRslr5CjHYcstnnA8eddF1wn9ub6rpLkYVuuWK2UCxkkwQ7WDbgovTKq/+25NisYE6EPnin5e2tm9KiRNbRpXdhe4bXJZXtjH06WCwTqff6lKRlD8r97eInrmT94k+EY7NWxA1SQpr7pY3W/grbGGgzuS/fcvVkeuOK4Gnmb4xm4rp8qngeIlZtQcr66qGMmYP8f48RwNrHKkFo25bFlP+h4lc2iuPyYp4+loYisBlIbBm6tnlfW;4:nG0Sq/b5NbMezQ0hIe+fI01ZnCLbOUydG5l4zMLLuCxg7qZSgkXclvxoP6eY3riQsXtraFSxrWVsl588vyjwsby+BDgfVTbwRA4/qVRLyMDus9vSrtdXQPIP0B3mwx07IDcnrxDr1FX2OZvdvCoi8Xc8WRDf/H7+NTOL99vsuW0B7WAB49BZtGJQWxuy8ZY6UAHQ7bVRDamT8e9/BsEWSxTzwFCx8KeQDZZ9cRob3p/lEalwFMhZmGp4W3Ka4uzT3oxlh53l3/TerANOS3p3vA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB2830991A0BB226478C580951B0C10@VI1PR08MB2830.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231220)(944501161)(52105095)(3002001)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR08MB2830;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2830;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(376002)(39380400002)(346002)(366004)(396003)(199004)(189003)(52314003)(58126008)(26005)(68736007)(6486002)(316002)(2906002)(5660300001)(16526019)(16576012)(186003)(65826007)(50466002)(77096007)(55236004)(53546011)(6116002)(386003)(478600001)(59450400001)(3846002)(97736004)(6666003)(2950100002)(305945005)(6916009)(81156014)(86362001)(230700001)(7736002)(81166006)(8676002)(229853002)(23676004)(52146003)(36756003)(47776003)(39060400002)(25786009)(106356001)(66066001)(65956001)(65806001)(52116002)(93886005)(8936002)(2486003)(64126003)(53936002)(31696002)(7416002)(76176011)(105586002)(6246003)(4326008)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2830;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIyODMwOzIzOjlSNXlqMmZrZk84YkNWQ3crSjBwK04vay9V?=
 =?utf-8?B?V1lHbDJmRXdnVWl4ODZIYzUrOGFPS25QVnNyNDREcWFQQk94TElPdkd0YmdY?=
 =?utf-8?B?U2IvbGpMdVRkd1lZYTY0N1NZazExeTBMb1lkS2FXVngyQUgxdEVkMmJLYk9l?=
 =?utf-8?B?czdmR3l3czJNcVAzQ2J5ejBzUHBMTEE5ejFkM3hiY3ZiVWt1Rmd6VE94aldl?=
 =?utf-8?B?b1F2cTJqa3RORTJvWHJVSEpwajBpS0syYTRpQWQ0a1docWVzVWJiMW5RaEkr?=
 =?utf-8?B?THZqbVltNy9ZVHphU2lRQUdEWS8rMjdTNWJtWW04RnVZRWIvUWtZcys1dkRa?=
 =?utf-8?B?ZDlvSm4zV1ZEUkw3K1B2TUwwMmVNRHVoN2hRMzNzMGF5NXBvQ25UdW44NVpa?=
 =?utf-8?B?ZHhXRzNpaUFEcVZSVG9FU0pOQlY3d0V0clFLQmwrSDlYM244aEo2bFBjUGsx?=
 =?utf-8?B?VVhqNGtuNHlTcjIreFdDdGdpN2VRSzdLRFQzOWltVlQvQlRLOWNTWHFHdHdO?=
 =?utf-8?B?S0k2S2FQaGFOeXRBWDFGYlhrSisvak5TTzIzMUE3NnNQSGpRSk5FN0NmOHdL?=
 =?utf-8?B?WXVFTzFzUURMdGdMVVZYU0JDQmhaL3FsWG9SQi9qM3VFV3AybWVEbmtTVENv?=
 =?utf-8?B?dVliaU9JUEl4cThPZCsrVjd6Zmo5b0Y1WGFHbVdqVmVCL3FEWnhrN0VNeXFp?=
 =?utf-8?B?eFhEOWFLQ1BhK1hCdk1HNFlXeUJLN1M2S29UR1BTQ1V6cWJ0UFZMelV5L2xy?=
 =?utf-8?B?eDlzckE2eC9TM0M5c3A0VUZpT0dBTTBDYmIwOUJVTXdiazZhaEVsTDBLQ2I2?=
 =?utf-8?B?bURFYmc0OGxnOTlGZWwwOTFCcXY1SlI3cG9JTEpmZUxlK2hHYkROdCt2Ty90?=
 =?utf-8?B?a0hHTDRXVWk1RzdacmZscmQ3TWpoMnlyeGI0S0ZIcTU1cEJUdDJkOXRvbGhE?=
 =?utf-8?B?VHEvOUhGa2JzUmNBM1RXcTBRYkgzSm51YnYxSkhKNnAvYXlNYUVMZzVHU1ln?=
 =?utf-8?B?WEo2Q212NWxxTUFSeDUzRDJ3aGtRbkxMV1RGcldMbzhEZ0gra1l1Z05OYWlF?=
 =?utf-8?B?YjEycU91bXNQWC9zVHVCb3Q1R1hIZ25Zdll4dDMzZzdZS2JEWnJ0VDl0cmIy?=
 =?utf-8?B?QjA2OER1TTE5YVQ5UVViSUNwL2FCODZZaXp6aFUwZHM0TXlmSkwvaERsR3Y4?=
 =?utf-8?B?TzA1cHgwSC9NcFdnanZZVlQ0ZE8wV1UvQlhybDcrb2Y3MXl6NWRpVXEyUjhS?=
 =?utf-8?B?S2wrZ2NERHJjZXczMFFmakJveXBDTXdnQSttQWcrYUFId3UzanVoaDhQbnRj?=
 =?utf-8?B?cm1takpEUEJGbFpSeFkyQzQ4RUR4NCtvUERjUVNSaHhYaGt0WWphWUlra0lt?=
 =?utf-8?B?b2dyWUQrM3h1OVVrNitaVG9kNHFZK0I2SHczRWxOdVRRZExjU1JZeXc5N3o3?=
 =?utf-8?B?eHdYcFhsVXFSbXBXVVpuYWFob3d4eC9rKzFNOGZVR0FIWWl1Rk14T2dwc011?=
 =?utf-8?B?aitOU2JObFFXMVZkcG1vSUp0SDhaWjRDQThHcUhQZ1pGRVRtQStpWVIyRzlh?=
 =?utf-8?B?Yi9sc0kxTmRpNWl5Ull0Q3NQdFlFcEJjY01BbjVyNkVwSE9IUnVDcGxYS0lk?=
 =?utf-8?B?Vmg1MEF2M1hUSGczTUp2QzhDam02NFQrUzJCYjllM1p6NTIyQ0tiMEF0ZDUw?=
 =?utf-8?B?OTRhTXJhMU1qYmt4empacUpiSWxWbWxrbDdWV0tuRTdydzRxMWNmd2pZTFZH?=
 =?utf-8?B?YzliU29VNU5PbWk3dnpNc3drNnJUV3ZQZ0NjTGZDR1lLZHBPMGEzS2FLa29Q?=
 =?utf-8?B?VWw3cG1qYXNKZ3ZtVnVHVEdHN1VxL2JBMUNFOWRnVVRpVG9YbXQwR0JtK0Rw?=
 =?utf-8?B?clYyaFpYdGFDenBaME1vTzQzOG85YnV0RWJSL1FBMVJoYzV0dGpSU215MEgy?=
 =?utf-8?B?bUxIQ2NwVnBrS2xkcmcxK3liOGxpeHNWMm0xczhiZ3dxSkZKNThnQmt3YmVz?=
 =?utf-8?Q?DGQMXA?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;6:F5Ui6BsG1Uu1zMTxzfP+VnPxAbQuRlMKnRtKSpOYtgdQmt+AO6ER4uPFiJC8zfXzqfapIoz+bg5sNUwHaryv2oBs1Qr/4BGrjJZAc9/Xn7eTszRXKt78bocjTSK9k25/FBlq59KD7GTtG0rXWUrcchNaKu8hS6gEWguM09mtJgaJubwSHERsKKEabxi1uvOrAKDUIm57otWUITbDVa8ZFCPiJb3o6c2yvJ6AvV/ZxCqHqTfiAR8FHxYUDPzoUICXeEUNm1tOQ5+3L9FIis9GuTXa7S/FXsE7fDiUztIBZAjjjm0HT3KIfl842KtdWVrZIXUyKPk45rpV8sNquzEkpFzPUS0mz8ivcMbeTgh4fDM=;5:pHcNNbOvgky+jJ3loR/axnPAt9HhUYaq1hxTmvNswabXdsCuudIDd/qprV3FW5EMcBMW3sovxu4eUFeDj/mkCl5T5l/8GCm3gGGomj4x8AuJOiO2r6QfKeQjMyqDFNQEBJ1enhGf7of9BS/oZlUeBOjbsoFEME5+RlodX6dmmh0=;24:PhpVxf+fqOJJ+lRjDuch++jvbzqxZKscTkPxlQjNepj3dPRJlKMMZnRsD4qnlroFYT+7nOTG1gChqQUDoQmiE0TO6GzlFx+xWXPTvdqmFXM=;7:/mfoKQ0ue9x8QrKfsaG69EkyITnqMtTcgeLRvZgaoSuRetx1EW9b43u0rtiEwZKt5FqwdH28SOt8EFtqi6hGN1kmyCX1B1X+gWjb0VoG10nIyvOC91GkB+/jrqQLFxj7nCC0/aV0rV6qveZoB0r2CbyhA3IDPMc/7uqy5oaMKwqQnxJQFpv5n2aYi3rAPaiXONxl8JEsVPioBHJRWKo2T8dA+eXtLtVB2shnkiKjWSmbwUegh6ukGP+bu6q8/H91
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;20:tzcTvTY9/oRRd5fv2OQF1qLHDHdcWmtfOhHyj7FB68FEtnWtXXmqcbdBozHr6yUrUx8ADmkQAybIezOzqVNQGXDZjXTlKAR0d6TGd6aQz095ROzdP7EhYtGQeeyh6yHwBE64Dn7bSep8938MDAcVQiUqjoPP5uTqf6YP9FXTvJM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 12:45:34.6597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a12778-308b-444d-736c-08d57d16d502
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2830
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/26/2018 01:54 PM, Jan Beulich wrote:
>>>> On 26.02.18 at 11:47, <aryabinin@virtuozzo.com> wrote:
> 
>>
>> On 02/26/2018 01:08 PM, Jan Beulich wrote:
>>>>>> On 26.02.18 at 11:00, <aryabinin@virtuozzo.com> wrote:
>>>> On 02/26/2018 11:48 AM, tip-bot for Jan Beulich wrote:
>>>>> @@ -351,7 +362,7 @@ static inline bool kasan_page_table(struct seq_file *m, 
>> struct pg_state *st,
>>>>>  	    (pgtable_l5_enabled && __pa(pt) == __pa(kasan_zero_p4d)) ||
>>>>>  	    __pa(pt) == __pa(kasan_zero_pud)) {
>>>>>  		pgprotval_t prot = pte_flags(kasan_zero_pte[0]);
>>>>> -		note_page(m, st, __pgprot(prot), 5);
>>>>> +		note_page(m, st, __pgprot(prot), 0, 5);
>>>>
>>>> Isn't this disables W+X check for kasan page table?
>>>> Methinks it should be 'prot' here.
>>>
>>> Might well be - I actually did ask the question before sending v3,
>>> but didn't get any answer (yet). The kasan_zero_p?d names
>>> suggested to me that this is a shortcut for mappings which
>>> otherwise would be non-present anyway, but that was merely a
>>> guess. 
>>
>> kasan_zero_p?? are used to map kasan_zero_page. That's it.
> 
> Ah, thanks for explaining.
> 
>>> As to W+X checks - I can't see how the result could be
>>> any better if the protections of kasan_zero_pte[0] would be
>>> used: Those can't possibly be applicable independent of VA.
>>
>> I'm not sure I understand what do you mean.
>> If we somehow screw up and accidentally make kasan_zero_pte writable and executable,
>> note_page() should report this. With your patch, it won't work. 
> 
> If this is a case to care about, simply passing "prot" won't be right
> though - the callers accumulated effective protections would then
> need passing in here, and merging with prot.
> 

Fine, but this won't change anything. Since kasan_zero_pte[] always ro+nx, the effective
protections should be always the same.

> Before I do this for a possible v4, I'd like to seek clarification
> though whether this really is a case to care about.

It may be not that important case, but one of the points of this code is to check for the absence
of W+X mappings. Passing known to be wrong value to bypass that check is certainly not the
right thing to do.


> Jan
> 
