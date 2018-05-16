Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4128544-1526459195-2-17320134642184897871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526459194; b=MGu4ZxiJEiZnVvLEqMONziiQrhxsd+x89gziKLJpF2vKaTKsV4
    nB6Nj7D5FObtkEwEuZa6Y04TZIprD422GvTZrqhPeL0YtO5KZGRPisybKy1aPPdy
    6lpiuAhYpx9axje1Maoty6a73Z6NF7+T1+5eQxJ398pU4Vl7g7wmq+gpi2coyl8g
    MSMR8juOQqh51iJFagYWTJUcxTuj7tEu9OoNRa1lgvSGtsy+cIGwmnuMeieO2btZ
    RVFuGzbf5YvC6te8aNWMsVQC6+2+5iwkrfEwLVoxZivS3Xm/qThXOg6pi9Dm3lXq
    q/xsHfH3UOpdmPmAhA9MDx41oXQ80DwbLuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459194; bh=lsRT21eZLZcBsNBzUHZP6bqHMfLwMt
    EUOfTUPwKHJxU=; b=KUN7TtLN3OXStbXmpyIC8DLeA5q0zp8wHLXn5k0g0zcRKr
    4KDIZZgXm8X+5aCvhf3J+w6/yep1QJLFtY8ybHje/GJ83haeRahKGD/sJ/pyjgjN
    pCmALAoaj+v8LskedJ2MJvM8OPD+dG6svyngBCsX46vpS2A66QSr85xkKUabCXdb
    Eh4a+M3M1DFT1sSVdf0GPwKpu+XLxJEMPuUhE7ODqy/IYs31YWIyDvfubrXUQkZO
    wuTt3m5Qmv7COArlw3+IuWNfqSImrxYS4frMP6B3d+ueap9YsBDahL87dYPXJ1Bk
    LPvuGknCu6xfg3gl6RDlgfqoeV1BfS7gRtVTzXVA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=CfeNH4BU x-bits=1024
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=CfeNH4BU x-bits=1024
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
X-CM-Envelope: MS4wfEMHtvzsYnqvHr8J4REn5GH8Ma+PRsWNvBJSr3jLslkoW8PbpvalsgJXpSJc8qR9GG06jlHZt8xqYOutVxKDNmk1CZiKLHphmVReyy13HDEIn94S6wg4
    /PpVIsD4vpbyrnhSGjOogZhPCmC1GnHpQY3Q0ddiX7kq69fFjFJhwMDI7ynMXwFXIB8f8jy+Dum0Lnm6E7cs4YEYaQhSgVw5xHoqkc33ppTmcjPRXH+kQwXM
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=yGmpZmWGxwcA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=zAyngx5bAAAA:8 a=enOvQawGAAAA:8 a=pGLkceISAAAA:8
    a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=z82fghl1wHTNHNTuOfsA:9
    a=t_uuJzYMQdXFO3Sv:21 a=-8lTkuO5oPoJRZFR:21 a=x8gzFH9gYPwA:10
    a=4LA4qAFo6bo561LpWNDU:22 a=OuzhcWw_GC9nAYdNdRwA:22 a=_FVE-zBwftR9WsbkzFJk:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeEPIWn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:22:43 -0400
