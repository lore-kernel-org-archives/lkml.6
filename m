Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A4ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1547420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="q96yJwxj";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VwpeGKjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1547420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeIYPW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:22:57 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:49244 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729015AbeIYPWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:22:55 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8P9Bd5W019834;
        Tue, 25 Sep 2018 02:15:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=9hF5p61lXEPYmzPaaQrAx83Ryau8Ft71kqnNwJGlB18=;
 b=q96yJwxjQjx59SVuWVgzxkU+WpesnERDQB3tRIKSXcqe4Q9pvLTrUs7Ex1rxV1PcCkYD
 3oO8+8MKDBRtqY6wC8Pm8Ic5kbhDVxIVtaXyRDfjEdzZk0qp4N6nxJkPbMou4pztVUxM
 l9lr3GpTsO2KhjSioOEeKqqw6Mfc/fw9ZyliDSN8GvyulUQzr0HkvsVEM86Z6uoWK2XZ
 cugKgMI9Xe2Ea2TIbRaeg6CRLlHrZwI7CYVo1fjQjJLAYOslRXyCcLSuOY9D4pRFG0Au
 D3OUUyUfp2N4Io6PjndMG2xl0d35Fi4HzxKpr6U/xl1EZO3d3TwAfpFoyVvi6WQi1kLM jg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp0083.outbound.protection.outlook.com [216.32.180.83])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mnj9vkfkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Sep 2018 02:15:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hF5p61lXEPYmzPaaQrAx83Ryau8Ft71kqnNwJGlB18=;
 b=VwpeGKjGQFVkWeFH5u1gUE0z1L0AnZIdWK/Cgju1qlYn5XZbxToVJ43Te9CYdy1T8gglwD5rJowUCPyd+WgP3MkbCE77ArKBV0vkW0c/R1xopsYOWwTr7WZoxoFdvtdRK+hONAmIVVhXppm9Nw28LP3L6AmITKw8fBOGz357dsc=
