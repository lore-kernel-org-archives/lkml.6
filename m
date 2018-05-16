Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4128544-1526459365-2-10851580637843493419
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
    1526459364; b=EpYroOA8Hx7AfQQrraLSgdBxFWMbeI5Fn+qxyO7XK4tOx/b/sD
    wDdG5jHq/6bRby78ygLaXN6IfGb2zg46inCrWITZ78MEtQ9k59ySkNGT6yOpTHB7
    Qqdfxs4pU+V7hdawndYofA9EGrQgDzrWNJ0YhQmHpZphHp+MUZukxmCihZ8WPFAu
    I7ezGJGarxcOdRSN3+oS/MPNoktosvc1aflvZx7LX1DB+iiEyMaCG/8B276wqgj3
    IaxdhrCRKKuc7TkSQR3rShbswnJRlJ242COG27FGyl58OnPyuJnA63swkDgxO5oS
    X19A1TU5qI/gXFa5rCmRxG6Enq6uH5HtFhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459364; bh=rlFgupNcEOK5aSIYFg0LEIqsffVhmK
    2x0v+mL6KNdvU=; b=RpNf5xEW2zPK+sp4NEB/QKf4KftBOfX7C731jxLsVy779Q
    6t0iizwse9dPKHMMyByJ9T8vO78NxUofuOEpmbb1hvai4sMFalWQnyZwRRQPW4YV
    zjJFEaq4lcFa0sa3Bb5zavcUzR7w1grGDhKNmK2K6uq0InGo5CUVuem1gKINeOwM
    bcuYXhkbo9Hf8kjELGqojnVgXYghYlEf4BWxRvGB2qVV7sVdFWRYWIFLUtOH52Gj
    s/OZ/YDlJIxdek1/+UlnmFnEUXayU2c/TTDGfJCsgU7y7HIb0aapJpd6andEdbBm
    EO5U9NRk8lc49EOu9efpU6ZdRJdV+d4gktGbn1xA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=lpAuZkZf x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=lpAuZkZf x-bits=1024
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
X-CM-Envelope: MS4wfM2Ds+nDH5CJmhgWwADGm0QfH+HroBpJ0vgosUe8BIY/0JGCHpt9nuWZSVzEeKOMSM24R7GCYFoswTVmtr/puQP5VT9mlU6pVY8q8Mf50TBFXxmukhPI
    CyMNd+NrRqB1UEVAOTj1MwQE8q7g0G942WPy4/uXWD7JR2By4YxJEnWkdls2OHOyVqeNHy8izaFrfY7MEKtkUpjiccWCZwEpj79akoxlEZumjyDejPaX2up4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=V_6QiwIxc6EA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=zAyngx5bAAAA:8 a=NXpJzYs8AAAA:8 a=enOvQawGAAAA:8
    a=VwQbUJbxAAAA:8 a=DCRbcVUs93Vj27EFCzsA:9 a=x8gzFH9gYPwA:10
    a=4LA4qAFo6bo561LpWNDU:22 a=cwV61pgf2j4Cq8VD9hE_:22 a=OuzhcWw_GC9nAYdNdRwA:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeEPI25 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:28:57 -0400
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:43392
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751664AbeEPIVa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:21:30 -0400
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
        Andrew Pinski <apinski@cavium.com>
