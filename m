Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7891020842
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="b+ZyVuqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7891020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeH1ORL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:17:11 -0400
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:33872
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbeH1ORJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=masIIo3xKNE8VMS92D58JgTW9aWNuOFdgFT3lds01sg=;
 b=b+ZyVuqdgZjsD5EZGOSgqezahc3ssMQGa8+EoIEacZjWzttHYg3/3WQwIy50s8aHn0Zw082fZTaiM09Ps8RlOAoGnVeYQxFMcrm53p4sfFbzFJw8aokO7NnGQ6thSohPOLsV3+1lDg7XUaLk5ecazpNya9+SVpOSNCiMiLEqsRk=
Received: from BYAPR07CA0033.namprd07.prod.outlook.com (2603:10b6:a02:bc::46)
 by BN6PR07MB2948.namprd07.prod.outlook.com (2603:10b6:404:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Tue, 28 Aug
 2018 10:26:08 +0000
Received: from DM3NAM05FT037.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::207) by BYAPR07CA0033.outlook.office365.com
 (2603:10b6:a02:bc::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.14 via Frontend
 Transport; Tue, 28 Aug 2018 10:26:07 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT037.mail.protection.outlook.com (10.152.98.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1122.2 via Frontend Transport; Tue, 28 Aug 2018 10:26:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w7SAQ2GS018596
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 Aug 2018 03:26:04 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Aug 2018 12:26:14 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 Aug 2018 12:26:14 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w7SAQ1Ai004380;
        Tue, 28 Aug 2018 11:26:01 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w7SAQ1B7004368;
        Tue, 28 Aug 2018 11:26:01 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <stelford@cadence.com>,
        <jartur@cadence.com>, <piotrs@cadence.com>
Subject: [PATCH v3 4/5] dt-bindings: drm/bridge Document Cadence MHDP DPI/DP bridge bindings
Date:   Tue, 28 Aug 2018 11:24:47 +0100
Message-ID: <1535451894-2518-5-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1535451894-2518-1-git-send-email-dkos@cadence.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(2980300002)(189003)(199004)(36092001)(478600001)(126002)(87636003)(26826003)(5660300001)(305945005)(11346002)(246002)(575784001)(446003)(426003)(86362001)(42186006)(7636002)(2201001)(106466001)(6666003)(486006)(36756003)(316002)(186003)(26005)(50466002)(356003)(476003)(2616005)(336012)(48376002)(8676002)(4326008)(107886003)(54906003)(76176011)(47776003)(51416003)(16586007)(110136005)(105596002)(7416002)(8936002)(50226002)(2906002)(21314002)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2948;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT037;1:0ER9I3q0KgOOWvhSXeRJg/ecWK/1lduAXBocCdzPVzk9tQp5aZZFJtV0YMQQ+QHaTbOxjrW2doQkaWptuX0zKB3hj03Q+WajEiaJvDlnAocPtYqx40t9elYTiF51D6CL
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d406b518-d2ad-4a96-3bd9-08d60cd0aa61
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:BN6PR07MB2948;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2948;3:d2RSTLBKlgX0Ao48pqgoLPpnLKF+7wsomN20Q2DpK4yRdPKVhaj2aW4EiV8OGXGVEZGtnQSYkOQPm2mAxStGv6PYvvoHxQvTW7SJbZJUdDnBxVJ2VR3C5nv6GmuX7s5yKdUpQ2vg7SpOPLRlW8TxKcUZ/l41p/wuA55wun0VgxoJjS9EORqvA/hvNAG3HyZ8wna7pZqybMPH9QQDVb+XwsWY/YbzF0SdEVmX4N2xBFPpLKyhchGbGEzrk1YU4faH7Fwj5hkWG4bE3F77H4JKHKo8ynpyzffdWOaJSTJbiaPJeuERVnFl+pC59jYSN+pWiWBXZvA+iZZuT1azUayPag==;25:4Fl7karBBnmn82PsJNdq89Phh/wIE4L9hDFFecprwy87lLNBE3TW52ylKpczvoEcKdsI+/kB3UdT0SCoH5K6x1QunGUr2dt+bPISyneVCYQkY9t2nFRLBVe76NEMdNr8mdhGy2JG8fJkNs8hDQ6NLvH/DVFealUYIvLhYCDNZXsKGWEYJU+qGMJpI1ySJUiBtAff3cr8p9zkp/6ipqZHvQLHivEhX+4JJUdvjBNqRIEYboIclEz0OArB3ZTZ0yKkA/f8IAxW7g5lan1g+x2g8PbvKK35LJk8NlfJDEHWxBBE6kBTKTCdJf4LVi/Foc2rqwl9BuJdf5TO8YonO9oMdQ==;31:RUsE5tuHxuGaEmYxcX9eMxqHXYjql8PNqU/BGjBrMzQ4XFxohgfMkkBveyifkkJ0vmZsop3suihvh7YUp2s+LpuIex6rfaSd+9m9doUaxdwvSnOImpNNNzR9m09ykjM6ePHKRz+KxSWMgxlSYbfmnnPIX3KGUQBAI2PSMmd0Nov06/GUbftgNSKIeHuNx3PCi8+msZDPgiaKwMiAtsTmQfhCuKsod1mpx4ewwX/Y3og=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2948:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2948;20:AzEgfErza3DjSweoO3WuKMdGZI+JxziUTz/KGat6bYwHCD+KA2UW6q1tpTryklDW6pBNme2UlKwsf2vywwbr3nusfXy9oFn3qmKpPBcEISmGaK/uWxYJsvVnIhshR07T60nXuVYWq+2v705HsmQHBEsUYxBTpeYEkGKcEMzGeh8pj+kGUghQlLGQtDjD0QP55TsWzbWoZsonwtzzJv+yb8EMqF7Ni7X/qypaCrZOBfRa4yg/xJk+tUXf2WQG4fCMGwJZbejMMARju/GDTkDZcEPoeCVZ5bU0iPFZKH+UhstIdsWin3VNwhs2UFj+AyieO+HL+GgpUohbiPPC500vcLwsobeTLXNkW+Y7dQwxNwHixGBw5tbnDZlKCwe56CAzrp3wwLBqcc96QrLMGeIc4c5I3H4HypBRAiGpH48JRomsRqYbrctTOVHwXJ/5xhlpdugfQmyIK1NXAe2mtYPCrtbQTpE+vhV1EDWvRVYHEIkTTcyBWaJznVOWYU8Spp+x;4:/O1pA5BFepcCTrZDWvkArXfZjdteU6u4Cw6d2660IY4OPrHCzKEi5Ssl4cZZbHspf5eNmBjuO+SHmloPJcUGktzjzE9EIo2e8OBXIJynNYes57dwuv3xOesYL0f2tDb/ERQxwNMJQTwhU1EhiRXcsMTVRul4KvhxX6/FRNIBVp/kYJe9H8BQ68XraU7XS+nPC5UuN77qzaQ1g94m9EZQKo/fsPTvJr+bb8MFsAP/AOgM9FAqHbjH0y+xyijW+HgE9H2Z8dNxKjr2LwYx2IzfUfm4TcMiM8W3G+guX4clQcO3AwooA8EVSw3p6TOHutaP
X-Microsoft-Antispam-PRVS: <BN6PR07MB2948BB59DF7AA12AA8B945DCCD0A0@BN6PR07MB2948.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93003095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN6PR07MB2948;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2948;
X-Forefront-PRVS: 077884B8B5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2948;23:yHts653X0bdAhEZ2bYYva87dIvPZoofy0jwglk3A+?=
 =?us-ascii?Q?/ekOLVRZXV1XoFJ+LOcsfl5wrTseOral4RECf8uZMEktKlsYFm2LR8TmRNVG?=
 =?us-ascii?Q?Doixi1+GoB2wmBEslus0FWR5FOfDNCJS165WjH2qNe0Y7OVSUo7XALhosVEK?=
 =?us-ascii?Q?PUw5+3H2wTmyi4ltDTdWE10lVe4FW2PktATIDPJYHD9LHE3Pel6oXs44S7eP?=
 =?us-ascii?Q?yU5bMkzit2nST5pTX3/WzAgNCJ8QPf0NSbh5kizTWsYgIcAgAsrv0V5M5Q8q?=
 =?us-ascii?Q?r6lMuLtTA4OCuRczhvrkXFBf0CE5ZNXu2iUNXNpfVSl412N3/IilUUUUfkbd?=
 =?us-ascii?Q?h2q/XQbaZO8mIbYAfR5/1UPHx+8nq2lUNLkLLCvcTCvdpSljIMOhILL7pCjj?=
 =?us-ascii?Q?T2+uz75I5pxpfAvt2lUvsWQhGc5nDGfDOZa8kPdnRqZU+aYTPSQS6RfxSZKh?=
 =?us-ascii?Q?Lumvn1NyO/OiuVGZLqkOmbjuIx//Eh/qePTln3pxxOZ9dj3186IJwYounYXg?=
 =?us-ascii?Q?WgVJmq1iXIKlK9jCqto3g8I4XwJRZIMg1Blg5uxQwc8XuG6/4kWgGdnLyH7F?=
 =?us-ascii?Q?x6YAHGjUFQ63fyGupcRAitx46u+mOD9EZWCYRmMNdw28eABUA3b1CefVrxq/?=
 =?us-ascii?Q?qzoFDVbDPF259+kJmxdgRktt4BExMjo+/jsehyKfd7UDwoRzM8NOMtG22E8x?=
 =?us-ascii?Q?9E7m1Hh7By7+ECQ68bt3VdIIRWgJr4+V2ufwsyt0Bed5CTEhHt+p5qJyBfHx?=
 =?us-ascii?Q?8g7ChYhbagbF5UHD2m36UoJ1ctB8FziiGM+H+GVBDhzd69xsuvYbIWAI/h6c?=
 =?us-ascii?Q?XtxQ7Pg/2RyOZNkMHfH7c0Q/yRxFeikXYko8RQLKanmAx3Juk7fpxwE2Lz3h?=
 =?us-ascii?Q?CTmu/GZ0Z653da7r4XS5+rRCH8WpKxjZkr6MfHa4vaE52xkPrXrxjgxTs+Db?=
 =?us-ascii?Q?//NtS8q9UvwmrksBY23kkGG2zHjun9uVHeB7Xb+Cih0gXoob8TR/XyGsuKtu?=
 =?us-ascii?Q?78nS01q6WmMwM3pAWlNnQBiPtFIrESnwX89xYMY/Qc7+0YaLajPK6jWlBzng?=
 =?us-ascii?Q?ldnE9Ys+P0PtgrKTOWJCp79TeuveW0gqzz4lfHb/EdvmmZlF01tKjJNJD4rW?=
 =?us-ascii?Q?9DLmyPI8UidFb2G3R1Gyh5W+qDDE7KpliQ3UeK+ZA5demoaYorQNbO8Iw/5Z?=
 =?us-ascii?Q?6aTdoATQ7HEQ0LYJZ0SLDAgHpVjOl5sPG7edtRli5aWwRpPmXjE3Boydw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Twa297XzmJBvNA+JRd5niSFhCmWSKC2gIu22NgixO5niwTjg5J4GWtza/X3X07R2J4eh7rDSruXR4oHhftACpB8wfLQOP6e7ZGaMj04K7aKzYe3x9pu0/ad6vI3tobo3x4tPPA5JBvphXPF9eBMgLOLInd78Bx1F7sTjnsDxyELMpS9vwyFG/yVG+KyT+/lfKmyAvBtgED7O1zfPTSGxBZcZmhK0M/EHYuYoeugR1m481UtUKXmqhAuLhcxZ6g/Fnm1vBFleQGvvG2Z+wK0D0D2QEEUCQuwxBNiuAcnfjd6Fp7ocjf1b9yt1ykAPpiMEChQM4Wog1M2qxxwSjbDY2kHIT7TSrSqh5ME+hGWfICe9JMAgsGog7dOMeuFXY3eRT29hPSZNw0O+bu3aNvlFxA==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2948;6:Y81LoCUbNvyXGACy/NuXLiAN/VTb0uzXG8qBJ/B40hyvrus9/qrZ4DXuYHM8rliAkYdDV99HxuRSia/CowkiXAE7tapRKZU5t1/gZY/2uLOsPLGSfc365nNqyIoC5/sVUVlvcKGd3jh1QkXp7l9OaywfrNn5mPEjhtsEdAHOc5LTt7YoRip9TPpLy1qpZPhtsqbs1E0iW4QUf89g3HK/wJRUG9k9GdPknm9OVm/BdXlAsGEFbSO+B8nM2/iiM2iJkK9nvuYKymT/imHsmN9uscNhkl+jHajLTU0LILrxZ2ceoMKBvbqRnijCN7rNgPJtDKONOQUStZvmvGxeXi6PCIwb01Z3mL2gG86B5mGp2Mjr8YRWMM4AK9RVq9qJlPwocxYs5Mkht+EdDgnraaKF8xsmd6xZaT0aKBW4u5XDfy9onUe5xfAW6i2KfUIso8YCnrz60O2NyIWZngdrP4dtOQ==;5:cpQTmAxO6/sGNkNFjZkpomExdh1xrhLvejh5vcWvaltq7hy8hviBcdJaJBFHnECNxb5U2WaiFihtuvmWdRgUprh4h28V0RUF9dh7P/cAD4K7TgHafFqVuYWcgsq7finYomtWxuP2pwAgSnucv5zcSNqcXCVSFjvWznMJhX7p2Ec=;7:Ev9efoOdnYHhnhv66JLkhiLrZMESMmf8ZSeHepWIo9Tgl/UP4Gcb/0MH4q1PLjLqVOxY74EO3kE5EqfgG03MoPs0ELtyTdbysSlSKKmktxScUMxAEN9Jp0tWwi2vveUniZTm2nH9/UZARm6jAl9AHcXKXlnx9N5//k+++jk9atDK1CoebkoVnfetjxcGS48bw39zB9709aIvfaE+qz2EzByR/uLGCX9tromvdcyYhX+c1oQNsis8bZ2Dpqd0Fi20
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2948;20:aH9GqsxnYB/eb2XiDBfDdWJjyeamXCyCfxucc6WAT6j1mul/o/DstWIX7/ImUj92+/q7zy3OnIWXah0dCliokEQ+uZdiHnEOs7aA+jjWKkPMoJvnJd/kfmOYAaBtrcCIK3H7Rt0/RHIOKUJYKokHC1auxkNBCdXxYpfK6WJqmZtLjxy/nr7/NsKqWA/Heg7O8SRD4+o0dPrWO76xrAk90pIyC+rWKlpU+ZsLdWg+jEfu51pawRG9TL3BiuGsRxpm
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 10:26:06.3077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d406b518-d2ad-4a96-3bd9-08d60cd0aa61
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 .../bindings/display/bridge/cdns,mhdp.txt     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
new file mode 100644
index 000000000000..f8334c520b98
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
@@ -0,0 +1,43 @@
+Cadence MHDP bridge
+==========================
+
+The Cadence MHDP bridge is a DPI to DP bridge.
+
+Required properties:
+- compatible: should be "cdns,mhdp8546",
+- reg: physical base address and length of the controller's registers,
+- clocks: DP bridge clock, it's used by the IP to know how to translate
+	a number of clock cycles into a time (which is used to comply
+	with DP standard timings and delays),
+
+Required subnodes:
+- ports: Ports as described in Documentation/devictree/bindings/graph.txt
+	Port 0 - input port representing the DP bridge input
+	Port 1 - output port representing the DP bridge output
+
+Example:
+
+	mhdp: dp-bridge@f0fb000000 {
+		compatible = "cdns,mhdp8546";
+		reg = <0xf0 0xfb000000 0x0 0x1000000>;
+		clocks = <&mhdp_clock>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dp_bridge_input: endpoint {
+					remote-endpoint = <&xxx_dpi_output>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dp_bridge_output: endpoint {
+					remote-endpoint = <&xxx_dp_connector_input>;
+				};
+			};
+		};
+	};
-- 
2.17.1

