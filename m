Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526459424-2-15120063750079693982
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
    1526459424; b=Ke7tgog2oINUUetFiGmJAWvegg5g4CgJLFCpdrDNmQThq/vUFY
    UAESt4m7d2EfiTlBpO41CFfFOXpxgPdNyTonhIOffMk76u7O0iLqpnb9QJsvf9i1
    lSRKOIKIwq+CFAO3xw44IF0o43NfxuydYFMPp56hr5Q0mX8wMyaq6bt6JkqpfCxw
    Gld/f3HiDFWNEiPVfKAlgZMHdvuJ/lIiE836fioXuIrhky5POMeDAdLvi5VjCosh
    wvzKsMNenyhpjhs5p16vxALpLEAPvy2vNplFcjThQNUbeSTLcMtxVH3L0fqYxNyZ
    mhDhjqiCZ9dwTgm60ZeZ/1E9ortx7rVovnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459424; bh=D1HYBg3AoJKuZGhuIloAczDUX42KQL
    xBuXMq6BTmaBc=; b=SEaEpBy/1qBZqZffpGqq2qkbQWvPxl2LeieFCCdQ+rZkp8
    pWZe1TzOoNBK4N+/lKVUX5UPqEaqviR7JdOfI6oNVM17g4XRIRktgqeFVhjsYW16
    Ld9htxLhALAPdiMRBg1HM9tH3T0+sjGG0cr/B/eOARr0jLKmAbanKP5JfU4TnXI6
    4VT8+AlSvX1EXDj1+5CioDGwf8JMm2guJimhgXgLniWbAAZI+tKdgnvA6RTqEhyj
    ejzAv2f3Io8+TkA/iTqhwiJVO473MT9KyzwWSdjN8eMMKAFTLaL9O2m+Y8S/25OL
    1ML1WBTeR82rTQW654LnsNQUm1C8ZMrVh+HoAVHQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=RlxX3Dq9 x-bits=1024
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=RlxX3Dq9 x-bits=1024
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
X-CM-Envelope: MS4wfL8X9ArC+3TSwgtbxqNGRZViUZxFI9uRgNPoEccO2twy1IKi5k4nzzXGaWCTlyrjUwu1fGXQtr5QjBakw7fJxCJct1njMiVTGZZocVv2J161Xab4Rva3
    nyHBeCvmqpLVsjiXkRwZJUbLzaKqsOLuRJvDWP4YT8Ser2RGx4a0adPWjxO9G9lPDYiR4vfRLHOGPIzW3X716parFXj3aCRCpv3gqgfk4/q3Vuy2CI0F2cio
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=Do-GKD8o6ikA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=7CQSdrXTAAAA:8 a=6rqHouBjAAAA:8 a=enOvQawGAAAA:8
    a=VwQbUJbxAAAA:8 a=yBqWpnd-oM1zklYVj-wA:9 a=x8gzFH9gYPwA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=Hx1yvPaMooE3kwe23bt7:22 a=OuzhcWw_GC9nAYdNdRwA:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeEPIUC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:20:02 -0400
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:19376
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752336AbeEPIT5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:19:57 -0400
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
        Andrey Vagin <avagin@openvz.org>
