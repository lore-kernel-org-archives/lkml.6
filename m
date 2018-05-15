Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3096842-1526411560-2-4975559538418362377
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526411559; b=Y63AOCbOoFSomnvXMeJXulGycuIOlKZsgbh+1vEs7dOkhs1AOC
    QLkTfmwhDSI54mk1CIxiMS6vQ9SjYuVPK0bKbwB0i+AnavG481GuetsJ/ZNnY0V7
    VDWXnQklqDKPmbnubCsZcSzVlEMzHcamIwTl6PrWcGgrFwZuueFbWBWClU3jmAtT
    3f8Nms/NE8JRfQRRNIiR9rwyq7KaktVrVsRFlj8CPS8OYTci5Fs13UEXbycbkREW
    X9Akel/ThiPEdgWaISMbmOzVdFJU/uHuSDnwAZKRKPHdcwHVoFKb7gbhLAvnuBQ/
    Hrt8ZdNvTKmn6SLMDXMNwMPnlsttcl6ssiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526411559;
    bh=aJIs/xMoOwxfD6MjsLj/Xgrd1wNb6aymKAgZBOvHfOY=; b=aO7olO9e4kI9
    c8b+F7UwK7vk6WoDEyVJGmxXMqE2IMKj1pC6eOqRKVh4+1oSxjp28o+JxdzItc0g
    qjN0KAk3cA7B/smvaEuG1hl1Pw5LZeBPwgiVmKQ0vHwRYuHjGsMY1lJg5A15pIZx
    sgmU4Wc0DaYpLwuqa1Z4EGF+9/XrKAoIWWoGLgDp3/aZt7kP9cu3e3oEbs3j65xg
    p7Fr/z46e6Ify8yEmKQp39unx40gv4BRyX/vuQf2c5Ks1Eg/Jd4E2637LLOrrBv3
    e5lLgXTE7dQiOChyYrM2L90cjf3OBTwO80GxwCrQIBN5fCmDBtWVT2lM/IJBsCG2
    RTTEKGGTWQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=V7fkWQOv x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=V7fkWQOv x-bits=1024
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
X-CM-Envelope: MS4wfMDhq8kmgiZXjb/jZponWSaLK9ird3ZHliQ4hjyS/3pCtxRh1ulnT/Z8sgFEUA7e/KJe4KPXOwDd1EDtGKUOZFC2Fu3M5G8tmtWHXak8w5PerKhLs/yD
    XhrZ33x72LlgPhHJYPeDP/5OzwdK4yRQuOY2n624XBNcSuAQZn39A3TlpN2zIt391+fBm3m3iTudX5PedSL9dStaXd1fAHCgX0ydP9Wb6pWMKW2+yNxxc2kW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=NMmGLDPa_bsA:10 a=mu3WYqzaZi4A:10 a=heuDNHDq8GQA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=KSb9T-wMAAAA:8
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=6jDnSUP5nZF_S6KhsuEA:9 a=x8gzFH9gYPwA:10
    a=cvBusfyB2V15izCimMoJ:22 a=KF4VuIdXkMyp4E_ug72i:22 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeEOTMf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:12:35 -0400
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:50176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751219AbeEOTMc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 15 May 2018 15:12:32 -0400
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
Subject: [PATCH v9 00/24] ILP32 for ARM64
Date: Tue, 15 May 2018 22:11:50 +0300
Message-Id: <20180515191214.5045-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.40.107]
X-ClientProxiedBy: AM4PR0101CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::36) To SN6PR07MB4383.namprd07.prod.outlook.com
 (2603:10b6:805:58::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4383;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;3:qEfO/TrW3taIAsNUOkdf2rftv0Ez3mK+bdOXpADS9jWkmkg57Y1PJhZsNhpYmyH3lkkEYsGHE3tWdVw4K8q0io9f9+LtuRKZXrWSRMETfzCkkzeS3W2eacEWyDkEYNReQG23+6suQZy2ZVvYN3aM1gmAFRK1UxkAQNtNbZ2glzbB5L+gHvSoVOpSHvi/zKy0mTqo81K2SxzT2i4qgPTym/NTPaYLoRC8FrT1jFZr+YcY/tFTiYYh7kahh4rlhnVV;25:lPnG+7IRjM1wN77OE0gp9g0XzEk9vDB1qr7//xCkJXimjtITUCIoX55pQM++98aR8xV9XAnB2ckqGoZ0QTET7ImzI2tnWwyI0uDgT/w44L2m8DWRkSgsngrr8fXVbB2JMRQPKws78632xGFlnIQPvmohf5cL/ghEOAz45t4tPc9pavnztMNUzNlHpgyMj/5K2oCdfnbnBweYZQwta9dKN+pjTGlkuduvi9S3OqgFIpsADTT1jXbuoM3jbRAoQt0Wwt7nvkejJu5L17EzK8NZiri8rw2d2riS47q3y5MkpJGpUw+jPpHwlmifzRP1iCem47HPe6cz79sAufk2JqRAGg==;31:/zJS2zsF4U4OxE3PKVtpE5XGNZfV4bMmydYDUGpKItfDeWA1C7NPCnPFjzjETKhZmSszrDlz3gjYfJnDH6oCuQ/NPC3cT2IcIfoTzuvGe/5CgoR3DtkwWDxpzblDaJpAT4vXnlbR00mpQ8ouW1MO+J3ea6JzkVEUzToEkg0kiwZaNSkBHQ65PQJLCJq0/Pt4Y5n5r4MFbkXLFywHtnTcnXM1Zq/T6xoJ4Fu9dKWvCJY=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4383:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;20:obrwVT12NHHTnlH+WXm3cu2WEVwJVfZFROiPkbwLcJ36RhhoJzCDxgYS5aKo5eUC2VdKrj6xo+bjFOhrK0Ys6+Fu6L5j1zsY6mUQaMUczg8sC9FjbStmO17/toiwQxsAkxESN5C/zqhzqAbnKgLQqWi230tR8KLzF1Ip004f8Pjd5pQ71+7q6GkraFUeaSGHwF3rPgMXc3oqtkg7m1Fae9IhV5iLEzLXjfJVvhv9iCMlVtiNcmEbjeHU8zxULuLpOjT/gZq1jz64iPysXhIAkPYwFzAfsqQRqUwDEcIWXNT+OZRM+EeqHtr5e0bSRUGjw1rnAA0zM1S8nalVvEXU1RTRzcIgH0hsr/SDsGrcuYYXvvsS7fwaOvBq3/nMrDsGgvppfagYD63ixcIrc7ix6IhWqHVom6KmtIKfVCZK+98FU9m2TsKLtA1Z+aVCeRIn9eMhoyjvU8DXGWm0hRAX7sN3rZR8vFXyJnUkjiO8dahsZ62KzhYrVf2U5hPt1JNLcNJUV6TRw5REiJkfNKg3gQkXWZJvKRLAbcPg6cyf/3kx+VoZYdZ/i6K9efdTlF44nEPpl6B6LFHOLleZ8m2ga93irtbD1wuQiRY0Bzjf8tA=;4:VixCXwwyIigjWI3ZGx2XO63F9kQJmelQonyqIQqBEQFRN0/HfUm/MkupTYRdmq+NAst6IrqfpxAr8EiiKbKbrdFT/YHxQ4I5AVcQ2vWv8RKQdJ51BYAk0dehEC0stb6NDeYPgtRakt25Oh6QiMBsVu5h/RgCXzd/v27LfuoJcwWAIxF6eMlzbuQ2i9ZgC6ccnU6tib/lAcmeKJvu2GiKWh9A902FAKSWkqjPIZVqwsy7LF4J0aXj/FRO9VOqrhYHFP0IhWNMao5rPmwcCbgw4vFkSKt/W17fLmv2gn+PRZJYmUHI9zEXNq+crbJv6wmy
X-Microsoft-Antispam-PRVS: <SN6PR07MB438392CDB3AF4A8BB5B13E07E3930@SN6PR07MB4383.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN6PR07MB4383;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4383;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(478600001)(16586007)(6496006)(7406005)(316002)(72206003)(966005)(7416002)(47776003)(7736002)(6486002)(305945005)(25786009)(386003)(59450400001)(66066001)(54906003)(26005)(97736004)(110136005)(52116002)(51416003)(16526019)(5660300001)(186003)(36756003)(486006)(4326008)(1076002)(39060400002)(3846002)(50466002)(6116002)(6306002)(42882007)(2906002)(48376002)(6666003)(50226002)(68736007)(2616005)(8936002)(106356001)(476003)(53936002)(956004)(105586002)(81166006)(81156014)(76506005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4383;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4383;23:DkiJD3khCScsbAWmaYUgCY9naNcyiAnDC0Zff9L0w?=
 =?us-ascii?Q?CEjJ8REOnrMZ5yUoUy6MfQPyUykmyTK31cDh4x8+54YECTphEIZJYM4CKEbv?=
 =?us-ascii?Q?wgYEzZz1bsM0gNz7zBJK9TLh9YO7Dd1CeBrDGHFt4bVhTpTR1avTyiVf3Yul?=
 =?us-ascii?Q?cLI/SJfc0WggzUGkHQZ7Os5/W2E6jsn0ZOgoGTENiFz1gWQbEiZSXMe+Hm+k?=
 =?us-ascii?Q?udWIH5UbKtIteBUqCNIE3cd+aBs+MWC6KDC/WenTsVyDYJo2WoVQDCH26q4p?=
 =?us-ascii?Q?yHGMWfaVcrUHTNUWxR1drMh700ZY1NZSILtxqzOClAqYXFg5vKgSvnzjmNpJ?=
 =?us-ascii?Q?sIdkHUpFamiPTm10JGl+kmbrPnXunfrC2Rqi2mGhAP87gZXICIOKyUeTil9L?=
 =?us-ascii?Q?QdW/MyYK8u5NOtokcO+SmdEQfnhvC/22N72Ai+5ZQccRM8CCAae1sAHAjvaW?=
 =?us-ascii?Q?bRNRaYSuL7KqD35YjTvKTcmPRtU1rByBS1SaLIxLmPnvKxFWOtfniW6HARht?=
 =?us-ascii?Q?B0weA9fBc48i9ZNeW0mi9h71XVxhGsSZoIz+Lso9hgga9DZBqhi6rQ0Y7p5I?=
 =?us-ascii?Q?1K277k4SYOySJzaoRIdrDiFGw+oEgPp/TWOpktHRScXzZ9X3EWPISsWkVVll?=
 =?us-ascii?Q?OlFGxEAN1ur3NDs7YFHQpulFuKCpRpSxovyrGQAyh3rJ1+C1qzAX0+cuGU0D?=
 =?us-ascii?Q?qfRWy/flbAIvrJVkiO/7NuMxIp9cQIdW5Rzd9mNw8wdoOX2Gy/4np/Kno6YX?=
 =?us-ascii?Q?z54T3YpiCGqbZnA0fMo68ioD7YUEGs5ZMjDplhIOGNnjpVBpvbrTLYNhy2Mg?=
 =?us-ascii?Q?5gm9T/g94RqxhvWlzBJ3dL5ynMA6gCm3+NfTviezhJu5/fXZCFFkiSSs88ub?=
 =?us-ascii?Q?kgxaTxzHTsSJRzA0y1UiPtJgeCvAFJTK7e0lYERIXdgzwuo92it+az5fS+rI?=
 =?us-ascii?Q?qnXRA8wq34SDbP259KsXqAypGMizBwd8Q7nGdHJB0Uv/wK13d3IKqkC4qVq4?=
 =?us-ascii?Q?4BZ9Bqqgs7fdVO577V7gn1BKW907RjnYxHoearUpPP1MGEMm210j9xL7mf1C?=
 =?us-ascii?Q?zxRT9zRbhetjtLSECW364IilmuhNVXBxOlneI2i5uzeRiwWw0NJtlcDtr66w?=
 =?us-ascii?Q?7qxA6rnK224AiVLHSf+aCkzYBU3dOX23l568hLrPH09MYPDx4Rnv+ROPND8/?=
 =?us-ascii?Q?+DsJD10mR2UBcTzlvFEaKBdVnYAmLPFOkargFaijs5JTEG7zOZ2W08xrkYO2?=
 =?us-ascii?Q?NZR96ZyN1OMx66ljIz+/vJEMHNLVqh5jwiwnwmIdh0O4IqxOAd/eIRW0QGuS?=
 =?us-ascii?Q?8bDJeweZkmx9ytarVc7J0M/nF3/uZVZ8dqOWblY1mSP?=
X-Microsoft-Antispam-Message-Info: ++Mb/H0NbU3mjgaCUz+rqce7g51JXjon7M31vzL2oqQP0iT0ysYOIuPZxiJLjoJtIMB80gSrRcE9hWTPJB00DDJ/vCjhhYiDDPi8qToyeCuN2/dFuwzH4M3/RZ9s7osZvCpbdGYMVyIOcSPof1FUeatRs28Zdaqtf87CBxeHOSXcbz+PFW5JNW3h07MYoEol
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;6:McszboKb4UBWDkVIxuqFqwUVNF7r7vkfE+QZO08p30eJWdT7PVbWN99eAfWWhL5g66uUO1gvIIGUR4KzyJbohQPEQHwcKIkL+YmOLo4jkEwObczm/KaTm5pl7Is6YUpq4N+h+Qf4QlNYZqv5irJymb9i8DtI0D2ZYT4AB2G8R4GXoz6zFi5lnbe3V69pGc40XeArJChrorLpwaXZ8mnA+3xCAxAKVTNow+7zfjracOWmXal/weBWPRGlOzQSJIlfstsegeDpyZd8c5GUqJL/2MRey+FfS/kmCZRhch0+Qd7oPL81EE4Hq1znUq38pGjEyBlT/Lp8uCfVfizsgai32w40yp6GbkrdnrDd6QSprUx+G2KCBP4qSZZXcrYl3DxX7IJZPHkUZuwVcjR6H1pilOu+vZ202H+ZIaSHEnLvmfpG7kyzfqGKeFIJgL+TYxxHDIqeS7EfMj6yaffCFnRZpw==;5:ihpwM12pXOdqZf/9/X1msB6UG4GabPGS0HANhWxeg8oVSNO1C2Yk/jA8PWuEF2hzZKGUYqqDO6my4HckjCdsYmfJOZom7pIenFC75TaKI59SXZnSGZT00HCYjOPw2hmLlG3jhcnqeYgUlBa51hZTd09tHfkr7A7GVouenJBkEkA=;24:AfBylipBtF2K6n8HjZCiML3hfhx/TsIdgATA3cZbKAMq6n7CVYB33P/12v6ZiA5VMyc/iMSbNMXtxrHHc0p0BumsRuTLvJHX5myuHi3UA+w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;7:cKisIRzi9tUrQxP5/rHTt8xsbyghYCphbn9rrLqKgVG/mM+iH3SKKZVDWNJboVHNwfeK36t0rHqMw2a8EaMbPcQTn0+RN9WToffyyLmlXlQrcKzonehQLVsN82a6NfRRUlyhch7A8jdCqH+q7MmS7oVFmagfZ1MGeOhaP/GtvTRLxFRe7wDHENZZav6p0a4TvxTj88Clo8Spx0VW0YSoLkpHllnaDrKEvM4gkdOo8RvmcHzH2jKsmX8pGBHMTzq6
X-MS-Office365-Filtering-Correlation-Id: 4ffd7743-20d7-4bf2-839b-08d5ba97ccec
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 19:12:27.7735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffd7743-20d7-4bf2-839b-08d5ba97ccec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4383
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

