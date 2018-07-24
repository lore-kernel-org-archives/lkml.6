Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF7EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7E720875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DPePh5O2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7E720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbeGXMUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:20:37 -0400
Received: from mail-bn3nam01on0041.outbound.protection.outlook.com ([104.47.33.41]:52128
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388241AbeGXMUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtN67qSMds/UkL+NdUwoEx1B7qDdOuT7N4CtyKwyWk0=;
 b=DPePh5O2EFV0y6RYe8tIkyGE8KMAdPbWMgchn1XLH6PVeK7LmlUcutnUdZVJ9lHDddj1Cl69U6dwQB7c0Ae1980GfcaOk/6XB0ENCQ0Y0k+ywCmX2ScPW2ClMoCTV6G0NVS5cCo20nUyGyfO8R+nOz1emq62FkS2b/7L6nzjxCA=
Received: from BYAPR07CA0013.namprd07.prod.outlook.com (2603:10b6:a02:bc::26)
 by DM2PR0701MB1344.namprd07.prod.outlook.com (2a01:111:e400:5119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.22; Tue, 24 Jul
 2018 11:14:24 +0000
Received: from BY2NAM05FT025.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by BYAPR07CA0013.outlook.office365.com
 (2603:10b6:a02:bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 24 Jul 2018 11:14:24 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT025.mail.protection.outlook.com (10.152.100.162) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.995.0 via
 Frontend Transport; Tue, 24 Jul 2018 11:14:17 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBEE0a017782
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 24 Jul 2018 04:14:15 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 24 Jul 2018 13:14:28 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 24 Jul 2018 13:14:27 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBECFJ024744;
        Tue, 24 Jul 2018 12:14:12 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w6OBECih024741;
        Tue, 24 Jul 2018 12:14:12 +0100
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
Subject: [PATCH v2 1/5] drm/rockchip: moved cdns mhdp dpi/dp bridge low driver to a new location
Date:   Tue, 24 Jul 2018 12:13:32 +0100
Message-ID: <1532430824-23477-2-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1532430824-23477-1-git-send-email-dkos@cadence.com>
References: <1532430824-23477-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(189003)(36092001)(199004)(107886003)(53946003)(5660300001)(246002)(16200700003)(87636003)(14444005)(7636002)(356003)(48376002)(47776003)(11346002)(486006)(446003)(336012)(8676002)(126002)(26826003)(6666003)(76176011)(50226002)(8936002)(305945005)(50466002)(106466001)(426003)(2906002)(36756003)(51416003)(105596002)(316002)(478600001)(186003)(4326008)(476003)(575784001)(7416002)(110136005)(26005)(86362001)(2616005)(54906003)(42186006)(16586007)(2201001)(921003)(1121003)(83996005)(2101003)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1344;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT025;1:TehsmnIpT8z/GVQM+W+eiJW4VBb3r5gIfzA6KmylxBlFERlj/NIu/oXgS+uUxlvHE9BxFnZ7LS1JlYPb3PtN6DcC2qdGrycWMtGCz47/u8tmSWhEFcOox7UbKMgtYHPK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5236ad9-f1ab-4c42-d31f-08d5f1569c45
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM2PR0701MB1344;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;3:k52m0grwy9lZopBXRkc2Zt2A9zCpAEZVOSJgeu8jimI4bCw/a597fQH6CCBjYyNztBYohVtKCv/O7vcRIacPhFMJT5hzyutgg/zkj3eRjq8BRAfCBy4hPOwXRjMEeTq7FgXz+p3h4Ph0XODjJAFPs6O14/ji0F/sqGMHBYMVoIXaYj3W0gEBf3Mip3vV+fXPki6C9GAG1zRyeT9IufpbTvUGhKbZsmNGEt0JUy47yy34R3X2azS2Od0fKtFkTJqGFY1vSBhlPb2bMp89kEWGtUu6QfFIVvTG/3qvrA11/1/l9UPR8VRyJRt7vSODCEaj9ntr1DnNjizPsv9pCEkJ/KHKf6Em2gmQ02RO2X4AFGo=;25:QfGg57JNt5zTm5UsW0zkWyt1xuYm2F1z8Nk+M1G59d/9pc/rhh621CSOodSR1XXpgdgzmCiCA+leCvq3eerS5sZMjGcsvDPJLsWKygPULh4mmMj/M16AGBWv0oLi3hwXuyBDRMgu24MqK2NfJk6O2nBd0bH5zfkBV0Kntn4wxThUCZtnGKNrJs/bdtrJemunOqNnWqwPjL8nX9C5KdzG6AdOib0q5WPR3cJnDcNhVpoXqtiwlxc8pz0ME0HbLx93MUBmUqQNR7X8YnPJMU1t4ucvhIDWOPAuP6riZfEW+Wgpdi+02dKW0qAxQp3GfNlBJ+FP+RS0Ekf/XyTk2xDw+6hwdJMzSRnDAtiLAq4DLks=
X-MS-TrafficTypeDiagnostic: DM2PR0701MB1344:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;31:1Lcg4jmvk9QZgFVDBpr1yb3sDoROFuTmg8c1w3At4yNrgCHdKpYhJkymd9/54ytV8XX7cgHaA5oa3Tf3V58VOhF84Hp7i+/f8YW99QFYxxznsvOS0U5eOcbEFPYhqHU9IW3AXu6luMBDWVpgdogwOvrXVRyUdVq87pSIYFoFrIkI2XVaodlV/VxkVvAs/NnX7IY09e/s/2l2BQdp7VC76+LqdAVSEVhwfphEkcZcHOA=;20:f6s5O3j1+eSADP6BtiXPsAbBGw6cuDSm8acz+z9mA/dL761oRy1qvFWxHTWZr0OexkZzM2nbXcJBKN2bGZRrKC4vBSmdkinnJKKZgRHC+AkPAHUklz+DdtN0Q/nr5XZfeCGwvp9yKrDdVnZpze9SzD1zETlE4LlgnnTpui0TG4uGKFbi63GAkFqfDd2qMaHsXhHLk/O03vwdcAXl5L2Y3DQB+rOeO3//TAHF2koWL8VFSbMQIIOWqI438/a4fG/iHu2ZT0omBoGb9A2+6Q0TrjBQtkIZaN5VbYohbrYkfZgy/Boapx7fP8k/JfbKdxb6SefqXPC6VH33TTrkh2Y1463c5tTCT2puVHnecCKtu/Neyq03t4oM5d6n06oWeQuj4SdT7DB6/gcNkzGIVn7z9W1JA3rKrqqYe64XQaIAf/uPi+HRkv60jqws8Ik/MGR3zmYvQ0y+tHlirumS5KOeZk1Ujp83vWtbsiRzEVSUtrCBpAJs2llulZxjIHwsBdZN
X-Microsoft-Antispam-PRVS: <DM2PR0701MB13440F63C948D70A590AB74ACD550@DM2PR0701MB1344.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR0701MB1344;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1344;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;4:zw43LWU+srUMUOvLcBI+4dsO08c+IHboipg4QlWQi3H4duXOy7NxMqfQ3nTHJjDHViGLIFZarVVSUaq3MpCendSup0RufnO1I5RJBEwkocRZ6Jp7r+EhIKpxfY9Pni+LXK8Q8OxEbYXnb1lu/MRVsiH+1e/eH1JJEx3x/LBXG/hDZYkrQ86+uR1zPNyJ6IVJOR+SNTXcj+1wR3Ytr4bJXlJ1RsTm3XAZXZ67egbm94N/23vYLeZ6G9f1kFeZdALWrfz7SP6zPSekNd8c4v2EHIIYjooZWoziT/mlb33p4xWgBSPJBo+er+WVL5vkGLTz
X-Forefront-PRVS: 0743E8D0A6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0701MB1344;23:SsZKuGhr2O0SUoGv424RFdZKNxKbv54JapW81Fj?=
 =?us-ascii?Q?Fo/eSpj8DK5GL2G1ZnFGNVrY4nph21JpzDsPcFLFXP41PhrPOak9VvhA5qNW?=
 =?us-ascii?Q?xRCHU3NSN9+vRcnQncpT7V4Bz+2+kCtkyz2RcC/iZ6uT+4OwB2hEmTIWFsbf?=
 =?us-ascii?Q?6m2J3paUax9AALYF42S240qpBfYyLJTiKLikmvvw7G7rjmTqfMngcx2NmQ6c?=
 =?us-ascii?Q?p4sioUz03+RUn3CQKy4VeNAoK1nKH8j1HMnnmnikGha3BFZvdpWyRSheXdPV?=
 =?us-ascii?Q?bHmuZ0ng4fVJ16To+KlnKp2WG9b7ctoUdsVQBojgva835KS2Qbb37iEldSY9?=
 =?us-ascii?Q?HZc9wFb1DbXEaEkDSA7ua/OEJsRhA9OBIKndbE/l+WNCuNoypWdlBMCHg2Sl?=
 =?us-ascii?Q?WymqAMhDqEdJpqIsyjDKdlG0cZS2rBmxQ+LF/4DKx9rEekYdehgWyGbblYSZ?=
 =?us-ascii?Q?PjqwWrfCOhTr8YLv+5japF7L0I/bXKx7VYerFmQIPvu+2wdfdThsYr5IrO5S?=
 =?us-ascii?Q?IT9PdSlDLSnBo4676d3kRBe9oi/OiLIMlyCsHJlKXL8DQWHzxa7xYtY5VR27?=
 =?us-ascii?Q?HN5geenRRd1rV8DhZZWFRZOS2IP32gG5cIB+y8ZiKdO/ym93FGi0RLNTCBBK?=
 =?us-ascii?Q?jwNq/2L1NN7QSPrHMeybjCmLvrnU/RpAjHiyXUooEY/g7q6vfdD9iVW+6tbm?=
 =?us-ascii?Q?A1LLuewiFmEfJAmRbSi1TXh365o0wqE34uoSPcX+wDQ/ZG5hbXZa+4pYY+CC?=
 =?us-ascii?Q?zPQ/hYSV9OguVgoNi+dr0PkdLzCCMqKs9tjhZCcSdJmDu69w2TXF8oBpV0TW?=
 =?us-ascii?Q?CUj6AOpSYmGhX61OVp0eDIJE0W2r0mJ4TgIzAfQSM11mOHfFEgQHGGmRIP/h?=
 =?us-ascii?Q?7xFGZsH4HOjD7Ihfs5CvEO8VatQGvTG7zMSXjKHyLHVbG/qbq1kfgQOP77Sa?=
 =?us-ascii?Q?44iBVeU2xL2n42OLsfz1It17zZF3UaREz3uppJCr+64Xi6HdrPLEgVIdOZ00?=
 =?us-ascii?Q?fEp9/e2w6NcgS4wYuArsF+H3313TJg/DIBTxRzgyHApHKKbS58h/+UOGcL1L?=
 =?us-ascii?Q?2axvJScMC5qTggarcHPEsqKcnHc9sUVSsnsyRiqyz89Bc7RRbJs7aq6SYG6A?=
 =?us-ascii?Q?EoRcGzRLV97peScyu5pYWG/OSEailVFz4Ymz9PR4KwD9pwe04cr8fd8T2WuI?=
 =?us-ascii?Q?Y/fmcVDpqqpqhHVIvbRrxEmt5rUN34x09uGT/ZASGcAavag8fSAPH0mGJIBo?=
 =?us-ascii?Q?CCuBPnp32xvczRexRcI7Kx7tMHT8NdUIQUvEUSAsFlpjcUC8R777d7UXsip0?=
 =?us-ascii?Q?1jXgwfsbnnKsKub/jmuwazWY=3D?=
X-Microsoft-Antispam-Message-Info: EEeSsqYlPbBPeJ5LBspgxY96YZ/xevnOCYVWyiXy/HqTQ44EvRe3V+uNWDKGTdMqf6bxmVdzWbnTu7sDIGttjinCYCxzlZhvkQHdQB/vw2ezfqtnj5yyMqxyVGzAOyEFZBm9/p3OqlVxNXE4Jx3MvIGTpawuHz+lfv2mFInSzN6ztqLbPvSJiOWHNAfeENe3cNzIl9q+wPKTSEPcbOTLAmdMOdP0yMzx+pgVyqUPNHInloxyKLaVnDnhXbMWg9VATqL2K6ERVpcBM8PKlwRLkK1k/+jSl5itBjfnTZ9H6pMMkZbVII8GcJNbmq3Yb13I4es3/UTpRF0UBV+Z2vZrLI+u27xzth7YM78AWgskd/PJRGa9k5D1KKMcN8xC7OteER4FH3BpU3OmIcIlw0D64A==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;6:Pdgdu0Y6zWJXqJF6c8/HrqCO/SkqXSJuG3E2LlVEvHyWy1iQb0YG+rO17yvr6jnRTQR5S7v6M9vV2qxfw+iDkgMe+dR7LneZGDVPOBYw9oL17VJZyhEwh+Ph02heMdNhUdS6x8DO+oTSzunY1iLJK4NJYRsE7L+MrCIe/K3hua3tu2D0kZZTGV3LHg6l4whDObJhobCR8EhGS0PnagwwRhWTQgNgZLDJJcJSQEzgr/TIo1DkDPyvt1fL4V09/s9eNqOYoRLK6MyqThFGv0MVBnzXdZ1bTKKHSDgNKZFyKn+VCsLRZjiMyfMdrrlxtxteViN9BHQjEIkZHfNEtCeeDYLY5yk2OeJ+/hYR36bai8kMJK9bZHgElOmyIe11jrmMiGC5jnW1pTeas9wX4jxdWU0OWVTBmiYDwL3PRcuWgeHUs5YxquCv+4PgMurHywjYbIYZNKsyHRMITrLs54R7hg==;5:AmPjPr46PA7g0UDalJCGakg0oYn+3Sv2acqm/QuCJFiVdO/5kela2pZryFNJE+/uM96vUMGaXccyHZUN838i2HdiJHgxY/VE7lihTtZiN+9rVLSPN/nGvVzM4r3r3PzjYYmfsgIJBHmwq/4MitGOXprtK5JcB6Yu3ytWjfpdqOI=;7:rZEQL8uHf8Zpp58Fs3/JD/1XlMhw+2ltpY/xpzsXWfLPN4IV/suS4bYkvGXDOgldnpXoOMBwlXjcpZ1PO139u4i4lwQ9SzYZhXsy5GCquBhym2BiuGtx69S06wKTpn6yEk7j6lotiOxUDbr+CZdX4MJZWugGhhUffLZLqsZhQut2rgZ5N1Q63GTXqWwj42DWFpcxILrm/EMhMrgKtEaCQON8NeRQhidGBUGRrDOiTKvJ/UG6ulH5FcLvPT4xjKJF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;20:qab7+QUFoPo+619PkkemDwb63Df3WKAGdJGP+dqMKefGfFdrlTd9BtPQ6P0N7dsAzQCUKMRRNRiihH4ZsE/AGHSztaEzVqSgdR5+iNaVCoFxEfhMVWt1Xi262qvSmO0gDPkUIe6biRmzY6+xSQeHN5zurYqkTngA7ktDr5ko7Geilu7gQlhwzueUXXgH5pil0hgoMAAOmToK8/Ya+/a6L4MiA82cvAkOfexSXPunrzwO6V5eq3LFZ17ZqNMxjjON
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 11:14:17.2687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5236ad9-f1ab-4c42-d31f-08d5f1569c45
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Moved cdn-dp-reg from drivers/gpu/drm/rockchip to a new location
  in drivers/drm/bridge/cadence and renamed it to cdns-mhdp-common.
- Extracted common fields from cdn_dp_device to a new cdns_mhdp_device
  structure which will be used by two separate drivers later on.
- Moved some datatypes (audio_format, audio_info, vic_pxl_encoding_format,
  video_info) from cdn-dp-core.c to cdns-mhdp-common.h.
- Changed prefixes from cdn_dp to cdns_mhdp
  cdn -> cdns to match the other Cadence's drivers
  dp -> mhdp to distinguish it from a "just a DP" as the IP underneath
    this registers map can be a HDMI (which is internally different,
    but the interface for commands, events is pretty much the same).
- Modified cdn-dp-core.c to use the new driver structure and new function
  names.
- Changed the CONFIG_ROCKCHIP_CDN_DP configuration to automatically select the
  Cadence MHDP DPI/DP bridge (DRM_CDNS_MHDP).

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/bridge/Kconfig                |   7 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 .../cdns-mhdp-common.c}                       | 434 +++++++++---------
 .../cdns-mhdp-common.h}                       | 123 ++++-
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/Makefile             |   4 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 220 ++++-----
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  40 +-
 8 files changed, 453 insertions(+), 377 deletions(-)
 rename drivers/gpu/drm/{rockchip/cdn-dp-reg.c => bridge/cdns-mhdp-common.c} (53%)
 rename drivers/gpu/drm/{rockchip/cdn-dp-reg.h => bridge/cdns-mhdp-common.h} (83%)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index bf6cad6c9178..31b75c971454 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -35,6 +35,13 @@ config DRM_CDNS_DSI
 	  Support Cadence DPI to DSI bridge. This is an internal
 	  bridge and is meant to be directly embedded in a SoC.
 
+config DRM_CDNS_MHDP
+	tristate "Cadence MHDP DPI/DP bridge"
+	select DRM_KMS_HELPER
+	depends on OF
+	help
+	  Support for Cadence DPI to DP bridge.
+
 config DRM_DUMB_VGA_DAC
 	tristate "Dumb VGA DAC Bridge support"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 35f88d48ec20..c9b35f736a00 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
 obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
+obj-$(CONFIG_DRM_CDNS_MHDP) += cdns-mhdp-common.o
 obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
 obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
similarity index 53%
rename from drivers/gpu/drm/rockchip/cdn-dp-reg.c
rename to drivers/gpu/drm/bridge/cdns-mhdp-common.c
index 3105965fc260..813319481220 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
@@ -19,22 +19,24 @@
 #include <linux/iopoll.h>
 #include <linux/reset.h>
 
-#include "cdn-dp-core.h"
-#include "cdn-dp-reg.h"
+#include <drm/drm_print.h>
+#include <drm/drm_modes.h>
 
-#define CDN_DP_SPDIF_CLK		200000000
+#include "cdns-mhdp-common.h"
+
+#define CDNS_DP_SPDIF_CLK		200000000
 #define FW_ALIVE_TIMEOUT_US		1000000
 #define MAILBOX_RETRY_US		1000
 #define MAILBOX_TIMEOUT_US		5000000
 #define LINK_TRAINING_RETRY_MS		20
 #define LINK_TRAINING_TIMEOUT_MS	500
 
-void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, unsigned long clk)
+void cdns_mhdp_set_fw_clk(struct cdns_mhdp_device *mhdp, unsigned long clk)
 {
-	writel(clk / 1000000, dp->regs + SW_CLK_H);
+	writel(clk / 1000000, mhdp->regs + SW_CLK_H);
 }
 
