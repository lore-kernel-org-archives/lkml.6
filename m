Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3096842-1526411576-2-7452822990879419656
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526411575; b=OR45ZHbSCIznG2HtanZ8M5wDD3vrYOQeaQB011k5RM6hsdPYpi
    RG/FUQv67YIiiDAxxxHeqAdDijxXeABbFAZubUJMEdObdnhr4Ewc/P2wcy5vKFlu
    fEf6+AvRjJ1wKEMLBZIKxa0+Yh1ERcZzKbo0qpB9X7oJgqwNmoqMdqxPtoxxbxPI
    jRNwVC4MpC+4RQAxI5p7PVsX9oQPMFJ4uX8OsKm8Xqr2NX286ikF3t9QiCqhIQ/c
    XTFm70AeUN4B3aGkaqzTjGPAq3GLiaP361//7zt7D/q3M3SATen/uU/jmebouwcX
    koxBjyfOrttopswdNiT60gqh44WZeeKvGTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526411575; bh=PfgDULwB0jsQXl3jEb9HcWM3cPjToJ
    eK7ojzHVmrAOM=; b=FDOnR+Z9tYc5riO8Uez8jtJB2gjOGHdVg+RfngX6/Gay5n
    mjDQqptMEJoW0jRfaj149+1vcA+9foc1KqfyBPpWCfquB85soK30A2qQqojiFIUH
    Pse2v7/QgEt4ZgetnCjM+oA3uGdtjDBph2K4o3ECIDN1jYoNwgDYi9iTlWDaFi4t
    6knl9kkZ+zMuGhL2TbKH8wkl/IOYeioSqKNnyNVRCLljZbdOngC9L2XbOSN5rrGF
    eSRKDDCCiOUiw1EYFATFso1sJdksmBMVpy/1SiyW+4CVEHgzAFBtx7UXpCsrSuVm
    rA8NdgOFOs0QSwfGWh4HcAKDprPSQWULfTweU8nw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=VfRiTU1C x-bits=1024
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=VfRiTU1C x-bits=1024
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
X-CM-Envelope: MS4wfJkcUWS/Hj/f79v+5fcSimL5BNjj6GtkzQ0aOKKtbmBgf8FbRxkOny9AkgtuL+lNGtjg48oMl87KLiLS+jtc9f6efjxXbNhQRVGFlo4gskt+bFCDOAiu
    7U5C8MEWIbPRVsdruZdZIXe3RtuJrvpTAZN06mfjYcIMQLZlCJC1gL1HkUeBLi+AkaDxk69bNtYaveEEdLRO8gAtiqhC7FxIaGehQ3cBYFLFCEcFaEAQDqqe
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=NMmGLDPa_bsA:10 a=mu3WYqzaZi4A:10 a=H9XALQ4oeggA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=7CQSdrXTAAAA:8 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8
    a=BUTbYKXI85lQsqGHtjMA:9 a=x8gzFH9gYPwA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeEOTMx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:12:53 -0400
