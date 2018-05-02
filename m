Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeEBNld (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:41:33 -0400
Received: from mail-cys01nam02on0045.outbound.protection.outlook.com ([104.47.37.45]:4818
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751078AbeEBNla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:41:30 -0400
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
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
Date: Wed, 2 May 2018 15:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(65806001)(2486003)(53546011)(77096007)(186003)(65956001)(26005)(2906002)(64126003)(446003)(106002)(486006)(126002)(2616005)(47776003)(44832011)(58126008)(476003)(229853002)(426003)(36386004)(8936002)(36756003)(336012)(11346002)(6666003)(54906003)(6346003)(110136005)(31696002)(81156014)(81166006)(8676002)(86362001)(5660300001)(65826007)(316002)(478600001)(93886005)(6246003)(356003)(9786002)(63266004)(305945005)(50466002)(39060400002)(230700001)(31686004)(23676004)(4326008)(76176011)(106466001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1671;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT041;1:3JVuz9ePsXaSt/LGvo9Xkfq4bSS57Qhux2tiUYZJ6fyqQM3Rg2PVOgiWssoKYCXxDEjYAwshw1v9CFzAM/yGJP70eP4R5mODj2XJrnNVFvKeH0SbBIOOFu5fHwrSLV2F
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR02MB1671;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;3:j3ojh4JaM0zuYq4cYdZ5d8En8Bfl/6N5jB0RuSEgr+nEyujQEdS2fLKZWLoKjGNsLSyPiTFVm0yNw8AoXSt349Npvnqg9NkxgKRxxwEj/dX4mDsTu8x1IR2CcYJl02meCpUqkLIwxvNVY4BmMiKN+yHxxNc9HBy4TIRKbvOq/6xs+xeY7jrzzdTK1rTl+kNXji76+VRwVJdt1Tu8UYSbnpik1ecAx1J5ZvNZqwytOphYz7ifXYUa5Tt0yUg5wMjSc2BW4MFoH6nLHNaOZA2QNmgIJLtyfPYhp8LL+B8m/V5hltEFP7+VU/dbOlc73ND4ufZuIiOa/j8Ve2ius5BpoQpjZ4TWpPfwWylretothG4=;25:9ZxZFLgrkkWqW8N/O6ODuBnkm6YInk4sG1emUUMZk5u2NCCDnrFg/7Q1YDjCX1RkJacm2rl5/4BTU/yP80Mfg0DkgMIpHw5CqoSlW+xwE0CVFXkJ8lPheiq4Zcidi+aACswar+CLrZTlb0Jl43XnWf7NqflumOjWDf0/4Wk8JOM2c3XfK1TiDPTFu9tWt24l7obLXA5oOMz+QinzlkzxTD1l09SbY4Bhnzj9dMoSD3lEo5jFsoqNs2pxHW/Pn7SyvHZbbsUeSqsLYPVviaCiIugWYuyNkvPDWevj4NlrGcWlaNqpg5YCiiGWc4MSvEjrzafGtJ9G+fRqYNtoqQ6PUA==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1671:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;31:mzDxv/iY2l8e89QA720YKiCmWEEvE0L0M/MCPXxn5bF+mPYrQywOMyttiW4uyjzwN0L4YcD1ZfxX0XGVD0KISJNGyMrKK3iAavxLtZnmY05v7Ht69wOvF+Wew6PTlNLVCzwO6bCz42mDkCxrRZX0OUnFCCTEQLvq3wqtZPrY11pYMatvvnAxN1Uc46YvfMERzQxIFwNDmiA0y48ysZlO2Pp5Jk6wvIhgEV0cLFntbG4=;20:rcvXnnPrtw6Z5JL+GcN11jCrBBTmw+W/5k0GkJ4/1ieBgOmf16ry+qkYg4cb28Lka51ctrbcXdBoPG99hskGurEIWJ6tXIHCGiw3/l01RXgfwqd+gmODihNwhRtZB3y3kl2jC7GSYqA6a+dDmw86arq/16Htuv+0eahzknK2Vm7KRR1AV+xs2Zmc4W/Adga9eZzMvqUI4aZTMI9Vsx+XvLlltgs6K14qDlNqaDgynkLwlnIapjQE9UFMLHzdgbiUTi8qzFEmNtG7M3vDmLLQ7gPXUAk3a7X5pYJfdWFmEIerBMAcEP9CiBcaYWjsGSLvZ1p3V8o2XWQiKi8T3iaXUS5/oRuvWbhlXo8qdZErwSYNdWkxrZ5GYulMbXvGsanzWwaa24WWFj0ANJBitwfq+IeYz8/Yjq/FmjD8toj3J0Cu6ebT6l/RjdCqyldRNc5OoOwIYMZUspC0AKVRLAHmTVXTF7B8tNt58FuuY3UBc46kmR/Z9aCcwyEeCxE1avi3
X-Microsoft-Antispam-PRVS: <BY2PR02MB16711E65558DF930090D40A0E2800@BY2PR02MB1671.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR02MB1671;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1671;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;4:NAFZulXaAXGUKpZ5Kf3xfLAiT8Fr4n99bVOIUchwe49MR/L87sYYvC2US0iIlojy7mtzpE1FXCDo8rasDJJBG666hF0UkCfARbergCQa9/U0ziC+Ke+F0grwGe+zXv5I890cl1wHNn2y6j8yQBZKlFQvQM+A5/IJaZINQRtCTROdQZ41H/q6O8OOvu2yyi5NVzVeMyYgu7vRqJWPl35hfjBiF+JZwO/U0BMb8oLG9KxUuxqFb1Z+apPNVSYzYlhNmzjd1K9JzRWzdKfdsZ717hkpxxiarR6XB5o9bvFfHYH9omqUpifDZAKEJgpR8m2E
X-Forefront-PRVS: 06607E485E
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIxNjcxOzIzOkZSVVpKVXdhTWFtTXprSVA1cWw4VHJIaGc1?=
 =?utf-8?B?R004Q3BaNUt3cG5MMmN2dDVjdU9DNkpVVVIwaUNzYUxzbDhyQXMrV0JBZGR1?=
 =?utf-8?B?Qk5paXYySm53WUp1cUVOS2ljQlJwVEtjZGFhVDNoT01UWHNHMEYyUFNFcGI0?=
 =?utf-8?B?YWNLYnhTblJxdTRqS3VpWVlhTWo3dkNrMXM4WENoRVE4OUFTNFptRXhycGQz?=
 =?utf-8?B?N2YyUjBZRUp3NjdvV2dMNGpCbDIzTGpBOVhSK25aRUt2bjZFb0JSSjd4Q3NT?=
 =?utf-8?B?RUpidFJnK2hzQk1DMFozR01NQjFrTmo3aWpFU2tQWG54VnF5bDBDWVcvdXUy?=
 =?utf-8?B?eTZSRThJUWt5NmxlVEFIbW1TUGZVSGlySVdPamVBUWd0b0dZYjJsQ21jSnp3?=
 =?utf-8?B?YnNGeE9HdGVlbTF6MFJMWGFkZ0xVaFpmdGdaQW5lY1V6MkY5bjN6VW5rSXZu?=
 =?utf-8?B?Z0E3QkhuNGo1L1dyNXpMLzM2Z0djaGMzYkpUNHFlVGd3S29xcXk4YWFQb0t1?=
 =?utf-8?B?aHJzbkRTTEJKbVhSeHNpMy9WMGNwQTBiYjcxT0loeVA3NzhscnlGQmgxOG1r?=
 =?utf-8?B?MU1lS3g1YU5ja1JRTEszb0NpQTV4SUVsVllwMERUTDRoZGs2Zk5SUk03dS9W?=
 =?utf-8?B?cUwvMGlNTStRalhYcHNNR3VSa0p6aWlIWVpjVFJ5RVpYR3FscVdoN0swODJX?=
 =?utf-8?B?bzJHTHh0NjEwVmF1K3RsdXRPdXhtVFRvWWFqRWZ0cW52VXJMeGdFeXpiazdu?=
 =?utf-8?B?dEtYYlgxNWFrejFqWGYxbnhGb1IySkZGN255U2puQWZrUUU4c1VBR2lVaVlO?=
 =?utf-8?B?ZWlBbnRIREpOZU5qUVZzL3RmZUlteWNvVUpPM1ZhSGgvNHJab3REc2tDKzNL?=
 =?utf-8?B?NUJKU1RJODBSSnB3WlRES2ZRUFlQTXpyVW9jL1hxUlp0ZmN6MTUxd2JLNDdK?=
 =?utf-8?B?RGZneEk3ckliOU16cVNnZ2FGRC9DNDBQWmhtOHZBdXU0SDFncDZ4ZFJhYlNS?=
 =?utf-8?B?TTcwUXdjcnRlR3pmdk5NVlp2UXR3dDJjZDJKaE41UldhbTlvaVNzTkNmQ2RU?=
 =?utf-8?B?ZXRZMmljQ1oxM1V6eG1URExyT2FTZmQvMTNtTXVYdnlpV05ac2JndHZXN1ZN?=
 =?utf-8?B?dkdleWcyanZMcytEYVR5cGZQVGtDdEVBS1ViUXdUa05PVmVXTG84SjQ2U2FV?=
 =?utf-8?B?c2JCMjl5cXF6TW8rZmlzb0Zta2tOVUNLbytMOTVyOXZkN3ZnaDdPc251Rk9Z?=
 =?utf-8?B?bFhkcGNhQXhDWXJFa3RkZnhBUWdQSnV5Mmo4NVBlVlIvcnlMdTcvdjdia0tS?=
 =?utf-8?B?OWdjWm92azBlUTZGZ2haeWhxUW5rN2pRaHBmZng0aTF5ZWhjQ3Zic2lwQTM5?=
 =?utf-8?B?WFVQYXRBRVpDelBDV0pxMktrNExLSEhGTjZzdXFZSHFCYlZJbVo3dTFlQUdj?=
 =?utf-8?B?dUJ6b0tFdFdTRFkySFUvWlZYQmhpZC9MTmhidUNWQjIwN29kaHNlZWdJS2dt?=
 =?utf-8?B?cUV6ZUZJemNKbWZBbmoybDdOSUNoV0pxY0xoZnVZVzhCV0FkOG5YU0wrcEtZ?=
 =?utf-8?B?UldMZkt2bE1rME9YSUN1WkFhQ05EeC9mN0pBd3dqQ1NzZ2pWU091ZjZjS3NM?=
 =?utf-8?B?SmZuNUg2blhyQk5qV0U3NmMySndlUVlpTWo0U1lMNlFlVStkbUNQSGptMVc3?=
 =?utf-8?B?Qmp3RFJiZHBId0EvYW1xMXRYek9BR3U4cTZUQWdheVAvRTFCQzkwSEpFM2s1?=
 =?utf-8?B?N3cwNHZnclRGNUVnQTYwS1V4STg1cWtKMFVhWElsQ2xNOUVBOVhlWkRLazlM?=
 =?utf-8?B?eU80aXBZWGtZZHRXdnl6N1dNb01YMm5vQU9wdnNIdXB5UkFnYUZkb0MwOU1M?=
 =?utf-8?Q?aLkUCU3yh97YUDvFnWYu6B3tsD4OMwUp?=
X-Microsoft-Antispam-Message-Info: U99KGKGTedXVd0d4OAVBNSc6YpWDnWPqx141rHCaKnGLQpcae2ORYGgZS3BNz1AY3ysDX2oX+JLTM0hhigBgpoSRVeRXyUiK/oAqX4z9ja6QyBFBFWSV2pow4Pn7sbzqIa4MfcCpuynfGBSqAul6ktSr4qb2YpyQ2Y6OjIi5zL7KrqEfV5dL6dHlk768Gg/f
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;6:NvQfy0Hx01/JCJWk74gaoJX883p6fjlUzm+M3+yItDdGp176IirbvwaQyS9SX5EOwdUd2MhOcteX7DXrvPtDfFaDq1gfQZ+CtSQW9m3utcx04MwuIW12joDEnD02HS4DZgcd+SSrfJS1BiXXzB99Iod5aEpSRDDfCZhj536igCVbJkBMbAiP7VkOFJQUWPPHSxOKkux/p3PfhuSminfBa9YQqgTy1l14ds1scPBUxRfEaZvXX0nejU03a8e25lOP/XRRPfuj1IcZpZu3+6hfWvXJopyjauhJDfr7KECPmC0ul0rZO0krdM5o0bu3Jsmn0elMQZkqjDu/LrjM+pL/k8AXTnDvC/chizNdsiIlpmi/cPpex1jZTUEsFkaCSRi1z+sHYT1D2DIONXPV/mNVnlW1U8IcU2D8VsNBY0nhWwYcv1EQbQgpJvDaF0dtGmOfw501pLcxP26kTR6dTETz7Q==;5:WrCmwhwtdAQLiabQG8D1Z3nGm+XCyvFM1bWpSir7fBx2pPbKfhMeJVHyj3Zsa9rVYY+8t8vv4gOgBZTEyYVmTINwLZy5m+OhfVZ0xHB8ZX9rK0gsiWFDrta1whL2EzsAVxDZRRl9tRP/sUCPFu7ebY8yZIFIfDfFTXafNWtOOPw=;24:pG20b2bb+Yjp3YYCGjJ6ZhflxDSgSYi5lmHGQMOZCyhnjSh7vauNJ0ZrcZamD0W1rGegZGSneJy01hIYkX+kCKbc7Yzq8/k1CSo0IecMb58=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;7:tfO0+z27jBM3suZx/E5+ZzCAjyyKoN5Ohnh7G64xTzq4Ibr+BnWdWKz7ic0FsP6k58VRkcmk3g228bo+7F/EXxI63g8SBLIhhAJmZG57ThfSfZBV5X1V+3No3g0YHvzoo6y2hwOxuXdDO8aV3t/T1hK6R4Ds+pFcMcwzbKIXi//RNnxCm+k2aXtkgFT9QqrhYzObDkZhxyeT22BDrREHzHmFAQVHespXNdBAil8EvEDvCUY7sOfjh1dax3JmTFO8
X-MS-Office365-Filtering-Correlation-Id: 6f9aee63-5ce8-471f-bdc6-08d5b03267bb
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 13:41:27.5503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9aee63-5ce8-471f-bdc6-08d5b03267bb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1671
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.5.2018 15:01, Linus Walleij wrote:
> On Wed, May 2, 2018 at 12:15 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 2.5.2018 12:10, Linus Walleij wrote:
>>> On Thu, Apr 26, 2018 at 3:35 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>>>> Yes, it is about legacy application which I have seen recently and there
>>>> is no source code for application calls it because board vendor doesn't
>>>> provide it.
>>>>
>>>> You are right that -1 was used from the beginning in mainline but
>>>> unfortunately this driver was in vendor tree for a while and it uses 0
>>>> there.
>>>>
>>>> In upstreaming this was changed to -1 but customers have a lot of code
>>>> which developed against vendor tree and they want to use
>>>> latest&greatest. And without this they are not able to run that
>>>> applications.
>>>>
>>>> I found that this logic is already in 5 drivers in mainline that's why I
>>>> send this patch to be +1.
>>>
>>> I see.
>>>
>>> Sadly comaptibility with out-of-tree driver code is none of our
>>> (community) business.
>>>
>>> We do pay a lot of effort not to break the ABI to userspace, but
>>> it needs to be an ABI coming from the mainline kernel, not from
>>> a vendor tree.
>>>
>>> So to the mainline kernel this is no regression.
>>
>> I understand your statement. On the other hand it is feature which was
>> permitted in past for some drivers and this is +1.
> 
> But was it permitted because of breaking out of tree code?

You know how soc vendors are working. We need to develop code out of
mainline for certain time because we can't share details before.

When we get permission to upstream code a lot of application code is
done already with certain expectation.

Soren has sent this driver with using -1 for autodetection even at that
time Xilinx gpio driver had 0 there.

This patch is not breaking any current functionality and there is no any
gpio alias in zynq/zynqmp too. And from my point of view the usage of
gpio alias is similar to others aliases present in DTS file.

If you don't want this patch I understand that and it will become just
another soc vendor patch out of mainline.

Thanks,
Michal