-void cdn_dp_clock_reset(struct cdn_dp_device *dp)
+void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp)
 {
 	u32 val;
 
@@ -50,16 +52,16 @@ void cdn_dp_clock_reset(struct cdn_dp_device *dp)
 	      DPTX_SYS_CLK_EN |
 	      CFG_DPTX_VIF_CLK_RSTN_EN |
 	      CFG_DPTX_VIF_CLK_EN;
-	writel(val, dp->regs + SOURCE_DPTX_CAR);
+	writel(val, mhdp->regs + SOURCE_DPTX_CAR);
 
 	val = SOURCE_PHY_RSTN_EN | SOURCE_PHY_CLK_EN;
-	writel(val, dp->regs + SOURCE_PHY_CAR);
+	writel(val, mhdp->regs + SOURCE_PHY_CAR);
 
 	val = SOURCE_PKT_SYS_RSTN_EN |
 	      SOURCE_PKT_SYS_CLK_EN |
 	      SOURCE_PKT_DATA_RSTN_EN |
 	      SOURCE_PKT_DATA_CLK_EN;
-	writel(val, dp->regs + SOURCE_PKT_CAR);
+	writel(val, mhdp->regs + SOURCE_PKT_CAR);
 
 	val = SPDIF_CDR_CLK_RSTN_EN |
 	      SPDIF_CDR_CLK_EN |
@@ -67,53 +69,53 @@ void cdn_dp_clock_reset(struct cdn_dp_device *dp)
 	      SOURCE_AIF_SYS_CLK_EN |
 	      SOURCE_AIF_CLK_RSTN_EN |
 	      SOURCE_AIF_CLK_EN;
-	writel(val, dp->regs + SOURCE_AIF_CAR);
+	writel(val, mhdp->regs + SOURCE_AIF_CAR);
 
 	val = SOURCE_CIPHER_SYSTEM_CLK_RSTN_EN |
 	      SOURCE_CIPHER_SYS_CLK_EN |
 	      SOURCE_CIPHER_CHAR_CLK_RSTN_EN |
 	      SOURCE_CIPHER_CHAR_CLK_EN;
-	writel(val, dp->regs + SOURCE_CIPHER_CAR);
+	writel(val, mhdp->regs + SOURCE_CIPHER_CAR);
 
 	val = SOURCE_CRYPTO_SYS_CLK_RSTN_EN |
 	      SOURCE_CRYPTO_SYS_CLK_EN;
-	writel(val, dp->regs + SOURCE_CRYPTO_CAR);
+	writel(val, mhdp->regs + SOURCE_CRYPTO_CAR);
 
 	/* enable Mailbox and PIF interrupt */
-	writel(0, dp->regs + APB_INT_MASK);
+	writel(0, mhdp->regs + APB_INT_MASK);
 }
 
