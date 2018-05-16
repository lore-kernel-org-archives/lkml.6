Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526459337-2-3775704370710856378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526459336; b=haKJhw5pUGPRb/LkkR8cdnu6vhBnbCTgjJ3J7r3Tl7yNdlBUX0
    9TFRzTZS7kOfKC2ajaT4WeaV6FbtZfn9W1DfRKiDRiy/NOa/rFlIoSPxWDDLtAn9
    BmJqYGSvg6JKtssunfZbHh8pWDzWdhRlViACV+TzguDC4ovXSA7RsQuYd/LRYXZq
    JAeCpcN1g/+k8x672/LepSKBY+hI5iUAamo1gDlq0Fu+MRvf57fD3KecFN7r9gQr
    4vSg9GbHoeEaKT9weRPhPDK1vfwIpdGb3VYjzRx7EPE/u/WZWLdGZ1u5G9360vNu
    9tupXyA3hAfRd0Y2VB14WNq5rs4gV64/M5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459336; bh=1a4Nj803UF86+1rhegVQXYo+JiD6C8
    oY/2jNVou1JUI=; b=erFRrrhwRD416UbipPf0cg261x6tUVz60cO2X7yy4HgY7J
    prFex561Wm4GfLF12AFT4lz5VKulnjrgKFA09F8qR/TpkGW6Y2XP8hqcc60mdD7K
    7sQmxm6KR0R29so3ec3njXhnnVxT4DJZKiKP+uJhU8k7G2aOx7IY0yyJ6ujcA1YI
    Urvn01X+wQs3QYUySB3F1waVZ70DLpZaoUVX9u3T05DB2l9rmDWEQRMFhnQsYpr+
    Dk6DGTaqQvj+hstbe5hvCRBu6tM4fMEgQR9mslv/YKp7YRSFeTz981vT9tPNBPZX
    qAfmzu7H+EmHqFBQS6LhIgY8fF96T+Y3dWNdM8Ng==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=h6LxgryM x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=caviumnetworks.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=h6LxgryM x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=caviumnetworks.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG8ExUpuj/zURP58xha4U6uloufO9B+gYjXZoxe8VaKF65XYA4IStfMZeo93mf7iLGxLV0lUl2KfUzVzc6LaU3/+kjVGmkJY11pryg/UMylF+WfLRnzY
    aibAhmbHfP5OOhSODdHSH8tUgQOloaNMLQXne7vLol+RP0lT/LRp7gaNNoxjNBct98M8byoNNAJl7H2qI560KaJ5EyEbiv3vNwXaSXJJC49L3sN7/ZHRUs8s
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=hxpFIyAUfPIA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8 a=EQenZLDqzTpsDMXT6KwA:9
    a=pqFLZ8xwInLg8M5k:21 a=GqzFPm4uB6p-GRtR:21 a=x8gzFH9gYPwA:10
    a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeEPIVe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:21:34 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:23517
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752912AbeEPIVZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:21:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: [PATCH 09/24] arm64: rename functions that reference compat term
Date: Wed, 16 May 2018 11:18:54 +0300
Message-Id: <20180516081910.10067-10-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0122.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::24) To DM6PR07MB4377.namprd07.prod.outlook.com
 (2603:10b6:5:bf::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4377;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;3:pflja9aTpa7pQs92glFty5RFxkspnka9EPzPAGLEw5+MlugXcG0QaO9upI4pSGgFVNycDxIL7VArOTcG50jk2q8ipBqu5EsPdVQ4inPwRCD0vBR2xinBxQKZMCGEn0bAflFLDEYxUXUnIJOB4dsyrmtMMxQIrPzswj0ZvFbNzyP1ePvZz5me1SQKOU04gesuBOOpZLLfX55ypSRymArokE4DfWsq4xmPLV+gl8BXM9i1pZRxxdKmvedUTH0tyQ7f;25:79WA3+3UjQDoOUd8YJGDnLSr5ogVgLZbwjalJTz/lsJ7T3JQDCf8t5oPtBar4YPvJ5QnXIPugQLrUE7ehAQvx9ZHmz8jSspPdOb4kLS9bKTcC5L0LcfWlwrbB5t2xj7OSK7madsg2Kr34ye3YJl7J3wTCsLvsW/D+rHkLDq+PG65myAWIgf/4EkHb/Rz+ZCvvwT5lUcxYj1yxyADJQlk+7GjgabFWg8lzT56/yJhjyaIutvz6nDSxFP2sS34+w/GIqY/0G6t4o0IoffQsE8YCyjSFOhC8tOYVLSQRKYR59oNU2yagF5yVYugzyWNrqoFupOWoOBd2BmPGLvZafKr9A==;31:K91fB2XfyDGE2LBa1LqoIpdHdmodv5glulc0uJ1T3MgQWML5qPeQ1S/+v1xUQmBEPlA95OrrABGJpG2AUPpo0xNwVnTgV0XjTRsf8LMTfEXmFEdbiLIxpG73t3iXpg7tWD18s2v1KsVmt2WOz0REnPC/J132GrtnPKSPO7jFfj83ubxZAWx+tUb5hcRKHw8uEHSjXAUT5h8e82EbVmG6XBdUyx3fhlaBDz/587HdVeQ=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4377:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;20:jKPKG1IUd8PxAZ629ovXAF+fO/exnISAlmcngi3ShmJ01BnteWi7ZxqKc31kjlqdU3p9QivEAN1Ttr5ngYPh1e3gtT/kQPi9JhKm/IZMQ7Q0SsTA4mIfiYVjHvnsHo3NKf6KUd0UmOv1PteydHyECRn+oWnDz5M7Zv0pQWCt7yEPsYF/SmJklj1U4g7CLM5Xw+MgVeh+Blp8SAarZRZXy4zwEG/BRooGsPAqVdp09LKzfEds81V9ZRtmWussy1T8XRCFGM4zXxUC3g2DZrpjDSiup0iZOLUIoZhXo+UVYSB5ISSa5yx4oxo0t14HdyybsbROSqCdYCBesz99WTx4HqxeEpeNsp+QRTdbusJW+5MkxAbpNEQ2q0OIxPLDwCdip1vUxeuBqh0VXfUkxGix8AQTLyU92d2IQS1wxXazPS6kVhQRHejhapbcH1HUPIASwQeUfjBXRmjb8EZ6OTxuLrMv522IQgU3PhS89d3s6EjYjWpyPcVTJCOgeoPKUPG+y/EAqvn0/RksG+TgV8l2bYaG173UsYN4Dww/r+zj+3LtqfpRjypmmupjLlDRmEad87hVPrtKW2YBJ4tjzYtEvS+r//hFwk1NKDO6o2SWA0E=;4:4luan4Y6XXDzxnPQr/JeCDTcfHQQ67fQZ5Xir67KuyteQO7qo9ZsA7L98O8o3shC9iM80ndG1xtOMx5n4Lc7/nzlNCQxBos89KXzYcYc1eWG7PTDnvFyo/F0eLfjH7DZYuvCi0nBUPbvgqIJWKnTC5F6qn1y4ctktEYuP9ONfnou7ho2y9XyOHMoHOlkckeoh/RbiaNlzzNQyMcBuMHmxwXOCOD2z3nWnhpfi38iyrOJFhPGuR9qYs1g92Fluk5T9TKSV+zzDRYzZPqUyuRw5Q==
X-Microsoft-Antispam-PRVS: <DM6PR07MB4377FACE780FEDBA71C3B71DE3920@DM6PR07MB4377.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM6PR07MB4377;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4377;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(346002)(39380400002)(366004)(39860400002)(199004)(189003)(7416002)(76506005)(2616005)(8936002)(53936002)(6496006)(476003)(956004)(81166006)(81156014)(6666003)(8676002)(36756003)(66066001)(6486002)(5660300001)(446003)(105586002)(7406005)(106356001)(575784001)(47776003)(68736007)(11346002)(39060400002)(76176011)(2906002)(6116002)(3846002)(26005)(1076002)(48376002)(50466002)(486006)(386003)(186003)(72206003)(305945005)(59450400001)(16586007)(316002)(97736004)(50226002)(42882007)(110136005)(478600001)(25786009)(52116002)(54906003)(51416003)(4326008)(16526019)(7736002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4377;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4377;23:wpV01EPG7jqJd90b6HOuVkUH7FzA3RJfDx/8ifqjo?=
 =?us-ascii?Q?J9jRh28swQucXEKlbOiPW258PKVHNOmyYKNeiswXTzmgFjbK0NUa7EVn8Usj?=
 =?us-ascii?Q?0CeddI9kCZrIB/GKmdBN+9nJX2xDwi35tAnPlz3DEaadRhcWJATDpCQYp0Ii?=
 =?us-ascii?Q?T+qog+ZqOqt1QN3E8MY/tkeHeX4AT+eu7HVYxM54WnFsbDMmSZZOCONqpZ27?=
 =?us-ascii?Q?v1hQy2NN6DN2aFDgNUhyZRjaFPiL9YV76STRG35xCMsf6m76UpTLX7ZG3v4j?=
 =?us-ascii?Q?nhJXsHggN2y22iiHAZzF7N0ZJyOQ1CATrAKstNVLak14vtYpZmxs9znTaeNT?=
 =?us-ascii?Q?iy4gzWs3KPw/imiLnhVkkJEyvxv/jAu+L7QXpYctG9TtSS8Xag7UtKwIYBDw?=
 =?us-ascii?Q?xvdnpTvF2yiVSuLvkyoxicAESuaJSEyK1K9LqeyFGFeK7dcYHuO5AVTII2dD?=
 =?us-ascii?Q?/uwEUsgfipZAc0QUxfrQr9++SnLYH9ifbAKutrtDlyuNmBakfroJUROqPr9T?=
 =?us-ascii?Q?nvVsZLiH0NzO+li1gRnoFsAvf8TjgNzddRJVpWaDjfIo/ysq+x1gBTAVLLDK?=
 =?us-ascii?Q?2uMR/yG3F+TU5hEqgmcV2DXtbGl3J6Kt/c9qxCWp1pb+l8V9HmNtqkGUHPky?=
 =?us-ascii?Q?iyTtaOHwXarfRm7JuyE5d/y0xsCCUCIjjG8SEpe7OVadjERIlMYIfKeGmVmB?=
 =?us-ascii?Q?uxne8yfyR6M4XhKtfch34aEcY2LQm7X2XyRLTDr6WxbS1NRdVtxgUEmDCfBX?=
 =?us-ascii?Q?XepQ3OPge6DQFWFlXotTvQ6u+keDAZPvn2cApvDQ4CxLD8RkEOjNK1zZC9YQ?=
 =?us-ascii?Q?6O4FWZedY5PqIFt1hjMw7ecFC8TbWCz0MuHJlHMsx7sSLDzKwaerRZsL24IA?=
 =?us-ascii?Q?NT/8Lie9vqaVQO3dpS6j3QU4sn6HA7xRM2/EBfJKh/iUcjWYGVMturwYeT+q?=
 =?us-ascii?Q?VM7OwYak+9WcOile8pHeJiqFw9bMUk+BUGzrjiihv2toxSTHs0GAsRg22tFF?=
 =?us-ascii?Q?VWllwfQeOsnt+lWvcdl4SXsz3P7dhSWyHAL0CXhjlPSNQvPvPqqGN12mQrYM?=
 =?us-ascii?Q?5VKynz9591cldI3BQy7k318nWDB6js/seqAJYvCWlgwnD9C21weZJ5AmBEFs?=
 =?us-ascii?Q?SwHpUhlFo/ghW9l3Jrm+6PKtVL+S6336SVzpXO2nYbnkX5xmzEGmBoqdM5Gf?=
 =?us-ascii?Q?P3ws2GrSg4f0VHgyG+2Vm8cOeyx2dtMckyOk2iGRNyBwqneBF4S8OKZrz0/o?=
 =?us-ascii?Q?Z9IrOBBpNZjLGtbIrmcIPleG97KVMzXFMdInOCeWK51R2lO3z7db1b29IRjq?=
 =?us-ascii?Q?H5rBgzgXvpWMVX44EKSPNcMGh5jq3P3xjpYTYpM8RCPiHEkjqo3KxwUSdtVJ?=
 =?us-ascii?Q?2LFBealqFysEA5EHgzkfP3qYLZdmLfXiC9Iv5E3cCb1Ox5X?=
X-Microsoft-Antispam-Message-Info: qpVfOFRR87Mesa1l6s9sFTRvbw3aL3aGV3/6cdkss0OqVBClzoyFrHqvqKEYCG5b27BGlH29O95YLLlSpj9GwHGpIi1kNXmQ6YNsVlgjsPBCQH4y+iTnaMe+UMMfLraLniP1DA7gGnxR0jca+uGSJxNo1ahwQNT5Sy+gfDzr1T2bYO+WnG08rQAIyqNGk1uW
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;6:VRrQnlVODomOiOmcQBhmJIgwmPBDO/Unr7qFQHxauhs8ATGPkDYcGFNhLLrbKnxXGfqbT+etg/nlAlteLtNM2B174oFbjH4LNce9A6UcF+nANFOd5g+CIkss7c5RU0TUd1kVmvhCJMufmzg1Fsd/AIHif69dc5W6bp/ibWVmt8mpkAtvWctcrN0T6CUjcJ8Hh4wI3mnnNDmf7GFN7agmR+TFhtrPkjgvaNSEm/L96BM+xS/rmHDEEq+3HtBCQEueWQIIw9FN7YDaVCuHjprfMUSnbagP5IfG86HBYcXDi4BWjI3zUmcn0wP3MMl3BonZjRH5/s+IEXwBpZZTNTKtMNDDEq2VRuaJbi9oQycLh4v6FxbP+UZ+vTzfG6w1u71wbYm+Ocb56P/YPHyTBu4+6V3sYGl2AbSJooTustnX75JeEqPbSo00iOGR9R4YLBNTQaPsnwpzOXFEfYlhV+Xz6A==;5:1AB32XayNS1PNQ45sm0dU9IaLn6Kb0U01b7RT+GPevjERjnkU/pZbCkHweJYwlK/NMCMsgs+/bWD3Vk1dpx4X1WgRxLR0mAQAAnBfwoyWEo193UMRWPvQEgnf6OXhEl6xW6DY9B/ZXGZedMbVIQGYhx4dIzfdpQsTgHWa5HJJBo=;24:lQuZxiGisTfnZZQjJDMTo3bnkiiEXgk2Ucii0AGWNYbLawJJNM3ETDVVcbV+uS0aJQ5KgjjPn51h17cTHLk6LLMuA3O873C3eVX84VQ1RbQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;7:w6SwtJgslA3Un9t+sxQe0hy0d0kNjQZqzFC7L4+XKyqH+gEIuJm9stri8s192CMhO7B7BIgCOawlc7t7Rz+47JlDNNZwyOzpbP3o2TlPOWchilenxstAxeUZi5PXoOIJodBLzC+M9fKmc20LDRogRorvU6XOnm9MaC4wQO7lJEblPfNLGGood85549jEu9Wtkpglvn2Zg/OrRDwDA6MymBHbmKhOMXPg+9yzZ9Z5KESrziCAIYFQNAYMQnkq8epw
X-MS-Office365-Filtering-Correlation-Id: 8975bcfc-ed95-4f8b-5893-08d5bb060132
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:21:20.0348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8975bcfc-ed95-4f8b-5893-08d5bb060132
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4377
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ILP32 for ARM64 patch series introduces another 'compat' mode for
arm64. So to avoid confusing, aarch32-only functions renamed in according
to it.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/ptrace.h      | 10 ++--
 arch/arm64/include/asm/signal32.h    | 13 ++--
 arch/arm64/kernel/armv8_deprecated.c |  6 +-
 arch/arm64/kernel/cpufeature.c       |  6 +-
 arch/arm64/kernel/debug-monitors.c   |  4 +-
 arch/arm64/kernel/perf_callchain.c   | 22 +++----
 arch/arm64/kernel/perf_regs.c        |  2 +-
 arch/arm64/kernel/process.c          |  4 +-
 arch/arm64/kernel/signal.c           |  8 +--
 arch/arm64/kernel/signal32.c         | 88 ++++++++++++++--------------
 arch/arm64/kernel/sys_compat.c       | 10 ++--
 arch/arm64/kernel/traps.c            |  6 +-
 12 files changed, 90 insertions(+), 89 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 0c85b469ad68..1ca181a6903a 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -155,16 +155,16 @@ static inline void forget_syscall(struct pt_regs *regs)
 #define arch_has_single_step()	(1)
 
 #ifdef CONFIG_AARCH32_EL0
-#define compat_thumb_mode(regs) \
+#define a32_thumb_mode(regs) \
 	(((regs)->pstate & COMPAT_PSR_T_BIT))
 #else
-#define compat_thumb_mode(regs) (0)
+#define a32_thumb_mode(regs) (0)
 #endif
 
 #define user_mode(regs)	\
 	(((regs)->pstate & PSR_MODE_MASK) == PSR_MODE_EL0t)
 
-#define compat_user_mode(regs)	\
+#define a32_user_mode(regs)	\
 	(((regs)->pstate & (PSR_MODE32_BIT | PSR_MODE_MASK)) == \
 	 (PSR_MODE32_BIT | PSR_MODE_EL0t))
 
@@ -178,10 +178,10 @@ static inline void forget_syscall(struct pt_regs *regs)
 	(!((regs)->pstate & PSR_F_BIT))
 
 #define GET_USP(regs) \
-	(!compat_user_mode(regs) ? (regs)->sp : (regs)->compat_sp)
+	(!a32_user_mode(regs) ? (regs)->sp : (regs)->compat_sp)
 
 #define SET_USP(ptregs, value) \
-	(!compat_user_mode(regs) ? ((regs)->sp = value) : ((regs)->compat_sp = value))
+	(!a32_user_mode(regs) ? ((regs)->sp = value) : ((regs)->compat_sp = value))
 
 extern int regs_query_register_offset(const char *name);
 extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 2ebde460f5a0..92f48828b13a 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -24,27 +24,28 @@
 
 #define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
 
-int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
+int a32_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
-int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+
+int a32_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs);
 
-void compat_setup_restart_syscall(struct pt_regs *regs);
+void a32_setup_restart_syscall(struct pt_regs *regs);
 #else
 
-static inline int compat_setup_frame(int usid, struct ksignal *ksig,
+static inline int a32_setup_frame(int usid, struct ksignal *ksig,
 				     sigset_t *set, struct pt_regs *regs)
 {
 	return -ENOSYS;
 }
 
-static inline int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+static inline int a32_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 					struct pt_regs *regs)
 {
 	return -ENOSYS;
 }
 
-static inline void compat_setup_restart_syscall(struct pt_regs *regs)
+static inline void a32_setup_restart_syscall(struct pt_regs *regs)
 {
 }
 #endif /* CONFIG_AARCH32_EL0 */
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 68450e954d47..b4f5ab915a0d 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -555,7 +555,7 @@ static int setend_set_hw_mode(bool enable)
 	return 0;
 }
 
