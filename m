Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756279AbeDZNfu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:35:50 -0400
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:4736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754847AbeDZNfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:35:45 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
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
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
Date: Thu, 26 Apr 2018 15:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(376002)(346002)(2980300002)(438002)(189003)(199004)(8936002)(356003)(31696002)(36386004)(81156014)(54906003)(6246003)(31686004)(86362001)(5660300001)(426003)(106466001)(106002)(478600001)(9786002)(2616005)(65826007)(64126003)(486006)(77096007)(53546011)(26005)(65956001)(65806001)(47776003)(446003)(186003)(76176011)(39060400002)(23676004)(316002)(50466002)(11346002)(305945005)(44832011)(81166006)(58126008)(63266004)(336012)(229853002)(2906002)(6666003)(2486003)(126002)(476003)(110136005)(8676002)(36756003)(230700001)(4326008)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1676;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT013;1:JV2fHX3dQQQovK/04jKlcXz+Y62ikI+wAlowNfUK0QA0uRR0P2EOwQixNeQpkXQcvobzJqhpmrKCoEd23AXYRMnXhZeRq/DxG+TjlOwWt/dNr5BKdKHTpXJIKGaLADKc
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR02MB1676;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;3:1IiCgtmoHWYtSnY13uRB7UF5z/P0HmnAcZ6morkDu8oeCtCoP6OpYOQaVozRCjs/LAN9RcHYRSMqkfu8YiUuNyIDVZU/7rv7q6tjPxW38yZ/onDIGb/GpNef6z34holoD5iBZLQ4Smz1u08Vra/SSZkP+liyOcTxqUSc6NZqyJnHi/gOggeVTAC+ljuDl5zcXKETHfGk0eBUGuLjDzP1daMNM0rumLogxEjBmuqzY8OrFJqkFnoeliA8shnczRbeFVB2UiCbOUBR5M970R+0EXHpBYk5ucGwqa0Q97l8MxrfLkPZ+mqWj1ODKd7/qj7gsA1B2xr2OSsDmFuTSo0aL4ZBahgZPnKiccjFAhbwlHo=;25:ITyV8WxviDZlkXfdHeiAjHxAqEQT7ok/21867F6Q3fuEkxFxKj1swORXNlROPSJMxPhTCtfb+TEWESTZiHT3fBqBiYFxvyMlKRBoJu6mmYrV248W8mfcqxWu9rPonjJJO0sIlkPRVkwpxNWBTamiqKUBwkVDcuHMinwQVKZF4YDgpgGf0u8tpvniq/de4jWa73+v6PanFaWOYLSY7Kpz7xOwoK9AOThs5pMBzRM3a0yLarhLUhoi4QOxZbFbW3qQ3qioO4BzeltSHQ2RVWDPyWeDceleyo1mcSIGgTZAdg+WWts7gBYvXy2W5qLbGxJpgsHc4xmnAKbdkxfA0rAq/Q==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1676:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;31:84os9KLnIPSWL3Ms1gaTRXPILTOExf14aii6542oSjSeSIxRwpRzyvxSJdfkQ5EmCVxT55I6Rkpws1YNOgqwAAggaSc3JoR4fFxYYS9j7UjYru66EVljdQ5wMSDYVODSiQTuCLp0Li4A1uQdKU8Ez2D94x++q9k9pRezNk87705O0yW86MmObUMc+UvVmza7ifLfKW0v+q4UtwexLCtBbX+8SqMig8PDznMV37VtjEU=;20:5mFHoL62R606DAfT2TqpMImMomakEVcbiP+fB0dD6aXhOxNM5nlg86ESk6kMFLf3bTjzp5XefvKLAqnHoa1GFolmXav1+jIeYHjzy74B0l9td2NXDGy842DUFN/+qUC4NugDjEzZ3H9hNSlfULxkGQ/lQQvtJWbVc0z9zxs2SKqXbOInOl+ab+bSY6Tn1Iuj6coxwjXaM9qfeO7gNGsjN69A5R/0PwWUrmMqnTZBsm35CiOUbc29t2qIyrQRFLOoukmpd7FSElGj8Bli31671N+95rrWlmMymmUq2XCBWSv0NVjPavvgc0s+pvI94OslZNN+Ke4rgzpjPuhH5AWS9ee1crzrAFij9U9KcQtrT13M9b4z2Fd9HLUhABpAV1f8LxFbGM7RRwy3AMQkJUZqzuhwtE38NQfgZeyBtpf/JC45Qf0p/ayWqkkbrGXuhwGPCFhMOQw1hqh7E2ZWA5rJuTokb22MctqTP10XLVbmfYtiJj/IRG6+y7pG218Jiid+
X-Microsoft-Antispam-PRVS: <CY1PR02MB16766363796FD2A4ECF58741E28E0@CY1PR02MB1676.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR02MB1676;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1676;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;4:3k7j16Py5MGbhquNLmzU7iOrdwwET0cnI5h2pVC9sFBGHLNn+DjqRvXvK/J1zNAIcH74i1zCisQ+2iFRIu11ZYLuDSkptS8XXyTFyQq9PILWDL0jsQ8g/GxUfQ3YLslslFGwFiYBuV20LnkAwU1cc1exzI0jsBaDb0btXJjtokt/VwEaAElRK8+vTcI8TEqEmG03mcLf/phwFf7eQ8j/d5p7gyIyfC/KyrtXRGaWzVdjguVo7l7MFjfI1Gm7f6iA5kkhlSw2QQ2DYbS1vEBNt95YfrBXBdwQ5EIrNpclxai6p08Y/IraMOALYxhDPpTSV1Q31iugk94O0IyaVk92nTmcsc/YEg3dBToW6viLzbc=
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyTUIxNjc2OzIzOnlpZXBUQWFYM2tOaTNrRWYrOHJXVWk2Z2lp?=
 =?utf-8?B?QTl0eFdLcCtoSkkySFdCSEltTWpNMERvUDF3YlJ1VFpEM1IrNERtamNuZlBH?=
 =?utf-8?B?MXZJUHFmbDZFTFFhaUxqcGY1SXpNUWFDVXhSWkJLTDFiVVMxQ29vZWFiOWM0?=
 =?utf-8?B?ZVlIbHRNR3h0U1VRZ2xyT05lK2M1U3cwZzdpcnYzd0x3cEVtYWU0ZlpGV0lH?=
 =?utf-8?B?NGoxdWx3YktOZ0ZIRDV0WWJaN1haWkt3VUxrVldSdUdPV09RMFc1VmdwaWlj?=
 =?utf-8?B?eUJtdnNYTVF4L0NaMXUyUVlzTVJjVThJWTM0UTZOckErQ1VHMVZGWDdUd3ds?=
 =?utf-8?B?cW5Mc3lwNkJHdlVTYXhaa20rSDFQUUZHWHc4Y2xPc3d6OFZWeC9sV2YzelRJ?=
 =?utf-8?B?SlhZTHE2ZXd0ZS9tQW1acmdWbC95YXZsd0oxZEs2VzRLenRSQnQ4cnZNNWJz?=
 =?utf-8?B?WHFsRElJaFFucE1QcmkwbWszTDFReG0zWjdZdVo0eEtDTFgvYzRPSGRZMVFV?=
 =?utf-8?B?M05JeU1NZ2NJMzI3d1RtWGg0My9zZVVNRUpob2FnYWg4cnhhclgwNnJ1YmRz?=
 =?utf-8?B?dUQ4ZEJYa2IvY0JZdUNXc0JULytLVVZPd1dZcDdsakVqTm1vSXdZMnNaYmhm?=
 =?utf-8?B?OFk5TEZJUlhrTnNKa25VV3lHTXZwbTZ5RktCVEQ5UzdQMkVONHg5RDRjZzNR?=
 =?utf-8?B?MXFIWTVFeDBEczllN2J4VW9uRlVnbG1wTXNSRjY1eXNSeTJIb0Z5ZnNJUkx4?=
 =?utf-8?B?aVB4ZStPZHdPTmZMVU40cHh2VzJBcG5udG0rci94d3kwRlVaL3lVZ3lDaHlr?=
 =?utf-8?B?a2x2UmpFYWwyeHNEeW1TWndCM3dlaTlld1pKcmo5QXU2ZTA3N3NQeE5MVnB5?=
 =?utf-8?B?TFQwaFNYUGZiajRVckFYSUpFd3VjbGJyMU5WUTZDRjAzUnNTejdRcXdMYTN0?=
 =?utf-8?B?cUhMNzJDcEJ5RXo5UFZSVjdPQjFSaW5WMkh3Z1MzV1k4djR2SmJMV2trUFd4?=
 =?utf-8?B?NXR3bnBIUzZRMWpsZjl4NU0rd0N1VURzTUFmRm9jS1RDR2V0NDBQNEZlenRn?=
 =?utf-8?B?bUVtTnlYaEdnT05GTXdUeEZMVkxoOVJsYmhnVjlnNDlzY3V2NElNUHZHQWRM?=
 =?utf-8?B?M24xS2ZlS2xIZm5adzlDSmpVd2lEc1NGYXlORm95Wjc2Q0o1M1NYa25ybmli?=
 =?utf-8?B?V0crWElZeHo5Qk5IMkZGbEh3SVF2V1pWZVd0eDNpT2lXTHhmY2I2ZnBQbEVy?=
 =?utf-8?B?cStsK0U1Kzc0L0duOS9wMHlwMnlLYm54L3NOeTlRQko2UGJGSjhMZ2w3NzhT?=
 =?utf-8?B?dFV6UmJrdXdQZVlHZHRPYlZ4UnZJQ3lZSE5CYVlQZUlxWEJyQXNITjN5a3d1?=
 =?utf-8?B?MlYvenJ1b0VCV3lYYnZyYmtpU2VnT3JFNEVMVGRBT0N2Ym9yVVArWFo4Ri9I?=
 =?utf-8?B?Q0hLbCtybmZRTUhZdytCY1hkSkpDaWtHT2xZSVM4MkZTWnREc0ttQkZEK0Rq?=
 =?utf-8?B?REUrUVE5K1Y2OU9LZVgrSERoVlpyVEVJajBWc0kwV3BXdDJUUi9NREY0WXNN?=
 =?utf-8?B?RnZUcXpHdUcxVkplTEd6YTdGaXVldjk3dU9wdlowNDhWcEJNM05uNGdZdHd2?=
 =?utf-8?B?aFdWMEsxQUE0cHFwZkU2RTN1bmJPNHo0aENKdFNoRHNPM1ZZSEgvZlozT0ta?=
 =?utf-8?B?MmVBMUhEbExHNHFxbDNsbzZHLzc5dk9vSHMvUkxwa2Z4TW9WSHN4bDNXTlJr?=
 =?utf-8?B?YWlVK0tKdGFJaVZrQTlzUXJsQXdhQng4Y3J0Y29RQjBPL3FNTHJGQ0VKbGEx?=
 =?utf-8?Q?VosEP85krIApm?=
