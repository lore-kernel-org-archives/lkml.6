Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeEBOUB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:20:01 -0400
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:38907
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751724AbeEBOTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:19:52 -0400
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
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
 <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
 <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com>
 <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
 <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
 <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <57e4bbdd-1e30-0352-f758-998b64a6b77f@xilinx.com>
Date: Wed, 2 May 2018 16:19:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(36756003)(36386004)(54906003)(110136005)(58126008)(478600001)(2906002)(356003)(31686004)(44832011)(86362001)(93886005)(77096007)(53546011)(2486003)(23676004)(966005)(76176011)(47776003)(63266004)(230700001)(305945005)(6246003)(65826007)(336012)(39060400002)(81166006)(6306002)(8676002)(81156014)(31696002)(26005)(4326008)(9786002)(446003)(106002)(5660300001)(476003)(65956001)(186003)(65806001)(50466002)(8936002)(316002)(106466001)(11346002)(426003)(126002)(486006)(2616005)(229853002)(6666003)(64126003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1675;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT026;1:acAQ/rNJdIfl3vkJCewxAbnOal/EPns4ruIg78WpKO+rH01PLgcBOA4cdSEHfOkyrHFKrRav5yB7Yuqh3u47vsPcLOWaoWmkyxOVUqKZITzOSsWSSGQuBSsFtsUw1cuj
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR02MB1675;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;3:JMJ+QwI+kOHIhoIgKyThlmDFQXBKmEMIj6DqdPCX6RZ4QoNrZDEkwHpmb8EitS1gy66n/vB3EBc7bfUM/MIE5AuQv4FAPqCz7TxDKBdIl+paFGhDbz3Kc65vwXjsLgUM4J6YGKVbXyC/a6f1OF4DKtIWg60sYG3s+JLCY8U2Aehgrc/rwLywlYZXVZHTg3WrFuv489RHjZkDIHVFPEngyHk8qaUAJg2b5QSQk85nPjx1WswHjLd4ELTrzff+HSc0SyyU/WdErVLIul+DUJT8JtxqvgeQ1z/t3oxHKjQcOGiI8SzFzYNABWeE6wcFfaqHbihw9Wl2zDawDfjN7XOunvuKGWbP8JVyrhh7kv5+Gh0=;25:o5H+3IoGJqDlOFnHNMMJcMp+FxGHxo35ayw1eL7lK1+isU/rGakCsTNkAUzh3KCJMT10gzeUDyfzciRZfAWtwxcgitdoi3Ik1yGurRcr6O4djYPv5PVry7OTmptpVyhb/CsTsh5IPT6ASpTRuW2vkSzkmCCQfvid/fd5btppf3YouRdzwzHY8AHl94O7mYlfs11yinOXrV8DvueET8POdiGUNLVabOYdMmexdkWpNHg9GFCd2cD0q677nnfF6nxY0HnrRXQaC0PjN4MUvQWqiuWZ8ip1AGbs1AwovyHvMXf1Et+iYRuf9cSo9MxQg/B9wTxzOZft4mtcKcjWjnInfA==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1675:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;31:vVGBkeOLmXcSuBT9tGs4wbAiKWnSypmaxfkKgNXX3RJFuXKQSUatRBHV1w7AoMMy9EUlJ/1FVfJYpnrlYp/SDonJ1LjpLTvrX7CUQSpPKk+PQqRDidyK68Y0AnwKOzWPXRxfC/kjYIxAQxlabLPqLbRE04NPazo73/tAnNxk7EiITjFvTiD0iFV3kneKESN7nmtpKvfQpNAuAwek1ANgKa8NbaI1MC2e+sAlbl7M8vc=;20:TZtTx7jEYezVHslcUV/xHmZ9ISc22hELoSDVWqbA7/sW5lvsZEnwUqeEv+Msq5kwdkEeh8MOH8Kb7OJDEv0l6vkbNbwv/R/igxwJzpsw++7JcqHKHt2to/eYD8PfC6QbIay8bxk4dz1Q/2fShvUzko+V3Hk7jocwae1NB9zNZ/EGCG2+oknSGIZuvz/MgAWkxubpes2GK8Wws0YULbBkRsWSmRc0WXukUZcnjbxKXFmlFDH5YSX2gmvK8FT0F+sJrT/3ncaYOYNzpyMEzgXSu53aWvPoHFHV8eh1hNQmcxtVz7YLgLFpyEKgoGq/VpRok8wTdQqcvMeEI2nyejVMmOs8n2cFgBfSTB41qdEiYYPXY80wIrlbyU7svC+5RpTOSa9gowkkY7yi1n4XWLXQ2wiABi2G/3g3PJqL41T+temRfenqHJl/fXG+LRHP9FC9fTCV7l46unLGvKBlGL9HzK4rdwFBwEa0Lh02CYjvqYq4e0SjfOEAjkqBVpyuVN3M
X-Microsoft-Antispam-PRVS: <CY1PR02MB16752744D5C50B1B9A770435E2800@CY1PR02MB1675.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(166708455590820)(192813158149592)(100405760836317);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR02MB1675;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1675;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;4:0Tf0/sLKLY+DuQyrJIl3UAHnxjXK9ewGJ3K4JNbaVI0hpLHrATIr79S8Lxec8hpFq1hhw6GjjvDCWnpK7x+lfvlCfdRWsZJ2W0LPs8lDgDms8dEp0NykSURjtAISQ/gkjoFoNsnV1qlCxMmYS8LbyFHGvMwhJn+tUyrq9zbQaZ6+EDyfA+JmLEE/Q7gXGBtWiqTegQSNqLn0HcKqHlPoLEF4S2reNwDsY/yVFgEtuv61soWGPcp1ker8GpCWoMCsmo+RAbtx8aYKaG5gvdELLKBZrfPF7QZ1xGlxk7q51rHEXUW7ZluFgZaofVNNPEG1mgb94u5O/frQfN5XuceL+Zw4qF0KK2xfioEvLZqbvuxy4uA3phkgKi2Njus+rAo7o6/7QhA2lPRUclTj5nK68MdMLmBvbhRLH/nlYLkCiYg=
X-Forefront-PRVS: 06607E485E
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyTUIxNjc1OzIzOjFnZHdzdzhaZXNpRzNGOTF4b0lYUGRXd2Q3?=
 =?utf-8?B?ZWQwb01tTFh2dVNmdHcxelBVMm55N2pEay9wYmJMQW5qRUNLZUxRVUw2QWhO?=
 =?utf-8?B?bExnYUk0dUg3Q2FMWFpTa2NVWEpDNDBEUCtXei9UMmNaaW5mUCszVno0SGFI?=
 =?utf-8?B?Vlc4N2FTRmxGVVFXNno1VEJLRU0zMlgxMXZ1SGluUTRLandmOVViSmFuREU1?=
 =?utf-8?B?Nk1qU09KK1ljNHpOQVpzdEpVa1ErQkpmMXRxaXVnTmJmWWNkY09LQnl5dm1K?=
 =?utf-8?B?V2M5eGNZL3ZZVDRDOW56bzcvNENocVdGWmlZc2M1SHMwWXpqM2hzell0ZG45?=
 =?utf-8?B?UHI2c3YrU2txb2FvUldZMnNoM3hZYVB2YnFjS29OS0o3TG5MTnEwd3NCNXB0?=
 =?utf-8?B?Tkh4MlR5MC9UcjY3NWVYYnRaZXZqY0RWV3F5WjdDNkdUNTZhNU9RUCszT29a?=
 =?utf-8?B?SmZCN3BjY0MvRlNoOGdkdmJCd2FMWU83aUZWcWxZYXhXY0w4WDJrdThnVkxO?=
 =?utf-8?B?YzIycEd3aGJlUHdMMmJoa1NyMHB2aUJ6STZKTXpjMXVFd0FjUkFvREJZSENQ?=
 =?utf-8?B?WkhnR0dLNTQxVlhUT2ZjN0tPRlYwZkpsWVVmSEtiOU9OQ1VNVkpSSWY0Vk9M?=
 =?utf-8?B?c3lYbHNQR3FLeVpYYWlzYXNPc1o2WHNxbnQ4YkJqR1cyZENub2F4TFNyb3Fp?=
 =?utf-8?B?SFhQVXNmcElSQUVsYy9aSUFWSkVFT3YvbkJVTkxxNng2cjdjTkdoNm5iTld2?=
 =?utf-8?B?bWFHS0ZTWmpLd28xL1IzRjEzbHJEalNhckdaWWZSeDNuNWg0WkxTOERVOHht?=
 =?utf-8?B?c1YvaG1raHJYUG9OM0d3Vk1tNVhZVzNpYzhRWEYwTmJZN1UvMGQ2Qm9aUEdO?=
 =?utf-8?B?V2pNc0dYVzdtLytOMVhGNUpZWFVVYnlEKzBzM29LMzJFbG52NlhpWDdEYmFp?=
 =?utf-8?B?SmZVSTJkWldhT2NWN3Jsenl0UGl3MlRJSDVGNG1NNk51eXZYSXpLUHlkNlhK?=
 =?utf-8?B?dlhOd1BjcHJvU2pYS2MwYTdPUUt0czdVYTZpK3hrLy9Qb0g5dUptQmVySGpu?=
 =?utf-8?B?L09DVWN0blNiVG10bCtXMkQ3VUtYV213OTdyMXhkTUNRWHlXQWhOSlMzeHl4?=
 =?utf-8?B?UWdrREY0THBMZUd1VUcyUW96Zm55RjZKOEhPZzFxaUt1V2xCK2ZOS2liS2pG?=
 =?utf-8?B?eHM5WUs4WndoQTZUOXoyOUp4K2Q4RXVReTRTYzRoV2EwZmdLMDZkbzUxbjlx?=
 =?utf-8?B?cm53ekJJNThBYktpdVBnb3RhOFVkUFhWeWhjSmk4REFYSEQ2NG15c1Rlc09H?=
 =?utf-8?B?VXYxZlVsS2pPa0lqUnI5Rklyb2dDd0NDTlVTY0FMelRTdlJtcHc3NEl3NkY0?=
 =?utf-8?B?L0JaTXlkMDNJc21HMkdPNE9KQkZWV3R3Z2RlcUcyMWZJS0Jxb1BuelpqL1FE?=
 =?utf-8?B?UEI3KzByV1NSTjdHSHR2WDJKRG1CSGxrY1YrSzZZL2g5aDh0T2RQYVlQeUd3?=
 =?utf-8?B?K29sMU1xL3pRK3ZuTjB4Z2pESzJJTWxiL3Q0YTVpbk5TNDFORUp1Y2h6VDdz?=
 =?utf-8?B?UlhKTXM3Q3VTMGhPTWs0WHdKeHluYWtodjFqUXF0Z3d1Q3VndVYyOTYzY3Nj?=
 =?utf-8?B?QXd2anJ3N3RTeEQvRitMRUtpeDdZbGdyaGVDNWtyZlYrcnkyT0FBUFNDNWFk?=
 =?utf-8?B?MkFNV3VkcnZzQnJHZVEyM0VZd1pCUWhMaEZJaTVLNFUrcENsa3BCTWpBZjZX?=
 =?utf-8?B?YnhqQk8wL0hxbkI4bmlOV0k5a0I3c3FZRzFhMWMvWTdqQ0hybEZUMmNuQmVG?=
 =?utf-8?B?Mjl4Tko0eWZuMDZiWGQ4MFQ4eTJiTmJnOG1YQXpmOTRHUStPOXd2SnduYXB4?=
 =?utf-8?Q?q1UmwwF+56pyE1gVs5hAXhUA650/PMQo?=
X-Microsoft-Antispam-Message-Info: olQJ7l+ArDtz3JhX9rxklLNc6+5J01WdgKE+YAA6YSOhkk+FIZJjp2pHF2I9AzX7Sc3Uu3JA9t4AhcUGiu5vWlU/SxeddxwqwbPIh23iqk3BgWanqLBuIoC49/zZd2RJewPu3a9+SlWrkAkD0h4U0UeQlPDr2Ppweye0kYEqu1OwcGdVw3Vh7yaX3XyXprmc
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;6:AIp2SVhxv8HiHm7H76R4Z84UoFUidl0aIhSzzVk6R2SNGuSf8q2U0+b8N24mLMM8I912kY4HVJREW0pqLqs98nH3y3Kl8a3drJaK3zzNZbYS5DewIIZF6XZY/CUX7Ax7x7RIvDEp0mLw/tEfRzfrX1fRAIGiVCT0BoUL8y1eseL4KlXpCFJnvgEHpMk20tn5bxg/cscypoazFADpscCBS3PgSTVB7KD9mvXNQ3s0+GAkIUa0CiLDS+hvJAZ9unuVvudvfTh63gQO3IQr8J/u4Xo83JXu0TC6yvAfA731g7wnNEt0/2bfazgzCXBfL/aLwiESPPxrS3F8+a1n9l3oB5giQnOR72KIRFn8R7za9KFWN93Fkl/ScpEe42flRBa95m1u51/RHbAJzkP/B1Or+bb/hk6UJUY1RU0xuEqdKadXQpC2YLTtGlL8kAJ0gNzCigyaZavYzqmCmk2g2tsgLA==;5:AcgMfr3+Ps8gZSBda/wy1Fqz/yoVJwScODTVLQzajEHwcDMQJLOCT9r8mXXFtMAqJbvflCguiRU3Dkd+tlbZPMIXVtKpv2xonouGJDIICio1LaAA/3hdmdhXeoHbux42kyM0EsrJ4srF2rsSF+p5TzvvcZYiphdlEWbeLWoMdW8=;24:mRkT41CgAgeWVTop8SzNagkqlTsIInSHQbdqCN/rcROkoQAl+H6QIz5yXmkBIpOx9IDUYF5rntcE8NrxIzBTWd40J5h7aOu5GDKqNj/Xu7E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;7:KfhgzlB7C2F+k1vlCv3cNd3JQqYYLDriaJEefxGzbpw/PAa2WNTw2gbqJjN30h1orBgVf1bAc5+Tqjh1UdtsTml2XweFaY5+zgvDWDqYiNI2T5FlpV99zx3Ua90bzf/I4PrESYEI2C9Fwlcn889Kk1O7YvCXxaiBNX3GqQbaX2etsGb/6oLX2i7veDa4Qacy5J/l6N3ApLz5kwhNUUejiywJoVQZH2U8M2lcvraQKB6VleIdHZIAE72/394QrIh6
X-MS-Office365-Filtering-Correlation-Id: 1752f66a-f7ca-482c-df16-08d5b037c379
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 14:19:46.4838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1752f66a-f7ca-482c-df16-08d5b037c379
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1675
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.5.2018 15:56, Linus Walleij wrote:
> On Wed, May 2, 2018 at 3:41 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> If you don't want this patch I understand that and it will become just
>> another soc vendor patch out of mainline.
> 
> I don't really know what to do, so that is why I'm discussing.

me too. It is also interesting that I have met with the case with
zynq/zynqmp gpio driver and not gpio-xilinx.c which can have a lot of
instances.

> 
> It's one of those gray areas.
> 
> From one point of view there is the purist stance that we should
> only support what the mainline tree does, and be strict and
> consistent so we don't accumulate to many nasty hacks.

Also this expect that the first patch does everything right which is not
truth all the time.

> 
> On the other hand, it is completely possible that all users of this
> particular driver actually must have this patch, and then I just
> push them to use a deviant vendor tree for no good reason.
> 
> Would it be possible that I apply the patch, and somehow also
> establish some understanding with all users of the Xilinx
> platform that whatever legacy applications are out there
> must start to migrate towards using the character device so
> this reliance on the numberspace doesn't stick around forever?

When someone contacts me for asking guidance for gpio I am telling them
not to use legacy sysfs interface and use libgpiod. Last one was a week
ago in connection to Ultra96 and libmraa.

But even chardev is not supported there now.
https://github.com/intel-iot-devkit/mraa/issues/713

> 
> For example can we make a patch to some systems like
> arch/arm/boot/dts/zynq-*.dts
> adding proper GPIO line names to these device trees, such
> as was made in e.g. commit f6b1674d570aa1
> "arm64: dts: qcom: sbc: Name GPIO lines"

If you take a look at
arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
which is Ultra96 board gpio-line-names are filled there for the whole PS
part. Definitely take a look and let know if you find out any issue there.

zynq/zynqmp gpio controller contains PS pins (hard part) and PL pins
coming to logic.

I can't describe PL gpio pins because it can be whatever even I have
done that for one fixed hw design.

Interesting part on that sha1 you shared is how "NC" pin is described.

gpio pin 35 I have on zcu100 as "" but it should be maybe TP_PAD which
is really just a pad on real board. And the rest of "" gpio names are
connected to PL.

I am happy to take a look at existing platforms and use gpio-line-names
there. For example arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
I use in tca6416_u97 and u61 comments instead of this property.

> 
> After all that is what I strive for as maintainer, as the IETF
> motto says:
> "rough consensus and running code"

Thanks,
Michal
