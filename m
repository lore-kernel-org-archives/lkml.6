Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526458781-2-9612634033678602253
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
    1526458780; b=TKlG/yuCdql0qQCbDvdJ7qaoo+1gvYDQRmiT2mGdlNOfIKMyfY
    T6UXKfogHa1rCdPKShtfBwMHropFUZnFC0ovvvIKaBQR5xVFa1e7guEaRDOxJ4xw
    poLaKNtzHyAB5vMyZH3y9MhDosS2a16VKhwZBKcwALcjlL3vT1IDF/Djs8i2j2yk
    4WjO/C+B/bMPIGKCjOBYIJbz3Xf6d/bmb6WNwEwWYHXAZikZ4ffUIf4r6aDwKEWu
    8vbm4HKFEuWf8lG3/MhByuhNRQ3G1fK7o7JP4700ragrphO0sJoci+h3vP6BHMD/
    zvs+9/OS6s+DYsWUvTqbVYQbUzExpor9C3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526458780;
    bh=wvV78jmdtpqggud5RUbpTEX3j3brrxm4T9PGF2gNhKc=; b=VIg6TygPUMlt
    5c7og8pL1xW2NhMg+fExc2YFWSQND8LT9yh+yP3envLwO27U1N+m6HCc3AuO/tzt
    1sg7PtPryLcwJwFEzD2ywgipbix9+dmxV4+SEj8uufr2yteb9CXrxxWxiubKbe2o
    A2TfqLynIGpWN1LGgHRzaQhH4yA66/tltJ6mIuB31ytqHZw3fqy1RxCzHFiZCczR
    30dqhjVE6ReUvTy1a8g/QNaECVCPWK/vU3q66k3bLS3NIuKTtGr/SEtwsDvHKJH5
    BISD6DUDZ1hyC1xZ9Jkd5+KhiKgEZAD1g5wN0ofY8y6K2bdEIlrmtSruwQX3Knlu
    Q+xaeshxjw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=ck+cnqmX x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=ck+cnqmX x-bits=1024
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
X-CM-Envelope: MS4wfDppUjLG323FuX8vGKb9y8VpAraUk/+57ghJG/2vAwJRscZg3D9v7e2Pthtqe5u1mZ5MIJJvK1I5jqiNOMtgAwqnSujkpND5MezhsAP+7mc0Y+2l7u+I
    Iy0IztSbA8H1ygzM2krYPgG178v3qGpTiTBvGM6GAJVEfz91DwCKOw+tWYbO9cytMViNW6XCm9bqFGFkr4lFAT8nZFA4pKK+MWKYc691rmevxwE6fJUBG9cW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=heuDNHDq8GQA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=KSb9T-wMAAAA:8
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=6jDnSUP5nZF_S6KhsuEA:9 a=x8gzFH9gYPwA:10
    a=cvBusfyB2V15izCimMoJ:22 a=KF4VuIdXkMyp4E_ug72i:22 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeEPITh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:19:37 -0400
