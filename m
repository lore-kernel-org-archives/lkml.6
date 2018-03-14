Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521043013-2-6267073396694075767
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES daensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521043012; b=jDjbtAuxA1lqX4UOGmEzbMGjEiVVfwccn8Z8JQe0y+Om94L
    ctOoKmkwv9lHq4tbqXRdmWJWrVdP10HCQiAXdADfB4tX0PS5ajhhe6DK4RjmSLCR
    Kf1CcldPQoKDC8QQDQecpIsMXqAfYSpnU2BMZDjvgzCbdJISGUf3xsZ8zgiDnHcZ
    cRNK2M1lKJYIbwlt9P+0U7MRHewaYm7qFlJUvXcqHEPeQ8aBF3ibmbRvCrkmtEFh
    wW7dkO63OENVuo8dH3wG/gcM0QDxeKq1opIr2lAVodapqCgMGh5glhtNOHHtO0WP
    6hSnDa+1XFmziPTFp9KlgoqCjDU9PwJfMEzH4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521043012; bh=Z
    pNZih45VrlVaWjU+NRjzPAuoTrTHPL/upRNbjL2mqI=; b=CEFDoPOM12TFvRzmG
    g5DuBmvCLsfkiiJDRXxb/nnrrHXF9hhzmo6hjBS5birNKxjlBcX4lViYZL8pcF0u
    I1YjiS6QzJ24o5EMXWTXREOvu9Xks1zFywoe+hXF8l9anxBAzwrjNMO23kjGZ1mS
    YcVsW/B2lRe7G4WXpndzHN4zUAEOQEnfqfxwMaYbjFwikCdOS4+f3qcMR/s3KAQu
    B0HOS4qgvVdoX0sS3ZqJDy1CyGbWEc0BOqnO+UYjPlpocRkthI68UU1V2w9rQtwE
    54pQAwEFWx9QT9OWNj0G+2JJImGd8C4iNfwrk+GGNLvZn+s+tH5h+2tjF5kGmLjY
    /VxWQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qiuUywp+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qiuUywp+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v6 4/6] staging: fsl-dpaa2/ethsw: Add maintainer for Ethernet
 Switch driver
