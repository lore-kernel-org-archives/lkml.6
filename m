Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B22C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6453A2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="cy4xGECK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6453A2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeHWQIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:08:20 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:54440
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729511AbeHWQIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm9FH6YuWjNng3rHFwQVWdL836q3nEfNN69Tki/WwrU=;
 b=cy4xGECKnlAfMWs+d83yGHjSlI4m8+GwFuPjkrSgor30GbFhRYNzD7Pf13iV1FkWmSrSkyJVWJ5wIZ/IWw062lgtoYKKd5/HUWpz8SpjoXRaMbVPB3OHyNNwWrWciSmJn+AhnVdEcsSK/fLhnl4OmYAdK+FFYI3mzOn0SBFXMJA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM6PR04MB4661.eurprd04.prod.outlook.com (2603:10a6:20b:1b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Thu, 23 Aug 2018 12:38:25 +0000
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
To:     =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180822081436.13d8f55b@ipc1.ka-ro>
 <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
 <20180822131758.162d5351@ipc1.ka-ro>
 <18b4a847-bc59-4450-331a-0b17f27c97a8@ysoft.com>
 <20180822161036.4d69bdc1@ipc1.ka-ro>
 <5b13d21c-f83f-49b0-eedd-9a4995dbd469@ysoft.com>
 <20180823131816.741c09cc@ipc1.ka-ro>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <5a5c419a-b08f-f913-01ad-715e28164731@ysoft.com>
Date:   Thu, 23 Aug 2018 14:38:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823131816.741c09cc@ipc1.ka-ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM6PR0502CA0072.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::49) To AM6PR04MB4661.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a582cf57-962b-4e8a-d382-08d608f55270
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4661;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;3:hEIPI4rtAS5g0SPXYZMrfbm5QOmPp9gOsNSz8DmJLpsh96/vqk0xTLgqM9p0fP8pMj6vTET/K395pP4iCa5/PwQslnyU7NJ5UeIn8VuuTWO1LoOXqymSZXFlNN+jWF+eZZviUkPWsQSsrJMHfSdboIuRLIpxqueh67k/oEQWWtfc6rc0XYbpAp4VAFXzpHLQaQBfc6Y48XfNH4BrrGA8Sw19coMGg+yryRSZp+im2Rmqok2nw+gqNv/h4v2JC0Im;25:Xl+lpqdV5/b8JDXeLlOqZj8YokBec2Gq/UfFNtcTEkEFIn5IkkhuPE/T0G25BbB+hPYFCEWSU8zSUJNYty0Oh8XpodWrmBR9Qb4mbnIVylu3G91JJgts9+CDoC1UMDSBtqR2Re7Y6lw6nouFP3GbL0b2ZOBxg82AOOVIjtfZP30I6pQxa4OO91xZKsd6gUsgJNXnc90Z44GXCYdCMtaTCEuwmgxlJaLmLn0IolsXD+m6STttPANhqGdZbBwhETW+745DUSxfpPCeosfUuFjbi1aZWOFkgcN9mvm+9T2OAaXLcYuM7YqBrUavEJb6iFTXGQk5hom/ieIuvTHXUm4H1w==;31:1TpBoqZbbJoBWgkda1rqY5Y/N9Hx7jIg09gBO1gaVtnj/NbVPl63Kj63h5ueZubF0XcJc211tEhenoXaXjXL6bKz3IV/njWf/X5+XlEUK5h89tQnmG2KKXBt41yFd85eRoSKYbjgMfg3szteTsGkKzks6TnMZqEZtO5LNuRFYPBd4xkj9AuKE/xMbaC0eDANyS1pDyV+pmsKDIcnVSPTq8zEPmm+e8NZweYm+O5lT0w=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4661:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;20:RdPYY3binj8m8sbdmkvWRy9Py27Xk5EwfBSJqvac3oqtQoCoirI8UYJ3fCQgzf2rgkktE3YVjtxQNdzaFh49g0WgF3CM6Fn9ynR60wHgOuzmjhCWgZqLAVFLmOMhVdK2NWcMnWC+m01zJr4xAJl60tzEOOgpEhI+LJLq4MNctxnK1/+TIM0qyA0ihst0H0gVHp276DfRRawypdiPS5IrbGSz/yJK3I2uzDzgoEWk/3Eyti1uHtZyBB65Ln22qt6p;4:Xnl8AhnCZIkq2ebMjV4xCELP8uC/6nrhNk4IL1SVJGrdxBP78ZQy0etuuFXzOnRUWEZHNtGJmeTBQDIsqvfKrp7rVHGs5HVtQ42TxQSAJPXnbV3IeFxAGY49ZkG9z3HG9CDWv04BEsy0EMYFKJlhJhCFs68c6qx5gAad+Yz1VJQyotZPKbp8T/RUlrqJhq+wP/WMW6VB52bpDpetC/q5x8JltnVwcO24CwpIQF2GfwROqMagZdw/WNm8hn27hVg1N9dRsHR/UuSakYLgrzeGdA==
X-Microsoft-Antispam-PRVS: <AM6PR04MB46617AE3991F3F4B48C1FEB99E370@AM6PR04MB4661.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM6PR04MB4661;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4661;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(376002)(366004)(346002)(136003)(396003)(51744003)(57704003)(51444003)(189003)(199004)(85182001)(345774005)(16576012)(86362001)(316002)(6246003)(31686004)(2870700001)(39060400002)(52146003)(6916009)(23676004)(76176011)(52116002)(4326008)(67846002)(7736002)(2486003)(25786009)(2906002)(50466002)(106356001)(305945005)(31696002)(77096007)(6666003)(105586002)(54906003)(72206003)(58126008)(8676002)(47776003)(36756003)(217873002)(81166006)(2616005)(65806001)(68736007)(8936002)(476003)(5024004)(81156014)(486006)(53936002)(6116002)(66066001)(93886005)(6486002)(65956001)(478600001)(26005)(14444005)(53546011)(956004)(97736004)(229853002)(386003)(446003)(64126003)(65826007)(3846002)(5660300001)(11346002)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4661;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjYxOzIzOlUzZTloZHdPOTNVUnE0bEtKVXlxaDQzbFlL?=
 =?utf-8?B?QnkzTHdDM1A2V3h5UXJTRThIcStyQ2xRcW1jY05OL0VpTTR3K3lFVWgrVEwy?=
 =?utf-8?B?OWlPNVZDbUE5NHEwZjFVWll2Sjd3M3c2dFlkZDBTeXJDRGtMZEFiVmpQUWJD?=
 =?utf-8?B?dGw1MERZQ25qMVpNTXErejJ4Z2Y5QnFVQzcxYUlMZzRYcVowVzZiRXcyRkdj?=
 =?utf-8?B?VkVjWkdRYjhzUE9VRWxXSFlxZFpUYXF1UkU0MnZCNUNvc0Z6UFRPVEZLMU4y?=
 =?utf-8?B?M3ZNbmhiUlBuTWkwS1NRSFlrdjNiaFBIUlRlMUVWaUNEUGFNWHNFOFRZa09B?=
 =?utf-8?B?NjViWDV6MC9zK0g0UW5YV2dTVWdDYkhJNFpGKyt0TVZXRXB4L1FyUGFaRUp0?=
 =?utf-8?B?V2xLb2Q5d0hmV0dMcWhOekI1Y1JYMlZZOTJhRUp2cTlEQWJLSGRJeVk2REtZ?=
 =?utf-8?B?Ym1lWVpvVGVGVnFYdjlCR2RSdGV6eEZyV2IvYmd1RkRRYUg4MkZ4OUxkODNp?=
 =?utf-8?B?aEZHenlkSnlRUTU2eThEQ0VQemROVmxDckk3RmZ4anVhSU9kOVJPemtPaWpZ?=
 =?utf-8?B?Y215Yjl6TlJjdEJNbVRDY3ZYNExSM3dmOWIrNUh5b1B0VUQvd0kyRFd5YXFa?=
 =?utf-8?B?TmlvaEhob3hVTi8ycHFrY1BibHhCYkM5NlB1bEQ2N2cySGkrUTFwWWpLRjdI?=
 =?utf-8?B?cXNHNEJNb1lleGZJcklUZzlYUUFvdGY2VGV6dEFyaG05Q2Q5RVQ4RnlKOE9w?=
 =?utf-8?B?aXNOU2RjYUppY1l1VnpKWCtDMU5IMUt4M3NicmlmWDV3VW9OSGFpbDg0T01F?=
 =?utf-8?B?YWFaaW54Zm5Ra3RRekxHTm1vY1hsN3Q5a2FSNks4Z2xtWkJ6KzdpbExEd05O?=
 =?utf-8?B?MTNRd1dpcHBoQUNiTnRRWldHSDMzRkMvUFRJbWlwUW5rWlhKUjBicFhDWkRx?=
 =?utf-8?B?UjZrakV0Z2NyMVI0UkEreWMzSkQwbWl4U3M0Mkl5dndYYVJObGtyWmVEMGZq?=
 =?utf-8?B?T1c5eFQvZk5Jam0vQnFVaGlxNnhxa0tGd0RlRnh6SzU1NUlIQnBuNVVKcUN3?=
 =?utf-8?B?eEJ5eGU4cHNqVnJzUlVCWEI0cS9XVFcwZHdhdGNIcDd5SHYzblVrcENZdkdx?=
 =?utf-8?B?c0cyMzZ0cTRHeEJsQkRYbkp4VmZjek4yVEVsaDVFZmwyWjZXaXBVZmRteHNn?=
 =?utf-8?B?VXF6Q2tDd3Z0Z0oxYmc2VVkwSkJ4VlZNYnJ5UzFUZEZMUC9Lc2x3Z1NrK1k4?=
 =?utf-8?B?cHVWUmtwQi9URjU4VWR1V3BCV1RZZGp5V21mNG91Tm03MDZLRzJzSVA1RlJR?=
 =?utf-8?B?d0F3UzF5UFdvZkRDQjZwN0ZseEVmc2JWS1Z2TjN5VkR4SmdON2lCcTNqWlVD?=
 =?utf-8?B?a0dHVmdrYms5eU11TVZBQ2xGUXorbmxqaFJjQkFpanlSOGxNMHNYWGFCV0ZF?=
 =?utf-8?B?eHBDQ2N2RnBndlhPNjVnZWRCbG9kZXVjSnZzNXA5bWJyT1o3c3BCU01ZWTFr?=
 =?utf-8?B?Mjh2N20weUJqb0VOYnZrUklxa3ZWdmtoUlAxTXY4dFV2QVAyWnpMMDA5VWRs?=
 =?utf-8?B?a0k5R0ZmMUtWOHVRSEF2SzNaOU9ENzFydlM2akFJaWhQZE1wVmlFNHJVeEJy?=
 =?utf-8?B?R2U3bGtSdGJmdnhCWm81QkFWVVU5YjAwaG9Ycy9lWGwyeGtGaVlVdXd3VWxB?=
 =?utf-8?B?djlJakFBaEJsTlczZFIvTzhCcVA1Z1JRblUxMndJVFFpU0F6L3l2ajF6YjlD?=
 =?utf-8?B?ZHV6dmFqUVpHaXNKbGRlTmZtRy82aE1ZdFJEMmkvZnJnRCtTQitUQk4wL3Ns?=
 =?utf-8?B?UGpRYk5lRXd1Q3YxQ2Z1RFNvM1FLb2lmVVgwMXY1SVptdmNmSDFaakRyNGYx?=
 =?utf-8?B?U3ZNcmVWSTl2TlVsMzYxQk02ckI0WGpNTWVrMnNuZGx0cjhwSi8zc1RDOHg0?=
 =?utf-8?B?SjRhdDdyaGEyNXp4QXVIMzg5UURqa00vdE5mNzlodGlFMGZXN2tuK3hDNUJE?=
 =?utf-8?B?QUcyb3hxQk9UUXVRdUYydEc4cno0eEx4bWhnbTIralZGZGE0eDczOVEyOGZU?=
 =?utf-8?B?UnhPcVYzTVA2TDUzSFZkZ3dkcnh1dXRhbEZsUFNOOTRWTUpueWlwVzVPdVd4?=
 =?utf-8?B?YkNtby9yS3BlZEVENTVCMmFoUC81K3pmVGkyZTZhY0NwMythMXZOMFRqYTVM?=
 =?utf-8?B?YklRZXIrQzA4dWw3cm9ReitNVStWRUJsTmNzV3JOTGJPMy9FKys0K20yS2xu?=
 =?utf-8?B?VmNRUk5XRExYaXNIV0lBQ01RNlVLYVcxSUJ6RDNCNW9DRCtIQWtqZz09?=
