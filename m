Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4128544-1526459311-2-13572235633628969262
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526459311; b=Irbusy678DtMFI9GCZ/cwbxLkR8jACp+Vk767CxvdtXTN2caHf
    YkZ9EYWbmE1P+qJRsCGpmomBsqbYAT4I91ER78PRbx6uWkeD9KHo1z5amUlWv5UA
    EhRDCHLI1wVt4qEcQ9b48zYRvurV4kmfLjQmRjlgo4kPLyFjDj3X6PAEjFgkF+GV
    cDWFuiwpzcmvTDCKQNgFlMYrlPTIHtK8fkc0/eZzktrG3+Yq2ecD1CGhYiMerI4Y
    HSi3dGxsGd/f8PWrwoxC3CeEySRk/6eWAHwwZdVcnZ8QZB26HOeHsfa+B1Wqi5Mw
    vTeFrlP5M9wgcuyzRsK/r/vA9DnnxjFi1vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459311; bh=P5w528j4bczk0Ipom5WxyO0jHYTCR1
    +UeJPhzoYmkoo=; b=dsLRd4F8WK5AKz9gco43KuMvi5tOZr3ktvNqaB56UD3Br7
    hws4y0kqZNPS3iXJigmFxhRXQeshC49cARIFIgoz8uBub1w1bsxQ3EYEcRMXgGVt
    qQpXwF8Tx4NsFHiScW8mVKaiJnS+hldu/d7kKmc0Xhj9J7lPzkxeZ+6ic6BDio6m
    IotVOuw3P9rTy/nyETAePbA/4gI6ahnEuDQH+japO0MfBHoXjhdOwYBHbbV8wC2z
    sU89z3dDbjTwmo31EbgGiVmMykAKDeDQc3mlIbBNflSt4F05zzoeb7fB1jd6uzEv
    fL2iVWNTh1Xco5Ipb0K8IsW3Cpfxlq+OL4rljNVA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=aqRikEsw x-bits=1024
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=aqRikEsw x-bits=1024
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
X-CM-Envelope: MS4wfGYP7TqZkXVTew6RBMJP0Levok5NTGBWt2Oikb4mYbrhI8OMUHP03hkUOTbgKp9KGHJCiFGyvhAqE0l8RsJRphs5Q/vbluFqRjX2IMATOnFV1w6tUagk
    xXOqMWQQGZkStyCof5phND9gHiB8bLyIH4UvjohIHe+q8X89LFlc0UKUFK34I6x+jLUbBjrBOntETTtfKkfLu8HAJKapuFa0spa9Aye1Di5VFSV/rx4k2xvK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=Ef6v7InKE84A:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=NXpJzYs8AAAA:8 a=VwQbUJbxAAAA:8
    a=uzbUAyuzZ7kqyHK0DjYA:9 a=k6dicGi_3wLnj0B0:21 a=emnqsAJtfy2EdJZi:21
    a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22 a=cwV61pgf2j4Cq8VD9hE_:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeEPIVz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:21:55 -0400