Received: from mail-co1nam03on0054.outbound.protection.outlook.com ([104.47.40.54]:12800
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752500AbeEOTMu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 15 May 2018 15:12:50 -0400
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
        Zhou Chengming <zhouchengming1@huawei.com>
Subject: [PATCH 01/24] arm64: signal: Make parse_user_sigframe() independent of rt_sigframe layout
Date: Tue, 15 May 2018 22:11:51 +0300
Message-Id: <20180515191214.5045-2-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515191214.5045-1-ynorov@caviumnetworks.com>
References: <20180515191214.5045-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.40.107]
X-ClientProxiedBy: HE1PR0301CA0001.eurprd03.prod.outlook.com
 (2603:10a6:3:76::11) To BYAPR07MB4375.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4375;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;3:c5uUkIZ9NUluRijkLEW6hNMWjZbdCwe3UfTdQQSRDy1kT3L6xXx4AabVyIxOJtn/buCntxvEtPpZ6VTymTz5KJ6++6/dEZ36opeCYkxSx0fV6eUdqbgr6iW/9S/gGKuRUJmCwbALefZ4Z2Fq6lIc3tkD0ExMISm27JjfYRz+IjnB8yMRl3Qzayu+jC2K/EUfmouigTyva3CjsMiQRiZ5UCywRNUAsiyBz5Lm/7WOqiLXkXsYagnVozaxr9u1fSew;25:AUooJOm9K3w6ijO4/2y9YefQV/Uhren3EZckSJazPof36+fgsGZPTMt7JzVAmbs+SUP2oGfiRtNoThvWWj6/We/y0xlrvpB9J0YkNi7Fe9Q8zV6M3iykBlE0Bs1/JGjt9bZPvPH9eRirlHxNVzdDgYT0Q5bIhMUkwlRL7pMu+26b5IY8pAytV4zGd814o8DPeMIS2GzSqYLkAXRuOhh490w3KtRwd69ChfydS12UyEs6H+cDR/IwJoGHi4vg8mN7wSodHqmh+hbWXQgn2Cvposcpnh0I5pzZLcAE+6jNnXAOGSvjOvWDYY8RIrA3QLYjYmo//bQS6AE+ubjdyWVUSg==;31:3aEVzMhOnkGYoH4MvfCaVRrvRna8jZBA2Tim/Y1X5tpi9AVGh9kNKeLupH1j6Mg1303ug8CKJhW1bzqw1Eq1bAH4rwBh0O33rD5DD5b/lXUMY9/6Ian4Jsl3dj8wqDLXRS3GrCjJ0VBhetvbC+tSlz3EkpYSRIhUFu1MnNbC2BPzddWFVedRbd6xFB7Lvx44022t/hnvEaQ2diynSQbeXgJD8NIBLwBsg/Jqrs4EQ70=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4375:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;20:f1tnJd4/gLcKClequol7AzI2HmUlCNfJzFNJ8l4h0P3y/2UOqsIhEbcu+D3rqB+uSY4f/qyInLMeODZv/aqx/wrVd46B14RxNv5u52dLMMpXkBcV7F1/vIN/ciCK+agDuAqns2ci8sFqeGaTVo27Tg5dXrJA/UrLFTQMLB0s7qWmUNkVUDGL6YMETKVwAYkkQ6qvpckxe5572AZJLmt24cCBVWQI39aSpfOlBoIx8KrX0tknPutyGDx28qfCKmoiTYvvPHtJS4n4T+ZcbbBWUhem8iWFSaC6v29B3xtgXdGbQgK6b3rE8Sz2UfSvpL4I6sPcf2A1+jMk1Y2V8RqFvXRErngBMXCcxa3amCSYH+xi0/qpKaNWG+DSNiHEhZX9jQtdw50PukDrBdi8fjLiPYe4CV4M12PY4cYQYa5x15nyDE41i06hvxF9RlVSJoW2M8/tueWxFhV8KBRI0L5kjwBt6Jin4jdS1H9W3Goj21itSbYKsCabm34iGI2NZra8dyY4Q+V4B9AcEHRLYOhElWJOf7ZLHK2gqA17mGcCggAZiDiJQW6NdChxSxgy7JyAQLT3Rhl6/LqNEA4Tzwelp5feEkJ+Sr2DUxCr66TCXeg=;4:y/egJ7sGJt3UvjDNopocIUzDqWUEsyFmKyD+LLtF0GmyDHkSDpKimUtGTyw6DeAMiR0rkQBDvnBpX3sDfrE9ICXosPnsmOrE+zPMbjKMHJtkJsrfRemq/JazQ3yEI+Im+c2v/sNQ93yR35Q+O2JQmC7MdoGTCkuNB1YasK1rpoU4xzc7c808A2Imc5oBV5ypr/JPMsqiov9XyzvO+gKK1GMiQJEoanXh9F4jNHkrD5Vm1fz0dxSZSSc2hFqxDNXp2btkUkypGRxG470qk+UbP16v1L90WPCv6yLHPwSduqWDhhxTEMsq9ahMwPXaUze5
