Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeEON1A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:27:00 -0400
Received: from mail-bn3nam01on0059.outbound.protection.outlook.com ([104.47.33.59]:15934
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752453AbeEON05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:26:57 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH] gpio: zynq: Setup chip->base based on alias ID
To: Michal Simek <michal.simek@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>
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
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <8b344d48-592d-8be8-bea0-e29b3e8469a1@xilinx.com>
Date: Tue, 15 May 2018 15:26:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <57e4bbdd-1e30-0352-f758-998b64a6b77f@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39840400004)(39380400002)(376002)(346002)(396003)(2980300002)(438002)(189003)(199004)(229853002)(36756003)(305945005)(65956001)(77096007)(26005)(106466001)(53546011)(5660300001)(47776003)(230700001)(65826007)(966005)(76176011)(478600001)(23676004)(2486003)(6246003)(6306002)(336012)(31686004)(110136005)(106002)(86362001)(54906003)(9786002)(44832011)(11346002)(58126008)(446003)(65806001)(63266004)(356003)(316002)(426003)(64126003)(93886005)(186003)(81156014)(2906002)(476003)(8676002)(4326008)(31696002)(2616005)(8936002)(39060400002)(36386004)(81166006)(50466002)(486006)(126002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2614;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT031;1:W2MCBbRX3BUXCUpkZLaF75IUYyGVLULocASaJ2FJMqnMYXUchrFxJzQGhQSjtyz3+ijkhTNzIEUb0nkL0jTwdLoTOglR8l9kS70LKAzZnm3P8F3TA+HRMY/TRTfGAolB
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR02MB2614;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2614;3:wX7OXGwwoeXl/jNLtofjc+Rfn4m0CGRMhUltM3+YLbSJ3iVug3NabOIiT/cPz86DHVmMFut7OUEnn7I7hVQRHf3Qn+FyfHlrs23/2/rPwE+zRIBThQdK59JgVcBRv8r/HzxfG6qSjIPm9sFRTYl7nb/VC33pKAS1ptz9Ce81mQv+B1ya2hfeacoU/jnj7t+5TX/UklMBbDdZEZLbFbOpH1mstsdiWAIFW7C/u+RIXYKW8g3xziFeR1dVFTL+HnBb/T4Lx/LZG1cxtJm7kGCKj8ogglADy+Av2IiYnxaiVPWzfd/gkV2ukKQjXmrTxkPlgKzv2Z3KwlC8W3F+tyltdkdGDrPOxmSvHmk+uU8D0pU=;25:JDYN5MVfnfLL5iPv+fDZsuBsZOlbxLDYXbOjp62s9Dp4DS22BgwfRzRGMQB7W6ML0GM0UR9cO9NnKPcJVj/QfNZeikwfBF/YF9I0wSnK7QCl1NhFVOXq3/LOmEFyS9rcykbB9IQnAjaSY+GB0RdqxCYKydTRY7wqRxJxRG7uMzikvAi4CyB/ao12v91XEHTrYlsPs4w2qDNoyVWw4U/3kbg+wtHeD1V995R6ZDpe4MPQQlqkdU/uFsMOXmfgvbn1I7ynA9m/7DtOqV53f0GeAXh+/kdvFavtw44fCZhfhIwX5m9JrgJBgQr4RPXtOTPKJa8ivTHNhyp+SP1/y08cOQ==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2614:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2614;31:wfVwpjfYulnPyZ4PKgL2HWCEx9lE7gAQIUjYxZEN3wYb6qH2GaU4IK1qe9hOyKs8dd7z9IpfU1QQdjr76B1gDpCWDhlT7bkwzgtocTYP1DlNy02MDdKvwbQUDM0MOK1urid45TSyuS5ys1bADq4jmzlUi53wGHKYrfRN0RZh/wqAxPzflBUoWP8nLZhUBfOiXaXk1BHLjMjXjnlaSKBbmNrRVOtsXylTvsRgtJ8Ki88=;20:IxYZETsKtxb7A9OLIG1Qf9YN/Z7CE2S++X3S3/b6+9EGgh1lNmGUe7vnv3H5VHVqxRVIlUrOQB0rO1SESXM+Dg0wKvzG1Yc19jTj5XD9JQg0JvnHdU8Xq70Y8YhYUQfxnVDtjKwuW4CNwz9a5ERvbbtJqVtRff96y4WpdEVDOE6EIw50ODHesfkp/RP/qfizzF5TeluEAQ4J2zTUKH6V/RE3i0IV+ih5qGbvEmnuf12H2iS/31ocpOPPshciPZoSns2PNs+d3Ts/WtujLRjVVlW48LdDeUGiYBuvZZlv8vN91VqZZmad9VshvvVKLkkb6TGNLObdLtLcfXpQOHg3aJPec5ESI5W02YXLeiACDuWtSITKk4g+kbxTVYVGER1fF71MFHpAOvLnNrkksoRT23mCShQto8UXUPDEIeWiRCpm9wFhqyPHlGHK6qYoZaB9ENgoBofueTzeHqFSY1utPKyuo9oSnoXt9/c8Z627rX5TXmJ5k/DUUjTRPwZCc+Tk
X-Microsoft-Antispam-PRVS: <CY4PR02MB2614EFAA4F4775114D1D7E74E2930@CY4PR02MB2614.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(166708455590820)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR02MB2614;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2614;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2614;4:QLIrssaE30P7y7rKVyA6KDLK/tdsSoAdV5cDmAQmE0sQBjxdLox3YGhivUOQsTHA5bdxGnkqqmQqdW2O7wEd/mQHYVvH4+PlXK+E0A9aFClIwOcuakLYIs1WeuMsV4/W4/Q2vbCjCTQpNSWgLiGzZYTWKRUKyauwq+NIpNSa6xgOHbOMtH/jAPyGlexs95p3GwnPkjx+fUQGrxGn/hHyJzU5OT1jwOLUxFEriBeIINBAnY25+I2M7BqlrLvJs+2zPTFjyamCseJ8kQ6OF39pz/8GISGYjegE3H+FC0/BxS8ZYHAZUkzZX78UVuk0eWijFH503GOu11m3uenLjVEW0Fp4+FKWFnJ3SW6zmW5pfaLKe19PBHhy3Sckf+hoHmeE
X-Forefront-PRVS: 0673F5BE31
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIyNjE0OzIzOlh3OXNiUGlwelQyWFJrejYzbzFFbWtZNVNI?=
 =?utf-8?B?ZHN0b3hVNDJXUGpJVzd5OEFZa1RWRDM1ejVmWDNUanpRd3FRUnBZbHNFd0gx?=
 =?utf-8?B?R0Fra1FtZnh1Y28wajdITTkxSVNYNEdtcFc1MnI0TDZ0VzlKWlAycWlLNnRJ?=
 =?utf-8?B?WkcyV1NxZjZTcW1peHE1MnJ2V3dYbENUOThkQnJ3TkRmR2NnbUVqOHVLcHU0?=
 =?utf-8?B?cUswb2NUZDJzWmtYSENsRUFpSERJQ3BFMzJscVZCZ29tUmttd2pkQU82VjV0?=
 =?utf-8?B?NUtEYmFGMEpnZnZsRnloMnpkNHppdHlaTlpCb1RuSFo2YWVjY21NVGNySUtn?=
 =?utf-8?B?S0dEdk5tMnoydFI1ZlBHckxtV293MGNTeDlTY0M4YnJLRHpWREdnV2xDaGI1?=
 =?utf-8?B?NDZoT3JqUDFTeUk0QkhRdUx3MEtnbkRRcFZaTWRad21DZEZLc1lISjl4cGNQ?=
 =?utf-8?B?bzZ3SVN0SDFPcVQ3NGl0Z2pJcGt5cUhzc0oyT3orcEZYcmlPUE1aU0krblpI?=
 =?utf-8?B?SzZ4aHJocGJxNENpTksyNkM1WGRtYmpZRVR3V1pIQkxsZ2hrQm1nb1NqL21S?=
 =?utf-8?B?ckZnUDl5UWpSeHF5Z3VuemhBSDJaeWI1Y2xBem1hU0dlUUp0c1ZHZFdTN2ZU?=
 =?utf-8?B?eDNJRmd4QnNDY05yOGZDWThrVDhOOHRFUmNGN0xpNU96VE55a3g0QTF1R3JI?=
 =?utf-8?B?MkpRdjBTSkluRjlQSHcrRnpONldWRjhocnhZZG5NVGJ3WXUzWGtPWDcrK0lo?=
 =?utf-8?B?NWZnTUMxMkZLd0liTHBnUm40RURuZkZ1K0g5N0taQ3dFbG5va2J1K2E3N2Zw?=
 =?utf-8?B?QUd2UUZmY1haUjlzMUgzMmhqTFRvNDJ3TGJSN1RKUjRpVTY4V2FPYTdjSGpD?=
 =?utf-8?B?WFJSbTdjK0JHeVd2RUwzYndzVThtamZLWHJSN0xhbytkTWM4V2JTbkxpSThS?=
 =?utf-8?B?eitUV0gxcFpxZC83Ymw0VGRlZG9KZ1lKTWRqTzYvTG9ocnhIbm5KOGptc2R4?=
 =?utf-8?B?cG84eGUvNWNWWCtIeXRpeHI4UVgyRXhhVnNDQXZKVk1tcTZuSC8rSngrdUFx?=
 =?utf-8?B?VVd5QzNUTDZzSWw5ZHNxQStIY1AxUnlwQWFpY1ZVcVB5bDl4TzhSTjlESXdK?=
 =?utf-8?B?Uk9OcVd6eHU0V0lVMlNFMkViMDc5SnR6UExBT29wMnhEQ3V5ZzYra0h0VjA5?=
 =?utf-8?B?cGE4V0F4UFhQV1FvbTVuOHRlcjBxMmdSTG9VVmpPcmROeFU4UVhsUVZHWUNs?=
 =?utf-8?B?YzRNVUR3TndkN1FyUE9hL1I0WUoxOEthcjdjbnNRZ3Ixank5YTFTcEdTVTJz?=
 =?utf-8?B?dHU5ejZoeUEyUEJPRFJCelY3WkFSQnZtbFV2MmZXYUM3YUtxK3FkWHNQRnhH?=
 =?utf-8?B?RUN0VHFzeTRDbXFZeEloekEzSkF6V2dDMm1KMW1Qc1JFRXMvRXAyeWVTUGpi?=
 =?utf-8?B?VXRhd29uT1hCcnBGM3JhS3RzS29XTGhLSXU5eUlhYkFZRmg3eFI0UUtYc0hW?=
 =?utf-8?B?dkE4T2pKY3V5cVlEL0xjZzVHR1BJV2ZDTmh6MzBoRWlETFVGbm53VVJjTFFG?=
 =?utf-8?B?YVQweTd3WVUzL21oRnlWWEIwODVHcnNtZkJKcE1vaGlrY3lKeWJ6ZXJZMG41?=
 =?utf-8?B?SU5KVHFqOWlLV09kbFNjbTllajcwWXZqRStKZk02RXRMLzBRSWdhODR0TzZC?=
 =?utf-8?B?d2tKU3VFd3RmZTNvcE5KQU9TcVNGT3dNSE9CYUNmNDZpZEhDbVpFbTQvZWZJ?=
 =?utf-8?B?N21nUE9MdHYyV0VjdTZuQXN2UWVEQ3ZJYWYweHh3R08ySTRzM0NDUFVib0Nx?=
 =?utf-8?B?VEk2Y0ZyTU8rdmhnMVJCZUVhdzQrOW0zTU9ZczM2bmVENWZuRUcyV1VHYnMr?=
 =?utf-8?Q?ODhQizQBMiU=3D?=
X-Microsoft-Antispam-Message-Info: 60jsiEkbudkdePA3aNRV+HZxeZ2oFfgDX/kY75FFcdMGOooPnwtD5sIlx0Yy+dqjxJW/EDE/GK+p0U6GuZi9Xqgv+T+eOJDn68hnvj5a+2vneywdoTWmC6OF6myNMdHMUabIU54/iipobZ6LtJg6Wx1QqtLwzSs06Cxe0ofIFMZtDwzp/YuTM2USz8V4j5Xs
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2614;6:82fnSFEHV/OIwsRYwa1lC9scB1SBg5M2NBBmB9gg9F4/MLJANWdUR2J1K4HwGkNiYWDLW0IbO+qDMznoxkNoUwwIVfzOSyrkVIJUxT6c3P5J6zw3zR7ghIPNbuawsoAze7n2QfWN3Im9YQFcxRNK9Ck9R4d9iFpMh4n5GbFN/4ySrp9F0R2i9FN655X/nPK+EVKHjzgJ6uD/Pho/ptrRKdXLgwTNqwLMPWD0FZnIJ0obQYodYTi7/5r6dzDWcbRyYmeJcNFpAEDTQmmmSASAKZGs6ia5LmAJ7q/sYetMWYC0ZCwDwwuRE26Zq32ZuDW+Cn6J2AQ5tGT7pqANehfSattZZ0XglAaWoWWpEoQPXLLuXcTPSJBNrbJna1OgKtcAtEOM8uKYqUtVnQww+Hawak6bXhqSlSTm7uU03o6FbfqtS7V4/w1pDPoqHYa75KTBd9v3KagCpC9oqzvlOlox5Q==;5:m4dLmmGuiwwE7pmZTf8MK023apgKTlAESgsevw6gE1+/206TE6JHMiS8rc9G8Rcxzo7enik7tkDcCkX0XTt1rs6gGn2B8LCaW4HQ56RxGG8Tuz1KQ/OZdlNsXp34QD0ZZPFsQiKgPl20b+72T8QS2k3ezJVrxGH3PFSjRV0U//g=;24:eSwAHx0JAm3XpTR8NfcqJVHnCTfixce/o/I2+x3tlf5llnROA9zOrC2Fx41vbFfu+36HffDzpXKic9Dvex2/2spglkxpXEWfAMrKsCDayqo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2614;7:/1zX90IbHyA5OiztBBqQhavGXcLl5SYlVDqF5wkL37Wmi3oKREpeHNejNGJz/KysvT1Yh4UHDDPj+FT0qbj+NPHzcmT5lXJE09RBEDlJxyGHBJqZiWOrPY/UawmKynt4rWVvRVa5uSLaDrkUoJUlXftuC1UVbQV6gSNhb75cg75yQ8cZh6RlTcbbmQlieaz0FbJQx4ay2Z4biptfnbVtQWB26UP9q5JUMMZq1ytqh95zPIh6/LxZvJg3Ac5MzjjL
X-MS-Office365-Filtering-Correlation-Id: ff7b0622-af4c-43c4-9659-08d5ba6786bf
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 13:26:54.4612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7b0622-af4c-43c4-9659-08d5ba6786bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2614
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2.5.2018 16:19, Michal Simek wrote:
> On 2.5.2018 15:56, Linus Walleij wrote:
>> On Wed, May 2, 2018 at 3:41 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>>
>>> If you don't want this patch I understand that and it will become just
>>> another soc vendor patch out of mainline.
>>
>> I don't really know what to do, so that is why I'm discussing.
> 
> me too. It is also interesting that I have met with the case with
> zynq/zynqmp gpio driver and not gpio-xilinx.c which can have a lot of
> instances.
> 
>>
>> It's one of those gray areas.
>>
>> From one point of view there is the purist stance that we should
>> only support what the mainline tree does, and be strict and
>> consistent so we don't accumulate to many nasty hacks.
> 
> Also this expect that the first patch does everything right which is not
> truth all the time.
> 
>>
>> On the other hand, it is completely possible that all users of this
>> particular driver actually must have this patch, and then I just
>> push them to use a deviant vendor tree for no good reason.
>>
>> Would it be possible that I apply the patch, and somehow also
>> establish some understanding with all users of the Xilinx
>> platform that whatever legacy applications are out there
>> must start to migrate towards using the character device so
>> this reliance on the numberspace doesn't stick around forever?
> 
> When someone contacts me for asking guidance for gpio I am telling them
> not to use legacy sysfs interface and use libgpiod. Last one was a week
> ago in connection to Ultra96 and libmraa.
> 
> But even chardev is not supported there now.
> https://github.com/intel-iot-devkit/mraa/issues/713
> 
>>
>> For example can we make a patch to some systems like
>> arch/arm/boot/dts/zynq-*.dts
>> adding proper GPIO line names to these device trees, such
>> as was made in e.g. commit f6b1674d570aa1
>> "arm64: dts: qcom: sbc: Name GPIO lines"
> 
> If you take a look at
> arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> which is Ultra96 board gpio-line-names are filled there for the whole PS
> part. Definitely take a look and let know if you find out any issue there.
> 
> zynq/zynqmp gpio controller contains PS pins (hard part) and PL pins
> coming to logic.
> 
> I can't describe PL gpio pins because it can be whatever even I have
> done that for one fixed hw design.
> 
> Interesting part on that sha1 you shared is how "NC" pin is described.
> 
> gpio pin 35 I have on zcu100 as "" but it should be maybe TP_PAD which
> is really just a pad on real board. And the rest of "" gpio names are
> connected to PL.
> 
> I am happy to take a look at existing platforms and use gpio-line-names
> there. For example arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> I use in tca6416_u97 and u61 comments instead of this property.
> 

Have you done any decision about this patch?

Thanks,
Michal