Received: from mail-sn1nam02on0060.outbound.protection.outlook.com ([104.47.36.60]:31712
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752939AbeEPIVv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:21:51 -0400
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
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Subject: [PATCH 12/24] arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
Date: Wed, 16 May 2018 11:18:57 +0300
Message-Id: <20180516081910.10067-13-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0116.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::18) To SN6PR07MB4383.namprd07.prod.outlook.com
 (2603:10b6:805:58::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4383;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;3:DE45wwVso0vgHL04VX21OiMxUmNA21OlBF3XvVQsGOzallQbIynhdF2/4I/qvresVG/OQaEJyiunCTEM8j3w/TzH2HRlMAELqGJ5X9k7C0fKpV5Ug4iELDQ8Y7rGa7fAAAS6qhIxgAy+2hCXGo01WJeY2RXcYxcp+V9SA95Fj14LV4fC4ZFHUIGFvPAnwvUuRXXOxf0f84EMtGqypc8U3MWu2JRmnJ7sRnt4LJs/3KrdHBg4tq+R4BpAmdkTLVPB;25:zYRSeA6zkcijT2Z0qGpNbbE7LGmCPdcCl+NkpTyHsuFg2RLBznZy5i97s5RrPbCPrfhOYgXUN+ctTCsWCbArr/pWAibBns1nR+OMSOLoxl1ZMQC7w9rxUrEYSBstlhq74jDbVy75aD1qqGIVeuQSB59IIqzSvtaqXgDH2psouVovCNrZVqKKnr+vY0YhAYy/6+fqTjq283OajIL0ylv0kXr/mYZY89zdWFWANMQPe39T3eqVSArOfNbO5LvHLwDr/dwb/z2R/YNN7P7BDHGXVNyrWRuuEOTtgfS08NbLn015xhyziRywLZM3kx4+cSX4DkLrbI/pp/LFWymiVMxVHg==;31:0JimyTjwv4QolXIax/DV4TD/FgKC4GIUZ6Xx4Wuom12JbgWUIJP/QndWt1m4TnBgXYrmE4EY8cIvE6ZwShc0G1jHzB/7AaOjGkfl5qQLiBE2ZJHN/4jYYMdZ9eqz+0ryj9CXhvfTUOuSbjpZDF6jI3o/KACDTJHdlNplAyUSE2ZaJUTwORP16GTk1xXDVvqcBxWSBFzPfH9M6KcCCaUmFZaFdmZfJG/OLG/PgA4Z5D0=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4383:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;20:y5qdc60TDCqM0SJf+y0NQrzZOB4cG3CeTN3jaV7Lm4x537e2iZH1NOhM6nxExHBwnSTE1TJ4WpXDmuW/dzk4LJPdrxuu5ivM5YYo/blA7AESr/tg6gNx74hYNYy4II+tWourY4UPfupQQf7EcGJDufMIoW32FSjQHnz+yi9h2X+iPi6A7KknKRWY6ATS8885OnwPh5OJowiPtsEm5akEcc81H1sDNf9L9SHgAZnLkd4+rp9xh3POYbrEr5jgEDLhs+br4msxFAjPNr+7Qi+WK9x9uPnQL0PC3+HlHvWMIKJLtI9B3BOpFztyUTMDKpI3DfUb87MyF/oSzoxEorxxFf+8ZbduhtWzDloRtuxxwn+ji5G9NCV8dCCZb4I7HujgYPYWDf2bdPF3OJuC3nLz1F1P9X+TbAB7P8O+I+z1xZSiye40Qe28phOqZeDUyl7rvArsZkek4dVKxTjNwR90Bbg6H507QDMqLL5EQpGoZmt73nZyMK/ySOfjuO+eOjELYHFMBvsMWLFsYknF0dPnAa2meCQPPXoAC4Qt7zzHFcx83t21wuF2jekMhZzZxglWGpe62hGOnbnvPgLGOs4OO7+I9PNT2gvJ4FrwqxhAVY4=;4:3U4JdOgBpY5Ns4p2Q72UKueSVU2//M/3XsGGVUSzbSMt8w2G5WW7CYmQVzG+8wfUiYCraoWHov27yb4rI/6IRfq8TY2sq5TTT0yg0+h/9nhwmhPC56DWNqr90FfY/uXKLmUepF29D8g4ED8Z3tl4n/rz2ewm2cw5CJv/GA0E5qNIE049LB37xg6yxX6Qy9/kCeBl/ZZivMrxK19d1xErRPJjpE8lZfNduepx5kjtZwTearC9z1LBAKIF2U0J1YAmub0ZdT0gYXJves+wyeTIfg==
X-Microsoft-Antispam-PRVS: <SN6PR07MB4383268B79C0C1B80FA528D3E3920@SN6PR07MB4383.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:SN6PR07MB4383;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4383;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(376002)(39860400002)(366004)(396003)(39380400002)(189003)(199004)(6496006)(72206003)(478600001)(446003)(39060400002)(2906002)(11346002)(486006)(3846002)(4326008)(956004)(2616005)(25786009)(6116002)(1076002)(42882007)(53936002)(50466002)(476003)(107886003)(48376002)(50226002)(66066001)(6666003)(47776003)(16586007)(36756003)(68736007)(110136005)(54906003)(15760500003)(8676002)(76506005)(81156014)(81166006)(106356001)(386003)(7416002)(8936002)(76176011)(305945005)(7736002)(5660300001)(97736004)(7406005)(26005)(16526019)(186003)(316002)(105586002)(6486002)(51416003)(52116002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4383;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4383;23:+XUBOJboeTmeAl1qbE/qJF0O0iL7x0ZC+RT8laDg8?=
 =?us-ascii?Q?ciewYIqPSbzmJ/c0W215ZCcjVsDHmBp2ED2783/bkshwTRIxFB6l7Mtnoe+Y?=
 =?us-ascii?Q?k2tOlxctEh0KfZNQyX9pmIu4H0Z0BMyooy+uth8sgZfNoB7npH0e5ioK4CN1?=
 =?us-ascii?Q?6iy0xCLe+iIoIiOo0N84Zsqmw9YVUQdh1DdGguWqQT2f5AvRR+BWpATVN8C/?=
 =?us-ascii?Q?nqAiIdFnwQ8O3gyU+7xH8knqkJz/07ohuRIHe6z9seq8gX5IF71d5mHW3u//?=
 =?us-ascii?Q?kH//mbKU5oPWUV8E+6NJcEhuvMgWzQWmV+Xf4dhYq4IaoYbq/p2Pugee+Yt6?=
 =?us-ascii?Q?PtWR2KE26lv5dNqEJNrWaM+OlwkrLbf4TRqsyQlLO4gOUh6tSmG8Wgj8p8oW?=
 =?us-ascii?Q?xm8oo0loyACvg5PmRmu4jtnOUsvRqh0P+eiq0A9R8Bal+MERjEmKqlWiNyzk?=
 =?us-ascii?Q?FtW6DZ0SByVp2tOi6Dnv2c2IupE7vH/gfpEKiBR8va01KtBkEp8B/dhec1FW?=
 =?us-ascii?Q?J44E+Hn5pJims2ugCOa5/P1iKl6CPrieEKyC5YcA7JG2r+yJEFJWv8tfoSXK?=
 =?us-ascii?Q?0RHbRDv9CbqYbgJcX9WbITtU0LoAx2Zkw274rCmJ5JQXz1MSy+Q93ENPNkW0?=
 =?us-ascii?Q?DQyygQqeB/0SdDtH8L1aIS/jc8v4jaZ9gN9I7oGFjIOhpYJiNf98DFmhvUSG?=
 =?us-ascii?Q?OKCBR672EBLeVkuq6n1ApEc6C/nXn/k4YOZ6WlO+S8UhuE37205K3ABYr55D?=
 =?us-ascii?Q?rVpEtu3FuURbUadzW+oDNSZNj2FyS45RQWkrdQu8q71ZAlZ07zB6TB78+YwZ?=
 =?us-ascii?Q?dmJKan8+fu82A92HERenRX50qxAEkScie8wg9mMzomBccrf/zFnW9d4f2YmO?=
 =?us-ascii?Q?lJMNhXaFtBir74RyhEZ+X+a0337Zel5vlG9GZrJ7PRgf4KmWffNOYe30Vvml?=
 =?us-ascii?Q?MdiqYLzUM7HKer6Ed4+eluNKhJfKvO4QAeSxOEmcWrMrIjCnn64vJpZ67xkG?=
 =?us-ascii?Q?2pujEqY557Mjqj7tmKWRZAoGbZsTdJXhKJtHD/wkE7kvvdabsA/tV55Jq4RA?=
 =?us-ascii?Q?SGJcIJZ42C2TFJCRUZsHCZL6X75djLTSS8BqGXc1vPr5BrjbpJ4qDO8e/WgK?=
 =?us-ascii?Q?IEmeTmzVnjxuqo8UjxOt1nzHrZIcvdw8z3zS6tC6Vk3/A2QICXQjD7NEBr8q?=
 =?us-ascii?Q?wWMQLTWcx+gQPIRwnNPhpU/15YdnzAl+tLbcyQAbESJn+HcfFB9/rRxTAAZe?=
 =?us-ascii?Q?L+vDozK0DMXVrbtbhqSNzvmcuOo7Tt7LfA1zwkIonJs4U1R9VX8PU61ljd/Z?=
 =?us-ascii?Q?qB5Z9GfQkEUmmHseXflGdUU7Rl/NEn4nlhhdjgfSnGfMlesQZaLcMwVLc4rU?=
 =?us-ascii?Q?gPwmdFURrf0zFU0NvdFDvgpWRxUX9TFyOhLqZp45fKDIsa+?=
X-Microsoft-Antispam-Message-Info: ZAJTm+Lc/CKHmqcHhemNxj5RCL0vpbZJ34EMj0hAUDv05WZwxpxkACcwmJV+TuNrCGEZ7KqUYAxAhJAP80FOMa4OTcZHuBCcCaQxzFxPRcs1xu+OUM6ML4VVSkis8xxpJh0XF36ftVKZ1t1vt/T5MOQp9Im3NzHBLjggxLMcQZ3oJDRGozjgktrYIwZliedr
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;6:c1vVhqWF4t2fwma6vtDlfOLCcbFRDc6T3J8Ak10HMh5Zsvn9ZrM3UFsVxnpURykp1okukpo4x94T4uORTno/3oH/xZ8490VAXQB9LC0IgkEj51lhBGJcgGk4jfD4NawkjsVqGAcbJwPgrniRuit+TqA4yiZXteUKN6MV8Q+TJ4R8qqEgaOub/JER8MslL3FhJSnpnUv3d8N6bL6wQpluEJzWTlf8NQS9I1d04okNU8D9f7gbVZMlMQiotpweBXpbSky4DGdIj1D972z3Hf2pu6pLfVI0tK0qurf6w1fQHNFk/+CoCt0GBmPO6eEe9lhqZ8h61tAyy7mxzoi0n8rVYVJasdSLUeWVXd/jKsjs0eKwTwDGoNVecT2IrB1Qtw9foqqPMqwau03KP1MJYVd08tMzaC5y5rOP48Az7kigqcptGlCvAbtyOK2seNyTpM2M9rGnKHj/qi0ZDnX2OZZ5IQ==;5:1TkwnetB8nx7WfR71fhX4tFO+/MvVuTSMfZ/eQ0gomOD4PAeRh1t+xj9xUWiulTT2m6bPrzKpRG7gY6bqNabBjlOxL+YwZ90UiVC6xM9RSlfjx9xtQAaBn5apx0LWsLxWjjGGIQwVJ5+8QiVZM67fHryQscvwtRKnb3pzLjyhXM=;24:NFWeFNwMhWOMDUwWiWn9i91VtKnItvX4NLpUmozHzh5p1Uh+jmTJTnncTEe+Lhxw3cpmL+2lcFBKp5qSl/ujX4IXSiCg0mR4uO4Cqe73bz8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;7:vfXWg2hn4HH1EYbTlQSSIW0KR9/q4AWWx+BzawMVn9K+sNs43wSzDnci5wNVD8xWzYXV11z9JRfZ1G7DcXEBFuZrxhF3/v3mquAimnledzwfGljWawgGOG3J59CR4wQeu79ZlCqYBscZHxym0+hIOsGg7/GRuUftzX1dan+9/l9hIpF9VLZLDZ2IV07fU8Jqn6Bd8cLf4Qd+acTw0NXNmcCz2jz9Qa18ZGLm6rDLjSDsQRZVvYrZ5U7UuX8HH0kJ
X-MS-Office365-Filtering-Correlation-Id: aa930f35-f954-40ae-407f-08d5bb06114f
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:21:46.7709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa930f35-f954-40ae-407f-08d5bb06114f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4383
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ILP32 tasks are needed to be distinguished from LP64 and AARCH32.
This patch adds helper functions is_ilp32_compat_{task,thread} and
thread flag TIF_32BIT_AARCH64 to address it. This is a preparation
for following patches in ILP32 patchset.

For consistency, SET_PERSONALITY is changed here accordingly.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/asm/elf.h         |  2 ++
 arch/arm64/include/asm/is_compat.h   | 30 ++++++++++++++++++++++++++--
 arch/arm64/include/asm/thread_info.h |  2 ++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index b4b10eefc667..023b2fbc1454 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -143,6 +143,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 
 #define SET_PERSONALITY(ex)						\
 ({									\
+	clear_thread_flag(TIF_32BIT_AARCH64);				\
 	clear_thread_flag(TIF_32BIT);					\
 	current->personality &= ~READ_IMPLIES_EXEC;			\
 })
@@ -194,6 +195,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
  */
 #define COMPAT_SET_PERSONALITY(ex)					\
 ({									\
+	clear_thread_flag(TIF_32BIT_AARCH64);				\
 	set_thread_flag(TIF_32BIT);					\
  })
 #define COMPAT_ARCH_DLINFO
diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
index 19868588fbef..484c01def030 100644
--- a/arch/arm64/include/asm/is_compat.h
+++ b/arch/arm64/include/asm/is_compat.h
@@ -33,18 +33,44 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
 
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_ARM64_ILP32
+
+static inline int is_ilp32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT_AARCH64);
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT_AARCH64);
+}
+
+#else
+
+static inline int is_ilp32_compat_task(void)
+{
+	return 0;
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+
+#endif /* CONFIG_ARM64_ILP32 */
+
 #ifdef CONFIG_COMPAT
 
 static inline int is_compat_task(void)
 {
-	return is_a32_compat_task();
+	return is_a32_compat_task() || is_ilp32_compat_task();
 }
 
 #endif /* CONFIG_COMPAT */
 
 static inline int is_compat_thread(struct thread_info *thread)
 {
-	return is_a32_compat_thread(thread);
+	return is_a32_compat_thread(thread) || is_ilp32_compat_thread(thread);
 }
 
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 6d2d58daa9d7..8ed56630e6a5 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -94,6 +94,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_32BIT		22	/* AARCH32 process */
 #define TIF_SVE			23	/* Scalable Vector Extension in use */
 #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
+#define TIF_32BIT_AARCH64	25	/* 32 bit process on AArch64(ILP32) */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -108,6 +109,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 #define _TIF_SVE		(1 << TIF_SVE)
+#define _TIF_32BIT_AARCH64	(1 << TIF_32BIT_AARCH64)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-- 
2.17.0