Received: from mail-by2nam01on0075.outbound.protection.outlook.com ([104.47.34.75]:58385
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752874AbeEPIWd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:22:33 -0400
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
        Andrew Pinski <apinski@cavium.com>,
        Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Subject: [PATCH 17/24] arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it
Date: Wed, 16 May 2018 11:19:02 +0300
Message-Id: <20180516081910.10067-18-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0114.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::16) To SN6PR07MB4384.namprd07.prod.outlook.com
 (2603:10b6:805:58::15)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4384;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;3:X5lnRTJteecAEFRmMz4c5iCmTu4WflLBtgoYg/hc2Ca/oc2RtPVrNRhHbQ20b2QEPKqasL6AdD4G1ghCdYpUSw6aIhRxhGHADL/rFhhbXzMkwDnrdCoRmOl6NDna84/klO+JZrtgUiWrq3IgOXPOHZpuV9wBKY1/VnsXnSti6ObCPSNRcwkRBwg4COOMi7Zp6LyNE44yzXmLcQ4fSw5XAhZYIQ5a3t3s5PFJ0i08AqOkq3v/AaqOXuDsG1l703NS;25:D4wrvlIO0Rwh4qj6aCidnmR0IGgKGJPt1sRQEkZL0UyGWYvnIYqPkZwVO1LhVCtLwP11JSAvSXTNlFYiz3AKXosVeiY2uDe9du/wi7ZYDHqEz4NTAMPq7Hg0nubnwT5bNj0iN6WJAILFXYAboajLpK0zpBegkJKsuz0Vw/3M9trqSpBX7S556u/LiVxLkt3tc3INaBBTEb6RXirrNwDByWwlj8+vYX/SBvgNYMuIQpdaBbtANvzFaFRe6SoBuU55FvXgP56qlJxJnYzoKAumhkbPzp9MTOqh+ap4BWf2UyQ2lXC96p5YoOdWwQ98EndS8/3mgt98cZ1P994qWnS3Rw==;31:2sOYSHQiOhClV4tbcII6nfVx0jJnxKT4TZrbh1vcxpvbmYzAvhQYt34OlmWfhB/HlpFgCJD0TOmMfsDadtanLdI0uzpp1XAEnilPU5iNsXpZZwVY/mqPIVBK1NX8dQmLeofBdOa/OceiN6oLxBti3TsyNK7uPLQKczhlhcu7TQK69MKTVvAfMdC6GpQHZGFD/wMXq6h8YaEVwByPinIluzycKt5pGYOoF1F8npjsA5I=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4384:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;20:lSRSuLmTKoxxmhReNTEOb9CX4P0eHPSBfy7LE2p0hZCIEIajuwyKPeOHQuvPLiYVZJ0ncn68ZTns1SMMbbuNXz6hAI0vb0t8dJFC9+yKs6oTYRp7d6SRQG7JeMWowybN61FVjcA/4L57jQqBJ/L5aTdqS+skWLZBOgwywTjOKnZXkUOzohaEFZkmdB0lk5kA/gY7306xRQASRlzddZGYlpAQMyVyjBrfTpolRg7ETtCq2xZfnbGubX9nk6K7Ps+BK1niXN6tzG7XuSRdfnnombZMcqc/eaSO7GsgLRkvtoCYnViFrlntL3YumZHtfguq2/vEBMgBXeS5duTnWI+eiL8jZ08IFj4HTAZvX3nqvtlxdL5+NA2l1ennd1uNNB281ae2R6IM5QiSE/NfrL7MBrBlnGKRjzUvNEW7/GxKdrGktgFADCZQXMV+LH0TZ1B+LJXbm5vW1fZWU5VDORm1YNDXKugPbnOyf1ueJ5VoA5LeemvITdciRBSVmA1uwIpCEQGLX8n2AIi1Pu7Ck4wvwAWxiHFuNxxs8s9SRe2RyRIHyiEdb72RjgDlqBl0F3TQgJog8yqeH7T6QzgQSyM4A8Dk9PEE0mZ1iloMEJWmDpE=
