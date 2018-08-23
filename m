Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A7FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABC82152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="LJdTJGKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABC82152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbeHWOu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:50:28 -0400
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:34183
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729387AbeHWOu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXE1H2PWx8LJpMcHiRwH/L5/sCipKFkeQUhqLZxUx6A=;
 b=LJdTJGKFadL1GQy1ROy6E+pa5d7OfS4gQPw/FZUVxXADozDCKVxX7cZSYPYaFEDj0sAXl6e5u8QgqzegCSplUsfUW4xZ2YXjQWbnQLJ2Ej0R7zX1EskHqjsstVqS+oeibdAyFeozBGQmhLnCmfjQV3RZ4r3SHIC/a+fxsA8P4zQ=
Received: from [10.1.8.111] (89.24.100.190) by
 AM6PR04MB4662.eurprd04.prod.outlook.com (2603:10a6:20b:1b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Thu, 23 Aug 2018 11:21:07 +0000
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@karo-electronics.de>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180823123759.68b78e9f@jawa>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <0691e93d-c2e2-21e5-374f-c29e7765de93@ysoft.com>
Date:   Thu, 23 Aug 2018 13:21:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823123759.68b78e9f@jawa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::15) To AM6PR04MB4662.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad3ff22-9da4-456e-5fa4-08d608ea8603
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4662;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4662;3:PV4keWPEOz5lcGny5wJAQGL6jhWpf5DXAf+YaVEaofJTZ+HgrhZRq/W7BlITxQJoD1KPcitV4jxmzYrwdYhmWoShcMqSsodFDKPAQsstbhoRnfLUNW2gxpExfg3efMqgnGi+Os3VuHDZNtF0J0hzpXDgrLMXR76Jj8r6WhbyvadJqWsm02TiSFEcrDc3AExrxwQhFpLXxLYB+zajoHOO2cJvrQoSyhT4ssRK6PBB6asyzSv0cKVPEsttmS/u21VS;25:15b/LE9z2SBhugp3zlZ7INfjCx61Xnr6F/ln3jkPWk5tX8/L/nhvNfebzAwOQBieHq2RSEAQm75vFn8/73hwfUPskp0dvbENdra+RWpvgnra/OcpXH661H1QdKq+hdqlnv4f7NMVAqXvxqLrhoRmt0ZTBNDxi9G/PJY/fNfMQWNp4teT4GnJAl0hlzTKmq8KQTr3EnwuJFEBN4iUjA4cvNT+2Nhf3Qa/QETSyTTUpdfbIMIEu8pHrnIVt8xLYngAGa4CfUKBfOGfp0eo/cz1PDnUmYcTB2j1f8kbJawrePMjb+AjVpGJf88mk8XSfxK0yTDH1a5XemB3laazChFpCg==;31:6dRE+G4t7MDxSBivdFkF5NJMSyBMGxANkkNl8L1muir+FnlAVlUef8npt8RTng64M+rhzoBWaF/Wm7qtNapfnW31Vixcb4kxpvz6t8bDGsjevs9fFfRYD8wb9d+sSP1c1OeAR5AsNyB1mNTxiE3qyM6Eht+AF9inePnEJJYNk95rXKz5sS6W7EyyQVKQmxuqs2QW4Vs6z9xOe1GOCgVrrtKjE2mqSU+SJenNajU/9FU=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4662:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4662;20:8ybpG1yaUS3Y4v3B2Lb+8FqOUCWUwXk6FVoXxUEHoCRCReRYn/SzttiI9uveravta1/HYGfc9WoHFQkIvCjHkzALTgjnxO5n7UkVe38sMJDvEKh6Ou+JO4EnXqdC0/aV22jcf0+gIO00R2DaCPq1R7Ka5FMpk9Wme/MKlVubHgBXfmVxY8SkJt/tv6/TA9bTzaB9lfxHKMiPE8jsxK7pwFGdp1gQ/qPcrJZpKL6GtEW16u0gZJQ6y4WSSfskHreC;4:pkwFfH3JEw8wWdwwVpGJXyo3YjEKGHDx2E0JuxEW5Wo0NvSXfjOj5qniLUUSz/IaqlqlxremzjqsPUpC1jd51a9TaxQhdWQmhecr0sLSqn/KDvnAwz+rMgzDUhihsolXWa9KjP3lST4nQugunxZsWyMZNNKIyJGo6C7mgXnThPCAppKmxMpjOXd4b2j3Kb0ZN5lROvzvCd6pIRvDH/57thje2NK2jP5udrzKN/CjeqJf7DwcVSjUNBL4q5Ff3rYXH1Zx7NrUnJdlWf/gCBqeRw==
X-Microsoft-Antispam-PRVS: <AM6PR04MB46625C683CD6B74020A06F899E370@AM6PR04MB4662.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM6PR04MB4662;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4662;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(39850400004)(376002)(346002)(136003)(85664002)(189003)(199004)(51914003)(6246003)(16576012)(6916009)(305945005)(85182001)(52146003)(217873002)(54906003)(8676002)(6486002)(58126008)(31696002)(5660300001)(50466002)(65826007)(81156014)(81166006)(25786009)(65806001)(23676004)(6666003)(39060400002)(4326008)(66066001)(65956001)(47776003)(76176011)(86362001)(7736002)(52116002)(67846002)(2486003)(316002)(14444005)(478600001)(26005)(53546011)(106356001)(31686004)(64126003)(72206003)(6116002)(97736004)(186003)(53936002)(3846002)(68736007)(16526019)(956004)(2906002)(386003)(2616005)(2870700001)(105586002)(77096007)(229853002)(486006)(36756003)(446003)(476003)(8936002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4662;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjYyOzIzOklRc0RsTmF5alJvdzdndHYwUzFzQUVyWHJa?=
 =?utf-8?B?cVFZRVBSN3RIWUxNSHVmOVQ2eFZLQ2N6eXU1OUFPeDAxdEpmcHBvZVVIQmVN?=
 =?utf-8?B?aXpMRzg4NkgxeE5QTU0xRlc5THZSVGdsdGhKNXFqSiswUHdPR2tWVlRUTHVn?=
 =?utf-8?B?aldtN0JPbXdGcUdNZGdGR3hqZWluR202S0ptN0ppR21xVUU1RzZjVmR4TjZL?=
 =?utf-8?B?UG1ZYkgvV296WHRMSmhhcEVtY0hucnVpcGNKZjE2ejhWejR1eXkzbCtiQkMw?=
 =?utf-8?B?ajBYdE00OVRxRWdFTC9sVFFxMnloZUszUWpac0tDYTUra1N2c0xRNkxSdXZh?=
 =?utf-8?B?M1Uzb0Vqc1ZRQlNRaWJEMFg4TVk1NTRvMGdVTW9PTGY5ZkVMSzROQlppSlZh?=
 =?utf-8?B?eXNJbGJRdVVWdUtFdk04UTRmTGpRRTBFampiclRtR2pTRU9YUjJnNGE3cE92?=
 =?utf-8?B?OFRvbjZqWXhNSGxzNUx1cTBoV1FhSE5SVmpKR0N6WFN6NzNaM000VS9LeWhP?=
 =?utf-8?B?ZlA2YVFBc2ZsWVR3aExpN1dLa3FId0xQZHZ2UDFoVXNmYzRVdkF1RjhURHY3?=
 =?utf-8?B?YllVRkFSQzNDaERQNTQ0VjBTTWRjbFVxUlR0TnF5ZnRsb1FhdXpZREVzOEhU?=
 =?utf-8?B?WDFXNHc3K3ZxMzBaNGJ3cGhXWkxTR3psejFod1NveHZTMG9KR2h6Vis2TElu?=
 =?utf-8?B?QVdlNnQzS0VSQmtnYWtxM0w5clh1R3BLRGFqcnZDdUJnUE93M1JNcEd3eW04?=
 =?utf-8?B?blgvMHRTR2FZZWM0M0tOTWh6UFhhTFh4bDdQL0tIc00wNXIrOFpYbG1FWC9X?=
 =?utf-8?B?eEJiLzlwR2wvaS9Nc213VkowNW5IbDZHQnlHd0JKQTNxa09oTUhtY3ovL1l5?=
 =?utf-8?B?K0haeHVBYzQzNlRKamxrcjV3cTZFbmNtOFp5T0p1b0d4TytVbEhZVlIzUERl?=
 =?utf-8?B?MHR1YWN2NkNldjdaaDZXQjEyK3JKNHdmMFM2d2ZUeno3UjQyd1U0UmxoNTdZ?=
 =?utf-8?B?cWM3NEMzb3dlZ0FjUXlaK1ZGeDVwRzZpN3BsUnJrYVZlaFhLYjFkWm5qeGNS?=
 =?utf-8?B?V1BZTW9pdmdCdnBzNWhPOU1KWjZFMUc4QlU3amtYVkI5WkRlVjBUTnU3RDM5?=
 =?utf-8?B?SGFobCtrR0VUakdRQk92M0s5c0F0RWtSU1kzQVN2aWJtd241NEMrTTY1MXNP?=
 =?utf-8?B?SDRaU1dyRjR0Z1JjYzdKclk5M1RxQ0RoYVBXeEhvTTkzLzBlN1VnOGYyVGVN?=
 =?utf-8?B?V1JFYVB5bWdRdDdEUGVhenlJVFRJY2tnKy8wQnF2ckZMTnpnU2pnRWU5ZjJR?=
 =?utf-8?B?YU9yRE8rQmxjSStNdHhWOFRselpXVlhjeUhFeG1EU0xuSUNvc0tMWkdQUlBj?=
 =?utf-8?B?U001OFl5K0tQM1MvTHBTQjd2L2ZGNmFUWGF6UXlDTkJ5OXg4TXFNMnJhRC9D?=
 =?utf-8?B?aUt5SHJQU2xidGszaWhXVkhTaHROcTE0RG00aUgxNEJ5MWtER1ZRekE1MENv?=
 =?utf-8?B?ckdrSlRqckxZYndLWk1wUEpEVnhTbTk4Mk4vK1RUOVlocTgrZ2c0eU1tODFN?=
 =?utf-8?B?eUdGdmd6QmhuUlZhWHgzK2JITXA2Q0x1bFpVYUFUUkdJM2Q1QitzZzdiNTdD?=
 =?utf-8?B?OVVUclJWSy96VFRVRno0VjVqS1lObnJqRnJGRVk2MDZqZ01idDlTcjAwY1lI?=
 =?utf-8?B?cXg4a3BHejJ3VU5saElFdkg4N0JpclM4SXVmS0JOQXJldDlTK2hyeFRQckND?=
 =?utf-8?B?WGdqSk5oYS95VExzQ1JtK0dQRmRiZGtXOUJ6YkUvREY1andRZ3U2SEJKUlAw?=
 =?utf-8?B?MWVVUjc5RXNkYkxSb08wVm9kMlY5dE9kazU1aEp6cEZWZW4yRFRqVU9kRlND?=
 =?utf-8?B?Q096T3JRYkFQbzFJUm1kS1ljWkJsb0JRb0phNFhxWjFYTi9jL3pxUFNBR0JZ?=
 =?utf-8?B?MUdUL3dZM2VsblNCVXhla3RRZkFudW1wSFhKUnp0Sjk5Wms1TEVNbUtxQzRJ?=
 =?utf-8?B?bHp6Y1NNTzMxeGxIdmM4TkloaEl3OG9yRmgydC9Pa3dXc3FKT2ZjeTFyTDZv?=
 =?utf-8?B?clg4QkcvQkhQRm1yK2hwSktyTFNUbVdIV3JaWmk5WjVPRzJWVDdYSFprWHN1?=
 =?utf-8?Q?2wCOpXSrwyUhhiXIt3rwfeM/DEDw31UYTGNKsF/Uu22l?=
X-Microsoft-Antispam-Message-Info: u1k7UrSW+dvx2W5VO88BnUQrSMxP9TWlhYtpeu4QhHu2J4C9EAHPA52nu9i6wrZIZ/VXoDHO5/1t+p5aw22b4H//6gqcDCPQr6siE14GhbOS14BWrL0PRDPAjjpocsELbqfvxtBCDqquOupgKLFowo2PeO4Y3LcZptEbvXHxbWfJpBpGe8R7Ssnw9UczQmsTozk/qHdq6UAvUOBmIRb64e3NsyirIvhZVRBs2blXXRqyHEc88JHFK489bi85dQfvYiP2swJIJ74EGyJl5lR56RfcPukzvQVrF5POMa9tkgCiUqehXGzPExMMgICEcRTbCOPYQw387WG7qbQK0Bl5YNUs0nWYmgclzA+MwExBoP8=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4662;6:xdHGViUb4PeP5NcKeGiC6wsTZaZ/K2ja9l2rYx5U2xpKrAW1xC8hmf2kraIVrBnqbvaKc75eTG3lRE3WSa7Qx5vTfR6ONHOvHUGVWKgPZKfVJtUgrWYLBDQj2mGybZtpCyVk2aoThu7UHJNH9IhWYCd3ubYeC9boyd0IwxOxHYlrvpZQuJ7EZdr7M3563R7dsCgGc/htRl8EQqbMDoJbQvKRNVCUefoEM8LiiVXsiQupMI/eieaIoU2wWJYb/kGwdkDnmMOPGi+NI+g3rCFfjiF1C4Lo5mUwqY2Za1iB3JEtwZIwx/Jm0Cqh/f3Pi6YNU3xldyMvzifQ+xR0Z7qiJPgqUhcHRRCQHQ9d4dyjIbPDfwuKFMDU3RuvOrRdjKSfjRKZUGgaFgZAzCSPR6jccM6BdT4SHyZWnU1X9pJiwOherQJPC0foG0+G0lfSEKBAAT17U83lhbTKy1Ek2osqtQ==;5:+hsmTTzE78LFYKMgtUeWsNlbHd+qGRr4swY1+cbU4s5XDXl+qWr0OFDsVq+QTslOZ64KRgme6AK7EcL4z5KmJV87XqFJ6TXHPVLx1kZcB884SLSgxlXUeCCIF/ep6QkmdEdtaRuV1ooRn7/0dSKfQXVgOo7sTcMGri7GaUQo6wM=;7:9zrS2CwdGun9b74egS57/m+QKruI3ot/CuKITX1InVHW43U3YBhREYm8612lak8b06mCp/0wQmKhjCvvKA4DUvnu3kmJuQClJSOqf1tdwSldYicesHSIghwuxOugEKCQuqy8uY6Eu+MH/JVvXKSVDdHLurJjIuPc6Ockzig75hCruFat9XCrOLOOY1vgptFCXSoFNSBmduc68Fbfjf4u56qSanS1L7XEhZLULL8X7suPOIbitfMnNYyduWN8nmk2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 11:21:07.9022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad3ff22-9da4-456e-5fa4-08d608ea8603
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.8.2018 12:40, Lukasz Majewski wrote:

Hi Lukasz, thanks for the reply!
> Hi Michal,
> 
>> Output of the PWM block of i.MX SoCs is always zero volts when the
>> block is disabled. This can caue issues when inverted PWM polarity is
>> needed. With inverted polarity a duty cycle = 0% corresponds to solid
>> high level on the output. If the PWM is dissabled its output
>> instantly goes to solid zero which corresponds to duty cycle = 100%.
>>
>> To have a trully inverted PWM output configure the PWM pad as a GPIO
>> with pull-up. Then switch the pad to PWM output whenever non-zero
>> duty cycle is needed.
> 
> Just to ask - Is your display equipped with power supply enable/disable
> pin?

No it is not. The backlight on my display is just a bunch of serial-
parallel connected LEDs with separate GND and VCC pins on a separate flex
cable. And the display itself also does not have a reset or enable signal.
It is a PITA to use it I must say..
  
> As fair as I remember the trick to avoid flickering the display
> was to disable the display (enable-gpio property) and set the PWM PIN
> as GPIO to high in u-boot.

Yes, I know about that. I can not use this as the PWM output is the only
signal I have to control the backlight. I mentioned that somewhere in the
previous discussion with Lothar.

I also think this could be useful not only for backlight. Any circuit that
requires truly inverted PWM signal can use it. I see it as an enhancement
to what you with Lothar have already done ;)
  
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44
>> +++++++++++++++++++++++ 1 file changed, 44 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt index
>> c61bdf8..3b1bc4c 100644 ---
>> a/Documentation/devicetree/bindings/pwm/imx-pwm.txt +++
>> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt @@ -14,6 +14,12
>> @@ See the clock consumer binding,
>> Documentation/devicetree/bindings/clock/clock-bindings.txt
>>   - interrupts: The interrupt for the pwm controller
>>   
>> +Optional properties:
>> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure
>> the PWM
>> +  pin to gpio function.  It allows control over the pin output level
>> when the
>> +  PWM block is disabled. This is meant to be used if inverted
>> polarity of the
>> +  PWM signal is required. See "Inverted PWM output" section bellow.
>> +
>>   Example:
>>   
>>   pwm1: pwm@53fb4000 {
>> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>>   	clock-names = "ipg", "per";
>>   	interrupts = <61>;
>>   };
>> +
>> +Inverted PWM output
>> +-------------------
>> +
>> +The i.MX SoC has such limitation that whenever a pad is configured
>> as a PWM +output, the output level is always zero volts when the PWM
>> block is disabled. +The zero output level is actively driven by the
>> output stage of the PWM block +and can not be overridden by pull-up.
>> It also does not matter what PWM polarity +a PWM client (e.g.
>> backlight) requested. +
>> +To gain control of the PWM output level in disabled state two
>> pinctrl states +can be used. The "default" state and the "pwm" state.
>> In the default state the +PWM output is configured as a GPIO with
>> pull-up. In the "pwm" state the output +is configured as a PWM
>> output. This setup assures that the PWM output is at +the required
>> level that corresponds to duty cycle = 0 when PWM is disabled. +E.g.
>> at boot. +
>> +Example:
>> +
>> +&pwm1 {
>> +	pinctrl-names = "default", "pwm";
>> +	pinctrl-0 = <&pinctrl_backlight_gpio>;
>> +	pinctrl-1 = <&pinctrl_backlight_pwm>;
>> +}
>> +
>> +pinctrl_backlight_gpio: pwm1grp-gpio {
>> +	fsl,pins = <
>> +		/* GPIO with 22kOhm pull-up */
>> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008
>> +	>;
>> +};
>> +
>> +pinctrl_backlight_pwm: pwm1grp-pwm {
>> +	fsl,pins = <
>> +		/* PWM output */
>> +		MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
>> +	>;
>> +};