-static int cdn_dp_mailbox_read(struct cdn_dp_device *dp)
+static int cdns_mhdp_mailbox_read(struct cdns_mhdp_device *mhdp)
 {
 	int val, ret;
 
-	ret = readx_poll_timeout(readl, dp->regs + MAILBOX_EMPTY_ADDR,
+	ret = readx_poll_timeout(readl, mhdp->regs + MAILBOX_EMPTY_ADDR,
 				 val, !val, MAILBOX_RETRY_US,
 				 MAILBOX_TIMEOUT_US);
 	if (ret < 0)
 		return ret;
 
-	return readl(dp->regs + MAILBOX0_RD_DATA) & 0xff;
+	return readl(mhdp->regs + MAILBOX0_RD_DATA) & 0xff;
 }
 
-static int cdp_dp_mailbox_write(struct cdn_dp_device *dp, u8 val)
+static int cdp_dp_mailbox_write(struct cdns_mhdp_device *mhdp, u8 val)
 {
 	int ret, full;
 
-	ret = readx_poll_timeout(readl, dp->regs + MAILBOX_FULL_ADDR,
+	ret = readx_poll_timeout(readl, mhdp->regs + MAILBOX_FULL_ADDR,
 				 full, !full, MAILBOX_RETRY_US,
 				 MAILBOX_TIMEOUT_US);
 	if (ret < 0)
 		return ret;
 
-	writel(val, dp->regs + MAILBOX0_WR_DATA);
+	writel(val, mhdp->regs + MAILBOX0_WR_DATA);
 
 	return 0;
 }
 
-static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
-					   u8 module_id, u8 opcode,
-					   u8 req_size)
+static int cdns_mhdp_mailbox_validate_receive(struct cdns_mhdp_device *mhdp,
+					      u8 module_id, u8 opcode,
+					      u8 req_size)
 {
 	u32 mbox_size, i;
 	u8 header[4];
@@ -121,7 +123,7 @@ static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 
 	/* read the header of the message */
 	for (i = 0; i < 4; i++) {
-		ret = cdn_dp_mailbox_read(dp);
+		ret = cdns_mhdp_mailbox_read(mhdp);
 		if (ret < 0)
 			return ret;
 
@@ -137,7 +139,7 @@ static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 		 * clear the mailbox by reading its contents.
 		 */
 		for (i = 0; i < mbox_size; i++)
-			if (cdn_dp_mailbox_read(dp) < 0)
+			if (cdns_mhdp_mailbox_read(mhdp) < 0)
 				break;
 
 		return -EINVAL;
@@ -146,14 +148,14 @@ static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 	return 0;
 }
 
-static int cdn_dp_mailbox_read_receive(struct cdn_dp_device *dp,
-				       u8 *buff, u8 buff_size)
+static int cdns_mhdp_mailbox_read_receive(struct cdns_mhdp_device *mhdp,
+					  u8 *buff, u8 buff_size)
 {
 	u32 i;
 	int ret;
 
 	for (i = 0; i < buff_size; i++) {
-		ret = cdn_dp_mailbox_read(dp);
+		ret = cdns_mhdp_mailbox_read(mhdp);
 		if (ret < 0)
 			return ret;
 
@@ -163,8 +165,8 @@ static int cdn_dp_mailbox_read_receive(struct cdn_dp_device *dp,
 	return 0;
 }
 
-static int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id,
-			       u8 opcode, u16 size, u8 *message)
+static int cdns_mhdp_mailbox_send(struct cdns_mhdp_device *mhdp, u8 module_id,
+				  u8 opcode, u16 size, u8 *message)
 {
 	u8 header[4];
 	int ret, i;
@@ -175,13 +177,13 @@ static int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id,
 	header[3] = size & 0xff;
 
 	for (i = 0; i < 4; i++) {
-		ret = cdp_dp_mailbox_write(dp, header[i]);
+		ret = cdp_dp_mailbox_write(mhdp, header[i]);
 		if (ret)
 			return ret;
 	}
 
 	for (i = 0; i < size; i++) {
-		ret = cdp_dp_mailbox_write(dp, message[i]);
+		ret = cdp_dp_mailbox_write(mhdp, message[i]);
 		if (ret)
 			return ret;
 	}
@@ -189,7 +191,7 @@ static int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id,
 	return 0;
 }
 
-static int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
+static int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
 {
 	u8 msg[6];
 
@@ -199,12 +201,12 @@ static int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
 	msg[3] = (val >> 16) & 0xff;
 	msg[4] = (val >> 8) & 0xff;
 	msg[5] = val & 0xff;
-	return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_REGISTER,
-				   sizeof(msg), msg);
+	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				      DPTX_WRITE_REGISTER, sizeof(msg), msg);
 }
 
-static int cdn_dp_reg_write_bit(struct cdn_dp_device *dp, u16 addr,
-				u8 start_bit, u8 bits_no, u32 val)
+static int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+				   u8 start_bit, u8 bits_no, u32 val)
 {
 	u8 field[8];
 
@@ -217,11 +219,12 @@ static int cdn_dp_reg_write_bit(struct cdn_dp_device *dp, u16 addr,
 	field[6] = (val >> 8) & 0xff;
 	field[7] = val & 0xff;
 
-	return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_FIELD,
-				   sizeof(field), field);
+	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				      DPTX_WRITE_FIELD, sizeof(field), field);
 }
 
-int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
+int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
+			u32 addr, u8 *data, u16 len)
 {
 	u8 msg[5], reg[5];
 	int ret;
@@ -231,28 +234,28 @@ int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
 	msg[2] = (addr >> 16) & 0xff;
 	msg[3] = (addr >> 8) & 0xff;
 	msg[4] = addr & 0xff;
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_READ_DPCD,
-				  sizeof(msg), msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_READ_DPCD, sizeof(msg), msg);
 	if (ret)
 		goto err_dpcd_read;
 
-	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-					      DPTX_READ_DPCD,
-					      sizeof(reg) + len);
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_READ_DPCD,
+						 sizeof(reg) + len);
 	if (ret)
 		goto err_dpcd_read;
 
-	ret = cdn_dp_mailbox_read_receive(dp, reg, sizeof(reg));
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, reg, sizeof(reg));
 	if (ret)
 		goto err_dpcd_read;
 
-	ret = cdn_dp_mailbox_read_receive(dp, data, len);
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, data, len);
 
 err_dpcd_read:
 	return ret;
 }
 
-int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
+int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
 {
 	u8 msg[6], reg[5];
 	int ret;
@@ -263,17 +266,17 @@ int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
 	msg[3] = (addr >> 8) & 0xff;
 	msg[4] = addr & 0xff;
 	msg[5] = value;
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_DPCD,
-				  sizeof(msg), msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_WRITE_DPCD, sizeof(msg), msg);
 	if (ret)
 		goto err_dpcd_write;
 
-	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-					      DPTX_WRITE_DPCD, sizeof(reg));
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_WRITE_DPCD, sizeof(reg));
 	if (ret)
 		goto err_dpcd_write;
 
-	ret = cdn_dp_mailbox_read_receive(dp, reg, sizeof(reg));
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, reg, sizeof(reg));
 	if (ret)
 		goto err_dpcd_write;
 
@@ -282,53 +285,53 @@ int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
 
 err_dpcd_write:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "dpcd write failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "dpcd write failed: %d\n", ret);
 	return ret;
 }
 
-int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
-			 u32 i_size, const u32 *d_mem, u32 d_size)
+int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
+			    u32 i_size, const u32 *d_mem, u32 d_size)
 {
 	u32 reg;
 	int i, ret;
 
 	/* reset ucpu before load firmware*/
 	writel(APB_IRAM_PATH | APB_DRAM_PATH | APB_XT_RESET,
-	       dp->regs + APB_CTRL);
+	       mhdp->regs + APB_CTRL);
 
 	for (i = 0; i < i_size; i += 4)
-		writel(*i_mem++, dp->regs + ADDR_IMEM + i);
+		writel(*i_mem++, mhdp->regs + ADDR_IMEM + i);
 
 	for (i = 0; i < d_size; i += 4)
-		writel(*d_mem++, dp->regs + ADDR_DMEM + i);
+		writel(*d_mem++, mhdp->regs + ADDR_DMEM + i);
 
 	/* un-reset ucpu */
-	writel(0, dp->regs + APB_CTRL);
+	writel(0, mhdp->regs + APB_CTRL);
 
 	/* check the keep alive register to make sure fw working */
-	ret = readx_poll_timeout(readl, dp->regs + KEEP_ALIVE,
+	ret = readx_poll_timeout(readl, mhdp->regs + KEEP_ALIVE,
 				 reg, reg, 2000, FW_ALIVE_TIMEOUT_US);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "failed to loaded the FW reg = %x\n",
+		DRM_DEV_ERROR(mhdp->dev, "failed to loaded the FW reg = %x\n",
 			      reg);
 		return -EINVAL;
 	}
 
-	reg = readl(dp->regs + VER_L) & 0xff;
-	dp->fw_version = reg;
-	reg = readl(dp->regs + VER_H) & 0xff;
-	dp->fw_version |= reg << 8;
-	reg = readl(dp->regs + VER_LIB_L_ADDR) & 0xff;
-	dp->fw_version |= reg << 16;
-	reg = readl(dp->regs + VER_LIB_H_ADDR) & 0xff;
-	dp->fw_version |= reg << 24;
+	reg = readl(mhdp->regs + VER_L) & 0xff;
+	mhdp->fw_version = reg;
+	reg = readl(mhdp->regs + VER_H) & 0xff;
+	mhdp->fw_version |= reg << 8;
+	reg = readl(mhdp->regs + VER_LIB_L_ADDR) & 0xff;
+	mhdp->fw_version |= reg << 16;
+	reg = readl(mhdp->regs + VER_LIB_H_ADDR) & 0xff;
+	mhdp->fw_version |= reg << 24;
 
-	DRM_DEV_DEBUG(dp->dev, "firmware version: %x\n", dp->fw_version);
+	DRM_DEV_DEBUG(mhdp->dev, "firmware version: %x\n", mhdp->fw_version);
 
 	return 0;
 }
 
-int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable)
+int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable)
 {
 	u8 msg[5];
 	int ret, i;
@@ -340,14 +343,14 @@ int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable)
 	msg[4] = enable ? FW_ACTIVE : FW_STANDBY;
 
 	for (i = 0; i < sizeof(msg); i++) {
-		ret = cdp_dp_mailbox_write(dp, msg[i]);
+		ret = cdp_dp_mailbox_write(mhdp, msg[i]);
 		if (ret)
 			goto err_set_firmware_active;
 	}
 
 	/* read the firmware state */
 	for (i = 0; i < sizeof(msg); i++)  {
-		ret = cdn_dp_mailbox_read(dp);
+		ret = cdns_mhdp_mailbox_read(mhdp);
 		if (ret < 0)
 			goto err_set_firmware_active;
 
@@ -358,16 +361,16 @@ int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable)
 
 err_set_firmware_active:
 	if (ret < 0)
-		DRM_DEV_ERROR(dp->dev, "set firmware active failed\n");
+		DRM_DEV_ERROR(mhdp->dev, "set firmware active failed\n");
 	return ret;
 }
 
-int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip)
+int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip)
 {
 	u8 msg[8];
 	int ret;
 
-	msg[0] = CDN_DP_MAX_LINK_RATE;
+	msg[0] = CDNS_DP_MAX_LINK_RATE;
 	msg[1] = lanes | SCRAMBLER_EN;
 	msg[2] = VOLTAGE_LEVEL_2;
 	msg[3] = PRE_EMPHASIS_LEVEL_3;
@@ -376,22 +379,22 @@ int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip)
 	msg[6] = flip ? LANE_MAPPING_FLIPPED : LANE_MAPPING_NORMAL;
 	msg[7] = ENHANCED;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
-				  DPTX_SET_HOST_CAPABILITIES,
-				  sizeof(msg), msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_SET_HOST_CAPABILITIES,
+				     sizeof(msg), msg);
 	if (ret)
 		goto err_set_host_cap;
 
-	ret = cdn_dp_reg_write(dp, DP_AUX_SWAP_INVERSION_CONTROL,
-			       AUX_HOST_INVERT);
+	ret = cdns_mhdp_reg_write(mhdp, DP_AUX_SWAP_INVERSION_CONTROL,
+				  AUX_HOST_INVERT);
 
 err_set_host_cap:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "set host cap failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "set host cap failed: %d\n", ret);
 	return ret;
 }
 
-int cdn_dp_event_config(struct cdn_dp_device *dp)
+int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp)
 {
 	u8 msg[5];
 	int ret;
@@ -400,49 +403,50 @@ int cdn_dp_event_config(struct cdn_dp_device *dp)
 
 	msg[0] = DPTX_EVENT_ENABLE_HPD | DPTX_EVENT_ENABLE_TRAINING;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_ENABLE_EVENT,
-				  sizeof(msg), msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_ENABLE_EVENT, sizeof(msg), msg);
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "set event config failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "set event config failed: %d\n", ret);
 
 	return ret;
 }
 
