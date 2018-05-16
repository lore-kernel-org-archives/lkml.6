Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4128544-1526459228-2-16602835679337700965
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
    1526459228; b=a6Ru7+JJKv3Ku/o/mjsbJs5AkxFAN06O6l61ZFLvYPDOtTYRpc
    2sd0kisidBF40JNgUV2nKuf4ZBJQePTwk97HFi5Dnx/ymdIobNdhGJhGY1uMk5gm
    ZF3c2JEelVEoP/55KmGGirTCkacPQbK8o8gSoijG7ny6qMkx863a9e73goMjj/sw
    Lv+9yG3vuROhVHbxUyyHyAhXJAqu9AuNy74mCCEikeHqH4/f8ZJh2XiXqgdsab17
    oM6c6nz5Q0ecKuaKVU0R/U6xsIgUgcLlLvQCh/Dc16SbdxQSAPuo005SEEuwdTZf
    Qxx9LIi9VtFxPYW0eZC2u6ZkUwh3ecMFGWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459228; bh=i99POi2sSS3I4n2QS3FUIgtVVLfgZC
    6oniKbq+PlIuU=; b=VuZxDtTBHZPVpBJ0Hkk8d+VgoxrD/PCsp5WQLevUw/0xcX
    H1wS8aH3lvBZUq9fHqzspN6IykvLQAjoWx+UZNA/dOOuK1PNEDOQNLQy8WUrNk2S
    eGolF0n80xXn5I9xQF+1SzOuZ6McVXNj6fg+4ASnyroVpq1CDqGBfVxaMcA6yUCT
    gibTDrmhUGywMgcqRbxGIa1DyNeTDxJbu1WYah7GmSjlHqZW/sEWkaKsp91X270H
    Pf2i00rJpwwOgRThnDuXaYM0XSuxA26bepewKIUWoZoJ/zxCNjWk9SnFnOf1s+UZ
    +8pksMBYn6KtDt/ONuDCAIaFE4uYFTItVgc0KPQA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=XMempxwx x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=XMempxwx x-bits=1024
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
X-CM-Envelope: MS4wfGwNgiIYH0oNFhLuJ4MAFNJ9Oz5u2WhTk3uNhld3ix8F1/pEgmVHOweGWX357qbkA2kDAeNaDezK0PCOPRkGXXy/y7iGe+rjFCJiSGw10P6eylVzEy1b
    spICxoDlBbngY76JQd53fTZhgJvQBvJo66NFxAqohIZ3wqh2C7n97iIJuYF8HtrDzKqoUCpaP3jor6XQh7PtNe10bxWmHURVhqAHsY3+fbqUqxlZF27Ul1HU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=156W7YIXQOAA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=x7qQHykRX3tplOikWIYA:9 a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753009AbeEPIW0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:22:26 -0400
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:8874
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752877AbeEPIWT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:22:19 -0400
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
Subject: [PATCH 15/24] arm64: ilp32: introduce binfmt_ilp32.c
Date: Wed, 16 May 2018 11:19:00 +0300
Message-Id: <20180516081910.10067-16-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0125.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::27) To SN6PR07MB4384.namprd07.prod.outlook.com
 (2603:10b6:805:58::15)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4384;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;3:tExdOi5LtHSDJhg73zRqFbO2X3NgBwhFMcD1UVfxyN4TJtPGe/ZJHOutN+S0Dk945zPyaur+Z0tOserRJi4Yej9kxl0L6IXWa84I/hkMKMjypKTfdIzlGcljWc5pskh7wXMHXQp/+hhJMKLCqzhupxNbB4K5pfst4Nma1fN6s8py7MT4Dr0nugg1Fyx7mZ1AIp2N6dbf7Ttm9uhb0IYhj7IVX1ECXLYLaDYeva49THaPUfqBBcSm3uayWGYvod5D;25:/hT2/YV7q8IEnJE8fB/5YXJShTN95IoqeZSMibuHRAg36QJE8kAMhqhmxgzVPymhSmts1R+jo60HGRlg3v7VcPHGawUnaI0UJZu6yoBAZHympVo/h9SyJqsOq7ovcyWocZ4hbEBRwaIU8ZF8LQpdcv3JWfkrfBwxWcgAZQ5PhWyufq0AsqqjNBHvz4y9FCSiQLPIZl7dUsuneK5dOsQ8VzAlJHaaf5YR00bpppCuFfSHl3rxVThh8XSnn1rgphr9XZa3pdmC3XSjxBr24kuSkK29q/Lzb6loLaQlx/tRJ0GHYI+3NR0QuVVwfi/bNoi/LhsNOXzWckAABCDjNhoxug==;31:LfFe//RUAmnYb81MKDge27hdBe+vOU1EzECZ9r27DwqtpnT4A7bgRazZaAtP7DU7Uufazkv5eI8+wWJfuD0lrNo8NaVELmgaRZ1NnZEgdpiastopPniNXkT+psUOg/rEINuJP3sgfgXBRoXfvPpzgNSnX74O1MRcTlwG4j2JOnfoHtAHDDnO4TAPKmB5R52F/BUlOZdTx7IRkZ3lS8rpLBQuMwV7UCyjPSV4Li3EWfM=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4384:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;20:qwstfG1TKktntLT2wMNnc3EqDeDpFxNTw4RuhknZlRWkSEHSjwO0Bcj9ZRlBeweMs/qrqD8TQJBZrb+eY6x9PGegCuDK8UoEh11ig46ctG9JVvz63VVHdPnkvzGvow8VPhmpcYudnRUbm/CIauUCDkKs+LhzeSc7BbaV2ht0L11g4QDj0ZFLbN6E927OF+3+7ls4PxRXfFi7MuwdEFTRcR8YByKTGGi716JjyZ1g75KL8wDp9LAuGtFFiGwDD3Rt2AzbhHl1cRKkrSsX8S+xPA1qTlt3MGYo5pK7zWSb6sTz2DPh9J0o/5z+aTfoplfCr25sGjLyPHxCZMUPdNlv/TKlG7MYQB7VUXkJXYJXMkrZ6L0xMHCabrZu4L2/Ut3vL9bxGPzGwl80zKoMEdWUdcJC3X39GNsN6G92iHHPjUQtmRxmP6AbjvTrsSz7GGjSDQTE6V8SOxjD9/YROU4tiVUNLIKKI4kYbMdyz8MRCyORvgiG9F3PG7ezd5Ndx5fwqgVm1ke380L818uxC/LTrdlU1+YVBabfrZFqchosXu465KihDqPKVFXB/CXvJVMbcNPCZYpBN0j6g+IHAu4dPityLrlAx3Co4h2OUecK8gs=;4:Vv32BqL1bAFvN0fr2cqxedTz7A1h4YI+QBIyqEUZaIgGtNYXaEg2yu9treJtJF5GEby12B+sAOq6NFo43oLH/kM7/2xDsqNAxr4JNcqJQ0bMGNShwySIHccek3pBZ7F3SAObEe9zSnryUt8nd2lExsxZwH+SqYCJD5KQGD+478aP7ABLDgxXBzHNpFvFrO4fI0Whpq+mMiLx3cX/TVCPlwh/MyB9kOaetZpLwI+lKVGFEDkA68bATHRyEHw++20I6jXDZyufI+RQh+LWFQdzMnyXhaHWERMvMqBXgCUQ5qmh8CDbkPJnqVaY6R8kzjbE
