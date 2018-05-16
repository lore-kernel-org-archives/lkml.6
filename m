Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526459377-2-13469716841218725802
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
    1526459377; b=kPxeQW27r2IY1pCymNLbxg8OIOWrT1Oi+7LBj2ATijBcxpxrk0
    IuvWAihN7ShsLHs7TMrwlVgiytYEUBek7YH5VZ3axCGPYkXjnJNVZlf1pifcPKWJ
    YITSpNnhSw3XYPH7I0bKnONYC14eITaJyWvNKkCFuWaDTnWd+AaulzHZUC2wNxB3
    8zPPvV4nZdKb246XWlycJJEMKm5ITMUqXwwEmcAsNbYY5COgBI8anHewcfnQBuuD
    AHZxf6mMT3VZbCR4fM0ka5khf9G8zusXE6hDaMsKYDIGOVmXJ10dVhy62dOfjbpq
    QflwL+zdS7G5Z1I+8CVEr80XhMn7RZyD2lJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459377; bh=0r/C6Od4Lqu0EtWRqEfOZFELSG7G3L
    rF0Bb35ZkSrms=; b=jWDzkDqWw7g8gWoEOL5ZCAeN6V8+nDgUUzFG9a2lYjsvvp
    D4wat6pOrxE0G2ee7dx8AgupnO1if8Jw0PmYVsr2HcNCILDJ66hsKcBtX4q5uaKu
    aZSloqj4LrZL1b15uQYjEFHI9RDiBXJ9YQeVk0FVPIR4lew++Od3KMPtFpdhVzN+
    TmKKqzpsfNVDvBPvN8C+mbBGhb0INQkMkylNAzZn7tnZfV/paRtKPt5nijZnauBQ
    CX4X2SCpsVGZ893ZLaGuFcU+wxm4w1J+V+BXYLw3nJBKvPS/AKZI8ZpDkQtvwbn9
    vO8mgbFxjkxcinEBj04uSxtI3HES0mAs4Esk5M3g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=C/BrVnxA x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=C/BrVnxA x-bits=1024
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
X-CM-Envelope: MS4wfEs5roD5teO6fP0wCLjceCwiou9i9U8vr7NErhVGD1w85XI6za+9m638N8MxHLXph4vNfSw5LUrxxCmzYvuaK+n5V34YINmUR8PqK1WODmoSzb/HfVV7
    vPv/SuqBrWxNerErTKy41erGWCUBcXwyB7XYdzaAcHbEXOTDwnqDQoPEvt6KXWk2WQnQxLE1gwQ3CBB+jTQUYPM8QUIFerDlHKZArqCy+XFEwFNVQT9uFdch
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=OVGXfsOndbYA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8 a=xhsBOivIuABy5QiS2EcA:9
    a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeEPIVK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:21:10 -0400