-u32 cdn_dp_get_event(struct cdn_dp_device *dp)
+u32 cdns_mhdp_get_event(struct cdns_mhdp_device *mhdp)
 {
-	return readl(dp->regs + SW_EVENTS0);
+	return readl(mhdp->regs + SW_EVENTS0);
 }
 
-int cdn_dp_get_hpd_status(struct cdn_dp_device *dp)
+int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp)
 {
 	u8 status;
 	int ret;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_HPD_STATE,
-				  0, NULL);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_HPD_STATE, 0, NULL);
 	if (ret)
 		goto err_get_hpd;
 
-	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-					      DPTX_HPD_STATE, sizeof(status));
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_HPD_STATE,
+						 sizeof(status));
 	if (ret)
 		goto err_get_hpd;
 
-	ret = cdn_dp_mailbox_read_receive(dp, &status, sizeof(status));
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, &status, sizeof(status));
 	if (ret)
 		goto err_get_hpd;
 
 	return status;
 
 err_get_hpd:
-	DRM_DEV_ERROR(dp->dev, "get hpd status failed: %d\n", ret);
+	DRM_DEV_ERROR(mhdp->dev, "get hpd status failed: %d\n", ret);
 	return ret;
 }
 
-int cdn_dp_get_edid_block(void *data, u8 *edid,
+int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 			  unsigned int block, size_t length)
 {
-	struct cdn_dp_device *dp = data;
+	struct cdns_mhdp_device *mhdp = data;
 	u8 msg[2], reg[2], i;
 	int ret;
 
@@ -450,22 +454,23 @@ int cdn_dp_get_edid_block(void *data, u8 *edid,
 		msg[0] = block / 2;
 		msg[1] = block % 2;
 
-		ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_GET_EDID,
-					  sizeof(msg), msg);
+		ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+					     DPTX_GET_EDID, sizeof(msg), msg);
 		if (ret)
 			continue;
 
-		ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-						      DPTX_GET_EDID,
-						      sizeof(reg) + length);
+		ret = cdns_mhdp_mailbox_validate_receive(mhdp,
+							 MB_MODULE_ID_DP_TX,
+							 DPTX_GET_EDID,
+							 sizeof(reg) + length);
 		if (ret)
 			continue;
 
-		ret = cdn_dp_mailbox_read_receive(dp, reg, sizeof(reg));
+		ret = cdns_mhdp_mailbox_read_receive(mhdp, reg, sizeof(reg));
 		if (ret)
 			continue;
 
-		ret = cdn_dp_mailbox_read_receive(dp, edid, length);
+		ret = cdns_mhdp_mailbox_read_receive(mhdp, edid, length);
 		if (ret)
 			continue;
 
@@ -474,13 +479,13 @@ int cdn_dp_get_edid_block(void *data, u8 *edid,
 	}
 
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "get block[%d] edid failed: %d\n", block,
-			      ret);
+		DRM_DEV_ERROR(mhdp->dev, "get block[%d] edid failed: %d\n",
+			      block, ret);
 
 	return ret;
 }
 
-static int cdn_dp_training_start(struct cdn_dp_device *dp)
+static int cdns_mhdp_training_start(struct cdns_mhdp_device *mhdp)
 {
 	unsigned long timeout;
 	u8 msg, event[2];
@@ -489,26 +494,28 @@ static int cdn_dp_training_start(struct cdn_dp_device *dp)
 	msg = LINK_TRAINING_RUN;
 
 	/* start training */
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_TRAINING_CONTROL,
-				  sizeof(msg), &msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_TRAINING_CONTROL, sizeof(msg), &msg);
 	if (ret)
 		goto err_training_start;
 
 	timeout = jiffies + msecs_to_jiffies(LINK_TRAINING_TIMEOUT_MS);
 	while (time_before(jiffies, timeout)) {
 		msleep(LINK_TRAINING_RETRY_MS);
-		ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
-					  DPTX_READ_EVENT, 0, NULL);
+		ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+					     DPTX_READ_EVENT, 0, NULL);
 		if (ret)
 			goto err_training_start;
 
-		ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-						      DPTX_READ_EVENT,
-						      sizeof(event));
+		ret = cdns_mhdp_mailbox_validate_receive(mhdp,
+							 MB_MODULE_ID_DP_TX,
+							 DPTX_READ_EVENT,
+							 sizeof(event));
 		if (ret)
 			goto err_training_start;
 
-		ret = cdn_dp_mailbox_read_receive(dp, event, sizeof(event));
+		ret = cdns_mhdp_mailbox_read_receive(mhdp, event,
+						     sizeof(event));
 		if (ret)
 			goto err_training_start;
 
@@ -519,77 +526,80 @@ static int cdn_dp_training_start(struct cdn_dp_device *dp)
 	ret = -ETIMEDOUT;
 
 err_training_start:
-	DRM_DEV_ERROR(dp->dev, "training failed: %d\n", ret);
+	DRM_DEV_ERROR(mhdp->dev, "training failed: %d\n", ret);
 	return ret;
 }
 
-static int cdn_dp_get_training_status(struct cdn_dp_device *dp)
+static int cdns_mhdp_get_training_status(struct cdns_mhdp_device *mhdp)
 {
 	u8 status[10];
 	int ret;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_READ_LINK_STAT,
-				  0, NULL);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_READ_LINK_STAT, 0, NULL);
 	if (ret)
 		goto err_get_training_status;
 
-	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-					      DPTX_READ_LINK_STAT,
-					      sizeof(status));
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_READ_LINK_STAT,
+						 sizeof(status));
 	if (ret)
 		goto err_get_training_status;
 
-	ret = cdn_dp_mailbox_read_receive(dp, status, sizeof(status));
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, status, sizeof(status));
 	if (ret)
 		goto err_get_training_status;
 
-	dp->link.rate = status[0];
-	dp->link.num_lanes = status[1];
+	mhdp->link.rate = status[0];
+	mhdp->link.num_lanes = status[1];
 
 err_get_training_status:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "get training status failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "get training status failed: %d\n",
+			      ret);
 	return ret;
 }
 
-int cdn_dp_train_link(struct cdn_dp_device *dp)
+int cdns_mhdp_train_link(struct cdns_mhdp_device *mhdp)
 {
 	int ret;
 
-	ret = cdn_dp_training_start(dp);
+	ret = cdns_mhdp_training_start(mhdp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to start training %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "Failed to start training %d\n",
+			      ret);
 		return ret;
 	}
 
-	ret = cdn_dp_get_training_status(dp);
+	ret = cdns_mhdp_get_training_status(mhdp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to get training stat %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "Failed to get training stat %d\n",
+			      ret);
 		return ret;
 	}
 
-	DRM_DEV_DEBUG_KMS(dp->dev, "rate:0x%x, lanes:%d\n", dp->link.rate,
-			  dp->link.num_lanes);
+	DRM_DEV_DEBUG_KMS(mhdp->dev, "rate:0x%x, lanes:%d\n", mhdp->link.rate,
+			  mhdp->link.num_lanes);
 	return ret;
 }
 
-int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active)
+int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active)
 {
 	u8 msg;
 	int ret;
 
 	msg = !!active;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_SET_VIDEO,
-				  sizeof(msg), &msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_SET_VIDEO, sizeof(msg), &msg);
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "set video status failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "set video status failed: %d\n", ret);
 
 	return ret;
 }
 