Received: from SN4PR0701CA0017.namprd07.prod.outlook.com
 (2603:10b6:803:28::27) by DM5PR07MB2955.namprd07.prod.outlook.com
 (2603:10b6:3:a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Tue, 25 Sep
 2018 09:15:30 +0000
Received: from CO1NAM05FT033.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by SN4PR0701CA0017.outlook.office365.com
 (2603:10b6:803:28::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Tue, 25 Sep 2018 09:15:30 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT033.mail.protection.outlook.com (10.152.96.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.5 via Frontend Transport; Tue, 25 Sep 2018 09:15:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9FPqU028604
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Sep 2018 02:15:27 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Sep 2018 11:15:11 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 25 Sep 2018 11:15:11 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9F393007728;
        Tue, 25 Sep 2018 10:15:03 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8P9F3YD007727;
        Tue, 25 Sep 2018 10:15:03 +0100
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
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <rafalc@cadence.com>,
        <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>
Subject: [PATCH v5 2/5] drm/dp: fix link probing for devices supporting DP 1.4+
Date:   Tue, 25 Sep 2018 10:13:32 +0100
Message-ID: <1537866837-4408-3-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1537866837-4408-1-git-send-email-dkos@cadence.com>
References: <1537866837-4408-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(36092001)(199004)(189003)(446003)(246002)(305945005)(486006)(7636002)(8676002)(7416002)(4326008)(11346002)(106466001)(105596002)(126002)(86362001)(54906003)(14444005)(42186006)(110136005)(356003)(8936002)(186003)(6666003)(5660300001)(2201001)(2906002)(50226002)(16586007)(316002)(36756003)(26005)(48376002)(336012)(51416003)(478600001)(47776003)(87636003)(2616005)(476003)(50466002)(26826003)(76176011)(426003)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2955;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT033;1:RfJroJquqK/VIEO08QGl1GnVOfw1E0flTNg4C9+Oc+rGolJUlyYg5oEDgppn31PRm0aVpBc1TiKM2+G47WOCP367G4KHW9QHfYq8pHg3NAiljXHl/vLZT3u1Va6ZFaxQ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90f40c23-c819-4e05-3b42-08d622c7705c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:DM5PR07MB2955;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;3:fO0slzrP9jtXTehiaDR8I1TLJ5dIw9sMGumvHa93zv2+lZg6aUC+fAChsrEhnTZ7g4fEJTVBggmfYpnqa94x+x2udj0syl4iPGTD7HWecZlqt1gtSsWiytMj/cI5q9UywjD3x6iSqjSyHVjCi3ibg3eG0yXu3PAiXGsFNzD4OusA1O5k2SNp4FieQ7iW67B2wzPYJzqY6kfFEk8Qa7GIbA41X/JKN3ALzv7oI7tGGwohwEZleARj4gLRehMAGmVh0gd8IYWqA+ueFlOotaPB4E+5PQ77A3BmuATc35tPG/KkOC+oUtAo1LS4Tzq/asHn+j8UTj/oPshvhysiK2Hs3JbRm4g2L0qM6IzZ0RFEUrU=;25:8sOnKUnlSeswt6CMhNuQWxNK51WxQ0psjVs33hJq98/efGo0mcYHH+Gl+yAmHZrkTzkPVeAWExYQcEjEWg1VY/EsVkxPjePWjRwa0Y1j6cb6nFrvzjx5CTJ8UA1p8ih3io4TBFj4gVc/e9BFjYMVUIJMMzTs5jzVaCzAzrUETF4+mQGRkaI5BYeD8dX3N0MCHYGXWuTInlENZ3BrXSavWXkIx3U3JOQPqudISd8YI2iTAffvF4SVNbGwT4S8Mb2D9fP18WwHjltlQ2pMpLIoXute6Cuy00MVDeTC0yY24O/flIek1t6uoF0aiYVfOAmwpK5ajailoHURuxDeXqnv0w==
X-MS-TrafficTypeDiagnostic: DM5PR07MB2955:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;31:J0pBADHCGMWYbCek2o5vajZpbF6APETdErDtZ73oolNuaQ8d06dSPLKDVtn578o44rcPOfEleXgJez8p4vc98WC06UGIeOAQ7U2w8sZJ5A09iOhGulseFJfG4vMiOHs0LDeBlK3yVhXmhgNxyUlkypotf2EqufnacXF5lBKcwdhef2zHluTMlDHhnMzq/X0iEuQyVXakWopnxSyVJK2fESk7sWbaydRgcNUhHA9IQAQ=;20:VtnKnekoSdkfK5DLeL8IZUjfEQ5DHZmkRcDgq/GMNWZMOrmqlixY3S3CGjxh0z1Hq7T/RTMtYl3tU0TB6nyh9U6arQEL9dXdNXrcgJBNxNq7wwMfP2qEVVzczDt/SXQA+iP7zLGQdVKpgSjpnf0X0eG0idEusxcmeTinfbPKH3tdBzHID0x1WVQ5MbBjCQ89hY+xIBr8ZR0o9ixsOOigZ13Z8DZrVWqX3MhIVVmpAJEQ16VeSli+WF2FVpwwLZTYdpjhYBSnuJv2DLNibc4uWN/T73nokEtI0YISF/ya05+CanY+cxake+MAUNn7vDamf11WZLE3ud9nnYicd99fP700mhYVDszhjVj0BaasNxAG2er4LEXa7YPpZ/15e86vLLBxvwLTS41EzH2BxuZOpAZHbmIDgSr1C/WNkEUGdI8owUgcqO7R4sRbp0fhnvy0+t+d34NoAEWJisZrJHGSOWCehcf4fSX69O807ie4HH0DaY3zWscZk8sfm51YH0Zp
X-Microsoft-Antispam-PRVS: <DM5PR07MB29550B62DC68226021F3E37DCD160@DM5PR07MB2955.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR07MB2955;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2955;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;4:5KrKE94hmlKkWGbcBOK9W6s8zrDdy4x2bAJIXm6ivIiR2xArUS2WEeCdl/O1Li/dcuaXs6urBUxusnBjUG/mMgEEZh4VmbeTNQyn2o3+6wd5ulZIjGxJvxr+qe89kXzGUrYJDqImsfRgRSf6Lbo5pejw1iBgfLeqa0iAkhZw70QtWswVcRrSG6kOrWL2Om+4WKWjTx3dfczXOuKiHeP+rh898zVX1h7cZF03QvUxbGUwMfjR5PbouQetIvlp4xzsPDYDnruwneDq3Mm0GtVCnEnWd5YhObfhZkGsQIZNIQ2nkqVqqFQoOg5yEqhy/GgMOdcpZy9PLSQgnJKyvgFlv+xwYTQByxv2bZX06xA2jxM=
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2955;23:ZJ3QKaNWTfW4ki3unhU8XqkMjFiG119HD+npZO0Yh?=
 =?us-ascii?Q?+1Jksn7HeFcgHn5inYBsm/+WMXpJHhXBhsuVONaI6MQ88io+2UHeLfFs17+e?=
 =?us-ascii?Q?nubB/t0EN7a4TlNMWRAhGZJdNlY3REizE9KnDQmQEMkfxZf7aG4QjZk1ypBa?=
 =?us-ascii?Q?LxlCmgszWqRXC74yxob7186WJjiDXCQS4FfUK3Va6apkOuOp8DOmhgzHUesq?=
 =?us-ascii?Q?DsjphW1z08H5SKsYwR+61CKHWmCrdzZZEYmE85a3diPoFB7fiPl1wa9JypRV?=
 =?us-ascii?Q?Mc1HEWi9USnXQXS/4ilaHzrabi4TVE5SZJry2ltOZxuYr7t4d5e3XWKQhZt5?=
 =?us-ascii?Q?q/OY9dLeIAYqg9y4dvo/C3BXjo7GK+O4IvJJv0rWwr26DBBWRXgr8/xKsbs4?=
 =?us-ascii?Q?hkoHi6DzyT4MRNgbKX70qjCBHYPpPZHgx8yOE5vWSB75e4L5UxC17VicFiWs?=
 =?us-ascii?Q?NvI7czdPYvi2Vi54g9Hut9FTNMkjiEWeogc9HF4gr+hRMP469tNVXfDRYUxi?=
 =?us-ascii?Q?9x7QOPu/wWv9d/qQwCEx15nVR8Tj8jatEdOcYV/WhTR4fdYkEt9kejSlqPs2?=
 =?us-ascii?Q?i15dnyxdwQQ0cTrBw/BNlAmuc/BN7J7pnRJ9ku10ysLe+57YIKIElicz27Vv?=
 =?us-ascii?Q?UfgfCFkcOi6tKowAfOzLgZcLnQ9DvLOw/BP84bjy3yWCrr/ZRNKNJVhGqlxN?=
 =?us-ascii?Q?+fogb7S3oYMlVqWZSsHBfC6+uPu5BWhWKcPxb8aiBn6XjkzH0nBzvsXdFQOB?=
 =?us-ascii?Q?bcgono+rrpj39FWp10korwBl3ZrQ38/2bgCt2jwIe79aqVThELeCth0kGlXb?=
 =?us-ascii?Q?koM0zAIJ0IxottOR7dmdeReTKaumsMDUJi8Kp328hC5XO5zPLLR3g4MajrZm?=
 =?us-ascii?Q?IClKD8iJuyPVUYZRkMMvCEqlDWEiMXnw/lhPfHteSpOVUWcKJdsAeidCysgM?=
 =?us-ascii?Q?DEWGumsUdQ1nzolhC5RbiQc0SJNKtjT1vw7RVzcndJ6pcVfQ1D7n4WhDL7iU?=
 =?us-ascii?Q?/b1z7HFPYZF3kwAcwNE9m5GtdsJccSodfRy/yMKLdnAvRYIzFLarrkBPm2Kc?=
 =?us-ascii?Q?0Wo+tRtUExvIAhSjVMZrhrBUYdijV2A81lOi3eQNNWGzW3CiomfNsCjUz//Y?=
 =?us-ascii?Q?wQ6zZ0Nfjl+sT4KaHDAvsKgLgwvm6qdGuKfCyNrAV3+3GLxhJRQJ15kezrIT?=
 =?us-ascii?Q?r2fI72pAOmmgtc=3D?=
X-Microsoft-Antispam-Message-Info: +JjJELf2UER+eLFAq1WrMcBVQOQ025bJ6Xi//gVRjqd6+59IrvHWexjTHTZeXsCPFZnvmzJJhWqVpdUimbiy2pq+/yIDczKTARGsjPtYQASgpF46jYaRjVEcp/9V9Blspk6nqBUGa2u+4uWLOiuStCBPDim8WTLekpERmclDWaODzBnW6A1smmASyeYPuVxo8SWPqDBP19mRtzUfzOoPcuyAnlKWdRxw4cmBebx7CLyHJf2oou8XO1Dzs5aoCjkSdv1JaI/ixbC+KSKtbhgdvrnJiMsWEDKZzPyai47W0VqlyfmEdZuSd6WjM7GIwLDwdrFfw5Su4KPz70l44V+6xKcswzpJQ4mxfmWYretou1xyNV0ZOec367IpA3mj4/O6bk29KFR5/EWzMRh9flO8Jg==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;6:cUGvagxQtsGRYftZGlMyP2WRn2VIn17LXjlF/pMpF6msfG9hCw97iLHSJXPC2eSUY9ihBYnJKx4DabVxCWUfCI79Xb15dUYAJi6L9n4jhkLWidx0TmPbz9c9MlLX6iIBzXEdpwF4pPabbzExr4+FtBEMDcgPUwwqaGg+5j/FRXSyXYOUlxdb6ruxRKUIIyDURBnMrOXm5n+nEZ6bDzXrLhJ3Txmhj7l9nrQrzg34FsJ59ifLMWqaOmrOUgXwTCnMJKxmJWrJ1BT7rvKZMb0KGOr9VdtJ+Nz/nPV65tqr863vg7jLleLwlX1JvO2PmO67QakjOL2FNi4Lnfw/Y6sS0Z19f1bjlzLdkcv/bSULeWAt7h9+cFsJvz1oxdb6blrizzHIpYj/c2pyObJdkRkwMcdjcpgYm/CUU11Et4XE9lhcKl0MM5nMGWHA2ZN5mZeUYvRO9bQnbex0a0EKiykwmg==;5:tG6tZ38qAaZKaKZWvY8Ux4sf2nJWPgXzjaAHkw8n4FFH0IYprpz3yS6rYrQSguKXK39t5v1AIO+2v32CZPY+TM2RGxd5fQANUi5ihEYJy7I9PkaibpWb5ZdwpMTkA3qQT3ByGPSFoUZY0mUvX2/ksA0VM7aAsSpQ6yroBemIMo4=;7:5pwCmckK3wYqRl1WfttkT57IgAwtzTvL6ay7T5PGi/ArdF2atQ4noHlPHYkFr5kc1yqLlcNj6RhyAamOmarPj3FbjvuAYLL348aBdEWwUqORR/XwA0YLhs5+UiBQZtxRcoR1c7IRbDXETkYR7JVYcj3NQNwHeWhFObHiel8MSBthVvWhlB8FxwAAYpueJ+gh0AILjbZ9U8+aH82Ag2sWEMZCLITjCoZXaMRc9mwFy1LEyZ2p5o7X0wjuOtDz8SAg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;20:u8vG2efz9DDA5CGac/jABLY91jEYgVzsDt5NuORsCnrcCfeRvAn1rpJC7P4+Nm0ZSdmwqxo6cGSUsXB8HlHJSKSyJlpQr6al3aixmfh9ng+nX94iRYq4NOSehfBvZ12yPrrQOeDC33H718fEeLcNiqUTUJ0wQ7ZWOOkEI73GMzzfj8NcikbQJKkLsO/r3Jxef8tp6qOVYwk8oYVrJGi2BQDRPAWKK6X1WomBcLvqoXXM+f8jS04W075WTF82Yw4V
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:15:29.2651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f40c23-c819-4e05-3b42-08d622c7705c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2955
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=787 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809250096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
"true capabilities" of DPRX device.

Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
might falsely return lower capabilities to "avoid interoperability
issues with some of the existing DP Source devices that malfunction
when they discover the higher capabilities within those three
registers.".

Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
and read 0 so it's safe to check against it even if DP revision is
<1.4

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 8c6b9fd89f8a..735ebde5c2f0 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
 {
 	u8 values[3];
 	int err;
+	unsigned int addr;
 
 	memset(link, 0, sizeof(*link));
 
-	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
+	/*
+	 * DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
+	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
+	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
+	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
+	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
+	 * "true capabilities" of DPRX device.
+	 *
+	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
+	 * might falsely return lower capabilities to "avoid interoperability
+	 * issues with some of the existing DP Source devices that malfunction
+	 * when they discover the higher capabilities within those three
+	 * registers.".
+	 *
+	 * Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
+	 * and read 0 so it's safe to check against it even if DP revision is
+	 * <1.4
+	 */
+	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
+	if (err < 0)
+		return err;
+
+	if (values[0] & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
+		addr = DP_DP13_DPCD_REV;
+	else
+		addr = DP_DPCD_REV;
+
+	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
 	if (err < 0)
 		return err;
 
-- 
2.17.1