Subject: [PATCH 02/24] ptrace: Add compat PTRACE_{G,S}ETSIGMASK handlers
Date: Wed, 16 May 2018 11:18:47 +0300
Message-Id: <20180516081910.10067-3-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0125.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::27) To DM6PR07MB4377.namprd07.prod.outlook.com
 (2603:10b6:5:bf::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4377;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;3:vk0SZNRX/Bl5w23En1R4/C97CRgfGel6F0Rg4VCoGXNJdBrtM01pYBnfaCA0hBPFlNjltqYajaZGA34x7GjVZM8qZv92XEVx07icF9yuBCn4SZZ82GDYfCY8+GvKFjRkY4CqtD8Bhq84L78lyT+pXUV/sVLz19rpB17hQ4EbjOO5ltCgLQXaZpDQT7+NqCKvNxyYKXKTbbeElfjwM8GpTdJ0af8OI/NGX/sPDu5kQIW6ATn+wFxr2SXCA1Fuz4Lv;25:WcN8Qyx+xSGZ3Xjz/zRfP/yYy2J6ThbFxesFMkvi4vzI/AzA8RisuxOonq5C3shlbOa+0+0PB28sz1JiNW/2Wj+zo7qDCsNZ6ifU5GR4YuCftQp+/beccWzKYH+buxP6oxZSaMuwXooV4YvU2y34q9ic11fs1iWIcso60tNmQPCH9AXypPSD7skMO3ejf47LoPFMYKoMRrlbJ0RhfNvbZBM1J56S+oL379srnmTdFg+GFUjZ/mcJCaiKwqE1/CCpgm/7QaS/feNVb6w25oG0PHHl1b0oOmqJpEKTtkOfYxbkJg18tqOwh7XkgcUkCSUijsV4O7IV8Ps4a97XXMpVKA==;31:NIPZyFnJ/PH33SESOzA9agOYyvTUCx6X02eavZ3lzZf0lMqdWOxI38YVFNQ9F6xJ7CdxWzut/FTI2jsKDamE11dr+D11dpZXbZF8DZqLBKyMQUAjU57sv2PAUWaEQso5QFMG+iMAzSRnOlwY9sloVs1AMfOuq5RW/IFp6GzoV0KRYx1RQfujZcGAhBEnsLWW3PYRzPdgriMt+F6JndxBoqY1Q0PmOSQeTWfoM1rQttg=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4377:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;20:rEeJ6ey8/t/R7RKsNXUhxNPG/MDwxPuMFPKOvNXEDouIfmQ30I2JzeIK2a9BITOGsFegNkFDRJb0WRToQvO2OGQ6vxdiodOu9fQ/KEMkmZ0136bGWq875PxMjHlVGCzuz/2gP1HUJmNGQ/rp4SuqZAWRF1Q/Ol3P1Pg2oNxP9dPZBl0Yg+/WgyEpiUTTXRUrMOuLJ6z+fpyXp0biDEBB8Xb9bRpG8ZgWxnLmp4wV1/vUswA+5TVUziqW+zbxXJVJvd4oA1iTkdAa2FB7En3sPkpfXCK2HywCPel6NjWzOxMuEAksKJjBza7PbqupquCiTJeQ/8+ypdlPm7cEQ73h/U1yHNd9iNMArhEnDMY7tG6u9JH98q08FPQG7f4mHctHJiVj/SkSH0REyUfAGOTR0+FwTL+Dkt2aTuNM25NPJYyDyJHtVG0CAcadkQ/naynE1LUUDtAo0I2L0HHLAKcYvx9ENyqYD+fr0ICno1zgbOVrFOkfJoaK/hHA+exRu25rymtRIblmH7iCH1ZoA3XLuqjGd+uvRfQjo23QGt3fcnl6CzefQ87xpKb52mT9Mp447QW6rAhHnClNz5So0CsxwLdVuP+vl2tzieXDEcirmMM=
X-Microsoft-Antispam-PRVS: <DM6PR07MB4377408797D1B46974A9CEF2E3920@DM6PR07MB4377.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM6PR07MB4377;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4377;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;4:/EGg6UkwBMbLkfmRTxROhSkxox/Aj4lThnIzXTbE4EPkD0sw8zQQ4NP9vCGsRyp2Qh1xZkVoK67vTukamnmfrdPHFxefV1sofqzVyrxqi8lupcG7vzZ9qxYoJl+MIaDY3+NqJpjB9/VIhPhF+gxWsjMPw9xXZIBGmYllpchJ7Q3+F2Hr/xnIcWK6d3xsZYBbIbVVISihf9hSV42DmEfF+ci7hhCpMzQ3zRF4gnDxSaxYnNGgN03tqg+CJcrcSmLUzUuEOBqy5RHNkDokaeEbwXPwMIsRuZim5jPlIQL0wKptKpyIwVmMkEWihQvBeoHe+B2RfwbehgCTz/C+kO8w7A==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(346002)(39380400002)(366004)(39860400002)(199004)(189003)(7416002)(76506005)(2616005)(8936002)(53936002)(6496006)(476003)(956004)(81166006)(81156014)(6666003)(8676002)(36756003)(66066001)(6486002)(5660300001)(446003)(105586002)(7406005)(106356001)(47776003)(68736007)(11346002)(39060400002)(76176011)(2906002)(6116002)(3846002)(26005)(1076002)(48376002)(50466002)(486006)(386003)(186003)(72206003)(305945005)(59450400001)(16586007)(316002)(97736004)(50226002)(42882007)(110136005)(478600001)(25786009)(52116002)(54906003)(51416003)(4326008)(16526019)(7736002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4377;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4377;23:9+YVdn3yTwmSxEu24nJn7urZq6BEPQqJLwuUBkKYj?=
 =?us-ascii?Q?UpSKF+wCw/aYhc0tQDobwgeHx/VJ423FPTIKh4vymMFOY0iqvDCTdMgntvqo?=
 =?us-ascii?Q?SWyTXZR7mwQEg15pBxyO8F7A60GoyJQDOJBOrwMm/69g9hA4HOpCvdbD/hjQ?=
 =?us-ascii?Q?xfM6++HNtQh8ZBGs7us+UVvGHwFcwc41uWkmrLrox6RPYFE1RPjiUZ1V38R9?=
 =?us-ascii?Q?TkksOcTGwBfuxcrOTp6cNXf7TTfkhfVskbQxOQZL+HkKc6I4h0+M6XkDBo/N?=
 =?us-ascii?Q?/3iF6PdmQJyDyLbFUmN4YJna0+qtjTUMxH8eeTGcISoc5H4IG7aXL3rq5PnF?=
 =?us-ascii?Q?VXcdyHpQ/nILKbbgmnPWhjKKTe2gOIbIQunQVtJIfp0tyutDS33Z7Ld4DhBc?=
 =?us-ascii?Q?tAxMHaC7AOGRw0mAq1m2jzgK9na1jO0NxRS3VMC3CAS8bj5s3GiTl5SMNOC0?=
 =?us-ascii?Q?L8TVUrQd4rKovz1OmVJJPFe1Ixcy1UyHDUDPEEOjKq1kZGamc7woxBSGX9LC?=
 =?us-ascii?Q?jkSZTrSOLizz9X0ijcfLOVGRcnCFpkohfqAQ4aj+VEXbTGx37aOyVzDWgZS0?=
 =?us-ascii?Q?0htwv9JNOCfybnHHmRJoi1nLqZ9Q87vTha7hMTnnY4EWky7K6ukEGqXceEM0?=
 =?us-ascii?Q?DFwq1ACwT7uaeAtckewlmD37J3LfpMBOj+CBVmnDHdyvUEIFb8JBBEBty3uq?=
 =?us-ascii?Q?ffwOHr8BhIzo/Edx6zMi4D43OT90LDa6r6y80KRnOJ0L18kSFF4kJxrW0A7L?=
 =?us-ascii?Q?qFVGnlrrUKsjTQiS/h3sRlsPI5ayUJMYd+HCtw2uboFV4RzusCpyfFEvr/dQ?=
 =?us-ascii?Q?mrn6NubN5/X1ZPh64mjUMkd+dfr+9pU1OBFmLha8yIMnkpyxpe6nd512wX4e?=
 =?us-ascii?Q?MraIDReeEW0shiI3KE4zG62eeg4CtzCUrZLgPTc2VfiKEkHkkd+eA2GI3EmG?=
 =?us-ascii?Q?s48X3vivhwvhlCVp7T4KX+cmwHFkI+BPSrGH3l7OweERcb3pywdFC9xRvVhH?=
 =?us-ascii?Q?2JDZswlL35j782jZ7WajgYnpeZ9tkzDkNEKN9eO1hfIvGq+i912iBtYBguqY?=
 =?us-ascii?Q?Eb9UJE3izbYe1rFiw1VACQ01I3iesR3Y7r9tA0EDBDRljHy2iQ0OUle1jbUG?=
 =?us-ascii?Q?0qlXtrgJUmcLXjHat82PxJeamjZuF3XPv0faFadKK0B8MrhkQRHsScpA19gl?=
 =?us-ascii?Q?4FoWCxacQltzsuSiu5po/Spe8ZirUwPgG3+fUvom1eWWBWox71qJDXcWfe+X?=
 =?us-ascii?Q?UHCUaF291+/OTWhSZOpyEPCQADceJNvslQCgVLhPvLQVhdFMm2hGXln0avGs?=
 =?us-ascii?Q?3TntFcj/KvqL/AJZOLaEirdjx3/xVG2Hn/u3x4cnUKdR3fp8j///99p1sy08?=
 =?us-ascii?Q?qCILpteEvyKMPyYx54U4gxoClk=3D?=
X-Microsoft-Antispam-Message-Info: 5es12gOwhtxR8irWKPhEaNQIkiyCu8Nwi4esozORdEH3mPq8vfBbw6gX/X52wqWbZs+uIBpsqE7BXYZONHd9SNQx4p/wEeDTYtKpZMsoEAYT+uR2mzdqHLOCBOb6sEyftu4L7klr3Vd3LaQz9k2WByvfzlyTvURP5PyQ7zqbbz2bSEwAbGWaqOwNvAqKdZaz
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;6:ewtfibJuyEVWaOK6t7+SbN6rD0IFUAWlLOJT4qhLfcSXkqFftRziBqGdIwydLJ+Ce68+au096sx6OaumGv+0haiLSnc5E+AK4X0J2RK0lBCHQkuoRhkXDP3Q1NzZpXpTTNbA0KgZD4nVlyYZlimW231g3XfhAYEJnxna0MZxV6si2aN96gucAIl8SohnVNZVC+8X1fYktC9+f1c5UVQOxMz6FJJucJRljNUf1fgmAm4DzRS8qygzvLGZN+K4wrh438ISQRbR3LaIqOxfFqJCvKEsZQ9jApQgotFceSHCELAiUv8PZvc149xjwNJKnz6+oUGL3xnhhn7eOEeMYQlW4SCyAxapblYs5al4a/lDAsKZfAonx1dPRKGqctmI5Ha8l/H7GBQQKXmES7fTWzabPZsaY4S/tldvExD2fVzdAEPSe+jptUSGMt1Up5uFNplxLN6h14YBf1BQFPWhT3mWgw==;5:g+niAWh46Q/OK4+dxafYZZVWVeBHqAfIwJGJhpjbeih6ZyPkumFMkD9bxJjeXSKrk08eP1VVxbd5TtcSif3zeTlk2RHaDrWtXfeT+FuAHpfUqkC3/lWbA4b9hA8zAfGm11HQ9Mnqwmli+G/gBOJrqCnJafb5bJrH1/TofP9OtKk=;24:s0DzJfOxarNPeHg/FRFvChf3AEtRURTDZXfKe6rsxxa1aGjuAVWxyFTSp/k08n2lXJgr8z/5oTS4dkkV/vX0CQrUDVeG/7jf2iOly3Xm01M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;7:Ny/BoEkJpHVRVjaDG6MtXvPsWhpWU4b2/pi2sAiZjLayVru6fLeRHtvzd5vKNYtN1ZerfZE5W+YeM0JdLSUdzUrgD2TNXC2vS8SJeUykwaRPHUn2kXNEC+5qAqMB/oHx3iZp+/YMFCHliTQUs1yrHT6dL9Qf+pdxTT/btd5eKrOARtXfxlSnPnotUT/p0yYZmNP8p2HzP8A5nye5hOe9g/5QLnlBqeQPiEw19125y/h1gQJuqyv5V5PxGIVpB9hC
X-MS-Office365-Filtering-Correlation-Id: 402598c8-7881-4ca6-7526-08d5bb05cc23
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:19:51.0337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402598c8-7881-4ca6-7526-08d5bb05cc23
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4377
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Morse <james.morse@arm.com>

compat_ptrace_request() lacks handlers for PTRACE_{G,S}ETSIGMASK,
instead using those in ptrace_request(). The compat variant should
read a compat_sigset_t from userspace instead of ptrace_request()s
sigset_t.

While compat_sigset_t is the same size as sigset_t, it is defined as
2xu32, instead of a single u64. On a big-endian CPU this means that
compat_sigset_t is passed to user-space using middle-endianness,
where the least-significant u32 is written most significant byte
first.

If ptrace_request()s code is used userspace will read the most
significant u32 where it expected the least significant.

Instead of duplicating ptrace_request()s code as a special case in
the arch code, handle it here.

Fixes: 29000caecbe87 ("ptrace: add ability to get/set signal-blocked mask")
CC: Andrey Vagin <avagin@openvz.org>
Signed-off-by: James Morse <james.morse@arm.com>

Yury:
Replace sigset_{to,from}_compat() with new {get,put}_compat_sigset()
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 kernel/ptrace.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73d45d4..214944d7c268 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -880,6 +880,22 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
 EXPORT_SYMBOL_GPL(task_user_regset_view);
 #endif
 
+static int ptrace_setsigmask(struct task_struct *child, sigset_t *new_set)
+{
+	sigdelsetmask(new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
+
+	/*
+	 * Every thread does recalc_sigpending() after resume, so
+	 * retarget_shared_pending() and recalc_sigpending() are not
+	 * called here.
+	 */
+	spin_lock_irq(&child->sighand->siglock);
+	child->blocked = *new_set;
+	spin_unlock_irq(&child->sighand->siglock);
+
+	return 0;
+}
+
 int ptrace_request(struct task_struct *child, long request,
 		   unsigned long addr, unsigned long data)
 {
@@ -951,18 +967,7 @@ int ptrace_request(struct task_struct *child, long request,
 			break;
 		}
 
-		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
-
-		/*
-		 * Every thread does recalc_sigpending() after resume, so
-		 * retarget_shared_pending() and recalc_sigpending() are not
-		 * called here.
-		 */
-		spin_lock_irq(&child->sighand->siglock);
-		child->blocked = new_set;
-		spin_unlock_irq(&child->sighand->siglock);
-
-		ret = 0;
+		ret = ptrace_setsigmask(child, &new_set);
 		break;
 	}
 
@@ -1181,6 +1186,7 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 {
 	compat_ulong_t __user *datap = compat_ptr(data);
 	compat_ulong_t word;
+	sigset_t new_set;
 	siginfo_t siginfo;
 	int ret;
 
@@ -1221,6 +1227,24 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 		else
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
+	case PTRACE_GETSIGMASK:
+		if (addr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		ret = put_compat_sigset((compat_sigset_t __user *) datap,
+				&child->blocked, sizeof(compat_sigset_t));
+		break;
+	case PTRACE_SETSIGMASK:
+		if (addr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		ret = get_compat_sigset(&new_set,
+				(compat_sigset_t __user *) datap);
+		if (ret)
+			break;
+
+		ret = ptrace_setsigmask(child, &new_set);
+		break;
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	case PTRACE_GETREGSET:
 	case PTRACE_SETREGSET:
-- 
2.17.0