Subject: [PATCH 10/24] arm64: uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
Date: Wed, 16 May 2018 11:18:55 +0300
Message-Id: <20180516081910.10067-11-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0119.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::21) To BN7PR07MB4371.namprd07.prod.outlook.com
 (2603:10b6:406:b5::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4371;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;3:oOWHiUfNonkPGQczf/XxQpmYIDyaQJutXmRHeHnO3rCJfkYBZvKDNQT7tuEF9skWAUGQGGkMJFqFVV+dRpoZ0N0T33dOMBLTcpbjnj1O9xkzVxQe/EuLRaFZFyNie2MgpltdXiHFCyGTefoxW329Ev403FihLuzGP1v6JGAxJ15ruhsZul+uQZiSCSBMtdM/9gJcRtVdTrr/8yXbHx/OxWi8QxM4/ZqIsSPDAd4brinjZLUAYIIEyXTG0TriE99t;25:gFIQvwwYuiu06sp6/tufMoapCyKSb4Qakq7WOlmRBa3LixmfA8vVQmKJGu2rs/Pgl43bzrtNQgYJHJMUT0epVxlD863vBc+4vDi8M55yIDUgjGoYI0x5K6Z1N3fHgXaBr5vimUW89EirTRTcMH8LFU5Xift1AUb2583LQKMpKAumdJppgTFaZBYaVvzEvz99nlTbX+4ciuKJqOS3WIminmzAqmOL8jj2rHj8KFeHLekUEU2XYG+wki2eRL+Bx2bsqSgu/cKGi9GoioBrbOACFHvPxQNW7+OSf2ehHsItM9hId5EDWAvJP8yDJ7nKwuWF9jit6uX0QxnevLhpga6LrA==;31:3lSZisl/n/00WhhEfDtEfaD/WH7ugeG8ll04UmbhWFqiHIdI68pTOHZuaGpIRcKDXhHgUYGnzKRf18mUzBWXlKryQOFqjgJr8XSjQRQgvGnF3NW8mzaZJdwyWFDi965s+fBX1ehunQm2ZpsX2/Q1KZcm8x9mrRjn0Ol88mAaOtZrihuQewB27wSFEJHJ+PzbwOdllKVRG6wqevS8W6FpnjBncGVFPeO9wbh5w7hjAFc=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4371:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;20:BqeCH444BL/w2hWVlDZzx+ZxjgiyFTps/eKnLgAt7fs+d1NCfXmxkDh90Wx3GcswFxBOY5Mz2InmtsOGoJEiyod/Yk/H6Ve/o5IOYyS2KHYIca9eAMOzVkYK63fK0B7n62s6mWkUY4ruUQcweLj26Hkev5ztxkmry2dLtVObWOGIlMYplNofMioPsObGb/v66G655mUkVw8cAEklG08jpgbGn3Ru2UeutgdaiN+RMjAML5r2AGiA1xF++X6Tuak/GI8AKpODQHCJ4sesL++zAnx+ZgIA+GLo9Sr5BuuurGtAmRmicHojZgQ26P7xa9QGSG0gyUyBhqaDM12yubZdEv5nfYpvSauQM/msdMQNwwdGcINAinSUUh+uhV2wmjsq6LFQzSUExVFhJzy4PvyDWyyzQjjdEk1gmy9GGwWw+q14VGBIZqIpnsrLEzmpfvi3cDtmkj/H5aa9A/PpBUugdHcBRX5kZslmCKQc7apSyicJQzTOguT/LiCX82qAEilZfdEwkI1taRAZaWRyir83QBFuYxzM+wRkrjaHBx3ZOH6Mr9GkMRKjig2KWneSDRhuXGpdCRBugF8l7UuvMykaIVTALcUv5H2chfSK2yMk9fw=;4:DWO9MTE5dWOYUNjz9dzdmitJ0AlKanV+sI14W1NfeaVZ3wYKj1Z1KjbWV7iZOmKqfR1Z+3ZWNsLf0SDcOM0Zlhy04BFqmugeAn1p0fdBD1Kkhx6pbyUepetENwM3khnROMOOyVQephU32q8i5H9zPqD/3MF6MI9VB2mGj/xtFSTPcbGQw0dokgOYiy15u/RWhQ5mJoSsdspJmdWia3UBzzF4NbTmQMWWT8s//8AK+YWrrIsGA6A3T9MlY8eHxJQMs77DJE3Z9e51YSDI63w8rQ==
X-Microsoft-Antispam-PRVS: <BN7PR07MB43717AB414C6B8675B5B7EB4E3920@BN7PR07MB4371.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN7PR07MB4371;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4371;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(39850400004)(366004)(396003)(39380400002)(199004)(189003)(956004)(2906002)(3846002)(2616005)(7406005)(42882007)(486006)(76176011)(446003)(6116002)(16586007)(16526019)(76506005)(386003)(50226002)(51416003)(476003)(305945005)(11346002)(59450400001)(7736002)(25786009)(7416002)(53936002)(4326008)(72206003)(6486002)(5660300001)(107886003)(316002)(6666003)(66066001)(39060400002)(52116002)(47776003)(48376002)(97736004)(81166006)(50466002)(81156014)(36756003)(54906003)(478600001)(106356001)(6496006)(186003)(68736007)(8676002)(8936002)(1076002)(105586002)(110136005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4371;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4371;23:g7PLFBkr1mo2/RJQ2f28ewzW41rdGiznkdO/RZkRe?=
 =?us-ascii?Q?BNNGbujWGolQkgS+iE1L/goo4ZqguyV8qlv2EOayAT1k062qnoZw6S9UJPrc?=
 =?us-ascii?Q?fMJAO5EDgfathD39dYZeS1Ph31lJXobbKAvrNHh3qLtYig+UzPYqYF0OJiJd?=
 =?us-ascii?Q?z+Au1nwsrVFxEXRcUfPe120AJ4wjcTFQYWggzXTycJUEGSZncTve7nouTswk?=
 =?us-ascii?Q?c16zew0MZqyQ+zKj260s1Bg7T88b6W6Lge3F80Llo+9xUySMJxHaPvjBwJbn?=
 =?us-ascii?Q?E8OWzA0rLev8mOLeIUBBaYkd+Ap69uEbt5X9HhoIkksKLaSx/LyRNqBKiPI0?=
 =?us-ascii?Q?29OyFXVHm/SS0oIzes6x0kUd/MuX62zkT7yFYfJQgJKrmModbx+n9AmYfjS/?=
 =?us-ascii?Q?60IeaP6FeHmCh+ek/kkFag23LnT6ccXvBy4dKX4XeDNV5jEC7hRwAntV3mCr?=
 =?us-ascii?Q?d7zxXVQHuNLmeBsRcvQBn0qoaf57IAlG8qlLXlfORGLkLLlj+OhB0Q2+wWwH?=
 =?us-ascii?Q?l3T3ERhMHpnWsxl84MYxYT18Xoa1dkOrkyDsU/6IfWZoXSjrCyzL8A9uO/3G?=
 =?us-ascii?Q?kEBtvnRrD7d5ny94gZxL5RLH4q6DQKmWyrmCPA5DHzJEvPATplbOf5vxGRwt?=
 =?us-ascii?Q?OvOmVg7o0M/SQw4o6rHUBkjkHL9TvvbfUX0oYVMtCqsm5pNi7bwzxZZlcFNM?=
 =?us-ascii?Q?DlD8mAEDgFzr4Ln8W0vQkTVwXIC5eNSpyyxl6Qgp78PgE0J9KLW/7NhNSzEl?=
 =?us-ascii?Q?oCMCFXcBn+RRH7Wvkg4DhzF5T0DjaV8TLGaauuypjhHdSdtLp65H5JKM4mfb?=
 =?us-ascii?Q?zFdW6t9HG7Jf+IuCrPTgBeqlUzlzCSUVgjeM7x6mARQI0+Lbp+kJa/7LPALG?=
 =?us-ascii?Q?9t/mjhRE9d/+K9MKcPyDUzKXJgMLXqXfwC5ol/iIUxw1iCOkUnkNNrGRdgme?=
 =?us-ascii?Q?RI8xKB4gDY2ZhOw+8u6kwI36tistIDOSuWm+lruRZg+Dxd2GNvOWmxxbFVwV?=
 =?us-ascii?Q?UCcDcLCfWNx09i1j60TZi9RPaJ9TZPball2Vbb/5/vZsL5Fj7z+dH+BQysq0?=
 =?us-ascii?Q?EUL4Gk+Nh7hCaX0d0FzVgGCEexejlwGjefZZGanhYUyjIa9WBU0q1OzNHbCw?=
 =?us-ascii?Q?wp0lWtUXahyb4SPxekW6E2ndnpPVgcA+/zA9j3fv5xv7qjphtgfQhdn53dEo?=
 =?us-ascii?Q?QQndbvvqXr3U/wzvEaD+pl+vSnzOvItP3R0l9k/nrb7mafIWFklxdtjWDG6j?=
 =?us-ascii?Q?Yez4msDAU3zdp26IKFAEN9F5LesoO92SYQZTMYyvcecJHnIG6JCawpGqCS/h?=
 =?us-ascii?Q?6Cr6EV+fJ9Oa9Cx5/mD97mW/3uwaWfN0Q3K2HkdiAT0QuJRwYMYmWG/5nLWZ?=
 =?us-ascii?Q?JEuwZOtx27536EFzUuGZQOYieo=3D?=
X-Microsoft-Antispam-Message-Info: ZgAG43n6zgDPA+9X+H6w3aJHI0rHrvncdeOKVv9I3NK8+qsgOrQuTSIk4ATMpMOZpvJdH01QXAo2u7WLXCc9L/CSLLOfd0AH/9LGvZlGEZRziUaT2X9JCNKaeS/xnwlV6PKSMrbk7HtChFdBKTaDfZA28dkP581DSBHGwnr6qKp6OeuX0YDRCT/8HZbS2ujD
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;6:iEOaMXrF45AZiTJKAGXDKwL9yVPOBcvDXA+BSADjLwGDl1yK4dt0ha8xkRH10i1CPSkvEvtX7GdhA+/wgfxaFfbbdyq5T4iz2wkor+KrRdZK1uSGlNIZ7smkS+DUa0woTDbBohSDue7KjGuc8ZdRi6BgRSI9H3CvHatOx6MCYUB2p7beqyIl/yi0IuvmlyZByVlt0jzRGYY8Zr7XNhlHWjDf7hDWv6OQCdnBVZB7yZicpoRpD25CVh17BYpOs2UEI1rtv8DLJVgrw/QkF7pcXo169DrxXwdmCWcLV6X0RjDFynhmG28ZyDdqQ7b5J/aP9sR0/ZskCuNcyDV4ZWeemL+tdxrbrmh1B8g818qkvUPFum0JW59OoWDnsIKnWUYEbi6HYASjyvzSEhMjmI1u/KkiZwmiIeqabW5TmuxuudterESa++QN+W+vjZYW3DXuCf9YvBnMwrJ3xfotC2FV9Q==;5:MCmxN9U8LbU+5WDVHu46SkfZ+JY8yP/UZ/i+L24AL0JG/0gXovyQWYBIsPGdaKFhff4kZVKYbVZZ22kj1atohXj3csdXwnoGAyJ+3vY0UujoRoNi7a65ytnFb6/ewFiudLmfmJgG4vX7yj32mOR/lncYZSY8DFqy4F5PUql+Fwg=;24:0fTeOfe7ICL/eY97cr9e/b3zYUKUg+ZsBw+wxNeSD11JtLWxsKXdyqs3jwPQq1eAYe1gMz+ey27fH1N4rVm9ZgkS35gsp2zibAcFHdCQ+bY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;7:jsFyDXsL4citg7onCW7EE87BzIEoQW4ynndobHNoabYK0Ahk8A1rHe06uosAGqepJb7gxdP91hQZF30eGvGWI58RqS7jEWy9K5KcwytCvgrH1h414bXo8xSoq7RxhfvMMdaQZSgeONjMLXoMmqnlgFdSTUcCkJ3t7c1UpA6h0hkljUtusMRqsOCF07BbERrWJb6gAJ/tV4v0lztSLL1JClPhrCqQYpEy7lW4Yu9z6mefheJY6T1Hm9EBZzR7qspp
X-MS-Office365-Filtering-Correlation-Id: 1f057e86-6c69-421f-1290-08d5bb06056f
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:21:27.3312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f057e86-6c69-421f-1290-08d5bb06056f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4371
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrew Pinski <apinski@cavium.com>

Define __BITS_PER_LONG depending on the ABI used (i.e. check whether
__ILP32__ or __LP64__ is defined).  This is necessary for glibc to
determine the appropriate type definitions for the system call interface.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/uapi/asm/bitsperlong.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/bitsperlong.h b/arch/arm64/include/uapi/asm/bitsperlong.h
index 485d60bee26c..9a05a9659e76 100644
--- a/arch/arm64/include/uapi/asm/bitsperlong.h
+++ b/arch/arm64/include/uapi/asm/bitsperlong.h
@@ -17,7 +17,14 @@
 #ifndef __ASM_BITSPERLONG_H
 #define __ASM_BITSPERLONG_H
 
-#define __BITS_PER_LONG 64
+#if defined(__LP64__)
+/* Assuming __LP64__ will be defined for native ELF64's and not for ILP32. */
+#  define __BITS_PER_LONG 64
+#elif defined(__ILP32__)
+#  define __BITS_PER_LONG 32
+#else
+#  error "Neither LP64 nor ILP32: unsupported ABI in asm/bitsperlong.h"
+#endif
 
 #include <asm-generic/bitsperlong.h>
 
-- 
2.17.0