X-Microsoft-Antispam-Message-Info: 8AZ6+CIH3qvMVPruCzHmL1pB2scLfq4YVHOU+O287YkXlKR2mZLJrAS9yAXBUbe/Sa7uCW3ywjFqRuO4BJSwpzyYKuOsUPoZ0hOBq8Jk3mde91d5/p+ETZ0EHD1r25b6gtwv++813DMP6r3bUO53w/6HN/EMf44JnBQqcO/O8Z95L/HaJTAqx9jeBw1Nn1Ti
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;6:1LEdXJGX+K4kUtaF539Me8cgdNULV9Ts1Yvida3hAHtudUYdILdD+GisYGq1cV0ndBDs8LP18NBTkrWDDhsHZxFof0jhkxZtCkSUEm+37fX6iMdDofSep+14y5aAq2045JH+dB0Ey/kzqMBmvLAj0QgO3CCXaKPApc79Syg1sQi1ilYxL927kG77psQKOvj2Tb9fmtcBKY+n9rrWhpBEa/FQI0FgqTLWDp+qtNPVg/xOldJsSWYEVk3J0hwa1Wm/hivnYG2ZdI6x7yhmHD/zEDVp3i+BCUECujgKek7iMCcGyWjyLBdptOtNP/pKT7Z+fSRXKxjGB2xV5lHaFUAUexedlJiMjPdcA5S9t9qjjmqApWp8OxBtZiPmoDtRmGamkEcYLylrDShCaa8Hei8j7N7052PLMpRlJeok+jbd5pknMGz48HdIWriTAPcew3uV/+gLhpxsAtWa3IjVtisO3Q==;5:l2D+9g5pvVGDSGnYJ9izdPRZ053JrI521Dlz2xjZU5tG5sLEKEAoaRd+i6LqciUXfwSMjkbsuIDSPssi0OZDRo6sp43joCNeOy1GONg75mN49Na75nFvf51IS34zMf4Oc+L7AeknR/3KbIMiIwQUqOlKRDp0khDl90QdNkM4MZ0=;24:Oorq2gLiEoEVcybKOGcrGiMzKwCnk7+X6XPNrajfonq92DGQJ/adpXFZMO8x2QgsAWvGKi5ZDdwaau5cYXLvyqK0gZqch1U0zTCs4nGLoy4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;7:UjjuGggr7fE+MM2hA98PjGRhzx/TyWfoSzPzohvwIZkhzOYuuggH9EWFpoyvoKczs7JMHO/6ubhieoFt00ofbNoshTfhhgx2utMQywBcNPi67t4YVD3gOVft7F4pupfpOlqGfQLAQbUeUfkIEk0c4xAZ+UeejKDzyyYaQC4ltKwlvuJU8sJkIw3HjCXRvyWZeAC1yCzU/9RbtgIPo78n8QMwcx04/B3azhrQqqnJJQ3/3zoX+KDo40M8SQCWj+Hj
X-MS-Office365-Filtering-Correlation-Id: 06456895-fda5-4592-9849-08d5ab7a9be7
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 13:35:42.9518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06456895-fda5-4592-9849-08d5ab7a9be7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1676
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 26.4.2018 15:08, Linus Walleij wrote:
> On Wed, Apr 11, 2018 at 3:55 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
> Thanks for your patch!
> 
>> In past Xilinx gpio-zynq driver was setting up gpio chip->base as 0
>> which was chagned to autodetection when driver was upstreamed. Older
>> systems, which were using this old version, setup SW stack which expects
>> zynq gpio base as 0 and right now there is no way how to set this up.
>>
>> The patch is adding an option to setup chip->base based on aliases which
>> is something what some other drivers are doing too.
>> It means when gpio0 alias is setup then chip->base is 0. When gpio alias
>> is not setup gpiochip_find_base() set it up properly which is current
>> behavior.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> In general, we stopped any controlling of the GPIO base.

I know.

> 
> Also this use would have to be OK with the DT maintainers
> as I never saw this use of alias before.

If you grep gpio drivers you will see that these gpio-zx, gpio-mvebu,
gpio-mxc, gpio-mxs, gpio-vf610 are using that.

> 
> Please describe the use case for this.
> 
> The only use case which I can think about is userspace sysfs
> and then I would really like to know why these userspace
> users cannot use the character device that is nowadays
> supported by libgpiod and there is even patches for some
> IoT libraries to use it. The character device makes the
> GPIO Linux "base" irrelevant for userspace.
> 
> GPIO sysfs is deprecated and moved to the obsolete ABI.
> 
> If there are legacy applications that use this I would have
> to consider it, but since this has been -1 since the driver
> was merged I find that unlikely.

Yes, it is about legacy application which I have seen recently and there
is no source code for application calls it because board vendor doesn't
provide it.

You are right that -1 was used from the beginning in mainline but
unfortunately this driver was in vendor tree for a while and it uses 0
there.

In upstreaming this was changed to -1 but customers have a lot of code
which developed against vendor tree and they want to use
latest&greatest. And without this they are not able to run that
applications.

I found that this logic is already in 5 drivers in mainline that's why I
send this patch to be +1.

Thanks,
Michal
