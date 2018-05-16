Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4128544-1526459328-2-12969299474898449903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526459327; b=lumLrfiHFSjwuQEm3RxIMB6OGbP/mgzA2wG9mFim52pICFWb/q
    SRCb7+X4Vm1DT0wVcIks2VZ5Yldy5uSd1wLHg2YsHAnbqrJAjZJ9BzfQ6cHBQQx+
    oBp3fkF3l3MOpisC+RVallg5VpRpSHmv6XFhD7avRURxmd+3j4pbClV6bZLIwbtn
    zuTJ7WCHFDqa4RMnXM/aURHIYOSTOWid5vaKmlCkF7Da2FqKNBwOwizHOzKxC2vG
    N3c6NtVS8ieJBsfPTbyOv5uvM1W7Qi35eddvrXo4os+DZsQFHs42fPbGZiv5uhFO
    8XDG0YE8YVvrXP6BhnVAcPr9PoItF9RgSBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459327; bh=GhukGhYsHfr6sE5THqI+EQIn394awa
    7tVhljC5j1LLI=; b=MoHSXxHNYNyjxMzxA7GEbkWu+BfIa2P+QMAX2+0iTl7UfG
    sVgwO7Wz8oadcuzoFpV3qWF82+sF+KyzGguqwNoVqc8fZsiDNyyyLWKZWtuizjpI
    IQfuk/mlg8/Fc4dXCoEh2bgOH3yHhmAlEJ000g52OsBZrrcXi9HLvZTnmTzhKLld
    y27HvRj4+0t4tGJAkNtu4A5CgyXJeHYcoqDscFEuQbSfNgaQBReYgXnYcmUQs3Oz
    pMbAfDX1aM3RLcrNG9QIua8uE8BqbxBFQ8n2kHtnR1RDmtq8+adA0ytyF6IDDonA
    buH4McyKcHG+sS/53EWtsi0PIxEJ7L0lkOqy0sbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=RSN0GTAY x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=RSN0GTAY x-bits=1024
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
X-CM-Envelope: MS4wfCPphlh+lEDwBA/9CGjxvoMxrnxh8OnUVvDCRq81PdETpviD8a2AB0SpeQmfHps3mdS3cqmppvWNCQ1UsTHzfOkeEGXAaXCM/OFbogW1Rm/B3KnUAoLE
    c1UEQFq0iADBIVWZovnjStoJjaHhDDGcGlBDXljhI1LU+s2Gr0B0274ogKaM9RC/BewJ6sBtvzvl9Sh6qwHs7GrwUNGMGuPHurZ+WzwXInQQAymHMBSq4jrU
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=wTyAd9q2X0EA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=OWxLu11OLW9UFPa1ZQUA:9 a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeEPIVu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:21:50 -0400
Received: from mail-dm3nam03on0065.outbound.protection.outlook.com ([104.47.41.65]:4373
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752717AbeEPIVn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:21:43 -0400
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
        Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Subject: [PATCH 11/24] arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
Date: Wed, 16 May 2018 11:18:56 +0300
Message-Id: <20180516081910.10067-12-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0113.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::15) To BYAPR07MB4376.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4376;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;3:2yjWDL5GDHk84HMCpMf2f/ZW/yEA4bN/5cdHHnHfvbkHctK5Jo3xl1RemupMSY+zuyCKoGUFYNAZJv89Qgo/PEYlFdIy1bhwaORFzFOXORw1uTJYf5+iCgoap/fpLAZl0WrDrgNaXIwv4AKCmqDBa/YsqmhnPjDIunSwenR/6Pw2lW9lFXBjQpcEBuSIJTtvuvj14NtHckKeoNwCEUCH3IJrI9nmhhtKNjLMop7E5UatfeXEa5BghJsYqfxSxxGH;25:q+BvBU4cq1CotDDXBFEhKDPsVWkh9V0ZSBL4ZcVuoapW0kjDfCipzlsZblL1aVhh0RClSPT3GvaL+a9USkg/jkpJ0NEYGDFbULOQnsA6mLgN4GDsqUwFfsF6PLvnVaq/m/RswfVgJzFCXBgzTb6nVkucHn1Tfdmton/HqwMAR7MfCOvUnuXaEvsPHfkEIFiqCagsa2T5qnlll2tE9DbJh8PEbEL483qrQovJzC0rthAxQhKk+QFNjJZgqEfsJWKykLJo/3tWUjNGB3JJt2LywfCfkpoD7nl9r8klBo9hi97NKosAA6RJ6A9Wsa9ETgb1hgaVHkaHgSH4n6RdXbQlgg==;31:QijlmJITqGCcPrQrkICXKi6aqVSo48JePEvL3HT1YQwMjIoZZFNQoFWlb/028/86bIGCk9M8GTxRjLrJOpbfqmJ33Nty4AaUYZdEh1k4CINII+xhQql2+H6hIygrT46WPxfjTajJsWAqwM1hVoHQtERvOcMSlYSqon2THdb3R4EwrJLWyq73ugvw+Ym1NJce2SVpMKUGXAGRjOoUcaCqAuQhPmu9Yf3Umk8gDCEWwc0=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4376:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;20:eepGcaYGJju5y5YXv+BgfbgTUmPis5lTob9+eXuQrogC0aeGJtUr5ufEU7z51zyYzrzYYvqyAyk1TtV/2MRBQRViQTxAUoRA7Ay98C8EVSzpHCDoWK4Sj7G+HA+uCyZNz+mGHEMTxylDXkKQF3XUoB+poVE6N8QEQKDaE+q1rtdUhBDvq/mKPj//fZBuorq0Czu+skytHyDXIJRZq9sq5ayEpDLCi4JU8YrFaWdy2mI0s6sb8+UzVHgiPI9Dk4zkwLi5D/+me43Ew1qy02TXCDaF2qvQCGoPOqvAd4P/Fg2E4WcLJm2pHCRJA09+guFyHR3ivwe+o0C+N0G6qB9RFJ1SQItzIyNKtQn9WJjqY2TjRSPSIuDxmB1nzn5Gm7vnuKcR8Z+3HW6puREsmRbmgFbYpuJ0ePRUYQoGK2jRaIXT+Pt5IwV9kiemkL1L7yoWUjTs7wa6NXoQUzvSW6b30sqJRuSe/Nnif3X0s0v5XF0+6CFHWHWZaeJNgCJwu+CPZZMfg8rjPmbyPVMFST2dE/xgv5iYxlKnBRo9dRsz7JArnvc6gRAmo5hkTm9ybMcBEh6oHCMG1jlYjpkgs6WfSWMYg/iLKwrlXFUk0kMWe0k=;4:tHTE1TdDcBzIdRijS0/aUgYiB+48bndYymsLFUx7MZz1h1brOowByaxh6CLSFKWVj+gPUugfnFV3FU46e3cc+/ibxl4DMt1sfc9Uakbh5zbEI5Tf1Hok1D03IKqclSbQ5lhtRIypi/bCsjZZA9FwKoXr2Lv/rMAdL7SFO168dcZuQ1jU7onCrF4sFgoj6QY0JRq4+PrVke0advGtgshgxDiFuKUZX4OkBxGpw+NvRZkQ9h06YNJa2GLzq0M1X4GVQn4lpqblHO2219r09Zu2EVW9s8z8s3HmlEJWCDyTPfmahBzTPP6nzaMwWuSEjqHb
X-Microsoft-Antispam-PRVS: <BYAPR07MB4376240A1866B85446AF2D95E3920@BYAPR07MB4376.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BYAPR07MB4376;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4376;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(366004)(39850400004)(39380400002)(396003)(189003)(199004)(39060400002)(107886003)(42882007)(59450400001)(6486002)(53936002)(6666003)(4326008)(51416003)(386003)(76176011)(52116002)(446003)(6496006)(50226002)(16586007)(305945005)(7736002)(72206003)(2616005)(26005)(316002)(478600001)(11346002)(36756003)(956004)(105586002)(186003)(16526019)(97736004)(2906002)(486006)(5660300001)(106356001)(8936002)(476003)(76506005)(575784001)(50466002)(48376002)(110136005)(47776003)(66066001)(25786009)(54906003)(7416002)(3846002)(81166006)(7406005)(1076002)(68736007)(81156014)(8676002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4376;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4376;23:MdsSWMFVPiJKnhwttPvzaoYq2eEDBjauDAv47ITk8?=
 =?us-ascii?Q?67Xrxyu98OWPpM0sHnrQP1BnLQwsWZChTwjGXEcqS3T0TgI2+Bb7UOvY69ZD?=
 =?us-ascii?Q?TioKqtfXFGk+9czYGxWWFXofIs1u7p26QHYJ6EBGqmp/icalO9oPpIapasZt?=
 =?us-ascii?Q?A4TMN2l0f+1v0+jm5hcqNac1ccevrkSxZe9857uB25nZSu9lYSATXPHzNCBv?=
 =?us-ascii?Q?Z6AJ0C6JfzSmJD9jvejDXv/fusbNm+R+kmLlRGP6O2z4qXZkgnIM/fSD8hFL?=
 =?us-ascii?Q?tfCALMvoHLigAXiMkh/m5I6PU9wA+OsTZrCfV9ljPtG9jno6tnEjCIYsR2pC?=
 =?us-ascii?Q?+r6qnmXVTpMJPYBwwAsfuChH42MSZTColS009cuxDGVyUyTS08chaAfWN28p?=
 =?us-ascii?Q?j4ZhEVClTydjfsBM9mvprVIhYYygesQxJfxINkNwg+QJgSB0Ou/hqO5taHhM?=
 =?us-ascii?Q?jwyQavKjGx/bqzfT6FglSjC+LWSCjRilLjDZsslX7c/VyWNleHPvnlLXtdiS?=
 =?us-ascii?Q?KSU9eHUq4dReic+5ZTfHL/k2xdo2L9VbhjbzncO7T4S1FUL/z1/4oaz6d+eH?=
 =?us-ascii?Q?jvfrT/XLb3Un5JvKTCesCbxT1RHr/rUSyJ/JUsJ0Z3vzcpDVfOzmXFaHWcNv?=
 =?us-ascii?Q?+2Wi0OvcWnbKrC0Y1HVTjcLbHPs5cCdhDolbsU6AhlT9/t5TE6ldzafzliiV?=
 =?us-ascii?Q?VBY17ZO1Xjyi6zgHHNNpgHu+CPZamYDthDid38CZEE5m9ACmxhCs/DLP0Jjc?=
 =?us-ascii?Q?iaZoTMSR1GCh1T1gi5MS1bjGrSq35b5txBdwP2AVQAPTpzPupYPEckAYNCen?=
 =?us-ascii?Q?Jexm5lIj9uiRV0thfGaVokwtBFpn5eLsvFPWfhz3LL9OUldXmL7UxjWKHn+3?=
 =?us-ascii?Q?g+DAa9PTpXkju9QP0P2uykhjWkpJSoVvLIlTVS745ZhRm2oF0YuvmhefwUPT?=
 =?us-ascii?Q?jxpKC745//MK3ZuLgmNqD03PyyHcDyQbyp3ZBirbFCIExN1B9FstiGKZmr1V?=
 =?us-ascii?Q?zQh6ZEVbSh+n40wKDcBm5Aw6zicGs52+78WtfVcVUv3JTFti4XXbCjHn70X5?=
 =?us-ascii?Q?zXcibKicQUBcHJK3H95AMfm/8SiKbwO0s7qDQJBsauKoJJ6HyEoyodebVFOX?=
 =?us-ascii?Q?ymCtJD1j+4TIOF9DuCJocD/I4oPf46lpuIC1UwerkY4l8WedpYgt+Gz7R9/z?=
 =?us-ascii?Q?RxuR76GnrUO0pTXew3akUxuPMZ5ySYP0v5l2vKhndZ9tfkkXastDLqzlo+DL?=
 =?us-ascii?Q?D4a1HmilCWJRSkGiX7ZzY88NM0zIWf6iIkUwmhqC0v7fpygLzbPR9RL32L0S?=
 =?us-ascii?Q?V3NjpniwL51rbEVhZlz9/L+3R3BGbYnvqmngHH1/KVGKQ6KBew1r4/I2KGnp?=
 =?us-ascii?Q?JXQrAI5yoiedFHedVMwTfoM6q5SE0czIUAcrybCetWh4P0u?=
X-Microsoft-Antispam-Message-Info: tpjw6pSZrm2NUhA5ti8jJawkIs6kpa/IScKaO0PGx0pYqwSkBFRVjxxHvoYjnUWpmJ3iLYIscHqZtmoLfjbpy8Bbxv9o4D/+/yt/NsRkWSyOnMVBZk7U+aJB0wNlPO3ZswjrsYR/BGVZVjUpbGPEZi9P2bK9zYNp//+UbS+kBY1y+zYsYfYE49Ajcr3SpZlO
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;6:/GP+h0Z8skcHtm1SI2lHI6VDMrWUGpTDJCnzlvOhF3eEovSjDXcgF+ku99YRmHVp4Kcu1bSLU2dRQtsevdjEHJkDx/6vfNQg9vMJKCRPEz3QydySAFc1mSvmRc/oMzSCBP4MDOIqdDWHjWwCpO0offznyDDuqWMG+HLcQCNqe0q1/ZU37OZxr+5coehxtMLHBbyaxBLGykgu815JQ1nLk/NSdsMekAE13tQ1FeztcqjDXb+0aoMuD3lpoa4BSxi5nQVuhyBCifvy0MODot0nOBq1mtEOhIixHnRjOb4FUzip+ToA6/iJc3fSPc+hRFUgIEgIKvdgOZUMY8C6ioHitYRs/VUIDfrtUafWjUMl8J8Kjkdrfkm5Z2SC02kjVpL2KVWyYas/AWlkGXGs/SUpCju1w0HDg4cKxeRIGd0oLdSLMVmFUeVcOE6fp65kwFRfVzRdj40ivL4OLBZRZqjkaA==;5:s7mQ6VnIW1ZKsas2ZFJVL8qGLEHQ/dD2SQzw/k6TO8pAx+C9gXjEpAv3hbg/x05Bk6vGUeSil3vnNyu8Kz4UfNMZm3WjYDTTuZYkWx5n4USoVY4N2kJ15DvXJUHDavbRvCjacd/Rjb/EnADNDFhkDtLzStMZgh4uMUmKvIGMe/Q=;24:zGe5P43HfG73Ex9Is/HNWRLFzxTrsG7c2rRLRLaW1Eb8EU6ZY3DB+5CuM6xt2jY0n8KulZ2zaO7XvsHB4V0LhdNKM3Hd3+3CNal0EHIHj9s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;7:JXnUStheu260FleWrbLOTG2jswTx6plcHLhFIm8jzub9zdB5yJ2+rVlk1mqSoJ7DHHAcDg4i3xy/nLkq2mR17sV+kimDoxg6laqhQ3xeTTp46FEkm2FdxKyq8DphIa28tonyIk8ftXPwJ9MpRKm98vU2fgwQlmlTczBy5qskwvBHg4EVWfBaNhALe6lh9L698k5m5J/dZ9I+yC2ngYwJ/isSX2gVOeEUbQl7f/ecgh73pMM/xM8E+BrBipKC/UXo
X-MS-Office365-Filtering-Correlation-Id: 2baa0b55-e6a0-4822-3af4-08d5bb060c43
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:21:38.6161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baa0b55-e6a0-4822-3af4-08d5bb060c43
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4376
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Based on patch of Andrew Pinski.

This patch introduces is_a32_compat_task and is_a32_thread so it is
easier to say this is a a32 specific thread or a generic compat
thread/task.  Corresponding functions are located in <asm/is_compat.h>
to avoid mess in headers.

Some files include both <linux/compat.h> and <asm/compat.h>,
and this is wrong because <linux/compat.h> has <asm/compat.h> already
included. It was fixed too.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Bamvor Jian Zhang <bamv2005@gmail.com>
---
 arch/arm64/include/asm/compat.h      | 19 ++--------
 arch/arm64/include/asm/elf.h         | 10 +++---
 arch/arm64/include/asm/ftrace.h      |  2 +-
 arch/arm64/include/asm/is_compat.h   | 52 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/processor.h   |  9 ++---
 arch/arm64/include/asm/syscall.h     |  2 +-
 arch/arm64/include/asm/thread_info.h |  2 +-
 arch/arm64/kernel/hw_breakpoint.c    |  8 ++---
 arch/arm64/kernel/perf_regs.c        |  2 +-
 arch/arm64/kernel/process.c          |  7 ++--
 arch/arm64/kernel/ptrace.c           | 11 +++---
 arch/arm64/kernel/signal.c           |  4 +--
 arch/arm64/kernel/traps.c            |  3 +-
 arch/arm64/mm/mmap.c                 |  2 +-
 14 files changed, 85 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/include/asm/is_compat.h

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index c00c62e1a4a3..412d7c07a3dd 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -25,6 +25,8 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
+#include <asm/is_compat.h>
+
 #define COMPAT_USER_HZ		100
 #ifdef __AARCH64EB__
 #define COMPAT_UTS_MACHINE	"armv8b\0\0"
@@ -234,23 +236,6 @@ struct compat_shmid64_ds {
 	compat_ulong_t __unused5;
 };
 
-static inline int is_compat_task(void)
-{
-	return test_thread_flag(TIF_32BIT);
-}
-
-static inline int is_compat_thread(struct thread_info *thread)
-{
-	return test_ti_thread_flag(thread, TIF_32BIT);
-}
-
-#else /* !CONFIG_COMPAT */
-
-static inline int is_compat_thread(struct thread_info *thread)
-{
-	return 0;
-}
-
 #endif /* CONFIG_COMPAT */
 #endif /* __KERNEL__ */
 #endif /* __ASM_COMPAT_H */
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index fac1c4de7898..b4b10eefc667 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -16,6 +16,10 @@
 #ifndef __ASM_ELF_H
 #define __ASM_ELF_H
 
+#ifndef __ASSEMBLY__
+#include <linux/compat.h>
+#endif
+
 #include <asm/hwcap.h>
 
 /*
@@ -156,13 +160,9 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 
 /* 1GB of VA */
-#ifdef CONFIG_COMPAT
-#define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
+#define STACK_RND_MASK			(is_compat_task() ? \
 						0x7ff >> (PAGE_SHIFT - 12) : \
 						0x3ffff >> (PAGE_SHIFT - 12))
