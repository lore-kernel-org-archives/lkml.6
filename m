Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4128544-1526459394-2-14788327674087790025
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526459393; b=UPBcWcDFTW2nyZQ/6Q108XF42DeADglxnwPmWvak8c7KSpoc7M
    5nXiJJiyJwPQhsbBPurAMf+Mdux549YQRakT0AdndczhO4vwyHIJzQxeTrWpBlo7
    WuMNogiqDBGxwQd3eP3MOuOaO8I6i2bXrtqkVlvckvgMOpD2yBC5TrjXRL7/t6up
    t/13gJce2O6kV5BOhRpbHG33L4BJIEVkrXsoPtdQxBO/ucPIU4Cuy8+bqQRGRQNN
    XBTxjfKqLxaV7pSXgI8TOA5rQxeR8ni6grUwQCg3OMDsMkTw30mK7Ejg0Bx77bAu
    k/I7BA4LRDADXQaR6PZPrAMETFc9ibXLJD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459393; bh=SAaXfcJKb4QnocuSonDsnKi08+VboW
    B+W01vj5iM+VY=; b=bMEpWu5g7WSEdtGjJuCEPzT1xkTC3d5w6kQsmbjy0YUJDf
    KITjJJspHJ3ZQlGqOLbIbSxkjSEEZtMTm9+Clg/mJYI2EFGtw3YI89Esb1tzgK33
    qjcTsCIMSQi5aGq7AjvBy+aI0KO7jUbq5n26xG61h8TWOgeB5BGZ05MICTygrVe/
    c42cuyLp4v56JnjLRHfzBVcVhbrtlM8Q5zm83GrI1eGQc7noFIO8CJ38xvmiaXg9
    Lu9V902KsnyDp4ePm1RCFvNaDNR5K8yE5jUlo9sVce0V2ll1s2ClVbrlnxKpZoCd
    GYEkoLCiKQfqHaXIhThqiD1bBRtS8xg8QbWug81Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=MMStW5kQ x-bits=1024
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=MMStW5kQ x-bits=1024
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
X-CM-Envelope: MS4wfPOWuMh0l/3KEa8tBQNmypnKYu+F/6W5yXZaD6jWo4KpPff1HAI/7K2dN7fe30oEFMeNjsa1KhpjTam+kiGqYIc7KsriIBpx0fofTwMwOFprOYSzJlea
    UH+i60wOUbdhx8WD139jy2BHqSYflzJUvSLJkKqqJHV+7Ncoc87HvFDMFhmk4H479RsaOMIlUWH6vjFPqqqvPkcwobmmOE4KGA2UPl/cem/FrNBF0C07fiid
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=8Vrhg9jcMeUA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8 a=LQV_mRbyC_J601MwfJ0A:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=3Y7jEmdpTcse2tSp:21 a=x8gzFH9gYPwA:10
    a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeEPIUb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:20:31 -0400
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:50976
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752831AbeEPIUW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:20:22 -0400
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
Subject: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
Date: Wed, 16 May 2018 11:18:49 +0300
Message-Id: <20180516081910.10067-5-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0119.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::21) To DM6PR07MB4378.namprd07.prod.outlook.com
 (2603:10b6:5:bf::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4378;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;3:r/sZWCcUkIcmJaLAS9U5sC4Y9GKkTMjIO7gN/3zJQHlixs7qHzRRCSTwKEu/LYdaCkLsrb9hW1VyCONqy2q5oIb2X+5n2GE2EPHmmvvdv6HB/U6DhHxUMYiYq2lt6EjHWrn/JVqSvzCiUSdt1HkHJXYdARHxJ6JBZDszQyQHboFXLhiCLi0BnwZjZtNQNXsEcH+MvufopP47lIXgN7IDfwk7F266skxVy9+2EF9AH9MmBxm7bxRJLZbxH3vMtK3V;25:Pet6YodaprB7iUr7dOym8JHLUwekpU+llTdRpawlYkMqvE0nRUZKH5thjXmdbpG03LxR6S9FiYPR8nFwl7yXWVRVq4mXU7jQVr3zIHTzRPAoOV6qdh/Tp4p4sCk8wrCo7YYrlg30g8wu7MYwu9eI0DUdPJV7qmYRfPrS02I5hoQsZeKzy7wDdvtKlzp0m7e3f8xfEEJK4lsUQY5yOYpnOIzvsfA+tsJJ+BooUEhtq1YJCuIdr+nbxrP5e6y4O+Z2e5eerT6ULLDWZ2anXSzesXuZ0WJb4oaVPjWD84a99NSC4D/QNCZb9ZfzyTGEnGtNWCBDQHm9/hOCRptE7/6emA==;31:SJnUE8+GBKvTudGUvYj4DpcF6gEriQWJOGiuDK08x/KaVUmgECJxvZzqHK6S6489CaG7XsXXA1FKi4sTBtbdYTvoty34cqOClvnoSeWDkzt9nvU+Mv5L3hl1/ouxxKODreSr1K4PapL4fhTia+sSqH23aBcmejpV51FHOnd8h4YDasw7NkISEpy+H8TmL0/CK6KSIPSBX/lFsLGqLAJ7YZG2/cOPwM3YWehAcJrHCf0=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4378:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;20:vQqkNnPaDXZT5UqiiMHN/WQsP9ed8dBfe3c0IJtpND+K7UPrbcPnvaIn60enA+DZBFfyODMQ8p3kxJoj58eiaEiKu45J/3ZfQlhWWZdKFi8cmatx2tZF1rcGFOWz2qb+aZ1ZYhgWFen81RZdgOlWm8k7Zui0vGWLwwBq5ATPRRzEgNTsBFqxPe+Tl4lRn0hgpUyC1oH6A+ZeutBFoKPpFwdfCLbdF6uL2rNBX1RCrqq55zQa14crK74ktC/ACqLpG2eRvBXh58fz2l56s3ku+PjpyOHRhmDnP7zGW1wSSfSd8Ld9Cb/T5ngq+51d9h+gQ03QTWAkdAjxbj7LiG8aQau/uWuAIX3cRIcZym942DwyU8hWlAueIRYThjo+MUNFsKj+DSVIidO47/WP0nZKnjmKl1KLpzW/lK7q56VvZMi7S88Tk2h381vd4AOup6dRvdzFogM/4PJib1YN/LP4df3rrpAEF65R517NsrK/C2y4/cTX+ZUpdMx9MveVWm9n5l41DTC7OQYa1k8G6wiUiFPX6HJp0la8VlK34k4nG3HFoIv/YNDq75e+7nmdrDLxp073G2Zfe9iDjSwxGHlZirWZzFOi+atz4Afdg7m2TBM=;4:usfHejypWpjh264RMHEMNQwJopM7oqY84kzyqdN/o6NRu7xkrwGZv5kHznssw5no+NjXecpSr4Myw/q0ZGqx+qNmuNFuxnpV0Gu7vkbuhVd9e3Psyr9wgI8H+Eb7XS35lEBkbft0XQr3agJfEdZvM0xTqVshpjhBnohWj0FxfsMXjJMRNb5JS0wJmUeVxzhWgS2+WTM5wDA1QYJQPS3WouTGli6qN2yrRWs6DvuJ9E+Dv0bgC7N6gu/8mO6wXilclLrKxbtZDSAkm4Y73Ha4fKwXcQfL59vXOQWFNAXup/xcF86i54yS2gMmoeyq+976
X-Microsoft-Antispam-PRVS: <DM6PR07MB4378C4F5925CC68A8651DC44E3920@DM6PR07MB4378.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(5213294742642);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM6PR07MB4378;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4378;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(199004)(189003)(76506005)(42882007)(54906003)(478600001)(72206003)(4326008)(51416003)(25786009)(53936002)(52116002)(6496006)(476003)(2616005)(11346002)(446003)(956004)(316002)(486006)(106356001)(36756003)(7416002)(5660300001)(16586007)(105586002)(110136005)(305945005)(97736004)(6666003)(7406005)(8676002)(6486002)(81166006)(81156014)(68736007)(15760500003)(48376002)(50466002)(7736002)(8936002)(6116002)(50226002)(16526019)(66066001)(39060400002)(575784001)(47776003)(1076002)(186003)(59450400001)(76176011)(386003)(2906002)(3846002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4378;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4378;23:I/LmrQn5/EtLU7y7W0xBscDAdU9svulnKaOKM4bev?=
 =?us-ascii?Q?WpDFA+zbXM6pCIbwRvUem5VRLt9KyA6QJoZ4trBO78jUUGyBXh5PVbiNIb40?=
 =?us-ascii?Q?1+9uhciZEOii9U+xeP8K9F5SiRTawNcCPgII566vQy2n4GbnIf9nVgZuKehl?=
 =?us-ascii?Q?qCj2x22hiDPkz16+chbQhszBKxaPD531UetSjZRJm9uxbfPZGFTmH80cUkIj?=
 =?us-ascii?Q?oR3FsLdXSO1zD2KS1HJMQSQ7MJ6eVz7gr7RxCRoPAPIiWhzbrhGuqeh6l4JZ?=
 =?us-ascii?Q?QUAuZBPNAeKM2rAqezS0WfjbyyX7H2T7XrnX8T715JaRecArK5wtSKEEd20r?=
 =?us-ascii?Q?il2gUxdkmEMeOlqYsJdBfoIlVlvbVydpkzXyXIy2BU/4/LfU8usVJKh9L3m+?=
 =?us-ascii?Q?3ZE7BHZECljmqvwbkQakL7RPUNZtGVOeCk3ed8J+B2B3M/H+FWR42WrwRK3v?=
 =?us-ascii?Q?F+B9ivR8pWBT3wZTYR/4UNdMgVXE2AL5aWvmsGurXvrCHLzlEQJ4V3fxbyUg?=
 =?us-ascii?Q?nIn+1W3uhNOyue2ECbFnSwMKaFqNVbn+PKiCuWZxNUo35nkzYyhiugwEmUro?=
 =?us-ascii?Q?lZ9QrpKCWTB2JvqDucEAVxVmIaPlQEGEUWihAIr1ojfwWIMoJiC8VuF8u4rP?=
 =?us-ascii?Q?bQFTf9htQjljXEJKNgtIatT73dn5Fb9J5Zm3erZFT2NQI+40KrrPnY2ldJCq?=
 =?us-ascii?Q?QkBkjWInScNjrOa+uVnvdJgJEcDDqp8c77vTdnOwVTdpZhiQNxWN2ny94PLg?=
 =?us-ascii?Q?M2Xj/YcdIk1pMTWJyMblhkYcc8vRZgVWm6ujC8g+s7o1SUkC4XaHJVqNrYla?=
 =?us-ascii?Q?+grrBfTYSgjnlxuEo8Q/VN0nQUAw2mRGq5qfWpJorLzGy3B35yqxP93MPFac?=
 =?us-ascii?Q?vT3iARSHl6jzJPh1afNJ3r/3oNG+WxGu8V2HS1fmlRdMx3e45YAHdlU4t/gQ?=
 =?us-ascii?Q?s1SLSqOAca1kq+Xf37Zksb/ot0O12VElJXw6biAM5vEAK6mOaW5VzqpJLN8J?=
 =?us-ascii?Q?WyDYpqfBL9YVBExb4BwAcTbj4ckyPdQ+WG65xwtFQVI65DyOSSNvReghXo+N?=
 =?us-ascii?Q?nwD2aKrUMWGQPo9lfcbG2wWiYOahooxdh0tAfRN3YJdOlIGNthl+OUT2YUwN?=
 =?us-ascii?Q?Rxuzc1TCZ7+f2Eeu2ttjcms7dvaXp2vNca04uEPWmjlHEw02YJMYjfT6FSkn?=
 =?us-ascii?Q?JL9bcx2QChSMZw2qJ1m6p8xEvdQ4m7YBtUWbcCxISzCa8z5/8TvSOZLLFJAq?=
 =?us-ascii?Q?8MLvdgUgJmOckU57Vr99cO+2lUUB+EI6gOmnVE0D7yefzPtQSUH23KcfHFmT?=
 =?us-ascii?Q?mzwWj2klbUQ+NV1X61Wl09NpDZR3wOqPySUMuhump4EhN9DmG3za0RqVTiYA?=
 =?us-ascii?Q?s06nk5gGRn7L1Dq9Eq9CRrbVXes00omKKIFppY7XYN3ecp+?=
X-Microsoft-Antispam-Message-Info: pX//i3zn5Y1fI2aJVs3G3+6F/IDKXCh+KgdTup8X+cZD5ZHk9SYPlj4Fx6GvSD9Kpy3qp3/fOtIMEgnq0Emg5DBid7T5GS5Z+VtcFu4fLJSND+Bi5GO0DQmaow/bmGE7o+ndJuUBVfyxjc2xoTJl6MwW9a4EIWLUJQx0OdqLPB+DTjyW3j16QVOKiRrF0f/x
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;6:Cgu+lq3nl110MFxE1zwkow7azIlF2Wq1RxbqvHApqJH3R+9EsuSulN0cudxaJ0cW4u9+kUDAWU+6SoTBSGCGxG5y1bPMK/+u39zBktji8Ty4QLwNCrHMg6Pn40pa1UnaXcQSM9cWT9EHr/UWrcPEzJzURUgRuk2h4UIoQAM7/fVm33jD0d+Xym0g6pCBDiAReosijQk6/KlT/GsHjyKaeyHkqUB6ER9RE0VNKcOsCDQ4DnfcvEr4kFjvZR2hJro1kmdqzWgACXdLAOPNMb1F+hLi4OtkemPsWX0SxEhJNEZms9qmNA2F02/j9dfPfW8d8xCbuy59Hz7ucfsFC+vDdBY04i5V+THCUxSgSjH2dW4BWOAV5hV3Bt8bqyHsHJM65XI1dEynufV70Cs879ifPTTqQrM6KqlQG9KdRIZfq9O2uJeDAj8kjMeU0m97r3fVCV4LYAAF8Ca6alHwcYHoAg==;5:sx/cmwVmxLJqgskI610MDnzgJUdh0mCRvjKmDOt9TZwWd273lO/k8ZrORq8txc4SZE9erUIMUnUQAwEy7UDdFXRZE8HmTsLJAb2cchR9CzACMA8M+rwBUMrp+XMTU0DLA3JDtroQuVt9kQkt5zvRl3V7U/C8z8DQ1xhC6/fFBmk=;24:RqRA2Jfj4x7RjRNdXBPuTb4QFLLMOcdvp7zxEHD1uk7sDiYbK0WJzNxZFIelFC//17wVeuc7oomyBiWG/HnwqpcbsdFlM3f65Hp3Zo776lo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;7:ONCaCNnc4WVPajxI9D81FX2x+5ebHm14vrkWsF8HOOotwsyYQCY/k+TiW38EXti9VFVrWt+8TUs8THY6niwnjelbQcPoznaT6wWjk+14rZ2n0aoh1TfiSLBa6ASLDUl3C66GqB25uvsp0FtGU01y7/lCFJB/+o7ww+WwE6DpqcJkJexFyGeVfhTKPTrGWIDRURvGLA+XEZ0nBpss6153LR3VteDHZGTDNkYYiusT65iLCwt4jHXtASXpf/Giywxj
X-MS-Office365-Filtering-Correlation-Id: c13ef3cf-2b35-4f7c-d785-08d5bb05dcf5
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:20:19.2403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c13ef3cf-2b35-4f7c-d785-08d5bb05dcf5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4378
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All new 32-bit architectures should have 64-bit userspace off_t type, but
existing architectures has 32-bit ones.

To enforce the rule, new config option is added to arch/Kconfig that defaults
ARCH_32BIT_OFF_T to be disabled for new 32-bit architectures. All existing
32-bit architectures enable it explicitly.

New option affects force_o_largefile() behaviour. Namely, if userspace
off_t is 64-bits long, we have no reason to reject user to open big files.

Note that even if architectures has only 64-bit off_t in the kernel
(arc, c6x, h8300, hexagon, metag, nios2, openrisc, tile32 and unicore32),
a libc may use 32-bit off_t, and therefore want to limit the file size
to 4GB unless specified differently in the open flags.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/Kconfig            | 15 +++++++++++++++
 arch/arc/Kconfig        |  1 +
 arch/arm/Kconfig        |  1 +
 arch/blackfin/Kconfig   |  1 +
 arch/cris/Kconfig       |  1 +
 arch/frv/Kconfig        |  1 +
 arch/h8300/Kconfig      |  1 +
 arch/hexagon/Kconfig    |  1 +
 arch/m32r/Kconfig       |  1 +
 arch/m68k/Kconfig       |  1 +
 arch/metag/Kconfig      |  1 +
 arch/microblaze/Kconfig |  1 +
 arch/mips/Kconfig       |  1 +
 arch/mn10300/Kconfig    |  1 +
 arch/nios2/Kconfig      |  1 +
 arch/openrisc/Kconfig   |  1 +
 arch/parisc/Kconfig     |  1 +
 arch/powerpc/Kconfig    |  1 +
 arch/score/Kconfig      |  1 +
 arch/sh/Kconfig         |  1 +
 arch/sparc/Kconfig      |  1 +
 arch/tile/Kconfig       |  1 +
 arch/unicore32/Kconfig  |  1 +
 arch/x86/Kconfig        |  1 +
 arch/x86/um/Kconfig     |  1 +
 arch/xtensa/Kconfig     |  1 +
 include/linux/fcntl.h   |  2 +-
 27 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 76c0b54443b1..ee079244dc3c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
 config ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	bool
 
+config ARCH_32BIT_OFF_T
+	bool
+	depends on !64BIT
+	help
+	  All new 32-bit architectures should have 64-bit off_t type on
+	  userspace side which corresponds to the loff_t kernel type. This
+	  is the requirement for modern ABIs. Some existing architectures
+	  already have 32-bit off_t. This option is enabled for all such
+	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
+	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
+	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
+	  unicore32, x86_32 and xtensa. This is the complete list. Any
+	  new 32-bit architecture should declare 64-bit off_t type on user
+	  side and so should not enable this option.
+
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index d76bf4a83740..9b48c82a12f6 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -11,6 +11,7 @@ config ARC
 	select ARC_TIMERS
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
+	select ARCH_32BIT_OFF_T
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e3d53575486..825a611a9d86 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2,6 +2,7 @@
 config ARM
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK if !HAVE_ARCH_PFN_VALID && !KEXEC
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index d9c2866ba618..5a99c1ccad67 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -13,6 +13,7 @@ config RWSEM_XCHGADD_ALGORITHM
 
 config BLACKFIN
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index cd5a0865c97f..db7ea0a9e805 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -54,6 +54,7 @@ config LOCKDEP_SUPPORT
 config CRIS
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select HAVE_IDE
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index af369b05fed5..9dc671f8f4a6 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -2,6 +2,7 @@
 config FRV
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select HAVE_IDE
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_PERF_EVENTS
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 091d6d04b5e5..6fc8a034ddb6 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config H8300
         def_bool y
+	select ARCH_32BIT_OFF_T
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
 	select VIRT_TO_BUS
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 76d2f20d525e..f6e748178292 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -4,6 +4,7 @@ comment "Linux Kernel Configuration for Hexagon"
 
 config HEXAGON
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select HAVE_OPROFILE
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index dd84ee194579..8d9c2244b144 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -2,6 +2,7 @@
 config M32R
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select INIT_ALL_POSSIBLE
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 785612b576f7..8aafd39b5142 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -2,6 +2,7 @@
 config M68K
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_IDE
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index c7b62a339539..8bc07fa5982d 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config METAG
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select EMBEDDED
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 3817a3e2146c..48270951c3aa 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,5 +1,6 @@
 config MICROBLAZE
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8128c3b68d6b..3eb048042004 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2,6 +2,7 @@
 config MIPS
 	bool
 	default y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index e9d8d60bd28b..7840859b3f9f 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config MN10300
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select HAVE_EXIT_THREAD
 	select HAVE_OPROFILE
 	select HAVE_UID16
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88f1db1..9b4a9cf4af3b 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config NIOS2
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 339df7324e9c..24c7c25064e5 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -6,6 +6,7 @@
 
 config OPENRISC
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 9792d8cf4f56..93f8cecbb741 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config PARISC
 	def_bool y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
 	select HAVE_OPROFILE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd07642..4f38ce304b78 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,6 +134,7 @@ config PPC
 	#
 	# Please keep this list sorted alphabetically.
 	#
+	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index d881f99c9ddd..7371e5fb18b9 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -3,6 +3,7 @@ menu "Machine selection"
 
 config SCORE
        def_bool y
+       select ARCH_32BIT_OFF_T
        select GENERIC_IRQ_SHOW
        select GENERIC_IOMAP
        select GENERIC_ATOMIC64
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 97fe29316476..bbd75a7cbbc4 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -58,6 +58,7 @@ config SUPERH
 
 config SUPERH32
 	def_bool ARCH = "sh"
+	select ARCH_32BIT_OFF_T
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45f1b2b..3cc26d90ab82 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -47,6 +47,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_32BIT_OFF_T
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index ef9d403cbbe4..542bf49cdfcc 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -4,6 +4,7 @@
 
 config TILE
 	def_bool y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 462e59a7ae78..34694eb7c790 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config UNICORE32
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0fa71a78ec99..47c2f1eaa7ad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -44,6 +44,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ANON_INODES
+	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 13ed827c7c66..d1de823a8fe7 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -22,6 +22,7 @@ config 64BIT
 config X86_32
 	def_bool !64BIT
 	select HAVE_AOUT
+	select ARCH_32BIT_OFF_T
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index c921e8bccdc8..20ebab4fbaf6 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -4,6 +4,7 @@ config ZONE_DMA
 
 config XTENSA
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 27dc7a60693e..d019df946cb2 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,7 +12,7 @@
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
 #ifndef force_o_largefile
-#define force_o_largefile() (BITS_PER_LONG != 32)
+#define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
 #endif
 
 #if BITS_PER_LONG == 32
-- 
2.17.0

