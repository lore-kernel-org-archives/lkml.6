Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeDTHXY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:23:24 -0400
Received: from mail-bn3nam01on0042.outbound.protection.outlook.com ([104.47.33.42]:36016
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753539AbeDTHXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:23:20 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; sang-engineering.com; dkim=none (message not
 signed) header.d=none;sang-engineering.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 59/61] watchdog: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-renesas-soc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-60-wsa+renesas@sang-engineering.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <c8156dd1-5081-7ab6-6dce-fde367190ae9@xilinx.com>
Date: Fri, 20 Apr 2018 09:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-60-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(9170700003)(31696002)(230700001)(65826007)(64126003)(305945005)(336012)(426003)(106466001)(5660300001)(478600001)(63266004)(50466002)(6246003)(77096007)(229853002)(186003)(4326008)(26005)(8936002)(36386004)(316002)(31686004)(54906003)(58126008)(126002)(110136005)(11346002)(23676004)(2486003)(86362001)(81166006)(8676002)(76176011)(356003)(65806001)(36756003)(446003)(53546011)(65956001)(486006)(44832011)(106002)(47776003)(2616005)(2906002)(476003)(9786002)(142923001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR02MB1227;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;MX:1;A:1;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:I9iRgMla5OpMvayeyB7xgAJMx2Wu3sG7By0a4gVYrbpSqTN0uVJ3SFH0FAZ//SFUF5DzWRu/rBOCgIGRNvHgt2Kz3y6mLqhRRHooO80KcuOvwuhctNsrKsLY1ZFcVnsd
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY1PR02MB1227;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1227;3:vanQIm2xjYcKIYwbOWB9wG1bg62Bwk6dUSr5wSVseNADk80Rgera52aXOAdTg7Ref19vOL9gZaPsknfKli1iUBDEsH+Xe4vEH4s1oA9i/aUI3xM+JqM19mqKCiA4zGqC4MZvf4mCBKJJ8gNoXrI3qJaWjxCzaIY7bwEUWyK4aWfAvHZzf1tjhLt/p7azWvdRsmnmTNbHnoJFNKObed27K++T9jqndO1Zm0wE5XShow8r+yULwiZuwAicJjqDJ2geYFcTAy5Vfevv6x8wsv74ul5FDZatk7/sNWt9spjuhUvbV7ab/hL9tHvHIxTQlZg/UAiv94GhWoCnbwZ1iw8lsp05PRTneM+t2pqKQsy39mU=;25:dYAUp8BSZQlYY875WAuSVmbIhsBJz53Y3a9t0ieOR8Hsrz057SdPTc2/GsC2CUE3Lx/Cb8Vrqt2D+/VjVWyNADd1rSNhtDrLTYa2zXV5qofTvQeW6CsOFNZslKguSMpLbiQ5aGJkrkLokklRf7Cv8tAZlmw72BsodCf5VWgWiULtkdiaHgjQ/Qe+9jDfWS8qcfhhSEl1+l4radAOQUz/xQcMaJi07lY3aN1APdb81AZ9CXvrDjZBPkKZPJbANDusSxA8oESebneLFrhGBwlWn0Tt7AgrdJK1IFP52S/tbiKy5tYfEqHVGQZcRaazKXJG5gBuV87PtzJVvFkavcr46A==
X-MS-TrafficTypeDiagnostic: BY1PR02MB1227:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1227;31:NSGxiT2I2iSelcLbYMjKMswPJhBiBQgwyVOLRHlz3zfHoDeSkuHcTg3qguNsGSnoaAI64ZBmzhDDEpqs5IAJagDkEbW2wpS2CM76t0pQledkHgeNWNo3zpsL6U+M2m7vkVd64AFKf94Gh+8ECRArmuTfkFHDSBiKjR72k1UTbbuM2UlLGLs5epLFFxuVywAehUauQ+fyxrNqTIy7eDOQPfha118i9NJTP3OoJOMbv2g=;20:DXjQ4SOaeJTFdIRmNE+SpVQ7XGdfoGWTwdo99yu3oz8JGHltLuQ/UY0L1XOA0vQfsuFyf5DaINEJwGBzb5iYYHBR165eS1SzYmmciUhjEOk6Jd8XFcAC+tbjvJu+TVFhpv3Kxa6f0mz/36nnQ25UCsS6N+Mt46ZccYCDUnwPPu9VeIqHAEfY2QdVsc5jRKfIjrdlgMJ/F/C1tdV228bCAjY3vZ+lo2NUJuLTvS9PhvcyVsBX1r1a4J5TkVe0iOQwh4exwOFxkyVUzt4wWKcHmX8E5zZr4M+2E6hDf2HQJCLvUWgiS86/RcPuPBg0kiolc7Kt8nJ6BIrGzFlE0yEUTpwP80h7N3Chp8RTBI10p14x1wTdf4JJJa2vlGhlcPOToo2w/lMOHjG9blFJK5guCU6mglZFxjvOmj5rCivyoWiYj+LEQMF5C9VUHOYqIX7xYz8fKvJMAGnChfuj4wpDI44Us+NIoPX0jw7/sVKti1M69+c5UZbNkT04+tOUXSin
X-Microsoft-Antispam-PRVS: <BY1PR02MB12273885E96D0A4DDD1B103DE2B40@BY1PR02MB1227.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231232)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BY1PR02MB1227;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1227;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1227;4:AJSikXvMnG+2yiU7b3Xthn/tRVX/uQa8P1E9kq/Io7Y70hbcceRYo9lnG//M15Q4SctdwfAYgaIog5W/5vfm6zAPpAiuoovlNGaEVXiWKtn22iK1QLz77XSC6eitmU9HQZ17uaFF/iw5BWS6gF0qgV4uNpxg1lscXimv09cmhb+NZQlPvAb9DtWC3GxUhWmXMzHhlxMLudGyTgsdiWSO+3V7sCqq7dQoVB1UknIG0Wh9QF4Xpa+z2wB3fAXuOMlQXSa7ML4WDCeyt1TTMVaNbkllS88rHGdnHaMaIf3qZ31JXILPBoZ1rcAin7iJPAM+
X-Forefront-PRVS: 0648FCFFA8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjAyTUIxMjI3OzIzOkd4cUJCN21GZWxBWVNEVmx6d3BWdmE4d1Zv?=
 =?utf-8?B?MkNMSVRyeXpJT2lJeFk4WDRyZjhuTkNjTWVQTVVIK2RVVnRPUDVDK1UwTkVN?=
 =?utf-8?B?d0Q3L2orOXNpMnI3SjByVHh2MXFIbmo1U2k2UXh4L2tpc3JyblhhTTUxY0dL?=
 =?utf-8?B?NSsyZC8wcE1jcFJ0ckg1KzJScTY4Y2xDMVFRQnZlRjhrV09nUHdPT3NGSFJV?=
 =?utf-8?B?WGx0Tlh6QWU5enVsMyt1MU5NZ3hLaWxwYVd1U0diV2l3SlNsVUZOeWZPc3pI?=
 =?utf-8?B?elZvcGk1MEZBRkJwbE1JQ3ZsT0dSZm5scWJhR0FVS0R4aHlDNmQxTHJFRWM1?=
 =?utf-8?B?U1VtaXo0bUhyU2FvUU9rZFhvVzBEeUlvbEIvNUsrNHZMNmtWOFFZbVN4WFJw?=
 =?utf-8?B?MmNNM3Y3VVp0MUFOaVJpeFJqR0I4ekcyejk5ZzJNZTJyYi9zTUF0Tmt3MFlv?=
 =?utf-8?B?Zk4xNEhSbWJ0SDlZN0tQby9xTHdzODdwVzdqbTVpN1RrZ1BleEVmaGc2RElz?=
 =?utf-8?B?dXpoVHg3dld0allnVXI2OVlJQ0dSdkkrWWZzZlc2WDhjSml4TDl5NXl6SjNX?=
 =?utf-8?B?NnZiRHZzYnF0a05oTUtlWFhYWXNCaEZ4d0FJYXlDMC9OQktuZTM0OHpDcHhB?=
 =?utf-8?B?aHVuTG1VNm9mS09SeGNiZjZyM04zL3ZmeFkrVVU4TUR0TUY5MjMrMVZ5T0o5?=
 =?utf-8?B?Yk5abjloMFRDbjRqQ1pEZVc2cTVXV1NxUVNpVWZFa0dlbGdzN2FjYkhQZ0Rs?=
 =?utf-8?B?b3FrYW1ITzdrbmZ1SmhucHBUR0hyNGZiRnFiNUcyRGRyQ3ltOC83MEM5WmdB?=
 =?utf-8?B?R05hZVVIdS9lWEViTFNjUUY5WjZhTTUwc3pROVVnQnc4Ri9DL1Z0Qmdrcm56?=
 =?utf-8?B?QWh3WVl6WVltbFE3UzlCaERmNHBNYXFveGFlMEZ2MTZkWFdONTFHVWswYXUv?=
 =?utf-8?B?NjlWdjNWWUN5RmpsOGVyL3JLcEEvd1Q2dDNiNjh5aSsxZTR2clkxNm4zSmhu?=
 =?utf-8?B?TUY2SVRyNHlwSmVSWjF0RHNpQksySnIwSmFsRGFCT29sN2JsMVp0MDE3YlFx?=
 =?utf-8?B?SWdLd3FXZ2hTaFY1OWlqVXhJQk9yTWd6cWZENWMzbVJOWWQzVlBHRU1xTVg4?=
 =?utf-8?B?dHd5c1dpNytTR1RuZlVxRm1yZlVJU2lZKzhlblpITmFXZG43bDd6ejBMN2V2?=
 =?utf-8?B?Y1VJcHNLanprdi9VN2xUOE0xY1hNT3MzWEVudnhwNVo1VmFUa21lMmp3T3Jy?=
 =?utf-8?B?d2tRdEMwb2hvL091WGhtRDE4ZU5aQ0JVWTJjc0tRbUZQOGhValoxSi91TFlp?=
 =?utf-8?B?cTE2eE1tMTNYRm9BeC9NcmN1QnJIS3hibEN0L3FWemhSUFpEaGhzOFV6bWZU?=
 =?utf-8?B?ek5DejhsSWp2c2FVOEs1RTVoKzVSM0hJSG9COXRqY0tGdnVWakFtRTkxTmJG?=
 =?utf-8?B?akpBSVlhZXo2YlNUT1owTTNvNlJtdFUwR2xvR0pRYzQyUlA3WjdobzFjOW81?=
 =?utf-8?B?UU1Za1IzbUJoTUt4bW9Va29YV0ZqQWpva1N0Vk1aZ0QvYTh5RjV5UzdxNi9C?=
 =?utf-8?B?T1pUenB2NzQ2TzdnczNGak9COGcwQ0FLRVhETG8zU04yQmMzMTFFdnVsRzZp?=
 =?utf-8?B?VDRzZ2VQeGZFTWdJT3VnRStyR2dLamd4d0s2MHo0dGI2azgvZmRmNnV1RFpH?=
 =?utf-8?B?NXYvM25qZEYyQStYaDFaVEUxYVlwcXZHMm1wRjZwMmptUUd4bzVOcXRUc1Q0?=
 =?utf-8?Q?shPXsCakJzNq3KJAD4LNqNYVY0MIj0uSW56ZY=3D?=