-#else
-#define STACK_RND_MASK			(0x3ffff >> (PAGE_SHIFT - 12))
-#endif
 
 #ifdef __AARCH64EB__
 #define COMPAT_ELF_PLATFORM		("v8b")
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index caa955f10e19..0feb28ad10dd 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -54,7 +54,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 #define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
 static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 {
-	return is_compat_task();
+	return is_a32_compat_task();
 }
 #endif /* ifndef __ASSEMBLY__ */
 
diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
new file mode 100644
index 000000000000..19868588fbef
--- /dev/null
+++ b/arch/arm64/include/asm/is_compat.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASM_IS_COMPAT_H
+#define __ASM_IS_COMPAT_H
+#ifndef __ASSEMBLY__
+
+#include <linux/thread_bits.h>
+
+#ifdef CONFIG_AARCH32_EL0
+
+static inline int is_a32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT);
+}
+
+static inline int is_a32_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT);
+}
+
+#else
+
+static inline int is_a32_compat_task(void)
+
+{
+	return 0;
+}
+
+static inline int is_a32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+
+#endif /* CONFIG_AARCH32_EL0 */
+
+#ifdef CONFIG_COMPAT
+
+static inline int is_compat_task(void)
+{
+	return is_a32_compat_task();
+}
+
+#endif /* CONFIG_COMPAT */
+
+static inline int is_compat_thread(struct thread_info *thread)
+{
+	return is_a32_compat_thread(thread);
+}
+
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __ASM_IS_COMPAT_H */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 79cbc385f52a..78f9e71ad6fc 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -37,6 +37,7 @@
 #include <linux/string.h>
 
 #include <asm/alternative.h>