Received: from mail-cys01nam02on0081.outbound.protection.outlook.com ([104.47.37.81]:12349
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752245AbeEPIVC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:21:02 -0400
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
Subject: [PATCH 07/24] arm64: ilp32: add documentation on the ILP32 ABI for ARM64
Date: Wed, 16 May 2018 11:18:52 +0300
Message-Id: <20180516081910.10067-8-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0115.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::17) To BYAPR07MB4374.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::17)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4374;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;3:fkrIjfvGcZKkBOen97Lcm140az6nuLuB6TUc4RNo6/xh6my7az2KK8NDrExAGNdK+N4A2CCjxfmxm+CYluvUZkXL/WKi5gQe4jhuA0IZxjZTI7IEfdTsVgHT/LOkZKCw1Q1DZGlrkIyArPU7VseO46bAILIdtkbzOb/aBQ3wy7/3TVAWWFz5T3urKyFZ+0cExOWnt/Mav/cxoKCyO9+HlRQQ5x5k1vKPisvtkqTjdU/u3n/s1zliXdpnefS31tPC;25:xgnbaVj2Emy2PFoiAk7hUy9J/bPBhIwIrWj15i4o0lOKinqkhXBGAvctApDhkJExy/rLOrUXRgSHq1RvNEbpRW6IREA36cZFoPj9oSbdTFa8QKAw6XGXWJYMfW3X77Hy15ItvieK5TUJ7REtpEePPM0GmNJx4mqC9wFnzZ2+EbeNTpBEv+vTvt49PCbAJTNoCG1rEl2hpkf239cpAlFVJEmS6AT7Ge5BoqRhYAYTfke9kc4TXOfjjIplVg3w5nZB7QP92KiJVQ7EvxozV6A5xmzMucazARQObTB8RdpXFHUfmeTmGnIAQqLNNPoU8WPDCSVO4qdfH7zMqbB7oZV+cA==;31:D4csiEOSpQSNjbmVMSIZm0J/nvl4z39uKdjt157U9Nf+MDHMNLg2u7fl6s/XZoqINZv0LXXxLXgPixaWKB8+Dr4ODO3E+mzGTuIWzu8jo6PqZ61+TNteOKKb7hzTvhGcMThSw4WahINkoyNkOcDflocN+b8/4kYPLTHd6Fp+C7y0UJSVlMmnPNeolE16t+gtswftOXcpRN+q/u/Nurq49h5q7jvQKYkDpI5MXisIhBQ=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4374:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;20:EvZcgkK+C6j4vovft78OUlTFXkiq9bZmlBLt5XdbuIci8bphDjazMaoW5XakvYrffIU2x+gcx96til9JUy4Qt+r/qOwkXSmjI1qWVuV3F6+jk28iDza2FwUW1Ps7ZWQHn5eJa8vvc1vS+9Q5pPWlokQKgOmGbOW9cDNg1ptiVe6gpji6TrYnZHGhHriK0l04V2y6aBqrA/FRC0Km5ElNiiWDhbF37UZaOQkGu3VVeXpBgfG1i9zMBaVJbLRHy+FdpTOTC4HeUvFKWZSZzKmjKNTTfK8sgiCTgc9GTH1T+JosdPgZ+JQKVKZ1EzRkWvK17YMqKJgSZoTzIug6NLeZyO9MNFP9FTZyMj7C4toaaPHxKHoJbn7qa4F6HWX0CSK2hVVvc0YlrmWPweQOZ0p+ku9lNwhGLe9Q6zm0ZGO1aKYg4fHJYow4la4hxHbDcntA6qozaTixi9kFxwAH5aE0Gge5idcjNN+dz4vZjLlf56yoLhAYa4dL3NwymYN8+UB8QZOc7jEZkTU9rOiJwbuXwAtGmAXtOR+JQHGVgv78VZsR11xxeTsRG9LSEOE7lHn1yPQAiMxsmiyPd+LVNHb8fEiOB+6PH9OCeWKGRvT4cAg=;4:6p/0na0d6qFzUiq9NqjfcmJIceYrX0cNrflJ8e7ZJzDy8DYX2jqqp133rDxtENEdHJ4BUXrHFlUthpsHp7tguWmiVDxIZiDN3zr2PNeDaFi9qfpxtlYRQz4bHFixzSHmykyUSbQzYkSZoANDVqooXJztoyWtV9khk/Mt5G0t8qQ80Djj8tf4fzorVgDK/m61fY/XSsf5YjbRsBKJ8PKG/hVf1VxNnqDsVRpe77U4BIb/iel9SEZgKjgrxtpxMh+FQGD2GDiLIGc6yhIsZ8DWew==
X-Microsoft-Antispam-PRVS: <BYAPR07MB4374BDE3E8C47971B8F79737E3920@BYAPR07MB4374.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR07MB4374;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4374;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(478600001)(68736007)(42882007)(16526019)(36756003)(305945005)(4326008)(386003)(81156014)(7406005)(7416002)(50226002)(6666003)(2906002)(81166006)(53936002)(8676002)(575784001)(5660300001)(39060400002)(8936002)(110136005)(3846002)(6116002)(6496006)(54906003)(51416003)(6486002)(52116002)(1076002)(47776003)(72206003)(7736002)(97736004)(66066001)(16586007)(486006)(186003)(2616005)(26005)(476003)(956004)(48376002)(446003)(11346002)(76176011)(105586002)(106356001)(50466002)(316002)(76506005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4374;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4374;23:mHsSiaSMMpecEk/lrCl70OdnYpJdnkpWCurLbrNWf?=
 =?us-ascii?Q?i6fFT0ICh7XCzmQrcaFGEvWlK3DY9UmvTrfdsboMwfR/nRPV8ZQprtIV6GGM?=
 =?us-ascii?Q?CgnQa+BhgSZrBeSjp70REFWLdb4cgsSun80AbnTfDhaBsSz38cgx7K97k3g3?=
 =?us-ascii?Q?Oe6YKMRQRg5uKPIltl1qxggjE6c76DV/7jlFRuAljp2RwEx2FQA3PzSh4/sL?=
 =?us-ascii?Q?ADnE5SNPz5u56yiQ3kzF09VGRHIU2GysatBEl5gQ0n3z4FWb0K+UT/wKErZq?=
 =?us-ascii?Q?Mm1p+ScQlIVN0L89O7sFAe+iyfTZo9EdjUnoVUkj6sgf1ApUzLBfdygCU2Pi?=
 =?us-ascii?Q?H9jlfFWVxwEe7WzzyMDMcQakqlmOP0WYY8Xh7wFMALXsB6aO077vhqb3mOgB?=
 =?us-ascii?Q?FRPbwYTNxmgxwdaWqvPhTX+cKCHJRDRxdQcK6vodm7tvNgZlJInGcJVMCtRX?=
 =?us-ascii?Q?ymRKOtxtfh0Fa6UkLJfO/BwPGDY51dmNPBE4QqB4O83LDJSASNJqQxWZ2VyU?=
 =?us-ascii?Q?NeQ+K1AgyaXuAMXh33Tk7LIGTECQ4rxC/Oj8Q/NKU7toqEDTgS2hD2u/KbhZ?=
 =?us-ascii?Q?oQdXJySxIQLqkraddqFhljtLmXqv5HTFJQ3AU5t4o1g58KaW/f1+Nx96Lxym?=
 =?us-ascii?Q?mKwmzHWjtBcKHiijGYatMx0bfUXsqeTAntKmISMSuznPqpgiDyTpQdI1nTRT?=
 =?us-ascii?Q?jtRp3uR2IEeRNjz1hxjNkJf2DkaVgXfgt0mJxWJO6Z+YjK5V/c8awqtwpYlS?=
 =?us-ascii?Q?6aReBDoxgItnduk6IyPQkZOo9A7cXzp/A0Czk4qZDjN82R3HrJL+SKRQqkzu?=
 =?us-ascii?Q?C/R7GMTN5oD9tOHVZXwvtxZ9MZCoBdWX65y4sWFS1+4jJzBkG2RrzZVpk8rl?=
 =?us-ascii?Q?5gbIK0in26J42nemH1XQ3ixCV7I9CTZ9xyIPzSfngJo0iXfAmViHf4MFf6So?=
 =?us-ascii?Q?IJKqRuvR+rTo69I1SpVqWkwJyKr1afab850gKvcLN6hXOcoJ7M5PRY9xSYCJ?=
 =?us-ascii?Q?rvucqpb3XqAGTpdlkNBd+XM7EycQhcnW0oVh/EhuVLa87zur4CUWdUN9ndJu?=
 =?us-ascii?Q?HQtAFJf2LOkZXirN36XNPAtlcCciYvGcJXduJ3n/pVkq2QBxyxea5v9tkUJo?=
 =?us-ascii?Q?GqJScyKz0uR6LX8l2VxKyeN0bxfHMfn34RCE03id95WBwk3hQ/CVy0DKQVIX?=
 =?us-ascii?Q?cTIOY1l0EMuXkoVxXquOa3bqzTbneqsGzJdscMrsQfgbivmx4eFHDjCTODwP?=
 =?us-ascii?Q?XTSn0vRAG9nvCRfpHp5uMUbH5Fwn8oeQ8/euFVrJVnztqwJFxBgnRJW/rquc?=
 =?us-ascii?Q?QeCm2yL3xl4fswLAaCW6wIwCOTg54gVec17xa5eYsDPe6MfFH4neuGNb2D50?=
 =?us-ascii?Q?xFtuw=3D=3D?=
X-Microsoft-Antispam-Message-Info: SSjkjH4uW10xV6Pj+rtDFKnRU+DyM51ptWVEyzwnUMYVViwr6WTK8ODaDwe4etAiFHBGtSh+YVe/udx/H5XxlKrCWmkh67IkCZX7z6A/8JO5ZQrS/rnfsp3LlIdZJ0QllMfp35bsbPTMQT8urc14wcW0JzefIea6vy3XmrBvMk82u1rptXcbOD565Wj2FWHz
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;6:l9QH6+q+sk7D5QZS61e7YBDOZaAdogQAwSq5wd5cnA7j7hQe4CvjXRXhHXzSOu/GC2l46tElX5utIEJrkNJaeeqpJ64DTjvgrHj2Zt49DdC0mLRAuEjuNCPeQ08CKKNywmfDmOC+ukBRZhIaFaGGga7e+YZSR785ue4XkMSFSYJmYDdsyxNkd8IYqpWnEHK9A7NX2545XOehTx7+BCmPZXRwpB2lbw5To+7386EKzFWbMD4XekrnGXy8YiWilSyCB0IMpRKgkzq95LJpAvJLA4UWSBQHWry8DeTABBC5BkcWQqWleuIgnhT3hBA2RBOvUsGaee2Cv7bMR8/dPIoxWGlRZmO4UWCjnbCkabOg4BVDLWp67nHIEugPw2rxt15SYv5gLn1gXjKJdWOGURhLDpI1uibEdRk2wyDOLikrtmLlzigUwmRTOqgpAWV9zdOYXSY3QVQdNmnm6v/wkaalTQ==;5:jaSU+5tQ1jnZh4UAjYcpas5x0Cus+btCU4dQ5pY1fD/Ra9AtOYezL9dnHZwGZ6onkjB8N1VZuYdPbpkaJcdJWBvCStlYlmqVM7LaBiFd5RQTTyi61Xh57MdC/Cie1VvwAxPmNjLCyoU6W/SVmfyxTkwdiN/s4QqgFi9iGkORzkk=;24:sYm//1VdCxjX4WsLuVeo4e3Sc3rx6JEERnOfCHrsRCGU8kY5nK9tSaWsWlYaLzgm8T1943hg5V4Seoyj5Qo9pzmtbCXo0vEQ6TNheUEZH+4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;7:pH1eI/mHF6qW/kKO8d5RtHUMiwJBNQGjv6nL3y4xGIsuVyM1Vq5nkWEt9u0vLHMq5x+KvylwT322zAbeXDVze73oLz1NxG/QF4iW0X2UDu0MJTAipKptpNEPJnoAlfeiqi8SPhrBj8IjpK49GGjP/su2PFQfznduWaQzqeUn0JxKlcuN1jxGBPsrvqgoH8gZTZNVxNYHsak/BDgnOianTZMPNTqxenDFVIAo7kQV6SFzJiugRboGfIChA340srqJ
X-MS-Office365-Filtering-Correlation-Id: 8ae0c413-6526-4513-676a-08d5bb05f39e
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:20:57.1768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae0c413-6526-4513-676a-08d5bb05f39e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4374
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Based on Andrew Pinski's patch-series.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 Documentation/arm64/ilp32.txt | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/arm64/ilp32.txt

diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
new file mode 100644
index 000000000000..d0fd5109c4b2
--- /dev/null
+++ b/Documentation/arm64/ilp32.txt
@@ -0,0 +1,45 @@
+ILP32 AARCH64 SYSCALL ABI
+=========================
+
+This document describes the ILP32 syscall ABI and where it differs
+from the generic compat linux syscall interface.
+
+AARCH64/ILP32 userspace can pass garbage in the top halve of w0-w7 registers
+(syscall arguments). So top 32 bits are zeroed for them.
+
+Comparing to AARCH32, AARCH64/ILP32 has 64-bit length of following types:
+ino_t       is u64 type.
+off_t       is s64 type.
+blkcnt_t    is s64 type.
+fsblkcnt_t  is u64 type.
+fsfilcnt_t  is u64 type.
+rlim_t      is u64 type.
+
+AARCH64/ILP32 ABI uses standard syscall table which can be found at
+include/uapi/asm-generic/unistd.h, with the exceptions listed below.
+
+Syscalls which pass 64-bit values are handled by the code shared from
+AARCH32 and pass that value as a pair. Following syscalls are affected:
+fadvise64_64()
+fallocate()
+ftruncate64()
+pread64()
+pwrite64()
+readahead()
+sync_file_range()
+truncate64()
+
+ptrace() syscall is handled by compat version.
+
+shmat() syscall is handled by non-compat handler as aarch64/ilp32 has no
+limitation on 4-pages alignment for shared memory.
+
+statfs() and fstatfs() take the size of struct statfs as an argument.
+It is calculated differently in kernel and user spaces. So AARCH32 handlers
+are taken to handle it.
+
+struct rt_sigframe is redefined and contains struct compat_siginfo,
+as compat syscalls expect, and struct ilp32_ucontext, to handle
+AARCH64 register set and 32-bit userspace register representation.
+
+elf_gregset_t is taken from lp64 to handle registers properly.
-- 
2.17.0

