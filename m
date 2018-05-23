Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeEWK1V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:27:21 -0400
Received: from mail-co1nam03on0050.outbound.protection.outlook.com ([104.47.40.50]:19376
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932467AbeEWK1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:27:13 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH] gpio: zynq: Setup chip->base based on alias ID
To: Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
 <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
 <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com>
 <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
 <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
 <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
 <57e4bbdd-1e30-0352-f758-998b64a6b77f@xilinx.com>
 <8b344d48-592d-8be8-bea0-e29b3e8469a1@xilinx.com>
 <CACRpkdb6pN=XYgWN7rPBGDwgpMjNLhgxVk_=QRTrHb=DZuU-xQ@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <fa24761b-1025-53bc-7706-9c67c0112cdf@xilinx.com>
Date: Wed, 23 May 2018 12:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb6pN=XYgWN7rPBGDwgpMjNLhgxVk_=QRTrHb=DZuU-xQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(39380400002)(346002)(2980300002)(438002)(189003)(199004)(36756003)(230700001)(6246003)(39060400002)(63266004)(31686004)(229853002)(93886005)(36386004)(316002)(4326008)(58126008)(106002)(106466001)(81156014)(2906002)(126002)(2486003)(23676004)(336012)(54906003)(110136005)(76176011)(6666003)(44832011)(26005)(81166006)(8676002)(356003)(65826007)(53546011)(47776003)(5660300001)(77096007)(9786002)(2616005)(8936002)(305945005)(65806001)(86362001)(31696002)(65956001)(446003)(186003)(558084003)(486006)(11346002)(478600001)(476003)(64126003)(50466002)(426003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4481;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT036;1:LKDRrTR3WbEXOy2EihgBGRcM0c5j4tHQdOJopAmoLJwfwCmiIj2Ll6fhE3c8KTSxQGNnOn5JeB+wLeGWQDjhf0e/cSZ6OvBaZnlQPyG7YAFaZ9+4k/y/Y8U5z/3onV3R
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BL0PR02MB4481;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4481;3:P4mOgoN0ly6byWtpJRz6f+3rBqy2nNKhL3++cFAccP1YlUrXvIldaYUAJPhb+4ZwrgesXxShpLqj6tdH/eoH8/6EWIk1EI+lHPKFPzewQ2M9tB0n0RmsJRLNpBHk7htvn9607FL2RLfB+r08TDRfIxfhzJ9kRUAOUZnypQ4U4SjO7eDAUzF4tmNnS53zjzP4lSLdCZ811sJJam1d6CzeHQKb/NJsxiH/tEcXYPuTY+Dq6x2cmHryBOYMjfl95oX5EH2GSeShqw0tTVpIByvFEzLYP6Ms3k+HcSWFFFJDW/cVI5/eH7ChQewARESNMYvPAVsXiiEPyRP6Yqyc7S2beQXKvklhmSQZSTRXTQbyeBc=;25:ZxSMZcmyAdI1CFJVfjcaeOVFDpTnYHD5pgMuWQTbZpvNfA0AursoaWY/bx/wSRjfTE11k9778wfIzL48Wvok02mp/Eg0BePfg1YVYR3DOnBQuSZDdBtMK9DbB3IpLSgznYbtmOf9M25JHsAZBlYaofx6xnHHCAzev2NxfH8XqE387QBMNLWHtfosV3ZHN1pfhXEKE26t9QxvQYnACubu1i67ITyYf///0oO/cqzQIPV4eZyS6iGXxxBNIQSLzq+lvlnldzSJl0cU+pS6XP99CRz6FC0h6rM7xocPdM9lc6+ZDXZRqHAjWrSe5zmUEmeMz0xuZGUfd3+5QfVutp27fw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4481:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4481;31:7yMSXDwJJBZD7Yr3C0N6QKCYq6p39DdWKhUV2U91e9rK+xrlBiI0P6+xTUjtbu42No2RLFST/AC2gUbkCVMtEUWn6fCuKf/2CmM2rFNJDDAwnT8+PLZjnMfbYcRArSBkaDyC9m4j8a2bhv/zUEG0OxxmM9tZos2AZvt0asL/VA9Fg4dQhALP5XvKSA1x9rAe1N8nc5ivYUeOm6V6QZZPnAoZxcPrA2LI3l9O7nV4q6Y=;20:9j4LrxQuFb5ouiBVSKjMEq9G+HPCa/VEQs9fLYwi7bAY6rBUCpM0l5276eHDlxw5Pa5ewr8pkMLBgkftewnTy4oBZsKE+8Mp7pe1wSAlcbgrRKuszpk3A/tfbTB1yfVzx47cZP/ZvVuANKpbknPIVHn87Jl72Xw/T6maWmkhvRpaY8+fRw6SoH05norZvpQWBxOSc0PMDOtCkwPBZ/QuSp5QaEkTaPMdIsgaSKKs6U2gPPGsBR7+GObdtWjDevFndnpq/DaKSK9MV7KOsf1hRDTqh86NrRvVcvLRwtEYC6kchFE1BgsyyPxaGn1kRnj+knSMJSe0zr5zV30/4qPx9d7BjhPVtkfUIQIrwOiV1+nyqW42ROXBWwXv0KIcXwSU9MrEISLVIP9AFHJ3pjC/DV50jr944IMCmXEJhh+VpQxiUeFtCsembXJM5U/X2LsY+6ZWmos9ptluB6Z0nVsPq1Br8uAy1+qAzvAukW24S36lQuE3Hu5MN1hmHULJ4H5a
X-Microsoft-Antispam-PRVS: <BL0PR02MB44813129F1F9AC577BE1D65FE26B0@BL0PR02MB4481.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4481;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4481;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4481;4:jJMegwASfL8crz9IwYub4gdUgksqQE4MVy620YNef/BgItkzQdTGExqxa1QBSd38m01/rs6qPuruVQoK1w8wpW4w4geudMYT4XDkAHH7jDUPGtx4cuUuaG6/ogWdb1jZVAT1k7ySFq9m7u+AUA885X9jxKqyzHii80KiqVHGfZzOB35ePPa3BisJit4nMVb/P+B26bk2mLcl1vpsuCaWgJoxe75yLw7WpvImgqTT7IwolJ2gEJLk7qi9vNQDleSht+Hz8NgJmy6ybP51YCxE2frkSKD1ZYaIR25NMS62Hc47ruM76NJhkoWeP6cw5N1W
X-Forefront-PRVS: 06818431B9
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0NDgxOzIzOnh3YW5nR092cCszYUNxRFFVenl0cHV4TTVL?=
 =?utf-8?B?Mkl3ZW93R0NWd2hRdi8wZTRmcTMwUVhFcHN0YXVQRklWN3dEaVFXczdVSGdW?=
 =?utf-8?B?bHo5cHlLMnFZZDg1NVJZSnEvTUMycFNRdmtlR3hTSkl2WkUwaTBBQlRKMVpn?=
 =?utf-8?B?ekl1LzRNV09wWjJYbWVObGVBalduVkhrSTBscWVRNThhUkRYclBuK3h2TG5B?=
 =?utf-8?B?NkFVV2FnY1AzMUJuRzBoNER2Y01jVTBaazREZ2tzMmJkV3hVWUtONnI4OGFS?=
 =?utf-8?B?WVZSYXo3dVhCZDVTNTBReXJLTTBITDJQOWhONldWYmJ3dUR3aGxWbTBsa3kx?=
 =?utf-8?B?NUs3NW5iYzJnY1h4VUdROXNncjdWODBaNjV6VWdod2RoK1pGZS9CTWJDZjE2?=
 =?utf-8?B?cnNmQnh0NFgxL0FURGpsRG5ZYmwyTnZRYjlJcm4yUDBZSzd0Q3dPUHNYajRl?=
 =?utf-8?B?RVROdTN2U3UwQ1ZIakowOHZ2azhHUHA4TVVEUGY4VWJENEpmRHNtRnJ3RXRz?=
 =?utf-8?B?U3pBWVFBenBzdHZ6ZUJ2bld4NjZsZnhERSsvMk9DR2JvKzNYTGY3V3NUKzR2?=
 =?utf-8?B?QWc5dSs5VzNuTGhrbzJZSVVSYkUwSzQ4Zk0rKzBEOWh1QUdnZ3RRRnYzeXB0?=
 =?utf-8?B?WC9reWZGNklxbDVGbTRBam53dDBScFdzcjB1UzBNZVl2eWFYUmRiTmphREc3?=
 =?utf-8?B?bkhoKzNNMGoyaEhVOU1yVmJlZFAxQVBrMHlLc3lxVm9xNHUybFJ3dUc2dm8v?=
 =?utf-8?B?WkcrK1NRc2drSlFDbG4rNEhLNklzMG9yblhKTDE5SjF3RjdHOEpoR2lwc09o?=
 =?utf-8?B?V00za2ZHeVgyOXBjRTA5M0thQlNYVmtKeWx5K2NFa3c0cXlzWUx5RDNmbkZr?=
 =?utf-8?B?WVlueFIxdDhCdXVRTUQ3MEJvbkp6WTlJVWd2QTVCbCtEVmhIcDNxMlAwTFRD?=
 =?utf-8?B?alFCL1dDR2RGSW1GWGtaT041Y3RTTjVhRCtuUjMzNk4xSkw2dFdBT0ROT21x?=
 =?utf-8?B?VWQ1MXVUc0V6S1hEK2lrcGxsVDYycHptVDY4akVrQmZaYTZlTExoZFpzQ28z?=
 =?utf-8?B?aUJXUlFhSzlidnNTUTN4NVVGakNyaUVlZSs0aHlydHJBOFJZYlQ0UW9Sb00x?=
 =?utf-8?B?a1lYbEpzSU5QQXoxc2lldjdkcnM2Qkw1ZnlJdjNjNVRac2VtWll0SWNncHM0?=
 =?utf-8?B?V3QyN09TS080eW8xZXg3dklwRHdsSmZ3bWFWSWRETmxaQmZ0VE8yL2U3TEtX?=
 =?utf-8?B?dmpCR1JJbXR0N0s5aCs2bjJaSjIrSVR2eitVQnZicG96YmtoaWdRMlZCSVgy?=
 =?utf-8?B?RXVVQmdIbzJWUVVCR012cjhwTWZ6UjkwMFdDOUQ4amZ3SDhxTlZjMzFjMWNT?=
 =?utf-8?B?L05UN1UzRW5DYloyLzlwa3dkQ1FkUUlybUdqc1V3bHRtYzFHenJGdzNFNFhT?=
 =?utf-8?B?WXluc1hTbms0d3V4MlFsT1NPTlJvcEhlSjVrRG5JREptVllocDR0NGJMZGtu?=
 =?utf-8?B?Z1JUNGRrSTFKWFBtMDJHbGxlODIzbDFTSVg2MFZ5RVF0a1pCN0szbGxVUmh4?=
 =?utf-8?B?eVkxQ25ESnF6R2hZUkx6VG1IOWFRSXBzYnA0ajlLWTBZUGlOR2diQjNkek0x?=
 =?utf-8?B?K3VSMm5hdWl6Rnhhclp1WEhHQXRHSEpCWDZlcGlqMG0yd3d0TUJxOXJTR2kv?=
 =?utf-8?B?S2loSkV4b3FhNC9DK1JuTFRHY0FrNWFMaTUzOCtEbmxCL0Q5ZnB3ZTN1MDJB?=
 =?utf-8?B?TjcxQzNrNVYxWkZTU1VHK21sTGY2R1Jxb1BQSTJwUkM3RGNnR2FGQTNQMndH?=
 =?utf-8?B?aUJLUUpaM0JXZ1I0M2JHaFNNaWE3QmsxcVM4b00zMW15bitldS9ZL0VOU0tK?=
 =?utf-8?B?WFRaY21IZlFPTGo5SGFGWkdTTkZ4aWp4Znc5b05FbGVCWmNaRmxFVU9ONndk?=
 =?utf-8?B?UG54MVpBVmV3PT0=?=
X-Microsoft-Antispam-Message-Info: wy58CNMM7rIqgs8bEudGjth5Cd/Ig5bgvYCynyU2c0+P34fcf0LKEEuGwW0I+HoSiROkdyvKYB3iH/c8btE99l/GTIgsCkSGD3gL9MAMw4dE81sJkVkHjr469IKvUvf227o4gkYNQkbCcdFoyuEGbt7VYPj2awQaGKLCdF05e03JRuh+7xrqtWbRhGh0xYXG
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4481;6:Wv8o/qbF1yzeeSTghz2OJRvWYuUAzJO/O2CJ2F5zu2cZAqViYVBiFzWWKyc6WwKhnUq0vSgi+cujZRicJj4SNdBb2mAikBTibbC825ThUO1AA35hq57QS5nm6aHI7/HjReBrO8bCWZVhoSErcSU9SCoDfMuITzmEunxnGovuq/MscUNDpUk933tn/lKY2CoA3/Sa8Hs/XKif9lCow+TCsi/QnJNNudYrcqt+m3W9HmZkZujYnfSdAr2i+fBz6CGKV7G0mJDcNDUdzebeSITzS22DQHFdks/757q41vxHXe3wFpdDWBENNpz3jU60uQKmePDswS48zlPbcJgLsxRFzrnDBCNntfS284/DyiFUAwITD52Ff/MXrduDW3GQ80PjdG2mKryQaV5CUyLdUkqTtNV7I/9HH8IwJIJsX4p2+L2QLbqDVJPyAoZ2zfZZdLiSYQ+gVi5FShtwJ5t7vms0uw==;5:Y6WpF+JwpkLxzN5//qCooeCFlAB84XRTNsLKE4tktvuae+QfuoRLgUI+7XpxMzYsTwfCe733r97Pmdre/2Zj4s2aoNCyr5zb0VaNNAqrrT4c/vMG5poioxz/IfeZeU/hnBUwjSpLf3a0POjBGKVuZpUn2g/lVqjEAwgm4ZLdUdQ=;24:ry+cyvrBpVDh72QAWpI42wkmOaQde8Nuas2tR14sMYcLFa9HmfRkU6ViPNBnKctX185aE5h8KXus+7YfMpruGRP4oVWlkDZz0XkmGoWg6fE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4481;7:9Cys+xRipblOPEVBP6wZdg4NZsABH2J6hrFx6+8VW+qsvZ717aKzZHu2OeQ4hKzOrDFwBjkPIsNiVha128/O/mmMyQ0GahXKrWGNJKYcdmWik+U3GbntFx71k5kUQCearcuf9LzqLG0lajDDMy+MCAmQrz/lfwR93KJy38LLLf+kF/0XITLVHnRimdto4dEgsbS8nZlYeVH6WTgtcPQNywUyAv8qyptBMXLx/kzrRc/AaruqL1dS/ZaBzJ7fqMZb
X-MS-Office365-Filtering-Correlation-Id: 8ea04384-4c86-47a7-9b11-08d5c097bd7f
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 10:27:09.1831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea04384-4c86-47a7-9b11-08d5c097bd7f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4481
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.5.2018 11:44, Linus Walleij wrote:
> On Tue, May 15, 2018 at 3:26 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> Have you done any decision about this patch?
> 
> Yeah I applied the patch. It's a bit of "choose the lesser evil" approach
> but what can I do...

Thanks,
Michal