-static int cdn_dp_get_msa_misc(struct video_info *video,
-			       struct drm_display_mode *mode)
+static int cdns_mhdp_get_msa_misc(struct video_info *video,
+				  struct drm_display_mode *mode)
 {
 	u32 msa_misc;
 	u8 val[2] = {0};
@@ -635,10 +645,10 @@ static int cdn_dp_get_msa_misc(struct video_info *video,
 	return msa_misc;
 }
 
-int cdn_dp_config_video(struct cdn_dp_device *dp)
+int cdns_mhdp_config_video(struct cdns_mhdp_device *mhdp)
 {
-	struct video_info *video = &dp->video_info;
-	struct drm_display_mode *mode = &dp->mode;
+	struct video_info *video = &mhdp->video_info;
+	struct drm_display_mode *mode = &mhdp->mode;
 	u64 symbol;
 	u32 val, link_rate, rem;
 	u8 bit_per_pix, tu_size_reg = TU_SIZE;
@@ -647,13 +657,13 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 	bit_per_pix = (video->color_fmt == YCBCR_4_2_2) ?
 		      (video->color_depth * 2) : (video->color_depth * 3);
 
-	link_rate = drm_dp_bw_code_to_link_rate(dp->link.rate) / 1000;
+	link_rate = drm_dp_bw_code_to_link_rate(mhdp->link.rate) / 1000;
 
-	ret = cdn_dp_reg_write(dp, BND_HSYNC2VSYNC, VIF_BYPASS_INTERLACE);
+	ret = cdns_mhdp_reg_write(mhdp, BND_HSYNC2VSYNC, VIF_BYPASS_INTERLACE);
 	if (ret)
 		goto err_config_video;
 
-	ret = cdn_dp_reg_write(dp, HSYNC2VSYNC_POL_CTRL, 0);
+	ret = cdns_mhdp_reg_write(mhdp, HSYNC2VSYNC_POL_CTRL, 0);
 	if (ret)
 		goto err_config_video;
 
@@ -667,13 +677,13 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 	do {
 		tu_size_reg += 2;
 		symbol = tu_size_reg * mode->clock * bit_per_pix;
-		do_div(symbol, dp->link.num_lanes * link_rate * 8);
+		do_div(symbol, mhdp->link.num_lanes * link_rate * 8);
 		rem = do_div(symbol, 1000);
 		if (tu_size_reg > 64) {
 			ret = -EINVAL;
-			DRM_DEV_ERROR(dp->dev,
+			DRM_DEV_ERROR(mhdp->dev,
 				      "tu error, clk:%d, lanes:%d, rate:%d\n",
-				      mode->clock, dp->link.num_lanes,
+				      mode->clock, mhdp->link.num_lanes,
 				      link_rate);
 			goto err_config_video;
 		}
@@ -682,16 +692,16 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 
 	val = symbol + (tu_size_reg << 8);
 	val |= TU_CNT_RST_EN;
-	ret = cdn_dp_reg_write(dp, DP_FRAMER_TU, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_FRAMER_TU, val);
 	if (ret)
 		goto err_config_video;
 
 	/* set the FIFO Buffer size */
 	val = div_u64(mode->clock * (symbol + 1), 1000) + link_rate;
-	val /= (dp->link.num_lanes * link_rate);
+	val /= (mhdp->link.num_lanes * link_rate);
 	val = div_u64(8 * (symbol + 1), bit_per_pix) - val;
 	val += 2;
-	ret = cdn_dp_reg_write(dp, DP_VC_TABLE(15), val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_VC_TABLE(15), val);
 
 	switch (video->color_depth) {
 	case 6:
@@ -712,136 +722,137 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 	};
 
 	val += video->color_fmt << 8;
-	ret = cdn_dp_reg_write(dp, DP_FRAMER_PXL_REPR, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_FRAMER_PXL_REPR, val);
 	if (ret)
 		goto err_config_video;
 
 	val = video->h_sync_polarity ? DP_FRAMER_SP_HSP : 0;
 	val |= video->v_sync_polarity ? DP_FRAMER_SP_VSP : 0;
-	ret = cdn_dp_reg_write(dp, DP_FRAMER_SP, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_FRAMER_SP, val);
 	if (ret)
 		goto err_config_video;
 
 	val = (mode->hsync_start - mode->hdisplay) << 16;
 	val |= mode->htotal - mode->hsync_end;
-	ret = cdn_dp_reg_write(dp, DP_FRONT_BACK_PORCH, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_FRONT_BACK_PORCH, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->hdisplay * bit_per_pix / 8;
-	ret = cdn_dp_reg_write(dp, DP_BYTE_COUNT, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_BYTE_COUNT, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->htotal | ((mode->htotal - mode->hsync_start) << 16);
-	ret = cdn_dp_reg_write(dp, MSA_HORIZONTAL_0, val);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_HORIZONTAL_0, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->hsync_end - mode->hsync_start;
 	val |= (mode->hdisplay << 16) | (video->h_sync_polarity << 15);
-	ret = cdn_dp_reg_write(dp, MSA_HORIZONTAL_1, val);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_HORIZONTAL_1, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->vtotal;
 	val |= (mode->vtotal - mode->vsync_start) << 16;
-	ret = cdn_dp_reg_write(dp, MSA_VERTICAL_0, val);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_VERTICAL_0, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->vsync_end - mode->vsync_start;
 	val |= (mode->vdisplay << 16) | (video->v_sync_polarity << 15);
-	ret = cdn_dp_reg_write(dp, MSA_VERTICAL_1, val);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_VERTICAL_1, val);
 	if (ret)
 		goto err_config_video;
 
-	val = cdn_dp_get_msa_misc(video, mode);
-	ret = cdn_dp_reg_write(dp, MSA_MISC, val);
+	val = cdns_mhdp_get_msa_misc(video, mode);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_MISC, val);
 	if (ret)
 		goto err_config_video;
 
-	ret = cdn_dp_reg_write(dp, STREAM_CONFIG, 1);
+	ret = cdns_mhdp_reg_write(mhdp, STREAM_CONFIG, 1);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->hsync_end - mode->hsync_start;
 	val |= mode->hdisplay << 16;
-	ret = cdn_dp_reg_write(dp, DP_HORIZONTAL, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_HORIZONTAL, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->vdisplay;
 	val |= (mode->vtotal - mode->vsync_start) << 16;
-	ret = cdn_dp_reg_write(dp, DP_VERTICAL_0, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_VERTICAL_0, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->vtotal;
-	ret = cdn_dp_reg_write(dp, DP_VERTICAL_1, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_VERTICAL_1, val);
 	if (ret)
 		goto err_config_video;
 
-	ret = cdn_dp_reg_write_bit(dp, DP_VB_ID, 2, 1, 0);
+	ret = cdns_mhdp_reg_write_bit(mhdp, DP_VB_ID, 2, 1, 0);
 
 err_config_video:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "config video failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "config video failed: %d\n", ret);
 	return ret;
 }
 
-int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio)
+int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
+			 struct audio_info *audio)
 {
 	int ret;
 
-	ret = cdn_dp_reg_write(dp, AUDIO_PACK_CONTROL, 0);
+	ret = cdns_mhdp_reg_write(mhdp, AUDIO_PACK_CONTROL, 0);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "audio stop failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "audio stop failed: %d\n", ret);
 		return ret;
 	}
 
-	writel(0, dp->regs + SPDIF_CTRL_ADDR);
+	writel(0, mhdp->regs + SPDIF_CTRL_ADDR);
 
 	/* clearn the audio config and reset */
-	writel(0, dp->regs + AUDIO_SRC_CNTL);
-	writel(0, dp->regs + AUDIO_SRC_CNFG);
-	writel(AUDIO_SW_RST, dp->regs + AUDIO_SRC_CNTL);
-	writel(0, dp->regs + AUDIO_SRC_CNTL);
+	writel(0, mhdp->regs + AUDIO_SRC_CNTL);
+	writel(0, mhdp->regs + AUDIO_SRC_CNFG);
+	writel(AUDIO_SW_RST, mhdp->regs + AUDIO_SRC_CNTL);
+	writel(0, mhdp->regs + AUDIO_SRC_CNTL);
 
 	/* reset smpl2pckt component  */
-	writel(0, dp->regs + SMPL2PKT_CNTL);
-	writel(AUDIO_SW_RST, dp->regs + SMPL2PKT_CNTL);
-	writel(0, dp->regs + SMPL2PKT_CNTL);
+	writel(0, mhdp->regs + SMPL2PKT_CNTL);
+	writel(AUDIO_SW_RST, mhdp->regs + SMPL2PKT_CNTL);
+	writel(0, mhdp->regs + SMPL2PKT_CNTL);
 
 	/* reset FIFO */
-	writel(AUDIO_SW_RST, dp->regs + FIFO_CNTL);
-	writel(0, dp->regs + FIFO_CNTL);
+	writel(AUDIO_SW_RST, mhdp->regs + FIFO_CNTL);
+	writel(0, mhdp->regs + FIFO_CNTL);
 
 	if (audio->format == AFMT_SPDIF)
-		clk_disable_unprepare(dp->spdif_clk);
+		clk_disable_unprepare(mhdp->spdif_clk);
 
 	return 0;
 }
 
-int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable)
+int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable)
 {
 	int ret;
 
-	ret = cdn_dp_reg_write_bit(dp, DP_VB_ID, 4, 1, enable);
+	ret = cdns_mhdp_reg_write_bit(mhdp, DP_VB_ID, 4, 1, enable);
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "audio mute failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "audio mute failed: %d\n", ret);
 
 	return ret;
 }
 
-static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
-				    struct audio_info *audio)
+static void cdns_mhdp_audio_config_i2s(struct cdns_mhdp_device *mhdp,
+				       struct audio_info *audio)
 {
 	int sub_pckt_num = 1, i2s_port_en_val = 0xf, i;
 	u32 val;
 
 	if (audio->channels == 2) {
-		if (dp->link.num_lanes == 1)
+		if (mhdp->link.num_lanes == 1)
 			sub_pckt_num = 2;
 		else
 			sub_pckt_num = 4;
@@ -851,15 +862,15 @@ static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
 		i2s_port_en_val = 3;
 	}
 
-	writel(0x0, dp->regs + SPDIF_CTRL_ADDR);
+	writel(0x0, mhdp->regs + SPDIF_CTRL_ADDR);
 
-	writel(SYNC_WR_TO_CH_ZERO, dp->regs + FIFO_CNTL);
+	writel(SYNC_WR_TO_CH_ZERO, mhdp->regs + FIFO_CNTL);
 
 	val = MAX_NUM_CH(audio->channels);
 	val |= NUM_OF_I2S_PORTS(audio->channels);
 	val |= AUDIO_TYPE_LPCM;
 	val |= CFG_SUB_PCKT_NUM(sub_pckt_num);
-	writel(val, dp->regs + SMPL2PKT_CNFG);
+	writel(val, mhdp->regs + SMPL2PKT_CNFG);
 
 	if (audio->sample_width == 16)
 		val = 0;
@@ -871,7 +882,7 @@ static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
 	val |= AUDIO_CH_NUM(audio->channels);
 	val |= I2S_DEC_PORT_EN(i2s_port_en_val);
 	val |= TRANS_SMPL_WIDTH_32;
-	writel(val, dp->regs + AUDIO_SRC_CNFG);
+	writel(val, mhdp->regs + AUDIO_SRC_CNFG);
 
 	for (i = 0; i < (audio->channels + 1) / 2; i++) {
 		if (audio->sample_width == 16)
@@ -880,7 +891,7 @@ static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
 			val = (0x0b << 8) | (0x0b << 20);
 
 		val |= ((2 * i) << 4) | ((2 * i + 1) << 16);
-		writel(val, dp->regs + STTS_BIT_CH(i));
+		writel(val, mhdp->regs + STTS_BIT_CH(i));
 	}
 
 	switch (audio->sample_rate) {
@@ -914,56 +925,57 @@ static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
 		break;
 	}
 	val |= 4;
-	writel(val, dp->regs + COM_CH_STTS_BITS);
+	writel(val, mhdp->regs + COM_CH_STTS_BITS);
 
-	writel(SMPL2PKT_EN, dp->regs + SMPL2PKT_CNTL);
-	writel(I2S_DEC_START, dp->regs + AUDIO_SRC_CNTL);
+	writel(SMPL2PKT_EN, mhdp->regs + SMPL2PKT_CNTL);
+	writel(I2S_DEC_START, mhdp->regs + AUDIO_SRC_CNTL);
 }
 
-static void cdn_dp_audio_config_spdif(struct cdn_dp_device *dp)
+static void cdns_mhdp_audio_config_spdif(struct cdns_mhdp_device *mhdp)
 {
 	u32 val;
 
-	writel(SYNC_WR_TO_CH_ZERO, dp->regs + FIFO_CNTL);
+	writel(SYNC_WR_TO_CH_ZERO, mhdp->regs + FIFO_CNTL);
 
 	val = MAX_NUM_CH(2) | AUDIO_TYPE_LPCM | CFG_SUB_PCKT_NUM(4);
-	writel(val, dp->regs + SMPL2PKT_CNFG);
-	writel(SMPL2PKT_EN, dp->regs + SMPL2PKT_CNTL);
+	writel(val, mhdp->regs + SMPL2PKT_CNFG);
+	writel(SMPL2PKT_EN, mhdp->regs + SMPL2PKT_CNTL);
 
 	val = SPDIF_ENABLE | SPDIF_AVG_SEL | SPDIF_JITTER_BYPASS;
-	writel(val, dp->regs + SPDIF_CTRL_ADDR);
+	writel(val, mhdp->regs + SPDIF_CTRL_ADDR);
 
-	clk_prepare_enable(dp->spdif_clk);
-	clk_set_rate(dp->spdif_clk, CDN_DP_SPDIF_CLK);
+	clk_prepare_enable(mhdp->spdif_clk);
+	clk_set_rate(mhdp->spdif_clk, CDNS_DP_SPDIF_CLK);
 }
 
-int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio)
+int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
+			   struct audio_info *audio)
 {
 	int ret;
 
 	/* reset the spdif clk before config */
 	if (audio->format == AFMT_SPDIF) {
-		reset_control_assert(dp->spdif_rst);
-		reset_control_deassert(dp->spdif_rst);
+		reset_control_assert(mhdp->spdif_rst);
+		reset_control_deassert(mhdp->spdif_rst);
 	}
 
-	ret = cdn_dp_reg_write(dp, CM_LANE_CTRL, LANE_REF_CYC);
+	ret = cdns_mhdp_reg_write(mhdp, CM_LANE_CTRL, LANE_REF_CYC);
 	if (ret)
 		goto err_audio_config;
 
-	ret = cdn_dp_reg_write(dp, CM_CTRL, 0);
+	ret = cdns_mhdp_reg_write(mhdp, CM_CTRL, 0);
 	if (ret)
 		goto err_audio_config;
 
 	if (audio->format == AFMT_I2S)
-		cdn_dp_audio_config_i2s(dp, audio);
+		cdns_mhdp_audio_config_i2s(mhdp, audio);
 	else if (audio->format == AFMT_SPDIF)
-		cdn_dp_audio_config_spdif(dp);
+		cdns_mhdp_audio_config_spdif(mhdp);
 
-	ret = cdn_dp_reg_write(dp, AUDIO_PACK_CONTROL, AUDIO_PACK_EN);
+	ret = cdns_mhdp_reg_write(mhdp, AUDIO_PACK_CONTROL, AUDIO_PACK_EN);
 
 err_audio_config:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "audio config failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "audio config failed: %d\n", ret);
 	return ret;
 }
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/bridge/cdns-mhdp-common.h
similarity index 83%
rename from drivers/gpu/drm/rockchip/cdn-dp-reg.h
rename to drivers/gpu/drm/bridge/cdns-mhdp-common.h
index c4bbb4a83319..b0101f10594a 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-common.h
@@ -12,10 +12,13 @@
  * GNU General Public License for more details.
  */
 