Date: Wed, 14 Mar 2018 10:55:56 -0500
Message-Id: <20180314155558.6898-5-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
References: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:300:c0::21) To DB3PR04MB0747.eurprd04.prod.outlook.com
 (2a01:111:e400:9440::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3fa71e8-5b9e-4189-27be-08d589c426c7
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:hfGgrJ2K6+CkIhSotYZMMoAynS8oYypg8fE8ODpLXEEqarseLwyRt/pkaSVW1/RZzfPO6qtVT+DGKIJvfr/j+TeYFPGXpIzgMFHkxbf2HhxBvNtBZzz/mvzVf6pM5ZN0sK1puNmUd8E9Td1HDbLWTRiISWP4FeXxFMp66vE9REzsXP05KbS4LsZLm+iK8ftVYry44hYl+y5E0xVZV9tpfFo7rng6ghMEeBzVqPOIHs91LdGA6KPQZBFxQSRhCem4;
 25:7RwDAnnkK+HnbrsoJw73srNePX58qS6ETbfz9cs+1PeoOtm/EXiDladZpPUOB105YSVqOjDHc2W7h9up32cLBi6O1gb/O3ylCoUNcQDUmQFMxDLRMWH9lJuojq9gGeRKnrNtn35E/nqwxC3E/JtCKFwHtnd4bbPYpXIFIydGGRH4KV9r4yq6i2seC6+LOI36tiGmVXwdWE1OrkrRNtAOAM+GJxS/oulBDEKisTs332RueqiqSxKPXZag/o1qKOq8bPlBOzQ0nVoNC20JpU26D6VuWpyaOmcpZULGaCj0ZWsCawj6e1y7Qo5kBmBRZzvKGb+3OwEkMub/qAjCXBbyVA==;
 31:TO377ggOAiPz6zSG0C2rXbGGcBDFoU4NsU2fK/VIq4v6uZ+n1bsusjYQGO0EONikT0qHQkrU04I0xXuQywY6aOAiPowmGSPLrZk/0BAQLOk/xnayOdkr4W9Fz/yC862DPsdqsubB1B0dffsw4FGDSO7KkGBjxQrZRGwK1/g1jpFfAL3n2rNKyPFJ3FK5ETEINVkyPH52iHxOc6tL/DOZGoE0XxmkTrOgtgoqOvyiDlg=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:c+o9lXHWES9GDZURKVdgUGPYhtDyAEBWkh4fYXusILO/4shr/ZGdewtAFG9Uk8LMZFnkhVq1ZgGvh2nEflrYPFONryKmUoazyz4QaexlTmAcGaaWQvyW+6B5ypafRJmnGB3Z/TgUEuVH/dYFx9KMSMK0LKu5jtFA7/xyuDBgi9bIYGxfzfGVEcG49+kHdjgF7iUem9j5616cXvvNz+EQBmEPfneYg2H0iy9jF3lw+iLHkMMIqN92ITdvFzOB6vv+W7E1KWN+aRstWlk4i2lQGcg7KbYENbTcc5hXinYJK0vExVeNt9nEdqPJgw/UcEpJxw9JAxZNs5yE7gZRUYvqFJBfVyA9oFOClVNY8TwY5Ffb7DbAKXmonbftiQMvc6/8kWskeDRshzBHq0NHD1UxGzn4LT3IH68kex2AzrLgLizj0ab58N5vgD51NaoIX6erLCD1wh4d9GTz/ZyPFn/KsUBQW1SXc7CBog4CnMJkIILl+FPCYl0loKbMBcXxwSYv;
 4:TfP8nm/RKAqcFnZdXwBOPgqJHGkUlS51cTLLLZQjix1/doqQoSXph5dpoXeE4VgzUv+VohptOY7/1eoLM+bgP9WWimfwVDlNmTvKpB8Ks1zzWOH/nTSz02brXmkXUujos0s6lEp+vohofnQlaz+erEO/cLlqY4q2P7hlkUjb186KooQPskdJ/RFZYP/HkN5358IelYCTU2dT7IIEES3l//M6dUdeg78oauBzE29DRsHaap3Iu7NPbzoJWp8cMac9ER4DrAetHraUrhomWMRQMCJa0Yy3qXOpTj2DnNb5+D1F/cB0l2wKf4dkL83FUZh2j1PbprlLksOfD3denbukrNe/1OAVnX+n8E+x84ls3OE=
X-Microsoft-Antispam-PRVS: <DB3PR04MB0747989F4CA0DF9FC2D499B1E6D10@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(54534003)(199004)(189003)(6116002)(3846002)(16526019)(386003)(6916009)(186003)(76176011)(48376002)(1076002)(50466002)(478600001)(47776003)(6666003)(5660300001)(2906002)(26005)(305945005)(81156014)(66066001)(7736002)(8676002)(6506007)(81166006)(2950100002)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(6512007)(36756003)(68736007)(6486002)(106356001)(53936002)(51416003)(105586002)(97736004)(2361001)(4326008)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:Xet3w7Vtx85kJAxz2oOPzKwC9TWt+Cj/N0rS4ZuL5?=
 =?us-ascii?Q?SOBD1WrFtYwe0b6/T4osIyC5f7CuUj97pF3UHaWq0O75lcMdmkbGcHqRXpXb?=
 =?us-ascii?Q?V4+UuHnoWbu2fOPD+iJA4dOqX5mIMweQMzXTffd+UR5oyHP6GGE1X5PAaEus?=
 =?us-ascii?Q?+IVF34vHlnWNFMZkrLpxCLN+WPa/YYRg6UULw1hFvjKb72mZ61XAocv42tmF?=
 =?us-ascii?Q?k6cP9u/ZWKSEiXVLhYGKOvqfXySY0UyKyXvLmISyoCxjDh7V9HTdngSoA3nv?=
 =?us-ascii?Q?nCBdTDEAkpMkAPNTqb80UE9/IkZw8/63+UaksKCNic1lk3QStjMlsQcez3Yx?=
 =?us-ascii?Q?LEEmFgQvrq2rR/5Zb/RNJ/ljd9coukOjUPaw/Nwm9t0YdO0mG1v4X4NNlV8b?=
 =?us-ascii?Q?TaYWBwU668C3OxBkI8KQk3+wg3i+d+1g1qKGApiRJ5VwguFWnHRqpEtcBpG0?=
 =?us-ascii?Q?qZZ5aumsal2O7hIFAzz03q60KCNgCjqFM0TUP+Sl6wQdpWPcyACLSMAHs+2J?=
 =?us-ascii?Q?Dv+a82BRW2uL7nFaoQW3RR9hLEggGaDxEk/tV4qOuXDf1HC4zfmeNb32jeCP?=
 =?us-ascii?Q?M1+KmY9xA4jfaHxXSHNDWS00GG11NtyNFAhO7bq67yjFCnoO1WHjAG7msuE+?=
 =?us-ascii?Q?22UwrGZC0GqdYSlOqgOp6b6tDgvM0Hy5r9hckn7Jpq+91O7AGYoPlWlyb9Tz?=
 =?us-ascii?Q?r93NxYBUpHE6c7SgTr6WTy7NI/p1A1p9cWT/WzHZgDAtYWTXbP2TNMa3DshS?=
 =?us-ascii?Q?UZXCRxtr/1HjePfUE4sDnaXrcD9lEYAc1hSPwv4vmGi+6+ExWYxmmxNNcoOf?=
 =?us-ascii?Q?QkNcokS6ag033TfMrQnNeaFI55YqzITu1f2YyW/MLvkznInsYJpgjv+rCLZ9?=
 =?us-ascii?Q?tYeCST1350KH+hWhqKC0anP681rZyHHYncwN7lsEUG6LkgbtJWkAztjeVgvO?=
 =?us-ascii?Q?h9qqgONH6py2pg39vyLZqrpv3HSq2DJAN+JpA9L4xKpt7i2fg4DX10DLs+Fw?=
 =?us-ascii?Q?XaSl7Z31gVaPLHTAmYn/95ZeVHIvXGcEPktaM5uoo6SVwtjZyjHIivf2v7Gz?=
 =?us-ascii?Q?+QkGRnCKvsZGGRaLCmkBLEA3JmtX9dm1lUL9ZRyzBk85K979ccNkyxDs89QY?=
 =?us-ascii?Q?xHQJIet3gbClsmHHVzlDK6NA39Y32LyJhokZ3acuitSf9R9K9ZE8NPBjQWbz?=
 =?us-ascii?Q?BAM4rZbFca7u3Z9olrNoBaJWS6XRQJUnGOy?=
X-Microsoft-Antispam-Message-Info: GiGS3641dB/jb2vkqd0gxe3FfaQjSx0wTdOJJF4wSAYqt6Y2tOCOg7rRIWAQ7Qflh3Xk+uLi0SsawROu82l8wiuFIH1l1W7ZfuJDb2Puoi39jGi0Sn6vunSJdg9Glk5eLVMsJ3Pw1eFkXQsMr5JU9rbNJi44/nMMjV5e/L2j3p8KFASDTorv0Z0kmvJN5Ab3
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:O2ax65zzvkDZFxi4qFCHZj2KkpHms/IAvN1xQUV7pVVsJsWz/hPgIe+yJ7p8vvuYn6rYopMhR2NlD3E9uRqqtgQB+ep14K8xQB7snJ0Cdwo9C7uDBId72RtB7iy3FPb4/bz0GyzW17mv46xpEoqRtAwxUY7EetlvRIrxD5QlXA1gy9ECTsZwNAML0rs2p2/GhDUuwHgNDohgGPJs5wCeoSo68BpMyxyMo/VQdIlz6ltwqLzqjPHdfqzxlRaYwP6n6fi6neOskQAk8NLHGUe/RzAFjXjxEYM55RZGtNTlbTkNh6guaVpEugIj5i/9dEqGfOsx+WTmDdmLgTL9HM+RLC7ez+eUMGL79I5asgrG7NQ=;
 5:x36UeAxKB4QtAF7FzOkkToc2vo9O+vk9Qx/ayAyzqax0trqx9WAs3/EtOnwkkJcXLYC1C4nYhuaOLLBvQ7WEkMZesK5JKo5hPh6Z53eAfQVCWKMrOce1i5SaZ75RFe0bUaxQAv3q0hZ+mzc7wRcWlaIBRiTUXJ1tzo/hsUAONgU=;
 24:XCpmEWqLQYCe3lN5ivf1p6Sxb/yh5MDNA8lqtk3l9vuBPOH4epTZh8hoahPXS2RM7UBfqZf5cUt3hzPEUkhahx2Dv1v4fjHuLZZdtZgIlUA=;
 7:eX7VsYXohP1JAO8gaPHp8xfhAig6tRFqAvWVHGU+mLm0YPGfTdeDK6vo7uthrA8NPrcyVA0jAEt/ytLMDIZ8bu1ZC718rNnms2ee4qZXnrdRENp936+rbW9+gGolmsx3um9HygOA5S+VBoYtx0NV6lCG6nt5HTEpqzruQoxAyVqmk7Yt/46bGfeLf9RtZEiT/OqQPZyTOyyA0suOkjEiOw8d4TUOPLbHq9H8HudXGDa+FrE+fAZ62EFRz0HWw4gr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 15:56:26.9505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fa71e8-5b9e-4189-27be-08d589c426c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR04MB0747
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
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, netdev@vger.kernel.org,
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org, agraf@suse.de,
 stuyoder@gmail.com, ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - no changes
 v3:
    - no changes
 v4:
    - no changes
 v5:
    - no changes
 v6:
    - no changes

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3c2b75..20d7bf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4410,6 +4410,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethernet
 
+DPAA2 ETHERNET SWITCH DRIVER
+M:	Razvan Stefanescu <razvan.stefanescu@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/fsl-dpaa2/ethsw
+
 DPT_I2O SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@adaptec.com>
 L:	linux-scsi@vger.kernel.org
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