X-Microsoft-Antispam-Message-Info: sq+minXGx3CQGhJGtjVcYwbYR4hY0s8KeoZ9KAy+ECrobqBpB3bXIhDsOsb0LshmDP3EmUBjW2gXc+nmLqynUXzF/a7fpjHCGlhALCWJuPa81+owCDQxGeJy3JzUWUHxRqNlZFNx2LpmAuZE4xjp1knTQX9CxuWn/vy+VxrYZgDm7SQ32uVE5kVtWyEQtc1g
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1227;6:8lYTdYEcdZsAoZmuKdD2zi2xsiM1U3+DdZp3EVUPVHM8qcRAfZNe5VuHbavoJY+pY9Qy4yeouZtZdJzl18g8Ty62+7xXJe/0vAs9Vx5nmXRfm6I2WuYUQF58/wxL/JSmRmnSRBaYpyGUO0dmFP0qxfxAWvkxWFXtF76qetPjfc5+Bl/sZ8ly02l/ckSACj6OAnXnsAkMUSs+pcV++LPPDusYpqdq8YbS4LsZ5PORbwwp/HSpGBO3uc9xv8oHiFGbCsx7UvO6pQj0yf9p+XbXfizQQ26PfEe1SPD7THotxVJEXu5cGXtQuPJwm6E14KvJCM2KTxrrkeSaJ69V0HWSMgjiwqKEUWPz/P2g4GZ/3V+q4Cxl9wDL8z6tc3BcD2E+6GXFFKjP+2Sv5372oxuuW7IVLxphZwAzsmr4rdwvSFFVFyYEnFbefCXchvUM7lrqcJZ2INqVzKHv5U1ZuedPzg==;5:6zLbTeCNJpw5ph0A7j7SACX/S2A1a1prs2VkbrF4B1/MfKi+kTK7d05mm35UGUDz5xjO9gJbGRvdyMsaAwknaHW8OfS655mV3f4ks3MxwcVFCWWsqfm8NecKS7o87VFNF055kZEZE2VzXcmCc8xfEdfoE9cyT5dURAHnuS0lsms=;24:NPzWcATqM417TePQFEOImgTIgcwjuefPKJjpRUmYkcZl7n1nNTrv7jRe6cH8O8DdSdUAifdb12lgIbbekHzHF4jPxKMo3PBLzW5FH8mMJVI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1227;7:TXNWy5VQKH25hlQj6DDah0wsMRy8yw3Arst9eZdHdEfowgE/izevM1+1FRkGe2aIP5qXIdkx8bvUR327xMU48nKwoFzKDHMyOENR2eMsE/R4LgyzXnZPDf+P7H2pQw02NWJ8KrzZ8Hjot4+Bx7dGmTa6gw6MPLW/U5d4GVRy7KmpkQ0VjzxXqFg3+z6JNSRs+Npg57mbUpEOnmxWUavZOcfGIOG8+epI5059s3L7yvBxgwdIGXtAwf4JYMs0If08
X-MS-Office365-Filtering-Correlation-Id: d014f826-e06f-4425-41c1-08d5a68f9440
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 07:23:13.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d014f826-e06f-4425-41c1-08d5a68f9440
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.4.2018 16:06, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/watchdog/cadence_wdt.c   | 6 ++----
>  drivers/watchdog/of_xilinx_wdt.c | 6 ++----

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
