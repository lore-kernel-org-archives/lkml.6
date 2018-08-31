Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AEFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CEB20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="x/hVABpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CEB20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeHaR1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:27:49 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:18528
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbeHaR1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTf/ZEItmWZM2pz/ihBrMr/PjTC6fmcA0KJSvh/dAaE=;
 b=x/hVABpJWpMfa6a0orRYMwJNvdpI40LGbWl70FECkS+3Mfl1qsydcKTcUhJhr3NOgcndWjPnoBmst0HMLL8R6D0KFVjHIXzar4zgFj1kAx9eW1SvSWctcL1krVHCSsy8o4spHUloF8mPTlG9/g4//cy7XrIQsXQPbVCwNGVBFT0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 DB7PR04MB4668.eurprd04.prod.outlook.com (2603:10a6:5:37::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Fri, 31 Aug 2018 13:17:13 +0000
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
To:     =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>,
        Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180831121809.GA22507@bogus> <20180831144548.26b1204d@ipc1.ka-ro>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <64b731c7-aa24-7738-0076-8520f6b9a495@ysoft.com>
Date:   Fri, 31 Aug 2018 15:17:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831144548.26b1204d@ipc1.ka-ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM6P193CA0008.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::21) To DB7PR04MB4668.eurprd04.prod.outlook.com
 (2603:10a6:5:37::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b276bd5-479c-49e8-b5bf-08d60f441150
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4668;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4668;3:y1Nblcye1puimKY+X++mlKF7CnULT02DVz8s8VSraldvVeXJBsSJtMz7b4V5tESLmnu3HeZiHQ1mHDBYyKz/frIOVuhncS+9D6TrKVXpbD3DnvOaGH1+r+aNUftsR72amuEX30TT16VwBGUnMncdtb6u6gghk/dq14N+Q4BpUPU5Wg+G7HB3Vv0JqEXnxFsXclItMkSvqv2QwIjNqgCUifuHw1gBc5FyIBl1BCCRAI/NFvLWqaHGwmlyC9XWDRPk;25:9VTDPJTNUPJ0+DPaM9+duloF708LGE1RfwjHVIiWXifPHz1eIyLJoDRe53qwbQ7BzXoJgi2Sh510q1AcCDFKHx63czW1tJiQNpCXaeUNVowUvsbmtIPiD5o9X80pQXnPRW5v0cTqQ5czA7kT57K7sBDqKvsIxsMup01Tnvu/8c5j5NRtq+ZOKspfWZHLx3gkjan+RR5WlMwI36z8fKKa8t8cHYEWWIfDfkr3eA7KJ6ow1/lfExuSop7RPalHTwcV5RDs2GRMwuuTvUqNUByD7DwLZdDzESJ/um/KxK+qqVYG6yKg8nlHxVwiUPdh7vdoTfqKhzX6o9Wvpv70tVJzRQ==;31:SIDuTsUUDeO4dlJFgs+gFz9btTwll5h0399PHTLEC6d27Vnt3163t3WAkJVXkMmcn7iQE8gba5naFqvie3ldJWH73daaqAmZAECNyS1HrEsO0Jbrwt73x9IbqKb+IzNht4v6RYu7jX2zWsEdgCtifJf2cBN9LmZANLQBSgylH2q6MzzjjIZl8SgKS7u6DzilKwFdgRn9tBkTJueY6eRMXYC3ov3WzibehAMvnVIvz7Q=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4668:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4668;20:F7Xfk58AqnlYw+XC48fhb8mji+MKM0GQw/nsnETTfLpt4dLuXMvn8cv0PdZ8Twa98VKAuCAJnb5sPbqrkQAWoJWo2dNQQLKSBCFpOE8ZLQkrMVueFfWty+TxRf7VwMbLKhdBRe+nM0j41ROPCrpF8FtHreKhCGPPVX+51AkXWCOEJtxPdtRoNW+Vawt5R7Nx9PRwtiGLt2muCD+u9glLbsUTEbJcAEBx8ZPJIzbA7+Hf7+pi/ANd5CNHLWxMZwmD;4:cSEV0SemkybWdau49l5+JOg9UTgT0D6512zGXmkzNMWHUFugrOa8IBR3FPkOoelgnIsbcZEx/JaSg+tiLZdPYX7iNBf89gYS0KOcyU9IqAGZWO9tebUUOxc4q0vWy5IHTan2TU9FNxBxGLntyUNNGpd+/kbwYe9rKqzNWz9CnX0oeMC/aKpmMdvFPkzY1ZRE/x9d8wnxfLTDSri59p97U7zUfbbpopH1+AJqKaOLuErAWGTDdoUTjUQoBvf1wdiVjGxVnjxDmEzN897OAaARPw==
X-Microsoft-Antispam-PRVS: <DB7PR04MB4668D743062045F90CAE84769E0F0@DB7PR04MB4668.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DB7PR04MB4668;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4668;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39840400004)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(106356001)(105586002)(93886005)(86362001)(31696002)(50466002)(76176011)(31686004)(478600001)(72206003)(23676004)(52116002)(52146003)(2486003)(58126008)(110136005)(316002)(54906003)(16576012)(67846002)(6246003)(2870700001)(25786009)(39060400002)(2906002)(64126003)(4326008)(65826007)(5660300001)(386003)(53546011)(53936002)(7736002)(97736004)(305945005)(36756003)(186003)(16526019)(68736007)(8936002)(77096007)(217873002)(26005)(229853002)(14444005)(6486002)(6116002)(3846002)(65806001)(66066001)(65956001)(8676002)(47776003)(81166006)(81156014)(2616005)(476003)(446003)(11346002)(85182001)(486006)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4668;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NjY4OzIzOlFmd3ZYWnV0L1poRGNMK2pnSUlmV0dHSVNY?=
 =?utf-8?B?alpnRXpxb1hWaTU5S1dTb1h0eGQ5S080cEN4SjJpd2l3VGFvYmczWnl3WFRx?=
 =?utf-8?B?R0FvQ21TSEpHYUpjU2JHM1k2ekEwcmY5dUtRT0NxMmxMelo3WCtWOTFQUHBl?=
 =?utf-8?B?UWVZVDl0U3VqeFN1Y0tSYWhTbE1DM2F0Vnl4S083WkhlRGpvYThnUnVPc3BX?=
 =?utf-8?B?WGNOMHNZc1lnR3EzUzhFdkFIRVZMWEFQajRmU1NSU3hDUHBsY2FGbEY2aXhQ?=
 =?utf-8?B?WkR4M1B6RW04Y1BYMXduNlJGVUFqazFqbWlJYzJscFFzZjRMTUhubllyek1n?=
 =?utf-8?B?S3JrczMvbVlRTlJOM3VYTE5tNnRGQS9oLzN0cW0zUDB1OUhGY3kyeitkbTlU?=
 =?utf-8?B?cW1mWi9lNEI2SWc0UGd4Zmd0TXJpcFlrT05JTkNMalBmQm9xZHd5bU0zdEUz?=
 =?utf-8?B?dndEaWJyV0hjS1hPN2h2Wm1WeU4zZXFRdEIrbU1Vc1N5dDJlcU9FRENhbDBC?=
 =?utf-8?B?aFQweUQ0L25jMmRYRGJrNldlMHhyN2UvVmR4Zkwra1lkaVA0ZTVrTGhRSnVL?=
 =?utf-8?B?OFZuQmtrak8wRERoV3IzOExrWDNpeDkrUXpPL215Z3B0djhmc2FWbiszdTRK?=
 =?utf-8?B?ZjlycDRKRklUSm5NR1BCUWF5bXU0MjlNVUh4VjVSQi9yTE1wTlVvMVc1enF1?=
 =?utf-8?B?VWN4c0tvUmFjYll6ZDFYUU11bUE5bWpkcFhyYVJBcEdXUXdReDZhVzM2KzZo?=
 =?utf-8?B?d1VmUmRsK0lQdXNNcFFhbmxEQU1uRXAyU0JMcCtzOXlrQTFIUWJTNGVXUENU?=
 =?utf-8?B?Yy9ML1ZXL0hpN0cvczd6MDhnRm4xbE5UVVhid2xrUTgwMVNia2QyWHphRXdl?=
 =?utf-8?B?cVAwektWUHdFbGNaZEFncmNVQmVWWTlNeWpMaHUwNXRyVzB1WHVvRWJycnVQ?=
 =?utf-8?B?NWtBMXdrRkthWGhpRW8zYUh5U1dSVXVNbmowaTVBMW1hQ01MVzlPRFdyK0l1?=
 =?utf-8?B?bysrZXo3dk1NVERRSjJlWVk5V291RGlTeFNqdFhrY2RjejRqZnk3RWgvODlS?=
 =?utf-8?B?Y2Y3YUtZNURBdWRnRWx5TW9Ba3FyY2FDa1VjY3hSbjZhZlA3Ti9XTTZvTFcx?=
 =?utf-8?B?RWR4RnFkdFRSYTdaUmJUSTY0RXVZL1l0ZHM0Mk9HcVpwTXJPZVNZeWxXQVpI?=
 =?utf-8?B?T1B3NEdYRmI3SnRzdG5XWHA2NkpudWZiWGJGSDcyQm9aZjlWRXlCQXdHeXN4?=
 =?utf-8?B?YjBKMWVzZHZLMEpBc1MyYVlKWldvVkxnUXdGN0xzZ3hVbXgrVHllSWRUenQz?=
 =?utf-8?B?ZklvaldTMDNxSDRDN1Y5eFZNREhqaXZKTHhIQ0lTUFFjZmNpZ1lRWlhXZjFT?=
 =?utf-8?B?YUEwTmI3Vk9UcnNQeUdReGZyN1ZDM3Nua3JlVGtTSm1tdHA3U0t1b0dNUHhI?=
 =?utf-8?B?UDQ1TENJdVhhK3kxanRFVFA1UTE1UEk3VE8yS1Y4b1VxYWtmcGMxbHVSZzJz?=
 =?utf-8?B?WmlxZktBYm5XVndTNTlISFB5dlkvTkt4TlN0M2crSHNwVVBqdC9XSk1yUWpk?=
 =?utf-8?B?VGM3K3ZlZEExdklKV0E4cE9LcjIrQlQ0czk0azFNMk84SkRmUkxLdGx5bHgy?=
 =?utf-8?B?dUpOWmJ6SjhlVzR6cGQ5L2lvYVliTFNPcitSMVhNU3RlNk41VjVtakFqdW9S?=
 =?utf-8?B?SFpGYmxQUFVEaVBHQ2ovL3h4ZWNHUURJVVlzejQ2TURwNXdTcXJKWkZkeTI1?=
 =?utf-8?B?dG5pZC9vYUVUYWRTT25aZlpNY0ZBR1laSG5oampXVk5kSEpZKzZ1bW1UWTFr?=
 =?utf-8?B?NTdIUzN3cFhLclAvMXF1QVM4ZDEzN0MxVmJqS2s2U2pkUUlQTTFjWVhOZ3Iw?=
 =?utf-8?B?UGlwcTlVOTFtNU9PSG9TYjQ4U1pFZkJGS3FHNjNNenUzbld5YlFEZjJhT1Zi?=
 =?utf-8?B?dTQvc25YRkRnYWhqQXdTMGhab094OVVlMVJpMHBFY3piVHloUmFrOSt3Zm1J?=
 =?utf-8?B?M2duUThQSEFURDZuRGJDMlRvN3pGdjJuTlUwY3Uva0Ywc2ZWaExIVnl2SVRX?=
 =?utf-8?B?b0FTVUdDNWc3UnpDRGVRK3NRbmtQLytTL1ZMUVJidU9BTCtpcVZ5VHdpVFFN?=
 =?utf-8?Q?F2TjkDt5ehs1xahoaTuwKEE=3D?=
