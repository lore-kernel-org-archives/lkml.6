Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C4C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84F221908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gWvdh5mA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="kLLhwdWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBGNWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:22:02 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:56728 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727061AbfBGNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:22:00 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17DH6n9016231;
        Thu, 7 Feb 2019 05:21:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=proofpoint;
 bh=Wl8SnScf2o/y9rLVIx8v6R+zBuq8/V3ZCvfBk98whOg=;
 b=gWvdh5mAFLSqfzCejIgw5viYrkeCKjxg3rOjOXpqUPhjPWtOCKW8SoIU7MXAfGs8s0jk
 SDcA6RWZ4oYDec2QsU7kjWLGxaxiUuHG4VDt8YHEvdnIrCDJRS2gk30WqlqJMVJc4XZT
 L1x/NQxQENw1t78bsXt61qUZlchIQRJjx1ZOllD/Xt0gg9Q8GH7SgANZfxULNCl9fgFg
 MQDCl/rjTeRX+WZI2QZxtQeOPEOhd4R6Q6lHA0VRkyqfvnumwEWkEW1RnUmv6z8mARAH
 QluzfhFjbhP8FaOPp8/KTK/X0oFPpxlPBnZOjZ5CGOyOfD0jmvDgSRkq/iErZGqzLjEO wA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qfagtj6bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Feb 2019 05:21:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl8SnScf2o/y9rLVIx8v6R+zBuq8/V3ZCvfBk98whOg=;
 b=kLLhwdWWpwJmNbUKiXrqEAuSz03KS4PG8wp4FTLrxmfBzy56wi4etzF2FLHtJLsQTfAa+AjIaFUaa+gnYNhKbiZVPlo119iOen590mxbJdtE692Osqz+O94H74EzJplHrg8/F+LVvIcgvQfY5btDkhfLPV8FD9KFcMO+w3IVHC4=
