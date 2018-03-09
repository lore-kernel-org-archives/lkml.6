Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1163969-1520620890-2-15196050136467260956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520620890; b=Dakhbx4ZdE8G7LqzBv61MVaQihqWMRIdn+qk4qYaWbxqdKN
    o5crYbBqv0e/epUmdK6fR+Ik+AjN718MUuC75RiZoOYsLVMqpQwSEhgBhEoO+oRw
    mBUzPtuaoUxqy2hO+a6js7VH74jYD5PEf5xE/fcO5T1inJFFw+LQuGjhyf5XeJFa
    Ggbej6IUMtI12q1FlyPMCyXKJ09Sq8Ep5W+w09osIVygyKOCPbnIlW+71nebOT/S
    TvNWLvHrn0nmQ++lL8z9psp4cuCfM1GUF2Eqx1UN19Sgs7UbeoHa0LJoRst/Dkq/
    4scVcFx8qju3lar6UmLu6gheZr3P0mIrUGbU8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520620890; bh=p
    MXe3Mgr8NzfrHS92+8jR5DKnpifQ31HcVo5FHn0HJ0=; b=PKnDLYcSEXFkahjJh
    JV+tCkb9Iz9Bd2D8ZIDzNUPGFoosH4+qqINg8rjKodlpxvwUzcI0zpoSjAkRvyx7
    th92tSOIqFayLwYv+YH0JEy8Z1AJ9Ui3Rvtt2bNs2MgQTWdlKdum3rEmNaW992si
    Od9Phhg6fBXW1NngL2Wtc9r5bMwgbMU9RN84/A7fy98RrWJw2GXyfxXNqPVAW+Sn
    d4/PWcXL3G7VBJc+gCwLtKrWYQCZDaNEGSJsNOSaZ9YiiqJjzj84KtFHWAooNR0N
    4FF6WlH2FCmbjNOkcjWudW0ixGMX6uWhXlfKrt35bwppJNLUsr9qUgfbyChxwoFk
    J9Z4A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=ZdCzcEqB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=ZdCzcEqB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v2 0/2] fsl-dpaa2/eth: Enable multi-arch compile
Date: Fri,  9 Mar 2018 12:40:54 -0600
Message-Id: <20180309184056.25370-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: MWHPR15CA0040.namprd15.prod.outlook.com
 (2603:10b6:300:ad::26) To HE1PR0402MB2699.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2a6a7ba-0230-44d0-ba9c-08d585ed58db
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB2699;
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2699;
 3:+gxSRyFo3aDJRQfOe3X8jWpiqIzkTXxCBSfG6jgmTdQXX43V7BO9UlpRufTMPqOA8qlYKaZh7qcvRBPyGhglxChKvK4EQmT+DM4EEAcQ5nn0b+LC3Pjd8BVI7Qbuz1tCt/N33R9iYY38ow4OfGxSEXWdLbnNk+QOeEFvLRASNQc3zt460lW/N9klFn4pE3/bvqZahBbTMkT4tRdAA/RQt2Kgw+RHEmpylawhorZ/YbyzdDFyKqbIpLpCjKRfowFt;
 25:ajJ3GWa/zciwRIHGgobvNKX6iTt5KySwJbs+0U4A4sqiyEbYtiH4Zq8bPZXqZ/2mCFZb1lejs4OFZuIbbatdRsO41byZfnB2TL9lqQXdFdtyEP4EL8/qNHS9BihoGBBZCwlrI8fxLZrRoqWnASkN2emJ5SEbhIvs14TB9Ez/PbJBNm1KyutD9xZ+TAPdagPHig4IKfK9EvBplfwwfX4IY2G4W+TnvYz4EikwSwnqt+bfs92Zx0gYEv0sjjyXPiwz/suuF6hBZheRmAWXsdk0x68Luwnrb2PDhakbfjM+ilIiFFY21GUsa251N44Hk2jfBYaxcHBu6bWD2KDMHSt47g==;
 31:cNwa0Lle2msH1vuyoojLcBkvkdJZiAd/jcyvyP0guhryR1sz+wLtXVCB60Yn9B3z/fGQ/1dQxTJKh5N6CfTeWIqGQzNqch3flAw2iLa3atPL+sJ80s+VQbXKJ7dnYjt+8O59bg2p9/SK1xIm99hWfS73eRsOFugoCoa0KQtHirC/sKVVMMKHHMrMwq6tsx1MzMRLFPZ02yJZMtAIa63TV3vbEgOUnx5FmtQLzpKBWIE=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2699:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2699;
 20:QWAWJwkAiKaW1Y1SIGGiGepQMzNjCuPnsqlOjhBTNrZVIPZ+oE6qHqPSjbC/HuWPC2UijNcRhfsDj7hWv1Eanr0CWQyKg5nnfPMKjEO0+ug0VCRpLSO+Q+cXmI8WPu1XEJ4abPphRJPb6O042B/UNAEx/NuRDqo4cv10h4Ns+5zMFAVzUsq4ry3vYzusgpcOq5b66aseg9lW8xJaIKtBXaShA2rA+sP2/6FoAwUUsfGa/gdx9mQZVLFKrZE6alEvQ/H7BCXFdDvOCJ5SkjnKCfsdOqRyU3cJqZ0SxS3jyZ9rElcqM0HJXxHsoliCGM6jlVGOkZgQc4vgk1kd40q1AjKZVdUyX0M8NhDEKK4QTiNpiAUYdC1PpaAArjca8aSdp2YIsf3CQnHcLtUKO/Uie6vDJRTH7sdUws+t1Eexqd/BD7RMBybWFhLp3OvhiwNDwIyvi4jOmxezdsYNbLCBl6yTVogmtSb47zCJqWogESbteEn9FHX3KSupQ4q37O7Z;
 4:/MnppXpKKPJYZzXM0kDQ3lsJL0sKyRO39MNIwAgJjLbLp4AwXxge80T+A1EGv2j0dJD/jeM5GucTwwkgsdCuu6aJ2AZptlLJtK+3sIAHic6YYm3C8pBDQep81VIIWqCHJaIICQOjVIxkE0l7WA7LeasKn36t33jLfrvU4SgU4/KDebHqOdOQKy3RaK772CmD/i6CH83QLn5IEgpX++1K7euGAszvT3DZJxc0P3Ucy6h25F6JsQ871qEED9PrnxOET5qXpx5oXgenhlTg9zarbg==