Received: from mail-sn1nam02on0087.outbound.protection.outlook.com ([104.47.36.87]:31968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752524AbeEPIT1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:19:27 -0400
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
Subject: [PATCH v9 00/24] ILP32 for ARM64
Date: Wed, 16 May 2018 11:18:45 +0300
Message-Id: <20180516081910.10067-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:803:64::25) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4373;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;3:wMvzK6s99PeICUXwSOKv8o6hUw5yHvdoD+l+HaYKCQXrhdqUyGIyT7npui8Ib9SIysxrFxxCQK5u5kLT9r2/3m+M1z7bk8eIXmRGv04xswktAOyFDqHh+OL7G8s8L87vFbJjBP0dXbRe/ovvv5uSHYLVcU/IlRFEo1In+grBPGsUoaNB/uUmeguvptrN47vUFgJFaBlOEWiPphey7JLunIb+Cyv9aUXMqfPUBzKpbp5cY/Ph5ucNcszI2S2Ws2oH;25:+vL7sTp3LAuAsNPOZ6MFEQmVpQIHCiucoMzu1Y0Dsw1TWwhTWu3jVe3hh3acoTC7M8VPF0MUvFIN1y5GLTJwMrxHhyH64/uGjJsIpowve2GF80XNOpiK/CManciRp7IYH6VpORYKWhHqR+Apr7vvLmYvL8mjmpkFyPuG8TReg9rxKZt1m2xovjuUBQJGV/wShn1VjrBYpfLQuXQQ3VzyqhUMv41RZ2XeOdHZcbjf6RzWPgSbxHUzJSUa4DRhYqT+2oLeirPN1Fed6jvTByx9Z/u0295Wy7hrC7yugzrRB1tolshpYdYmn2Iv6BuA0NbP/LLr/wIkLNsO2woBmjDrBA==;31:bduwk1xrpjpVv4lxFwvEqPJPN881CP1/ALzFmsmEBS7+iN+RgVTSc1MPtNHB+kh+2Wrfbtbhii3TllCd88Qtk9sCGO5fgY/GhIxiC0IAI/ugTSqlTNx/UyrCFHxuWHR//7kTlooJYb33Yy/5oodUpLiYAi3dwln5cQ3XUjEZmRtqxk91wd+s/cKUh2SnOpFDfq9Xs9XDnkZ6VBTOdhhffOn0wbPiAQQxtoAT6EVXeTk=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4373:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;20:HBVv0outtcW93OAQ46qMeu027/9/eaz25Dm73T+B3m0ebSghK/NYqqFLtdEK0SiKy+jTCusECrnCMEIjoJiUCJCFR99JSaCq3QSpm1KhDs1iGtkvolLLRp7z91D+S9wBy1nBU8tmq3Vd/S2XAabjIHkciEybw8BahGSUg1/MircFzInvi6PH2M8qDzj9kOVOqpM+aXarDJBR9NtfMSadUGmpyKu6sJ5LabVdwuLHVNMEBC0TTn2SRQ47EN1F4xUZxqZTP0RQoghFAuEIn6AddwlnrdiAqgcPJnw8n0YOiOxI2RSab/2nXPS9s8ojSya27NBCfaOHsDOgKLF9FRI1ZR6ZySL0ju5NeTF67VyzKvxuG9qgMX78Hi5gbA0znIxxeBJ85seYWhDF6zW3CqpNq3Z8Y/QMwAikZnX5KG7HAzX9+dw/v8oZJtV4XUS57P5bLpkaK85zAn8l8DF9nHw0pdSOzFBmENLpuWwL3098ePv1MwM8vi6lHCVrvKlsqAV+4qsaT58omnPt74PgVizVeQIEfXjk1fkugNgw9M/3683x7zk+Lvnd5EB7fW3WQnKhjNn0sQ8TbKLwFHO04UJgzxOZWq2Murz05rr7x1GttRk=;4:JjZyCLgO9E4V+xOr+KBGC16V+h7zwBLIBtsXpkzRWB5RegoRZcCYUsCR6lnJFN2qv5ZRapRL52C1wTqwJLJwAnyhRXMJjYKhzkBMO2g+cKqsFtwPJG8DxJ9vl4V1X9HYuYzGEfLRl2+qyoxP0yKxIR5+JmcDoY+Q0SbfTVUMrFPCZavHhPMkFSubaD6UpRO4bd893aWzVzM0RaknmAKjbEHQlnGD5bsOX2xmMyEFcenX3XNjrNdvorIOp6daylmbKwkQxT05A83k8n3o0TjlsVmZaMaHqIL/jKODuyZpPWvHZcZ9zhSkX3d4yOL1gkld
X-Microsoft-Antispam-PRVS: <BYAPR07MB43733DF8B1B0D30C0C88FD62E3920@BYAPR07MB4373.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR07MB4373;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4373;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(39380400002)(396003)(346002)(39860400002)(366004)(189003)(199004)(2906002)(305945005)(39060400002)(7736002)(42882007)(7416002)(7406005)(956004)(476003)(2616005)(53936002)(106356001)(68736007)(6666003)(36756003)(47776003)(4326008)(5660300001)(3846002)(6116002)(25786009)(50466002)(966005)(72206003)(386003)(76506005)(54906003)(110136005)(26005)(6496006)(66066001)(105586002)(1076002)(48376002)(8936002)(50226002)(6486002)(6306002)(8676002)(486006)(81166006)(81156014)(478600001)(52116002)(186003)(59450400001)(16586007)(97736004)(16526019)(316002)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4373;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4373;23:XnRJ6UU7XtPbE07smLVmn0D1ODG0ZVLGLMivmy2z1?=
 =?us-ascii?Q?/WS2+D/u6dFYTDBJPqqPc0FU10B/SMFHR/o17BSeOUT/fbPSn3myPK3qT4+2?=
 =?us-ascii?Q?kIUcpLhTqGLgt2CdESYY0XjfEjDJh0aKoDt+8nt3pjrS3N5MSMFZgepZfK9t?=
 =?us-ascii?Q?u2lVfXO/YEjPyLZ01vVurRzfO1/7JCgosbuPnqK4pFFiM7TmKIlC+zID7FvS?=
 =?us-ascii?Q?m3flv+0QPs81ZwVNUH8IPJBpHSzbqUcMeoY8o/7VzwSadSfqFft33jJMjX9T?=
 =?us-ascii?Q?Qx+o4MszL5zfdM7+9nBI5Gob5TWKOxLMA2zJfLsX8qgwpdpYPluDv2/yqaoS?=
 =?us-ascii?Q?/w41KIkYy8btaw4qd0KZwB6RLcHdUPSQpQ9DJNGQgHtU6c8vI5E+XI0pDml2?=
 =?us-ascii?Q?JsGROQdAVJF2JMscBP95exuPOkRMWv20p0ho8Ml+b/7IZyqS1JwQifyLvDc9?=
 =?us-ascii?Q?WlSYVKYsEZoXAlm6Czfy7lh5qPKHRJCo/lV7CHncv7LTFAtdnqizIz5Mt9Ul?=
 =?us-ascii?Q?R9gRpSXBFjSjG82F1TcVEnFtC0Md98UU0CJjjV2s45ZevwUV43GrfCvZcv0U?=
 =?us-ascii?Q?5qyEk4mTaafqtF5sol3sO10eFDGtsIhb6THTVVNHhuPi5WfIODkymddIs1ZU?=
 =?us-ascii?Q?FvsnoI3lqLgDAyOLdBfvD7e9EioUlftJxz4v04FClScsvy78/6BkqU14l1t0?=
 =?us-ascii?Q?RagvfcCyg8jBwuFHNJWC4zQxYpeY0vnpvjPkZ66ebvHdVb01t9PlLbt9qHXp?=
 =?us-ascii?Q?TO0hhXxoWtkdg3v5jdD/sVEOLW+WfqXbkVomuGy6xcQV7GsMJFtXgGrt33yX?=
 =?us-ascii?Q?uvOW/UGXIYcDXyLQYUb8wavwqEOjOLqPH9rcDuP9ovfjT68rFv9Dplk7sLfZ?=
 =?us-ascii?Q?j7G+m7PkwoXH2nOzTjek2aat+4vchuwOBRUHt/pnm3L9rXHGYdK3dZ2QIq0/?=
 =?us-ascii?Q?HOV9W1o1k0+y448TOBzo9z6dcB/uNInc8OJTDwCYWnrn40/ecKRN3s42NmDm?=
 =?us-ascii?Q?P9j3R1hj6IzlyzaUdY/+miPBxeNuVTkV+lKYvB5BWHeS2fBa1Gzqx8w5+ViW?=
 =?us-ascii?Q?Fztuq0VEp/kBcS1BT3wvT3ospXxlyM72/4kCjjZf5wBokVPRbz32/c0W/1AJ?=
 =?us-ascii?Q?9nm8xPoIC+uJdi0lAvIlysU0nzXOJV6n4QEKCU0RMBQGXDnZ+tz2aMo8TalX?=
 =?us-ascii?Q?47lVLhPWvdE1MgqQBm4soq1ongIytRrDBvSw/WVhX7JQrPlq/h1u5fJZb8Vd?=
 =?us-ascii?Q?Tu0/pbhIs0GUISKygeqV3GoBmxiUgYr28nDWNl33Xm/uxsgUit8UpNkA6TbU?=
 =?us-ascii?Q?W24UtMIyPrhSVPFyKBgXhRlpOdhEk+1uyTyQYzWGO7/?=
