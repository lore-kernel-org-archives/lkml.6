Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E646C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759A6208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TktcO6uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759A6208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbeJAVsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:48:00 -0400
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:12358
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728979AbeJAVsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0C/qg2g3lusuEo+HLbJoswS/emn33bwrC3SPquoWos=;
 b=TktcO6uhY/YU9YkQDQV/U9C+R7KjQS5CWnm1Jkeur+oWHft358q3yFAK2DPN5r+Y2OigbKtg2+zxaVzeLOwktOj0CvTrK4HkxLzBnS53F45EGI6CDgEVp4uU0bGbwD/19m2qKDzhC8d4xbRZ/x3vpHeRfdNJ89R2FzLj0+HY+wE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.106.55) by
 VI1PR0801MB1389.eurprd08.prod.outlook.com (2603:10a6:800:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Mon, 1 Oct
 2018 15:09:30 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     daniel@ffwll.ch, ayan.halder@arm.com, liviu.dudau@arm.com,
        brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        emil.l.velikov@gmail.com
Cc:     nd@arm.com
Subject: [PATCH libdrm v4] libdrm: headers: Sync with drm-next
Date:   Mon,  1 Oct 2018 16:09:18 +0100
Message-Id: <1538406558-6433-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.106.55]
X-ClientProxiedBy: AM6PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:209:15::44) To VI1PR0801MB1389.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afdd57c3-e088-419e-82da-08d627afe36f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1389;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1389;3:G1nHfa4OvOMtMUDniOf47kchtOcw5uQN6YZhyOt1CADz2nppoVqBf+BW2eAOJALkkH7pb+fTErxG/aGUwwaOWe7deEvTzj47D23c43V846N8mhMD1v3Psrsg9KxXLOpAaTjKo7o//U+eaShaMz2ZE9TJfQILVhFrWmEqNC9cmARPgl38UR1WICmu4O7FtU0+hLAOGtscPFnUq9ucrEmGbZbHW0J/N6F37XrbFRuEN+V6Tm2KdrSYziYWXtpslLTn;25:6gx6mUXlnO9yLCPm5OrN5iK+ycFBy1zkVGM/2KuWuxrioub3/4V1b2/kbNo7GdMiOObtYCRObiNRCsk0WU8p7pby/JnbktA4LW/MnPRkbQ7kVRvcEg5qcq/nQbzAJdyLHk3NFjhnlnmSvJO7HyNXp+Vl7VsCNBK2LE6tDuEkabYiEbEdJLroex5veFqo6I/TFXHtel8jqB1J5fVw5GZcgl9gpYBcwYax1XEId/9mEK9vMLjfzHp5ZC8NwUlg9lRTAPlVunsd3Eao8s2yZ+oV9HdWvGRhCioB3568TChJ2c8F21m2guPN6vpz2tUqEyh/4j7Sak8Cm+JqQEmyHIVaAA==;31:/BzJJIK7hvjk9cNW7iADGJrPDh36sDaEtC7y0P60EkMLjqk9oa3SSxaK65Wjckn7IJWhhtWCI7/Z670a9vDE3yZRenDUso5Zog1t80p5GP1cWKUJPQbnOHyI8OkOkkt/ApY69WkTaXPhhVas6Oxx26XKp+mqDLTET7mglZihhvmhXJ+nBRfQt4trRWfNr5YXsGaSLuQaf1yVrWdhI0IxY/KENJkUftDQs9vO5AEoIeo=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1389:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1389;20:/7wgSPkkqq0TBdFBbMjWurYvS6E688Gd15QKGrPEdhRQnLb58kLv5s3jtS89HCdX7+RSPyIgpAnwCvJKumJJQpFf+1Qg3y2VXzZJS98sTbKTmkM7/b/w2GsGJjueKm6svmUQSyT4Uu7fBCce5YImjLoNRtlC9eQxiJlxAuO+QHYAwnAeihCjGsWv8+VM3fGfWr/e09JZMdTlpwtiZRIBsdL0yU37X8n7LxTE4Qsuc0lKFjoAyJJ5kTSuk7AXrpVSTsEbhDzrvu+mlDJrZ1fFdS8Nsbj02Hqr/jtiDizqkexIiuM/DpT3cUfcRqlq54z8abIL9UXDo0qd6T6bKtwZNCHjPvGI/UtpV805kRIVuLlp0dPfasUzJ3HeCSE9BQ7JyE6yCfbpxea1hVl1D+Kshd2nTMQWzQAN5bMgAm/sRxs=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1389165E01571CAE543A666EE4EF0@VI1PR0801MB1389.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040)(85827821059158)(180628864354917)(17755550239193)(211171220733660)(20558992708506)(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR0801MB1389;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1389;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1389;4:3pIR/0yB577RfDiLZoIwhkibP1dR5jhtoUyDeNptYll9d/1JSZRu2Zxb2gCLWbJFXnCJ/8KDadYyoSUBXsqlB6zZ/qoKx6t1x3cukAoaVMYb1NHPLGt7OTWNYtAbDILSLwpGSGuqf5ZwvLfg8qQKlooelYB/2SHti6xBxtZvYkgvWZRyy7QCMWN882NuOWPblNiGj20T9INDv5QVl6i/pJrW+T8WwLwAQxEoWhehAH4qvJoxct4S5gQvFK/I/bwX2ugbIx8IHTr6qg5i/J+r0NEObYzaWwwC0jQ8WZcsqEC4EXrH0fj1MexNfVfk/yTLq0K2lJh849OKYtPFtiEznnkXDj2HKGWEmjAUw25I/iZ3MHKawM13EUC+Fo4YFZhsluys/P4jBXn+W/FUmRxNDbcFHQBVwu0E0fgeyh44Zhnnm78vZJNvBAm6nJx/eW2NgtF5bHzY6QE/e95yeo15+5z8AtW1NAwpromzrM4WDjescKyuk/I//9cdVO6noSYS27dmCd9SvMvfAk+83EnJHQ==
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(396003)(136003)(189003)(199004)(1600100001)(386003)(72206003)(575784001)(25786009)(86362001)(4326008)(51416003)(476003)(7696005)(52116002)(50226002)(8936002)(97736004)(106356001)(81166006)(8676002)(81156014)(105586002)(50466002)(316002)(16586007)(47776003)(956004)(2616005)(66066001)(486006)(14444005)(5024004)(48376002)(26005)(186003)(16526019)(2906002)(7736002)(39060400002)(36756003)(3846002)(6116002)(6486002)(305945005)(478600001)(5660300001)(6666003)(68736007)(53946003)(53936002)(34290500001)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1389;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1389;23:2nxO9z3JgjF/+blD5wB3r46v+mptRzFbVVrgkrz?=
 =?us-ascii?Q?HZy79x66PrqXyBtPtpdGEBl8vv0q4/EfI0XB7KAXXvqtaaspkTwQJHxmRWRg?=
 =?us-ascii?Q?o9XQQqi66R9LM2rSjJA3MBGD6cNogP+JmOCqZkRjpeLQFo2EYVg0uVC9O4KE?=
 =?us-ascii?Q?QrLsxNTghRUMmVdIQZL+61Q2z84kcfXdSjd3ZXz3DlgcvyVwa374O+GQ++yd?=
 =?us-ascii?Q?zQgsqy2x6ITpHgMzTR5JCLjOqSrmDWvxCfRrN3CwzcDQZogDOpIjsJeY4R74?=
 =?us-ascii?Q?34iz2QdOIrWrsalqX+sJaYoiKahze5ShxXVU+Hw3kOpZBd/6fhww/IIwGliE?=
 =?us-ascii?Q?5RrOnGNSafhR1dTb2oGEjLRtZ4vpT1e7EDYRYDf2TS/EpBTBAQvrSRN6wmt6?=
 =?us-ascii?Q?o2pgwG+O2L7vsz1UVafdOzM/AdkAeEw4PqW2uU+hq4hdSmJvmWzuhgwyUDiE?=
 =?us-ascii?Q?rzNXT9AZx73lMcw7DR965SrAm/FbZQnXosLmuduDLtphtrQevNkB8ifM1vKM?=
 =?us-ascii?Q?ZwvwT+ZoQ7wyNHdtKhK6Ci/QhzKntsuzmp18ukH6WDAqhRhOe+mHR/yp/DwZ?=
 =?us-ascii?Q?sXX9Qr0lKPEOEw/HbNe2g0PZ5gKGo4JmmyHRVq2frL6Eug2399OgCRLowQA/?=
 =?us-ascii?Q?7G04cnA2bFoxoIQGZOisN9Hu8y57WNZpCLl9uqvxLOI8lDAkMHQE0xGW0ZA6?=
 =?us-ascii?Q?jpjOq4lPpbjtdX4KA7iZH7Nnau85BSc/k4i74V77rkZnCH0Mr+Z8i0jgiP12?=
 =?us-ascii?Q?1UEfJ9dT7rvjTfKqLZRudsQOb596OVhy7LugvAWaeoGzA9kP0krSIy5b32jj?=
 =?us-ascii?Q?+4EROMV1nyUunQFYbwoQthDQe3m51NNBmEyFVaJUbKPnq50FqNJsqYzNB0S1?=
 =?us-ascii?Q?Ikq7wMG9tmpm01uJXRtTXCFGndEmiVrOUkmeZ4Yj9O6tWQc+58ZcuY99ZLoe?=
 =?us-ascii?Q?YJrRyjtCy2Mdb0+kCXhuLXoVOdoaBhd+4L7Vxd63FgG/IOWEgr2HChgba8St?=
 =?us-ascii?Q?uSgj+Vkg/bUkjdL+GgzMNZOSvpkQ//BZ9fam81yjtdMI29IMMB/FeHI40bTV?=
 =?us-ascii?Q?r562s1GyfAQDH861U5kL9e8yhuJguhnRQTZ5ITR1YyYpVmzxQ5do0eVTJuVI?=
 =?us-ascii?Q?+fA8RM8PLR4hNXZ99eHzyBXkyXHPXVyJdtSo/IdsEmArelz2eJaue5C1FFYY?=
 =?us-ascii?Q?YG+uIM/yMhGtjLDnRcvnd6rtGffigK+N043R3KkBMonA/JnZgCsWlzhWF0oz?=
 =?us-ascii?Q?IoI+oRh6Ft+W/dkH2E1HPmW7DY2RczZFvKJDGPrj2?=