X-Microsoft-Antispam-PRVS: <SN6PR07MB4384CC03BEA807B98599B18FE3920@SN6PR07MB4384.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4384;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4384;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;4:YaoXOFSnDsVuPLRW8XfRZyXONQofVWlJe7JaEIHbOD45C3stDQ/8ylnr3b2GV8+NR8eJfp675mhZJhOrsvyw+9LnuCfNs7sYLHlV7aeEG9T+DBVZygirZ0Xw4LJ5PCGn8W8udhS9V7mBPvr+5yAyfX8G17SLh9FVncEYJs4n9UpsE/TE0lLfPSbt0WGJdrQ3+hceivDEp+8sJ9xVPxs8EdXA7WzFiIi4i35AmbZesjONLeH+7flRroByPrOHx0w9gH57/cPMXd9n/hRr4rWitZf2gE/UcEBRaMb0/fohniTSeeW2/B6xu11/5/GFb+GX+H2sYCa6TSoUsuTn0nOvSaw/6zYG5rYayakJseRMk2bmRjtuD42+uCD1AE0KBFnV
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(366004)(39380400002)(39860400002)(376002)(346002)(189003)(199004)(6306002)(36756003)(25786009)(7406005)(6496006)(7736002)(305945005)(2906002)(105586002)(76176011)(52116002)(51416003)(7416002)(66066001)(486006)(6486002)(6666003)(42882007)(11346002)(316002)(446003)(16586007)(956004)(39060400002)(2616005)(54906003)(110136005)(478600001)(26005)(107886003)(386003)(59450400001)(53936002)(47776003)(50466002)(3846002)(106356001)(81166006)(81156014)(48376002)(8676002)(6116002)(76506005)(50226002)(68736007)(476003)(72206003)(16526019)(97736004)(5660300001)(186003)(4326008)(1076002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4384;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4384;23:cPUKIGHvZINqDKRIs4BzLiM5ynR14vDPiUL7NySAQ?=
 =?us-ascii?Q?gDauqGbRjAf2mU2vJzklD17JwhTbFid4vG5hbVRMGVo8DYg68cvJ3Qv3uP3C?=
 =?us-ascii?Q?4AeuCHWleNmOBQHAcV4WWw38tVHe81TYNvhroy3hmz1zFbqGHNyXmFr2XxaJ?=
 =?us-ascii?Q?yM9MzLpZQSq58V9149ZK+AomQG7RkEzZZeRUdQRw/FZaTFlxnS7EDBpLv8hn?=
 =?us-ascii?Q?JO+arO6Vulv64Lvngm/MI/L3d7uqn6OCJ5OsZoCswq/MQIgxcPLict5AxU1+?=
 =?us-ascii?Q?fN79uORvGLFRjKUya7PgZzaPU3zV7BU/ZmAcsBP9MVaS6ZzXjNwsAiXOrT4f?=
 =?us-ascii?Q?FZPdGHt6DENDyIp4dtJVY1ufxcIjfCUS9t+k6zxBL3me0j3m4mGDaCPj3KhF?=
 =?us-ascii?Q?3MLpWYZv0Mo7Lc7dKvFZfaoS/dAiZ8nSk4e1SJ2XVoH5/XGuqJRkFm26g5T+?=
 =?us-ascii?Q?JS5Xs4wbECoGY65I35/0rDRIa/xMCa7NlvL/FSBmXkqQLjkqryCh/gI6D97X?=
 =?us-ascii?Q?BAIzt9/HNK/Xwh2jnFD1xU353L15i1p6Sgt4yDuWe04n8SjAot7zYorpUeZR?=
 =?us-ascii?Q?1Ktk+KCE0gdjFu5ycwroctPYogVpzJetEjER4EkICKrkJefu6kidg384p0Ym?=
 =?us-ascii?Q?KIAI1AZuOAddznN5MkHfQc2YYdN9n5QhrVOejPKzxY68JcxYFRWGnv0mM3t2?=
 =?us-ascii?Q?/IZvyg8YcCKQphv33xT/gYZ/1KjjBlVFe3ssOJX05DpgJ4lRyAafBIIP4Au5?=
 =?us-ascii?Q?MeTcSY+JH6s+kFn9i4bqUU+J9FjIZAeI6ruWHvWzYnboTrgkqMylvkWE7lF+?=
 =?us-ascii?Q?Ev+EaVONq2hUsGri6wkLmFsvy/Wia/rBTlDTTB72JqB7v6gS9ICFeRzYzpnq?=
 =?us-ascii?Q?hep1To2NJNXqeTGnKCaDcBP3RRU3xEPX1PUc/vVZSYJYtWrgPEh2Y6PKf7x6?=
 =?us-ascii?Q?dBCGi/eFXm5VpinxwwGcgYbhcjc6lnT0Ua++8OKH2TbdvC1fWUK8y3bLLQsG?=
 =?us-ascii?Q?G8ZDFVJuLcb8ZM0nZfZF9p/oo/bXvYAdJnEkuBgS69e1tRIHLPUfvbJ1c+om?=
 =?us-ascii?Q?jTDNThs7rPlgdMJnfSEbczl41ou6W/GG+5DTzm8GDM3UpiNJs331XLvkNgiY?=
 =?us-ascii?Q?uo13vSBVowQbNz8+fNHLvEQzeV9HMOPGk1JgtWFJ+a27R9HFdbwjV2qjN2l7?=
 =?us-ascii?Q?NHOcBmO9xY2I9mnqVIGAZnN5qRNV63qFa02M6Hwv80J3tPWpVXxebSVNO/id?=
 =?us-ascii?Q?FIhaW5iBiboXy2G/hTbsppLrmdvgPz9g+Z35X9oa4FhgyK4RFmsyiAng+phV?=
 =?us-ascii?Q?jKY90fPDk3GDAf9oycD164MnsWzT7uIHJdH5Rxqa+5tOp7e71cAvYVEneOrO?=
 =?us-ascii?Q?gsCjnfKWdaN1YGy+jxaRYL3elSetV17u3TS1yH+iKMdI8EY?=
X-Microsoft-Antispam-Message-Info: 9sbl/X61wZ+qlIZUO2t1h+VGm+Ca15ebOwZPNBKBpBr4NBt6g9Ian9eLIGYSRieD/CxUAJ87smMunhVx0lgAMgFAKOeSIdqLzVaBecBYl4T8bcZPUlEHAo6Cf1dX+FZ+BTvflQ2uxW47lDNax/D7tCgDswvGwzwzVHzoSDLIMfTTVYLaNs2O55YT5AHlq70x
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;6:jLV1e6xr4KUHRvJo8XSgrUMh1tB02OyDXuc+ZC6WQK1ece+10qnbCA0QOG8EJu2NSdWErJkWYfgmJwXtz6jLCgV79huUVWnZvaCc67ewFnQNMzKzuUb/lDhd+SA+ltrTs+XSCZx9llZN4l1AoG7v5zwaYYMboltmjTtKKQh664ULWujw0hwF18NOE9VgzHAHsaejhm4Qr29vhwlU+9j8jz0M2HNg3igqx1swAqLt6q2gd/411cyEANNpOK/WGL4Xvud7yyezatjB/kCAmIcJU1Gg4afnFBpNVQzCvdIiG7rBosMTuM2MMxbaAjcNxerFbd/eEzCBbpbpWwuYKRa1V2axPy0H4VlSSFm0E9PxeV5YyocWDjNCOXaHDym6ytc6y1w7dxz+U9WSGDup+no7utFWRKQKsLrKl4VCSJd7nwgzEoFwoXYCjKbXWuoeL3esoNqv8HvSf7oXeK5TyvDDOA==;5:4eSJhPGtgpw1ydgqj0xsB9vm/cFpACOlpRAHj8PoYI47nn0qMapyDcP2/zq/whFSjddr/dAV1eJNXStzeGMsO9alpjurjTgkYfGp1QpF8ard8NMxH+Tfo84q9X+dytIwump54LIhim6CiR2k5J4cvlkRWgSo5pwnhBQ0IgQyt4I=;24:JmG3C/oJSgRereh5C/GSeB4Ia9RTPdGMUk9bzxoIs24326MxkYdHTYHl++RlpDRZFtl+pbKOzCM5cnSr51O1FufYhvWKN6yMZT9If/HLcVk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;7:ZBp9JRlmuRbV1+Xsx+sd7vyNowC3424FMc8KEZA9M8UXe7TpBkRtfBye19kcnh0/nWlO+BjxY+eO/5EX6YtfiWyJL7MbCXoqXEMJ9fGLaKgKXGWepogGWTeExstoxptTblJmHwBEuu7JM5A66GGIaUvzhs0szWggYLmPelMSOs9bC8R+Jcr61abbVcWiQIzsAWmtWwSx+Q+GbfTD9mWF8gEv3EtoPQE8mxDhq3Gd+dEr7jxamXMNv9Fk3dVbBeYi
X-MS-Office365-Filtering-Correlation-Id: 0c800a41-dd5b-47d8-216b-08d5bb062b08
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:22:30.2225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c800a41-dd5b-47d8-216b-08d5bb062b08
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4384
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrew Pinski <apinski@cavium.com>

Add a separate syscall-table for ILP32, which dispatches either to native
LP64 system call implementation or to compat-syscalls, as appropriate.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Bamvor Jian Zhang <bamv2005@gmail.com>
---
 arch/arm64/include/asm/unistd.h      |  8 ++-
 arch/arm64/include/uapi/asm/unistd.h | 12 ++++
 arch/arm64/kernel/Makefile           |  2 +-
 arch/arm64/kernel/entry.S            | 31 +++++++++-
 arch/arm64/kernel/sys_ilp32.c        | 90 ++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/kernel/sys_ilp32.c

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 99d29290c98b..1bf5572cd078 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,12 +13,16 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifdef CONFIG_AARCH32_EL0
+
+#ifdef CONFIG_COMPAT
 #define __ARCH_WANT_COMPAT_STAT64
+#define __ARCH_WANT_SYS_LLSEEK
+#endif
+
+#ifdef CONFIG_AARCH32_EL0
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 439b1c55c827..80f1cb4ae2e1 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -15,7 +15,19 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/*
+ * Use AARCH32 interface for sys_sync_file_range() as it passes 64-bit arguments.
+ */
+#if defined(__ILP32__) || defined(__SYSCALL_COMPAT)
+#define __ARCH_WANT_SYNC_FILE_RANGE2
+#endif
+
+/*
+ * AARCH64/ILP32 is introduced after next syscalls were deprecated.
+ */
+#if !(defined(__ILP32__) || defined(__SYSCALL_COMPAT))
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#endif
 
 #include <asm-generic/unistd.h>
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2dde9ae508ec..a6db407d4089 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o binfmt_elf32.o
-arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o
 arm64-obj-$(CONFIG_COMPAT)		+= entry32_common.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 698907724eed..d03542418f9b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -401,6 +401,23 @@ tsk	.req	x28		// current thread_info
 
 	.text
 
+#ifdef CONFIG_ARM64_ILP32
+/*
+ * AARCH64/ILP32. Zero top halves of x0-x7
+ * registers as userspace may put garbage there.
+ */
+	.macro	delouse_input_regs
+	mov w0, w0
+	mov w1, w1
+	mov w2, w2
+	mov w3, w3
+	mov w4, w4
+	mov w5, w5
+	mov w6, w6
+	mov w7, w7
+	.endm
+#endif
+
 /*
  * Exception vectors.
  */
@@ -695,6 +712,7 @@ el0_svc_compat:
 	 */
 	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
 	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
+	ldr     x19, [tsk, #TSK_TI_FLAGS]
 	mov	wscno, w7			// syscall number in w7 (r7)
 	mov     wsc_nr, #__NR_compat_syscalls
 	b	el0_svc_naked
@@ -916,14 +934,15 @@ ENDPROC(ret_to_user)
 el0_svc:
 	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
 	adrp	stbl, sys_call_table		// load syscall table pointer
+	ldr	x19, [tsk, #TSK_TI_FLAGS]
 	mov	wscno, w8			// syscall number in w8
 	mov	wsc_nr, #__NR_syscalls
 
 #ifdef CONFIG_ARM64_SVE
 alternative_if_not ARM64_SVE
-	b	el0_svc_naked
+	b	el0_svc_select_table
 alternative_else_nop_endif
-	tbz	x16, #TIF_SVE, el0_svc_naked	// Skip unless TIF_SVE set:
+	tbz	x16, #TIF_SVE, el0_svc_select_table	// Skip unless TIF_SVE set:
 	bic	x16, x16, #_TIF_SVE		// discard SVE state
 	str	x16, [tsk, #TSK_TI_FLAGS]
 
@@ -939,12 +958,18 @@ alternative_else_nop_endif
 	msr	cpacr_el1, x9			// synchronised by eret to el0
 #endif
 
+el0_svc_select_table:
+#ifdef CONFIG_ARM64_ILP32
+	tbz	x19, #TIF_32BIT_AARCH64, el0_svc_naked	// We are using LP64  syscall table
+	adrp	stbl, sys_call_ilp32_table	// load ilp32 syscall table pointer
+	delouse_input_regs
+#endif
 el0_svc_naked:					// compat entry point
 	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_daif
 	ct_user_exit 1
 
-	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
+	tst	x19, #_TIF_SYSCALL_WORK		// check for syscall hooks
 	b.ne	__sys_trace
 	cmp     wscno, wsc_nr			// check upper syscall limit
 	b.hs	ni_sys
diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
new file mode 100644
index 000000000000..9803d7806328
--- /dev/null
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * AArch64- ILP32 specific system calls implementation
+ *
+ * Copyright (C) 2018 Cavium Inc.
+ * Author: Andrew Pinski <apinski@cavium.com>
+ */
+
+#define __SYSCALL_COMPAT
+
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/msg.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/compat.h>
+#include <asm-generic/syscalls.h>
+
+/*
+ * AARCH32 requires 4-page alignment for shared memory,
+ * but AARCH64 - only 1 page. This is the only difference
+ * between compat and native sys_shmat(). So ILP32 just pick
+ * AARCH64 version.
+ */
+#define compat_sys_shmat		sys_shmat
+
+/*
+ * ILP32 needs special handling for some ptrace requests.
+ */
+#define sys_ptrace			compat_sys_ptrace
+
+/*
+ * Using AARCH32 interface for syscalls that take 64-bit
+ * parameters in registers.
+ */
+#define compat_sys_fadvise64_64		compat_sys_fadvise64_64_wrapper
+#define compat_sys_fallocate		compat_sys_fallocate_wrapper
+#define compat_sys_ftruncate64		compat_sys_ftruncate64_wrapper
+#define compat_sys_pread64		compat_sys_pread64_wrapper
+#define compat_sys_pwrite64		compat_sys_pwrite64_wrapper
+#define compat_sys_readahead		compat_sys_readahead_wrapper
+#define compat_sys_sync_file_range2	compat_sys_sync_file_range2_wrapper
+#define compat_sys_truncate64		compat_sys_truncate64_wrapper
+#define sys_mmap2			compat_sys_mmap2_wrapper
+
+/*
+ * Using AARCH32 interface for syscalls that take the size of
+ * struct statfs as an argument, as it's calculated differently
+ * in kernel and user spaces.
+ */
+#define compat_sys_fstatfs64		compat_sys_fstatfs64_wrapper
+#define compat_sys_statfs64		compat_sys_statfs64_wrapper
+
+/*
+ * Using custom wrapper for rt_sigreturn() to handle custom
+ * struct rt_sigframe.
+ */
+#define compat_sys_rt_sigreturn        ilp32_sys_rt_sigreturn_wrapper
+
+asmlinkage long compat_sys_fstatfs64_wrapper(void);
+asmlinkage long compat_sys_statfs64_wrapper(void);
+asmlinkage long compat_sys_fadvise64_64_wrapper(void);
+asmlinkage long compat_sys_fallocate_wrapper(void);
+asmlinkage long compat_sys_ftruncate64_wrapper(void);
+asmlinkage long compat_sys_mmap2_wrapper(void);
+asmlinkage long compat_sys_pread64_wrapper(void);
+asmlinkage long compat_sys_pwrite64_wrapper(void);
+asmlinkage long compat_sys_readahead_wrapper(void);
+asmlinkage long compat_sys_sync_file_range2_wrapper(void);
+asmlinkage long compat_sys_truncate64_wrapper(void);
+asmlinkage long ilp32_sys_rt_sigreturn_wrapper(void);
+
+#include <asm/syscall.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, sym)	[nr] = sym,
+
+/*
+ * The sys_call_ilp32_table array must be 4K aligned to be accessible from
+ * kernel/entry.S.
+ */
+void *sys_call_ilp32_table[__NR_syscalls] __aligned(4096) = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
2.17.0