X-Microsoft-Antispam-Message-Info: VycgOVwXxrKQ9r4I/oVZ3SrHTS0kzcJ7pOjO9q1FyIvpaiqxZgxSLKNt90VLxjmVpD/wZICcoYLfyZu31fcepkwX4JGgVXvfOo46nd319z9lSKrcxWlcxo0e2N+qOl5nYXtWMdqCHOgqU2X6ROrS2VTRPJbCJ7n5h4FhdH3XxiJvGGHJ/m8zZC48nXkqIigQ
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;6:T0gYAtQIW9EyyWskW0EwCZvlYqmyB2b+/QhTTJCSlckSh6W0FFAtimkjcBEpYilfySAOt+9XD3sIltPr1wsr5V/v758YFqww1iHkO4EBvD1vTSMLv08YUQY9PAiiUrXq1e4Bs1wZ8YX0TQYS6u7muDDNi5fyMYJneX0SBaQZnOb7VjhzXm/X/TydZa0U3QlcCrkl08jhcj7pKhjRNEPGnAQhVEGpEZS578xET2VIfklMfZxipLe5y8eDpHfTP31Xz7kVTJV0VTnol9+se/dzjj8iRDNlo2ZHEuxh6HM5ReLo5s12WC/Fq+UATOzG5FxeuXydD+9rk+0QjhrC571UkWeyhkx8pl7C/NRVyo2ykMo2BfU001xDgHKx6cWFMBHx0lj/Gd+UYFeiMsK3mMnpGYwo5rh/Lx2GQZIpD3Cbi+i+U9Tqhb/fxZ6aIRIQogbONRHNtpXVWp1l42/cAB06sw==;5:fehE8kmMy+OQ/QW2F3baLlvAJKvNdGsnAuBehbiw39yWHwrxbEkxns4/h+WFJPGJtU05k3WY9VEdXFimE15fR1GXsiHdKD6Q1gzqT8/ghkOWgUh6J6ykHpvgsOX8CvuB9AQtQGa2klclsFTV5wn/qd3p6jDwTtilW7zsuCvUOqM=;24:sD4+vGtmaCycuY15EGlryiS97JcLap5O3ka+IcD+9TJ8Fb24J/9sximUS8sUecS8EpDJhT3g/Jc2y0BiQufHQz069fLwU544/smmZL0k434=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;7:w+gF5icQ2xs1tJe6hd5gejNyYWm095JgOE0uGEshL0asFzcdTblzZZh0WktqhMm+a1hn+1OLIDkHsfwaAZGC4gD5ZtovznUk3CD59GUt+9ccvjQhmwp9RpYZCr4/EtW+5bRC5t+RMwDH+LiaqkkYsJX/mIuK+yLl55+SEUxfp+2Ebc0baj66fd3WLQEsJnsoQYw/m1Ucu+li95G3Nl0EGWUiT+tzxioe7IWFKlapBdk59dR9Jff2CwqG2vjIe5CJ
X-MS-Office365-Filtering-Correlation-Id: de1150a3-a85f-4620-33e5-08d5bb05bc02
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:19:23.7222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1150a3-a85f-4620-33e5-08d5bb05bc02
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4373
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series enables AARCH64 with ILP32 mode.