X-Microsoft-Antispam-Message-Info: M5wHTv610jj+FtBm6La2q0FPqSCmuHov/n7avfzmdB+DzO6FVZoRatbnfJh4jcu2zhBSKXk2T0RNu2+VHETW7JZM9AQJDGMajy8l9HZItt/0MAaHJe8rClZ4zTeiR1s/IxzL3TBvnxt1NkKKa1jx7eYKQ1t0aDFJTcE79LMz+Ww4Z4tOLWgwfNKj26qHn1M8E6Fj0bwPWLYeB6eLnCFMQjkFxZ6vvXPb9ucH/7UHD3GJWviSyrobLSHguEnoL8V1+zROux/uAadpMWOxA/iCpC5j5PPWdGdYZ6sccM3LPJ7EdJeQP9Z2MmYqVyG9JXWfwWSoa4cMAYFN6285NSpaPg==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1389;6:TlGNmAfUIP/bw8GeNizUCB64QQGyDdupKSlNAMTDp7VJuCPB343KELsPYJBumXRGQoXPNlRkQWyzIzURRFhGH3nsWjz1A0xyOqs16Rbl1VS3eH/0roTiwxZnWkajBj0zlvPHYD/Odo4Zfr7eQUDN0eaYpe5FYdev0+TmthXQpGyrtAhUrXyqCxHckSFUcyk9ENO3uvCY7aWdqeMp+0BuHo++jtuUDAo8JHIEHv0fppify3cVwDuEz37i1zDzhChf7gwjqImufAeXDP6NHoDJUBAnxDZDIoQnMzvGmwIoctFtxcw4T3j3j8yvAakUSq9QPw7nXJOUTt91KuOBaQXDq65oVjQ8j4wdG3k5n0gnWfgEUAtcWvho9K6jc6V1Pq+C6OLJkKIl4PewHiYrYyG7lKxAGwMynzLFWv9eZJY0A2a8eRe5CIXLJs+pFDlQNIsV8eQSaHzKwfcS+xrabbryIQ==;5:J1p02msta/oUyXGYhUIV6/X0e8fX5M0zdxY0TqKonWRrNmbhJSSoIkOQdVH+aeoqUA7Stte8b+R0rLrcOYVdM2fV/3iVsHtaPtgBzJn3WG85P/B6h7neadk1y2n+IUPTf5gR1Jf0fYDKxYBn4Bo9ysciZNSjv+eAIrtXS3xvc1I=;7:hcLyffRKJ50Cy4YmI4e/ssz5uoPmk9pC6miPUc876ybLtubCuP66U1XW0kHPXMJpJdsgO/18qh3gKxQQEJCr73RP6nNbUdl3CxxsWWAkJ/YPGdKuwyejDoSN4zi/A5tvpwjVPpwKjif4k44802M2roX3irHtgSF1zXZtKaVYTScP1pBJb8TmsjuuVw+AobIXZT6cLcrqHnufHdHPO+UfLApVd/NLYDYtJ4QC3M63EV39qbaiD9hJwv7h+BZ5xyz1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 15:09:30.4406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afdd57c3-e088-419e-82da-08d627afe36f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generated using make headers_install from the drm-next
tree - git://anongit.freedesktop.org/drm/drm
branch - drm-next
commit - 2dc7bad71cd310dc94d1c9907909324dd2b0618f