X-Microsoft-Antispam-PRVS: <BYAPR07MB4375A32D46351DC1FF87C6A9E3930@BYAPR07MB4375.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BYAPR07MB4375;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4375;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(396003)(376002)(346002)(39850400004)(39380400002)(189003)(199004)(6496006)(51416003)(2906002)(11346002)(446003)(52116002)(39060400002)(16586007)(47776003)(6666003)(42882007)(478600001)(25786009)(76176011)(97736004)(59450400001)(6486002)(53936002)(316002)(110136005)(50466002)(4326008)(48376002)(54906003)(66066001)(6116002)(3846002)(7406005)(7416002)(5660300001)(72206003)(8936002)(50226002)(81166006)(81156014)(8676002)(76506005)(7736002)(305945005)(26005)(486006)(186003)(105586002)(1076002)(106356001)(36756003)(16526019)(956004)(2616005)(476003)(68736007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4375;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4375;23:l1TtueW9PhQCkd9+d28Tkh4M3jJaxUAjmFbrj8ktV?=
 =?us-ascii?Q?DjgAhqjr880ogSdfmOqLm3VJEgAg1ybT1EvKYd7H5K9QfeO/P8lgQknpxbQL?=
 =?us-ascii?Q?23Vgg7PV00/3UfvEzTUmP0k4Cn6Qwuqm1xwpRv/9hS9cQmBptoCTvX1g/yZF?=
 =?us-ascii?Q?8cN6KtOBwZ33w1jVkiQbxfgk5m99mZ3N1VOJbiKipbivYhHKoRTDtdbEsW+K?=
 =?us-ascii?Q?9EOiNtI2KlmCP2h3VL6mRqF9wY2JTvQaP6ElMNCAHCqZgJd6hzqd3PspASqB?=
 =?us-ascii?Q?2NjoaN95HOwpDd3X1TcoZi1NDJHQ374mCbEfkaNQ6KvdAQunt5CpW0xS8H+e?=
 =?us-ascii?Q?I0HEGHQTcCw0CyKZPYgkYtRif37tPS36as1BNMJN8GEjHY8MRtqee6SagxjG?=
 =?us-ascii?Q?YDtoob2takRmf0GhJDlBVUd8vQdsz4MVF2vdzbX3z4I3ODCrMHk+eipIzzZK?=
 =?us-ascii?Q?Xx8ISO88K7aWJF8SXoOQyk9mgwxQIZDclkVlnVW+qPWJtuYlhxRpitACULGQ?=
 =?us-ascii?Q?/EYzzw2XeryAwe7hXtN2ckeGlc4QyB1G2jmXIHuq66wxM5dRVr6cPriEe4sd?=
 =?us-ascii?Q?wEln+qzTdgn2PDzEKd7S/GyAu41hVLOKodsczfEWZWV/tuAb0Ae0C2Z6Hg+C?=
 =?us-ascii?Q?DD5CuKw6LdwJl4PeOtnU6V+JG1+iXV3xKd7ft2y3Axzotbcb9Syp7Kj/QFpI?=
 =?us-ascii?Q?Vwa+qQao4oGtruQr2GcAudRlw7CICfy3COHoOPtF61zdgxHwksMSm+LHs+V9?=
 =?us-ascii?Q?nlwuio3FBfnRgCKVkx2crXfjyW5OB+X4luLSzDQrQ8klIjOoD4SQwUxEQgiI?=
 =?us-ascii?Q?dtxKVaOyC1gBYsU0eVC74KdRvWlvXF2RDIIFSEJIIgGmmuUxU5Wdm3woXvzC?=
 =?us-ascii?Q?hFMBwgC+MLuzeDa8Xbk6R5OkQ5xnAiU3kboKGQWh7L8O1dD1MmOZ3v0nGMjR?=
 =?us-ascii?Q?Sj1gUXMi2xAPf72Tjv8pK5PXN4o/xP22dTGbo+GJjgEQMSHWZrKMCBo77mFR?=
 =?us-ascii?Q?UbD46pA55DuPT21q2aS/FZ8BvTte+w2ITgrzUpqxuSJ+yAIX5NLwk/w7ydFL?=
 =?us-ascii?Q?QsXXQMwTGaRFKZ9AP1OoF5lUo+HRqnEBVeFRampc0PDnt/rdHCT1O3LvU/WI?=
 =?us-ascii?Q?MGmyXXkefxWEUirNdf3gv41u96T2tlZQWrUUyjZf7qfFLF55waGXhk7DnRQb?=
 =?us-ascii?Q?fc7ZCZNrYUQuZ72HLyALN8UQZQiLrOU1Vdn2ftui/xrALq0EgpJKWzCrV50A?=
 =?us-ascii?Q?YImP6Ct9UDir/W2sGm1hlkVOke6WGKalzfmOeym/Ki3odvPRodXaDfqBi77L?=
 =?us-ascii?Q?Qq/e1uLyaowH2JnICzEuyfkZjwzwBYucF2+HR60iEq1DioD079hCruDwwMXA?=
 =?us-ascii?Q?50Kyg=3D=3D?=
X-Microsoft-Antispam-Message-Info: +BBj0Wq4Mot1PS3fqeODqqRZwG7rfdss4YAzYvWtUm12pac0+vJaeIuRu0aIuPlfBf6OOAO37+odBdsOcuO0b4j3ZpKSrFMwQzgOv59j+vJgFTZuLyhowmBLBB7WKD9ePFR3JjcRU+0LOuizhr6beHlhnKGVJyTDA5Qh7iRoZvUZ5Giyo7s+BmTZ0tlSOb5m
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;6:lXO+QeTI/FHx8NJwq/7v89avC6DnRB0iW9hkrHnHMnU/uIxJHTn+UFHjH3ap2gNYWQFyR6QCcpbnWSWXi3ig7DLAz2DnKFcTzre0x9tskJFi7WzEZB7yuA5GLXbd29/5NdqjCMBNBplSqgGiGCqX7u9wxD1kG1n9lgmCEPld+HMBezDDh6/+kqcPrSs497YXn4yqviW1p+GsDHWJWXve7Egezr6jEbfRaOCADBMKAJ95RbmyZANtsxP6AJhtUNMUShCEAdXvVytvnpouRD8COmJdg9ZH3rm40rhbtxi/1bdbJmSb0zw50r4f4JyEJkYPXHCzEUA7hiLx3wmJRNGEKrO7QS8/BwjMJvCC0LaIyr45uC3XsoFgsag2G/qgk6kKwuLdi2FYzQo8x4kTz9ifqnBy8VKDmUnfHWPP+LFbrvpkj2KHFK14iKWtLlZUH/sFu6DHsK7eS1fwAUw/bKMycw==;5:+clHEKoUwouKyzjbtVjEcW7t+8nebafB77GN5BRT4hBIE8hOoNMIb8bQp+uNxlLhtVqLVXM3uHB+1sXxPEp15kGi1gUOTfhIBBUWCTXbeIirWjgywNsXcmEAq5ctcoKZo+WheyRxee+ZM5QS0CjFfufefRkqDHmHTIHuMLZjJ+s=;24:QGIsmCuayZBSSxLZL33yccAt1/BXFqfOj/uT8EpRpG7OQ9OXXysUhWbrBWtnrjoW6Nap/5tG7Eu96lGwd6iyrKFl9/5BeqzZ2s0SyarpN4Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;7:nI5pDkPn64uVmr5JTzUPF/PtxaSlzR92Q7V3jN5UP8ggz4MtaeBmIUCz+06O8VLyC22z+P0e+fMaQdEPjAE1sl7XzXAYxsZpiSm21yl3qYKtf6DZMjb/t+oBUn3cNjZTWzOBzXj7YNdsgg0DINbjV2uU9vl83CqGLssuV1Nh3EVn7p5RzZRF721LfeR9p9dEauJ7zn2prswR1ya7aaifECnmbCTfP3Gg25yPK+pdQ6NlKUgZ2lHbDsFO1uabcHPw
X-MS-Office365-Filtering-Correlation-Id: fc9d9b81-cfda-4b9f-4d79-08d5ba97d74d
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 19:12:44.5444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9d9b81-cfda-4b9f-4d79-08d5ba97d74d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4375
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

