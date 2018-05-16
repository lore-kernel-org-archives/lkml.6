Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526459250-2-2804464942714529219
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
    1526459249; b=Ve/le4hQz0yNf34TFJGDv3+fwnLgONKVPu05TxHgdZS1MNxhXW
    3Ukm6y+zetR+m7aPvZVoq+pdzEjs78k00/nFwTEFleIR2iB7H0SOBfVjrfR1LRwY
    Ux2itjod49TOxVisoZVPh4G4Pg72+N8Bmvd5UR596Er7+UYaeOJcHqJoXNOjnuzx
    fdeTb9X+IhIPAO6tNF23aVCgZDF8b/564gnoZFqvsZeRQhozH6DUfo2UiUHAYez6
    ta77PkkJWZ+4KhRGFTCDsmvvJ/0BHeOJSC1s9eCohZcCbhyECzuEV2umaQ5DrV+7
    icXYjLTcf8yJAhZ900o+DDekVG1/DIRlqx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459249; bh=jaRw0U3Z64cJpNRQtHu202/9UhzNaB
    lUJMhRevIrYsE=; b=S1RzBH0mzF7p4EWDtGdA5RM4uZ1OxFLm1oGIiAiGw6qabv
    etZFISUjGAnVVngjJKQUQzDJWgNn7PSCwPObUcOjs4NzrTg7INOwcLz8Yfgfhn8n
    CrjK5y3aDSz2LHwCGj0nZG0+qJVF1JGIJOlPam1WaKQXqRaCNnCyaaJHmjm4eKQd
    JGly+/+sYm/Phe0MjC/fk2K8dwutbt2m2I9oDjDFZS/FHKA4j04cyXm81cVsFs3v
    K8or959rJoYLfp65zfIYnq0XbyxbPhB8ZoJFJ43UO9jc7HuPiFmfnMknNpJRNPZF
    tTOnbns7OC/3NBfdWMUz/bksecGEJ7i6BhLFPwQw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=MermSLEp x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=MermSLEp x-bits=1024
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
X-CM-Envelope: MS4wfOS7YCXfoxHJckOjVgcUsRLAJkP6+ipBhC7KIjFaSEQFAw1MNQopVRUsCDC6OZbC3ye7QNFQFj0twEDXE5iWpnK2Vq1QJG2rZy2JHKBEFoUReC/BkpkG
    0ZRqv65nt/5kyYCm908p4jadhMtQxpPOvca2fNxKNZFOsbvCQhxmk3eYIKpsKFMxy6xTuYabgasxednUbv9hIwi0BcNi9YSL2FRCnkuoUtBXS6zJTpgkm3RR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=8hbM-sQLF_oA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
    a=UB-HM8XSoCIi8QqMbNUA:9 a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbeEPI1G (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:27:06 -0400
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:2806
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752734AbeEPIW0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:22:26 -0400
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
Subject: [PATCH 16/24] arm64: ilp32: share aarch32 syscall handlers
Date: Wed, 16 May 2018 11:19:01 +0300
Message-Id: <20180516081910.10067-17-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0122.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::24) To SN6PR07MB4384.namprd07.prod.outlook.com
 (2603:10b6:805:58::15)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4384;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;3:yybPkNwI2boKwxXQRXjeJavru9fkYDsIE3nRQiBMtnJPjzxOfOSOnIAKy509peY+amcnEqqGQRsZVQR4cHASbS7sajaCDd7QRUyWr93dmXqZrJO5do+Y5wcRI9cZG7BuCuSSdWxRYpqWNW8gOnPHT9HMBWOyTj4NzG3j0+NNMA3zhRodOeq/88N74QghaX+kncMlIcIXk2J4Fb2BkB8y1wtYjBRULcRhmuPDP0CWaeBVzWZ0xSijaC11AN7UdIXD;25:2xifa+2YsE+o5IoIuIn3yzGghEHt+AtGavIH/Yb3lB5Ind2KQl4Xo+hMTDVs/lhGSHgkLcmWORTLtLtOIl0mvKBO7peLo0b+RM8fV6D+hxfOeSL/24kk4Fsa3wOz0KIf3xL6zdQeS/PqE4D/sNv0LQvMlqvIFOVAE1tTSMfmoaRGCF10GIm6COksJaJ+kbLolVbJZLgm2y9KsnJM57baxcDhT9MBQc6Q9xbvmDjQ6+e4UiNLZFx47R1dklEJtF987kgV0b+JAKn9P+E1YD1v0AlxbK7DZOz7reHBZj7xkhB2C1zVvXab2XqbEXINkCllo8erR0YhwDIJJS4LZdoiyg==;31:tcDxjN0blGHWXNN6qr/0p+4BX5dMG8kLpRghApylf3T0xl68cyscfU0JSBfRxxdkJ84tnD1RMuCDHCeBEE+qliicpS2z9vaZ/8pNIconXH5TLX+GbmRdQQwW+t34PD1GysKCm07XP1v7qZU6ROedQffnFp2jv8ZAh8n9MV7VdCTydaMefmFsOPXd+Dcb/52OgdRdOQZniatjiDMK0swqw9kWP1FTG1c/c7HNU5XCcME=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4384:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;20:44a9t7Cz5jvy0DPagJcT190Ll4h2SXtLH8sH0PqROcP8FeKFSqwdyxd6xgzH8h1VObon4VPV9SsmxIsHX1azIqy+3xYbiW77rZ6bWwvHpw4KP1KcgS56Ks0hwiNvOC8Bc1/YXB1p3SgI+0uxN9wL3VZdh6gqUIgYyqu5OHPVnJBdiKu5ygRUtErj6D2AuG0KffmGkMiVcq3sPjrOe4lZUrx4oHg94raTtaPwD91ACxyQ/yjasoARstIvdWZxQ13XrQi49TdpU1J5d8fcXCbJrsCU0UVxs171k3W+9r1THICsq+Itwtrn2qeGFAPb5AIrEllkOCmN2TkuCwbK9pxG+1bhBGiOfjXO44ImjBMmKILz+6tGPcZ9Y/49M5tT6R4G/kMKNhPy+WChcVlcHGquyYb3pKK7HQU9DktaEeg7hwwnWgJR01OPflEq7JeB8O9eGnBaES/hmXfO2bvGlbiZg+folAi52X9kbe4OgX1LB/RTm+4dxNSSF7sIQPeqKnifasGJDN4jxThkOSr123c/b/DK4gFUti8JWVUzNm+5J2M2PpVvDWmLoSBfejwzoDvmQsufANAavJu4FPQ1/xP/dd4QLsjv4W2c3CZAZSB8m7E=;4:4BEk2dIr10SxNKu5doP+d8CBVgYoXpovyJBWkoY13eb+swyw2fS/+DkaCRq+44o+dkbjZcnWccjSIKifPOkUt9deM8H+JE84jyx5coJLE5Fmx04+an/vKXKcEn4edl000SgJ/qWNhyzCpUjG6s3ern086gKG0pcqEEYgT88RcqQV6dMu8rHpYYYShJQDRMUNvKUTt8iDL912uhTzvwlykJlq6YV2lcMLye9g6yWtwTm/3xaQj831B4AD67ndBEZeOxJkyKusatr96wHxYfhiK7LzFGoi8xIGEWTZkANuw5+6Wkb+ZBnawPaW+vWCxlxp