The changes were as follows :-

  core: (drm.h, drm_fourcc.h, drm_mode.h)
    - Added client capabilities for ASPECT_RATIO and WRITEBACK_CONNECTORS
    - Added Arm AFBC modifiers
    - Added BROADCOM's SAND and UIF modifiers
    - Added Qualcomm's modifiers
    - Added some picture aspect ratio and content type options
    - Added some drm mode flags
    - Added writeback connector id

  amdgpu:
    - Added GEM domain mask
    - Added some GEM flags
    - Added some hardware ip flags
    - Added chunk id and IB fence.
    - Added some query ids

  i915:
    -Added an IOCTL (I915_PARAM_MMAP_GTT_COHERENT)

  qxl:
    - Minor changes

  tegra:
    - Added some comments about struct drm_tegra* members
    - Modified DRM_IOCTL_TEGRA_CLOSE_CHANNEL

  vc4:
    - Added some members for 'struct drm_vc4_submit_cl'

Changes in v2:
    - Mentioned 'libdrm' in the commit header.

Changes in v3:
    - Removed the changes to radeon_drm.h, sis_drm.h and via_drm.h as suggested by
      Emil Velikov <emil.l.velikov@gmail.com>

Changes in v4:
    - Removed the changes to vmwgfx_drm.h as it caused a build break ie
      'make check' failed.

Change-Id: I018a06f65bf4a6a68400ab252b9cd05d041299b3
Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 include/drm/amdgpu_drm.h |  47 ++++-
 include/drm/drm.h        |  16 ++
 include/drm/drm_fourcc.h | 215 +++++++++++++++++++++
 include/drm/drm_mode.h   |  35 +++-
 include/drm/i915_drm.h   |  22 +++
 include/drm/qxl_drm.h    |   2 -
 include/drm/tegra_drm.h  | 492 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/drm/vc4_drm.h    |  13 +-
 8 files changed, 825 insertions(+), 17 deletions(-)

diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
index c363b67..1ceec56 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -72,12 +72,41 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
 #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
 