-#ifndef _CDN_DP_REG_H
-#define _CDN_DP_REG_H
+#ifndef CDNS_MHDP_COMMON_H_
+#define CDNS_MHDP_COMMON_H_
 
 #include <linux/bitops.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_bridge.h>
 
 #define ADDR_IMEM		0x10000
 #define ADDR_DMEM		0x20000
@@ -395,7 +398,7 @@
 #define HDCP_TX_IS_RECEIVER_ID_VALID_EVENT	BIT(7)
 
 #define TU_SIZE					30
-#define CDN_DP_MAX_LINK_RATE			DP_LINK_BW_5_4
+#define CDNS_DP_MAX_LINK_RATE			DP_LINK_BW_5_4
 
 /* audio */
 #define AUDIO_PACK_EN				BIT(8)
@@ -459,24 +462,96 @@ enum vic_bt_type {
 	BT_709 = 0x1,
 };
 
-void cdn_dp_clock_reset(struct cdn_dp_device *dp);
-
-void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, unsigned long clk);
-int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
-			 u32 i_size, const u32 *d_mem, u32 d_size);
-int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable);
-int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip);
-int cdn_dp_event_config(struct cdn_dp_device *dp);
-u32 cdn_dp_get_event(struct cdn_dp_device *dp);
-int cdn_dp_get_hpd_status(struct cdn_dp_device *dp);
-int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value);
-int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len);
-int cdn_dp_get_edid_block(void *dp, u8 *edid,
-			  unsigned int block, size_t length);
-int cdn_dp_train_link(struct cdn_dp_device *dp);
-int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active);
-int cdn_dp_config_video(struct cdn_dp_device *dp);
-int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio);
-int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable);
-int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio);
-#endif /* _CDN_DP_REG_H */
+enum audio_format {
+	AFMT_I2S = 0,
+	AFMT_SPDIF = 1,
+	AFMT_UNUSED,
+};
+
+struct audio_info {
+	enum audio_format format;
+	int sample_rate;
+	int channels;
+	int sample_width;
+};
+
+enum vic_pxl_encoding_format {
+	PXL_RGB = 0x1,
+	YCBCR_4_4_4 = 0x2,
+	YCBCR_4_2_2 = 0x4,
+	YCBCR_4_2_0 = 0x8,
+	Y_ONLY = 0x10,
+};
+
+struct video_info {
+	bool h_sync_polarity;
+	bool v_sync_polarity;
+	bool interlaced;
+	int color_depth;
+	enum vic_pxl_encoding_format color_fmt;
+};
+
+struct cdns_mhdp_host {
+	unsigned int	link_rate;
+	u8	lanes_cnt;
+	u8	volt_swing;
+	u8	pre_emphasis;
+	u8	pattern_supp;
+	u8	fast_link;
+	u8	lane_mapping;
+	u8	enhanced;
+};
+
+struct cdns_mhdp_sink {
+	unsigned int	link_rate;
+	u8	lanes_cnt;
+	u8	pattern_supp;
+	u8	fast_link;
+	u8	enhanced;
+};
+
+struct cdns_mhdp_device {
+	void __iomem		*regs;
+
+	struct device		*dev;
+
+	struct drm_dp_link	link;
+	struct drm_connector	connector;
+	struct clk		*spdif_clk;
+	struct reset_control	*spdif_rst;
+
+	struct drm_dp_aux	aux;
+	struct cdns_mhdp_host	host;
+	struct cdns_mhdp_sink	sink;
+	struct drm_bridge	bridge;
+	struct phy		*phy;
+	void __iomem		*dbg_regs;
+
+	struct video_info	video_info;
+	struct drm_display_mode	mode;
+	unsigned int		fw_version;
+};
+
+void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp);
+void cdns_mhdp_set_fw_clk(struct cdns_mhdp_device *mhdp, unsigned long clk);
+int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
+			    u32 i_size, const u32 *d_mem, u32 d_size);
+int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable);
+int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip);
+int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp);
+u32 cdns_mhdp_get_event(struct cdns_mhdp_device *mhdp);
+int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp);
+int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value);
+int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
+			u32 addr, u8 *data, u16 len);
+int cdns_mhdp_get_edid_block(void *mhdp, u8 *edid,
+			     unsigned int block, size_t length);
+int cdns_mhdp_train_link(struct cdns_mhdp_device *mhdp);
+int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active);
+int cdns_mhdp_config_video(struct cdns_mhdp_device *mhdp);
+int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
+			 struct audio_info *audio);
+int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable);
+int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
+			   struct audio_info *audio);
+#endif /* CDNS_MHDP_COMMON_H_ */
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0ccc76217ee4..8269dbc0d385 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -28,6 +28,7 @@ config ROCKCHIP_ANALOGIX_DP
 config ROCKCHIP_CDN_DP
         bool "Rockchip cdn DP"
 	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
+	select DRM_CDNS_MHDP
         help
 	  This selects support for Rockchip SoC specific extensions
 	  for the cdn DP driver. If you want to enable Dp on
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index a314e2109e76..c70b1bb6829f 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -3,13 +3,15 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
+EXTRA_CFLAGS += -I$(src)/../bridge
+
 rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
 		rockchip_drm_gem.o rockchip_drm_psr.o \
 		rockchip_drm_vop.o rockchip_vop_reg.o
 rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
 
 rockchipdrm-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
-rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
+rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 8ad0d773dc33..bf7e206326f0 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -31,11 +31,10 @@
 #include <sound/hdmi-codec.h>
 
 #include "cdn-dp-core.h"
-#include "cdn-dp-reg.h"
 #include "rockchip_drm_vop.h"
 
 #define connector_to_dp(c) \
-		container_of(c, struct cdn_dp_device, connector)
+		container_of(c, struct cdn_dp_device, mhdp.connector)
 
 #define encoder_to_dp(c) \
 		container_of(c, struct cdn_dp_device, encoder)
@@ -70,17 +69,18 @@ MODULE_DEVICE_TABLE(of, cdn_dp_dt_ids);
 static int cdn_dp_grf_write(struct cdn_dp_device *dp,
 			    unsigned int reg, unsigned int val)
 {
+	struct device *dev = dp->mhdp.dev;
 	int ret;
 
 	ret = clk_prepare_enable(dp->grf_clk);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to prepare_enable grf clock\n");
+		DRM_DEV_ERROR(dev, "Failed to prepare_enable grf clock\n");
 		return ret;
 	}
 
 	ret = regmap_write(dp->grf, reg, val);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Could not write to GRF: %d\n", ret);
+		DRM_DEV_ERROR(dev, "Could not write to GRF: %d\n", ret);
 		return ret;
 	}
 
@@ -91,24 +91,25 @@ static int cdn_dp_grf_write(struct cdn_dp_device *dp,
 
 static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
 {
+	struct device *dev = dp->mhdp.dev;
 	int ret;
 	unsigned long rate;
 
 	ret = clk_prepare_enable(dp->pclk);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "cannot enable dp pclk %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot enable dp pclk %d\n", ret);
 		goto err_pclk;
 	}
 
 	ret = clk_prepare_enable(dp->core_clk);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "cannot enable core_clk %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot enable core_clk %d\n", ret);
 		goto err_core_clk;
 	}
 
-	ret = pm_runtime_get_sync(dp->dev);
+	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "cannot get pm runtime %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot get pm runtime %d\n", ret);
 		goto err_pm_runtime_get;
 	}
 
@@ -121,18 +122,18 @@ static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
 
 	rate = clk_get_rate(dp->core_clk);
 	if (!rate) {
-		DRM_DEV_ERROR(dp->dev, "get clk rate failed\n");
+		DRM_DEV_ERROR(dev, "get clk rate failed\n");
 		ret = -EINVAL;
 		goto err_set_rate;
 	}
 
-	cdn_dp_set_fw_clk(dp, rate);
-	cdn_dp_clock_reset(dp);
+	cdns_mhdp_set_fw_clk(&dp->mhdp, rate);
+	cdns_mhdp_clock_reset(&dp->mhdp);
 
 	return 0;
 
 err_set_rate:
-	pm_runtime_put(dp->dev);
+	pm_runtime_put(dev);
 err_pm_runtime_get:
 	clk_disable_unprepare(dp->core_clk);
 err_core_clk:
@@ -143,7 +144,7 @@ static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
 
 static void cdn_dp_clk_disable(struct cdn_dp_device *dp)
 {
-	pm_runtime_put_sync(dp->dev);
+	pm_runtime_put_sync(dp->mhdp.dev);
 	clk_disable_unprepare(dp->pclk);
 	clk_disable_unprepare(dp->core_clk);
 }
@@ -176,7 +177,7 @@ static int cdn_dp_get_sink_count(struct cdn_dp_device *dp, u8 *sink_count)
 	u8 value;
 
 	*sink_count = 0;
-	ret = cdn_dp_dpcd_read(dp, DP_SINK_COUNT, &value, 1);
+	ret = cdns_mhdp_dpcd_read(&dp->mhdp, DP_SINK_COUNT, &value, 1);
 	if (ret)
 		return ret;
 
@@ -200,12 +201,13 @@ static struct cdn_dp_port *cdn_dp_connected_port(struct cdn_dp_device *dp)
 
 static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
 {
+	struct device *dev = dp->mhdp.dev;
 	unsigned long timeout = jiffies + msecs_to_jiffies(CDN_DPCD_TIMEOUT_MS);
 	struct cdn_dp_port *port;
 	u8 sink_count = 0;
 
 	if (dp->active_port < 0 || dp->active_port >= dp->ports) {
-		DRM_DEV_ERROR(dp->dev, "active_port is wrong!\n");
+		DRM_DEV_ERROR(dev, "active_port is wrong!\n");
 		return false;
 	}
 
@@ -227,7 +229,7 @@ static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
 		usleep_range(5000, 10000);
 	}
 
-	DRM_DEV_ERROR(dp->dev, "Get sink capability timed out\n");
+	DRM_DEV_ERROR(dev, "Get sink capability timed out\n");
 	return false;
 }
 
