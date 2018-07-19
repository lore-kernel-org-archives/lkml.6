Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447A620856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hTHinaKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447A620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbeGSSnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:47 -0400
Received: from mail-eopbgr700040.outbound.protection.outlook.com ([40.107.70.40]:62787
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731661AbeGSSno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOWNYt19usNdRNt7xv++3EV5KuQU11vNVAbn4o+Gkhc=;
 b=hTHinaKq6FvkzgQRw+fwrOZH42kiU4UlIM5CU9DDVIpdb+IJhj9PUiGGWvf2Sl2eQly/0RttriZbYhtLI8iMabkfw5Dqp7v7aX4ZYo/flPXONqxQpiN1jJ3sOEygZDlUvAU0bbbZwWCxYC09DYUw3q+SqQmz2Cm2Nuxupbsyb0c=
Received: from DM5PR07CA0104.namprd07.prod.outlook.com (2603:10b6:4:ae::33) by
 CY1PR0701MB1340.namprd07.prod.outlook.com (2a01:111:e400:4c1b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Thu, 19 Jul
 2018 17:59:06 +0000
Received: from DM3NAM05FT010.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::209) by DM5PR07CA0104.outlook.office365.com
 (2603:10b6:4:ae::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:06 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT010.mail.protection.outlook.com (10.152.98.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHx1Bg004988
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 13:59:03 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:16 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:16 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHx109004971;
        Thu, 19 Jul 2018 18:59:01 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHx0K3004929;
        Thu, 19 Jul 2018 18:59:00 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
Date:   Thu, 19 Jul 2018 18:57:33 +0100
Message-ID: <1532023084-28083-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(2980300002)(189003)(199004)(36092001)(54906003)(356003)(2870700001)(478600001)(105596002)(4326008)(47776003)(316002)(97736004)(8936002)(305945005)(106466001)(5820100001)(87636003)(42186006)(109986005)(53936002)(26826003)(2906002)(217873002)(107886003)(36756003)(6666003)(86362001)(68736007)(50466002)(69596002)(2616005)(50226002)(486006)(1671002)(81166006)(126002)(26005)(426003)(186003)(8676002)(23676004)(81156014)(5660300001)(476003)(14444005)(336012)(4720700003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1340;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT010;1:vwjirNWIlGP8qCzHPObzyBg5q+fhiRwt0Mj/FjlckNo7cqaR5+wxEf9bu6XZD6Q6ZFLrYRs9CIcM0q0Da30hwKQec832QbNGMkyU1Wduk4j84Dha0erOVY86eRPwLtGk
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f71bf9e9-76e0-4166-6f58-08d5eda151bb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0701MB1340;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;3:Xr5lAU6JxjOnm9JfVuoU2qOKI3ZCbVnZWDnRz1ghs1ishxd/MrYtZKzWfgRWIPKMv8FcBy9S9F71uR9g1YKaoVq+PB1UX+hPQMXZZT8YJ0pms7u3y55w6Y2dAup3iBIo8tL6YDV+FgUtlZmhx5Ke1dxcwUgO+0ibZfqqmn2Xlptn8yvhM9woxWgN/HTwL/tZAJMRlXIvWVQLRDrZoLaau5o64Q4iyqHTEBrHIDeN/blxlL3MvFijR7PNP0zlUmZaZeQd3NQTtNxit26YYtoNbtTxPSSDst9ZUo+WtJF9eAf03rSkZMhC3Loo48HnRWZrC2Z7oNXCuDvCuQ/hPfgsBQ==;25:2Be6esYM3w+myaNPanz1xvWGNyARtROOblu7VwWbh8tlxQqPu/OgB44da1AIQsvmo0mdN1b8C0ufgpj3wKgAPd4LCK1F+TjWN+WFR+SqW2lVOW80UnIYbZXxpVTWqMcvatVXJRlSMFWMaEBpT2eZYU4ftlmtEfTBmKHe2q76rah0oD/dja4Qmxy9IGTWqT/yzgA3PYZAcsu1omMcpZAmDKMgb1Xw5g8Ef3sNKXvhqyB/gnSMOoaqthFbHLlvtDcr3t+h5T+FDE7hrr3/1n9FmwUJ4habPfQTAr5KxAw7Wxl6efjUE+g1a8OekWBXloocVBHJvUKmB/umtRt2yUHxIA==;31:AFkpwNZLMxEN5yxv9edXePN6sISH1FWwtkLynmUDoIo7AK4XzsnX48pZzfJaV/asXReEa7sA0dXa6+Szc1TfELLnje4eX3ZFHHF+G34JV0IxNjgqAQ3ONeTniaqPmenmYplTMEgSN08+0pgAlYwK0nCg+ULKnhUdiePN30NBeknE1PUJha5lhi0yPSTw3ksaZX4SzIUbNJi1cx4iiw1JjBv7rSxhcHxk+OB8pmJb9sQ=
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1340:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;20:ctVW6b8MwvjYsA/SN0nemHAaYHiPiBnz/32OOJnu7L+O+HSevFMo249s5DtduP4qdLGtSmfAkSGMzqEbbatvmLG7lu89+M1abWDFlwa4BDFXf26SEnhgf+BHUDXXPeI+4a9huQ3emClwPv6LH/JC9YgVeQ74au5VBZauFMGdPIKMGJaAC4ZdCpKQewtA2+NGC3DlFjs/4jTIA91r9PmAOoLp0owBHBUx/YJd7CmnV7GKmN3OnYTNjmsVD/KFexlzXp0UKaSiHfT1T8zNOqyUVJEH1G85TnXv22spuOcSicfoYlyiEGWOyqof+bIPRKTcjy3iJNTtkQtQ63oSk6eiLJJ/XHE2cXZLbZFXN5yrOzkdFHcwrLoSlx9ueFZyb0kxITmrjPqkYhv8V08svplQOASPcSTmI00dJyT78INhTYNAUvmAYlbpvCTmW/C+KS2qbhwrIpOMG6P4B5bz4XpqXN2JpfBZD0Qz9jAHLz/G0x3TpxGRiSR5iaNtZfE8FDqS;4:WsEop3gIqOjVzHYgpQveGPeiZ9M6Lw+BR9/EbbjkP7SDvHuJBnMBVG2+HsYDYcp6T0SELhTtrtNEMc3CkJVEAeziXaSvVDMSrqOCtxq5lfMRMVFXVRuoP+O8ieRvOiEmSfSc19X4hqd+ZJSTbRWKT/DMap/vMs2HcfClfj0kArBeT2j3FwlxZHIJAJYO4Ez30Saql34DivJzdKtcbZJbb6RBMg4iRw2eie4h89wZ7xGksjEOoPFLJ6WIZTCWgxHIEUoGFURFWSIAaTRG3Qz4EqkwfdoCcpkgEKucvdmDJl2zN0hKxw+ILSopNMQdm0dW
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1340E381C94B30CD43276A25DD520@CY1PR0701MB1340.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93003095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1340;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1340;
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjA3MDFNQjEzNDA7MjM6cWJEMFlGNFJBWWdPNVMraGR6NXFvWXJX?=
 =?utf-8?B?b0RSUVFLWk1ucVpNbjI4TVFYWHhSRk5FT0RoVGgzamR0bGdPYTZVS3lSOU1Z?=
 =?utf-8?B?ZVl4dURCS2JFQXF0K0l2Z1FqSDZMSjY3a1NYWjYyLzJ3Tk5Zbjh5Nklib215?=
 =?utf-8?B?OEN2OTlMcTM5M0hsVXdxbUw4b0I1RTdaU1ZNUTdxSjRUN3dvSE5UV3NZTXR5?=
 =?utf-8?B?V2lRRHFWK1kzZUpldG5XYzRkVDQ2SE9IbHllQUJZRUtUNS9IQVBaY2FZWjkv?=
 =?utf-8?B?Tkh2Mk1DTVJ4c0ZJRDIvQjlabnFvQ3lhTndkSm8zUDBYZElMb1NsRnZXUWNm?=
 =?utf-8?B?MEYrYUhwNjVDUGNpMW4xaVoxSmRtS0JROWVKd1ZlREZsZEh5WG91YjNOWG9G?=
 =?utf-8?B?VEFTbmJYcU94QTFpL3p2MG1CQ1IwSTNlZmZNSHFSbi9rUGxCZ2VFM3U1Ulcz?=
 =?utf-8?B?cnZ0U24xSllmdTZvSi9idExXeWRnOTdKRTRwZWFHcEtDbXpOcC9RZWN5cTdW?=
 =?utf-8?B?V25NUHZsazNzRkI0NTM5MnZjYXJ6MUJoZ1hkRmxVUE90L0lxcXBKaC9HblYz?=
 =?utf-8?B?bTNOZUN3QmhZSWx1SDVoelhma3BaTlpRV1NiZUdUdXZRemZKQUE4Z3lCVjIr?=
 =?utf-8?B?QjBvcWs4K0xqYjZwcW5sWWRRSDhxWlFXOXlCM1FZS3kyclU5L1Y4NmgybEky?=
 =?utf-8?B?T25jZVFnT2p0RG04bmRkNGFOdWhubWNrcVJyc1VPdjhDOGdiUFVMc2JBaGJs?=
 =?utf-8?B?S1ZMMHZTSVA5ZUVxaTJhSVJBT2RCUlVPbzVSQ1Fub0g3c0Mwb0duR3lIbGd2?=
 =?utf-8?B?SjBPeTNFMzVBbXpYMWQwcFlNa0pCcythZlM2VFFkZWRGdDZCZUYyWGtRMVlT?=
 =?utf-8?B?Ylp4aDlRY3UrQUZRSnNBN3lLRUNmbm0xMmVObEtnc3Y2KzIwMHRrNzl3YVIy?=
 =?utf-8?B?U2hHVUFFd3hHbi9kQjJTYmJGdXB5M2VYQkJTV1ZjeXBaZWVZYldCWHBmL0Np?=
 =?utf-8?B?UEYyTzV3dWZ0WnJINGVLTE1nZnpac3lOZUl1Vkp6TS9vWTkvbkIva0tyTXRM?=
 =?utf-8?B?LzZnN0VlZ21ldGFuSFl4NUdpaGVkcVBPY1NzcHZhK2JpTUZvRURRem1IVm4r?=
 =?utf-8?B?dkRoNFFpMys2b0F4TXh1Nm1zYTVxWjFqWUJxZ2hmOGRlbGU3OER0UmZDS0NU?=
 =?utf-8?B?WnRVbmQrMFJ2TW1vSkVkdkR2eG9TTnEvUHZqNEJ4TmZyN0pESGQvWTB0VFNu?=
 =?utf-8?B?dWtHNWc3VnRBeDRPN1ZyTTUzRmErQzJRMUJYTk0waW1uMEtuZVo5OEp2Zk84?=
 =?utf-8?B?UnNmMUEyTy94KzdmRERINGsrKzJPaHpVMUtJUWVSL1JMY0xlVXpIVUdUb3lN?=
 =?utf-8?B?UGloMWJUZEhSZTZLbzJIbzE2Vnc4dE1tcWUra3c4eG1XSDJDUmFsSWtYNkgv?=
 =?utf-8?B?aFBHVzh3UVJrSEhGUnhRZm9vQWJSTCtUUXhidjFWc25CL0U1Y2hSWmdJVlNK?=
 =?utf-8?B?NzlKZzBXVlJtOFE2UkdWcnlHQnZES1ZqUWZQTStvcmFONS9CbUJ5bWpmV1Ru?=
 =?utf-8?B?UURLNWxHRm9hUDdaeHNoeWlCanhBV0VOL25xZTIySWxnS2FYZmlONjFNNG5i?=
 =?utf-8?B?V3EwZDRSd2MybzNONE9TWWVmQVE5OWxraThOaFd6aFkvS3IvQWRhOWQxQXc9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: laPPdufflb3LcEZZ3zdbNLUOGBY7QZaQHdEOuWBiolm5+LybGEk/o+ENK1oyKkoEqLUEjM7XtbmFomiVRdr4+PkC5l4OTnXDyEXnSjoTBdxjzNKwGDp+M7rQL8s5u2yQuYd3ArJIrXb95kGtZjDu/kBMruMVIDza/zNiQBts3+ByG/L78CS1SauBqgi50D2yX14C6kxV3C77BPFpZaQ4e2lsvtTCdS0fyJhpY4ED1kPZdRRsUoiF5ueZW7gZGDwltzlhoIIjvl6CblF3wnLphUxwYtw/cxaAA49+ReaLiBtG8JeCtLqhZ2KHV8f2IC983bjRcggcw/xbAyIEWuZp45Q8BidMS0XshEBJhJnfh2SAuUfF9Q0/CR3Tco+sGdTJmNp8sTVS+uCssqWcJTI+cA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;6:EgM1S8NV8RiI5DlnAidybPfkpHU4Cz/JTjR/guIKuz+7tYbNEmOnBWxsZB4oR1pOKs1JnRmQ+tUkL53PToS/jLoZUioJ9zWscy1STOnMfpORfzGy+Z+dqVhGvv3iWiw3N07AjLgDBsFuQP5KzHcT9H4ZkTCcpsL6Fm29S1qbrU6tdDakU0UmnKJUS2Cw7nEwC/udvkVDs6QxplmTRniyCQ/PtX59rWIiRRTPjVQkMGfGDsk5c3Ifva6C5X1r9iVavANqD/OuHnvo2GGtnRSobRkrAayrx7aa6+0e8/OdHZ8nNvbFxx2jxbzwoHnRzT9lcMwiZPwiy6WFktcoz1bNq4Tjp+0tdXkfcx05m0g6rCgwJOF1dcPQNoT2de0tFM91V37nJwKGLlDBSf2q9e4dg5IrJGiX/vWTvvf+lBn0yglQghO85x5vo6QADpZd8INw9OM8B9w1kvld9GuYRJVgLw==;5:zkidH4RpFRFBBi8RIGd/ZBmlFaoAgjvyUMP7G3RLR7hmPEkOTMZmNIfPGlAyKMmRUY3qkN1B/tgetOh8+Pt7H3d2UFNoV065Ow5aKW4Knq6LqLrSa8hMUgzaPFTTJU8S272j66xUmiwupcdFSBPMqYT4eU/KwMJmYMyN3pmvQWs=;24:MxYWVXHH2SUk/jwkbUqqn7LQtYPkWN+a91EI3fsx4dZd28NzW03U4EV/RpUjpfniMEbKRsJJOxa3p1Ja7wPX0/F6EqWGRrfIyV1XEn38Pck=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;7:SnweCHPSJWhzdszlAz/QzqRUQaw/mobhLoadclZMjr3X0sP6rJIBMt+CWjWh/rveYMdPPgj55/BZL66cleHuciDjYaaqaZ0AOjxBwMDmSvI8yF7x6KwoFY/8FtdNJZLKyRfWVXzU3r83SJz0lgk/ACPzkK+DoDvQ674lm4u9PuzWZ5Q8SajCuGM+12++ZRVRxfIp1bCoxPBUizLuxAPfjbPx7+xLyhCUUAejTJZAFW0LVk1uRhyvhjRBVW1d13S2;20:ZCl/p4wskZoqQwciK3e7ESB0SPjfq9Q86IO9SXvmAQKnmm2G0kyFP2M6vbmjQRx2uhiuc721wrGzJgAQn3cLdRt70wNxlHDGXpQFafy66p1QltW3gqDHtX0FFKuTVH9MEyCxtjYHc5/PuqMGzWsKZ/rVcflp7nL1LAB9TK23BEBhep9XSNJ+hZWvIUNOcuIL2BK009tAYAbQ8KlTrPEOqot7KlEAbWw6bgWcNyGmqsDYz7JiTh8po4z/s8QYzbqV
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:05.6736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f71bf9e9-76e0-4166-6f58-08d5eda151bb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1340
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduce new Cadence USBSSP DRD driver
to linux kernel.

The Cadence USBSSP DRD Driver s a highly
configurable IP Core which can be
instantiated as Dual-Role Device (DRD),
Peripheral Only and Host Only (XHCI)
configurations.

The current driver has been validated with
FPGA burned. We have support for PCIe
bus, which is used on FPGA prototyping.

The host site of USBSSP controller is compliance
with XHCI specification, so it works with
standard XHCI linux driver.

Also, device side of USBSSP controller was designed
in such way to looks like XHCI. It means that
most of logic of USBSSP controller is also compliance
with XHCI specification.

Consequently, the USBSSP driver for peripheral mode
is very similar to XHCI driver.

This version of driver supports only Device mode but
DRD and Host mode will be added in the future.

---

Pawel Laszczak (31):
  usb: usbssp: Defined register maps and other useful structures.
  usb: usbssp: Added some decoding functions.
  usb: usbssp: Add trace events used in driver
  usb: usbssp: Added USBSSP platform driver
  usb: usbssp: Added first part of initialization sequence.
  usb: usbssp: added template functions used by upper layer.
  usb: usbssp: Initialization - added usbssp_mem_init
  usb: usbssp: Added ring and segment handling functions.
  usb: usbssp: add implementation of usbssp_mem_cleanup
  usb: usbssp: added usbssp_trb_in_td function.
  usb: usbssp: added function for stopping driver.
  usb: usbssp: added functions for queuing commands.
  usb: usbssp: addec procedure for handlin Port Status Change events.
  usb: usbssp: added procedure handling command completion events.
  usb: usbssp: added device controller error, transfer and SETUP
    completion event.
  usb: usbssp: added connect/disconnect procedures.
  usb: usbssp: added implementation of usbssp_halt_endpoint function.
  usb: usbssp: added handling of Port Reset event.
  usb: usbssp: added support for USB enumeration process.
  usb: usbssp: added queuing procedure for control transfer.
  usb: usbssp: added queuing procedure for BULK and INT transfer.
  usb: usbssp: added procedure removing request from transfer ring
  usb: usbssp: added implementation of transfer events.
  usb: usbssp: added detecting command timeout.
  usb: usbssp: added implementation of usbssp interface.
  usb: usbssp: added endpoint configuration functionality.
  usb: usbssp: implements usbssp_gadget_ep_enable function
  usb: usbssp: implemented usbssp_gadget_ep_disable function.
  usb: usbssp: added support for LPM.
  usb: usbssp: added support for TEST_MODE.
  usb: usbssp: add pci to platform driver wrapper.

 drivers/usb/Kconfig                  |    2 +
 drivers/usb/Makefile                 |    2 +
 drivers/usb/usbssp/Kconfig           |   29 +
 drivers/usb/usbssp/Makefile          |   15 +
 drivers/usb/usbssp/gadget-dbg.c      |   39 +
 drivers/usb/usbssp/gadget-ep0.c      |  571 +++++
 drivers/usb/usbssp/gadget-ext-caps.h |  102 +
 drivers/usb/usbssp/gadget-if.c       |  569 +++++
 drivers/usb/usbssp/gadget-mem.c      | 1938 +++++++++++++++
 drivers/usb/usbssp/gadget-port.c     |  287 +++
 drivers/usb/usbssp/gadget-ring.c     | 3452 ++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget-trace.c    |   13 +
 drivers/usb/usbssp/gadget-trace.h    |  482 ++++
 drivers/usb/usbssp/gadget.c          | 1909 ++++++++++++++
 drivers/usb/usbssp/gadget.h          | 2373 ++++++++++++++++++
 drivers/usb/usbssp/usbssp-pci-wrap.c |  226 ++
 drivers/usb/usbssp/usbssp-plat.c     |  186 ++
 17 files changed, 12195 insertions(+)
 create mode 100644 drivers/usb/usbssp/Kconfig
 create mode 100644 drivers/usb/usbssp/Makefile
 create mode 100644 drivers/usb/usbssp/gadget-dbg.c
 create mode 100644 drivers/usb/usbssp/gadget-ep0.c
 create mode 100644 drivers/usb/usbssp/gadget-ext-caps.h
 create mode 100644 drivers/usb/usbssp/gadget-if.c
 create mode 100644 drivers/usb/usbssp/gadget-mem.c
 create mode 100644 drivers/usb/usbssp/gadget-port.c
 create mode 100644 drivers/usb/usbssp/gadget-ring.c
 create mode 100644 drivers/usb/usbssp/gadget-trace.c
 create mode 100644 drivers/usb/usbssp/gadget-trace.h
 create mode 100644 drivers/usb/usbssp/gadget.c
 create mode 100644 drivers/usb/usbssp/gadget.h
 create mode 100644 drivers/usb/usbssp/usbssp-pci-wrap.c
 create mode 100644 drivers/usb/usbssp/usbssp-plat.c

-- 
2.17.1

