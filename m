Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526459430-2-2094239747418464195
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
    1526459430; b=INY7QLOh+8pHoZlcE+cvZewxYdfLJdhTaWnUGXdAECF0OQxM3R
    tH6bPJvVopQknoJyHDS1nPSL3SyeUs3eY3foJ3bDYttBTbZNS4ixiSbvpQyS6QQh
    plkYj6G+VUeY6/CVLtVqa7Xm8czizx77YVVbnSthfE2TKV6lYby0Sr9uYBwzOkz2
    dxcu65mryvICjaVyO5zPZpWX73dKWO47DJscPnMDztrqJVzKQ127IQcMwhLEAg/G
    pUiO6D3VNAKt9H2eZ2U2m7CwJoDoFkGpupk52MDPsUN3JkeWySIlNtCizW2SEyVR
    3/l3r3Ls0STEXSTnqJtLBEeL/rmgwYkBzzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459430; bh=PfgDULwB0jsQXl3jEb9HcWM3cPjToJ
    eK7ojzHVmrAOM=; b=WFJuPTqodslSrnxD6y4UDV/ttpThzRn1/OFMofYkpOJgEI
    2sC4k/W89E3lni+fsI0BMihclIPSzHpXXi0jKvzvWb8/n3UUtjomb4s1kKvdV/ed
    V4ENq4vEQ7vK175250DRkzNGACKhBVWmVxSTPA/j/yrIgCcGy4XID4d0sajISuiQ
    HZtybp8Uthx/p8cZne/4P5i/0wqESSCNsdiDqOd+oy4CNaGd2iqJfg4QyfJdWU6v
    BAVselvYdqzvUUomTVVoeQEGPvl3mZ4JGvwRcsQeY25SWymuAcoibUltscBUUJvT
    CH7RxI4GQ6zBw9K4u4bt1RxD9M/m4yh3J25iI6gQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=lYUbF/1M x-bits=1024
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=lYUbF/1M x-bits=1024
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
X-CM-Envelope: MS4wfB9m5OXehYvWXTv5DU+yKn6xvFrUeZC+QFetXaeM60iwuXR3OQyCThigWwvGmHkoEsxgcY0YNBvS9UAMocdB/13JpAhs/enr7tpNLk4jfCZ2e21a/jI7
    7ZWi4Z/eG7IObT94PAYHpFB7anuU2onK1KQcsHtPoXE721cOobaA2wXGug0CngRZQFsSO59Wo9gcIsPEh4tTSk2n52dKt7IRE7VsSUFq5HSMysnZrCXcjTGv
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=H9XALQ4oeggA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=7CQSdrXTAAAA:8 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8
    a=BUTbYKXI85lQsqGHtjMA:9 a=x8gzFH9gYPwA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEPITu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:19:50 -0400
