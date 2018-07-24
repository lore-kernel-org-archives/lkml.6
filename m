Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85467ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2753C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Oh+h3VlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2753C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbeGXMUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:20:11 -0400
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:49951
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388241AbeGXMUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcjpP2uZPyrpBMKyoE7ovrn79TPpLL+gsyRmh9ysJAs=;
 b=Oh+h3VlDMkay+PVxf7VvLaRz4rSaDMtwqE3FI0g7k/Jsx2prP//+hIv7yI6EEoABp0XiVkmr51pIGLSd3FwnFQGH0TXJUULbrnZ6QLloKtF7G8Nxw71OQHBodF8qi7Z6qGrwXRhxR0Z1j42JTI+UC3gugybDcn/m6TdnOGU0tZE=
Received: from BY2PR07CA0078.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::31) by BYAPR07MB4711.namprd07.prod.outlook.com
 (2603:10b6:a02:f0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Tue, 24 Jul
 2018 11:14:10 +0000
Received: from CO1NAM05FT008.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::206) by BY2PR07CA0078.outlook.office365.com
 (2a01:111:e400:7bff::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 24 Jul 2018 11:14:09 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT008.mail.protection.outlook.com (10.152.96.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1017.0 via Frontend Transport; Tue, 24 Jul 2018 11:14:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBE27H013024
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 24 Jul 2018 04:14:04 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 24 Jul 2018 13:14:16 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 24 Jul 2018 13:14:16 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBE0SB024147;
        Tue, 24 Jul 2018 12:14:00 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w6OBDpTJ023930;
        Tue, 24 Jul 2018 12:13:51 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <stelford@cadence.com>
Subject: [PATCH v2 0/5] drm: add support for Cadence MHDP DPI/DP bridge.
Date:   Tue, 24 Jul 2018 12:13:31 +0100
Message-ID: <1532430824-23477-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(36092001)(189003)(199004)(50226002)(107886003)(51416003)(186003)(86362001)(426003)(105596002)(26005)(316002)(7416002)(336012)(2201001)(5660300001)(476003)(4326008)(126002)(2616005)(486006)(305945005)(8936002)(87636003)(8676002)(48376002)(26826003)(478600001)(7636002)(6666003)(16586007)(36756003)(50466002)(14444005)(106466001)(110136005)(47776003)(42186006)(54906003)(2906002)(356003)(246002)(21314002)(921003)(83996005)(2101003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4711;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT008;1:EeJyEPYUMudvCTgROB6cFAqAMmw2jSKoLq55nOrYDVPvd9zgbLGk8pRfptYI+6B2YItKdX3AXI/QdbvTZeL5TcNTJ7EDNcPg5Tg3hpPRBi//HvsmyZSDTRKJC9KiZmF3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fbbf3ba-c2d7-4865-2c95-08d5f15693e1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4711;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;3:AzbWZZds81caOSyTMs0cUVX7uUyHnQpaAkEoIgQ3tyyDICA6ICGBM5ISBTzx/0e1R1W844wjPQhicbGUy1CYo3LJtNAyXUit4ZSQxald59b1YYOGOu5AnKVqWZ+KnAs/J4Gsy4XASTLFOhsrqK1SBDOu9hrWXMyMRoRXJwV3NB/HjMedm8GMlg85DEfsBvH8SBZ10zdm3LlPJvVUqBTUc9fH0/jvaGWRN+WiBlYAfrc6f9l10yImuAdyhPRY50HieWa9/uCqCLHdRt8zHGLdMwlA4IKXN5yOBbydDW5uFHreg+NPQgYQRpDA/SJeTHF3Edxoe6fMzst5vVXunLE4KmKN1dXbBqR/Q98WNvqGypY=;25:FyEiqCcFF+Q1WldW2bMHrySiLYhGOXAD9f3OG9iC4C3GZFVp1uFd5LWrEHUUXryScYFc+6KKjU4QSTSzGrHvj29KOiyXDfUo8O+vwzNGom4+SaIv8S3BOlwz/bYzttLMnskU2sLQwMvbDrZk2bAuKWQWnfruLLFW+lEcz5gjECks8KJsLvij7wVTVgFkCqKiYr7ppYAVIVS/zOpfBmpMXhit6ZJeV8ySd/FGrqVrkhpQbuzh3DNY0ducjRHBY/jXo+IdeSf2yTSJYHySlHWo+jJQWrBjuE5k2krK4uxyEc25Nk5qjXRmPQrxnSCsMR+H7OrXkJlwKpS3+0D45N1Ipw==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4711:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;31:NoQBI8ttF7tQ4thCM/S4OMUOK+FtWBC/UqR9v2AAgGfG0ptUEKq3Xmd9ioPJYOZRS2AwM0zTh4FIHMJtkETEHvB+YWJspnKp1rBe74U16GSKcyTtVS24pF1h+i+N2agTY6UCaQOBHCMZD9lXBybt4yuGK7bxWptfCb4cIiI2pPLPDeJwivGRnARIctyh1XNbOfAnRO82uHmcsqHuoXwN5QUbjzZd3nKlXbE3v0H6iWA=;20:ek6Rjxh0/c106AAP8MpU9CphhKkFuOMaEXUuyIUAXXRAF/07mNC81uJBIIdzG9LlrMYrFCDap+DFImvZhVjpIZ71mLNDVJHF7FGg41Y88d4ku3qTQ2Sb6Xc2Sx+//qJYDZGQtlo8bfxqRFv017tFAY8uB9Tt3CYuAV72uvI+keO9WR45v0ZKFiELh0GslQdmXKQsYmSweQpkzsuY0cXyyXjUS/PqLocwvACiFdaqeAukyTHUlOceHMgnY5qZE1o0hPCY+Q2erNrQDy5nubwbTsqvBDZ0ylJ4gjaqbFRvfQKvNbUUh8UayKYs8hVatUCRMKEDzIrBQ8j2q4/UTgTic7rDmZU/LyAl67ifX9tejtzYD4aHN66081aoCMvJyJ2VMzXZ9pCbX9nr+IHxFz7WojCVPdNfOl6LbD39uUBekhBX1t50/v7ZdU6JWqoolhiUtFKLFXx/3F9eko2mF6bKxzOT05T/p0hhoWbZPkigq8b0tMX2Ru7Fploeb9MQdWVW
X-Microsoft-Antispam-PRVS: <BYAPR07MB4711D9CC690B11C4EED3E629CD550@BYAPR07MB4711.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4711;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4711;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;4:kZYHfW23eID/NBFIKmK6eYfG/fc0tPHRGb4USBF71aYkQLtP2ckOnEmepAb3ckqr6+VbdNDaRrQT9bOHb6Q+FbKIXlUzaG0Wpsq7ZlhKLgfIRFcnGc1oiqxIgiOo1PndoGmgbyR9C5RHJBb1PMODzw351aL56kuJ18BJtG6TdhwygFkKk/y2bLgw21PcjHFj7L6NSV0KqMB/fvBFwG+ArqeACC+cXZ5wl1mrM4XurN2cv8BGfmBDAsJkOZRH3Vu+PE1Y5bPRqLnABMWAlDJsWA==
X-Forefront-PRVS: 0743E8D0A6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4711;23:plv91M0e4+swb/4JD0ZCgkD8XJR12lCCn0BHKFF8T?=
 =?us-ascii?Q?3eXcODstAPn/ofRDb3V19rCBHK4Twv6CsSmB9zj9zJ9iTVujWqnmqmgEghqN?=
 =?us-ascii?Q?cZ4Un6DO3+ogKtYYsj9F2e9U3qzQsgoxakOZbESlR1fV7DPOQmcN9gtN0vpT?=
 =?us-ascii?Q?tT21B9jQKK+lG0w37tISmMB9Zn+5nmMTt7ro9ipCKWNQWJJAuk6uFCtGZHnr?=
 =?us-ascii?Q?7yYmrBePM+gUZID6SdFmc5Xr2/EAD6gUqwdxCn08RLwB+JnderbP2KoCzo+I?=
 =?us-ascii?Q?WGU1aIz41rXVPAE8k/LNVHr/N2hu2035IIZhVNfhU/NNWQOet09SPWEbNT4Y?=
 =?us-ascii?Q?v0z186ao/hC9jlRLl3ItD2eYlxpD390nLez1zv1etgJVFktdbAO3VikO0cak?=
 =?us-ascii?Q?1LmEC/hqrmBTFgVxO25hLMNcD9Wx4GWdn8y97ftypud26zfEkLtySGhKZon9?=
 =?us-ascii?Q?ft7w3j21pFh8FvRVSR2JIYyGoKkxoKuoPcJBFxJBq6BWCXmemyHx1o7SEkO8?=
 =?us-ascii?Q?SE6p6QJSgubDFx1QILYZU2cFhcnyCJH6BBRYBl9V/GEF8RVoQgyy0KylSU++?=
 =?us-ascii?Q?a9loUta3fsM7JUs4WBNAlnsr0S6qzQOfJb2DT+3VpO1yk/KVYIXnFU/pi7rX?=
 =?us-ascii?Q?VudoUvPDMvwGSN2+66X+DO+oO8TMTgt0RJEjqib7rreN9/3N5httrgj2xnaJ?=
 =?us-ascii?Q?JTSu0kguKXdAFAzf32edHoz1kIrQ2XmunQCeS/v7OgUTIw88bmTZkV4nGkM0?=
 =?us-ascii?Q?vdByh5wX1isRT9HZzQNCOQd+r27VXqHnBjM432kwP6wrdE3FSK64hKnzAjxf?=
 =?us-ascii?Q?gO8Am1rbNL3Lgk15WIadhSAngC9HgVDVCNv+LgK1Nrq/GCiowD7UH9GyAxuk?=
 =?us-ascii?Q?sN8uBmVCZch6dq2trVPvot/c8kkKtH4ZQd/BI5NgrWyzsAJ2h73ik/CJEZoL?=
 =?us-ascii?Q?TSbPY7yiyrv/gOG0GRVSAQynOG6Pr4ICXrbImcuBZWvEAUV5m0a6Bs0NwRMo?=
 =?us-ascii?Q?KPtYX4cJqc3/ca+6VgdwQtBMmw7H0ZRNIhsC+VM8l/GH1jbGNYxYdYu9vQls?=
 =?us-ascii?Q?berx3csHRXAwM4StlPbmhqMmVGzxZo2EmgEs0f4pWh5lVgJDW1w+LQ1ufTgY?=
 =?us-ascii?Q?bZtVtDl8o60qGPFIkSSRAow6ETpwnojOO/m34OYUYFJmzQ0gaDywLxLTg/6m?=
 =?us-ascii?Q?VkO0pLKJJmHa7kOGJSDoaGt89sALInLAKvnAolysX+OBJMMLLqPYVjWw3OWd?=
 =?us-ascii?Q?xti3QA7zanMThAsR1zfvPOY20Y+YC2SjnZKpeLK?=
X-Microsoft-Antispam-Message-Info: Enpfr7XhANbXvfMN4brN717xHiSHYLOZg5aX69kwZDANzO9Noj1QCMPxXVbCCgPZJ9EjrHA36KG2o1x8eg2Wj27LhJWoyqvmJKJxmpi3pL3W/0NU+kJal7pZ/JMzDvTS5aLh+4GolGCIx6ovEAdWZilL1yQugSAaJuM8JLegD3FpxpfzyobtHSfcpUI8wrhobjyf/DfyPgujF/zQMgGvTAVn7AVDH9OqbNB7mj3C3wUsoq1jZsr0+omeZsf3j9UZZdibXm2INKIy4fKPcapXrTSeJk4BfXreJGc3M+74EfULNWWT/vxdz+QfgKxn/yEvO32fUNg90/znperLuaAQV+xmnSa+aydKre/pqjDtqbTD4d5ACM1iGBD7X60j3eNFITlKoAuGUKcR5qnryJ7PPg==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;6:PJwzaqcctY5LaHu/5HbU2LW0E38S2fxRL/iOASi4uFNDyu69RA/Dz58HfqA3Uv7al+KEPEYhN3/K0IWLB/TgTheUeGzz5DazAtfxTsOlfi/mNRCZ6v1aapao+r8Te5rpxH1qF5PthZ7yVd0r7+/waLI/vxwZjHlu4Pwlo6I/6kLFLLfldx0WcTEXGyEG+doVRZgYxJ3ba8PyZ7KE/ao1owTXE2M1QY5hcQbffT7O5NSoyC6UoxDqMnQuhTou7CppHgcGqNq6eBQ3s2JLdjXacSyeceUpcSp1izgfuty9ZHEf8SzTkPOqwjx7eq3HrOJaD9rr94r4z0QRGB6qW/NflwYoJ+DOtwgKTRcEEsETeOWe0pDzcLjQlYiLB1mClYbvSs/ALSUQec0VdCZzpaOwmkjyxQdgKyd18yM9XVmUE1Yxhosuji7ozGyAxCbP96+1rTbGraOxlJHRKXmn8zSG7w==;5:GzS6pzUfidPKnpgB4jpCrAS7XAgdxIWRThUb/RlY9m0fyQUu1PVI/lXJAkNAp1udrKW1VDx0i2Oe5ls/LwZWbGCPv+wJFm39/AgEM1IkhFoRzmXti0bm7rOxkHCV4Eft03yZS2Vo4rRZT/SCBaSSS5nbUqyXsREELo22c17UFB4=;7:R5uf3fj3gxvCCY/2jj3UN7vlv/qQHOzDV+B1OwiE/i08Qxw2M6L7yIAEcN0tT4WcbDIOM8tuDGv1mDknhmnFju+b9HG2ZIWtaqOtk5V/I+oe7Ie81orEexd3AAxIU5GOw24EV6nVN2DqnIwXsW6T7pU+7skfREEhLQEL1VqYKgiotLfQwSMLIfAfuJtcXkl0i/59H8Qd+IF0ZetviTMkPXvVnsM7lch2Syx+c9lA0EvW5TzD7q5n3TldlL3nymN4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;20:a9NtIFvP6jCXuTpTQMq+pDfiXmwN/26flJIQxmF9pQDHC+z7tE77Xg10flYoFGMPFFEuEbjyAcoQGinm+4bKooQPBagDoClX2UbDO0pyGx32R0KQF7tl4Re8rZFjodivmO65BxCm9KbTmqVOy3YEcQqn5eXbuynZ3Ea4RL68a47jW2ZX6Y0+hKBc0JQvDblCWkRi471cBwsxTNKd+UuuyBCyUtrqtIq7IFKAgVQyqZ+xUX8nrHghuizjhBLMVorK
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 11:14:07.7188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbbf3ba-c2d7-4865-2c95-08d5f15693e1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is the series of patches that will add support for the Cadence's DPI/DP
bridge. Please note that this is a preliminary version of the driver and there
will be more patches in the future with updates, fixes and improvements.
Please keep that in mind when looking at FIXME/TODO/XXX comments.

Initially, MHDP driver was developed as a DRM bridge driver and was planed to
be placed in drivers/gpu/drm/bridge/mhdp.c.  However, there was already
a driver for Cadence's DP controller developed by RockChip, but that driver
uses the different DRM framework and looks like a part of a bigger system.
Both controllers (including firmware) are quite different internally
(MST/FEC/DSC support, link training done by driver, additional commands, IRQ's
etc.) but they have similar register map, except for Framer/Streamer (which is
noticeably different), so they appear similar.

The following patches contain:
- Moving common code to drivers/gpu/drm/bridge/cdns-mhdp-common.* and
  modifying it a bit (mostly new prefixes for functions and data types) so it
  can be used by two, higher level, drivers.
- Modifying existing RockChip's DP driver to use the common code after changes
  made to it (use the new cdns_mhdp_device structure and new function names).
- Modifying DRM helpers a bit. Some are required for new driver, some are
  updates from DP 1.2 to 1.3 or 1.4.
- Adding documentation for device tree bindings.
- Adding preliminary Cadence DPI/DP bridge driver.

Some of the things that will be added later on include (but are not limited
to):
- Support for Cadence SD0801 PHY (PHY's driver should be on the way by now)
- SST audio support
- MST support
- DSC support
- FEC support
- HDCP support

Changes in v2:
- Added actual description of what the patch contains, what is it for and
  what's going on here in general.
- New structure. Now we have one common low level driver + two high level
  drivers - one for RockChip with minimum changes and one, more general, for
  Cadence.
- Dropped some changes made to DRM helpers.
- Updated the device tree bindings document.


Damian Kos (1):
  drm/rockchip: moved cdns mhdp dpi/dp bridge low driver to a new
    location

Quentin Schulz (4):
  drm/dp: fix link probing for devices supporting DP 1.4+
  drm/dp: make dp_link_status and dp_get_lane_status usable from outside
    of the core
  dt-bindings: drm/bridge Document Cadence MHDP DPI/DP bridge bindings
  drm/bridge: add preliminary driver for cadence dpi/dp bridge

 .../bindings/display/bridge/cdns,mhdp.txt     |   43 +
 drivers/gpu/drm/bridge/Kconfig                |    7 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/cdns-mhdp-common.c     | 1087 +++++++++++++++
 .../cdns-mhdp-common.h}                       |  134 +-
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1233 +++++++++++++++++
 drivers/gpu/drm/drm_dp_helper.c               |   50 +-
 drivers/gpu/drm/rockchip/Kconfig              |    1 +
 drivers/gpu/drm/rockchip/Makefile             |    4 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  220 +--
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |   40 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c         |  969 -------------
 include/drm/drm_dp_helper.h                   |    4 +
 13 files changed, 2648 insertions(+), 1145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-common.c
 rename drivers/gpu/drm/{rockchip/cdn-dp-reg.h => bridge/cdns-mhdp-common.h} (80%)
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
 delete mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c

-- 
2.17.1