X-Microsoft-Antispam-PRVS: <HE1PR0402MB269932C5A5CADE96DC9F22B794DE0@HE1PR0402MB2699.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:HE1PR0402MB2699; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB2699;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(48376002)(105586002)(305945005)(2351001)(106356001)(97736004)(2361001)(6486002)(52116002)(5660300001)(81156014)(81166006)(47776003)(51416003)(8676002)(6506007)(7736002)(59450400001)(478600001)(66066001)(25786009)(386003)(68736007)(8936002)(50226002)(86362001)(16586007)(316002)(1076002)(966005)(6512007)(53936002)(6306002)(16526019)(6916009)(50466002)(186003)(6666003)(26005)(3846002)(6116002)(2906002)(36756003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB2699; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR0402MB2699;
 23:4ywd3mWbyXgq03hlg/YgK5l6uB1143I1Jb/L2Yz?=
 =?us-ascii?Q?1HpRwz5Jm1y5863DApES5tWSRCxA0HFIsCD0z6USBJjJcCL2v45yDyoLoDsF?=
 =?us-ascii?Q?YN+L8spcnUk33eJj0R9vqrt5g7kUQvnacGJNmTn4N7ZpFcEk1fzfX8YqcH+f?=
 =?us-ascii?Q?4iZW4ItySh8PeqLw9gxog36HMD6dpNyrsTvjKWawy6LUvlCCvE5QIkDnjAsS?=
 =?us-ascii?Q?lUhpeb+O82OeoOV8Y1/OKUCcwbVjN9K3+hPDs9xvhohFllL8OGlUMjy1rmSG?=
 =?us-ascii?Q?mEj1qXs99uitDyehM3gr3m0FsSbQVtsSWZyQSS8mxedl296Mo0DkCGFZOjg9?=
 =?us-ascii?Q?FF3IkKE/zSO9lxRqNhZjY8rQdNPvOBmmdosnpkGPm8DEFrW7odjc0uFJGX4R?=
 =?us-ascii?Q?nRV5SCG5xG1qQACwUR+fyjp7vlGogso0Pu9fzwRHeroUGuRJP7WUAMpmOVei?=
 =?us-ascii?Q?6YkWxsGo13lFMjKuUo4qk4ukCQoBZkzOj+ZrXigJVphwutMmVW5lHrU/6Map?=
 =?us-ascii?Q?0hYYiCHkcapyGuLq7/QDFFx2jdRAXG06ES9stjS8dzitEES6S+uVX/zwAStG?=
 =?us-ascii?Q?cwFdqYdYB4YW4L8Wh9vUK3NNlwtHZZZcuXe2Q8YUBwlINg0QDTx6+AnHWyNf?=
 =?us-ascii?Q?iwNFNGiShIOT2iPclLe3lSXny6TSj2zAHKa4a3cY9tZ61PMMlotDjV/pQwXK?=
 =?us-ascii?Q?X6k46Ay7Kcn+x/gTBqFEf+So/aYm6JQGo/rJYnWYIRxwa6SAWDCF4IDxjioI?=
 =?us-ascii?Q?wZWlOPlRz77oMhPQ18BHmfDR/CW/ZYXUcdIQKepRpFU9UFwxVuStN1ga+X4S?=
 =?us-ascii?Q?9mFs8aU9fih33wvPs6mGeNi27SvHZ/tpYYLnCerUFHHVz3VVKXNpnkbfExQI?=
 =?us-ascii?Q?prl/qiZ0J5l4Ey2/OtGI8mheW8pw8qeVD5t2Zof2kH5ndJHxHoy6uPkMK785?=
 =?us-ascii?Q?fyQ726/3mF9FD2o4Gk1oLXPpv/hbiE2ONL4N5YV6LKMYoB9hRLkufTW9edOB?=
 =?us-ascii?Q?XEdmOMWeDpUzStCXtKnAXXDAaiua7g3REw4lAe9wQAh6UW233024656oSxW1?=
 =?us-ascii?Q?8dOPupjfojhxD47wPB3Cr35v19N7v8GBCRwAzZdHy0wvuj0mgQ6rYJpqZ2G8?=
 =?us-ascii?Q?hJevgr05eFMnlAi0xiTwVYVsAikqL1sbGtafKssxliA947Y+m0T+mdA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: O2OAsm4Cj+r7Rke4VJXGJ5NFvwllfPhSbvz2vbnTQWC4WwiJql3HjKRlFZS74V7tlcHoHJg2cnw38lyeqnHKY0Esuy2NUqepSXTAl+wEQPZa7oPSjOInXOAqsO3RU9T74voTLThLEh5fVQi13xMM06kaT73l8H4IvVLLXqPqHxI8BJe91pBfayrRKHskdIVo
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2699;
 6:DPeWkEb8JLGZybNKkC10VGQyPOBloftHRJr6pqqM3eS6xFsOCZ8tuRd+ponbMb0YBXxDlLQvejjZm/RvdS4DWOhi648kKPpGThcBjOmdUxG95pP1kA+zCHV6ru1JszBHmaFxAM8vmbPd/r7IBocn1IW5Is6Z4iner8o2SQYE/Abtd/x2huLjWozUmrWg58vxGL4ZE8B2/qbhd26XJzM/jVzxu4r+SedKEWw0VLRCaDseGHAXXvGDGCvWpdhWtbo/yt617/e1M83BL29egJntN/bZnPmglUA/vlQ+n/FnU5U/NbP+6hwtVaX1SN2qF3nWP/IggSUXLj1WoY/Q/FDSUjag8E5C7tRYRbtpUVI1ms8=;
 5:cXGiEWMlskX7w+6NDecY2MaUyySOwI71T3MVOSuQb+p4daQphhhMPWX+/vsjSo88dg/t7MKa06XfNVfi5453VzkI+RXcOIQ9feKanVobM741I34qlukrXRN017KPxZUpYypcWNHviHfIntkdrVSsmznSIbMQ16chfG3uUxylRgE=;
 24:girG2FKaEH1FFG2cmPNiYyZLxTqRS7PKIpSXOTviqmww+Ay2xViOXVgneqruaePQElb6jsSiWpieDy+cZ4tsyYhmk89Hq+lwdu/hgdlahmw=;
 7:fv/NHfX9kGCq3LjbKHwGz9VNwJ2wASmFER9KnbWmvS+9vcuu38uaZVSDJgmKNLDyhKOeBSQvruClL/W4tcB0RWQnLUr4OYMfvl2jGyyQMge34nwsUOftnXzt7X6LvIm7g6O9QlXUhFzI4KqAOFU2e2kkm8fwoKrqA5dHBNkhJ9KIRkd2MyQvlH/6R1+s5hqYjjM/uhTbnFqAy3/1WcdTshhNoo9cag3jhSlluO0D890glrAYUHDQt32MEAKS50ZT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 18:41:16.6864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a6a7ba-0230-44d0-ba9c-08d585ed58db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2699
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, roy.pledge@nxp.com,
 linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Ethernet driver can be built on multiple architectures, so
remove the ARCH_LAYERSCAPE dependency from its Kconfig.

This patchset is marked as v2 because it includes the final patch
from this set: https://lkml.org/lkml/2018/2/26/626, preceeded by
a patch fixing a sparse warning when building on x86_64.

Ioana Radulescu (2):
  staging: fsl-dpaa2/eth: Use __leXX types where needed
  staging: fsl-dpaa2/eth: allow the driver to compile multi-arch

 drivers/staging/fsl-dpaa2/Kconfig             | 2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
