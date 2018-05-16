Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526458890-2-7144516104956090470
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
    1526458889; b=J7U3n2whvs0nnUS5C7wxVwQ4K3n9nHiDSrioghvSP/gvCGGoof
    pwpQOedDiBA8YkdG2Q/bg6CHOTBQSsewAl9VrfjH84scaZ1yfLLpahErgcPI3WNC
    YCZAg6tOkkAu9htpao9WNgs+edcFiZ+1EPFsgExBp+QEXh2InOu55+gkhMFH1x5T
    pODzLtPkkx1cShhS+llpEH02DFL8qLmSX+V2GJl0/F6n7bBVb8vEG/noLd7vRVnk
    mgRRJYZDKPgS4K7I11kgIuaLa2v8vgKT8HhBBz9aba74YI0Zn6WJAeDybf3WeXlC
    DIy8t+a0dLqEEh8l4jz8noC/6vq40fpEKF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526458889; bh=f2ZHjMn+xNLFroimi3WMeKIQh6a2TP
    6Gw6WE1kwyX0E=; b=Y0j050tWbHg8kiDC1TD8hlJ6c/RCHBR7diltYN+UT9jYB2
    VNxHdrDzMTxYgrjd0Rt2g8wzxJalkONaYf3kgjdIW55XRxpLpNC4jhdE4zJHb64D
    2t/QaM6zE8LBc6sY9dLXQgWoYvJheKKV9vshMqPj0j3ALnhn8bEQwpOyG//Tk+S/
    Rh7LlmTLn8iijeh0pPsZmTSEbhLxq/Xn1Briv5UNtFfpuNZsCOXFS7HlSSA/4bD4
    rKG3jBLfj4bU8vwm4UJQel8DwfgldQonC2DPyLkIqKml/pVpByUqjyAzA4st+js8
    qIyxi5Tf8K7trhGiH5HA2qf0+AitIW63Y+xXYvew==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=PzgtLl2g x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=PzgtLl2g x-bits=1024
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
X-CM-Envelope: MS4wfK5x1phlUCPt4FQ+cwd/YduQ6OveqerJnHk0aL3arp6OkPK4sfXiB+pkYqpYqP7fX7RcMQi+DOe8dJUTBHAZECSjohdSxYUX0OEZWk6wVNIegaZhR8xu
    loTRwK77W8y1dw9WwPMKPmdcu51ewRgX/8oM25+LHMglMIY6ssSCrdsWz6x3TKMzAYtHd1QoSIMI8dFTmMyl1mrWYWnZPi0bcdsAiOpet5XMBsOODQMZVS1y
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=6znUWO7K2BAA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=zAyngx5bAAAA:8 a=enOvQawGAAAA:8 a=NXpJzYs8AAAA:8
    a=pGLkceISAAAA:8 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=Fe70Ljh8badaJzu3x_gA:9
    a=x8gzFH9gYPwA:10 a=4LA4qAFo6bo561LpWNDU:22 a=OuzhcWw_GC9nAYdNdRwA:22
    a=cwV61pgf2j4Cq8VD9hE_:22 a=_FVE-zBwftR9WsbkzFJk:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeEPIVT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:21:19 -0400
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:24928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752245AbeEPIVM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:21:12 -0400
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
Subject: [PATCH 08/24] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Wed, 16 May 2018 11:18:53 +0300
Message-Id: <20180516081910.10067-9-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0124.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::26) To BN7PR07MB4370.namprd07.prod.outlook.com
 (2603:10b6:406:b5::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4370;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;3:4sTLnwJPYfk6DPC0YJtcN00sU3N6v8rGAB0T2uvcNV8d4WJBPuMFrtTvYrmvPFj6fNJBjRd8lqfoheNTuVYKZjIyykXXSH4vozcAXl6liPiEtAOZkfvOjnZWm2XPj0g1JdYMhqWDC6NQg0NOsVzdeFWo+7iZPboN1eViKvVckaqtFFIIqZtfaJkETk8ZvxwOcqZ3T4lpmOd36EYDs7dfVzuoHDCfBjwGRz6ZSI3CjZmsUIGZUtQtz22d+LbJpNOR;25:zggRN57DqRoT5fYYSv8px+E4F2JrkUeKi6GMyUqI8zzRnTHtFCldOng8V90s3yPeUVEpZjvMtnkE9NIupBiPLl2K87K3lcwtUt9kLRmKlSPrEk8WtZJFq/sgyTHZ56Tyof5IJeD8vEhfg2ienIHUrawe0jGlJ+ggCBu5BpwFYGDJOQYkR2eLqNJlq+bGs876LqMIjLmcji6slB2eeXlPcv5mEr78OeV/z7+oR3KI5E0RZAkdxdnVXCq2idoGeRmdY8ddLrhmD62JdwVYn8VzxyT9Tb7p3RByyaI8Jc/ZV2fRr93Q30iEwL+LHWGy1ZnoLksAT8g5CMCDHf3lHLEFrA==;31:kzQ1DmlqORFcQLVPxlCO4FjE11Ggl2lZSr+OAhG3U3oq7afUl7JYMRJAP9mEqPim7VuGE462TP2h9PbURGU83N4CdR8iunIzL83Qc5EtB+9GdLvEaLNxP/w8MT+aogsJ8xil2EDbPwEabw/iQkb4ZFpBySOnyyH8wFq41XBtsgnSxYlrYLAj8vM6UMND8P1UmHihkJjIugUJThwshTEYjII0uefRsXRFGVOZBzedltY=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4370:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;20:ObUdyfIdYBrUYWF55DpV5ygy9Towy4qt55MZMwNh5EpTA+5n3S4yLs5wokdexkPwazv1MGHgEswqmFj7AcRll8UY1KYbAt01VJQIAQch7+V912o09JGyFvlVqSGmqn0w3dxblynGf1qzkzVkuPGVBQFysaOR+V7RBkdvdiBC//biW9B7vQRPER/35RvxEALJcYqmUgQqutxg5giO4CtuVsADfOthTQbGKKzTep0NvkxRL9s3Lwpu5emnI9b8Ox7zHMiki+aDuyoyeqdK2J2ou2xeGnN+o+pLsS5qHsTcTm1rK286c1XRezuuTCYF1djw+G3BKJq+u9/hizfBmH+7rYeCRk2BeuNoJk6D7EAbQJbf0vGhOtsDuIWFgQmnP5ZHXeBR0iQPQTV8Mx9lDYb1UAT0/ssZzlRjZt5jmgQWpTDDPl8lMjIiZYQdK7KVc1bzglYswjNmCXKwayxmGDgRKYYtFpF1fkfOXUY4q/n3bZs3vO9oJj4AGNMZjCyy4XpTYuNggh4fPnR1dREYpEJkIGuiAYtAKn/ZyIWYIsMxjzXGEmBiLK8cIjyLzZCbV0mIaBCtwqDf8EeHPYdboR2mS0Bbj1d1nOhlQdC8JZebo4A=
X-Microsoft-Antispam-PRVS: <BN7PR07MB4370F76FE0CB5CC02443BAB6E3920@BN7PR07MB4370.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN7PR07MB4370;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4370;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;4:QTSL7cjOgf0LfibMDRBdxDkuNlIUIg/6HFUvr2hcl8HDPQYQshRCOu1mgVHrSLN/R8IE681NQwAHFPqFO4pMhOEjhCP7074PNXX11sH+lHPVspHG+UFVGdShKx6LF09jwMN0DrfpZeqFg1Ey0nHLL/kl1aKvwGr2FUBrcE75jifbqsOJPXZ7XT5tdbxcKVDELdcshgAn6O5Zon8M0LWjyS6D2EJVK5P+5b5+RWtvIi4aQkuom/Yjs0vU/b2eIE2kU5/qc67jZfOtEckY6Rbn9hdsMN7bzmvoczjCyU8ON9K1OY/DVwiH8qHhBol+SKE99iGmVeNfs2Gx5TZow9YZeIdoKjJiet1RvpGh2id/O2dUolB3KS/BI6McVuS+6GlG
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(189003)(199004)(81156014)(386003)(39060400002)(26005)(52116002)(51416003)(50226002)(6496006)(8936002)(316002)(47776003)(6666003)(305945005)(68736007)(66066001)(16586007)(7736002)(81166006)(8676002)(36756003)(107886003)(97736004)(76176011)(25786009)(16526019)(186003)(59450400001)(2906002)(6116002)(5660300001)(76506005)(3846002)(1076002)(476003)(486006)(42882007)(446003)(2616005)(6306002)(956004)(11346002)(106356001)(478600001)(50466002)(48376002)(105586002)(54906003)(110136005)(4326008)(7406005)(7416002)(72206003)(53936002)(575784001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4370;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4370;23:1uDRDNGKCDPKFs52gmiFWWW9vJiE+zJFAcHv1VcdR?=
 =?us-ascii?Q?0g9JmzF5QOz6etxnTujW0/bz/GjoKKRfjkDfSgnoh34e+5MriCjCblpD03Cd?=
 =?us-ascii?Q?TmwovUf4MuZf75vc9T0vZCl3PnL5HkHJOBL7Ylt5o0Eb6l4QzSpUJFeXn1+U?=
 =?us-ascii?Q?J7JR+seZMM0oCTcTKTbeRmfm9JcbSWazPwh9X7ArlPSxfX3SIGscNgJPWuLb?=
 =?us-ascii?Q?1PRJ3LLOdBBothrNwAdzOGfRb3KzjK+zVolgbeFuci1RLwS1VXxAxdoejhrF?=
 =?us-ascii?Q?zVoiJqxGj4v6Ej4IrDYWepn09V7pfa+bj4V/w36nFfYo0hxMOiBf2kRhu4lf?=
 =?us-ascii?Q?lJI6el8ZOZm8mDT6iRCUFlSnmWufuIw3pst9p6st8GsIovgl8vccK26C1tlC?=
 =?us-ascii?Q?4zrA0JYG+jgV7xxPyab0ENutF6p9+/dAdP9gEpYpoj0tjBdLMJ5n5tXnWs3M?=
 =?us-ascii?Q?xSkYWBb42sXO13PvpEMMu12+Brk0XsBCi88Usz+9bcjj7WhvaxgjF7yRoL+C?=
 =?us-ascii?Q?JPcSOcMgSVWGjIka+GTkrgQ94TO5bUVd12cm3pOGNoikAhuhQn0iRSYr4Wvf?=
 =?us-ascii?Q?n1eqoOViX5yr6fnvaCqzoURyxb1pr4Fx2JZo1xhneA+pjkjjxX28jTcxufgq?=
 =?us-ascii?Q?PTyxe1Lw0nnZjS8p6SbUNZEo2zO3JpDjZXihX//tV3hWy6brRQ4h5D/vtqRt?=
 =?us-ascii?Q?vx59+gLzdwtS2app8vSDR1L9+oFBiUe1s0Pxe2ysRuYW2FWxtktLu1AJBE0g?=
 =?us-ascii?Q?Z5JKCQ34VW+JQd0VOcziTfmJ8W3hD2gtdCOo1jLBQNym44nXolyaK02mJ2tv?=
 =?us-ascii?Q?x753j4nvfsH/NXIMIxEsjHGJqV5nMzwFriF8IYgfx/r/hb1/2W02eYaXyD1U?=
 =?us-ascii?Q?aJKCX63HO/XPGD3YwGKq5NAFvxcaaH1a9wQ8FwzNZGfLvuTO+NDb3UlwMdrF?=
 =?us-ascii?Q?r2E1hL0JqfQUIhCp76SycK35Kk8r73oo9b2/zak5p7T5EoyumGDZktH/eDsU?=
 =?us-ascii?Q?tNEsUGL8/29dc5lfXMVuhAQ2BRMjAK9t3jWfmOo6vYMRg8R5v/VcZfNChJAV?=
 =?us-ascii?Q?pmG8NBWeXPHnTU6N+FHPAdifVwkjQjw2gOPPs7HRpUsXizQ0vdxycAtpV2K+?=
 =?us-ascii?Q?9Fnf1PVToP1r/rMVF7BM9PWx8GNBcTKqpGdrQ8J23khq4K8jgo5Mhl/IHX9c?=
 =?us-ascii?Q?Zc2LONlSPKuKY6CnDR033tJDwB4xxWI5rX9xSaZyJzrphph9NV6xYVBJ9uMK?=
 =?us-ascii?Q?+/FwXkpk82w+f16kO4J2ZWtsOsuT4NJ1HKH1/Sjpb8PM7wJNb7uJfjzUTSnB?=
 =?us-ascii?Q?QqplBfxp2khK4Sx+6ZPdCTSCpjfIP4TQF6fouogi1DUy1HXUnqCmN6Akyoxu?=
 =?us-ascii?Q?7oDd7jzhsmRgRMaisNx3dECAJBKjfRF7RUBQny9REYrvlzx7H25S8pJ/2ugM?=
 =?us-ascii?Q?z9fCETapQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0sQTZ1Fn/nEzFxuUAw0f6mPTEzKxgeQpKoddpNzhz2KV58L9nCcXdhm8QZXLCygQMUkxWjq2s33oQJr2dfBtuaX+NFMu2ussqKika3SgL76+zv7gpEwiDXBcAAxjfGfIHsdmuD4s5Z4+pEJYgFLy5m5kksY4PXuglOblykR/rBM3Qw6O+UOVM73WsZJQl8Ds
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;6:3ow/vGXAjxxSsBd9RwVzh7PSS9megBBWDK8t2leZu3r0HGKz93uwh7UBk4pHjY5ouYLe7L3GPD5/j02WK1hg+N20Fy1UbjR/xK4yZij6ZmhJPHP4iBMKmrnVldc5r56aPa5vOvL6kK2PH41dyxOMAs1luvpmsVIWvzYoZvOsBY0JKH44g3fseHzt3ecLah0CCw0JzNKwOG6O5rDzc3GMOEebYbUt+1TKvLTGJ8oERlNBFMhaY5rIo4QyOOfucOFdAH66IsDp8chqQd6N0mzyvZEuFRkgUiNYxDyQO4E795d9sXNNe2ht2u5WIvaM0M+e4rLovvJwuOTWqfnGYceBZClLTlS/RFxhT/lm49KV81Hxxvb8PEjH7vlF76cb3WwiADa1FNG+SiR6dWa1gj7mP4Xn96+m9J8JcLhv2tLwsfFPWcBEpoxen1FcyOnQ/WUwsVXdd3/zKxlbvy2wXZF9bQ==;5:92Fo5vy3QBujxKS7CduOvhF1zFzHDxYqrEpXvGttgLrlm1w6SNkzI0rKl0kMdTAJrP8TzaL4/w7u2qG3+tVjZ05sxRiAx1deM6BgiwR+8ZJRflp5QgCS1L7RXrseRfKz4smsTEFwhgTFWjvqg2reHvNCNFKdSm9Hv0xGKcuGCd0=;24:yE2eNmZF5z2c4jtBd1TK9/8YzWphb2vy8N1bsKN8rk5wnPq7FPg5FlygKbAzUVF5BCAK6xFzgr5mFqy1akE8McubFuJKqotxXnANOl0eHCY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;7:Inr/EjR5qse0BO3+15JElzXchsF/0kKTaajQm3O+eOw3NLshxknbCB9o3xwRD2/ohWDEaNzuvq3iLNeVDu0LTPwFGzjGO3Ejg4cvTGvATO5HgpKN0Mg0TUaUBY8pnImmpV4ItS6m2gSWtXeGBYi528hig7esVHYCuCdwZAGyNrhx4ULu5vXg2MhupSWkEnMrBVOqSDkWz3OaxZUaJK228RthUzMzgeQxY9UHNFyHS6CQ4ARo8ffwZmWoGG4YOu+O
X-MS-Office365-Filtering-Correlation-Id: bdd237fb-413f-458b-b254-08d5bb05f8a4
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:21:05.7004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd237fb-413f-458b-b254-08d5bb05f8a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4370
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrew Pinski <apinski@cavium.com>

In this patchset ILP32 ABI support is added. Additionally to AARCH32,
which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.

>From now, AARCH32_EL0 (former COMPAT) config option means the support of
AARCH32 userspace, and ARM64_ILP32 - support of ILP32 ABI (see following
patches), and COMPAT indicates that one of them or both is enabled.

Where needed, CONFIG_COMPAT is changed over to use CONFIG_AARCH32_EL0
instead.

Reviewed-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Bamvor Jian Zhang <bamv2005@gmail.com>
---
 arch/arm64/Kconfig                   | 9 +++++++--
 arch/arm64/include/asm/fpsimd.h      | 2 +-
 arch/arm64/include/asm/hwcap.h       | 4 ++--
 arch/arm64/include/asm/processor.h   | 6 +++---
 arch/arm64/include/asm/ptrace.h      | 2 +-
 arch/arm64/include/asm/seccomp.h     | 2 +-
 arch/arm64/include/asm/signal32.h    | 6 ++++--
 arch/arm64/include/asm/unistd.h      | 2 +-
 arch/arm64/kernel/Makefile           | 2 +-
 arch/arm64/kernel/asm-offsets.c      | 2 +-
 arch/arm64/kernel/cpufeature.c       | 8 ++++----
 arch/arm64/kernel/cpuinfo.c          | 8 ++++----
 arch/arm64/kernel/entry.S            | 6 +++---
 arch/arm64/kernel/head.S             | 2 +-
 arch/arm64/kernel/perf_callchain.c   | 6 +++---
 arch/arm64/kernel/ptrace.c           | 8 ++++----
 arch/arm64/kernel/traps.c            | 2 +-
 arch/arm64/kernel/vdso.c             | 4 ++--
 drivers/clocksource/arm_arch_timer.c | 2 +-
 19 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb7ef8e..a16916be20f5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -433,7 +433,7 @@ config ARM64_ERRATUM_834220
 
 config ARM64_ERRATUM_845719
 	bool "Cortex-A53: 845719: a load might read incorrect data"
-	depends on COMPAT
+	depends on AARCH32_EL0
 	default y
 	help
 	  This option adds an alternative code sequence to work around ARM
@@ -906,7 +906,7 @@ config HARDEN_BRANCH_PREDICTOR
 
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
-	depends on COMPAT
+	depends on AARCH32_EL0
 	depends on SYSCTL
 	help
 	  Legacy software support may require certain instructions
@@ -1225,7 +1225,12 @@ menu "Userspace binary formats"
 source "fs/Kconfig.binfmt"
 
 config COMPAT
+	def_bool y
+	depends on AARCH32_EL0
+
+config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
+	def_bool y
 	depends on ARM64_4K_PAGES || EXPERT
 	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select HAVE_UID16
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8857a0f0d0f7..0971bf730d44 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -49,7 +49,7 @@ struct fpsimd_state {
 	unsigned int cpu;
 };
 
-#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
+#if defined(__KERNEL__) && defined(CONFIG_AARCH32_EL0)
 /* Masks for extracting the FPSR and FPCR from the FPSCR */
 #define VFP_FPSCR_STAT_MASK	0xf800009f
 #define VFP_FPSCR_CTRL_MASK	0x07f79f00
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 400b80b49595..2c7fc5d89813 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -46,7 +46,7 @@
  */
 #define ELF_HWCAP		(elf_hwcap)
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
 #define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
 extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
@@ -54,7 +54,7 @@ extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
 
 enum {
 	CAP_HWCAP = 1,
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	CAP_COMPAT_HWCAP,
 	CAP_COMPAT_HWCAP2,
 #endif
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fce604e3e599..79cbc385f52a 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -104,7 +104,7 @@ struct cpu_context {
 struct thread_struct {
 	struct cpu_context	cpu_context;	/* cpu context */
 	unsigned long		tp_value;	/* TLS register */
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	unsigned long		tp2_value;
 #endif
 	struct fpsimd_state	fpsimd_state;
@@ -126,7 +126,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 	*offset = *size = 0;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define task_user_tls(t)						\
 ({									\
 	unsigned long *__tls;						\
@@ -160,7 +160,7 @@ static inline void start_thread(struct pt_regs *regs, unsigned long pc,
 	regs->sp = sp;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
 				       unsigned long sp)
 {
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 6069d66e0bc2..0c85b469ad68 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -154,7 +154,7 @@ static inline void forget_syscall(struct pt_regs *regs)
 
 #define arch_has_single_step()	(1)
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define compat_thumb_mode(regs) \
 	(((regs)->pstate & COMPAT_PSR_T_BIT))
 #else
diff --git a/arch/arm64/include/asm/seccomp.h b/arch/arm64/include/asm/seccomp.h
index c76fac979629..00ef0bf63230 100644
--- a/arch/arm64/include/asm/seccomp.h
+++ b/arch/arm64/include/asm/seccomp.h
@@ -13,7 +13,7 @@
 
 #include <asm/unistd.h>
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define __NR_seccomp_read_32		__NR_compat_read
 #define __NR_seccomp_write_32		__NR_compat_write
 #define __NR_seccomp_exit_32		__NR_compat_exit
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 81abea0b7650..2ebde460f5a0 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -17,7 +17,9 @@
 #define __ASM_SIGNAL32_H
 
 #ifdef __KERNEL__
-#ifdef CONFIG_COMPAT
+
+#ifdef CONFIG_AARCH32_EL0
+
 #include <linux/compat.h>
 
 #define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
@@ -45,6 +47,6 @@ static inline int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t
 static inline void compat_setup_restart_syscall(struct pt_regs *regs)
 {
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 #endif /* __KERNEL__ */
 #endif /* __ASM_SIGNAL32_H */
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a0baa9af5487..99d29290c98b 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,7 +13,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index b87541360f43..cff1a78bdf4c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -26,7 +26,7 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 1303e04110cd..a416c2333e2f 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -69,7 +69,7 @@ int main(void)
   DEFINE(S_X28,			offsetof(struct pt_regs, regs[28]));
   DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
   DEFINE(S_SP,			offsetof(struct pt_regs, sp));
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
   DEFINE(S_COMPAT_SP,		offsetof(struct pt_regs, compat_sp));
 #endif
   DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2985a067fc13..1ea242547466 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -37,7 +37,7 @@
 unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define COMPAT_ELF_HWCAP_DEFAULT	\
 				(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
 				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
@@ -1133,7 +1133,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 };
 
 static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA1_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA1),
@@ -1149,7 +1149,7 @@ static void __init cap_set_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 	case CAP_HWCAP:
 		elf_hwcap |= cap->hwcap;
 		break;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	case CAP_COMPAT_HWCAP:
 		compat_elf_hwcap |= (u32)cap->hwcap;
 		break;
@@ -1172,7 +1172,7 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 	case CAP_HWCAP:
 		rc = (elf_hwcap & cap->hwcap) != 0;
 		break;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	case CAP_COMPAT_HWCAP:
 		rc = (compat_elf_hwcap & (u32)cap->hwcap) != 0;
 		break;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 7f94623df8a5..23fdf30dc0a3 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -80,7 +80,7 @@ static const char *const hwcap_str[] = {
 	NULL
 };
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 static const char *const compat_hwcap_str[] = {
 	"swp",
 	"half",
@@ -115,7 +115,7 @@ static const char *const compat_hwcap2_str[] = {
 	"crc32",
 	NULL
 };
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 static int c_show(struct seq_file *m, void *v)
 {
@@ -148,7 +148,7 @@ static int c_show(struct seq_file *m, void *v)
 		 */
 		seq_puts(m, "Features\t:");
 		if (compat) {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 			for (j = 0; compat_hwcap_str[j]; j++)
 				if (compat_elf_hwcap & (1 << j))
 					seq_printf(m, " %s", compat_hwcap_str[j]);
@@ -156,7 +156,7 @@ static int c_show(struct seq_file *m, void *v)
 			for (j = 0; compat_hwcap2_str[j]; j++)
 				if (compat_elf_hwcap2 & (1 << j))
 					seq_printf(m, " %s", compat_hwcap2_str[j]);
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 		} else {
 			for (j = 0; hwcap_str[j]; j++)
 				if (elf_hwcap & (1 << j))
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ec2ee720e33e..698907724eed 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -423,7 +423,7 @@ ENTRY(vectors)
 	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
 	kernel_ventry	0, error			// Error 64-bit EL0
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
 	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
 	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
@@ -492,7 +492,7 @@ el0_error_invalid:
 	inv_entry 0, BAD_ERROR
 ENDPROC(el0_error_invalid)
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 el0_fiq_invalid_compat:
 	inv_entry 0, BAD_FIQ, 32
 ENDPROC(el0_fiq_invalid_compat)
@@ -656,7 +656,7 @@ el0_sync:
 	b.ge	el0_dbg
 	b	el0_inv
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	.align	6
 el0_sync_compat:
 	kernel_entry 0, 32
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2b6b8b24e5ab..fdd706a839e4 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -544,7 +544,7 @@ set_hcr:
 	msr	vpidr_el2, x0
 	msr	vmpidr_el2, x1
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
 #endif
 
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index bcafd7dcfe8b..32e07818835d 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -59,7 +59,7 @@ user_backtrace(struct frame_tail __user *tail,
 	return buftail.fp;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 /*
  * The registers we're interested in are at the end of the variable
  * length saved register structure. The fp points at the end of this
@@ -104,7 +104,7 @@ compat_user_backtrace(struct compat_frame_tail __user *tail,
 
 	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
@@ -126,7 +126,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 		       tail && !((unsigned long)tail & 0xf))
 			tail = user_backtrace(tail, entry);
 	} else {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 		/* AARCH32 compat mode */
 		struct compat_frame_tail __user *tail;
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 9ae31f7e2243..04e9b7973b28 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -188,7 +188,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 	info.si_code	= TRAP_HWBKPT;
 	info.si_addr	= (void __user *)(bkpt->trigger);
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	if (is_compat_task()) {
 		int si_errno = 0;
 		int i;
@@ -1039,7 +1039,7 @@ static const struct user_regset_view user_aarch64_view = {
 	.regsets = aarch64_regsets, .n = ARRAY_SIZE(aarch64_regsets)
 };
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #include <linux/compat.h>
 
 enum compat_regset {
@@ -1581,11 +1581,11 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	/*
 	 * Core dumping of 32-bit tasks or compat ptrace requests must use the
 	 * user_aarch32_view compatible with arm32. Native ptrace requests on
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index eb2d15147e8d..691b3bbc7606 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -517,7 +517,7 @@ long compat_arm_syscall(struct pt_regs *regs);
 
 asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	long ret;
 	if (is_compat_task()) {
 		ret = compat_arm_syscall(regs);
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 2d419006ad43..440fe2652d4a 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -49,7 +49,7 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
@@ -108,7 +108,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 57cb2f00fc07..c3c6a8d48adc 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -764,7 +764,7 @@ static void arch_timer_evtstrm_enable(int divider)
 			| ARCH_TIMER_VIRT_EVT_EN;
 	arch_timer_set_cntkctl(cntkctl);
 	elf_hwcap |= HWCAP_EVTSTRM;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
 #endif
 	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
-- 
2.17.0