X-Microsoft-Antispam-Message-Info: DuCPJ2moKTzOxKdMF1LHEiVU/L0vktsDDxprMy9iimoXckGTvyktXAOaYKA0cpnQc14Z5cDUwbfBRKpIOKPWWnH/HoHi13+XSlWw2gTyPkVYTDpcyz4FcIgYI8f57gVYn8/4qxkdh8oKb8+TUn5i51LYpmr1BycF9BlsD5W+68SwWicpsuY5W44MiTVnDYFzXRFIVbabkjpWPTi68svv8NzZVPFzL/IjqLFCXpRn5dCVCuoxfnjqFPVP6nvVklbEu5jV8q8YR9OUi6eYaBqv/53OIusnM2iPEtXfN4qMJ7FciAHRy+XhRk82qr8M1eN9ZbDGW3smxJ2IfJI5G9LprFaZifrBGQ2ex6nLXN3qz28=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;6:BbJymdqz08csb1FshNWBy0+rY7zCmqXKtyBv2UW6PL+Ral/g60bkQzwCtC1EfE0B7LJMkHW1oSEg0xeMp9xiR0AZiYUD0dTZA7ebSTOwTOjKmpiaZUteP8pDIIkSukfbaT7fmmYf+2T7l5G/3HvHIuRYvxLS6mlNUcngL4ietKR9PNVAuhRtKZTYi9ByJ7JnbE18Sysam866JREKw6SaeGEW0aGImQz6145y8QG5i4KB2lkCunUBoHjyguyEy40fyALfM1s6/qVyStRKtNh1PJy4Gs5IoJIJvRxZYOjFnfMtrMXrxNCkK1ym0444VEoj/tRBWf/IhBC0IIU+J8sG7pyLvlw9gl9pFeQVTTjSh66WknfZW0a1DGem0B1HxTc4XU1IGiKRpOh6r7Cb0fYJdAiWQQKUC/D1g4w6off+QARyNCUqIvl5e+bnp9w+jNobdt6jZ1Zi0RHOVrjM/7lnRQ==;5:RVhTSkjHseXOiucn1BBKy+iAvxcUME4kqthXPRUyou/2cC53tZCMEzw0kf4VQWM560Kae8UDBeRD14DCQuJtwGKcIAwereuB2Up/gkCUhOhiDgJsFGTjiuDYT576pIcFImuyo/HVIkZ0BnUyQaUn5DaV7rqXuUrKXtdNPPrY+5k=;7:x8tKiFcvXfpMN3z6nqAbligdYJVM3SRUS0Mk+EG1QmwYE5saVMboR51CQCpfWvfDcf1MzlL8Grra/24F3lxtLTjgSNVT4cB7L9+/iZ4tFRQR9J6rpY/FGF0aFrCIecUuvJtY+NBfqpUti/LsRCivMGkzSwuc+GXV4pqszjqISggHR769BN1V4HKFIKwxjj27OAkLsjGpNl5VrbvqCG92hjoQIfH501comFAjC3hDY14zGf+CoKC6wmhOPRMaapVy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 12:38:25.9237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a582cf57-962b-4e8a-d382-08d608f55270
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.8.2018 13:18, Lothar Waßmann wrote:
> Michal Vokáč <michal.vokac@ysoft.com> wrote:
>> On 22.8.2018 16:10, Lothar Waßmann wrote:
>>> My use case is attaching different displays to the same baseboard,
>>> where some displays have the brightness control pin inverted with
>>> respect to the others. It's easy to change the compatible string for
>>> the simple-panel driver and the PWM polarity setting for the
>>> pwm-backlight driver from U-Boot according to the display model, but
>>> it's not so easy, to edit the pinctrl settings from pull-up to
>>> pull-down or vice versa.
>>
>> OK, I got it. Though that is something different than having two clients,
>> right?
>>
>> You do not actually need to change the pinctrl pull-up/down configuration
>> in bootloader. You define the two pinctrl groups as I suggested in the
>> example. Or more precisely, you add a new pinctrl group where the PWM
>> output pad is configured as a GPIO with pull-up. You add this group to
>> all your common device trees. This does no harm as the group is not used
>> yet.
>>
>> In bootloader you detect the type of the panel. Normal PWM polarity? OK,
>> do nothing and boot. Inverted PWM polarity? Set the pinctrl-names property
>> to "default", "pwm". Set the pinctrl-0 property to point to the GPIO group
>> and set pinctrl-1 property to point to the old PWM group.
>>
>> E.g. something like:
>>
>> => fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-names default pwm
>> => fdt get value gpio-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-gpio phandle
>> => fdt get value pwm-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-pwm phandle
>> => fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-0 ${gpio-phandle}
>> => fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-1 ${pwm-phandle}
>>
>> Will this work for you?
>>
> This would probably work, but it's quite ugly.
> I'd still prefer to set the pin output state to the desired level
> rather than relying on the chip internal pullup/pulldown facility.