As supporting work, it introduces ARCH_32BIT_OFF_T configuration
option that is enabled for existing 32-bit architectures but disabled
for new arches (so 64-bit off_t userspace type is used by new userspace).
Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.

Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench,
CPUSpec.

This series on github: 
https://github.com/norov/linux/tree/ilp32-4.16
Linaro toolchain:
http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1/aarch64-linux-gnu_ilp32/
Debian repo:
http://people.linaro.org/~wookey/ilp32/
OpenSUSE repo:
https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32

Changes:
v3: https://lkml.org/lkml/2014/9/3/704
v4: https://lkml.org/lkml/2015/4/13/691
v5: https://lkml.org/lkml/2015/9/29/911
v6: https://lkml.org/lkml/2016/5/23/661
v7: https://lkml.org/lkml/2017/1/9/213
v8: https://lkml.org/lkml/2017/6/19/624
v9: - rebased on top of v4.16;
    - signal subsystem reworked to avoid code duplication, as requested
      by Dave Martin (patches 18 and 20);
    - new files introduced in series use SPDX notation for license;
    - linux-api and linux-arch CCed as the series changes kernel ABI;
    - checkpatch and other minor fixes.
    - Zhou Chengming's reported-by for patch 2 and signed-off-by for
      patch 21 removed because his email became invalid. Zhou, please
      share your new email.