Received: from BYAPR07CA0022.namprd07.prod.outlook.com (2603:10b6:a02:bc::35)
 by SN1PR07MB2254.namprd07.prod.outlook.com (2a01:111:e400:c456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19; Thu, 7 Feb
 2019 13:21:08 +0000
Received: from CO1NAM05FT062.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::205) by BYAPR07CA0022.outlook.office365.com
 (2603:10b6:a02:bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.19 via Frontend
 Transport; Thu, 7 Feb 2019 13:21:07 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT062.mail.protection.outlook.com (10.152.96.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 7 Feb 2019 13:21:06 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x17DL1i7008007
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 7 Feb 2019 05:21:01 -0800
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 7 Feb 2019 05:20:58 -0800
Date:   Thu, 7 Feb 2019 13:20:51 +0000
From:   Piotr Sroka <piotrs@cadence.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 1/2] mtd: nand: Add Cadence NAND controller driver
Message-ID: <20190207132049.GA20054@global.cadence.com>
References: <20190129160337.24350-1-piotrs@cadence.com>
 <20190129160743.9103-1-piotrs@cadence.com>
 <20190129191944.74e1e7fe@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20190129191944.74e1e7fe@bbrezillon>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj6.global.cadence.com (158.140.32.112) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(199004)(36092001)(189003)(16586007)(3846002)(6116002)(8676002)(14444005)(305945005)(246002)(8936002)(7736002)(7636002)(7696005)(2906002)(105596002)(23676004)(106466001)(76176011)(11346002)(476003)(426003)(336012)(446003)(55016002)(2486003)(486006)(67846002)(126002)(956004)(1076003)(50466002)(6916009)(4326008)(356004)(6666004)(66066001)(7416002)(58126008)(26826003)(478600001)(47776003)(316002)(229853002)(6286002)(33656002)(386003)(53416004)(16526019)(26005)(186003)(54906003)(6246003)(86362001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2254;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT062;1:Xtb9Lgs7oG+SXU736JErW1aBFdZ0fZOB6FKAWmdeCmYuls9ZjLeCWfsvYimZ3gUq8bMZFc+C+xhMk3TCB55YgTQm430zpTWSB2mNYLhrL+qDJqzn19GAKw1TQ8bRb26b0lURnLneWSsi/ND7E2YzLg==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cdc8615-2cdb-439f-556d-08d68cff1e50
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN1PR07MB2254;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2254;3:H9V9eOU/d1c0bJW8oIyZS4QetLFRghb1r5O3fJi5TFWKmLC0idPRCp2cbwv4Bxz2rsZ2xnuuqGh/+pDh2Y21VxhUptmc6TCQgoLn6lpksHLMfYlawNp5PLEVbObPwpoENvXe8lY5kIsDOvKXGMo8eC/E/QlF4erj8ZYvNUw6cOnveNXlXRV4G/TGchcSz155Zx59rQUbxCsjD3s4kXOshfpoCrhUfTWMMo7LmoBXm+4c073qoBqtFUY/uRJ5mo0IUMJHHp17VORFxKY+qfCw6F2q/nRnu4e0l2U6M/+lFAR1HRE8Tl/6CBmkS++TT7xNR6lMuaUMk+GOc9eDy4jSTieOKskVD44ml6CYXpOkCKwH4I4zko/3LrkVJJxfBMeB;25:sVK7jMK0155yGxO5YaXdUp744fUuuZoVvnV9PeJ49mecTSIXNrLtXv7Az7RFUszp8R1Ssb1f8bLFU5MZh7rXgja8E/uLujeuE/aksvZ6cTIpygvm9t1we9vzZcCXOf8aG8MpGFQzvGtmgu3ZUaLBHRJ8L9LCXuKwCrGdWxUvwD+Q0yf7LEXrXQk0LWjSS4htBn9409VG2P3AX9omCo/ISbVMsQxqPP+2QjyaRRo+4EGPkecAMf98MqLYMZ/J9iIDdODhSrhSs8ZFCr65Iovjy3aT1/YwWrPT42oLSafg0v5KcsIWYkfROn88DYNxe77FcU9ISbc5hKpNr4kLCOqFXA==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2254:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2254;31:w4Wx5m7fHKWdqSzF2XQ6MOF0IpwS6D/ZfPayd5o5nf4FpAydwkEnesoHv1HWlTg6QeklNU8JutQSisGlfv7Ps/ivNKlhToNzGNr0K/UWGht1RDG949eT9x/M0S0r+mNYP6eleINaNv+pTZnVm2gp8dhBRbL2iwmunZdfpURFGKuFSvZfVrDm/EnwyMTzJ+oPlEn3UznvIf56nSiLttSBMj8wOhwWQPq3oWYqkHgYp+8=;20:nRnUQRUC5rqYCFkPMXmKyUGsn0BliQHiUx/8ij/N2oSpbcBHpMC3znZQ3TbuKmqLm1BzMqle+wnG5ETsu1b/RpyDR2TJk3IQEbjMyZI5a2SzuWxufzTkJio6NEprSkB83jXOhgROIfaFVhqFfnG6uDc90phqOpYBmNKHpxtmpcMhtTwdU6MT2zvfZygqFXx4a6dW8Ty85AMDvuwLGd3DE3CpxT42nSIuLNuyry38t8Ru+U+eSvf0h+pXgCvJ2ZEHfu4xkpJPfAhH6g+Nr6Rv1wFzCBi3ioa7nDTNt2e/Ecb5eWu7WJDr5JgKEONrqWXnaDka56gtfb8OuIks+/0Pxd+X4keMM6qiPN21KUs7qAOBrZjklnBRQ/TFJ6j0GKszqxHrpSU7tsNwm1TpwaS4AHPotQUCNKQGXJCHwecAWnGBJhnyxNP+5sW7edsPyLUC13sY1SkO2lwOlRo7UojX7yIGXyLjwpPisV7KUo4QW6BcsYdyPt9Ux7N/mGhI1LeW
X-Microsoft-Antispam-PRVS: <SN1PR07MB22546035A715FE9796E38FA1DD680@SN1PR07MB2254.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2254;4:Ryi5OGyFyqqjte/ah+D7PNkxBv2q7E1LXDynoUTsfzlTeG6C3/KXY3MpiK92LCTmqPZjTv6BI4oTi9UJYQxWrg9Z0KcHpKnHS3VO/+msPyJRIFOjnqw6N70iVyTOT6iqt/RsbJ/PSnH9zAEBlIqT0mIpwvy4wthtdiG/mYKeVfhZB3d39hSZdvBsjJIzcag9JSLNW31kh8pckF3zwsReIBJseKxNUbAqkZO9yTVRo1+p2rXe0s5PSDQSD6foLBR/0P+ziYFOLc/9oKTpsaLHH4IHV6stn1vzXYTYqss/MtaAVijy8mLTvGtyuq9kCPZq
X-Forefront-PRVS: 0941B96580
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjA3TUIyMjU0OzIzOnhOQ1hONHJMeGVvRkJHNC9neDkvV2tJMXBs?=
 =?utf-8?B?MmpLOVRDVDlxWktXVWM3M295M2llMGpxOUVaM0VNdkxINWJ2LytRcDZQTndL?=
 =?utf-8?B?SW5EN1oyamM2VkUyYS9IZ3NkRWVxcmNPZWdvWkkwVmFCcVZWQU5RVFdLbHFa?=
 =?utf-8?B?TVd6cE4zdE5tUElWZXdLQUw1MzNiWnJMOW5Ldmt0YlFhNGlrZWQzWlZnOTZk?=
 =?utf-8?B?T0szcFp3TERVcFkyZ2lOZUFUcGdXS0tmOU1YQWNwUno2aFpKUnZlN0lQckUv?=
 =?utf-8?B?VWNuZXhqNkxUdk5oZkdnVkFTWHVaenY0L2pxM2xkUEwrUEhkdHRVd1pQTk9t?=
 =?utf-8?B?NDF1cHk3M2p5ZW1VY1dEMExhbUM0VmJIYXBFZDNyL0lWWjNNUXorMmVIeHkz?=
 =?utf-8?B?NTloQjNVSnpMNWFFSHJPMFcwalc3a1VhaHBzQXBydzl0a1J1WEwyRmloOFpB?=
 =?utf-8?B?WWc5OThCbkdIREN4b3F1cWpyWDdXVnliSVBtcUsvZjg3bnNQUDRiUnhqOWdm?=
 =?utf-8?B?ejhWWTliOFhSL1NQTkxPdEJtWFZIZjJDTGRPVGV4YkJ5aStyRktOQ3huS3c0?=
 =?utf-8?B?ZUpHMFV1YlZUOVVHRksvWjFSdW5rUFkzWldrZXBKN3QwcCtjbE9LRVNhMlM2?=
 =?utf-8?B?MXBYeGFma0M4NENQK28zeUluNFJQSGU5a2xrYkpmazI1WjhBdmV5WWR3S0E1?=
 =?utf-8?B?ODlMdE5TbysrUi81RnZuWlRoeUI4czAycWdUclZnbEpCTFM1Q0d4S2JWYnd5?=
 =?utf-8?B?RW5JZ0RUYVFxQnRQZDJZN3VnNnNRcHBYdWV5VkM1VFhTb0s0aTdMMFF4TFht?=
 =?utf-8?B?UTBUOXF2aG43N0FqN1ZDTkY0Mjc4QUNLYXQxQ01UenNqaVc0dnJwcmc2a0NP?=
 =?utf-8?B?eUMvTnNrc1VQbW11NzdJeEdrRkR5SUFGSjhUVWluczdyYmQrazZHQ09NaVJE?=
 =?utf-8?B?SXRCYUtSRWtzeTdiVVhmK200V1lPL3JFV0VPTDFZOFFmQlU3bnFGclAwdTZL?=
 =?utf-8?B?K0NLOHFDVlR0Z3RsS21nTHNHeXNGVENaTGlxNkt5SzZrWmk1dy9YMjVCbXN0?=
 =?utf-8?B?YWZpQ0ZFRHRYRk1aOE52OVh4VE5LRWowdFNwN2tPZkRIZE5NK3pvMzhjT2xX?=
 =?utf-8?B?VUNyMTRKV2N4TDZmMGRRQWphLzZLb2ZvTmdjaitZcWkxMUtRQmtBdkxIakRz?=
 =?utf-8?B?ME1ndUQrZWltdVRMTmo0eDBXOTYvWTdkOEVlRDhXU0cxQ0NIZHBRWkovZm9B?=
 =?utf-8?B?VG9SQS94Rm5XZ1N4SnR5K1l3VjY1L0dRQnZleTRkeTNoVzNteWZlSThTOVhm?=
 =?utf-8?B?Zk5uTCtyeFhzUWw5QUJmZHE2Sm1yZ3ZsdnFkSkNEbmxGQjJvVmtReDhDb0Ri?=
 =?utf-8?B?K1FZVCt3UTZXY0tteFVOeC84Y3IyUzViMXBCb2hWZDJwYmxUdFNxUy9SR3li?=
 =?utf-8?B?RnRGNERIZHU0cjRIb0ZBc0Vpb3JoK1NYSTRpc3hZTnlRQVoxZFVWRUJoY1ZF?=
 =?utf-8?B?R2JLbTRodEZxZjVUS010eUlpdkkrRGkxMTJ6Ukt2Qll1bk5sM3Fabzk3THVz?=
 =?utf-8?B?MmhoZ3NmSllRVUNRbk04SlhHWVJ5TC9qZTNiU3U2L3cycHQ1eUpma0F5Nkxi?=
 =?utf-8?B?TWJ6cHl3WFZjcFhYcE0yT005U3Evb283QmFDRWNQZWE2U0hMMVUvRFpjSWpr?=
 =?utf-8?B?Q3I1SDk1c2ZEamdMYkxYU1JLZ2xwTWxvNmZINHBjb0xQd29mMkJTbGoydUtD?=
 =?utf-8?Q?QX4/YeGmrmgqq93kQr8Af2XTAx2YhsnTOFQzU=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: G5m17dtGemXBE9C6nQ8SKNuA83wJji1csvntgbGhqm0zTpKaU8XxPgyY8OOTSOfHsOG1dNmoPCvkBnPbadFcQPDWwv8H+2kYqAIVID/JAybctz4zgVeXS2OgWesJUPNVkqnZ85LZ5soKwPnAT9x8Qt9DXeFSYh4HcDHOEHno6JA6jylaNGC03G5ZGHcvQpSEDs0ek5GofdlDKRzyLH51sjmeulBjNEJGu83KJN4bnOWAeYPOf6+JFdGqbKFRYCpSCrK9jzZ52yHIl3XOZHyXGoazdd3vyLbNgp0CXsjqx9UrZp/7SuuWzrQXiv01iTbfIWcY30/5fqnO4hnLBcbG+hXgzAeI1VioDw075sQ7Vcuo9R65E5K+xRqZbpsnYPo3UUzA9FZGq2/VY0gj5afdP+Dy9oAyXUWDDrhAayX39xQ=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2254;6:1CuaZJQNiQ4SF5VBykM03AmzK/5JfeIxVgYvj2aA8oL6CnC/k4PKssDIgLszISTA3Kz0N8VJSE0onsrOa8tf03Z8JpzCXRW546JPdfmf2htey+d4cMvMHOFRsOafiMqyqL7QTKOn6w6/vkuV+6hdLv8gZeb0b3Uo86RVAosYfQYx2/9c3TTFMOv+QoLLbgNFDkkMrBmCJgeMzqO7Jii4Xu3Ut9/j6xhc+iIiJF7bJtur8nUnLXTFhNPk1jIfNpgK9v9BsJi0kKDWAD+/K8CwCdh2P0mK2eztUquFwZbd7KgVtuwnVppvjlmoF8An4IrkcdE77OQFBLYXbS9uWfBsD+2gkh8VKYt8mDfysvrWRfJJoWQTg8OAmK+l31NPD+1BnpW9niMLKIH3VUxWd0y4Il4SJCNtCys/p7P9P0cSJXXKT/tpk5NrKjClaQR9FZpOucV5KtJRyIaOGK1Rt5Q41A==;5:LqdYR4hsZR8QMHA249Mdkksd5dEFA+MypwPtopWarfESEt1Rb+xGa/aKEbIpls5gJYnhz+bCGMlptQtJBcDTANG6rU/+7kG9q6q7PpFR3I7BK8xhHBwuRBFt/aI2Homa5YR3ZZNHvEkSoeEksnPEu4x1+vYcwl0yTROy+rM5FSyjYmews7xqI80riMyPlchsCX5l7neg/BIvv+t9Om6Sww==;7:MKqSXcgAivS3xzeokW4IC/w39Soc/9/CjI984NBN7BFufUgOsdVWZ80O8Ta+z0Xhni2mVVJpqEB31L1UyPjvl+adf0fraZ/4WBOal1rdXluTbTurprPGtl5+GqCDCXwTD2PkUUVfyH82o0pu7I2czQ==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2254;20:5l8HwpWuBDiJXv0vnFqBnT9XGYEVO8ewbuhQ2T4hSj7ObZC+xSYk/mmZNCrEANv9XzI9nWdFqoOwFGGe2O+MspLtMYWTWjmLGKEZyo/gKyDKNJVHJL2Dn4JiS29edffIDEJO8CULNMyEL/9FnmgPcnn08mEyI+4qI2EwdS2X30JtkBVoTYUybi+N4EA5g5L1rnMNy8+K9dfs3AQmON2kp+cAdcwo0A1yYuwWAh8OLDRNbpzOHlpLo34BxcLdLr29
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2019 13:21:06.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdc8615-2cdb-439f-556d-08d68cff1e50
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2254
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

The 01/29/2019 19:19, Boris Brezillon wrote:
>
>> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYC)),
>> +	NAND_OP_PARSER_PATTERN(
>> +		cadence_nand_cmd,
>> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, MAX_DATA_SIZE)),
>> +	NAND_OP_PARSER_PATTERN(
>> +		cadence_nand_cmd,
>> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, MAX_DATA_SIZE)),
>> +	NAND_OP_PARSER_PATTERN(
>> +		cadence_nand_waitrdy,
>> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false))
>> +	);
>
>Are you sure you can't pack several instructions into an atomic
>controller operation? I'd be surprised if that was not the case...
All write and reads operations are handled by function pointers. Apart from that I
could handle erase command as a atomic operation. I will add such function to
the parser. 
>
>
>> +static int cadence_nand_set_ecc_strength(struct cdns_nand_info *cdns_nand,
>> +					 u8 strength)
>> +{
>> +	u32 reg;
>> +	u8 i, corr_str_idx = 0;
>> +
>> +	if (cadence_nand_wait_for_idle(cdns_nand)) {
>> +		dev_err(cdns_nand->dev, "Error. Controller is busy");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	for (i = 0; i < BCH_MAX_NUM_CORR_CAPS; i++) {
>> +		if (cdns_nand->ecc_strengths[i] == strength) {
>> +			corr_str_idx = i;
>> +			break;
>> +		}
>> +	}
>
>The index should be retrieved at init time and stored somewhere to avoid
>searching it every time this function is called.
>
Function is called only once at initilization stage. Do we need to make
a optimalization in succh case?  
>> +
>> +	reg = readl(cdns_nand->reg + ECC_CONFIG_0);
>> +	reg &= ~ECC_CONFIG_0_CORR_STR;
>> +	reg |= FIELD_PREP(ECC_CONFIG_0_CORR_STR, corr_str_idx);
>> +	writel(reg, cdns_nand->reg + ECC_CONFIG_0);
>> +
>> +	return 0;
>> +}
>> +
>
>...
>
>> +
>> +static int cadence_nand_set_erase_detection(struct cdns_nand_info *cdns_nand,
>> +					    bool enable,
>> +					    u8 bitflips_threshold)
>> +{
>> +	u32 reg;
>> +
>> +	if (cadence_nand_wait_for_idle(cdns_nand)) {
>> +		dev_err(cdns_nand->dev, "Error. Controller is busy");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	reg = readl(cdns_nand->reg + ECC_CONFIG_0);
>> +
>> +	if (enable)
>> +		reg |= ECC_CONFIG_0_ERASE_DET_EN;
>> +	else
>> +		reg &= ~ECC_CONFIG_0_ERASE_DET_EN;
>> +
>> +	writel(reg, cdns_nand->reg + ECC_CONFIG_0);
>> +
>> +	writel(bitflips_threshold, cdns_nand->reg + ECC_CONFIG_1);
>
>I'm curious, is the threshold defining the max number of bitflips in a
>page or in an ECC-chunk (ecc_step_size)?
Threshold defines number of max bitflips in a sector/ecc_step_size. 
>
>> +static void
>> +cadence_nand_irq_cleanup(int irqnum, struct cdns_nand_info *cdns_nand)
>> +{
>> +	/* disable interrupts */
>> +	writel(INTR_ENABLE_INTR_EN, cdns_nand->reg + INTR_ENABLE);
>> +	free_irq(irqnum, cdns_nand);
>
>You don't need that if you use devm_request_irq(), do you?
I agree I do not need it I forgot to remove it.
>
>> +
>> +static int cadence_nand_calc_ecc_bytes_256(int step_size, int strength)
>> +{
>> +	return cadence_nand_calc_ecc_bytes(256, strength);
>> +}
>> +
>> +static int cadence_nand_calc_ecc_bytes_512(int step_size, int strength)
>> +{
>> +	return cadence_nand_calc_ecc_bytes(512, strength);
>> +}
>> +
>> +static int cadence_nand_calc_ecc_bytes_1024(int step_size, int strength)
>> +{
>> +	return cadence_nand_calc_ecc_bytes(1024, strength);
>> +}
>> +
>> +static int cadence_nand_calc_ecc_bytes_2048(int step_size, int strength)
>> +{
>> +	return  cadence_nand_calc_ecc_bytes(2048, strength);
>> +}
>> +
>> +static int cadence_nand_calc_ecc_bytes_4096(int step_size, int strength)
>> +{
>> +	return  cadence_nand_calc_ecc_bytes(4096, strength);
>> +}
>
>And you absolutely don't need those wrappers, just use
>cadence_nand_calc_ecc_bytes() directly.
>
Unfortunately I need these  wrappers. It is because size of ecc 
does not depend on selected step_size which is on parameter list but it
depends on maximum supported ecc step size which is not avaible in this
function. Lets say that controller supports the following steps sizes
512, 1024, 2048. No matter what step size is set the calculation will be
made always for step size 2048. 
I could use such function directly if it contains nand_chip
parameter. Then I could get this parameter from cdns_nand.  
>
>I'm stopping here, but I think you got the idea: there's a lot of
>duplicated code in this driver, try to factor this out or simplify the
>logic.
Thans for review. I will try to simplify the rest of code by myself.


Regards,

Piotr Sroka