Received: from mail-dm3nam03on0064.outbound.protection.outlook.com ([104.47.41.64]:53860
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752495AbeEPITn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:19:43 -0400
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
Subject: [PATCH 01/24] arm64: signal: Make parse_user_sigframe() independent of rt_sigframe layout
Date: Wed, 16 May 2018 11:18:46 +0300
Message-Id: <20180516081910.10067-2-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0114.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::16) To BYAPR07MB4376.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4376;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;3:M1jqorQZkkS7mDYCmGI1kJIJ6ktljDWVwiq1eHl8ENOs4ltEqGyyZ0/Qm21VFlC2XpMVshtcaAVS4xA9MjHhb0Y+K2hOmLEs+zBG6GABdcAXmRTPjfnmBIuvtkRQUmTe/ILP/jmbF67nIR22srCYey0ERCHyA1SNgPyO8wocRMNg5gQGi76nrdoH1/3yX7zboYBMht8bSBtYLxDGoPJYOwA783Dlv/rnbOWXmk6Ty2dZoY1ZZdeWIZPW+Grzt/xJ;25:HaDvKYhnR3HuZyo4iVpsxXjn6Nd9x50Mnohbxl8vAWMMwcVOOTFe5Ap87gKnhCNwaV6w6LLO9tr6QfvHtdx4p+cFJHXrxub45lrGtevlBwjZTPkLkys09J8PzatkZE4dzNT2865k7LWGWtr7zOXTI/TF50ZZrzK5AjvKLdEZ0rxOgKu7CCJa0kVD/Wjm2swg6bZ2R4MyAKE9E0T/B6ul+Z1HVKMY5hNfXxQPJxq3c9Bo3YnNSTMZFLbToi+a9UVF2nDvCXt0szyM3Vic3/byj8jCgDmU5f2K9LLz1wQ63bLDVAhUffSnNSKthx0NvXmlS3gEz0uzMMgiLnCpADsR7g==;31:e8/GggLImTY7I1CQ92iIdqryVCxnAFZRgk+c0KsOXzIAbGMY4SGRkpHt8qVUTX5Ce1YDjbxykCzPB8kKxs8L6geIoOAB+A8MbrWhEc9592moLnQK2OdfV0c7TzpujalwEBNzJQ3RmZvTtf7kE5SKvLfGQfvPRYqUlIqVMVOOJe1lz39rJu/8hr19ReExppQ4PgqSulv4yQghF12+BE41F1wmb6sUSroYEkz7Awbl75k=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4376:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;20:9P+d4X+IdUV5utvBTVO7uX0u3gNMq7f1KT749aFaemLz7ezU0VQRKx8xl7xcUDEUv7YQ6ItYcvbg1o0wFRmLvCvRhP4Mm+QfgypjKO168UWktvoxye9qPsi84S5JwglnMwdY0v2TObxxVlcjal26Z4g5mScutW5Py+nTswWodzwXkEuXpag9O4xQveHcAcAve6t/YHPGBSzWr+0IvIo1s/nJlouu/40up8D0chNHXB1zoNyMFGyhGXcyOFV0LBKdNQXq/NjeUfFPDBNR9mlq0Dup13fzh4aT00Vj7OSbyNcykTwFWHSzBrlsiBRWVvrr/GtWGIbuGx1ssAbbVZPiKZarV6qr2lUMRuX3eYEWYaeTu8tMCgziwipWB1Mybk/jSFHTnqMOnqP0vkU7BCzyruy8D17TrOPDFjf0vkffeFMMvK8t0UEbP9qByTo2/RalfnQFYOQKI8zJa1nZme/Ogba+IefbFVkr/j1UlKxfmiVp/HRS7EPR0kgCjhb3d+KkUUpFmerEf4OkoM83x256Gt22lk1NG2a8Ion/Lwbh3006yYdwrOdaMl6Q6Kj7OqbIp/JCCcNLC/1N/hhdwROp//85FhiOY4eAFJL3NEX11dU=;4:8tBNMdiBprQWDcB7oRzoIAW746ZY47b/T0Up8tPB2IJfga1yKw0cfaTtFB9YwHTARkeql3uFeBRMU1OG9Kuxup221C16+rTsniUMFvwJwbvnCwilKEiS+9zhF4GC1sD30xcICsRbntSw2mpKlt/sJ4b3nYFbyK5yDyGS6+qcMHpIi3IHRQaoc5DarQGctz/GFtTTTRpflGVF/AX55vQmtUrlx2jvP3ATn51lbxvfzP6p3cvIgmbaskF67kalsmk0D+fIolKMzcXZSrCib+jx0kvAdJt65/hRSM2qw4thvOdEXNUTwgLgeM+b2xWEbR9D
X-Microsoft-Antispam-PRVS: <BYAPR07MB4376E123FC4B5E2904DC6063E3920@BYAPR07MB4376.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BYAPR07MB4376;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4376;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(366004)(39850400004)(39380400002)(396003)(189003)(199004)(39060400002)(42882007)(59450400001)(6486002)(53936002)(6666003)(4326008)(51416003)(386003)(76176011)(52116002)(446003)(6496006)(50226002)(16586007)(305945005)(7736002)(72206003)(2616005)(26005)(316002)(478600001)(11346002)(36756003)(956004)(105586002)(186003)(16526019)(97736004)(2906002)(486006)(5660300001)(106356001)(8936002)(476003)(76506005)(50466002)(48376002)(110136005)(47776003)(66066001)(25786009)(54906003)(7416002)(3846002)(81166006)(7406005)(1076002)(68736007)(81156014)(8676002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4376;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4376;23:CZWA7czvuLlouWj+Ph0+3uj7yI6t5dcU0hzXeoqkn?=
 =?us-ascii?Q?bwN3YFp7OT8Twxt8GnlcHScvBJzRj/K0Xk83ZXj9s3LwGDBmoPZ1dnYyQy5X?=
 =?us-ascii?Q?4nJkJCzRoIiSR8Z3PU62RpgBm2NDx7mRFlxVhwOIyJKwKYJDHKNIn0G4xp1R?=
 =?us-ascii?Q?Z0znczH/yIqReDsoN235UTWct+X5pQVDfAFmv7srKFw6CVIUmEV4nHpPkg05?=
 =?us-ascii?Q?YJB/hoCevkbBHahR5QqezApN4NuuGcyzM7lTML15ue8Cz7jUD27rH02XPprU?=
 =?us-ascii?Q?2sWcDAYR8Xnu0XG8XMGQJ7kwJkWdIW3xVCV4XROqBqnnAb9oxSduoDdBZ71I?=
 =?us-ascii?Q?t1D06KUfRZILt/bPZZB2ZDiCiMXq4Woy4Vr1sekluSpDxwLpVwNKMLrr3keq?=
 =?us-ascii?Q?bzDQrQpS2g9TPklTYl7plg2s+mAVWFUu3pieMLWvv/2K2L4KqumJ0vbtwubM?=
 =?us-ascii?Q?W7j6qLUGhsmGTRO6noqlBiE/PFVslIPjbkiYPk8dxcTLJZp2W1LN9Phzj79K?=
 =?us-ascii?Q?/UkupgRr6USDaEkZ7IsvVzSSnOaSE6ZSqjt6aCTk7d2QLUIqs7QZmrNz+Vuw?=
 =?us-ascii?Q?sNrMqO3ESdWL8NGjL+UIp1VhpZIr8re+C32Wpj2Qf6OtHuImfWXBnJ82mXNv?=
 =?us-ascii?Q?yRn2ajiAaQUub8wMwMPHBHEGhLgDFxNgBRV13/VHgGq+jM/wot8D0efqe3wX?=
 =?us-ascii?Q?yci4vcFRagE08SBQhxs3V9JsJHPyVywS3AtFMD9Shd3GORYF/ADN0Z8hxe5o?=
 =?us-ascii?Q?IGeSfIlswafBbxsmNRo2lvuM7lq4m6s8OQ6w5PkTHg7I90Yhkoj94+7BcA/e?=
 =?us-ascii?Q?j+GVy8WVyGmvCBq4TN3oila4+IHa0gYlDqEn0Rw9ku8xUyCbxNnGWOb0kLbg?=
 =?us-ascii?Q?mYEW3Ekf6skl2EZ08sYUv3rWTWwqSEgft5rJgQDulKliy7Txjw3kxuh1v/C7?=
 =?us-ascii?Q?ybFkadB4VUpUIy02Nbn5uAc8kTsiKXttqH8FuOBlctHfhNVGLfLIlvTUc6ZP?=
 =?us-ascii?Q?ReafsJVBpb6nuaAiwYnfjjJu9Yqj7+YKZRvPGkaGRhQJBLqE6/xx/tzTdjux?=
 =?us-ascii?Q?UlbhOd8VUm0pV/VpvPr5o/pyZAruBxf4pfIemyEaEeJBg9RdVfGlBF8Zfs0S?=
 =?us-ascii?Q?mNXFrHi4Qb5kqcB6t1zJaUV9+N1iYcLqONDVz0F1HyP3ZmGj89wOftA41yaa?=
 =?us-ascii?Q?HaJwPM1yY5gCNYNHGCstyZwRYZAQI4Z6JyIx49BbADwXe4eJn6Gaw4bjjQsz?=
 =?us-ascii?Q?qADfwYW/Z6tIB1tvLECYCGp4LhubF9ZN5AbU2Th/40+jbjRUMvZV/dDq/zmc?=
 =?us-ascii?Q?XRRRR2Tl59OXAhxYIKpNvMV07KT74a0IMFoemmRv6EgaFSbwIFYN8Bpb4dGb?=
 =?us-ascii?Q?scV2A=3D=3D?=
X-Microsoft-Antispam-Message-Info: Gq1cPGyDcy6hgOG7/ocBZ7EoVKTI3hoR9FRHhKrbFIuNf+OwxCXg3jF6173KZJ3o0dyi38eisVJF7r5MVlBAF6p1cnpCOGK2YIhXXvSEZpo4l1Ewf9lLSGA9u4/BYI/JTEMZuXTOLFB9bHt2boymGz9437QlNrMLL6uGEOWFWJ59Q9XQDBBmp+3cRQz1iwT2
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;6:8NcKHqXyGq1/xIl0nke6s50vL2OShD56HKzSS4cPrYAHMsq5ZdJCgvR0fE7xKXO+XjAuFHqGhqNZ7XmFe25r+SyUtHqmQTCboDFBFl59yhE/ea429t/Gaz4uljZtH30/hnDLYXHlCzPlGVt0AJFf6apf1KIGp/zH9CXPKInkMtswM7rVdpI+D2NbStP5oS1la5Z24QjWhEoGBs7CmC2nwjdRrAvLlfQBhGILFWPUz5LZ0mZkVZZFlP5dWpaPaVEh2yLi0qMpdxmQBEZMvjasHgD1R0+7E4eBprtKm0QFFaq5ZoMgWOEYDy5fq/iPkkzX2eFcSJ35nP8raeVjsBUT8sG60t1yCPWetH2ifp2gbHiE4f/9FVpuXsn5xaBTUJPrNLP/GkKtGNrBB9t4t2tTb3a/ohSpl9SDXOkZafpqHpy4DcynwvpjdvzC01zzzz8Yqg0INGQGDhL9KqUl1iKnhQ==;5:QdUh99/4buMDlbxn4V5YUZQH+NnE/PuoCwLq1luYiz+8y8kR5B7McnKnQsRnBY7h+1M9jfII2VrCAWwaYYnbchBHK0qmsadLR67lz9SB8PgLgFS85JDv85uekPWPH771GeWW7DzFCpqqT5S3Qz/ru67BmEdyFHGQqMMW3+UwD2A=;24:cFjIDczPoWFQeYcUxS0Hy6+iD4ooBzmMaU2D4tiLKu1MWoGXZDWVtx4YIsC6Rom1yoKk5adOf7yakKf/TfHvOuCMsBn1iiLPGP1Ixx880bY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;7:2sKim44g1gsWMkTJI8U0FlR0fOTQYY2e3dDlBQK5E+PWwg3wgzd9MBpmZGhwq1GG9NUVZfOjLJlTuPrN1SdzJExtDiaGJa2U1VeQerTK+XkJ/6BVyEXYVMmESFzBhEobrUGQkXaBRCWqMPsIbyI4bdK8matngGSV9asEjX5YXaFxm01rlPagUx1u0cmB0MXNy2R9YL8+W4CTgeu65xh64WlEz/yImCGijzxY6lVEAPNIabFf4xm7epmno74V04lf
X-MS-Office365-Filtering-Correlation-Id: 7843e00e-1138-4bf3-2a57-08d5bb05c43e
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:19:37.4900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7843e00e-1138-4bf3-2a57-08d5bb05c43e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4376
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Martin <Dave.Martin@arm.com>

ILP32 uses the same struct sigcontext as the native ABI (i.e.,
LP64), but a different layout for the rest of the signal frame (since
siginfo_t and ucontext_t are both ABI-dependent).

Since the purpose of parse_user_sigframe() is really to parse sigcontext
and not the whole signal frame, the function does not need to depend
on the layout of rt_sigframe -- the only purpose of the rt_sigframe
pointer is for use as a base to measure the signal frame size.

So, this patch renames the function to make it clear that only the
sigcontext is really being parsed, and makes the sigframe base pointer
generic.  A macro is defined to provide a suitable duck-typed interface
that can be used with both sigframe definitions.

Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/signal.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index f60c052e8d1c..65406218743c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -334,17 +334,16 @@ extern int restore_sve_fpsimd_context(struct user_ctxs *user);
 
 #endif /* ! CONFIG_ARM64_SVE */
 
-
-static int parse_user_sigframe(struct user_ctxs *user,
-			       struct rt_sigframe __user *sf)
+static int __parse_user_sigcontext(struct user_ctxs *user,
+				   struct sigcontext __user const *sc,
+				   void __user const *sigframe_base)
 {
-	struct sigcontext __user *const sc = &sf->uc.uc_mcontext;
 	struct _aarch64_ctx __user *head;
 	char __user *base = (char __user *)&sc->__reserved;
 	size_t offset = 0;
 	size_t limit = sizeof(sc->__reserved);
 	bool have_extra_context = false;
-	char const __user *const sfp = (char const __user *)sf;
+	char const __user *const sfp = (char const __user *)sigframe_base;
 
 	user->fpsimd = NULL;
 	user->sve = NULL;
@@ -493,6 +492,9 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	return -EINVAL;
 }
 
+#define parse_user_sigcontext(user, sf)					\
+	__parse_user_sigcontext(user, &(sf)->uc.uc_mcontext, sf)
+
 static int restore_sigframe(struct pt_regs *regs,
 			    struct rt_sigframe __user *sf)
 {
@@ -518,7 +520,7 @@ static int restore_sigframe(struct pt_regs *regs,
 
 	err |= !valid_user_regs(&regs->user_regs, current);
 	if (err == 0)
-		err = parse_user_sigframe(&user, sf);
+		err = parse_user_sigcontext(&user, sf);
 
 	if (err == 0) {
 		if (!user.fpsimd)
-- 
2.17.0