-static int compat_setend_handler(struct pt_regs *regs, u32 big_endian)
+static int __a32_setend_handler(struct pt_regs *regs, u32 big_endian)
 {
 	char *insn;
 
@@ -578,14 +578,14 @@ static int compat_setend_handler(struct pt_regs *regs, u32 big_endian)
 
 static int a32_setend_handler(struct pt_regs *regs, u32 instr)
 {
-	int rc = compat_setend_handler(regs, (instr >> 9) & 1);
+	int rc = __a32_setend_handler(regs, (instr >> 9) & 1);
 	arm64_skip_faulting_instruction(regs, 4);
 	return rc;
 }
 
 static int t16_setend_handler(struct pt_regs *regs, u32 instr)
 {
-	int rc = compat_setend_handler(regs, (instr >> 3) & 1);
+	int rc = __a32_setend_handler(regs, (instr >> 3) & 1);
 	arm64_skip_faulting_instruction(regs, 2);
 	return rc;
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1ea242547466..28b7bc582334 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1132,7 +1132,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	{},
 };
 
-static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
+static const struct arm64_cpu_capabilities a32_elf_hwcaps[] = {
 #ifdef CONFIG_AARCH32_EL0
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
@@ -1331,7 +1331,7 @@ static void verify_local_cpu_capabilities(void)
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
-		verify_local_elf_hwcaps(compat_elf_hwcaps);
+		verify_local_elf_hwcaps(a32_elf_hwcaps);
 
 	if (system_supports_sve())
 		verify_sve_features();
@@ -1394,7 +1394,7 @@ void __init setup_cpu_features(void)
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
-		setup_elf_hwcaps(compat_elf_hwcaps);
+		setup_elf_hwcaps(a32_elf_hwcaps);
 
 	sve_setup();
 
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 53781f5687c5..541f681c3203 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -338,10 +338,10 @@ int aarch32_break_handler(struct pt_regs *regs)
 	bool bp = false;
 	void __user *pc = (void __user *)instruction_pointer(regs);
 
-	if (!compat_user_mode(regs))
+	if (!a32_user_mode(regs))
 		return -EFAULT;
 
-	if (compat_thumb_mode(regs)) {
+	if (a32_thumb_mode(regs)) {
 		/* get 16-bit Thumb instruction */
 		__le16 instr;
 		get_user(instr, (__le16 __user *)pc);
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 32e07818835d..6019d53d4ec6 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -64,21 +64,21 @@ user_backtrace(struct frame_tail __user *tail,
  * The registers we're interested in are at the end of the variable
  * length saved register structure. The fp points at the end of this
  * structure so the address of this struct is:
- * (struct compat_frame_tail *)(xxx->fp)-1
+ * (struct a32_frame_tail *)(xxx->fp)-1
  *
  * This code has been adapted from the ARM OProfile support.
  */
-struct compat_frame_tail {
-	compat_uptr_t	fp; /* a (struct compat_frame_tail *) in compat mode */
+struct a32_frame_tail {
+	compat_uptr_t	fp; /* a (struct a32_frame_tail *) in compat mode */
 	u32		sp;
 	u32		lr;
 } __attribute__((packed));
 
-static struct compat_frame_tail __user *
-compat_user_backtrace(struct compat_frame_tail __user *tail,
+static struct a32_frame_tail __user *
+compat_user_backtrace(struct a32_frame_tail __user *tail,
 		      struct perf_callchain_entry_ctx *entry)
 {
-	struct compat_frame_tail buftail;
+	struct a32_frame_tail buftail;
 	unsigned long err;
 
 	/* Also check accessibility of one struct frame_tail beyond */
@@ -98,11 +98,11 @@ compat_user_backtrace(struct compat_frame_tail __user *tail,
 	 * Frame pointers should strictly progress back up the stack
 	 * (towards higher addresses).
 	 */
-	if (tail + 1 >= (struct compat_frame_tail __user *)
+	if (tail + 1 >= (struct a32_frame_tail __user *)
 			compat_ptr(buftail.fp))
 		return NULL;
 
-	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
+	return (struct a32_frame_tail __user *)compat_ptr(buftail.fp) - 1;
 }
 #endif /* CONFIG_AARCH32_EL0 */
 
@@ -116,7 +116,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 
 	perf_callchain_store(entry, regs->pc);
 
-	if (!compat_user_mode(regs)) {
+	if (!a32_user_mode(regs)) {
 		/* AARCH64 mode */
 		struct frame_tail __user *tail;
 
@@ -128,9 +128,9 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	} else {
 #ifdef CONFIG_AARCH32_EL0
 		/* AARCH32 compat mode */
-		struct compat_frame_tail __user *tail;
+		struct a32_frame_tail __user *tail;
 
-		tail = (struct compat_frame_tail __user *)regs->compat_fp - 1;
+		tail = (struct a32_frame_tail __user *)regs->compat_fp - 1;
 
 		while ((entry->nr < entry->max_stack) &&
 			tail && !((unsigned long)tail & 0x3))
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 1d091d048d04..513e279b12d3 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -19,7 +19,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	 * - PC has been set in the pt_regs struct in kernel_entry,
 	 * - Handle SP and LR here.
 	 */
-	if (compat_user_mode(regs)) {
+	if (a32_user_mode(regs)) {
 		if ((u32)idx == PERF_REG_ARM64_SP)
 			return regs->compat_sp;
 		if ((u32)idx == PERF_REG_ARM64_LR)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c0da6efe5465..105f79d126ee 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -174,7 +174,7 @@ static void print_pstate(struct pt_regs *regs)
 {
 	u64 pstate = regs->pstate;
 
-	if (compat_user_mode(regs)) {
+	if (a32_user_mode(regs)) {
 		printk("pstate: %08llx (%c%c%c%c %c %s %s %c%c%c)\n",
 			pstate,
 			pstate & COMPAT_PSR_N_BIT ? 'N' : 'n',
@@ -208,7 +208,7 @@ void __show_regs(struct pt_regs *regs)
 	int i, top_reg;
 	u64 lr, sp;
 
-	if (compat_user_mode(regs)) {
+	if (a32_user_mode(regs)) {
 		lr = regs->compat_lr;
 		sp = regs->compat_sp;
 		top_reg = 12;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 65406218743c..fb7c1a510ed4 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -779,7 +779,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 static void setup_restart_syscall(struct pt_regs *regs)
 {
 	if (is_compat_task())
-		compat_setup_restart_syscall(regs);
+		a32_setup_restart_syscall(regs);
 	else
 		regs->regs[8] = __NR_restart_syscall;
 }
@@ -799,9 +799,9 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	 */
 	if (is_compat_task()) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-			ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
+			ret = a32_setup_rt_frame(usig, ksig, oldset, regs);
 		else
-			ret = compat_setup_frame(usig, ksig, oldset, regs);
+			ret = a32_setup_frame(usig, ksig, oldset, regs);
 	} else {
 		ret = setup_rt_frame(usig, ksig, oldset, regs);
 	}
@@ -841,7 +841,7 @@ static void do_signal(struct pt_regs *regs)
 	 */
 	if (in_syscall(regs)) {
 		continue_addr = regs->pc;
-		restart_addr = continue_addr - (compat_thumb_mode(regs) ? 2 : 4);
+		restart_addr = continue_addr - (a32_thumb_mode(regs) ? 2 : 4);
 		retval = regs->regs[0];
 
 		/*
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 79feb861929b..739e13b54820 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -29,7 +29,7 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
-struct compat_sigcontext {
+struct a32_sigcontext {
 	/* We always set these two fields to 0 */
 	compat_ulong_t			trap_no;
 	compat_ulong_t			error_code;
@@ -55,17 +55,17 @@ struct compat_sigcontext {
 	compat_ulong_t			fault_address;
 };
 
-struct compat_ucontext {
+struct a32_ucontext {
 	compat_ulong_t			uc_flags;
 	compat_uptr_t			uc_link;
 	compat_stack_t			uc_stack;
-	struct compat_sigcontext	uc_mcontext;
+	struct a32_sigcontext		uc_mcontext;
 	compat_sigset_t			uc_sigmask;
 	int		__unused[32 - (sizeof (compat_sigset_t) / sizeof (int))];
 	compat_ulong_t	uc_regspace[128] __attribute__((__aligned__(8)));
 };
 
-struct compat_vfp_sigframe {
+struct a32_vfp_sigframe {
 	compat_ulong_t	magic;
 	compat_ulong_t	size;
 	struct compat_user_vfp {
@@ -80,25 +80,25 @@ struct compat_vfp_sigframe {
 } __attribute__((__aligned__(8)));
 
 #define VFP_MAGIC		0x56465001
-#define VFP_STORAGE_SIZE	sizeof(struct compat_vfp_sigframe)
+#define VFP_STORAGE_SIZE	sizeof(struct a32_vfp_sigframe)
 
 #define FSR_WRITE_SHIFT		(11)
 
-struct compat_aux_sigframe {
-	struct compat_vfp_sigframe	vfp;
+struct a32_aux_sigframe {
+	struct a32_vfp_sigframe	vfp;
 
 	/* Something that isn't a valid magic number for any coprocessor.  */
 	unsigned long			end_magic;
 } __attribute__((__aligned__(8)));
 
-struct compat_sigframe {
-	struct compat_ucontext	uc;
+struct a32_sigframe {
+	struct a32_ucontext	uc;
 	compat_ulong_t		retcode[2];
 };
 
-struct compat_rt_sigframe {
+struct a32_rt_sigframe {
 	struct compat_siginfo info;
-	struct compat_sigframe sig;
+	struct a32_sigframe sig;
 };
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
@@ -129,7 +129,7 @@ static inline int get_sigset_t(sigset_t *set,
  * VFP save/restore code.
  *
  * We have to be careful with endianness, since the fpsimd context-switch
- * code operates on 128-bit (Q) register values whereas the compat ABI
+ * code operates on 128-bit (Q) register values whereas the a32 ABI
  * uses an array of 64-bit (D) registers. Consequently, we need to swap
  * the two halves of each Q register when running on a big-endian CPU.
  */
@@ -146,7 +146,7 @@ union __fpsimd_vreg {
 	};
 };
 
-static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
+static int a32_preserve_vfp_context(struct a32_vfp_sigframe __user *frame)
 {
 	struct user_fpsimd_state const *fpsimd =
 		&current->thread.fpsimd_state.user_fpsimd;
@@ -196,7 +196,7 @@ static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 	return err ? -EFAULT : 0;
 }
 
-static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
+static int a32_restore_vfp_context(struct a32_vfp_sigframe __user *frame)
 {
 	struct user_fpsimd_state fpsimd;
 	compat_ulong_t magic = VFP_MAGIC;
@@ -236,12 +236,12 @@ static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
 	return err ? -EFAULT : 0;
 }
 
-static int compat_restore_sigframe(struct pt_regs *regs,
-				   struct compat_sigframe __user *sf)
+static int a32_restore_sigframe(struct pt_regs *regs,
+				   struct a32_sigframe __user *sf)
 {
 	int err;
 	sigset_t set;
-	struct compat_aux_sigframe __user *aux;
+	struct a32_aux_sigframe __user *aux;
 
 	err = get_sigset_t(&set, &sf->uc.uc_sigmask);
 	if (err == 0) {
@@ -274,16 +274,16 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 
 	err |= !valid_user_regs(&regs->user_regs, current);
 
-	aux = (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
+	aux = (struct a32_aux_sigframe __user *) sf->uc.uc_regspace;
 	if (err == 0)
-		err |= compat_restore_vfp_context(&aux->vfp);
+		err |= a32_restore_vfp_context(&aux->vfp);
 
 	return err;
 }
 
 asmlinkage int compat_sys_sigreturn(struct pt_regs *regs)
 {
-	struct compat_sigframe __user *frame;
+	struct a32_sigframe __user *frame;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -296,12 +296,12 @@ asmlinkage int compat_sys_sigreturn(struct pt_regs *regs)
 	if (regs->compat_sp & 7)
 		goto badframe;
 
-	frame = (struct compat_sigframe __user *)regs->compat_sp;
+	frame = (struct a32_sigframe __user *)regs->compat_sp;
 
 	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
 		goto badframe;
 
-	if (compat_restore_sigframe(regs, frame))
+	if (a32_restore_sigframe(regs, frame))
 		goto badframe;
 
 	return regs->regs[0];
@@ -317,7 +317,7 @@ asmlinkage int compat_sys_sigreturn(struct pt_regs *regs)
 
 asmlinkage int compat_sys_rt_sigreturn(struct pt_regs *regs)
 {
-	struct compat_rt_sigframe __user *frame;
+	struct a32_rt_sigframe __user *frame;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -330,12 +330,12 @@ asmlinkage int compat_sys_rt_sigreturn(struct pt_regs *regs)
 	if (regs->compat_sp & 7)
 		goto badframe;
 
-	frame = (struct compat_rt_sigframe __user *)regs->compat_sp;
+	frame = (struct a32_rt_sigframe __user *)regs->compat_sp;
 
 	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
 		goto badframe;
 
-	if (compat_restore_sigframe(regs, &frame->sig))
+	if (a32_restore_sigframe(regs, &frame->sig))
 		goto badframe;
 
 	if (compat_restore_altstack(&frame->sig.uc.uc_stack))
@@ -352,7 +352,7 @@ asmlinkage int compat_sys_rt_sigreturn(struct pt_regs *regs)
 	return 0;
 }
 
-static void __user *compat_get_sigframe(struct ksignal *ksig,
+static void __user *a32_get_sigframe(struct ksignal *ksig,
 					struct pt_regs *regs,
 					int framesize)
 {
@@ -373,7 +373,7 @@ static void __user *compat_get_sigframe(struct ksignal *ksig,
 	return frame;
 }
 
-static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+static void a32_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 				compat_ulong_t __user *rc, void __user *frame,
 				int usig)
 {
@@ -417,10 +417,10 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->pstate	= spsr;
 }
 
-static int compat_setup_sigframe(struct compat_sigframe __user *sf,
+static int a32_setup_sigframe(struct a32_sigframe __user *sf,
 				 struct pt_regs *regs, sigset_t *set)
 {
-	struct compat_aux_sigframe __user *aux;
+	struct a32_aux_sigframe __user *aux;
 	int err = 0;
 
 	__put_user_error(regs->regs[0], &sf->uc.uc_mcontext.arm_r0, err);
@@ -442,7 +442,7 @@ static int compat_setup_sigframe(struct compat_sigframe __user *sf,
 	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.arm_cpsr, err);
 
 	__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.trap_no, err);
-	/* set the compat FSR WnR */
+	/* set the aarch32 FSR WnR */
 	__put_user_error(!!(current->thread.fault_code & ESR_ELx_WNR) <<
 			 FSR_WRITE_SHIFT, &sf->uc.uc_mcontext.error_code, err);
 	__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fault_address, err);
@@ -450,25 +450,25 @@ static int compat_setup_sigframe(struct compat_sigframe __user *sf,
 
 	err |= put_sigset_t(&sf->uc.uc_sigmask, set);
 
-	aux = (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
+	aux = (struct a32_aux_sigframe __user *) sf->uc.uc_regspace;
 
 	if (err == 0)
-		err |= compat_preserve_vfp_context(&aux->vfp);
+		err |= a32_preserve_vfp_context(&aux->vfp);
 	__put_user_error(0, &aux->end_magic, err);
 
 	return err;
 }
 
 /*
- * 32-bit signal handling routines called from signal.c
+ * aarch32-bit signal handling routines called from signal.c
  */
-int compat_setup_rt_frame(int usig, struct ksignal *ksig,
+int a32_setup_rt_frame(int usig, struct ksignal *ksig,
 			  sigset_t *set, struct pt_regs *regs)
 {
-	struct compat_rt_sigframe __user *frame;
+	struct a32_rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
+	frame = a32_get_sigframe(ksig, regs, sizeof(*frame));
 
 	if (!frame)
 		return 1;
@@ -480,10 +480,10 @@ int compat_setup_rt_frame(int usig, struct ksignal *ksig,
 
 	err |= __compat_save_altstack(&frame->sig.uc.uc_stack, regs->compat_sp);
 
-	err |= compat_setup_sigframe(&frame->sig, regs, set);
+	err |= a32_setup_sigframe(&frame->sig, regs, set);
 
 	if (err == 0) {
-		compat_setup_return(regs, &ksig->ka, frame->sig.retcode, frame, usig);
+		a32_setup_return(regs, &ksig->ka, frame->sig.retcode, frame, usig);
 		regs->regs[1] = (compat_ulong_t)(unsigned long)&frame->info;
 		regs->regs[2] = (compat_ulong_t)(unsigned long)&frame->sig.uc;
 	}
@@ -491,27 +491,27 @@ int compat_setup_rt_frame(int usig, struct ksignal *ksig,
 	return err;
 }
 
-int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
+int a32_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs)
 {
-	struct compat_sigframe __user *frame;
+	struct a32_sigframe __user *frame;
 	int err = 0;
 
-	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
+	frame = a32_get_sigframe(ksig, regs, sizeof(*frame));
 
 	if (!frame)
 		return 1;
 
 	__put_user_error(0x5ac3c35a, &frame->uc.uc_flags, err);
 
-	err |= compat_setup_sigframe(frame, regs, set);
+	err |= a32_setup_sigframe(frame, regs, set);
 	if (err == 0)
-		compat_setup_return(regs, &ksig->ka, frame->retcode, frame, usig);
+		a32_setup_return(regs, &ksig->ka, frame->retcode, frame, usig);
 
 	return err;
 }
 
-void compat_setup_restart_syscall(struct pt_regs *regs)
+void a32_setup_restart_syscall(struct pt_regs *regs)
 {
        regs->regs[7] = __NR_compat_restart_syscall;
 }
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index a382b2a1b84e..44eabb78d116 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -30,7 +30,7 @@
 #include <asm/unistd.h>
 
 static long
-__do_compat_cache_op(unsigned long start, unsigned long end)
+__do_a32_cache_op(unsigned long start, unsigned long end)
 {
 	long ret;
 
@@ -52,7 +52,7 @@ __do_compat_cache_op(unsigned long start, unsigned long end)
 }
 
 static inline long
-do_compat_cache_op(unsigned long start, unsigned long end, int flags)
+do_a32_cache_op(unsigned long start, unsigned long end, int flags)
 {
 	if (end < start || flags)
 		return -EINVAL;
@@ -60,12 +60,12 @@ do_compat_cache_op(unsigned long start, unsigned long end, int flags)
 	if (!access_ok(VERIFY_READ, (const void __user *)start, end - start))
 		return -EFAULT;
 
-	return __do_compat_cache_op(start, end);
+	return __do_a32_cache_op(start, end);
 }
 /*
  * Handle all unrecognised system calls.
  */
-long compat_arm_syscall(struct pt_regs *regs)
+long a32_arm_syscall(struct pt_regs *regs)
 {
 	unsigned int no = regs->regs[7];
 
@@ -85,7 +85,7 @@ long compat_arm_syscall(struct pt_regs *regs)
 	 * the specified region).
 	 */
 	case __ARM_NR_compat_cacheflush:
-		return do_compat_cache_op(regs->regs[0], regs->regs[1], regs->regs[2]);
+		return do_a32_cache_op(regs->regs[0], regs->regs[1], regs->regs[2]);
 
 	case __ARM_NR_compat_set_tls:
 		current->thread.tp_value = regs->regs[0];
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 691b3bbc7606..d2ebfc2f4fbc 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -278,7 +278,7 @@ static int call_undef_hook(struct pt_regs *regs)
 	if (!user_mode(regs))
 		return 1;
 
-	if (compat_thumb_mode(regs)) {
+	if (a32_thumb_mode(regs)) {
 		/* 16-bit Thumb instruction */
 		__le16 instr_le;
 		if (get_user(instr_le, (__le16 __user *)pc))
@@ -513,14 +513,14 @@ asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
 	do_undefinstr(regs);
 }
 
-long compat_arm_syscall(struct pt_regs *regs);
+long a32_arm_syscall(struct pt_regs *regs);
 
 asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
 #ifdef CONFIG_AARCH32_EL0
 	long ret;
 	if (is_compat_task()) {
-		ret = compat_arm_syscall(regs);
+		ret = a32_arm_syscall(regs);
 		if (ret != -ENOSYS)
 			return ret;
 	}
-- 
2.17.0

