Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526459138-2-2121921519364394438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526459137; b=C67cZwcJxMuZYRtREo1xGbdnPpxtvrrj3BYoEULlouIWt9Hrrb
    s4twzQAimOCXTaLqc9zt2Qaq1zmw1BqavBNCyHmasqlaxvr1ciF79A6nV5wa2D7X
    ABvr+CYqJ5kPPDHGijwU8cj37Qt1qPjumQ19rd1fsEURLWDD7v88I1sv36KRRDwK
    c9OECvv4yNWr96TJgpj8ptXgkWBvUPFNJmnS1v1x1IBvTexr4+qvwhkhTl57a9P4
    Rh3NunoOovhysLKO7Brebtgw/GDnDU5/Q9L6xqsMdvNgeRUpvGMulnO6aGR25Mce
    t4DduUDA+1QAxot6URY5pBXJeUJrV+TqWUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459137; bh=Lk9jB3wuuaHapAe33lOI4fT7Rcqo4g
    rgWAKKzbjzoSw=; b=MZFEHZnoLTT5s14UyQwwrkL2AMPFAmGxCfyXm568srAgJF
    tnoBm0oM9bxEKCbPccy7voeResZG+SGNaCtNDl2pyj2XGLYTqOzh0aQ9hPFuN5XP
    7IfaYjw47zmMxd/G2UuLc/jlUcksO2Cv/7c68q3aSwWmezTmPV1gwiJ1fujhqriR
    j8scG5lvlVYhJG7bTM8xu0MIXmusHzEroLkSkDa7eKIQ7qRz8n17xaJH5Kl6CHWE
    BEIbPjuxTPNZKjHF0QuL+ODDdz03tCyS7lohBpePDlLJEQZaE6e6LOj3SFVXIXoT
    A46Kvz0xocAV2iPhJqXMxUJekU9eGazsUg3F7aLA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=eI9ERN9D x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=eI9ERN9D x-bits=1024
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
X-CM-Envelope: MS4wfLHC27KNnHv72OG9JtGPz4AUV5rVSaNtsGuEc7Ct2BxaSMKCJrSqCxvjadJyn/NFcT0X0P/WtRieH2klvr6264O0TwGg9INB6+g/5v8yr1greCxCmvFT
    JhgsRunknenAoZdPWvRn3NvxSzYd5+t7onunsn29vryDGGPzoU7H3LbtNnRaONsVWmcMsJakfNb/QpQxOHebTt7mmSQILmvnCMAw/E0h532B8INq+H0ok8Ep
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=Wv-htbZpDssA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=NXpJzYs8AAAA:8 a=enOvQawGAAAA:8 a=pGLkceISAAAA:8
    a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=F-5A-24V1V675pMYT0QA:9 a=x8gzFH9gYPwA:10
    a=cwV61pgf2j4Cq8VD9hE_:22 a=OuzhcWw_GC9nAYdNdRwA:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeEPIXh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:23:37 -0400
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:7499
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752489AbeEPIX1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:23:27 -0400
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
Subject: [PATCH 22/24] arm64:ilp32: add vdso-ilp32 and use for signal return
Date: Wed, 16 May 2018 11:19:07 +0300
Message-Id: <20180516081910.10067-23-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0131.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::33) To DM6PR07MB4378.namprd07.prod.outlook.com
 (2603:10b6:5:bf::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4378;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;3:YWvUNjIZyrQirRvveFejMbfBjRTdgJQrjuj/oSmTQ+Nu5Na4camjCfQDgeELZH0wCJ7aVdLHtZhpFNjoHHQgT0/UX+lJ+LOTFaRYik8QfNFVfeDZ+D5eqNqfW16HrKPRF1fWd5WnbXHlNk4mPvo4OmeLPgqRn+6kFZmFanOZNQMw5nF6p+KK8iOVfd3lX3qyEdrWebPH0frm94cDwW8K9GbciYI0bBmKHJVk+764bu7QIBr6P3OBQh29bSyyp/oG;25:4Uw3cGFioduAwCLg9OJ1jq5SBQs7fIG5C9pp9/BtwNim9/gYMxy0IbHOJLGGni/uEjI2+Pi23pAGUIVTdC75szCINxxfA5pa9cdzmcWu3lOMgl2pr2iOlD/oua+CXsl0vq7xwZRE624YuugThLxcnh4Ra1cOTNzTdbbQZoJf6NS03RmgkI6aG1hNNKpNUfalzPzcFskmFEuuMy2h8qqhB7bBTyV2Niho090o4IaniXfVQgioU2m/5YD10Hexh5A2M5ELI/c1uToZTCUCL928VXZEi+fw+cR+XBLC3Ot/cyVjKWbKbkWbU/6oOu4dXR/HpzAJ9tRIZcc4Bct7I98pqA==;31:3SRZsW+JGOA6t8Yu+DFAdCD2bSJujLzYkegdYuZ7sapKrYRd6CjmKW3fUQALI/EGfkhTgZUg2rGc2luBuffHNM9bxPeYGnWtP5Hy9RYNWOrjMNbJhFoLgfALdDgPmhnM/FGh07SfO6vgDk/78D9XPFb/uA52y1IGLvFzd0k+sSVbmzDY5qSjHDjEl6Yq15Kow+rylSjncELbqQIeUZwlRvQ+6N4eC+FAYPypfbC8Zzw=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4378:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;20:M54yt9ogmCcGBKUYrlhuggSAZSN1beOyZyAyu469OVueeZ4OfUkkM12L9Bn48eBbcAtw+bkmoAgHhYc58rolYEy1AxpPRq/KHKvqOaTDZMb9/S66GS9THL4hfh0JmU2Cd5N22uLOHezA6PvdvmvlapfBzTU9Fl05jpdU05FgNJVWDEMDMLb4UKgLJozyVJWh9y9Pg4mRjYnmHJxlHtkX/b6S2ww+BznjOP6uGFxXvQEuDa18Q/rL800fYD9QEsBazp7qWO8pGoYYywEoBEvOA1bCrYVG/NRzXQF06yN6UCc4vGW88MMHNn+LqmOP95Z5qTfYu9/iMkOULLl8m71Ir9rJwFtpKt41UB4gkG6iChMrYWudEd0Wqdxu0AWezjnQvVBv6FRiCG3XzvtjuFa8yC5F1sfwKhyDK+cneifSrga6IT8c1T9bWQG6624kErKMSj+kbqqo+ZYoeSr1bBLoQjp0PINXr8U+vGs2wGKAsE2kdltvEfOlCNuh4f+hcrM3D3S7tLNN4RU6qNeTpC94aXuHrYrmvKRZGoSkcK/1yzXgtTFRrl3Pg13cWAe/6TrJuEfOH2GZUe5iTCT7W862qTEmmm8+Kw+a/uKip5KrNOM=
X-Microsoft-Antispam-PRVS: <DM6PR07MB4378916BB34B6153CBD79196E3920@DM6PR07MB4378.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM6PR07MB4378;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4378;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;4:vmJEK0iHoDg3CzJQyfixBJWU/ouTl8JKr3NZt57Q78zcj3EJms1hgYDsaUiATkjnTvVaGjQeA4kdkW1IDOF1YGQX9NR5xwK3IGoh0t6SwfYy2izzAGdRM8pcavfOFxo0Xqt91REa1AMl1z2GeFY8MTcm3/lD5mDtVQoCO8O9S8hWt8siZJSeCZVI7s/dxGdD6b5mOjz8jmkJ26sdvPN+j0yOcZvQUtAlLts+0J+m2vAX1JUVjTPCBoJ3sOAhBvug3uw4dfiEDV16xE7Tb9X7ZoUtBXDBPZF5Z4JMm9jrtZ97AblafMpviplGvN4dJ13cKKH1oaKdj+7obCnYjJxXxg==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(199004)(189003)(76506005)(42882007)(54906003)(478600001)(72206003)(4326008)(51416003)(25786009)(53936002)(52116002)(6496006)(476003)(2616005)(11346002)(446003)(956004)(316002)(486006)(106356001)(36756003)(7416002)(5660300001)(16586007)(105586002)(110136005)(305945005)(97736004)(6666003)(7406005)(8676002)(6486002)(81166006)(81156014)(68736007)(48376002)(50466002)(7736002)(8936002)(6116002)(50226002)(16526019)(66066001)(39060400002)(575784001)(47776003)(1076002)(186003)(76176011)(386003)(2906002)(3846002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4378;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4378;23:BXnF6F+xEm5BExvneyZGZdwuzeXD5Q1LEQEAuG70b?=
 =?us-ascii?Q?h5GNH1JALBuqTFZTYe5JLWDuio1pt480Tg5sDDXJtThPzgfh/4KcT0+znvON?=
 =?us-ascii?Q?NSBGoFhPLOWsg/4DYBEitWno/As6+HUy+l4+no5QfNutcZhyMTahsPBvk674?=
 =?us-ascii?Q?xHFOuSzWlRw6mWS1O+iIDijmGnS4fewc0fS7kw90sWfF4iUtfmsIrQYvct58?=
 =?us-ascii?Q?Tc8BpGGsUaHC2NuVNvPN8EvQH7DOxdO4N2Mq5TEaegHw1pjyoqQnPBHe9sQs?=
 =?us-ascii?Q?IE09dt3jBSdB59uu+xNLHAeoOQo87fC4ElyERuaWWDWhAdgqk4eKIBmqeHeA?=
 =?us-ascii?Q?TC99glwFRgl2ILMBH/d/iO3/9wL40yhxugl+ncPPxH1TGO+j7H32/WPm22Vw?=
 =?us-ascii?Q?w3V5IU9BkEFhfioaKYVoW4u1hPvSfOYsC+0DUpIFh0nS+F9w3Tk2ywIqPQTB?=
 =?us-ascii?Q?9k+p3hR+rI33pdXxXiAQYzu/JLRbFalL/xLNIj0pwvlP6qbWbbHY+2GDfkMT?=
 =?us-ascii?Q?zO9meRZwhpAruzo+55ba7jIhJpHPBICTNGu7e+OHzbI3LbSLKWadpQvDWBzY?=
 =?us-ascii?Q?3hybiTb3wtRITBGU1yD8EmzaNYhuyyZ0rdsfFp5j/LTVgSraEDZH51wTRAtM?=
 =?us-ascii?Q?YGgv3LYaY+RyaTOziltmhvA60FhizkyPEQtxwsHDs87IdIuoPhSW0Mr9vI9g?=
 =?us-ascii?Q?x6BW/BP27NtJAeAk2ocmls6LuT5Nu3xhD5H19ipAUnQg0PeX4XzTIE/qtJnF?=
 =?us-ascii?Q?0EKQZ/x2ONLsBhAXw7SlarQLxq7STqJwLyDb6XniUKNJnZRoB6iO8G2RgVWm?=
 =?us-ascii?Q?piAhQzGcnXcLqWDTRGYwu7C0P0fhPf+GhqgXBSBrnMKQEU2MSTe76T7hCRov?=
 =?us-ascii?Q?C2MeX6NAEhq32ZIR7nCRplAFD/Q9W0Yy63r23eAvU9EdLhJTHlskQTRh23dl?=
 =?us-ascii?Q?X9B3tMmmoMZTU7RKW4nymtDZdjJLEfZMPUfA2zv4qgrQH9aWkYevMCO2TGmj?=
 =?us-ascii?Q?8T0QxyXx27PMniWAJ/zrZthGUl5xOOViJYbrSNTgIWbYL+HeoGKQddAkl7P7?=
 =?us-ascii?Q?mrgdx0cFP1WBwBpYjYe/mccxQfSCa4L5GbFqnY3HlWgitpGVSGlCXJnn1Rgg?=
 =?us-ascii?Q?jWR8OvRstJ8SwuEXHYuJkMFNyY400CFc4lH9y7y4+4ytVvfufstC4bSpd2cK?=
 =?us-ascii?Q?8466KNuhTtVvl69XpNqEPpRVzwuzmM88oLna7XmYyRrDBtLUYhctsR7O5/EK?=
 =?us-ascii?Q?0Rbi4+uBebVUoqQqtKOsPFs83WsPNcvFePyew8A4wxr0OjdTK8Vu6FlUkskS?=
 =?us-ascii?Q?8TMwDeNz/Ezi8/RdubIBk5RxlWzzvzBNuUsWcL2Rz4o0U4O1ilhNhc+HDNs3?=
 =?us-ascii?Q?b4iNw=3D=3D?=
X-Microsoft-Antispam-Message-Info: eCURBSSNXv9DEy9jPI+gXP4KIC73GW8StdRdBqw/TuEsLeXDhlAAd0/KQWo3wzkAckLJU4OjURbgb3lNscWVPBvm3PIh+aFvvFhXeH2ca+gbkdUrX3oGZ9KN0d4NsrZRA7mN8M9lOieufEiY6+0YWWPW0lHjjp9lv1VHaqXLbhQEpEElgXiwDBOjwHxeo/pb
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;6:4G6pjrzQMFmsc+CwIARUqLS/heqKqPxGURAhE5jdnenAIji2qGmfVWN6oGYcowepm3VbZJOdz2f4XududHYBpS5PYupkgWiGYgLJ26eCWljBuaMewCYE1AW3cR7HU7KyXLMVhyUCIy60vCcAkp+Q0gHkNPA0gzREJ/p3QEEthU+a0aqn5ePIK3xXlbaSNXeTbW4mfrUWOwLysp4U1K83PMnfJq8UxCJlf6loKfFttmCmsSEq9IGnqd19Y8y4q0ouV9/x156p6JIHJuVAY0yr6ZbCCVhXGw/Nryumui7iGMU2RSN3nViTIXrvFJwBUBACQoMwuVuLCUU+UyGYCK2NzONYy0CFJHyY4N/+jBcoqz1CXWX8APkFt7KScyKYYHMV2ifdMdOJUYFgcF4R+7OBAw6BZFZs9k2qrc82KYSsYnBkm3eLAUbPFWoc1uTgY1Irkwi0OZyZ2H3ij1c6L0dTDg==;5:ezL6rNoBkz7VaDp6uZkDyUptastt/dV1NfWG27SyMT8TFHiNwzv/aeIeq7KHZ2RR/tZ7wFT0tHoRqLg0rQhc63eluL9jLN6t8URgDdfwcgXcj8EQ6/3RRYZ9XyTtVh+F2S4kHdQolXePqHDJs12eS3EbFeue5uhicTLapMAqDPc=;24:oLvt2u/Tom3WwS/32bVCk9ZP3xn4D2dhbyqlMNhNcYxVtmBGIyqEKAO6LVO4VZnEKGllIcn7SHzgN0TDpxKbzPnV7BppnXgc5MzOQkeiBA4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;7:MLtwVvIza/et+GTs1vk83q3zxhhwMdsyQ/+wrSOv8Zw/dj5yPpoDhX+AU0OI6fkgAPEyhri1xi6L2jAe2YtFrg1dthVWjLgDXC8fJp9ScDw6wkf4hok2ZGIv4oeRxUG8qW8ymVVXKBfuHSJX3ICszy+rBW1STFhw6P0FbEw6QKcQ9FBRCcRHQUs+MqTKHVGfHqEdqOvu3ZoFtDEJUewDgpWgTkGWfEmdDaIYSBjnClb+p+4jVf3ml+zzEDinERvW
X-MS-Office365-Filtering-Correlation-Id: 96ad3497-7e7f-4d89-7007-08d5bb064b50
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:23:24.3366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ad3497-7e7f-4d89-7007-08d5bb064b50
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4378
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

ILP32 VDSO exports following symbols:
 __kernel_rt_sigreturn;
 __kernel_gettimeofday;
 __kernel_clock_gettime;
 __kernel_clock_getres.

What shared object to use, kernel selects depending on result of
is_ilp32_compat_task() in arch/arm64/kernel/vdso.c, so it substitutes
correct pages and spec.

Adjusted to move the data page before code pages in sync with
commit 601255ae3c98 ("arm64: vdso: move data page before code pages")

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Bamvor Jian Zhang <bamv2005@gmail.com>
---
 arch/arm64/Makefile                           |  3 +
 arch/arm64/include/asm/vdso.h                 |  6 ++
 arch/arm64/kernel/Makefile                    |  1 +
 arch/arm64/kernel/asm-offsets.c               |  7 ++
 arch/arm64/kernel/vdso-ilp32/.gitignore       |  2 +
 arch/arm64/kernel/vdso-ilp32/Makefile         | 82 ++++++++++++++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     | 22 +++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S | 84 +++++++++++++++++++
 arch/arm64/kernel/vdso.c                      | 61 ++++++++++++--
 arch/arm64/kernel/vdso/gettimeofday.S         | 20 ++++-
 arch/arm64/kernel/vdso/vdso.S                 |  6 +-
 11 files changed, 280 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b481b4a7c011..55fb91420ebc 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -160,6 +160,9 @@ archclean:
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+ifeq ($(CONFIG_ARM64_ILP32), y)
+	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso-ilp32 include/generated/vdso-ilp32-offsets.h
+endif
 
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 839ce0031bd5..33a4e10014aa 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -29,6 +29,12 @@
 
 #include <generated/vdso-offsets.h>
 
+#ifdef CONFIG_ARM64_ILP32
+#include <generated/vdso-ilp32-offsets.h>
+#else
+#define vdso_offset_sigtramp_ilp32	({ BUILD_BUG(); 0; })
+#endif
+
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
 	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 27ddf5369f89..6510dad702d0 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -62,6 +62,7 @@ arm64-obj-$(CONFIG_HARDEN_BRANCH_PREDICTOR)	+= bpi.o
 endif
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
+obj-$(CONFIG_ARM64_ILP32)		+= vdso-ilp32/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index a416c2333e2f..54c9768dd964 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -124,6 +124,13 @@ int main(void)
   DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
   DEFINE(TSPEC_TV_NSEC,		offsetof(struct timespec, tv_nsec));
   BLANK();
+#ifdef CONFIG_COMPAT
+  DEFINE(COMPAT_TVAL_TV_SEC,	offsetof(struct compat_timeval, tv_sec));
+  DEFINE(COMPAT_TVAL_TV_USEC,	offsetof(struct compat_timeval, tv_usec));
+  DEFINE(COMPAT_TSPEC_TV_SEC,	offsetof(struct compat_timespec, tv_sec));
+  DEFINE(COMPAT_TSPEC_TV_NSEC,	offsetof(struct compat_timespec, tv_nsec));
+  BLANK();
+#endif
   DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
   DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
   BLANK();
diff --git a/arch/arm64/kernel/vdso-ilp32/.gitignore b/arch/arm64/kernel/vdso-ilp32/.gitignore
new file mode 100644
index 000000000000..61806c3fd68b
--- /dev/null
+++ b/arch/arm64/kernel/vdso-ilp32/.gitignore
@@ -0,0 +1,2 @@
+vdso-ilp32.lds
+vdso-ilp32-offsets.h
diff --git a/arch/arm64/kernel/vdso-ilp32/Makefile b/arch/arm64/kernel/vdso-ilp32/Makefile
new file mode 100644
index 000000000000..e372740e43b5
--- /dev/null
+++ b/arch/arm64/kernel/vdso-ilp32/Makefile
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+#
+# Building a vDSO image for AArch64.
+#
+# Author: Will Deacon <will.deacon@arm.com>
+# Heavily based on the vDSO Makefiles for other archs.
+#
+
+obj-ilp32-vdso := gettimeofday-ilp32.o note-ilp32.o sigreturn-ilp32.o
+
+# Build rules
+targets := $(obj-ilp32-vdso) vdso-ilp32.so vdso-ilp32.so.dbg
+obj-ilp32-vdso := $(addprefix $(obj)/, $(obj-ilp32-vdso))
+
+ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y += -nostdlib -Wl,-soname=linux-ilp32-vdso.so.1 \
+		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+
+# Disable gcov profiling for VDSO code
+GCOV_PROFILE := n
+
+# Workaround for bare-metal (ELF) toolchains that neglect to pass -shared
+# down to collect2, resulting in silent corruption of the vDSO image.
+ccflags-y += -Wl,-shared
+
+obj-y += vdso-ilp32.o
+extra-y += vdso-ilp32.lds
+CPPFLAGS_vdso-ilp32.lds += -P -C -U$(ARCH) -mabi=ilp32
+
+# Force dependency (incbin is bad)
+$(obj)/vdso-ilp32.o : $(obj)/vdso-ilp32.so
+
+# Link rule for the .so file, .lds has to be first
+$(obj)/vdso-ilp32.so.dbg: $(src)/vdso-ilp32.lds $(obj-ilp32-vdso)
+	$(call if_changed,vdso-ilp32ld)
+
+# Strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# Generate VDSO offsets using helper script
+gen-vdsosym := $(srctree)/$(src)/../vdso/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+define cmd_vdsosym
+	$(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+endef
+
+include/generated/vdso-ilp32-offsets.h: $(obj)/vdso-ilp32.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
+# Assembly rules for the .S files
+#$(obj-ilp32-vdso): %.o: $(src)/../vdso/$(subst -ilp32,,%.S)
+#	$(call if_changed_dep,vdso-ilp32as)
+
+$(obj)/gettimeofday-ilp32.o: $(src)/../vdso/gettimeofday.S
+	$(call if_changed_dep,vdso-ilp32as)
+
+$(obj)/note-ilp32.o: $(src)/../vdso/note.S
+	$(call if_changed_dep,vdso-ilp32as)
+
+# This one should be fine because ILP32 uses the same generic
+# __NR_rt_sigreturn syscall number.
+$(obj)/sigreturn-ilp32.o: $(src)/../vdso/sigreturn.S
+	$(call if_changed_dep,vdso-ilp32as)
+
+# Actual build commands
+quiet_cmd_vdso-ilp32ld = VDSOILP32L $@
+      cmd_vdso-ilp32ld = $(CC) $(c_flags) -mabi=ilp32  -Wl,-n -Wl,-T $^ -o $@
+quiet_cmd_vdso-ilp32as = VDSOILP32A $@
+      cmd_vdso-ilp32as = $(CC) $(a_flags) -mabi=ilp32 -c -o $@ $<
+
+# Install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso-ilp32.so: $(obj)/vdso-ilp32.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso-ilp32.so
diff --git a/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
new file mode 100644
index 000000000000..dee65ab79662
--- /dev/null
+++ b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/*
+ * Copyright (C) 2012 ARM Limited
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/page.h>
+
+	__PAGE_ALIGNED_DATA
+
+	.globl vdso_ilp32_start, vdso_ilp32_end
+	.balign PAGE_SIZE
+vdso_ilp32_start:
+	.incbin "arch/arm64/kernel/vdso-ilp32/vdso-ilp32.so"
+	.balign PAGE_SIZE
+vdso_ilp32_end:
+
+	.previous
diff --git a/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
new file mode 100644
index 000000000000..9f14666feef7
--- /dev/null
+++ b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/*
+ * GNU linker script for the VDSO library.
+ *
+ * Copyright (C) 2012 ARM Limited
+ * Author: Will Deacon <will.deacon@arm.com>
+ * Heavily based on the vDSO linker scripts for other archs.
+ */
+
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+
+SECTIONS
+{
+	PROVIDE(_vdso_data = . - PAGE_SIZE);
+	. = VDSO_LBASE + SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text	:note
+
+	. = ALIGN(16);
+
+	.text		: { *(.text*) }			:text	=0xd503201f
+	PROVIDE (__etext = .);
+	PROVIDE (_etext = .);
+	PROVIDE (etext = .);
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.rodata		: { *(.rodata*) }		:text
+
+	_end = .;
+	PROVIDE(end = .);
+
+	/DISCARD/	: {
+		*(.note.GNU-stack)
+		*(.data .data.* .gnu.linkonce.d.* .sdata*)
+		*(.bss .sbss .dynbss .dynsbss)
+	}
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+	LINUX_4.12 {
+	global:
+		__kernel_rt_sigreturn;
+		__kernel_gettimeofday;
+		__kernel_clock_gettime;
+		__kernel_clock_getres;
+	local: *;
+	};
+}
+
+/*
+ * Make the sigreturn code visible to the kernel.
+ */
+VDSO_sigtramp_ilp32		= __kernel_rt_sigreturn;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 440fe2652d4a..a37342ed1503 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -37,8 +37,13 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-extern char vdso_start[], vdso_end[];
-static unsigned long vdso_pages __ro_after_init;
+extern char vdso_lp64_start[], vdso_lp64_end[];
+static unsigned long vdso_lp64_pages __ro_after_init;
+
+#ifdef CONFIG_ARM64_ILP32
+extern char vdso_ilp32_start[], vdso_ilp32_end[];
+static unsigned long vdso_ilp32_pages __ro_after_init;
+#endif
 
 /*
  * The vDSO data page.
@@ -114,7 +119,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
 	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
-	unsigned long vdso_size = vdso_end - vdso_start;
+	unsigned long vdso_size = vdso_lp64_end - vdso_lp64_start;
 
 	if (vdso_size != new_size)
 		return -EINVAL;
@@ -124,7 +129,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
+static struct vm_special_mapping vdso_lp64_spec[2] __ro_after_init = {
 	{
 		.name	= "[vvar]",
 	},
@@ -134,9 +139,23 @@ static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
 	},
 };
 
-static int __init vdso_init(void)
+#ifdef CONFIG_ARM64_ILP32
+static struct vm_special_mapping vdso_ilp32_spec[2] __ro_after_init = {
+	{
+		.name	= "[vvar]",
+	},
+	{
+		.name	= "[vdso]",
+	},
+};
+#endif
+
+static int __init vdso_init(char *vdso_start, char *vdso_end,
+					  unsigned long *vdso_pagesp,
+					  struct vm_special_mapping *vdso_spec)
 {
 	int i;
+	unsigned long vdso_pages;
 	struct page **vdso_pagelist;
 	unsigned long pfn;
 
@@ -146,8 +165,10 @@ static int __init vdso_init(void)
 	}
 
 	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
+	*vdso_pagesp = vdso_pages;
 	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
+					vdso_pages + 1, vdso_pages,
+					vdso_start, 1L, vdso_data);
 
 	/* Allocate the vDSO pagelist, plus a page for the data. */
 	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
@@ -170,7 +191,22 @@ static int __init vdso_init(void)
 
 	return 0;
 }
-arch_initcall(vdso_init);
+
+static int __init vdso_lp64_init(void)
+{
+	return vdso_init(vdso_lp64_start, vdso_lp64_end,
+				&vdso_lp64_pages, vdso_lp64_spec);
+}
+arch_initcall(vdso_lp64_init);
+
+#ifdef CONFIG_ARM64_ILP32
+static int __init vdso_ilp32_init(void)
+{
+	return vdso_init(vdso_ilp32_start, vdso_ilp32_end,
+				&vdso_ilp32_pages, vdso_ilp32_spec);
+}
+arch_initcall(vdso_ilp32_init);
+#endif
 
 int arch_setup_additional_pages(struct linux_binprm *bprm,
 				int uses_interp)
@@ -178,8 +214,17 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	struct mm_struct *mm = current->mm;
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	void *ret;
+	unsigned long pages = vdso_lp64_pages;
+	struct vm_special_mapping *vdso_spec = vdso_lp64_spec;
+
+#ifdef CONFIG_ARM64_ILP32
+	if (is_ilp32_compat_task()) {
+		pages = vdso_ilp32_pages;
+		vdso_spec = vdso_ilp32_spec;
+	}
+#endif
 
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
+	vdso_text_len = pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
 	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
 
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index c39872a7b03c..9aa415098e0e 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -25,6 +25,16 @@
 #define NSEC_PER_SEC_LO16	0xca00
 #define NSEC_PER_SEC_HI16	0x3b9a
 
+#ifdef __LP64__
+#define PTR_REG(n)	x##n
+#define OFFSET(n)	n
+#define DELOUSE(n)
+#else
+#define PTR_REG(n)	w##n
+#define OFFSET(n)	COMPAT_##n
+#define DELOUSE(n)	mov     w##n, w##n
+#endif
+
 vdso_data	.req	x6
 seqcnt		.req	w7
 w_tmp		.req	w8
@@ -119,7 +129,7 @@ x_tmp		.req	x8
 	.if \shift == 1
 	lsr	x11, x11, x12
 	.endif
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
+	stp     PTR_REG(10), PTR_REG(11), [x1, #OFFSET(TSPEC_TV_SEC)]
 	mov	x0, xzr
 	ret
 	.endm
@@ -136,6 +146,8 @@ x_tmp		.req	x8
 /* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
 ENTRY(__kernel_gettimeofday)
 	.cfi_startproc
+	DELOUSE(0)
+	DELOUSE(1)
 	adr	vdso_data, _vdso_data
 	/* If tv is NULL, skip to the timezone code. */
 	cbz	x0, 2f
@@ -160,7 +172,7 @@ ENTRY(__kernel_gettimeofday)
 	mov	x13, #1000
 	lsl	x13, x13, x12
 	udiv	x11, x11, x13
-	stp	x10, x11, [x0, #TVAL_TV_SEC]
+	stp	PTR_REG(10), PTR_REG(11), [x0, #OFFSET(TVAL_TV_SEC)]
 2:
 	/* If tz is NULL, return 0. */
 	cbz	x1, 3f
@@ -182,6 +194,7 @@ ENDPROC(__kernel_gettimeofday)
 /* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
 ENTRY(__kernel_clock_gettime)
 	.cfi_startproc
+	DELOUSE(1)
 	cmp	w0, #JUMPSLOT_MAX
 	b.hi	syscall
 	adr	vdso_data, _vdso_data
@@ -296,6 +309,7 @@ ENDPROC(__kernel_clock_gettime)
 /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
 ENTRY(__kernel_clock_getres)
 	.cfi_startproc
+	DELOUSE(1)
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
@@ -310,7 +324,7 @@ ENTRY(__kernel_clock_getres)
 	ldr	x2, 6f
 2:
 	cbz	x1, 3f
-	stp	xzr, x2, [x1]
+	stp	PTR_REG(zr), PTR_REG(2), [x1]
 
 3:	/* res == NULL. */
 	mov	w0, wzr
diff --git a/arch/arm64/kernel/vdso/vdso.S b/arch/arm64/kernel/vdso/vdso.S
index 82379a70ef03..a40ae2485430 100644
--- a/arch/arm64/kernel/vdso/vdso.S
+++ b/arch/arm64/kernel/vdso/vdso.S
@@ -21,12 +21,12 @@
 #include <linux/const.h>
 #include <asm/page.h>
 
-	.globl vdso_start, vdso_end
+	.globl vdso_lp64_start, vdso_lp64_end
 	.section .rodata
 	.balign PAGE_SIZE
-vdso_start:
+vdso_lp64_start:
 	.incbin "arch/arm64/kernel/vdso/vdso.so"
 	.balign PAGE_SIZE
-vdso_end:
+vdso_lp64_end:
 
 	.previous
-- 
2.17.0