@@ -269,7 +271,8 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
 	mutex_lock(&dp->lock);
 	edid = dp->edid;
 	if (edid) {
-		DRM_DEV_DEBUG_KMS(dp->dev, "got edid: width[%d] x height[%d]\n",
+		DRM_DEV_DEBUG_KMS(dp->mhdp.dev,
+				  "got edid: width[%d] x height[%d]\n",
 				  edid->width_cm, edid->height_cm);
 
 		dp->sink_has_audio = drm_detect_monitor_audio(edid);
@@ -287,7 +290,8 @@ static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
 				       struct drm_display_mode *mode)
 {
 	struct cdn_dp_device *dp = connector_to_dp(connector);
-	struct drm_display_info *display_info = &dp->connector.display_info;
+	struct drm_display_info *display_info =
+		&dp->mhdp.connector.display_info;
 	u32 requested, actual, rate, sink_max, source_max = 0;
 	u8 lanes, bpc;
 
@@ -313,7 +317,7 @@ static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
 	sink_max = drm_dp_max_lane_count(dp->dpcd);
 	lanes = min(source_max, sink_max);
 
-	source_max = drm_dp_bw_code_to_link_rate(CDN_DP_MAX_LINK_RATE);
+	source_max = drm_dp_bw_code_to_link_rate(CDNS_DP_MAX_LINK_RATE);
 	sink_max = drm_dp_max_link_rate(dp->dpcd);
 	rate = min(source_max, sink_max);
 
@@ -323,7 +327,7 @@ static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
 	actual = actual * 8 / 10;
 
 	if (requested > actual) {
-		DRM_DEV_DEBUG_KMS(dp->dev,
+		DRM_DEV_DEBUG_KMS(dp->mhdp.dev,
 				  "requested=%d, actual=%d, clock=%d\n",
 				  requested, actual, mode->clock);
 		return MODE_CLOCK_HIGH;
@@ -343,28 +347,29 @@ static int cdn_dp_firmware_init(struct cdn_dp_device *dp)
 	const u32 *iram_data, *dram_data;
 	const struct firmware *fw = dp->fw;
 	const struct cdn_firmware_header *hdr;
+	struct device *dev = dp->mhdp.dev;
 
 	hdr = (struct cdn_firmware_header *)fw->data;
 	if (fw->size != le32_to_cpu(hdr->size_bytes)) {
-		DRM_DEV_ERROR(dp->dev, "firmware is invalid\n");
+		DRM_DEV_ERROR(dev, "firmware is invalid\n");
 		return -EINVAL;
 	}
 
 	iram_data = (const u32 *)(fw->data + hdr->header_size);
 	dram_data = (const u32 *)(fw->data + hdr->header_size + hdr->iram_size);
 
-	ret = cdn_dp_load_firmware(dp, iram_data, hdr->iram_size,
-				   dram_data, hdr->dram_size);
+	ret = cdns_mhdp_load_firmware(&dp->mhdp, iram_data, hdr->iram_size,
+				      dram_data, hdr->dram_size);
 	if (ret)
 		return ret;
 
-	ret = cdn_dp_set_firmware_active(dp, true);
+	ret = cdns_mhdp_set_firmware_active(&dp->mhdp, true);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "active ucpu failed: %d\n", ret);
+		DRM_DEV_ERROR(dev, "active ucpu failed: %d\n", ret);
 		return ret;
 	}
 
-	return cdn_dp_event_config(dp);
+	return cdns_mhdp_event_config(&dp->mhdp);
 }
 
 static int cdn_dp_get_sink_capability(struct cdn_dp_device *dp)
@@ -374,28 +379,29 @@ static int cdn_dp_get_sink_capability(struct cdn_dp_device *dp)
 	if (!cdn_dp_check_sink_connection(dp))
 		return -ENODEV;
 
-	ret = cdn_dp_dpcd_read(dp, DP_DPCD_REV, dp->dpcd,
-			       DP_RECEIVER_CAP_SIZE);
+	ret = cdns_mhdp_dpcd_read(&dp->mhdp, DP_DPCD_REV, dp->dpcd,
+				  DP_RECEIVER_CAP_SIZE);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to get caps %d\n", ret);
+		DRM_DEV_ERROR(dp->mhdp.dev, "Failed to get caps %d\n", ret);
 		return ret;
 	}
 
 	kfree(dp->edid);
-	dp->edid = drm_do_get_edid(&dp->connector,
-				   cdn_dp_get_edid_block, dp);
+	dp->edid = drm_do_get_edid(&dp->mhdp.connector,
+				   cdns_mhdp_get_edid_block, &dp->mhdp);
 	return 0;
 }
 
 static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 {
+	struct device *dev = dp->mhdp.dev;
 	union extcon_property_value property;
 	int ret;
 
 	if (!port->phy_enabled) {
 		ret = phy_power_on(port->phy);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "phy power on failed: %d\n",
+			DRM_DEV_ERROR(dev, "phy power on failed: %d\n",
 				      ret);
 			goto err_phy;
 		}
@@ -405,28 +411,28 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 	ret = cdn_dp_grf_write(dp, GRF_SOC_CON26,
 			       DPTX_HPD_SEL_MASK | DPTX_HPD_SEL);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to write HPD_SEL %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to write HPD_SEL %d\n", ret);
 		goto err_power_on;
 	}
 
-	ret = cdn_dp_get_hpd_status(dp);
+	ret = cdns_mhdp_get_hpd_status(&dp->mhdp);
 	if (ret <= 0) {
 		if (!ret)
-			DRM_DEV_ERROR(dp->dev, "hpd does not exist\n");
+			DRM_DEV_ERROR(dev, "hpd does not exist\n");
 		goto err_power_on;
 	}
 
 	ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
 				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "get property failed\n");
+		DRM_DEV_ERROR(dev, "get property failed\n");
 		goto err_power_on;
 	}
 
 	port->lanes = cdn_dp_get_port_lanes(port);
-	ret = cdn_dp_set_host_cap(dp, port->lanes, property.intval);
+	ret = cdns_mhdp_set_host_cap(&dp->mhdp, port->lanes, property.intval);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "set host capabilities failed: %d\n",
+		DRM_DEV_ERROR(dev, "set host capabilities failed: %d\n",
 			      ret);
 		goto err_power_on;
 	}
@@ -436,7 +442,7 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 
 err_power_on:
 	if (phy_power_off(port->phy))
-		DRM_DEV_ERROR(dp->dev, "phy power off failed: %d", ret);
+		DRM_DEV_ERROR(dev, "phy power off failed: %d", ret);
 	else
 		port->phy_enabled = false;
 
@@ -454,7 +460,8 @@ static int cdn_dp_disable_phy(struct cdn_dp_device *dp,
 	if (port->phy_enabled) {
 		ret = phy_power_off(port->phy);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "phy power off failed: %d", ret);
+			DRM_DEV_ERROR(dp->mhdp.dev,
+				      "phy power off failed: %d", ret);
 			return ret;
 		}
 	}
@@ -478,16 +485,16 @@ static int cdn_dp_disable(struct cdn_dp_device *dp)
 	ret = cdn_dp_grf_write(dp, GRF_SOC_CON26,
 			       DPTX_HPD_SEL_MASK | DPTX_HPD_DEL);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to clear hpd sel %d\n",
+		DRM_DEV_ERROR(dp->mhdp.dev, "Failed to clear hpd sel %d\n",
 			      ret);
 		return ret;
 	}
 
-	cdn_dp_set_firmware_active(dp, false);
+	cdns_mhdp_set_firmware_active(&dp->mhdp, false);
 	cdn_dp_clk_disable(dp);
 	dp->active = false;
-	dp->link.rate = 0;
-	dp->link.num_lanes = 0;
+	dp->mhdp.link.rate = 0;
+	dp->mhdp.link.num_lanes = 0;
 	if (!dp->connected) {
 		kfree(dp->edid);
 		dp->edid = NULL;
@@ -500,11 +507,11 @@ static int cdn_dp_enable(struct cdn_dp_device *dp)
 {
 	int ret, i, lanes;
 	struct cdn_dp_port *port;
+	struct device *dev = dp->mhdp.dev;
 
 	port = cdn_dp_connected_port(dp);
 	if (!port) {
-		DRM_DEV_ERROR(dp->dev,
-			      "Can't enable without connection\n");
+		DRM_DEV_ERROR(dev, "Can't enable without connection\n");
 		return -ENODEV;
 	}
 
@@ -517,7 +524,7 @@ static int cdn_dp_enable(struct cdn_dp_device *dp)
 
 	ret = cdn_dp_firmware_init(dp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "firmware init failed: %d", ret);
+		DRM_DEV_ERROR(dp->mhdp.dev, "firmware init failed: %d", ret);
 		goto err_clk_disable;
 	}
 
@@ -551,8 +558,9 @@ static void cdn_dp_encoder_mode_set(struct drm_encoder *encoder,
 				    struct drm_display_mode *adjusted)
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
-	struct drm_display_info *display_info = &dp->connector.display_info;
-	struct video_info *video = &dp->video_info;
+	struct drm_display_info *display_info =
+		&dp->mhdp.connector.display_info;
+	struct video_info *video = &dp->mhdp.video_info;
 
 	switch (display_info->bpc) {
 	case 10:
@@ -570,7 +578,7 @@ static void cdn_dp_encoder_mode_set(struct drm_encoder *encoder,
 	video->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
 	video->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
 
-	memcpy(&dp->mode, adjusted, sizeof(*mode));
+	memcpy(&dp->mhdp.mode, adjusted, sizeof(*mode));
 }
 
 static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
@@ -579,11 +587,11 @@ static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
 	struct cdn_dp_port *port = cdn_dp_connected_port(dp);
 	u8 sink_lanes = drm_dp_max_lane_count(dp->dpcd);
 
-	if (!port || !dp->link.rate || !dp->link.num_lanes)
+	if (!port || !dp->mhdp.link.rate || !dp->mhdp.link.num_lanes)
 		return false;
 
-	if (cdn_dp_dpcd_read(dp, DP_LANE0_1_STATUS, link_status,
-			     DP_LINK_STATUS_SIZE)) {
+	if (cdns_mhdp_dpcd_read(&dp->mhdp, DP_LANE0_1_STATUS, link_status,
+				DP_LINK_STATUS_SIZE)) {
 		DRM_ERROR("Failed to get link status\n");
 		return false;
 	}
@@ -595,15 +603,16 @@ static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
 static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
+	struct device *dev = dp->mhdp.dev;
 	int ret, val;
 
-	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
+	ret = drm_of_encoder_active_endpoint_id(dev->of_node, encoder);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "Could not get vop id, %d", ret);
+		DRM_DEV_ERROR(dev, "Could not get vop id, %d", ret);
 		return;
 	}
 
-	DRM_DEV_DEBUG_KMS(dp->dev, "vop %s output to cdn-dp\n",
+	DRM_DEV_DEBUG_KMS(dev, "vop %s output to cdn-dp\n",
 			  (ret) ? "LIT" : "BIG");
 	if (ret)
 		val = DP_SEL_VOP_LIT | (DP_SEL_VOP_LIT << 16);
@@ -618,33 +627,33 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 
 	ret = cdn_dp_enable(dp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to enable encoder %d\n",
+		DRM_DEV_ERROR(dev, "Failed to enable encoder %d\n",
 			      ret);
 		goto out;
 	}
 	if (!cdn_dp_check_link_status(dp)) {
-		ret = cdn_dp_train_link(dp);
+		ret = cdns_mhdp_train_link(&dp->mhdp);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "Failed link train %d\n", ret);
+			DRM_DEV_ERROR(dev, "Failed link train %d\n", ret);
 			goto out;
 		}
 	}
 
-	ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
+	ret = cdns_mhdp_set_video_status(&dp->mhdp, CONTROL_VIDEO_IDLE);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to idle video %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to idle video %d\n", ret);
 		goto out;
 	}
 
-	ret = cdn_dp_config_video(dp);
+	ret = cdns_mhdp_config_video(&dp->mhdp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to config video %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to config video %d\n", ret);
 		goto out;
 	}
 
-	ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_VALID);
+	ret = cdns_mhdp_set_video_status(&dp->mhdp, CONTROL_VIDEO_VALID);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to valid video %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to valid video %d\n", ret);
 		goto out;
 	}
 out:
@@ -660,7 +669,8 @@ static void cdn_dp_encoder_disable(struct drm_encoder *encoder)
 	if (dp->active) {
 		ret = cdn_dp_disable(dp);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "Failed to disable encoder %d\n",
+			DRM_DEV_ERROR(dp->mhdp.dev,
+				      "Failed to disable encoder %d\n",
 				      ret);
 		}
 	}