Andrew Pinski (4):
  arm64: rename COMPAT to AARCH32_EL0 in Kconfig
  arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
  arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
    it
  arm64:ilp32: add ARM64_ILP32 to Kconfig

Catalin Marinas (1):
  arm64: ilp32: Make the Kconfig option default y

Dave Martin (1):
  arm64: signal: Make parse_user_sigframe() independent of rt_sigframe
    layout

James Morse (1):
  ptrace: Add compat PTRACE_{G,S}ETSIGMASK handlers

Philipp Tomsich (1):
  arm64:ilp32: add vdso-ilp32 and use for signal return

Yury Norov (16):
  compat ABI: use non-compat openat and open_by_handle_at variants
  32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
  asm-generic: Drop getrlimit and setrlimit syscalls from default list
  thread: move thread bits accessors to separated file
  arm64: ilp32: add documentation on the ILP32 ABI for ARM64
  arm64: rename functions that reference compat term
  arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
  arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
  arm64: introduce binfmt_elf32.c
  arm64: change compat_elf_hwcap and compat_elf_hwcap2 prefix to a32
  arm64: ilp32: introduce binfmt_ilp32.c
  arm64: ilp32: share aarch32 syscall handlers
  arm64: signal: share lp64 signal structures and routines to ilp32
  arm64: signal32: move ilp32 and aarch32 common code to separated file
  arm64: ilp32: introduce ilp32-specific sigframe and ucontext
  arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32

 Documentation/arm64/ilp32.txt                 |  45 +++
 arch/Kconfig                                  |  15 +
 arch/arc/Kconfig                              |   1 +
 arch/arc/include/uapi/asm/unistd.h            |   1 +
 arch/arm/Kconfig                              |   1 +
 arch/arm64/Kconfig                            |  18 +-
 arch/arm64/Makefile                           |   3 +
 arch/arm64/include/asm/compat.h               |  19 +-
 arch/arm64/include/asm/elf.h                  |  36 +-
 arch/arm64/include/asm/fpsimd.h               |   2 +-
 arch/arm64/include/asm/ftrace.h               |   2 +-
 arch/arm64/include/asm/hwcap.h                |   8 +-
 arch/arm64/include/asm/is_compat.h            |  78 ++++
 arch/arm64/include/asm/processor.h            |  15 +-
 arch/arm64/include/asm/ptrace.h               |  12 +-
 arch/arm64/include/asm/seccomp.h              |   2 +-
 arch/arm64/include/asm/signal32.h             |  19 +-
 arch/arm64/include/asm/signal32_common.h      |  13 +
 arch/arm64/include/asm/signal_common.h        | 306 +++++++++++++++
 arch/arm64/include/asm/signal_ilp32.h         |  23 ++
 arch/arm64/include/asm/syscall.h              |   2 +-
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/asm/unistd.h               |   6 +-
 arch/arm64/include/asm/vdso.h                 |   6 +
 arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
 arch/arm64/include/uapi/asm/unistd.h          |  13 +
 arch/arm64/kernel/Makefile                    |   8 +-
 arch/arm64/kernel/armv8_deprecated.c          |   6 +-
 arch/arm64/kernel/asm-offsets.c               |   9 +-
 arch/arm64/kernel/binfmt_elf32.c              |  35 ++
 arch/arm64/kernel/binfmt_ilp32.c              |  87 +++++
 arch/arm64/kernel/cpufeature.c                |  28 +-
 arch/arm64/kernel/cpuinfo.c                   |  18 +-
 arch/arm64/kernel/debug-monitors.c            |   4 +-
 arch/arm64/kernel/entry.S                     |  37 +-
 arch/arm64/kernel/entry32.S                   |  80 ----
 arch/arm64/kernel/entry32_common.S            |  97 +++++
 arch/arm64/kernel/entry_ilp32.S               |  12 +
 arch/arm64/kernel/head.S                      |   2 +-
 arch/arm64/kernel/hw_breakpoint.c             |   8 +-
 arch/arm64/kernel/perf_callchain.c            |  28 +-
 arch/arm64/kernel/perf_regs.c                 |   4 +-
 arch/arm64/kernel/process.c                   |  11 +-
 arch/arm64/kernel/ptrace.c                    |  36 +-
 arch/arm64/kernel/signal.c                    | 352 +++---------------
 arch/arm64/kernel/signal32.c                  | 111 +++---
 arch/arm64/kernel/signal32_common.c           |  37 ++
 arch/arm64/kernel/signal_ilp32.c              |  65 ++++
 arch/arm64/kernel/sys_compat.c                |  10 +-
 arch/arm64/kernel/sys_ilp32.c                 |  90 +++++
 arch/arm64/kernel/traps.c                     |  11 +-
 arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
 arch/arm64/kernel/vdso-ilp32/Makefile         |  82 ++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  22 ++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  84 +++++
 arch/arm64/kernel/vdso.c                      |  65 +++-
 arch/arm64/kernel/vdso/gettimeofday.S         |  20 +-
 arch/arm64/kernel/vdso/vdso.S                 |   6 +-
 arch/arm64/mm/mmap.c                          |   2 +-
 arch/blackfin/Kconfig                         |   1 +
 arch/c6x/include/uapi/asm/unistd.h            |   1 +
 arch/cris/Kconfig                             |   1 +
 arch/frv/Kconfig                              |   1 +
 arch/h8300/Kconfig                            |   1 +
 arch/h8300/include/uapi/asm/unistd.h          |   1 +
 arch/hexagon/Kconfig                          |   1 +
 arch/hexagon/include/uapi/asm/unistd.h        |   1 +
 arch/m32r/Kconfig                             |   1 +
 arch/m68k/Kconfig                             |   1 +
 arch/metag/Kconfig                            |   1 +
 arch/metag/include/uapi/asm/unistd.h          |   1 +
 arch/microblaze/Kconfig                       |   1 +
 arch/mips/Kconfig                             |   1 +
 arch/mn10300/Kconfig                          |   1 +
 arch/nios2/Kconfig                            |   1 +
 arch/nios2/include/uapi/asm/unistd.h          |   1 +
 arch/openrisc/Kconfig                         |   1 +
 arch/openrisc/include/uapi/asm/unistd.h       |   1 +
 arch/parisc/Kconfig                           |   1 +
 arch/powerpc/Kconfig                          |   1 +
 arch/score/Kconfig                            |   1 +
 arch/score/include/uapi/asm/unistd.h          |   1 +
 arch/sh/Kconfig                               |   1 +
 arch/sparc/Kconfig                            |   1 +
 arch/tile/Kconfig                             |   1 +
 arch/tile/include/uapi/asm/unistd.h           |   1 +
 arch/tile/kernel/compat.c                     |   3 +
 arch/unicore32/Kconfig                        |   1 +
 arch/unicore32/include/uapi/asm/unistd.h      |   1 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/um/Kconfig                           |   1 +
 arch/xtensa/Kconfig                           |   1 +
 drivers/clocksource/arm_arch_timer.c          |   4 +-
 include/linux/fcntl.h                         |   2 +-
 include/linux/sched.h                         |   1 +
 include/linux/thread_bits.h                   |  76 ++++
 include/linux/thread_info.h                   |  64 +---
 include/uapi/asm-generic/unistd.h             |  10 +-
 kernel/ptrace.c                               |  48 ++-
 scripts/checksyscalls.sh                      |   5 +
 100 files changed, 1675 insertions(+), 698 deletions(-)
 create mode 100644 Documentation/arm64/ilp32.txt
 create mode 100644 arch/arm64/include/asm/is_compat.h
 create mode 100644 arch/arm64/include/asm/signal32_common.h
 create mode 100644 arch/arm64/include/asm/signal_common.h
 create mode 100644 arch/arm64/include/asm/signal_ilp32.h
 create mode 100644 arch/arm64/kernel/binfmt_elf32.c
 create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
 create mode 100644 arch/arm64/kernel/entry32_common.S
 create mode 100644 arch/arm64/kernel/entry_ilp32.S
 create mode 100644 arch/arm64/kernel/signal32_common.c
 create mode 100644 arch/arm64/kernel/signal_ilp32.c
 create mode 100644 arch/arm64/kernel/sys_ilp32.c
 create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
 create mode 100644 include/linux/thread_bits.h

-- 
2.17.0

