Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8F6ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692C52151D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="oCdPWbzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692C52151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbeISSfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:35:32 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:53184
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730876AbeISSfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FxeuZ1aao3PRmK5XTduBLiWy2F6RhikCojCWhzzgHw=;
 b=oCdPWbzHr3o8KqCI4QJz0o+DmGg/gN3QjCFLIpAPoSWMKMqDbSKY1ci5PMW2YEaLrVnHfvm7ePtNbZyOXR7fImFFwARLdHgoCbZVNLfm8bAevJU8r5PkOnpNeqCV8D5A2PcWbhbEZj3U7v6wixmIdKs2fP/drrY9wvhU32d9jL4=
Received: from [10.1.8.111] (89.24.100.190) by
 AM6PR04MB4662.eurprd04.prod.outlook.com (2603:10a6:20b:1b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 12:57:36 +0000
Subject: Re: [PATCH 2/2] video: ssd1307fb: Do not hard code active-low reset
 sequence
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org
References: <1537348724-22976-1-git-send-email-michal.vokac@ysoft.com>
 <1537348724-22976-2-git-send-email-michal.vokac@ysoft.com>
 <CAOMZO5CtaphPBXSkuRxX37Zbbx9oogXjy13TsRPgtR6y87gAdA@mail.gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <4830b2da-c487-f060-b876-d4d0e079c7d5@ysoft.com>
Date:   Wed, 19 Sep 2018 14:57:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5CtaphPBXSkuRxX37Zbbx9oogXjy13TsRPgtR6y87gAdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM6PR0502CA0035.eurprd05.prod.outlook.com
 (2603:10a6:209:1::48) To AM6PR04MB4662.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2bc54cd-7d53-4d67-bcf8-08d61e2f792b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4662;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4662;3:cPy/CVY6LJfupdcCu3y7AqEvmDsEdvXCuqcGUVbpQbnPW4RaMckSEGQFBvJ6UbexdVmSgJLy3pp3jEGas7A5NIYXctanMHMtkm8c3Vl5Ia10EgxbU6jjMu0knTFsFKI5L4tgt91oIryfFNsiOw0F4iJesk+ejtG8a6f6nt33bKdr9OE92WB9iiGX5O5/scX8mgjQGI8FPpIZDIH+8+meTGEzckkhRrwOQVaFe1trt0sjAVGClSRp7IwzZ/Bvy6Qh;25:cay8E0soaqQtISobP1Gu5+BDy3OuJmwlKwZHtUpyLhHvBTSeQAczabEr556OTi2fA1CZOXk71OkDpphZkaU2hcpAfLKhkP4vTGd7sKtZ6mEBgVt58kC5UT4QdbZ5+iVOHmqzw7m/zY03CVNI5lPrwlnFylKbABc+wAV/71+RKzicZDV4CpZ3+swVNaNK6rqB0eqGWxd8jZY6KL29gIco6nA3Cu07TfZS1fmAZZRlFOGZk70iILpslKrBtwmgTVsQuTS51JUHFv139SRYH3CnbxJRWMHRHxW245xh8gCKICTMBDjHh52uuB3SJp+z1A5T1j7OvAON9HH3w1ZJBVCB7g==;31:rhM7NjOHh8nSd87UqLs7ryZrMUG7W5vU/MxQuyHeB+XVOGVSMG5UDpg3GU92LoQQ/zg6P+VfdBiMr29/SZQjzq6B+qcghibkovhbXrSQVDYeuHPQaiN3HnhKlb0oiEawCxMfDVj+RWQTItElxb59DuTtKNOMLnZ4lHoLfBSy4DTEdb6t36xA6nJrA3T9/1BllTU2iIoYpUed1mpypApJxne/sndZUdiPhPq1vnbkc3A=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4662:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4662;20:KgrHTX+hu4PhTF4INKM6GkZwruLrEoyYkVOok261GnP6ACRr4+eH+/iHSiGYC80wIoY/B//Pi105GZeFF6SM5/Pfe3fvfqh8TuL7mi+umNAunesRFUUm+dF66r+d64x9C6aBXXiMcFjNOCZga2716X8xVqZ55ogp2gkJ0X1Hl6YKDPd2ua0bGMRdx6YHEuDskCHyDNp9QN2LQEa5NHmQrnQU652wrCSoXuzy44LOj3cAydP/9qtZXaHvGcwuvY6Y;4:eWiP9G3lzNUk7MTvMtyVEThpuCgqmyjnW+XeSEfx3A+aOx0iAgdF0keIzjrfLlPyuXqIv7Zgf2sNQe8FE9ARPoGzvxOPs6ktXuU7ntDVMNs/ORDF++Zdg8rPE9nr4/+zq2fRD8z69myvb8dPOR61DQu+Vq/Evsz+/w2610MmE7cJCQWQxX1XrhXzHsvPi+/jufXx9y1NPIaF2MFVKbGknnnGGKGfWP6Ou22Jald5AuNGGIzX5W0vmJ9lln5ilTYTSqXpmrKz/Ob/60YDabYYDA==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4662253DA46543EA76F2B00E9E1C0@AM6PR04MB4662.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:AM6PR04MB4662;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4662;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(136003)(366004)(39850400004)(376002)(396003)(189003)(199004)(4326008)(97736004)(3846002)(11346002)(85182001)(6116002)(5660300001)(65826007)(476003)(6916009)(956004)(446003)(2616005)(31696002)(8676002)(64126003)(52146003)(105586002)(2486003)(106356001)(2870700001)(86362001)(31686004)(2906002)(486006)(36756003)(68736007)(23676004)(54906003)(229853002)(305945005)(72206003)(52116002)(6246003)(7736002)(26005)(66066001)(58126008)(16576012)(6486002)(50466002)(478600001)(53936002)(39060400002)(76176011)(81156014)(81166006)(53546011)(67846002)(386003)(1411001)(6346003)(316002)(16526019)(8936002)(65956001)(65806001)(47776003)(25786009)(186003)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4662;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjYyOzIzOkg1bUtpeERVT2RodnVrRnhjWjhnc2taTkRM?=
 =?utf-8?B?aGxVSWVBWTNwN1Fwd2VDSUoyUEhxWDMzSzd3NUNuY25pMnhOY0xjZER1dG9I?=
 =?utf-8?B?S2xUUVE4Z2ZyQWowMDRJSDAxbnNtd09yMmRrVTk2TGZRVC9uM3V2a2x4aEJZ?=
 =?utf-8?B?U1lSNHlBNklCUU1oak9OZlJrd0JZcUNRVnJHUlRhRkV0YU1iRUgyT3ovcnNI?=
 =?utf-8?B?VVVGdVNOalJKeTRUd1JmRitPNTRNUEkxTWI2VlFHSWN0ZnIvMGc0V3FSa1Vz?=
 =?utf-8?B?S1NYVVg4WG9wRy9CZG5lUjFEV3BaaTBVenU4bnpURWthMmJXNCtSMHdjR0Vr?=
 =?utf-8?B?UnVxQXpiMDdUaDhTY1o5cW1Ldm05Ky9DM1BsNVE5RGE2K3pTZlhxcThOczZM?=
 =?utf-8?B?UWpuVHNwdU01ZkxNcXlBd3NtcjQ0WWJIdm50MDRvbGRNRW14dm1oV0ozZ2dl?=
 =?utf-8?B?L1pJS2xhYXJTai9EOFo4bDQyVEVNOW05YW8yNTlMNGFwN2VEdjBYaUJBeXpU?=
 =?utf-8?B?eGNCdUtNM25oMmp5ckhIR2o4RmpQdGF6bC8yMWdUQzl5OFYyYXJBaVZOWFpO?=
 =?utf-8?B?UDE0VS9jekFDOVBCelRySnJ1aXF1VXY4Smh4eXFWd2RXN1F3bCt2TURCMUcr?=
 =?utf-8?B?L0hSSFBIemdIY0xUVXN3bUFBUWZXOC83Y1FkSTAySE9NTTVFK0tiSjdhcDVR?=
 =?utf-8?B?V3g2VTQ3djhZT2I5M1lIcGRuUXorNEFIZlY0d3RoWDRwbkxaRnZiQzVaaWUr?=
 =?utf-8?B?RkxSWmhvL1FUa1M1bFgxUVJNT29KN0xDb0hYSC80M1NBNzZ5bGJGRTBXR3po?=
 =?utf-8?B?OVNENjcrdWFWRWgwbXpzblk4N09RWnNzWEtrbWxiQ2VMTjg5MTd2eUVqQ1Ri?=
 =?utf-8?B?QVREL3JONmk1NG1GakRQQ3BVeDZVanJITUVqYVVMTFdWODViaDRXbDdNZTIv?=
 =?utf-8?B?SnlMajJsNktYcWJCMmI5WitqQ0N3cHhaM1c2Y25Db2lub0loTEl4SWJHV1d0?=
 =?utf-8?B?aS82TmJTSzB1aTBmNUJ6R1NzdzVzYXhoekFqUlAveVdVa2ZJdXdDcnV4ZkVh?=
 =?utf-8?B?QkkramJvdklZcHlLa3ZZRHFEbWU5KzBGWTdoMFNhalBzMWEyUklBajB1WHZn?=
 =?utf-8?B?eFNRb0VIQ3RHR2pnVXlBVmY0OFhxREVsbVI0MFVtS3ZWbHZNeXR4ZDhFanov?=
 =?utf-8?B?SEtaVFcrZTQ0ckJ4bDB2SGtvNVg4dlU3cDF5ZUkxMVM4RW9qUjY5R2lxeUpS?=
 =?utf-8?B?ekoyT1oxYVhSMXYyK1BhcU9Vbmw1OE8vSWIvemREd2JkVVBpanJjYnhEcUxS?=
 =?utf-8?B?bHIya0xxTk5GQlNoSGFoaVNDVHpMc1Q3c25vYURucGpZQ1I2MW5ubjlQZ3kw?=
 =?utf-8?B?SnN2bGVlK2YvdmN1YVBIOVdZV3VPbFZXSVFPeTNsQ1RMSWtkZ2xZWCtEZUxM?=
 =?utf-8?B?VU13QkVsZDJ0elJFT2ROUFM3akg1NnVWYkh1UU8wZ2NFNFo0WS9Zb1FqTkhV?=
 =?utf-8?B?L1h1aWk1V0F4MzFmMTI4VmU5MFp3THNNMXI4dHBhMXRoOHozVU51WVllUjJN?=
 =?utf-8?B?YkE4aUpXN0pheUg2RWZmb3lnYUJTYUcxWTI1UHdIUWxXU1ptbHV1eWhwSXhK?=
 =?utf-8?B?aVIva25wTVdIYU1hWDhCVkYzRkxURmROclljWWJ3UFptb0tXZ2lqdW9PK1hi?=
 =?utf-8?B?eVdoL3pxSGdSR2RjdEZFdFUzTXRBUGJWYmx3d2l2Z1U4TmxqdGNVYlVXRUNq?=
 =?utf-8?B?Q2l4d2hmZnd0RFZSQXJreHNhb3NWTHZIMlJSaDFLK3pEbTh3eGxJa2JHRDA4?=
 =?utf-8?B?cU9sUkVIQjhIaWk3dUl3MTE5MXM3V21BREZEMG5XNFFKbk1ubXYxbnRpUEx6?=
 =?utf-8?B?RkRQREZWbzVJNmFVQ205c0VIOS9SSWNBWkVWb25vUXA3K0xna3FFVTJPVFZr?=
 =?utf-8?B?WWROdEJMZ25rWW5aajhiRGtXSlN3OHo2RlowYUptNzN4cmZwZHlMc1ZoQkJP?=
 =?utf-8?B?TDBZU1J2bDBUZXNNcWh6dEpvTExWMVhJVkFpcWFWQjdwUEVKVDN2akVpTlYr?=
 =?utf-8?Q?DmeBSkLQkMP4m15bkzvCMQTd1?=
X-Microsoft-Antispam-Message-Info: w9CIsmbAw5H1CwI/XO2OPMp67zlKIT7LoC3/zZRj1SLVr9l/jWp3HQALLeXbiemHGkYWbk/wG1Nl2gH+m8WaRXm7fO3xFSw9AXkg1Mv2y8yPprn5IEeixycKNeWjUeiCBpEPZyPGDp7ToGfLjOtv8UlWIdEh9EDb3N0GXphAKXFM5462kUWm7ryVLBsMOg5gSmKsPQNaORbWW7iTpyRlFR4qruxf+77zqV3dsd9oMeNLIW6BCcG453hN/4hAobI1EXvWalf/Bc33qvXQlAbJInXdFO3NpaO9isYnPMCl0+PURosuHgDzh99CExWCct/5hiJH6zza4xKXsB2F1WTVsQugspYC4hdXJolzpF8VNs4=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4662;6:YeCGEkOjhzEP8K+cI1AXHHkDuthjUWGI3YyTG6GHW/ZQWBScENSNHkKcdJAUJb7Y3VSnrQLEy4kjy+dRDmPxEC/vLzmO93nFoRhFTDdj1yDRSQpy2tdW4dxNYZB9tz6yD1lHSM3KxGp8Wu2bAwM2AU878NILQjtysPpsCr6Sas7UJjbKhDARbIbx+KmxmWj4T2B+ntl5RtSRhTI9O5XAndPdiKQpQNxKWaB8vc5pvAecUMmQSHvgMneLJNY/CInrcQTX5qM+bc6t5EljyuqNjgCsxEJT4fUuzXQhcOa67Y3MifDeDJaPrmrcaFM1g3jSgOSqbn6/hHqxUK+ruQDRj6AXAE6aFuGPpLvtYOtjtJ9wXQ5zhJc+pqATrTuaDKCRwoRzyHdcrJepI+N/er+QLA3k/jmDhv3l3YhAKIyZmxnM7ZufhNdvHocpM7Moes4pLEg5Os91XKTs03/Y61gpDQ==;5:YRmgs80in8Pk8tkyUQXiOsLuwvSlNFAFXOg+vR6zebnkxoP/kJXJmzDZMRJsXxcUYTIPs9m8Y+OXGNdRGbAcVcj06HGLUGpGVORI1hYKbmY2P07HG3+8QY9hXIsg3jvFkLBfsNo6zhQqqZyk7H43TZnDxDr9w3VO/uePT5QfIe8=;7:IsBwQItIUL1hW4rmiBb239gPEqep0QpICEgx1/wY2elvzAFWZYELV2s17zxSCwKBrz8uMLPrISz3A0AsOQXBHNj7MCzy7CA1q0mWOuMaPrzsEQZkQT4RqF8zZMM4FZAPRSTwrDZmzoe0R5g71yVDnewx0Otj4Rm2+GiV/NChBsRJprVBULgXol4FeaYDRio23oUMnMDq/YniPCdyu9DgF+mWrI/LpUG3v+EWIMQipuN8K+IjLHhVPpyeJRhgbL6W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 12:57:36.1447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bc54cd-7d53-4d67-bcf8-08d61e2f792b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.9.2018 14:12, Fabio Estevam wrote:
> Hi Michal,
> 
> On Wed, Sep 19, 2018 at 6:18 AM, Michal Vokáč <michal.vokac@ysoft.com> wrote:
>> The SSD130x OLED display reset signal is active low. Now the reset
>> sequence is implemented in such a way that users are forced to
>> define reset-gpios as GPIO_ACTIVE_HIGH in DT to make the reset work.
>>
>> Do not hard code the active-low sequence into the driver but instead
>> allow the user to specify the gpio as GPIO_ACTIVE_LOW to reflect
>> the real world.
>>
>> The only single in-tree user of the display is converted and builds
>> fine.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>> I am not really sure wheater this should be in one commit or the DT
>> changes should be done in separate commit. Just tell me and I will
>> split/merge the changes as you want. Thanks.
> 
> Please separate in two patches: one for the dts and another for the driver.

OK, thank you. I will send v2 shortly.

Michal