+/**
+ * DOC: memory domains
+ *
+ * %AMDGPU_GEM_DOMAIN_CPU	System memory that is not GPU accessible.
+ * Memory in this pool could be swapped out to disk if there is pressure.
+ *
+ * %AMDGPU_GEM_DOMAIN_GTT	GPU accessible system memory, mapped into the
+ * GPU's virtual address space via gart. Gart memory linearizes non-contiguous
+ * pages of system memory, allows GPU access system memory in a linezrized
+ * fashion.
+ *
+ * %AMDGPU_GEM_DOMAIN_VRAM	Local video memory. For APUs, it is memory
+ * carved out by the BIOS.
+ *
+ * %AMDGPU_GEM_DOMAIN_GDS	Global on-chip data storage used to share data
+ * across shader threads.
+ *
+ * %AMDGPU_GEM_DOMAIN_GWS	Global wave sync, used to synchronize the
+ * execution of all the waves on a device.
+ *
+ * %AMDGPU_GEM_DOMAIN_OA	Ordered append, used by 3D or Compute engines
+ * for appending data.
+ */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
 #define AMDGPU_GEM_DOMAIN_VRAM		0x4
 #define AMDGPU_GEM_DOMAIN_GDS		0x8
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
+#define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
+					 AMDGPU_GEM_DOMAIN_GTT | \
+					 AMDGPU_GEM_DOMAIN_VRAM | \
+					 AMDGPU_GEM_DOMAIN_GDS | \
+					 AMDGPU_GEM_DOMAIN_GWS | \
+					 AMDGPU_GEM_DOMAIN_OA)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
@@ -95,6 +124,10 @@ extern "C" {
 #define AMDGPU_GEM_CREATE_VM_ALWAYS_VALID	(1 << 6)
 /* Flag that BO sharing will be explicitly synchronized */
 #define AMDGPU_GEM_CREATE_EXPLICIT_SYNC		(1 << 7)
+/* Flag that indicates allocating MQD gart on GFX9, where the mtype
+ * for the second page onward should be set to NC.
+ */
+#define AMDGPU_GEM_CREATE_MQD_GFX9		(1 << 8)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
@@ -473,7 +506,8 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_UVD_ENC      5
 #define AMDGPU_HW_IP_VCN_DEC      6
 #define AMDGPU_HW_IP_VCN_ENC      7
-#define AMDGPU_HW_IP_NUM          8
+#define AMDGPU_HW_IP_VCN_JPEG     8
+#define AMDGPU_HW_IP_NUM          9
 
 #define AMDGPU_HW_IP_INSTANCE_MAX_COUNT 1
 
@@ -482,6 +516,7 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_CHUNK_ID_DEPENDENCIES	0x03
 #define AMDGPU_CHUNK_ID_SYNCOBJ_IN      0x04
 #define AMDGPU_CHUNK_ID_SYNCOBJ_OUT     0x05
+#define AMDGPU_CHUNK_ID_BO_HANDLES      0x06
 
 struct drm_amdgpu_cs_chunk {
 	__u32		chunk_id;
@@ -520,6 +555,10 @@ union drm_amdgpu_cs {
 /* Preempt flag, IB should set Pre_enb bit if PREEMPT flag detected */
 #define AMDGPU_IB_FLAG_PREEMPT (1<<2)
 
+/* The IB fence should do the L2 writeback but not invalidate any shader
+ * caches (L2/vL1/sL1/I$). */
+#define AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE (1 << 3)
+
 struct drm_amdgpu_cs_chunk_ib {
 	__u32 _pad;
 	/** AMDGPU_IB_FLAG_* */
@@ -620,6 +659,12 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_FW_ASD		0x0d
 	/* Subquery id: Query VCN firmware version */
 	#define AMDGPU_INFO_FW_VCN		0x0e
+	/* Subquery id: Query GFX RLC SRLC firmware version */
+	#define AMDGPU_INFO_FW_GFX_RLC_RESTORE_LIST_CNTL 0x0f
+	/* Subquery id: Query GFX RLC SRLG firmware version */
+	#define AMDGPU_INFO_FW_GFX_RLC_RESTORE_LIST_GPM_MEM 0x10
+	/* Subquery id: Query GFX RLC SRLS firmware version */
+	#define AMDGPU_INFO_FW_GFX_RLC_RESTORE_LIST_SRM_MEM 0x11
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
 /* the used VRAM size */
diff --git a/include/drm/drm.h b/include/drm/drm.h
index f0bd91d..85c685a 100644
--- a/include/drm/drm.h
+++ b/include/drm/drm.h
@@ -674,6 +674,22 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_ATOMIC	3
 
+/**
+ * DRM_CLIENT_CAP_ASPECT_RATIO
+ *
+ * If set to 1, the DRM core will provide aspect ratio information in modes.
+ */
+#define DRM_CLIENT_CAP_ASPECT_RATIO    4
+
+/**
+ * DRM_CLIENT_CAP_WRITEBACK_CONNECTORS
+ *
+ * If set to 1, the DRM core will expose special connectors to be used for
+ * writing back to memory the scene setup in the commit. Depends on client
+ * also supporting DRM_CLIENT_CAP_ATOMIC
+ */
+#define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	5
+
 /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index e04613d..139632b 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -30,11 +30,50 @@
 extern "C" {
 #endif
 
+/**
+ * DOC: overview
+ *
+ * In the DRM subsystem, framebuffer pixel formats are described using the
+ * fourcc codes defined in `include/uapi/drm/drm_fourcc.h`. In addition to the
+ * fourcc code, a Format Modifier may optionally be provided, in order to
+ * further describe the buffer's format - for example tiling or compression.
+ *
+ * Format Modifiers
+ * ----------------
+ *
+ * Format modifiers are used in conjunction with a fourcc code, forming a
+ * unique fourcc:modifier pair. This format:modifier pair must fully define the
+ * format and data layout of the buffer, and should be the only way to describe
+ * that particular buffer.
+ *
+ * Having multiple fourcc:modifier pairs which describe the same layout should
+ * be avoided, as such aliases run the risk of different drivers exposing
+ * different names for the same data format, forcing userspace to understand
+ * that they are aliases.
+ *
+ * Format modifiers may change any property of the buffer, including the number
+ * of planes and/or the required allocation size. Format modifiers are
+ * vendor-namespaced, and as such the relationship between a fourcc code and a
+ * modifier is specific to the modifer being used. For example, some modifiers
+ * may preserve meaning - such as number of planes - from the fourcc code,
+ * whereas others may not.
+ *
+ * Vendors should document their modifier usage in as much detail as
+ * possible, to ensure maximum compatibility across devices, drivers and
+ * applications.
+ *
+ * The authoritative list of format modifier codes is found in
+ * `include/uapi/drm/drm_fourcc.h`
+ */
+
 #define fourcc_code(a, b, c, d) ((__u32)(a) | ((__u32)(b) << 8) | \
 				 ((__u32)(c) << 16) | ((__u32)(d) << 24))
 
 #define DRM_FORMAT_BIG_ENDIAN (1<<31) /* format is big endian instead of little endian */
 
+/* Reserve 0 for the invalid format specifier */
+#define DRM_FORMAT_INVALID	0
+
 /* color index */
 #define DRM_FORMAT_C8		fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
 
@@ -183,6 +222,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_QCOM    0x05
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
+#define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 /* add more to the end as needed */
 
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -298,6 +338,19 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_SAMSUNG_64_32_TILE	fourcc_mod_code(SAMSUNG, 1)
 
+/*
+ * Qualcomm Compressed Format
+ *
+ * Refers to a compressed variant of the base format that is compressed.
+ * Implementation may be platform and base-format specific.
+ *
+ * Each macrotile consists of m x n (mostly 4 x 4) tiles.
+ * Pixel data pitch/stride is aligned with macrotile width.
+ * Pixel data height is aligned with macrotile height.
+ * Entire pixel data buffer is aligned with 4k(bytes).
+ */
+#define DRM_FORMAT_MOD_QCOM_COMPRESSED	fourcc_mod_code(QCOM, 1)
+
 /* Vivante framebuffer modifiers */
 
 /*
@@ -385,6 +438,23 @@ extern "C" {
 	fourcc_mod_code(NVIDIA, 0x15)
 
 /*
+ * Some Broadcom modifiers take parameters, for example the number of
+ * vertical lines in the image. Reserve the lower 32 bits for modifier
+ * type, and the next 24 bits for parameters. Top 8 bits are the
+ * vendor code.
+ */
+#define __fourcc_mod_broadcom_param_shift 8
+#define __fourcc_mod_broadcom_param_bits 48
+#define fourcc_mod_broadcom_code(val, params) \
+	fourcc_mod_code(BROADCOM, ((((__u64)params) << __fourcc_mod_broadcom_param_shift) | val))
+#define fourcc_mod_broadcom_param(m) \
+	((int)(((m) >> __fourcc_mod_broadcom_param_shift) &	\
+	       ((1ULL << __fourcc_mod_broadcom_param_bits) - 1)))
+#define fourcc_mod_broadcom_mod(m) \
+	((m) & ~(((1ULL << __fourcc_mod_broadcom_param_bits) - 1) <<	\
+		 __fourcc_mod_broadcom_param_shift))
+
+/*
  * Broadcom VC4 "T" format
  *
  * This is the primary layout that the V3D GPU can texture from (it
@@ -405,6 +475,151 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_BROADCOM_VC4_T_TILED fourcc_mod_code(BROADCOM, 1)
 
+/*
+ * Broadcom SAND format
+ *
+ * This is the native format that the H.264 codec block uses.  For VC4
+ * HVS, it is only valid for H.264 (NV12/21) and RGBA modes.
+ *
+ * The image can be considered to be split into columns, and the
+ * columns are placed consecutively into memory.  The width of those
+ * columns can be either 32, 64, 128, or 256 pixels, but in practice
+ * only 128 pixel columns are used.
+ *
+ * The pitch between the start of each column is set to optimally
+ * switch between SDRAM banks. This is passed as the number of lines
+ * of column width in the modifier (we can't use the stride value due
+ * to various core checks that look at it , so you should set the
+ * stride to width*cpp).
+ *
+ * Note that the column height for this format modifier is the same
+ * for all of the planes, assuming that each column contains both Y
+ * and UV.  Some SAND-using hardware stores UV in a separate tiled
+ * image from Y to reduce the column height, which is not supported
+ * with these modifiers.
+ */
+
+#define DRM_FORMAT_MOD_BROADCOM_SAND32_COL_HEIGHT(v) \
+	fourcc_mod_broadcom_code(2, v)
+#define DRM_FORMAT_MOD_BROADCOM_SAND64_COL_HEIGHT(v) \
+	fourcc_mod_broadcom_code(3, v)
+#define DRM_FORMAT_MOD_BROADCOM_SAND128_COL_HEIGHT(v) \
+	fourcc_mod_broadcom_code(4, v)
+#define DRM_FORMAT_MOD_BROADCOM_SAND256_COL_HEIGHT(v) \
+	fourcc_mod_broadcom_code(5, v)
+
+#define DRM_FORMAT_MOD_BROADCOM_SAND32 \
+	DRM_FORMAT_MOD_BROADCOM_SAND32_COL_HEIGHT(0)
+#define DRM_FORMAT_MOD_BROADCOM_SAND64 \
+	DRM_FORMAT_MOD_BROADCOM_SAND64_COL_HEIGHT(0)
+#define DRM_FORMAT_MOD_BROADCOM_SAND128 \
+	DRM_FORMAT_MOD_BROADCOM_SAND128_COL_HEIGHT(0)
+#define DRM_FORMAT_MOD_BROADCOM_SAND256 \
+	DRM_FORMAT_MOD_BROADCOM_SAND256_COL_HEIGHT(0)
+
+/* Broadcom UIF format
+ *
+ * This is the common format for the current Broadcom multimedia
+ * blocks, including V3D 3.x and newer, newer video codecs, and
+ * displays.
+ *
+ * The image consists of utiles (64b blocks), UIF blocks (2x2 utiles),
+ * and macroblocks (4x4 UIF blocks).  Those 4x4 UIF block groups are
+ * stored in columns, with padding between the columns to ensure that
+ * moving from one column to the next doesn't hit the same SDRAM page
+ * bank.
+ *
+ * To calculate the padding, it is assumed that each hardware block
+ * and the software driving it knows the platform's SDRAM page size,
+ * number of banks, and XOR address, and that it's identical between
+ * all blocks using the format.  This tiling modifier will use XOR as
+ * necessary to reduce the padding.  If a hardware block can't do XOR,
+ * the assumption is that a no-XOR tiling modifier will be created.
+ */
+#define DRM_FORMAT_MOD_BROADCOM_UIF fourcc_mod_code(BROADCOM, 6)
+
+/*
+ * Arm Framebuffer Compression (AFBC) modifiers
+ *
+ * AFBC is a proprietary lossless image compression protocol and format.
+ * It provides fine-grained random access and minimizes the amount of data
+ * transferred between IP blocks.
+ *
+ * AFBC has several features which may be supported and/or used, which are
+ * represented using bits in the modifier. Not all combinations are valid,
+ * and different devices or use-cases may support different combinations.
+ */
+#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_mode)
+
+/*
+ * AFBC superblock size
+ *
+ * Indicates the superblock size(s) used for the AFBC buffer. The buffer
+ * size (in pixels) must be aligned to a multiple of the superblock size.
+ * Four lowest significant bits(LSBs) are reserved for block size.
+ */
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
+
+/*
+ * AFBC lossless colorspace transform
+ *
+ * Indicates that the buffer makes use of the AFBC lossless colorspace
+ * transform.
+ */
+#define AFBC_FORMAT_MOD_YTR     (1ULL <<  4)
+
+/*
+ * AFBC block-split
+ *
+ * Indicates that the payload of each superblock is split. The second
+ * half of the payload is positioned at a predefined offset from the start
+ * of the superblock payload.
+ */
+#define AFBC_FORMAT_MOD_SPLIT   (1ULL <<  5)
+
+/*
+ * AFBC sparse layout
+ *
+ * This flag indicates that the payload of each superblock must be stored at a
+ * predefined position relative to the other superblocks in the same AFBC
+ * buffer. This order is the same order used by the header buffer. In this mode
+ * each superblock is given the same amount of space as an uncompressed
+ * superblock of the particular format would require, rounding up to the next
+ * multiple of 128 bytes in size.
+ */
+#define AFBC_FORMAT_MOD_SPARSE  (1ULL <<  6)
+
+/*
+ * AFBC copy-block restrict
+ *
+ * Buffers with this flag must obey the copy-block restriction. The restriction
+ * is such that there are no copy-blocks referring across the border of 8x8
+ * blocks. For the subsampled data the 8x8 limitation is also subsampled.
+ */
+#define AFBC_FORMAT_MOD_CBR     (1ULL <<  7)
+
+/*
+ * AFBC tiled layout
+ *
+ * The tiled layout groups superblocks in 8x8 or 4x4 tiles, where all
+ * superblocks inside a tile are stored together in memory. 8x8 tiles are used
+ * for pixel formats up to and including 32 bpp while 4x4 tiles are used for
+ * larger bpp formats. The order between the tiles is scan line.
+ * When the tiled layout is used, the buffer size (in pixels) must be aligned
+ * to the tile size.
+ */
+#define AFBC_FORMAT_MOD_TILED   (1ULL <<  8)
+
+/*
+ * AFBC solid color blocks
+ *
+ * Indicates that the buffer makes use of solid-color blocks, whereby bandwidth
+ * can be reduced if a whole superblock is a single color.
+ */
+#define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/include/drm/drm_mode.h b/include/drm/drm_mode.h
index 5f9fadb..d3e0fe3 100644
--- a/include/drm/drm_mode.h
+++ b/include/drm/drm_mode.h
@@ -46,6 +46,10 @@ extern "C" {
 #define DRM_MODE_TYPE_USERDEF	(1<<5)
 #define DRM_MODE_TYPE_DRIVER	(1<<6)
 
+#define DRM_MODE_TYPE_ALL	(DRM_MODE_TYPE_PREFERRED |	\
+				 DRM_MODE_TYPE_USERDEF |	\
+				 DRM_MODE_TYPE_DRIVER)
+
 /* Video mode flags */
 /* bit compatible with the xrandr RR_ definitions (bits 0-13)
  *
@@ -89,6 +93,15 @@ extern "C" {
 #define DRM_MODE_PICTURE_ASPECT_NONE		0
 #define DRM_MODE_PICTURE_ASPECT_4_3		1
 #define DRM_MODE_PICTURE_ASPECT_16_9		2
+#define DRM_MODE_PICTURE_ASPECT_64_27		3
+#define DRM_MODE_PICTURE_ASPECT_256_135		4
+
+/* Content type options */
+#define DRM_MODE_CONTENT_TYPE_NO_DATA		0
+#define DRM_MODE_CONTENT_TYPE_GRAPHICS		1
+#define DRM_MODE_CONTENT_TYPE_PHOTO		2
+#define DRM_MODE_CONTENT_TYPE_CINEMA		3
+#define DRM_MODE_CONTENT_TYPE_GAME		4
 
 /* Aspect ratio flag bitmask (4 bits 22:19) */
 #define DRM_MODE_FLAG_PIC_AR_MASK		(0x0F<<19)
@@ -98,6 +111,24 @@ extern "C" {
 			(DRM_MODE_PICTURE_ASPECT_4_3<<19)
 #define  DRM_MODE_FLAG_PIC_AR_16_9 \
 			(DRM_MODE_PICTURE_ASPECT_16_9<<19)
+#define  DRM_MODE_FLAG_PIC_AR_64_27 \
+			(DRM_MODE_PICTURE_ASPECT_64_27<<19)
+#define  DRM_MODE_FLAG_PIC_AR_256_135 \
+			(DRM_MODE_PICTURE_ASPECT_256_135<<19)
+
+#define  DRM_MODE_FLAG_ALL	(DRM_MODE_FLAG_PHSYNC |		\
+				 DRM_MODE_FLAG_NHSYNC |		\
+				 DRM_MODE_FLAG_PVSYNC |		\
+				 DRM_MODE_FLAG_NVSYNC |		\
+				 DRM_MODE_FLAG_INTERLACE |	\
+				 DRM_MODE_FLAG_DBLSCAN |	\
+				 DRM_MODE_FLAG_CSYNC |		\
+				 DRM_MODE_FLAG_PCSYNC |		\
+				 DRM_MODE_FLAG_NCSYNC |		\
+				 DRM_MODE_FLAG_HSKEW |		\
+				 DRM_MODE_FLAG_DBLCLK |		\
+				 DRM_MODE_FLAG_CLKDIV2 |	\
+				 DRM_MODE_FLAG_3D_MASK)
 
 /* DPMS flags */
 /* bit compatible with the xorg definitions. */
@@ -155,8 +186,9 @@ extern "C" {
 /*
  * DRM_MODE_REFLECT_<axis>
  *
- * Signals that the contents of a drm plane is reflected in the <axis> axis,
+ * Signals that the contents of a drm plane is reflected along the <axis> axis,
  * in the same way as mirroring.
+ * See kerneldoc chapter "Plane Composition Properties" for more details.
  *
  * This define is provided as a convenience, looking up the property id
  * using the name->prop id lookup is the preferred method.
@@ -320,6 +352,7 @@ enum drm_mode_subconnector {
 #define DRM_MODE_CONNECTOR_VIRTUAL      15
 #define DRM_MODE_CONNECTOR_DSI		16
 #define DRM_MODE_CONNECTOR_DPI		17
+#define DRM_MODE_CONNECTOR_WRITEBACK	18
 
 struct drm_mode_get_connector {
 
diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
index 16e452a..268b585 100644
--- a/include/drm/i915_drm.h
+++ b/include/drm/i915_drm.h
@@ -529,6 +529,28 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_CS_TIMESTAMP_FREQUENCY 51
 
+/*
+ * Once upon a time we supposed that writes through the GGTT would be
+ * immediately in physical memory (once flushed out of the CPU path). However,
+ * on a few different processors and chipsets, this is not necessarily the case
+ * as the writes appear to be buffered internally. Thus a read of the backing
+ * storage (physical memory) via a different path (with different physical tags
+ * to the indirect write via the GGTT) will see stale values from before
+ * the GGTT write. Inside the kernel, we can for the most part keep track of
+ * the different read/write domains in use (e.g. set-domain), but the assumption
+ * of coherency is baked into the ABI, hence reporting its true state in this
+ * parameter.
+ *
+ * Reports true when writes via mmap_gtt are immediately visible following an
+ * lfence to flush the WCB.
+ *
+ * Reports false when writes via mmap_gtt are indeterminately delayed in an in
+ * internal buffer and are _not_ immediately visible to third parties accessing
+ * directly via mmap_cpu/mmap_wc. Use of mmap_gtt as part of an IPC
+ * communications channel when reporting false is strongly disadvised.
+ */
+#define I915_PARAM_MMAP_GTT_COHERENT	52
+
 typedef struct drm_i915_getparam {
 	__s32 param;
 	/*
diff --git a/include/drm/qxl_drm.h b/include/drm/qxl_drm.h
index 38a0dbd..880999d 100644
--- a/include/drm/qxl_drm.h
+++ b/include/drm/qxl_drm.h
@@ -24,7 +24,6 @@
 #ifndef QXL_DRM_H
 #define QXL_DRM_H
 
-#include <stddef.h>
 #include "drm.h"
 
 #if defined(__cplusplus)
@@ -89,7 +88,6 @@ struct drm_qxl_command {
 	__u32                pad;
 };
 
-/* XXX: call it drm_qxl_commands? */
 struct drm_qxl_execbuffer {
 	__u32		flags;		/* for future use */
 	__u32		commands_num;
diff --git a/include/drm/tegra_drm.h b/include/drm/tegra_drm.h
index 12f9bf8..6c07919 100644
--- a/include/drm/tegra_drm.h
+++ b/include/drm/tegra_drm.h
@@ -32,143 +32,615 @@ extern "C" {
 #define DRM_TEGRA_GEM_CREATE_TILED     (1 << 0)
 #define DRM_TEGRA_GEM_CREATE_BOTTOM_UP (1 << 1)
 
+/**
+ * struct drm_tegra_gem_create - parameters for the GEM object creation IOCTL
+ */
 struct drm_tegra_gem_create {
+	/**
+	 * @size:
+	 *
+	 * The size, in bytes, of the buffer object to be created.
+	 */
 	__u64 size;
+
+	/**
+	 * @flags:
+	 *
+	 * A bitmask of flags that influence the creation of GEM objects:
+	 *
+	 * DRM_TEGRA_GEM_CREATE_TILED
+	 *   Use the 16x16 tiling format for this buffer.
+	 *
+	 * DRM_TEGRA_GEM_CREATE_BOTTOM_UP
+	 *   The buffer has a bottom-up layout.
+	 */
 	__u32 flags;
+
+	/**
+	 * @handle:
+	 *
+	 * The handle of the created GEM object. Set by the kernel upon
+	 * successful completion of the IOCTL.
+	 */
 	__u32 handle;
 };
 
+/**
+ * struct drm_tegra_gem_mmap - parameters for the GEM mmap IOCTL
+ */
 struct drm_tegra_gem_mmap {
+	/**
+	 * @handle:
+	 *
+	 * Handle of the GEM object to obtain an mmap offset for.
+	 */
 	__u32 handle;
+
+	/**
+	 * @pad:
+	 *
+	 * Structure padding that may be used in the future. Must be 0.
+	 */
 	__u32 pad;
+
+	/**
+	 * @offset:
+	 *
+	 * The mmap offset for the given GEM object. Set by the kernel upon
+	 * successful completion of the IOCTL.
+	 */
 	__u64 offset;
 };
 
+/**
+ * struct drm_tegra_syncpt_read - parameters for the read syncpoint IOCTL
+ */
 struct drm_tegra_syncpt_read {
+	/**
+	 * @id:
+	 *
+	 * ID of the syncpoint to read the current value from.
+	 */
 	__u32 id;
+
+	/**
+	 * @value:
+	 *
+	 * The current syncpoint value. Set by the kernel upon successful
+	 * completion of the IOCTL.
+	 */
 	__u32 value;
 };
 
+/**
+ * struct drm_tegra_syncpt_incr - parameters for the increment syncpoint IOCTL
+ */
 struct drm_tegra_syncpt_incr {
+	/**
+	 * @id:
+	 *
+	 * ID of the syncpoint to increment.
+	 */
 	__u32 id;
+
+	/**
+	 * @pad:
+	 *
+	 * Structure padding that may be used in the future. Must be 0.
+	 */
 	__u32 pad;
 };
 
+/**
+ * struct drm_tegra_syncpt_wait - parameters for the wait syncpoint IOCTL
+ */
 struct drm_tegra_syncpt_wait {
+	/**
+	 * @id:
+	 *
+	 * ID of the syncpoint to wait on.
+	 */
 	__u32 id;
+
+	/**
+	 * @thresh:
+	 *
+	 * Threshold value for which to wait.
+	 */
 	__u32 thresh;
+
+	/**
+	 * @timeout:
+	 *
+	 * Timeout, in milliseconds, to wait.
+	 */
 	__u32 timeout;
+
+	/**
+	 * @value:
+	 *
+	 * The new syncpoint value after the wait. Set by the kernel upon
+	 * successful completion of the IOCTL.
+	 */
 	__u32 value;
 };
 
 #define DRM_TEGRA_NO_TIMEOUT	(0xffffffff)
 
+/**
+ * struct drm_tegra_open_channel - parameters for the open channel IOCTL
+ */
 struct drm_tegra_open_channel {
+	/**
+	 * @client:
+	 *
+	 * The client ID for this channel.
+	 */
 	__u32 client;
+
+	/**
+	 * @pad:
+	 *
+	 * Structure padding that may be used in the future. Must be 0.
+	 */
 	__u32 pad;
+
+	/**
+	 * @context:
+	 *
+	 * The application context of this channel. Set by the kernel upon
+	 * successful completion of the IOCTL. This context needs to be passed
+	 * to the DRM_TEGRA_CHANNEL_CLOSE or the DRM_TEGRA_SUBMIT IOCTLs.
+	 */
 	__u64 context;
 };
 
+/**
+ * struct drm_tegra_close_channel - parameters for the close channel IOCTL
+ */
 struct drm_tegra_close_channel {
+	/**
+	 * @context:
+	 *
+	 * The application context of this channel. This is obtained from the
+	 * DRM_TEGRA_OPEN_CHANNEL IOCTL.
+	 */
 	__u64 context;
 };
 
+/**
+ * struct drm_tegra_get_syncpt - parameters for the get syncpoint IOCTL
+ */
 struct drm_tegra_get_syncpt {
+	/**
+	 * @context:
+	 *
+	 * The application context identifying the channel for which to obtain
+	 * the syncpoint ID.
+	 */
 	__u64 context;
+
+	/**
+	 * @index:
+	 *
+	 * Index of the client syncpoint for which to obtain the ID.
+	 */
 	__u32 index;
+
+	/**
+	 * @id:
+	 *
+	 * The ID of the given syncpoint. Set by the kernel upon successful
+	 * completion of the IOCTL.
+	 */
 	__u32 id;
 };
 
+/**
+ * struct drm_tegra_get_syncpt_base - parameters for the get wait base IOCTL
+ */
 struct drm_tegra_get_syncpt_base {
+	/**
+	 * @context:
+	 *
+	 * The application context identifying for which channel to obtain the
+	 * wait base.
+	 */
 	__u64 context;
+
+	/**
+	 * @syncpt:
+	 *
+	 * ID of the syncpoint for which to obtain the wait base.
+	 */
 	__u32 syncpt;
+
+	/**
+	 * @id:
+	 *
+	 * The ID of the wait base corresponding to the client syncpoint. Set
+	 * by the kernel upon successful completion of the IOCTL.
+	 */
 	__u32 id;
 };
 
+/**
+ * struct drm_tegra_syncpt - syncpoint increment operation
+ */
 struct drm_tegra_syncpt {
+	/**
+	 * @id:
+	 *
+	 * ID of the syncpoint to operate on.
+	 */
 	__u32 id;
+
+	/**
+	 * @incrs:
+	 *
+	 * Number of increments to perform for the syncpoint.
+	 */
 	__u32 incrs;
 };
 
+/**
+ * struct drm_tegra_cmdbuf - structure describing a command buffer
+ */
 struct drm_tegra_cmdbuf {
+	/**
+	 * @handle:
+	 *
+	 * Handle to a GEM object containing the command buffer.
+	 */
 	__u32 handle;
+
+	/**
+	 * @offset:
+	 *
+	 * Offset, in bytes, into the GEM object identified by @handle at
+	 * which the command buffer starts.
+	 */
 	__u32 offset;
+
+	/**
+	 * @words:
+	 *
+	 * Number of 32-bit words in this command buffer.
+	 */
 	__u32 words;
+
+	/**
+	 * @pad:
+	 *
+	 * Structure padding that may be used in the future. Must be 0.
+	 */
 	__u32 pad;
 };
 
+/**
+ * struct drm_tegra_reloc - GEM object relocation structure
+ */
 struct drm_tegra_reloc {
 	struct {
+		/**
+		 * @cmdbuf.handle:
+		 *
+		 * Handle to the GEM object containing the command buffer for
+		 * which to perform this GEM object relocation.
+		 */
 		__u32 handle;
+
+		/**
+		 * @cmdbuf.offset:
+		 *
+		 * Offset, in bytes, into the command buffer at which to
+		 * insert the relocated address.
+		 */
 		__u32 offset;
 	} cmdbuf;
 	struct {
+		/**
+		 * @target.handle:
+		 *
+		 * Handle to the GEM object to be relocated.
+		 */
 		__u32 handle;
+
+		/**
+		 * @target.offset:
+		 *
+		 * Offset, in bytes, into the target GEM object at which the
+		 * relocated data starts.
+		 */
 		__u32 offset;
 	} target;
+
+	/**
+	 * @shift:
+	 *
+	 * The number of bits by which to shift relocated addresses.
+	 */
 	__u32 shift;
+
+	/**
+	 * @pad:
+	 *
+	 * Structure padding that may be used in the future. Must be 0.
+	 */
 	__u32 pad;
 };
 
+/**
+ * struct drm_tegra_waitchk - wait check structure
+ */
 struct drm_tegra_waitchk {
+	/**
+	 * @handle:
+	 *
+	 * Handle to the GEM object containing a command stream on which to
+	 * perform the wait check.
+	 */
 	__u32 handle;
+
+	/**
+	 * @offset:
+	 *
+	 * Offset, in bytes, of the location in the command stream to perform
+	 * the wait check on.
+	 */
 	__u32 offset;
+
+	/**
+	 * @syncpt:
+	 *
+	 * ID of the syncpoint to wait check.
+	 */
 	__u32 syncpt;
+
+	/**
+	 * @thresh:
+	 *
+	 * Threshold value for which to check.
+	 */
 	__u32 thresh;
 };
 
+/**
+ * struct drm_tegra_submit - job submission structure
+ */
 struct drm_tegra_submit {
+	/**
+	 * @context:
+	 *
+	 * The application context identifying the channel to use for the
+	 * execution of this job.
+	 */
 	__u64 context;
+
+	/**
+	 * @num_syncpts:
+	 *
+	 * The number of syncpoints operated on by this job. This defines the
+	 * length of the array pointed to by @syncpts.
+	 */
 	__u32 num_syncpts;
+
+	/**
+	 * @num_cmdbufs:
+	 *
+	 * The number of command buffers to execute as part of this job. This
+	 * defines the length of the array pointed to by @cmdbufs.
+	 */
 	__u32 num_cmdbufs;
+
+	/**
+	 * @num_relocs:
+	 *
+	 * The number of relocations to perform before executing this job.
+	 * This defines the length of the array pointed to by @relocs.
+	 */
 	__u32 num_relocs;
+
+	/**
+	 * @num_waitchks:
+	 *
+	 * The number of wait checks to perform as part of this job. This
+	 * defines the length of the array pointed to by @waitchks.
+	 */
 	__u32 num_waitchks;
+
+	/**
+	 * @waitchk_mask:
+	 *
+	 * Bitmask of valid wait checks.
+	 */
 	__u32 waitchk_mask;
+
+	/**
+	 * @timeout:
+	 *
+	 * Timeout, in milliseconds, before this job is cancelled.
+	 */
 	__u32 timeout;
+
+	/**
+	 * @syncpts:
+	 *
+	 * A pointer to an array of &struct drm_tegra_syncpt structures that
+	 * specify the syncpoint operations performed as part of this job.
+	 * The number of elements in the array must be equal to the value
+	 * given by @num_syncpts.
+	 */
 	__u64 syncpts;
+
+	/**
+	 * @cmdbufs:
+	 *
+	 * A pointer to an array of &struct drm_tegra_cmdbuf structures that
+	 * define the command buffers to execute as part of this job. The
+	 * number of elements in the array must be equal to the value given
+	 * by @num_syncpts.
+	 */
 	__u64 cmdbufs;
+
+	/**
+	 * @relocs:
+	 *
+	 * A pointer to an array of &struct drm_tegra_reloc structures that
+	 * specify the relocations that need to be performed before executing
+	 * this job. The number of elements in the array must be equal to the
+	 * value given by @num_relocs.
+	 */
 	__u64 relocs;
+
+	/**
+	 * @waitchks:
+	 *
+	 * A pointer to an array of &struct drm_tegra_waitchk structures that
+	 * specify the wait checks to be performed while executing this job.
+	 * The number of elements in the array must be equal to the value
+	 * given by @num_waitchks.
+	 */
 	__u64 waitchks;
-	__u32 fence;		/* Return value */
 
-	__u32 reserved[5];	/* future expansion */
+	/**
+	 * @fence:
+	 *
+	 * The threshold of the syncpoint associated with this job after it
+	 * has been completed. Set by the kernel upon successful completion of
+	 * the IOCTL. This can be used with the DRM_TEGRA_SYNCPT_WAIT IOCTL to
+	 * wait for this job to be finished.
+	 */
+	__u32 fence;
+
+	/**
+	 * @reserved:
+	 *
+	 * This field is reserved for future use. Must be 0.
+	 */
+	__u32 reserved[5];
 };
 
 #define DRM_TEGRA_GEM_TILING_MODE_PITCH 0
 #define DRM_TEGRA_GEM_TILING_MODE_TILED 1
 #define DRM_TEGRA_GEM_TILING_MODE_BLOCK 2
 
+/**
+ * struct drm_tegra_gem_set_tiling - parameters for the set tiling IOCTL
+ */
 struct drm_tegra_gem_set_tiling {
-	/* input */
+	/**
+	 * @handle:
+	 *
+	 * Handle to the GEM object for which to set the tiling parameters.
+	 */
 	__u32 handle;
+
+	/**
+	 * @mode:
+	 *
+	 * The tiling mode to set. Must be one of:
+	 *
+	 * DRM_TEGRA_GEM_TILING_MODE_PITCH
+	 *   pitch linear format
+	 *
+	 * DRM_TEGRA_GEM_TILING_MODE_TILED
+	 *   16x16 tiling format
+	 *
+	 * DRM_TEGRA_GEM_TILING_MODE_BLOCK
+	 *   16Bx2 tiling format
+	 */
 	__u32 mode;
+
+	/**
+	 * @value:
+	 *
+	 * The value to set for the tiling mode parameter.
+	 */
 	__u32 value;
+
+	/**
+	 * @pad:
+	 *
+	 * Structure padding that may be used in the future. Must be 0.
+	 */
 	__u32 pad;
 };
 
+/**
+ * struct drm_tegra_gem_get_tiling - parameters for the get tiling IOCTL
+ */
 struct drm_tegra_gem_get_tiling {
-	/* input */
+	/**
+	 * @handle:
+	 *
+	 * Handle to the GEM object for which to query the tiling parameters.
+	 */
 	__u32 handle;
-	/* output */
+
+	/**
+	 * @mode:
+	 *
+	 * The tiling mode currently associated with the GEM object. Set by
+	 * the kernel upon successful completion of the IOCTL.
+	 */
 	__u32 mode;
+
+	/**
+	 * @value:
+	 *
+	 * The tiling mode parameter currently associated with the GEM object.
+	 * Set by the kernel upon successful completion of the IOCTL.
+	 */
 	__u32 value;
+
+	/**
+	 * @pad:
+	 *
+	 * Structure padding that may be used in the future. Must be 0.
+	 */
 	__u32 pad;
 };
 
 #define DRM_TEGRA_GEM_BOTTOM_UP		(1 << 0)
 #define DRM_TEGRA_GEM_FLAGS		(DRM_TEGRA_GEM_BOTTOM_UP)
 
+/**
+ * struct drm_tegra_gem_set_flags - parameters for the set flags IOCTL
+ */
 struct drm_tegra_gem_set_flags {
-	/* input */
+	/**
+	 * @handle:
+	 *
+	 * Handle to the GEM object for which to set the flags.
+	 */
 	__u32 handle;
-	/* output */
+
+	/**
+	 * @flags:
+	 *
+	 * The flags to set for the GEM object.
+	 */
 	__u32 flags;
 };
 
+/**
+ * struct drm_tegra_gem_get_flags - parameters for the get flags IOCTL
+ */
 struct drm_tegra_gem_get_flags {
-	/* input */
+	/**
+	 * @handle:
+	 *
+	 * Handle to the GEM object for which to query the flags.
+	 */
 	__u32 handle;
-	/* output */
+
+	/**
+	 * @flags:
+	 *
+	 * The flags currently associated with the GEM object. Set by the
+	 * kernel upon successful completion of the IOCTL.
+	 */
 	__u32 flags;
 };
 
@@ -193,7 +665,7 @@ struct drm_tegra_gem_get_flags {
 #define DRM_IOCTL_TEGRA_SYNCPT_INCR DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_SYNCPT_INCR, struct drm_tegra_syncpt_incr)
 #define DRM_IOCTL_TEGRA_SYNCPT_WAIT DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_SYNCPT_WAIT, struct drm_tegra_syncpt_wait)
 #define DRM_IOCTL_TEGRA_OPEN_CHANNEL DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_OPEN_CHANNEL, struct drm_tegra_open_channel)
-#define DRM_IOCTL_TEGRA_CLOSE_CHANNEL DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_CLOSE_CHANNEL, struct drm_tegra_open_channel)
+#define DRM_IOCTL_TEGRA_CLOSE_CHANNEL DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_CLOSE_CHANNEL, struct drm_tegra_close_channel)
 #define DRM_IOCTL_TEGRA_GET_SYNCPT DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_GET_SYNCPT, struct drm_tegra_get_syncpt)
 #define DRM_IOCTL_TEGRA_SUBMIT DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_SUBMIT, struct drm_tegra_submit)
 #define DRM_IOCTL_TEGRA_GET_SYNCPT_BASE DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_GET_SYNCPT_BASE, struct drm_tegra_get_syncpt_base)
diff --git a/include/drm/vc4_drm.h b/include/drm/vc4_drm.h
index 4117117..31f50de 100644
--- a/include/drm/vc4_drm.h
+++ b/include/drm/vc4_drm.h
@@ -183,10 +183,17 @@ struct drm_vc4_submit_cl {
 	/* ID of the perfmon to attach to this job. 0 means no perfmon. */
 	__u32 perfmonid;
 
-	/* Unused field to align this struct on 64 bits. Must be set to 0.
-	 * If one ever needs to add an u32 field to this struct, this field
-	 * can be used.
+	/* Syncobj handle to wait on. If set, processing of this render job
+	 * will not start until the syncobj is signaled. 0 means ignore.
 	 */
+	__u32 in_sync;
+
+	/* Syncobj handle to export fence to. If set, the fence in the syncobj
+	 * will be replaced with a fence that signals upon completion of this
+	 * render job. 0 means ignore.
+	 */
+	__u32 out_sync;
+
 	__u32 pad2;
 };
 
-- 
2.7.4

