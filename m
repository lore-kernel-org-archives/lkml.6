Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A8AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B3E20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="PAntcAXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B3E20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJAXKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:10:05 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:18624
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725910AbeJAXKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tf4RII8q/fxw7JYSn9wwqywzw+b8ywUlnNx19S3w+M=;
 b=PAntcAXdeBQelqgsw1F3J1OPpAw3ZqtuJZyDpkRLO8tpw0tM82kbPT8nkwnCoTVRvcXenwI5wWdYxwP0aRuLDX5FKd3MB/H0+L5rTdegMrjhMqkWY4NsGtKuA5HmuJr/vV6QWzIquMm/8CCEuvKXQ8bD3p9PG16cA+K3BwZiCjg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM0PR04MB4658.eurprd04.prod.outlook.com (2603:10a6:208:75::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Mon, 1 Oct 2018 16:29:28 +0000
Subject: Re: [PATCH v2 2/2] pwm: send a uevent on the pwmchip device upon
 channel sysfs (un)export
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, thierry.reding@gmail.com,
        gottfried.haider@gmail.com
Cc:     stefan.wahren@i2se.com, hsweeten@visionengravers.com,
        loic.pallardy@st.com, broonie@kernel.org, gohai@sukzessiv.net,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <1538400237-28766-3-git-send-email-fabrice.gasnier@st.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <b43c5dd5-6ffd-5e5a-f4d0-86792feac304@ysoft.com>
Date:   Mon, 1 Oct 2018 18:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538400237-28766-3-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR09CA0072.eurprd09.prod.outlook.com
 (2603:10a6:802:29::16) To AM0PR04MB4658.eurprd04.prod.outlook.com
 (2603:10a6:208:75::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e655835-5a74-4769-7247-08d627bb0f5c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4658;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;3:RDWQ2Vub55Laxm8gwaozwM6KIo+vTFENG4gQKb8MkfsQBwCfBSlMMCZuptPXjHU/Z0BmR8ELCiCjYXpT6p1iAlIueFCXFSy7Oc+LLaZIy/aM4cOYWY7wfIh2VBvuN5XiQXXW0q4SGFKFSP5IIO+IzUU+uMblNzijlpJJ8VOyRn4a3m14SQ9vgpeN5iupye/xoUZeA+iZrAljapceo/NKmcVzTlzkBC8IhQyayKab8x3gCk+6I+9bm4g0CEsNiNAt;25:kQgk13/7CnQ4bit9Y+P6Y16ySr9s9+ReiNVJcRgPNZwIAUWbd7uPSqfwflb/R7Ly8hUcwQdKtz8qnxiWQqvsHkF56eF/ZHdsHOv0OS1Jy7SEncxLqaWuK4eWdYTTA662TONm+VyzJ7800CJ/yvWiPbPpzyl371GTJz8nrOZNcaBiOGMjVwqUvceJjWw0gk3+l3NZ9bf0Gwi/uu79QwSvXgPaeWzWYRuMkOZLS+s5h1wysD476pN8F85x+xnb02hFog9F3IizpzmUXWdPeDL2mkYMRcdZbFVoUDZsqmnrRZ4ZvPLb5dFYZN380uYRo4yOhu1UOWckI/Pgdp3ngYZuIg==;31:PxHI5zBJKr/T7DjNhPTI4z2/Slydlq30v/JhuOJ2Mz3bggjvJLZ22jsCYEzcoSBS7m1+oMRzHJlhZvad0njAkrqS5wA52WrjPDP5yCpB8wjs21f/1/4SfyjTAFiz5i/FzPRU39ZLaX2tsQ/6nXjEfe2ButVTD2Ic12vPdKE8mNtCq9maJbf7DLGsK33ADnF+gek2YvdrixNtKR4PGUPelyg5m3c+VW7P5Hu6ZE9lXEU=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4658:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;20:otiDdeq2UGZGCJUV0ffO/FfxWSMxNfECOR0i7hixm3J2DwcShPoEaf/6dcMP41Toa/8tucZJuuqfFfjTmWlLc/cVR/V2Cq2zqPIQ1Ut3Alfd1/zgcZdiJvnJic0pYZBAX9xJ4Jd1BQSqphzf/UKCO4doOH/OfmOXaRnGFdMTwHZuRCgqEu9G9xMCR/KkbuxUObEVjSKQU1ETWjuWHIOiKyFQuEZ6rG2YNTKDHtbZ0sthXMMzGSMVndUOz0rpb20U;4:0WBwOAt60XrLFuInlEG4uyrA+riNNmFu3tu0Jd6c9bJjVwOmLM8QXaxWVhYC2yvxyuQoK3Xo7zbBp3ee1DGZ8FGgg6VElNqDUi5h9z09Yfj7/xOEG23aTWfqvIZNK0twPNepqWoVVCRRtzwe5Ty0fl5DFHpAHNGL5GPessRu15JgbJ6BkiCGjM2NJn+1Rhtsv6t/m9ezoFEEMm3WHpC4ES023tbDdbtu3CNMDdYk3xpvXrSzRFtN9XI4LsEcok5xETBpNxF6x65RxPMfhPa++hazOYp0kW1t9nHSNABmLbQAbE1qcXtPg0AI0F/7TqBx
X-Microsoft-Antispam-PRVS: <AM0PR04MB465872D94ECC78D0C35C5C109EEF0@AM0PR04MB4658.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4658;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4658;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(136003)(366004)(39850400004)(376002)(396003)(189003)(199004)(7736002)(86362001)(26005)(16526019)(186003)(31696002)(72206003)(65956001)(65806001)(47776003)(66066001)(34290500001)(966005)(6246003)(77096007)(478600001)(65826007)(8676002)(67846002)(5660300001)(105586002)(52146003)(25786009)(81166006)(81156014)(2870700001)(31686004)(58126008)(6666003)(2486003)(36756003)(53546011)(386003)(106356001)(52116002)(39060400002)(23676004)(8936002)(97736004)(76176011)(4326008)(2906002)(64126003)(6486002)(2616005)(956004)(3846002)(6116002)(11346002)(7416002)(229853002)(446003)(50466002)(53936002)(486006)(85182001)(316002)(476003)(68736007)(16576012)(6306002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4658;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU4OzIzOlVwL0g1RkNZL3RJM2dTUGVIRUN0RWJTK1RV?=
 =?utf-8?B?UEl1MkZ2TDlSSk1pRys0OXgxZ25ITHdyQ25GSTFkMEtpVWNuQlQrc1hJWDky?=
 =?utf-8?B?ZUxpOWl0TGtrc3JWTEE0OVM3R0lJaFRaM2tObW9QcVgrbTNXQ0xvMFFncWRn?=
 =?utf-8?B?Z202QVdvanB3cmpPUnpybUhRQ0dhamVHMkpML0o0MHBZWTc2MDFCcXlmQnZm?=
 =?utf-8?B?VUNlRVBMK1dqNS9meHRaTDF3bkdNTFd5ZHI2K2p1VEhKTnVFVzcwNVhFNWk5?=
 =?utf-8?B?S3NQWjlGeHRSVjlQckNpalBKcGNTTjkvL2FKOEJEcWpxUTJpaThLUjdkZis0?=
 =?utf-8?B?RE5JRmwvWmh1VlMxbGRpYzA5UUlIVWNPd3NoaEFVY01YdFl3ZzhDeE0yMnA0?=
 =?utf-8?B?NDFwNEV3LzVsOXArTFBPM1krOW5WQXVWNVpZeHBBS1JMU0g4M2pLUzAvcjJn?=
 =?utf-8?B?YTFiRlhUYlhUR0lsUU1INlRnZEp0ZVk4VzV4cnFDQnhsYmc0U0lpdVR5dTZG?=
 =?utf-8?B?dDZ4Y1A5RzNyQlVzZ0k2dmgrcG1lU0JPek42ZFNGSDZhdG9hZ2ppZk52TitS?=
 =?utf-8?B?Z2lRK2dXTGRKUTFDU3lWT05pUUVtMDMvckVTVnUyMk1Dc2kvcGtDRi9tMHhy?=
 =?utf-8?B?ajZBS0hwMWRJeDFXZWtFaGxyNzE1VytSdU1GWmJLV0lad1hTYnIrL0s0NG5n?=
 =?utf-8?B?cGFEek9UbmJJT280U2xMZmxwMzByL01RQU84dS9SR29wemlxR0dORUEvTEdl?=
 =?utf-8?B?ZFBYQUkxV2tYQVhJN2xjZkpKQ3VmblpMKzJtNzhMRHY0VjltTlRWeXVEKzBQ?=
 =?utf-8?B?TmFOcTNwT1J1bEhwaUY3T0JoQXhHSDFHcElFem9yMXd1VjJvZzlVb0pJMFZt?=
 =?utf-8?B?b2xIUFBsRTR2eTY2R3lBa1JFZzBDTWk5UnJjWEd1eVB3LzYzbmJXYVZTbHdC?=
 =?utf-8?B?UkhkWlk0NXFVWE54dytOOEdnbnNRb091ODlBQlpqUWRxVWR1Y2hYKzgrbWpS?=
 =?utf-8?B?d2RlczlXY3JFMGpqSGFpNHYxdVZsY1RBeVhDc0Ztd1ZkMGtQL202OEV3dmZu?=
 =?utf-8?B?ZW9OZlFzM1VHdWMydWdaUjVRWlBqT0s2R3g2eTJuajltcWVEY29MallTdXdX?=
 =?utf-8?B?a08rdkROeHlQOFlVSHROaDFITTlqUTFTaFhSK1hSSDE3ZDBtUTJyMm1hQjhj?=
 =?utf-8?B?WEtGNUE0dlFRdTBmbmNXQ3o2c1U1M1dFTjFFUE9hQ3hDR252Wk9icWZPRXVw?=
 =?utf-8?B?N0RQMlo1V1NldElEc1VWU1BVVkxDelJPUElGSFNyNFBxRkVOSEdZWG1vQU9L?=
 =?utf-8?B?aHoyREwzeko0SEdwNS81SzUrVXFrQk9EOE5FU2lLa1R4RWJrYmowUDUya24x?=
 =?utf-8?B?M2FkTFNuckdjbXpYcnVLWlVUanVBUUNxclozVTlQV2Y2Qlg4MGJSRUt6dkdn?=
 =?utf-8?B?SXp6bnJpWUdvM0xPeld6TXNMTWxKM1RHRWJ2UGJndXZGWVpZeVlaMlNwQWZ5?=
 =?utf-8?B?Uzlrd1NDdzFKVXBGbmIzQXlFZFZiZmtZc2I4Qm1GeVJidTg2dVZSYWdRVTFs?=
 =?utf-8?B?Nllxd1ZLUm5DUUxBcnhJNHc0UDUzNW9seUtSWEE5TXdhZDJqNXNubURLQTA4?=
 =?utf-8?B?UzFhWWhkSTgvQ2tDc1NnZTAyVUVsL2NpVEgxRWtwd2N5dElOWFQxcFFycksz?=
 =?utf-8?B?NEdDV1I2RExwcHJ2MktMSXpNMnZETzh5Y2ExRE1kTVlZTjJnU1B6ZjRXLzRX?=
 =?utf-8?B?Ti82UmFLRXZmUjFhY3RDQ3BOc3NIZVR4VXU5VU9DT1U3bDdiSndub1RkR3ZV?=
 =?utf-8?B?dFNJVHB0bjJLVG1qNmU3aFJoUXNFaFZpK2xFOHlzNnBCTXN0TTFHbU1sQkEr?=
 =?utf-8?B?eHl1MHBGTXB1cXBOYi9hdUZXVU9VSThlZGp4NUs5enBzTnZOMmdNZEtaaDZ1?=
 =?utf-8?B?ZkZpRmU5ak54NWgyLzJ3QXJUZ2l3QkQ0STd5SzdlYi9Xa3JoMXdGcm1CVWN1?=
 =?utf-8?B?UmFadGp0QlZsU2Rhd1k4SVFlcVpITWJCYmJwUnZub1o5WjJaeUNKQ1pJWlQ4?=
 =?utf-8?B?QkhiQVVhRkxpVXgzcjNwMlhyc0gzdFJZKzFWUEZmT05RQ0g3cHVzZk0yZkZO?=
 =?utf-8?B?Z1E9PQ==?=
X-Microsoft-Antispam-Message-Info: ku/VSR/Mm8AXtdbQePHmbk3Zum9WndWmxgU5TaWY3e3bGy/6hiy7CUXGCD9xqvkpkgraiCD+0MUBNUw+kkmhLlaYYbqdlFJJud8hE5t2RJdM+yCrGq6/OKkFZVPbs3D/ayGR20ZSjDGgMupiFqHHCFz/d7x6GsYijESFU2VZy17wkCQFR4umbZ4tDBzL/yE/i9vJBfVIl+swkGQx4uW8pZlcbjGyKrnFT15Tg30MajxULyWEd5h7nbNMvG/2YffLX49J3HNNvNCA+/m+ZboAbunLhTGuyx+11TAwpd6N5vkKXJC53YyF+wUvEVor3lQkVKNhgoyaLVIyfpj9XSvH1Cpi99QIGg6FQRBnijLu+w0=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;6:ohzkVzMU06xFf6EkcGrKzhcyAxoW/y0A1reDn6m8jivYQTMnj7mMEeMJiQ0yufB+UEJ87bwll585AwjkzozCM74a2Yv7w1gh6D7BH1vJy5x3+gRX41xbeien/bAjWPuLreovlXiaG9CrBF3fXLBnFIEBVNPTZv4TIdZWfLsHbg5l4cX4lSWimLDCfn5yoafRgwe+CZp/VK/aSqVbTKW8kKfgWLAA0khgPJsp4m9ln2Rx+5cpCd2mupyh2W8LldQXsYan1RbdJNU6jALECedpCJKeJbl7sgxz0jCAZ4stqeAzX6/zGF7UeUSk52dvN71WIadfzp3Jv1piItKjuCiRAObAG9WwmaLNQExIFKjRlKQB+gSAtpWCSQy6qgfbt1ORPcfM6xrISalisBXGO/aYWDD8IkI4RNMOvdKipGbnOP5ryHTHwkdb/nb8yQ8lKhxxGMNlI4QTVtbVubNAcInsTA==;5:av/HvGskgVciSIyvH7m0oudJv/aP2jkhAjqBomT5t74JYSLL1bmJoCuoGvHrTQsejb7RvTz73Ro5LfpaRtCM8crxQ33bhIyOZcr9YXUisZjzC/kIC16TAGZV0BMMeyx0lW4+vGemFSpnxOVEMmUt5Zt4xcG0213YiOwEL39333s=;7:VTNkyVd+tVI4YMBsB3qPm43DjOAKpgsr+LEjeBcW7gDs0yInT2y4tWXg7WMsAt+YLRcrVcu6ogdf9IaJqnTF+MNDHXeVI3nZ0bH9l4duJbRe6EM/v3S0bal8oi801VcBqQcoUMicq1kZI2/tjsZubcT5wH4mpO2c+ybII8Dg1Y85zzCAq9Lu25K4Qn1veVISiH18Eh2h1ju3jj/83brIHkNn6vlFjKzg8VCTC0SZctle6riZrbOcYwDox3RzotSS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 16:29:28.3650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e655835-5a74-4769-7247-08d627bb0f5c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.10.2018 15:23, Fabrice Gasnier wrote:
> This patch sends a uevent (KOBJ_CHANGE) on the pwmchipN device, everytime
> a pwmX channel has been exported/unexported via sysfs.
> This allows udev to implement rules on such events, like:
> 
> SUBSYSTEM=="pwm*", PROGRAM="/bin/sh -c '\
>          chown -R root:gpio /sys/class/pwm && chmod -R 770 /sys/class/pwm;\
>          chown -R root:gpio
> /sys/devices/platform/soc/*.pwm/pwm/pwmchip* && chmod -R 770
> /sys/devices/platform/soc/*.pwm/pwm/pwmchip*\
> '"
> 
> This is a replacement patch for commit 7e5d1fd75c3d ("pwm: Set class for
> exported channels in sysfs"), see [1].
> 
> basic testing:
> $ udevadm monitor --environment &
> $ echo 0 > /sys/class/pwm/pwmchip0/export
> KERNEL[197.321736] change   /devices/.../pwm/pwmchip0 (pwm)
> ACTION=change
> DEVPATH=/devices/.../pwm/pwmchip0
> EXPORT=pwm0
> SEQNUM=2045
> SUBSYSTEM=pwm
> 
> [1] https://lkml.org/lkml/2018/9/25/713
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Tested-by: Gottfried Haider <gottfried.haider@gmail.com>

Tested-by: Michal Vokáč <michal.vokac@ysoft.com>