X-Microsoft-Antispam-PRVS: <SN6PR07MB4384186B9DF7C814282D3227E3920@SN6PR07MB4384.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4384;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4384;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(39380400002)(366004)(396003)(39860400002)(199004)(189003)(478600001)(26005)(53936002)(47776003)(386003)(446003)(16586007)(42882007)(316002)(11346002)(54906003)(110136005)(956004)(39060400002)(2616005)(1076002)(97736004)(72206003)(16526019)(186003)(4326008)(5660300001)(8936002)(81166006)(81156014)(76506005)(6116002)(48376002)(8676002)(106356001)(50466002)(3846002)(50226002)(68736007)(476003)(305945005)(7736002)(105586002)(2906002)(6496006)(76176011)(7416002)(52116002)(51416003)(36756003)(7406005)(25786009)(6666003)(66066001)(6486002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4384;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4384;23:cIqlY6ZdMisA0ea6xGkdWRFDrUUVatQGbYquQdfjD?=
 =?us-ascii?Q?DOXxHGukHUUiKu89EJWyPCLZ7eNm0RT7UsSxEvg0Kz3MxNH63wRKPOqU3iPl?=
 =?us-ascii?Q?JAMQFRTd2oKYZ7tHQC+H9zkkChb9eDaUApoGX1mSKoeag6jZvFNip2dyVyT/?=
 =?us-ascii?Q?DALWZCOhK7yOhk5OPAOtzkFUkKiQ4YgPG46DSNLmU2NUzlBmjxB3vhFPlEWB?=
 =?us-ascii?Q?FwusMZDNVgduzauUGsL8FolCzsxbFhN8QEq1hlGg08nDDVn88y8d498tyO4L?=
 =?us-ascii?Q?nng+lfbJk2QlluJZXoVwNSQqTGRXUYcu69VlQL9SwRLYNd3UsIhuGpXJhncO?=
 =?us-ascii?Q?q2B9iDxmk33ccCd8v4Pdrhg5CLl6nmbPar/UnuE+685N/s+Pg/HeV3JuS47I?=
 =?us-ascii?Q?cnkcfrzky5kJJLcGwbx4IT96/3z/zee04GJcqSbBlFCZ8UQeRvjgQDvGadGP?=
 =?us-ascii?Q?QAgpiwPErOfzXvDsMDZ5FUemvvkPKAlC+GPi0I+03f5+fq1SkWWpsuAvw3Y7?=
 =?us-ascii?Q?vSbKt3DqF0yBy538Zz5O/ZiDDCZySmNI8LvX00OB4P1krYVcuKtZc326wGvv?=
 =?us-ascii?Q?oOuW6he3Hb85bWIxJ4M08StDknLN0Snnfo9JjY42425OB1vlyS3DlSJmErhe?=
 =?us-ascii?Q?gCapj/o3CX7zkbbEatxZ4qVlDc4syUiZKzxhvqTkSjbQz1NKe1BwAlE7j2wi?=
 =?us-ascii?Q?KZ2nEhrVg3SgStxzP14lA4EWnZtfRpKIyG/FAWxNVSHWBgwiuDefEiDwKeGH?=
 =?us-ascii?Q?+ITTLyseBE5bwdCeuQnjA+l8dnOF0PmGMjGbS1bqdCo8MaCbYWnjRFAeRJ7M?=
 =?us-ascii?Q?gkKIos7L+8MCFIiHxgHAy1wSlPS3p0DAHOSHJPWeMQLm1b7uHLnzwAradbDh?=
 =?us-ascii?Q?mKtV55vbjqN9UubMYpUo7vqfQo4ssebiQxvDsio2J5x4vVetT5xp58r4cM0h?=
 =?us-ascii?Q?m86k7jLKVs//A97axHTc3MQUqkMZR5EjBvhxyfA13uKDaIp0udmUylCpeaIy?=
 =?us-ascii?Q?Aj/vgTciYa3WxI2H6wIyNC/WowTVQG2LOTIP49pGFb9BkYtMREj0SjRme91w?=
 =?us-ascii?Q?ou4EwczXt35wgOoCFNxY2DJUkA1YHytKgN9URNNAHXc/Go2fvJ+jzM/QcV2W?=
 =?us-ascii?Q?Mh5bvOex1N3Ir5/egtGzONra1VG+0Tv2m35ZldbzXnfVXUuTHALKcXt0Nr6N?=
 =?us-ascii?Q?UizOpuezk4zn6/5qyrjd/8mMJUFVJsJPRU0cxE9nQFWH63/ZTcCWB2zqJl8Z?=
 =?us-ascii?Q?SE8VRZRqZYd+uTTsZMxXL5KecL11ETJGkJqSb082fo3uzfPPcTa0/4QH5jYp?=
 =?us-ascii?Q?NiIDpl6WLkGPuQc+PtPjUlsVEdEihp4y3yytsfMy6US?=
X-Microsoft-Antispam-Message-Info: Pyq4U+Irt2xmbgjPfbF32EOBYwB3FFYsrdEPqeYTDIMJXxuTPflZQrlRuCGgvxQ0yUx8HwedZEgy17rz+7h91jjlF0J1ay5c9EK8LAiLD6J4PUQQJ/QKymj3pvpOpVmomxYvdnEVmEROf66+zU9q5oJb4YgCY6GtGg0XCIVDHXtiOffs+Xro/bdP8ELlp1KA
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;6:BitvphIqixQbpVmXgjmY3W2H3YW8Hv6BpQHX54MUj9D1EJnZuTTmspuQ2ZFzXzdIlakNZBZjH28bkP4LIv1sffzrBrGiEeW0rJzfG++8DVMgQvjtiwnw5leBC82jnejQR9BAmPvgs8XWx2yjfmPwZ2kslLllXw4KMM0ykkDSj4KjzmzQCcx8B/b+CLf7kpsZjNH44rCRZvekxAEISHPP7OZt5bn8jUXxE9GwpKBmFaR9ePXY5Qk/JLcmz9Z/V+dD1e6WPrDBA5GGjWVLG4IOJ88Q4rmW3iXlYXFK3dhUKrzy3j2ZyNNi7tfLe3DmEDNEWP+UXtbbQ0mAoU4Gzm4KESSia5LhnEZCZZ6KQhc7sC7r7RuOD7wSiYs2xZfNvwsV09+sWt1OcdUcIEX50CaQ/P637QgPXqFsoPlZsvNHgVnWijklE4fqmOJMaCGnzi5Npdw+RoryzgBKfTMKPOl1Vg==;5:debVWsM1y28afe9JFoeHZz3BW6ONxDyHVhCXJXUoC2D5NwRU1Jl8ywe1sa57iKEpL+kX53dUGoX0r/zOwyzc+lKn3c3EBWY8qbKqMjwqUjS3FGREH888HB6GWN22r9HNtoelYosBcYkXBIhcfFCDh4cbvYFnCVGs1JVpdD3pOSk=;24:sfMellO6ZeaHDarVtVihRF360fLOZ6U1pySXVREaw7BbHRy9yBCeUss22ZQhhXiU6yvu19+URtHsA6bNZmMD59U3frtcEk245dE7vJhiC18=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;7:9AKULjwZD/IsBg/kJJ7m+jqOTnFfL1iTn9eDyp3jKXmxO7iCU5seX4u9dTPGmLUZVRMxdWFZodS70LESMf6oqEjgB7VtzMT7JLZa3rws2FMpIwKxO8ACyWapiN57zPJDRPqnw+8GU7RxrD5N2QF6mBZ9DGzdN4AuO+C6kjGp68I/nfkTzSMATW49N4sgEq7jAkPk3THJHgECTuvPy0AQ2XhVVpCg7kBsyxgQ6DKqn3Ow0R4wvfKpeVftAe2If/p2
X-MS-Office365-Filtering-Correlation-Id: 537bdfc0-4d83-417a-485b-08d5bb062217
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:22:15.1754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537bdfc0-4d83-417a-485b-08d5bb062217
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4384
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Like binfmt_elf32.c for AARCH32, binfmt_ilp32.c is needed to handle
ILP32 binaries.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Bamvor Jian Zhang <bamv2005@gmail.com>
---
 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/binfmt_ilp32.c | 87 ++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 arch/arm64/kernel/binfmt_ilp32.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index c63e0164fc12..3114191750ae 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,6 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o binfmt_elf32.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
new file mode 100644
index 000000000000..26b2477d190d
--- /dev/null
+++ b/arch/arm64/kernel/binfmt_ilp32.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Support for ILP32 Linux/aarch64 ELF binaries.
+ */
+#undef CONFIG_AARCH32_EL0
+#define compat_elf_gregset_t	elf_gregset_t
+
+#include <linux/elfcore-compat.h>
+#include <linux/time.h>
+
+#undef	ELF_CLASS
+#define ELF_CLASS	ELFCLASS32
+
+#undef	elfhdr
+#undef	elf_phdr
+#undef	elf_shdr
+#undef	elf_note
+#undef	elf_addr_t
+#define elfhdr		elf32_hdr
+#define elf_phdr	elf32_phdr
+#define elf_shdr	elf32_shdr
+#define elf_note	elf32_note
+#define elf_addr_t	Elf32_Addr
+
+/*
+ * Some data types as stored in coredump.
+ */
+#define user_long_t		compat_long_t
+#define user_siginfo_t		compat_siginfo_t
+#define copy_siginfo_to_user	copy_siginfo_to_user32
+
+/*
+ * The machine-dependent core note format types are defined in elfcore-compat.h,
+ * which requires asm/elf.h to define compat_elf_gregset_t et al.
+ */
+#define elf_prstatus	compat_elf_prstatus
+#define elf_prpsinfo	compat_elf_prpsinfo
+
+/* AARCH64 ILP32 EABI. */
+#undef elf_check_arch
+#define elf_check_arch(x)		(((x)->e_machine == EM_AARCH64)	\
+					&& (x)->e_ident[EI_CLASS] == ELFCLASS32)
+
+#undef SET_PERSONALITY
+#define SET_PERSONALITY(ex)						\
+do {									\
+	set_bit(TIF_32BIT, &current->mm->context.flags);	\
+	set_thread_flag(TIF_32BIT_AARCH64);				\
+	clear_thread_flag(TIF_32BIT);					\
+} while (0)
+
+#undef ARCH_DLINFO
+#define ARCH_DLINFO							\
+do {									\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+		    (elf_addr_t)(long)current->mm->context.vdso);	\
+} while (0)
+
+#undef ELF_PLATFORM
+#ifdef __AARCH64EB__
+#define ELF_PLATFORM		("aarch64_be:ilp32")
+#else
+#define ELF_PLATFORM		("aarch64:ilp32")
+#endif
+
+#undef ELF_ET_DYN_BASE
+#define ELF_ET_DYN_BASE COMPAT_ELF_ET_DYN_BASE
+
+#undef ELF_HWCAP
+#undef ELF_HWCAP2
+#define ELF_HWCAP			((u32) elf_hwcap)
+#define ELF_HWCAP2			((u32) (elf_hwcap >> 32))
+
+/*
+ * Rename a few of the symbols that binfmt_elf.c will define.
+ * These are all local so the names don't really matter, but it
+ * might make some debugging less confusing not to duplicate them.
+ */
+#define elf_format		compat_elf_format
+#define init_elf_binfmt		init_compat_elf_binfmt
+#define exit_elf_binfmt		exit_compat_elf_binfmt
+
+#undef ns_to_timeval
+#define ns_to_timeval ns_to_compat_timeval
+
+#include "../../../fs/binfmt_elf.c"
-- 
2.17.0