@@ -704,7 +714,7 @@ static const struct drm_encoder_funcs cdn_dp_encoder_funcs = {
 
 static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 {
-	struct device *dev = dp->dev;
+	struct device *dev = dp->mhdp.dev;
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
@@ -716,10 +726,10 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dp->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(dp->regs)) {
+	dp->mhdp.regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dp->mhdp.regs)) {
 		DRM_DEV_ERROR(dev, "ioremap reg failed\n");
-		return PTR_ERR(dp->regs);
+		return PTR_ERR(dp->mhdp.regs);
 	}
 
 	dp->core_clk = devm_clk_get(dev, "core-clk");
@@ -734,10 +744,10 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 		return PTR_ERR(dp->pclk);
 	}
 
-	dp->spdif_clk = devm_clk_get(dev, "spdif");
-	if (IS_ERR(dp->spdif_clk)) {
+	dp->mhdp.spdif_clk = devm_clk_get(dev, "spdif");
+	if (IS_ERR(dp->mhdp.spdif_clk)) {
 		DRM_DEV_ERROR(dev, "cannot get spdif_clk\n");
-		return PTR_ERR(dp->spdif_clk);
+		return PTR_ERR(dp->mhdp.spdif_clk);
 	}
 
 	dp->grf_clk = devm_clk_get(dev, "grf");
@@ -746,10 +756,10 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 		return PTR_ERR(dp->grf_clk);
 	}
 
-	dp->spdif_rst = devm_reset_control_get(dev, "spdif");
-	if (IS_ERR(dp->spdif_rst)) {
+	dp->mhdp.spdif_rst = devm_reset_control_get(dev, "spdif");
+	if (IS_ERR(dp->mhdp.spdif_rst)) {
 		DRM_DEV_ERROR(dev, "no spdif reset control found\n");
-		return PTR_ERR(dp->spdif_rst);
+		return PTR_ERR(dp->mhdp.spdif_rst);
 	}
 
 	dp->dptx_rst = devm_reset_control_get(dev, "dptx");
@@ -804,7 +814,7 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
 		goto out;
 	}
 
-	ret = cdn_dp_audio_config(dp, &audio);
+	ret = cdns_mhdp_audio_config(&dp->mhdp, &audio);
 	if (!ret)
 		dp->audio_info = audio;
 
@@ -822,7 +832,7 @@ static void cdn_dp_audio_shutdown(struct device *dev, void *data)
 	if (!dp->active)
 		goto out;
 
-	ret = cdn_dp_audio_stop(dp, &dp->audio_info);
+	ret = cdns_mhdp_audio_stop(&dp->mhdp, &dp->audio_info);
 	if (!ret)
 		dp->audio_info.format = AFMT_UNUSED;
 out:
@@ -841,7 +851,7 @@ static int cdn_dp_audio_digital_mute(struct device *dev, void *data,
 		goto out;
 	}
 
-	ret = cdn_dp_audio_mute(dp, enable);
+	ret = cdns_mhdp_audio_mute(&dp->mhdp, enable);
 
 out:
 	mutex_unlock(&dp->lock);
@@ -853,7 +863,8 @@ static int cdn_dp_audio_get_eld(struct device *dev, void *data,
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 
-	memcpy(buf, dp->connector.eld, min(sizeof(dp->connector.eld), len));
+	memcpy(buf, dp->mhdp.connector.eld,
+	       min(sizeof(dp->mhdp.connector.eld), len));
 
 	return 0;
 }
@@ -887,6 +898,7 @@ static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
 	int ret;
 	unsigned long timeout = jiffies + msecs_to_jiffies(CDN_FW_TIMEOUT_MS);
 	unsigned long sleep = 1000;
+	struct device *dev = dp->mhdp.dev;
 
 	WARN_ON(!mutex_is_locked(&dp->lock));
 
@@ -897,13 +909,13 @@ static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
 	mutex_unlock(&dp->lock);
 
 	while (time_before(jiffies, timeout)) {
-		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
+		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dev);
 		if (ret == -ENOENT) {
 			msleep(sleep);
 			sleep *= 2;
 			continue;
 		} else if (ret) {
-			DRM_DEV_ERROR(dp->dev,
+			DRM_DEV_ERROR(dev,
 				      "failed to request firmware: %d\n", ret);
 			goto out;
 		}
@@ -913,7 +925,7 @@ static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
 		goto out;
 	}
 
-	DRM_DEV_ERROR(dp->dev, "Timed out trying to load firmware\n");
+	DRM_DEV_ERROR(dev, "Timed out trying to load firmware\n");
 	ret = -ETIMEDOUT;
 out:
 	mutex_lock(&dp->lock);
@@ -924,8 +936,9 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
-	struct drm_connector *connector = &dp->connector;
+	struct drm_connector *connector = &dp->mhdp.connector;
 	enum drm_connector_status old_status;
+	struct device *dev = dp->mhdp.dev;
 
 	int ret;
 
@@ -942,44 +955,45 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 
 	/* Not connected, notify userspace to disable the block */
 	if (!cdn_dp_connected_port(dp)) {
-		DRM_DEV_INFO(dp->dev, "Not connected. Disabling cdn\n");
+		DRM_DEV_INFO(dev, "Not connected. Disabling cdn\n");
 		dp->connected = false;
 
 	/* Connected but not enabled, enable the block */
 	} else if (!dp->active) {
-		DRM_DEV_INFO(dp->dev, "Connected, not enabled. Enabling cdn\n");
+		DRM_DEV_INFO(dev, "Connected, not enabled. Enabling cdn\n");
 		ret = cdn_dp_enable(dp);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "Enable dp failed %d\n", ret);
+			DRM_DEV_ERROR(dev, "Enable dp failed %d\n", ret);
 			dp->connected = false;
 		}
 
 	/* Enabled and connected to a dongle without a sink, notify userspace */
 	} else if (!cdn_dp_check_sink_connection(dp)) {
-		DRM_DEV_INFO(dp->dev, "Connected without sink. Assert hpd\n");
+		DRM_DEV_INFO(dev, "Connected without sink. Assert hpd\n");
 		dp->connected = false;
 
 	/* Enabled and connected with a sink, re-train if requested */
 	} else if (!cdn_dp_check_link_status(dp)) {
-		unsigned int rate = dp->link.rate;
-		unsigned int lanes = dp->link.num_lanes;
-		struct drm_display_mode *mode = &dp->mode;
+		unsigned int rate = dp->mhdp.link.rate;
+		unsigned int lanes = dp->mhdp.link.num_lanes;
+		struct drm_display_mode *mode = &dp->mhdp.mode;
 
-		DRM_DEV_INFO(dp->dev, "Connected with sink. Re-train link\n");
-		ret = cdn_dp_train_link(dp);
+		DRM_DEV_INFO(dev, "Connected with sink. Re-train link\n");
+		ret = cdns_mhdp_train_link(&dp->mhdp);
 		if (ret) {
 			dp->connected = false;
-			DRM_DEV_ERROR(dp->dev, "Train link failed %d\n", ret);
+			DRM_DEV_ERROR(dev, "Train link failed %d\n", ret);
 			goto out;
 		}
 
 		/* If training result is changed, update the video config */
 		if (mode->clock &&
-		    (rate != dp->link.rate || lanes != dp->link.num_lanes)) {
-			ret = cdn_dp_config_video(dp);
+		    (rate != dp->mhdp.link.rate ||
+		     lanes != dp->mhdp.link.num_lanes)) {
+			ret = cdns_mhdp_config_video(&dp->mhdp);
 			if (ret) {
 				dp->connected = false;
-				DRM_DEV_ERROR(dp->dev,
+				DRM_DEV_ERROR(dev,
 					      "Failed to config video %d\n",
 					      ret);
 			}
@@ -1048,7 +1062,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
 
-	connector = &dp->connector;
+	connector = &dp->mhdp.connector;
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 	connector->dpms = DRM_MODE_DPMS_OFF;
 
@@ -1072,7 +1086,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 		port = dp->port[i];
 
 		port->event_nb.notifier_call = cdn_dp_pd_event;
-		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
+		ret = devm_extcon_register_notifier(dp->mhdp.dev, port->extcon,
 						    EXTCON_DISP_DP,
 						    &port->event_nb);
 		if (ret) {
@@ -1099,7 +1113,7 @@ static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 	struct drm_encoder *encoder = &dp->encoder;
-	struct drm_connector *connector = &dp->connector;
+	struct drm_connector *connector = &dp->mhdp.connector;
 
 	cancel_work_sync(&dp->event_work);
 	cdn_dp_encoder_disable(encoder);
@@ -1159,7 +1173,7 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
-	dp->dev = dev;
+	dp->mhdp.dev = dev;
 
 	match = of_match_node(cdn_dp_dt_ids, pdev->dev.of_node);
 	dp_data = (struct cdn_dp_data *)match->data;
@@ -1204,7 +1218,7 @@ static int cdn_dp_remove(struct platform_device *pdev)
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
 
 	platform_device_unregister(dp->audio_pdev);
-	cdn_dp_suspend(dp->dev);
+	cdn_dp_suspend(dp->mhdp.dev);
 	component_del(&pdev->dev, &cdn_dp_component_ops);
 
 	return 0;
@@ -1214,7 +1228,7 @@ static void cdn_dp_shutdown(struct platform_device *pdev)
 {
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
 
-	cdn_dp_suspend(dp->dev);
+	cdn_dp_suspend(dp->mhdp.dev);
 }
 
 static const struct dev_pm_ops cdn_dp_pm_ops = {
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index f57e296401b8..905dc4494795 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -20,38 +20,10 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_panel.h>
 #include "rockchip_drm_drv.h"
+#include "cdns-mhdp-common.h"
 
 #define MAX_PHY		2
 
-enum audio_format {
-	AFMT_I2S = 0,
-	AFMT_SPDIF = 1,
-	AFMT_UNUSED,
-};
-
-struct audio_info {
-	enum audio_format format;
-	int sample_rate;
-	int channels;
-	int sample_width;
-};
-
-enum vic_pxl_encoding_format {
-	PXL_RGB = 0x1,
-	YCBCR_4_4_4 = 0x2,
-	YCBCR_4_2_2 = 0x4,
-	YCBCR_4_2_0 = 0x8,
-	Y_ONLY = 0x10,
-};
-
-struct video_info {
-	bool h_sync_polarity;
-	bool v_sync_polarity;
-	bool interlaced;
-	int color_depth;
-	enum vic_pxl_encoding_format color_fmt;
-};
-
 struct cdn_firmware_header {
 	u32 size_bytes; /* size of the entire header+image(s) in bytes */
 	u32 header_size; /* size of just the header in bytes */
@@ -70,11 +42,9 @@ struct cdn_dp_port {
 };
 
 struct cdn_dp_device {
-	struct device *dev;
+	struct cdns_mhdp_device mhdp;
 	struct drm_device *drm_dev;
-	struct drm_connector connector;
 	struct drm_encoder encoder;
-	struct drm_display_mode mode;
 	struct platform_device *audio_pdev;
 	struct work_struct event_work;
 	struct edid *edid;
@@ -85,22 +55,16 @@ struct cdn_dp_device {
 	bool suspended;
 
 	const struct firmware *fw;	/* cdn dp firmware */
-	unsigned int fw_version;	/* cdn fw version */
 	bool fw_loaded;
 
-	void __iomem *regs;
 	struct regmap *grf;
 	struct clk *core_clk;
 	struct clk *pclk;
-	struct clk *spdif_clk;
 	struct clk *grf_clk;
-	struct reset_control *spdif_rst;
 	struct reset_control *dptx_rst;
 	struct reset_control *apb_rst;
 	struct reset_control *core_rst;
 	struct audio_info audio_info;
-	struct video_info video_info;
-	struct drm_dp_link link;
 	struct cdn_dp_port *port[MAX_PHY];
 	u8 ports;
 	u8 lanes;
-- 
2.17.1