+#include <asm/is_compat.h>
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/lse.h>
@@ -50,9 +51,9 @@
  */
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
-#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
+#define TASK_SIZE		(is_compat_task() ?		\
 				TASK_SIZE_32 : TASK_SIZE_64)
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
+#define TASK_SIZE_OF(tsk)	(is_compat_thread(tsk) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE		TASK_SIZE_64
@@ -63,7 +64,7 @@
 #define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
-#define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
+#define STACK_TOP		(is_compat_task() ? \
 				AARCH32_VECTORS_BASE : STACK_TOP_MAX)
 #else
 #define STACK_TOP		STACK_TOP_MAX
@@ -130,7 +131,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 #define task_user_tls(t)						\
 ({									\
 	unsigned long *__tls;						\
-	if (is_compat_thread(task_thread_info(t)))			\
+	if (is_a32_compat_thread(task_thread_info(t)))			\
 		__tls = &(t)->thread.tp2_value;				\
 	else								\
 		__tls = &(t)->thread.tp_value;				\
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 709a574468f0..ce09641f888d 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -113,7 +113,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
  */
 static inline int syscall_get_arch(void)
 {
-	if (is_compat_task())
+	if (is_a32_compat_task())
 		return AUDIT_ARCH_ARM;
 
 	return AUDIT_ARCH_AARCH64;
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 740aa03c5f0d..6d2d58daa9d7 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -91,7 +91,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SINGLESTEP		21
-#define TIF_32BIT		22	/* 32bit process */
+#define TIF_32BIT		22	/* AARCH32 process */
 #define TIF_SVE			23	/* Scalable Vector Extension in use */
 #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
 
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 74bb56f656ef..55c09285f444 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -169,7 +169,7 @@ enum hw_breakpoint_ops {
 	HW_BREAKPOINT_RESTORE
 };
 
-static int is_compat_bp(struct perf_event *bp)
+static int is_a32_compat_bp(struct perf_event *bp)
 {
 	struct task_struct *tsk = bp->hw.target;
 
@@ -180,7 +180,7 @@ static int is_compat_bp(struct perf_event *bp)
 	 * deprecated behaviour if we use unaligned watchpoints in
 	 * AArch64 state.
 	 */
-	return tsk && is_compat_thread(task_thread_info(tsk));
+	return tsk && is_a32_compat_thread(task_thread_info(tsk));
 }
 
 /**
@@ -480,7 +480,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
 	 */
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
-		if (is_compat_bp(bp)) {
+		if (is_a32_compat_bp(bp)) {
 			if (info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
 			    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
 				return -EINVAL;
@@ -537,7 +537,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * AArch32 tasks expect some simple alignment fixups, so emulate
 	 * that here.
 	 */
-	if (is_compat_bp(bp)) {
+	if (is_a32_compat_bp(bp)) {
 		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
 			alignment_mask = 0x7;
 		else
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 513e279b12d3..6efbbd171670 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -47,7 +47,7 @@ int perf_reg_validate(u64 mask)
 
 u64 perf_reg_abi(struct task_struct *task)
 {
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_a32_compat_thread(task_thread_info(task)))
 		return PERF_SAMPLE_REGS_ABI_32;
 	else
 		return PERF_SAMPLE_REGS_ABI_64;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 105f79d126ee..50b1249844b7 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -51,7 +51,6 @@
 #include <linux/thread_info.h>
 
 #include <asm/alternative.h>
-#include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
@@ -256,7 +255,7 @@ static void tls_thread_flush(void)
 {
 	write_sysreg(0, tpidr_el0);
 
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		current->thread.tp_value = 0;
 
 		/*
@@ -340,7 +339,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		*task_user_tls(p) = read_sysreg(tpidr_el0);
 
 		if (stack_start) {
-			if (is_compat_thread(task_thread_info(p)))
+			if (is_a32_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
 			else
 				childregs->sp = stack_start;
@@ -378,7 +377,7 @@ static void tls_thread_switch(struct task_struct *next)
 {
 	tls_preserve_current_state();
 
-	if (is_compat_thread(task_thread_info(next)))
+	if (is_a32_compat_thread(task_thread_info(next)))
 		write_sysreg(next->thread.tp_value, tpidrro_el0);
 	else if (!arm64_kernel_unmapped_at_el0())
 		write_sysreg(0, tpidrro_el0);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 04e9b7973b28..4d0a541d049b 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -40,7 +40,6 @@
 #include <linux/tracehook.h>
 #include <linux/elf.h>
 
-#include <asm/compat.h>
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/pgtable.h>
@@ -189,7 +188,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 	info.si_addr	= (void __user *)(bkpt->trigger);
 
 #ifdef CONFIG_AARCH32_EL0
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		int si_errno = 0;
 		int i;
 
@@ -1592,9 +1591,9 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	 * 32-bit children use an extended user_aarch32_ptrace_view to allow
 	 * access to the TLS register.
 	 */
-	if (is_compat_task())
+	if (is_a32_compat_task())
 		return &user_aarch32_view;
-	else if (is_compat_thread(task_thread_info(task)))
+	else if (is_a32_compat_thread(task_thread_info(task)))
 		return &user_aarch32_ptrace_view;
 #endif
 	return &user_aarch64_view;
@@ -1621,7 +1620,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	 * A scratch register (ip(r12) on AArch32, x7 on AArch64) is
 	 * used to denote syscall entry/exit:
 	 */
-	regno = (is_compat_task() ? 12 : 7);
+	regno = (is_a32_compat_task() ? 12 : 7);
 	saved_reg = regs->regs[regno];
 	regs->regs[regno] = dir;
 
@@ -1732,7 +1731,7 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
 	if (!test_tsk_thread_flag(task, TIF_SINGLESTEP))
 		regs->pstate &= ~DBG_SPSR_SS;
 
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_a32_compat_thread(task_thread_info(task)))
 		return valid_compat_regs(regs);
 	else
 		return valid_native_regs(regs);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index fb7c1a510ed4..0a829f6f1832 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -778,7 +778,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 
 static void setup_restart_syscall(struct pt_regs *regs)
 {
-	if (is_compat_task())
+	if (is_a32_compat_task())
 		a32_setup_restart_syscall(regs);
 	else
 		regs->regs[8] = __NR_restart_syscall;
@@ -797,7 +797,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	/*
 	 * Set up the stack frame
 	 */
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 			ret = a32_setup_rt_frame(usig, ksig, oldset, regs);
 		else
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d2ebfc2f4fbc..0d6eda51eca1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/compat.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
 #include <linux/kallsyms.h>
@@ -519,7 +520,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
 #ifdef CONFIG_AARCH32_EL0
 	long ret;
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		ret = a32_arm_syscall(regs);
 		if (ret != -ENOSYS)
 			return ret;
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index decccffb03ca..65be0d308d75 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -54,7 +54,7 @@ unsigned long arch_mmap_rnd(void)
 	unsigned long rnd;
 
 #ifdef CONFIG_COMPAT
-	if (test_thread_flag(TIF_32BIT))
+	if (is_compat_task())
 		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
 	else
 #endif
-- 
2.17.0