You mean like actively setting the pin HIGH or LOW using
gpiod_set_value_cansleep()? I also used that in my very first prototype.
But even for that you still need to define the second GPIO pinctrl group
and select it before you can set the GPIO value. I think because this is
all meant to be used only with inverted PWM output you naturally configure
the GPIO with pull-up. So you do not need to actively drive the pin.
Is your concern that the 22k pull-up may not be strong enough for any
connected circuit? IMO the whole point of totally disabling the PWM is to
save some power. So I will go with just the pull-up.

In your case you also need additional xxxx-gpios property that describes
the GPIO. Actually here you have one more option to invert the logic as
you can specify the GPIO as GPIO_ACTIVE_LOW or GPIO_ACTIVE_HIGH.
For inverted PWM output you should use GPIO_ACIVE_LOW. In your case you
will need to tweak that in the bootloader also.

The final DT fow inverted PWM for backlight will look like this:

         backlight {
                 compatible = "pwm-backlight";
                 pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
                 brightness-levels = <0 32 64 128 255>;
                 default-brightness-level = <32>;
                 num-interpolated-steps = <8>;
                 power-supply = <&sw2_reg>;
                 status = "okay";
         };

	&pwm1 {
		#pwm-cells = <3>;
		pinctrl-names = "default", "pwm";
		pinctrl-0 = <&pinctrl_backlight_gpio>;
		pinctrl-1 = <&pinctrl_backlight_pwm>;
		pwm-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
		status = "disabled";
	};

	&iomuxc {
		pinctrl_backlight_gpio: pwm1grp-gpio {
			fsl,pins = <
				MX6QDL_PAD_GPIO_9__GPIO1_IO09   0x8
			>;
		};

		pinctrl_backlight_pwm: pwm1grp-pwm {
			fsl,pins = <
				MX6QDL_PAD_GPIO_9__PWM1_OUT     0x8
			>;
		};
	};

I think that for further effective discussion we need to wait for some
comments from PWM maintainers.

The main questions still remain:

- Is it acceptable to use pinctrl from the PWM driver in the first place?
- If so, is it acceptable to allow to use the approach where GPIO is used
   as the default state and we switch to "pwm" when needed? This produces
   the cleanest inverted PWM signal.
- If not, we will use the "gpio" state as the second optional one and use
   it when clients disable PWM.
- In both cases, can we rely on internal the pull-up facility or do we
   need to actively drive the pin?

Thank you for your time!
Michal
