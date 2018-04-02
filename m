Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeDBQ5s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:57:48 -0400
Received: from mail-db5eur01on0138.outbound.protection.outlook.com ([104.47.2.138]:52736
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752878AbeDBQ5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:57:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] x86/mm: Fix documentation of module mapping with 4-level
 paging
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
References: <20180402121025.10244-1-kirill.shutemov@linux.intel.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6feb8d6d-9856-1f0d-7bfa-41e05961a719@virtuozzo.com>
Date: Mon, 2 Apr 2018 19:58:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180402121025.10244-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0017.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::27)
 To DB7PR08MB3259.eurprd08.prod.outlook.com (2603:10a6:5:1f::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1dffe31-8882-4e21-e320-08d598bad8d1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3259;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;3:EmAkfuE2k75TuGg/HYl6tUnD3u7ZQDqgWHggYfngtt6GEfT3QgJO4SJkIxKI84/AsReLeSmakA+HKxtvzwmDWGxR5yWex+eHcAQ3CoitIA1cMXtarBQYP3nTx+S/zAZGZ6ObhCopTCzQRSLcISljaNWELxLRFYVu5au/zDF3MKiXgdLweOoIAUTmtLhSZ9Ne0yX1iurfcNL1JjZz/wrlvndGoZlyuwicNpiao1faAcLJ7vt4Fi02UvjsrIfkxC6d;25:nZ8v/xRBRkbFuLJ8weyRs0vPLNYFACMoTlBKz2muieXIkBxOU0kOKV/tMyabK1rTLFFuoxifYexApYJrb+4opbNYB3g0MfVHCKzhkNKEPOs9bQXVO6Ue7gUTiOqvQIoVAupSOhloZgZRyD8Cuyfh1I5Fl0MMsJXKr7Ha9LjaqzSea3UtZ7NY7E37VaHraCbqW+vGBFI9nFjHAbEtycTB4/zR4DzAodkINPqFPnDlEMSEIIw1sy5MKmyfSFX6Lv+Kg0zUVY0E30HSl777v/kXPn1VbVKfpWs+fyrQD2Q3usdRlW5hkvVb24grsVbN63oyEeJ+vWmP6QhGUb7o3zeQjA==;31:/PUUXJ58XU7lPhTGU5c2dnLJYkiu3aOrxPGL76wPOXiq8Y90CJPT7BYuxGWsW5Xrh3lXoBuEt83iaAyc/WcTGij3ZoBk60hNJHKUSer/6sqnotq8ZGveatpUr0f+VRXEud2RDN2ldH+6TBajTpkveu6t1KtsxtPL49JXR8IQkeautKCpn1ckGAJuW08MU8OoojmXAGcgIwgO8GytrefqkWpdHWbDfb7EFq7+pXOeRog=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3259:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;20:B47gMQ3dQs8GI2SxGVS3CEexOlTq1TFYdTLD6HJjAQTXQp62coZ0Xrq81V9kglj26XgmRz4jDnDR7rqqTNWQ9x4m+cFNKY613lx/eNBLvWLDgoGbhYT+CjmXDN6CE2fnyeVqJWjX7Na1LnJJu8rhC2XiHfHUWPpLrqCDZ2geqF/ajiu5hiT9L22DsNUPwNSP5SFZuPBY2GbcvUH1sywahh/STSS6JlnBwzUUSL/foO1k1DVMvG5x7d29/UtMIaJ9juvtqhUO+lR5Z/D8BqXt0i8FtJnFYXI2wvXzMdSh4JDlqyC5pdnT2srkgQcrpj+4MiTEBdm39QM5nX+d9NABfrqS8kbpe2C1YOZGuHYRRJeQXCf4yVnooF0DGQDy9ltF5RlxeOHYltiUsqHeYzoRwDX1ViG7joPMwbq8k9oDBeoQ/YRtHy6/VMYqF8FOIwh/U2arto7wLiVZMu9Z4qUA+Hqt7TJWNjy17CTj0FTbw9TnAO3fOzi78NoHdpT35To1;4:0Hw5LoKcyoY1Qgvzmmf3Z5/lA8rSjr4/R5GWWPAqTT1Fewsl7mdZtW8cTFvvlPeb0ebzxz3VuRrIAkN2c/m6rvyzymIroVDdeuAJp81/ZOQQsLQMyZWa6UAdcT6FLlM9v391STMA5aaQRFWja47gErt633UaxV4RTUOLM0nYegQDopkj/xi5RGTKGxnVNKkqA9wVErsyhdP4SeC1ydKxd2uMYmpMKBVZiNJBvAu69Cujg0+jO8UIwz2xStWYaNbfWH79ftKrWlJrUro7sXu7lg5Jf6nCwrfrnfPnHMNKTBnRgUN42Xx8ko4kSBDmClmo
X-Microsoft-Antispam-PRVS: <DB7PR08MB325952E4E9677D2C31731200B0A60@DB7PR08MB3259.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB7PR08MB3259;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3259;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(39840400004)(376002)(39380400002)(366004)(199004)(189003)(66066001)(52146003)(486005)(31696002)(52116002)(6116002)(53546011)(6486002)(5660300001)(2486003)(23676004)(4326008)(59450400001)(386003)(76176011)(53936002)(486005)(65806001)(58126008)(64126003)(229853002)(6246003)(2906002)(476003)(50466002)(6666003)(106356001)(65956001)(65826007)(3846002)(68736007)(47776003)(105586002)(478600001)(446003)(8676002)(55236004)(81156014)(230700001)(11346002)(36756003)(7736002)(97736004)(316002)(956004)(2616005)(31686004)(110136005)(26005)(186003)(16526019)(86362001)(25786009)(77096007)(8936002)(81166006)(305945005)(16576012);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3259;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU5OzIzOmhnNVV1REs5SEtIK25QUndJcTZ4Z2pDWndQ?=
 =?utf-8?B?Zndnc2dlZ1JHa3BrZlE2NkVUNmcvd0sydi9mRlJGa1ExZHc1S0x3L3pYVGUr?=
 =?utf-8?B?Q1hLdzMvYXJoR3JLeHREbW5JeUYzRGJYSXIzcC9UcXRLZGI0QUhWNkJMNm91?=
 =?utf-8?B?VUhhMWxVSEJFMTRaZHVYRWpjUFFEcGY4VWlwVE5VbHFzdW5Pc0FPZUx4alV1?=
 =?utf-8?B?eEVmZ0s1VVlUTWM4MEtMS0ZFQ29rMzZrYzhIZGRjSkRxbTM2dXRjaXpBWEVF?=
 =?utf-8?B?QndoTDE4d2czUDN1akM0Q3JkYlpaemZEdmlyeWlpUmdpTlFMT3lNcEN2UTlk?=
 =?utf-8?B?dWdYVmxxa0VxV0pnd1Vma0pYWkNJK09IQVFmbG5OUzNQWFlJN0M0eDhEVlNi?=
 =?utf-8?B?Ymk5SUJNZDdwMmxFYXRRaDRzamZmY21PZUtpUGExWXhoZmpMQ3VGR3lGNVpD?=
 =?utf-8?B?S0IwZHZKbFJUalVvbDRFWnR0M3U2QXZJOU51cm0vQ1owakI2dElvWHFOZWhx?=
 =?utf-8?B?U2gyYjZhb2xrWmg1Z2NpWE9tM25vOXEzbEcraUFqdG4wRi9IcENUcGlPd1c3?=
 =?utf-8?B?c2pRMnZmcWxOc0hnNGordVhCVHJBWHZlKzE4QmdUZVhYZUlnQ0pSL0Z0TjYy?=
 =?utf-8?B?ZU1YTm1kTXZGV3B5UC9aNDlBclpjeTN5K1BDVGFwQm9zc1ltdHZ2eDk2ZTk2?=
 =?utf-8?B?ZEdocmpVNFhDL3lOMmVuTCtubi9JcWJlK3dNeFkyQUxwYTIrRktjaXJ2aHMw?=
 =?utf-8?B?NFpSVG54SitWRWVaU2JQdTZLMks5YVROMXljQnFkeERnTW1mVElCaEFVVUN3?=
 =?utf-8?B?NXZWNWIwVnMxSjV1dWV6eDFzMGNOeEVla1NqNjl1ZDRyODhaTVJRSWQrMnBu?=
 =?utf-8?B?UlhoWUo0V3FodjRMVHlycngyZmpxWUpJcGkvTkhBU2I0a0RTaHdDWkF0MzF5?=
 =?utf-8?B?cmM1WUlOUU9QMnkwUG40MVh4TFJtSHUrRVpBNmI3c1E4SmdQd1BjWWtQTXAy?=
 =?utf-8?B?RXhLZUxQcDZwajA3NURiN0UwTnVsM3h3Z1NrKytxWndxVkpYelk3NTRsQ2Nm?=
 =?utf-8?B?QWlSMWFGSnh6aGdqRU1VQ05IMEhUSHBvVzJhVjd0NWNDbW12bWl3dEZzSUsx?=
 =?utf-8?B?MUVlV2lFdjhpa1ZLcThTN3N1am5xNXVRVXgvY1BPWERNMG8yTjcrQnIxSTdq?=
 =?utf-8?B?c3E0am9lTlZKcXBmQURma2pNSXJQMk9RMVVPK3RGZ0VhLzJ3c0JKd1paQ2dH?=
 =?utf-8?B?bTJGL29VYUZBOWFHcEtmcFE1UXVKeWNtY0N3UEp3aWNNV0lLalhhMWdIbGRV?=
 =?utf-8?B?cmtkU05ySGFuQVJ3bVE3MzZSZVJSTHJJbzRlMTFlQWFrN0c0eGRibHMwZjE0?=
 =?utf-8?B?b0k1Y3pKK1hTQmJsVVllWHpEYnl4cGVyblJnSDRlL0VXMmZJQVpQbkVVR2ZZ?=
 =?utf-8?B?UGlRWjhSZUJZSzlFU084UHNYYTZaVU1IVU9nU2x4eWZmb2htQjFUTlUrc1N3?=
 =?utf-8?B?SFJWOVJPbTVJYmYxRFlMZVZSOUFhSTExVFdnQ21HOFNFcXlYM2NGWVRXbzgv?=
 =?utf-8?B?NU5PSWczdWhqQ3hHWVRRT3lDVTk2SjJWU3ZqcFEzK1N6ZmVOSXRXaklaNXlY?=
 =?utf-8?B?SzBLVVo0dHhoNXIzMk5MS2pKemdyUmpnU0ExYjQ4enAwdVR5TkdyUU1LL3lm?=
 =?utf-8?B?ZzVEc0FpcEd0QTBaMFF1YlBhRjltbGRObGtnbUJDQUVKSEFhZDZ1dVExY3Mv?=
 =?utf-8?B?U3dVODh1cFR5YkVlR2JrWENQOVpjWDJ5WXhBaDgrOFliUjRVdmwyOW4wMUEx?=
 =?utf-8?B?RW1HRFNSVGk0bm1VZUkwdG1zN05kcE9pWit6QUcrcVhZeURzK2lXaVkxdUpw?=
 =?utf-8?B?dHlyZFI2N0dOUFpHRTgxRXgwQUhDOWFhc1ZMUHAyZHVZcGxPT2VJdm9YMUdX?=
 =?utf-8?B?bmlGWnJZRnk2M3lCRUpDQkRqUDNrYkxMaXNlVXo4NGxGQXNvQURaMlBlZmZT?=
 =?utf-8?B?MWVZalZjR0hIcU0vQ0FpN09PeWpsdjdHQTJtQT09?=
X-Microsoft-Antispam-Message-Info: gus/4JiwPGAxs1cA3oPBOBWVOg4RdB3AbQARKKfY4Az+ADKdbB2ck0ZYfBC36YKWh6o6Ndi9ivyrErPfxhHIAB4pI/1C5EYpDkQ4Io2y0LZhNB8KdVz0qiQ9uJfS7sHghCsAKxSuoWrd5DTcSPhMiPLZq3IXo4qitGeuTp0wPfjB8FsESVwxizqja7YxZZzt
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;6:4EhkDDE7mNssl6ToJoTf2/Tpc6L/xdE6O4Qbq9ZngurMUdSBZDVciEJAKfxLpYhaKIDK7QuO2MHdEl6zybSM1zcDsD1Y/qxbrCO/TbCUZZ+z+qXBjl8bLiChhxYylVNHhXKp/C1JqLgVD0DuasDcmk+2Xq/UACSXFJc9TQ/HWmxJA3zCjEvjeQfttuSrEKGxwml4cELsgTviLNMCTsHpR6KrE3Cz6EC4K6prDFPEDJn3swLCecwwtjgQ0c1TIuyYaIvU1YNBh2udOc+HSkhXYs0l4AK46r0rhqWlY6fzX2exq/ZmIE4yCuMsJ9WAv+yU4gHwqErIi5x7KWf8/9uiOWA24fjB3fQGIvHDiM9v93KIwx5LlRqZKz1DucKSiiW5icqL57W8WO61/4kqCu43gWjSU0QyVm+yHS5f7V3n7S45TOE0tX6U4IcaGFbWcOFSPPs9BTRYjAN52cEZSjlezw==;5:/nrjTNip9BXaewpt5+57GNYqidCuhSoC5ob8yX4i/gHoaKT1ccw2GovUw5F94QLdK3nvyWFqFuTR54Ac4/1G6lH53M+Lsxlc7BmDBdlu0iPTcPsT2Bok0SlZ/JQLF++K+QAb+ZGMIfJ5A7KZzYty/6n8fOEPTnCbGfAE472TXXg=;24:/0anwM5juqihkIBEhrj5eTs+RFK8VClOZ2m2zfhUVgjKZGi+VAMTd8TLkU0vqkQZTLFy6iXW/hple+96zcJXe7F7x+MKx5jsyFM37FF3XHM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;7:0g3u+RJdB7Ct7IlvN3epq/LvUfiQKdjdYXm1r2OpnHYHuBQB26ATNX3G5QB9vocmYjgsCJxth5aXfvKW48646zb4tLyRap0WHBHiT7QKbhLF5WR4lUp3YYjX/HxCDWfSuSlMPNPDBte+dRurmmduo/8u+SL2jEEVF2lqiQgMBcsjt25AFjIdGizIyCe+dBSEU5l3UydSmJuofyVv6vZ4ZjlcWJJHBEhSeiOzLDXyxgxf+NmN3JYujd5Dxu4oZwom;20:rd7JD3VbQ06eDyt1jWCsK+2JjbOOXjaQM+K/gDKZI/mM+Ct7JEhIv8qa+5xq97lp5cFoDPSx9uiqt+N5tLHQ6kEDLKT9xpsB+kUyi8uXYWSbLyBhjAxruWL4FeGZ9+W9ZVR217fsnFFLTMhsVKhvsfQfh3JRzc8jeSVZXXpXmUA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 16:57:40.5828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dffe31-8882-4e21-e320-08d598bad8d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/2018 03:10 PM, Kirill A. Shutemov wrote:
> f5a40711fa58 ("x86/mm: Set MODULES_END to 0xffffffffff000000") changed
> MODULES_END back to fixed value, but didn't update documentation of
> memory layout for 4-level paging.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: f5a40711fa58 ("x86/mm: Set MODULES_END to 0xffffffffff000000")
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

>  Documentation/x86/x86_64/mm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
> index ea91cb61a602..5432a96d31ff 100644
> --- a/Documentation/x86/x86_64/mm.txt
> +++ b/Documentation/x86/x86_64/mm.txt
> @@ -20,7 +20,7 @@ ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
>  ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
>  ... unused hole ...
>  ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
> -ffffffffa0000000 - [fixmap start]   (~1526 MB) module mapping space (variable)
> +ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
>  [fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
>  ffffffffff600000 - ffffffffff600fff (=4 kB) legacy vsyscall ABI
>  ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
> 