X-Microsoft-Antispam-PRVS: <SN6PR07MB4384598E56986C2EBFFA567AE3920@SN6PR07MB4384.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4384;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4384;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(376002)(346002)(39380400002)(366004)(396003)(39860400002)(199004)(189003)(478600001)(26005)(53936002)(47776003)(386003)(446003)(16586007)(42882007)(316002)(11346002)(54906003)(110136005)(956004)(39060400002)(2616005)(1076002)(97736004)(72206003)(16526019)(186003)(4326008)(5660300001)(8936002)(81166006)(81156014)(76506005)(6116002)(48376002)(8676002)(106356001)(50466002)(3846002)(50226002)(68736007)(476003)(305945005)(7736002)(105586002)(2906002)(6496006)(76176011)(7416002)(52116002)(51416003)(36756003)(7406005)(25786009)(6666003)(66066001)(6486002)(486006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4384;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4384;23:Yw+vQi4V35QvzRj5wRNdmPuuz5+MatWbmU0tX1wt7?=
 =?us-ascii?Q?iS7B1bgcRgvj8vY3/yWu0YyKIu4nskxznqeis9rzEqL1TkprODL+XWSvj62s?=
 =?us-ascii?Q?KZNfByoIH0O73XPDcmEzxl8B5QZwf1+89ed4fxIsqE0bZRaqhtOtn54aqyyA?=
 =?us-ascii?Q?B34ZoHkzQJ6e8wqKW8UKBXSM6rClEyPF93OqEwnCSejIeBPgcetT0GIG6cBH?=
 =?us-ascii?Q?0y40M+eX4z0D3i2ysFYRCiFRLB3iFlVUzs2BbwCCII2kfyR8PfacyyNYkqdP?=
 =?us-ascii?Q?NOBslpPYYtvH2JlG1i7pslvzKiclQUrzURf18bjfr3ESdJhRYMU/mBNBsLtX?=
 =?us-ascii?Q?evjPColyj4Pn0A9vdlYQqfwcR5pfqBebL3ESHreLsixi/O0mnqb5WmHn54EU?=
 =?us-ascii?Q?7rVc1WynKnig5w5EW+56keNO4lkvJeyoNnPnLQJUtPZDkmBDMMFkfSIXIR3+?=
 =?us-ascii?Q?VmF/4NrYXA15aWbGyAaFbEsQOi3Z3dw15wUidV5w0esKO8Qgjqvd0sYOZsjd?=
 =?us-ascii?Q?lOnRtAAVXn1ESp8BLhxIyaIIaB+c5szwIjbRDU01OCBaAVoggVRcSUtLCZkH?=
 =?us-ascii?Q?aC/Ye9/l2z8k2vzQAU8j+G7dTfvGr/gYNdZB922YlE2qBD0Upow66igAL1jT?=
 =?us-ascii?Q?X6YYwMT7WYOSwzsjKNB9EE8yJCqR0psn0sn/L/TtZGuHn6vwzTI764kjAxfX?=
 =?us-ascii?Q?u/0N+xd6g6c5QPOpEWWo4oBjUN6i2DRfg76c4iMibPHAE4diGvu1tRHoIxeK?=
 =?us-ascii?Q?551ZPjr19HXeTZ/p0PAMgddi9ybjlYYzxkojqQRG35zfxpLvGxwHlCj/L0lj?=
 =?us-ascii?Q?ZjK+PgLXMEtZ352qFvBCL4HUtH97WAxJUbcM71hcu+5MNdtQRAfCdlxZCBBZ?=
 =?us-ascii?Q?k1EpJWqV42lRXZJ4iBmT/3oHkHHbPIMWMJ9LzEpTANFIwz2ACXmIh0/ODtDx?=
 =?us-ascii?Q?WYeSEixrry9edH2c1xgP60LG341YX3DSgYO451MaDFnZ+DAIMRU4ZRkaDYmK?=
 =?us-ascii?Q?VUB5dOKX1HtFNlTHCNChXMZnrMOwQNY+/XK5xZ5vBlaQ1+bbCODhnGiUtGZa?=
 =?us-ascii?Q?uSWsTO107Vi/tBRUfOkH/SaU61z1QDSv8l9U5uX8MfH0LGQdYM+LyPGl82Oz?=
 =?us-ascii?Q?A36H+tg1dVrZ8kq0vfZnuRdH4FPWeIP00ASC+sU2ZD8U1Wn8v1ZJ4goraFCS?=
 =?us-ascii?Q?GSDxmC7NObo9rxHGBzr6R2usXLr/DefyJ2fdWUcTFIO9Hl4bJq3rgzBkt2fl?=
 =?us-ascii?Q?gYW3/Sy59JK/ekjjFpTkw+QjRt1zrGgUVWLLMuRxjN/6wmv9gEmsTK595RXH?=
 =?us-ascii?Q?QJprcA6HRWqFSmUFOD3k9ae4kpR5QiZPWPzm6XG2Ed7FhLAssEBqj0byLImI?=
 =?us-ascii?Q?DWBhCi04heEBe5IXq2CvcdTSKqLxjSJELF2Muqnr+sgfivkLxGJRkuNNc+mH?=
 =?us-ascii?Q?rF/X8lzVw=3D=3D?=
X-Microsoft-Antispam-Message-Info: iQ/2YjhDxESGy899PG4ypDWLl7jqxGJPaYPueFRDmNbpnJ+k6ooT+h7Qg8fjsNkdvRWkhSt03NxkFLrrTnS+1XEXLmy5mBlp4L09VSJt6pgdqCHvXROS1TGSBJ9joe1uK5TUvI5TtfIjDcM9SqpPPFn5oXyy1Cy0xFxnuHIjjgZn0sJXIaYCV6KzMzw9hKF8
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;6:ZGhdhL/Y+drZq4yVppIm2K2AFNBD4+jLMEfciDx4HXJxSCfsutz9sMuXh4gjMsKIYVw/66GP7qf/gdZlg+bLnRC316dyvNDYsiphUPa5StdYYJAzCwDR1Pa9E3+0p/nWBJzh6Tkmw5BFPgr+9te4r8rkZ+IQWwRGQERGJuG6X3sg1TevY0Ps0S9kmhCz8JdeTHVryJd87pWD6uz4a4xuL8sI079n7WmNjRydgbO1KKYMEsYyBE/bzqLyPVo448SVWO1KRX6W1qiSXjzClEQVIJ0owOlTOKmSATTF/XEVP8WxgN59q708dExwu+6OhL9A1xy42rHUrSVfwIFLt4P8PsxOZgUjqKnvwe1nzm/25r0NePvFF7xlNKEiGsFTkHlqHE/86MRvA3cPpDTg/tj4du0g8BeyOXm8N7dXScU63b/aoAPiQb/cxQy+LgYMyzesNoc0AwCReuKboqLGYw2w8g==;5:L454j7nzkzOaEcsfjIkBabyYuHLqiN2v6KceScLOY/f0l+wueQbAh+zj3f5eFE7Lw+6Y9Z3BhDdX1SQVjWpa4lw1oMwk7HIgai7JJba6sZyxoivzvUwEGSN3bm6U5551o4e7kxbHH+nayLvrP9Ot046LrMPBlP72z3RZzH+mNSU=;24:cpB2SFKMSWFKyQMBTt8mTBr5p2yz1z26mqBjBtQfnidaNGzu/YbBCqpmAd+JBandRyEeACbaLcbAGskTSbPg9vJNpb18kQViPMF0f+EhNMk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;7:aTh+CaMiUEswPYQdSvaCFBm6RNbN0a16E0MuDOPHQx8/hSXxxb3rCykN5PYK/it8PY7vUrtt2WR1f6YNQOxpI8tJSllcNOHyQQLvHDz6wI2ENa+iT2mh4SriMFQXrZr+SSC0J7FKVZ1PHzB/Bk7uVSGf37dWhX9gANvPCFxdqLfKIaY7S2uz6x6fT+cZZpzGA4QnWIkp36Eai7OmIUW0xKt1ajnDqeydvVIopIU2T2lFdUgv4fHSPSo2WreIbtR6
X-MS-Office365-Filtering-Correlation-Id: 92d51d8a-e381-4a99-045e-08d5bb06267f
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:22:22.7068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d51d8a-e381-4a99-045e-08d5bb06267f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4384
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

According to userspace/kernel ABI, userspace off_t is  passed in register
pair just like in aarch32. In this patch corresponding aarch32 handlers
are shared to ilp32 code.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/Makefile         |  1 +
 arch/arm64/kernel/entry32.S        | 80 ------------------------
 arch/arm64/kernel/entry32_common.S | 97 ++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 80 deletions(-)
 create mode 100644 arch/arm64/kernel/entry32_common.S

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 3114191750ae..2dde9ae508ec 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -29,6 +29,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o binfmt_elf32.o
 arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o
+arm64-obj-$(CONFIG_COMPAT)		+= entry32_common.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/entry32.S b/arch/arm64/kernel/entry32.S
index f332d5d1f6b4..4bede0324440 100644
--- a/arch/arm64/kernel/entry32.S
+++ b/arch/arm64/kernel/entry32.S
@@ -39,83 +39,3 @@ ENTRY(compat_sys_rt_sigreturn_wrapper)
 	mov	x0, sp
 	b	compat_sys_rt_sigreturn
 ENDPROC(compat_sys_rt_sigreturn_wrapper)
-
-ENTRY(compat_sys_statfs64_wrapper)
-	mov	w3, #84
-	cmp	w1, #88
-	csel	w1, w3, w1, eq
-	b	compat_sys_statfs64
-ENDPROC(compat_sys_statfs64_wrapper)
-
-ENTRY(compat_sys_fstatfs64_wrapper)
-	mov	w3, #84
-	cmp	w1, #88
-	csel	w1, w3, w1, eq
-	b	compat_sys_fstatfs64
-ENDPROC(compat_sys_fstatfs64_wrapper)
-
-/*
- * Note: off_4k (w5) is always in units of 4K. If we can't do the
- * requested offset because it is not page-aligned, we return -EINVAL.
- */
-ENTRY(compat_sys_mmap2_wrapper)
-#if PAGE_SHIFT > 12
-	tst	w5, #~PAGE_MASK >> 12
-	b.ne	1f
-	lsr	w5, w5, #PAGE_SHIFT - 12
-#endif
-	b	sys_mmap_pgoff
-1:	mov	x0, #-EINVAL
-	ret
-ENDPROC(compat_sys_mmap2_wrapper)
-
-/*
- * Wrappers for AArch32 syscalls that either take 64-bit parameters
- * in registers or that take 32-bit parameters which require sign
- * extension.
- */
-ENTRY(compat_sys_pread64_wrapper)
-	regs_to_64	x3, x4, x5
-	b	sys_pread64
-ENDPROC(compat_sys_pread64_wrapper)
-
-ENTRY(compat_sys_pwrite64_wrapper)
-	regs_to_64	x3, x4, x5
-	b	sys_pwrite64
-ENDPROC(compat_sys_pwrite64_wrapper)
-
-ENTRY(compat_sys_truncate64_wrapper)
-	regs_to_64	x1, x2, x3
-	b	sys_truncate
-ENDPROC(compat_sys_truncate64_wrapper)
-
-ENTRY(compat_sys_ftruncate64_wrapper)
-	regs_to_64	x1, x2, x3
-	b	sys_ftruncate
-ENDPROC(compat_sys_ftruncate64_wrapper)
-
-ENTRY(compat_sys_readahead_wrapper)
-	regs_to_64	x1, x2, x3
-	mov	w2, w4
-	b	sys_readahead
-ENDPROC(compat_sys_readahead_wrapper)
-
-ENTRY(compat_sys_fadvise64_64_wrapper)
-	mov	w6, w1
-	regs_to_64	x1, x2, x3
-	regs_to_64	x2, x4, x5
-	mov	w3, w6
-	b	sys_fadvise64_64
-ENDPROC(compat_sys_fadvise64_64_wrapper)
-
-ENTRY(compat_sys_sync_file_range2_wrapper)
-	regs_to_64	x2, x2, x3
-	regs_to_64	x3, x4, x5
-	b	sys_sync_file_range2
-ENDPROC(compat_sys_sync_file_range2_wrapper)
-
-ENTRY(compat_sys_fallocate_wrapper)
-	regs_to_64	x2, x2, x3
-	regs_to_64	x3, x4, x5
-	b	sys_fallocate
-ENDPROC(compat_sys_fallocate_wrapper)
diff --git a/arch/arm64/kernel/entry32_common.S b/arch/arm64/kernel/entry32_common.S
new file mode 100644
index 000000000000..6ef4752162d0
--- /dev/null
+++ b/arch/arm64/kernel/entry32_common.S
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/*
+ * Compat system call wrappers
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Authors: Will Deacon <will.deacon@arm.com>
+ *	    Catalin Marinas <catalin.marinas@arm.com>
+ */
+
+#include <linux/linkage.h>
+#include <linux/const.h>
+
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/errno.h>
+#include <asm/page.h>
+
+/*
+ * Note: off_4k (w5) is always in units of 4K. If we can't do the
+ * requested offset because it is not page-aligned, we return -EINVAL.
+ */
+ENTRY(compat_sys_mmap2_wrapper)
+#if PAGE_SHIFT > 12
+	tst	w5, #~PAGE_MASK >> 12
+	b.ne	1f
+	lsr	w5, w5, #PAGE_SHIFT - 12
+#endif
+	b	sys_mmap_pgoff
+1:	mov	x0, #-EINVAL
+	ret
+ENDPROC(compat_sys_mmap2_wrapper)
+
+/*
+ * Wrappers for AArch32 syscalls that either take 64-bit parameters
+ * in registers or that take 32-bit parameters which require sign
+ * extension.
+ */
+ENTRY(compat_sys_pread64_wrapper)
+	regs_to_64	x3, x4, x5
+	b	sys_pread64
+ENDPROC(compat_sys_pread64_wrapper)
+
+ENTRY(compat_sys_pwrite64_wrapper)
+	regs_to_64	x3, x4, x5
+	b	sys_pwrite64
+ENDPROC(compat_sys_pwrite64_wrapper)
+
+ENTRY(compat_sys_truncate64_wrapper)
+	regs_to_64	x1, x2, x3
+	b	sys_truncate
+ENDPROC(compat_sys_truncate64_wrapper)
+
+ENTRY(compat_sys_ftruncate64_wrapper)
+	regs_to_64	x1, x2, x3
+	b	sys_ftruncate
+ENDPROC(compat_sys_ftruncate64_wrapper)
+
+ENTRY(compat_sys_readahead_wrapper)
+	regs_to_64	x1, x2, x3
+	mov	w2, w4
+	b	sys_readahead
+ENDPROC(compat_sys_readahead_wrapper)
+
+ENTRY(compat_sys_fadvise64_64_wrapper)
+	mov	w6, w1
+	regs_to_64	x1, x2, x3
+	regs_to_64	x2, x4, x5
+	mov	w3, w6
+	b	sys_fadvise64_64
+ENDPROC(compat_sys_fadvise64_64_wrapper)
+
+ENTRY(compat_sys_sync_file_range2_wrapper)
+	regs_to_64	x2, x2, x3
+	regs_to_64	x3, x4, x5
+	b	sys_sync_file_range2
+ENDPROC(compat_sys_sync_file_range2_wrapper)
+
+ENTRY(compat_sys_fallocate_wrapper)
+	regs_to_64	x2, x2, x3
+	regs_to_64	x3, x4, x5
+	b	sys_fallocate
+ENDPROC(compat_sys_fallocate_wrapper)
+
+ENTRY(compat_sys_statfs64_wrapper)
+	mov	w3, #84
+	cmp	w1, #88
+	csel	w1, w3, w1, eq
+	b	compat_sys_statfs64
+ENDPROC(compat_sys_statfs64_wrapper)
+
+ENTRY(compat_sys_fstatfs64_wrapper)
+	mov	w3, #84
+	cmp	w1, #88
+	csel	w1, w3, w1, eq
+	b	compat_sys_fstatfs64
+ENDPROC(compat_sys_fstatfs64_wrapper)
-- 
2.17.0

