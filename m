Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id B9vdNeVaGltmZwAAmS7hNA
	; Fri, 08 Jun 2018 10:34:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5CC77607A4; Fri,  8 Jun 2018 10:34:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="EOgo4eWv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B7852601C3;
	Fri,  8 Jun 2018 10:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7852601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeFHKdt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:33:49 -0400
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:24715
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751195AbeFHKdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qsc4OBYjuOd7NqwC+SYnFs1XKNCJW9WuNkq1RNus40s=;
 b=EOgo4eWv6I+BPb9CKG5PLDgd1TdR50x63a5iXQQZu3VoD6BNsDLRLWhqV06XbJDKvLgb8qlCSBVKsUSh7cuCiVWJSpRy2Agl4VrWeS2EAv1c8ZBsViby8tRQdGJundhWMVLZgYrX/Vp+bOUdbeg8OHoavitsC6o14vEP8R6WCSE=
Received: from SN1PR0701CA0059.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::27) by DM5PR0701MB3670.namprd07.prod.outlook.com
 (2603:10b6:4:7e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.820.15; Fri, 8 Jun
 2018 10:33:35 +0000
Received: from CO1NAM05FT023.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by SN1PR0701CA0059.outlook.office365.com
 (2a01:111:e400:52fd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.14 via Frontend
 Transport; Fri, 8 Jun 2018 10:33:34 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT023.mail.protection.outlook.com (10.152.96.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.863.7 via Frontend Transport; Fri, 8 Jun 2018 10:33:34 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w58AXViM022565
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 8 Jun 2018 03:33:33 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 8 Jun 2018 12:33:43 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 8 Jun 2018 12:33:43 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w58AXUT5017021;
        Fri, 8 Jun 2018 11:33:30 +0100
Received: (from kwitos@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w58AXUCC017020;
        Fri, 8 Jun 2018 11:33:30 +0100
From: Krzysztof Witos <kwitos@cadence.com>
CC: Krzysztof Witos <kwitos@cadence.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:CADENCE MIPI-CSI2 BRIDGES" <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] csirx updated doc for csirx with dphy supported
Date: Fri, 8 Jun 2018 11:33:03 +0100
Message-ID: <20180608103304.16054-2-kwitos@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180608103304.16054-1-kwitos@cadence.com>
References: <20180608103304.16054-1-kwitos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(39860400002)(2980300002)(199004)(189003)(36092001)(42186006)(486006)(16586007)(36756003)(7636002)(11346002)(446003)(476003)(126002)(316002)(2616005)(106466001)(6666003)(305945005)(426003)(54906003)(8676002)(105596002)(8936002)(478600001)(336012)(87636003)(575784001)(26005)(15650500001)(1671002)(50226002)(109986005)(2906002)(48376002)(86362001)(186003)(4326008)(51416003)(26826003)(50466002)(47776003)(246002)(5660300001)(76176011)(356003)(1076002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3670;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT023;1:qIucez+Lk9oYi/rGkSOlhPS2Lk0cgKvpnaL0Q28Al2n7jq9zhgoh87ECMf9mPQ8AKVuv6aSWE4szyuSmg7MeY4lMQ65+0GwFx8Kyzf4y1rsdio9ZRLcAupQlEbuxmPXi
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR0701MB3670;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3670;3:O7g5/9d5yRc6RLE57eurt33bq0y1+dvaYAVOCAcY2k2rC1SjI1Y9DxFpEDRN5OapR2l7s8rRLV5GUE2Wbhy0GPzBPbkpAWBGOD6zBMH7izll4aiHZ39fFMNtXGT+USKv6NbXNhZZy8lHQ0VMWQhmyeIxcWLvQHTYymnvDc9EyHuKtRzxz05wJqhNZ+d96wagL6t4JgW2sgu95GYhhHhjfpGJ+jhQEwupJjd8V0H/MeMIkR7qi0B/TRb7rT0Uw5zyMABl9M7pcgR83jyhHFCP7vt6ixsLZY+Ch+uOvbf52Auhe8YE3mV+wLcQVqug4FE4QCj86+rrvRJkIspKhbD+wV91BSzBFAfIpTqmP08jrLQ=;25:RZe7e6B3gORizJkR7qIyNt+g1n9DkftPq2Vm+iE3W5Bgo2ujJSueBNhf5Q2ZMTA51Gp0Ou9fheVDNrbs1kboRhiU91S0BvgXXw9mzIhxYClr5KZ82pa+BFO2R8UNYUpK3dgFSkIYBlGr+P/G9LpGQ1srxbTlKB221v7ZPxNcqnyS7zMduYSVLtwe9ZjK2Hnwfk0r21D14lMyZBQQWYclu4ZeIpqK/Bf7BKnT3z2G1JA2kpoOCnCZBOlYm4iqbrCOb7IUvuu8ZAMszEovc0kl5UH/Ne06icThWHuXaJGYqXLYBV/FJ2QefwQdBW9QicpqRh7IFd3CfKGrk7pQPknYHg==
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3670:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3670;31:7OnO/NO9KjlGvIZHXM/fqPpkp8Da2z0472nG1xAE2IimyfYwdZMaS6Q+lA/h/B8mFDFCPbI4s/8u5sy5ScbFVNyejp7kWwADXInJXh7LgC/3HlR3eXLL7BRLm2NfaadGMtvs0T2VNQ8mI7ywhxsRVz8BSWPDnGlUWKj58cQRzMQnRCbzrqrNlKbQp3sBl/eO60qDjf+UZtC17Sc6ECMZY74DMoyjp+yNQJI5q5qOdSY=;20:hez3i/2BumntGnJfKOaxZJqcPPcil5RqsxOAmBEBgyqh3HZEIOwDeeGxR1MdgGxoyp4feh5GgL/i8VymeSuA4+KmbRhdQhY2qvD2+NOrA8j7NeT83fqZZmWPQWgPd+rJ7PeTJ9Pq10ACFCgTFqCCrRgJKcRe/74l+cLwgrzI1CdNIxUa4enXbk34ye2phX8x8hLp2ozOonfsnvvB6d71PoXVxLOh46ufzdp6eEQq5mM0B1XHZF/eSYH6RezrYMGXg2x4LDqZv71B5kKMugnRvZwk+30cvUQmcUxXG4I+ugcd8csSiYGBBtSQClUMT6kLk4CLJTfQRwUPejOgtKwuudVkBmSQdv9Uo2Iw5uedjXcm2jNXLBPbFyJER0mvDeDxXF6qYIrZSzfEQZLnOs6Lcg6snHMDZ8t1whVCIZ3WDKiaBBrFoQ0KOSqq4GSCbtnMW8iuFGC+GqSRlIhOmX3qxKou/MnJYc60303qGM4nia2iNlEpUXWdJjYwzgngOxG0
X-Microsoft-Antispam-PRVS: <DM5PR0701MB367012BF1E1722942B990602C37B0@DM5PR0701MB3670.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR0701MB3670;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0701MB3670;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3670;4:I5BDcs5eGtUwAUtAnrJIGTYnDcWRr5S+IFSo0UQcIjWdsWxKlWy/Rfljq2k4G63qOzcDSkOjJM/jgaDKy7SMIzJvPfDhZH5NCBCepfovVVUo24kWLT0tvu/s0PwvJKJIPIr31fU5Z4JynBwRygRG04sJOTMEcSO7ze/WglP/Y0KXkiBrGfejqWF9qfl7eSBsQQRTWxERQXR1dx7674Y1nyJvBp0iI1lBY4p4Huo46u067Thpp8hqlUqDPBa9uBt5wLjwp/D9TBYnBOCCL72v/sTQ0MScuNZujXaWqMeTNCq6P46eHNLz9Wviy4+izJ0/
X-Forefront-PRVS: 06973FFAD3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3670;23:gCTn4wheUZ/L6uaud61pQZwzQJQ/OIdLORH0Ez0?=
 =?us-ascii?Q?VJQB3nuEA0U9oZjSJKQEQJxiRymGnU4sRgc6tQ/l1eDw8FqDDR8TfiW6piBK?=
 =?us-ascii?Q?PhuOCSjdF+2g1wV+B9qS5ecArzxf3QAywkDeWgGlBdMc9813/A73YYxtS2tV?=
 =?us-ascii?Q?oXlbhQuLplZ6zZAW7z2knvLU1rnUYPo061zo1OXCAvXqL102oqYgqiOX+UQS?=
 =?us-ascii?Q?bDKCF1Bl2P1zvf4z/+H2761LOso7PTOvGbu4n+PEZCEsKKF1eQyFJOmg+mHh?=
 =?us-ascii?Q?1HkIr4oRNAGqQEk2YpUa4c2H3XL6tVmhmaiH0uESRcJZr5rxYVLjk0CA8lF/?=
 =?us-ascii?Q?6fiZxPkcCAXBKXOUvXKa26pthqsxRjQRSS3EjKghXAU8JNkChPe/4FvDrSEk?=
 =?us-ascii?Q?9CmGoMgVK08z9gEorH/i2B0hVhFr3mkmUfLS5uESR7YfskEl1dJ/+7oSuEHn?=
 =?us-ascii?Q?VAXyId4QXzIrCUl/3MJDvEUlpOvMByo0eD797s+dt10QMSMxjt8TrymiDj5M?=
 =?us-ascii?Q?UtFDIq1O7G0CgSK8xr7hvIeHtPPoWWgv/QE2WAGV9c1KpfEkl3iMr/iYUMg7?=
 =?us-ascii?Q?QWUiXEknqCwsP728DFvwI5cLK9yBym8Cc33ZnU2ZoPQ7UYLuBL1wARnpxLh/?=
 =?us-ascii?Q?zz35S/W79yvbWZomtpvO0jjG2WR9JgOEFMmmDWGn24IAm3oBHXxYDUwMU9Gg?=
 =?us-ascii?Q?kRkmyPwoZGQt5SzkIJ1954SUrfVF5LD4MVFazOi8nAvymlXOqz69WXKWVaMb?=
 =?us-ascii?Q?xitHA27tFiQHE70rOW7P5pbUCcqLyC/4qfONy6jGayrg4b336LaI+ifv5VQ+?=
 =?us-ascii?Q?PVf2yQj2x9FqLD8vaoYXK0aGDl1PV9fxorZg03RM1/ZoGLDqfpJmzgA62YTY?=
 =?us-ascii?Q?jqpA1WTYf0xGJikCphQYRysaB6+zYG4CsCRYmw8btOpaHB6BFv1+wQE9JLWq?=
 =?us-ascii?Q?/yPsiN6ebAZ1Zt8nhv5fS7Zf28vgmYv7D0O674wja0b/4XzqzX9lGZ2Unvea?=
 =?us-ascii?Q?zhSGJ1DdcIHyG5fMqj0goN0eCXJCxKtMRXzQagzOxr3LGvITZGU7XWxQtl6o?=
 =?us-ascii?Q?5jpkb1OFJreMc0lYRJcOTZ6aQnDz382B40cElwhiI0KFonVIBXWbzIi0XDtM?=
 =?us-ascii?Q?7dvj2yTAkm6aNO/bYSpqMrkEuTguAHYWebIKkzGqUO7UtSaHzcmITLg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 5ZFV27fU+aLt38AoEfQwxg0iaE4hhdDB7aWyFfTH1Ccd/P8zsx7A1m0iR4wwSYzjdUImPHOYIqtdsVFvlnyaanMsu5s2Or+39yDmcPWUPMFvB1Rb5+ZyQOO2FQ99hEvjRAezKlwtnSZHu9nTLOTJyw6mw1d1SqHPxPawxpCzFUIO0pXunjlcIDI6pR8ZgXJKuGzGj2wdgX6g8MhCZJPjiSC1z8cmjDCxeswiF5qS1mk3Gz3iSEEeqZ3tT82fHqh6
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3670;6:dO5SB+AezcbNldqP8iZBQ/CJQCDhy2Ax0PagNifC+YUnQSEJml/4Y3bFG2r7IvLP3c6BZK7LT+2/zsGbkRTZSomcAcIz6ju1uMmE6aLq7pyDOF1ek5p8YrZeA1sJ9J+Mp4MBJqJvS0c7011i2na3tFdjKoyX0pHWSRQaxU/r3W+ayRjBns2ZEYFyh01sittSUKyd927mH5oG+5c4j/Juk/XUEtpDgKXPUr2ULG31j+MLACNlbwTrX2FpbZuIFplOxEn914hOq38Mx8GX+sITPi0t6fXqtDcbF23cG+Y+Lu7McDKJbpTRAbMhg61Jm3gZZOxkoEDFut4/jaOBu7Cds9LzV4TVnsFsyfTcG4pCmpKfKkWpU2Vy+/xDpeUFT4ky01UWhmMK9Kr/8lu9tO4LJdf88/TKLyxx2WRVvQuI71kuvd/9D4QdLM6+kKgY2jGVpe/n5D9FSpKHcCo5D2eR8A==;5:zfpbZl6jnVjJVKIJTctfkzmU5AuvEKnBVHcpwU5uam+lN3xLLYVAH6WjYocNC3iSR2psce6XVPHvHzZHcDvPRQFBiicVah0eRirzyokVemlriR1wfhEUfuQZNWnzHAl+/DECSdzyEEZwvArGjz0YlKM29C6kYphtWumNoeNng/g=;24:dO/ZAAGJdEgXsmg7MkYR3hi/zkd2vfyFsnaPWOGg3uFERxFc8z6M0+gNvmIM0S8dYfq4yAYgMkM9MgJ6AQhAsY+26/AsG4xDme6jfpP9gUI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3670;7:Ri6+QttEv+/3DumyEbF+AILmzFSe/1LgrV3Xv4OB/wNgW0wvGCbwivyYrSAomHavYcJhcg9/eoEjb1eQB8RIOoq+PGlsiyWLioSJnIFd0GacscVTj3xzGmcHJfftxACY44uzTxHV1XaS7/evYqtpApTUoXfB5H9HFh7N6bnK0D1xq4enG0Xm5n6ibr68uG5ifV4JC6kxNnouowisxTCJ6NDse/2nHpar4qCEHBmN99gDaswWpb3Egrsu7A0pb103;20:/OoVNFfCw90iqxNYd50lzuVEQcZhpnwRms+9bdET/uLRUPZRCjRps68cwfcN0EV6PmGFPf7hAwACMVN1TC4x4kKxl1twZaxyoEMOF3IFic5GrjC+tzdvS2KQ3lIaV1bfUUCQqbFYzSimcVs/q4hemlzg4SO11SSL6/z/gugr7lJ2dAZoDl7EhCpVuOzQIajVd9SuDLEEPd/jqGTmTfP9PpS/jyzEJDD0GLDCjINKZ3/5MiFeQWQ3XsRaCYKKTuIH
X-MS-Office365-Filtering-Correlation-Id: f5dc58c7-d2a0-42c3-b920-08d5cd2b49a9
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 10:33:34.3128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dc58c7-d2a0-42c3-b920-08d5cd2b49a9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3670
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Krzysztof Witos <kwitos@cadence.com>
---
 .../devicetree/bindings/media/cdns,csi2rx.txt      | 32 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
index 6b02a0657ad9..753b967863c0 100644
--- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
+++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
@@ -13,8 +13,7 @@ Required properties:
     * p_clk: register bank clock
     * pixel_if[0-3]_clk: pixel stream output clock, one for each stream
                          implemented in hardware, between 0 and 3
-
-Optional properties:
+    * hs_clock: dphy module clock
   - phys: phandle to the external D-PHY, phy-names must be provided
   - phy-names: must contain "dphy", if the implementation uses an
                external D-PHY
@@ -38,18 +37,43 @@ Required subnodes:
            in the design.Since there is only one endpoint per port,
            the endpoints are not numbered.
 
+Cadence DPHY
+============
+
+Cadence DPHY block.
+
+Required properties:
+- compatible: should be set to "cdns,dphy".
+- reg: physical base address and length of the DPHY registers.
+- clocks: DPHY reference clocks.
+- clock-names: must contain "psm" and "hs_clk".
+- #phy-cells: must be set to 0.
+
 
 Example:
 
+dphy1:  dphy@fd0d0000 {
+	compatible = "cdns,dphy";
+	reg = <0x0 0xfd0d0000 0x0 0x1000>;
+	clocks = <&dphy_psm_clk>;
+	clock-names = "psm";
+	clock-output-names = "hs_clk";
+	#phy-cells = <0>;
+
 csi2rx: csi-bridge@0d060000 {
 	compatible = "cdns,csi2rx";
 	reg = <0x0d060000 0x1000>;
 	clocks = <&byteclock>, <&byteclock>
 		 <&coreclock>, <&coreclock>,
-		 <&coreclock>, <&coreclock>;
+		 <&coreclock>, <&coreclock>,
+		 <&dphy_rx_byte_hs_clk>;
 	clock-names = "sys_clk", "p_clk",
 		      "pixel_if0_clk", "pixel_if1_clk",
-		      "pixel_if2_clk", "pixel_if3_clk";
+		      "pixel_if2_clk", "pixel_if3_clk",
+		      "hs_clk";	
+
+	phys = <&dphy1>;
+	phy-names = "dphy";
 
 	ports {
 		#address-cells = <1>;
-- 
2.15.0