X-Microsoft-Antispam-Message-Info: zfoPfdNFtgtbyG+TqK2lstk/YHalAi/OrsYd7VCsOgNEZwG3iJaJ65BoBWF/YJ+G3KeE9uJeWa/p6WIlR3GBqfp4LUJOS0bQYln3FH60ZuEI4zTYXWIWV/Foizi+ICp07ZpLkrYcZhPu88GM1WFbI0CSKea7vG6EJdevTqIs0VSAQFXDFTq2sunZ7ynwC6hS19kx3lptrM7xrR10u2bTbUdQW24Cg8VG+Z2PDlRUoqPwIGiMJPON/h9mNRIU6lP3t1L+r4+vniuoKnGk2jtSNn9QEl0f/HKMidwFFq9U/YJ2l/7rdFKzeu9YZ+QmWmAz2r9c9+a9SdYR5AEEtuh1HUFH+ZdlHMP7JcItyIP4xyM=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4668;6:VbCZDfL1iqC290R4T3DJ9Fge1n9jBsnrWCM2f35AeME5B8p5bBDIwQIy5BvWdVdAERCRtGmk9hqBKl8/FmVnaOXvVLIl3EJbHXJynh4WlGyIyE3x1Ys/xZEHb6UX3BSs8Kqip4MEOrGt4WjP4ItNxkfp1ylrQ6nJq0sJCxlTCLBs57GTxxab/p09BzWP4ued5vh/5u9IA84Me6FzzyxoGNKjBMhcxzc+hSPt8HYN0/elewGDaNP4hepNGbAN181YxeaHKJXAulp4UqiltZvJMVMcWVEy9E28zjia2BXcApag3wulYmnMQdGtWDkSWPO2/7AENHMkDxnO28VPxEOWUfwX+DuGgT2dOXgUrHqwUkUxSFfBE7wyVAydcxHs72gjVMVm0GujjVxxSNV/PzNy04wlfyyJ5TmAqUkMm+VIN+exNaboTDjJe7ug1+UgkRPnmTx+Vv/aKucMHykPObqiCQ==;5:toykYbvNcgLfUw7fKBBkKriNlShQxAhc1v/19inVmVONfZvltCwRUmP6P98X9E5aCEKCe5at+0ufINAJr9GdhGnVv0iXjFYJfEvPmryw0bq3v+8Pk5xuvV+bIUdUZ8uVhHYUriCI/om7L/jjj1c+t2TSAVSyA0/anCppVI7hfvQ=;7:Uu6N0J3BkBaHj3Nftedv8oUzQJCFwCkiOr077j426HF1x22jhfgJs4kCZbrHQZMuTJYSIm65Bh5BdOY97Ju+SdnTBFr9y++RSKzQ/GRhBvCTg3/KP/kB1eD7/Fu9yw+vTDnodvMVm0HaoYvssUV3SBBONmqLCuXzkgpxeKKSAHp1IUf8p8PsU8ylKVUQgwSabC3eU5zZMVLIcUdzgvmqjQ83gReSkOplsku3KSpJ0caeaICnuPb4byD22znLT/N0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 13:17:13.7354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b276bd5-479c-49e8-b5bf-08d60f441150
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.8.2018 14:45, Lothar Waßmann wrote:
> Rob Herring <robh@kernel.org> wrote:
> 
>> On Tue, Aug 21, 2018 at 04:38:52PM +0200, Michal Vokáč wrote:
>>> Output of the PWM block of i.MX SoCs is always zero volts when the block
>>> is disabled. This can caue issues when inverted PWM polarity is needed.
>>> With inverted polarity a duty cycle = 0% corresponds to solid high level
>>> on the output. If the PWM is dissabled its output instantly goes to solid
>>> zero which corresponds to duty cycle = 100%.
>>>
>>> To have a trully inverted PWM output configure the PWM pad as a GPIO
>>> with pull-up. Then switch the pad to PWM output whenever non-zero
>>> duty cycle is needed.
>>>
>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>> ---
>>>   Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
>>>   1 file changed, 44 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>> index c61bdf8..3b1bc4c 100644
>>> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>> @@ -14,6 +14,12 @@ See the clock consumer binding,
>>>   	Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>   - interrupts: The interrupt for the pwm controller
>>>   
>>> +Optional properties:
>>> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
>>> +  pin to gpio function.  It allows control over the pin output level when the
>>> +  PWM block is disabled. This is meant to be used if inverted polarity of the
>>> +  PWM signal is required. See "Inverted PWM output" section bellow.
>>> +
>>>   Example:
>>>   
>>>   pwm1: pwm@53fb4000 {
>>> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>>>   	clock-names = "ipg", "per";
>>>   	interrupts = <61>;
>>>   };
>>> +
>>> +Inverted PWM output
>>> +-------------------
>>> +
>>> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
>>> +output, the output level is always zero volts when the PWM block is disabled.
>>> +The zero output level is actively driven by the output stage of the PWM block
>>> +and can not be overridden by pull-up. It also does not matter what PWM polarity
>>> +a PWM client (e.g. backlight) requested.
>>> +
>>> +To gain control of the PWM output level in disabled state two pinctrl states
>>> +can be used. The "default" state and the "pwm" state. In the default state the
>>> +PWM output is configured as a GPIO with pull-up. In the "pwm" state the output
>>> +is configured as a PWM output. This setup assures that the PWM output is at
>>> +the required level that corresponds to duty cycle = 0 when PWM is disabled.
>>> +E.g. at boot.
>>> +
>>> +Example:
>>> +
>>> +&pwm1 {
>>> +	pinctrl-names = "default", "pwm";
>>> +	pinctrl-0 = <&pinctrl_backlight_gpio>;
>>> +	pinctrl-1 = <&pinctrl_backlight_pwm>;
>>> +}
>>> +
>>> +pinctrl_backlight_gpio: pwm1grp-gpio {
>>> +	fsl,pins = <
>>> +		/* GPIO with 22kOhm pull-up */
>>> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008
>>
>> There's a slight problem here if I remember the i.MX pin muxing. In GPIO
>> mode, doesn't the GPIO block control the direction and level if an
>> output. I guess as long as unused GPIOs are all initialized to inputs it
>> will be okay.

I am not sure if I understand you correctly. Did you mean: "..doesn't the
GPIO block control the PULL-UP/DOWN and level if an output."? Yes, that is
true. And as you said, all GPIOs are configured as inputs after reset.

> One could set the pad_ctl DSE value to 0, so that the pin cannot be
> driven even if configured as output:
> 		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF000

Yes, it will make no harm to set the pin to high-Z if configured as
output. Though I am not sure that this makes sense.

In case we choose the pull-up to keep the level high the pin needs to stay
configured as input. And as the GPIO is reserved for us there is actually
no one else who could re-configure it.

In case we choose to actively drive the pin instead of relying on the
internal pull-up we need to use gpiod lib and configure the pin as output.
In that case DSE must be set non-zero.

Michal
