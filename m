Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C94FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86E220873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ItjtI2C5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ACWJjU+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86E220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeG3PRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:17:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10248 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeG3PRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532958136; x=1564494136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mms+nSzbrBLvcPZxmmSDpz5O+xnrZ/YRnuZn0WLgzK0=;
  b=ItjtI2C5KAf0mylx2LKRiBVZgleMzHqtali9Tc7wHE+79b+mB2fvLGFm
   4G12VR4nsKI46mPL98HkLnhioAn2SXxjTj7gw4MrVJ2tm6vAQYA3nV81t
   sUGLMoqR/HQZwD69nrDtCMAxD/8svhshh5eAzzWWrzbIJSsoU3EQi1X3A
   vccv9ShWT04qDj38htGtDus1EyD32Boy2FLVh21tj4M4kA7H7sg/XyWgY
   /iNBfBdAnB1e5C2IXYgSJTw+L25TlaPopOFRZKcLLR2Jlf9ywFYupvT8y
   hejqHwZ3bHOy1sny9w9347zCgUZYhRWnQqjrUPEtaq6+qsX5Y3G8it+fg
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,422,1526313600"; 
   d="scan'208";a="86269205"
Received: from mail-co1nam04lp0052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([216.32.181.52])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2018 21:42:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mms+nSzbrBLvcPZxmmSDpz5O+xnrZ/YRnuZn0WLgzK0=;
 b=ACWJjU+RZzkUm1x1agJSNLEr7oABk8C+B2JpU2JSSZv1TQC9DrsYs1hRmBMZ+1P/rLIfPldUaLi3UXPIJlItPiFTgoQmuVVp86BSqzYGwsTDxscVMcxHxrR11rstDhR6w9WoTYmavGY/VfriMYPgJl+vOokcgc9ztkj2vouQjF4=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0463.namprd04.prod.outlook.com (10.173.48.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Mon, 30 Jul 2018 13:42:13 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397%4]) with mapi id 15.20.0995.020; Mon, 30 Jul 2018
 13:42:13 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jin.xiao@intel.com" <jin.xiao@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: blk_init_allocated_queue() set q->fq as NULL in
 the fail case
Thread-Topic: [PATCH] block: blk_init_allocated_queue() set q->fq as NULL in
 the fail case
Thread-Index: AQHUJ8vuRmibWV78TkqxlOAkv6/nKKSnxqQA
Date:   Mon, 30 Jul 2018 13:42:13 +0000
Message-ID: <80814c1eac9d8dda424d6c96652bd13d0ea30726.camel@wdc.com>
References: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
In-Reply-To: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0463;20:PHUro+RHQNQ17xn+jRZAwkV5WM/pRP/peMQi5RPBQ+9DLJvR8vkJ4wXbq2/SX/LG+fz7IHcylnXKh0rNhZ+VVaD6Rk6i6PoTdwbntKrr1pJYmLNpJGpkKeKsqJtAKctZ3zKxhBHS+oqCs8xH2FNnYbCWFqg2JZEZ/DtSfCTlbQQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f27a9c60-6879-4d71-dc1b-08d5f62241e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0463;
x-ms-traffictypediagnostic: MWHPR04MB0463:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0463E23B402344BB5908E64C982F0@MWHPR04MB0463.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0463;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0463;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(97736004)(6506007)(305945005)(2501003)(76176011)(2900100001)(105586002)(106356001)(110136005)(5250100002)(99286004)(2616005)(476003)(11346002)(54906003)(316002)(256004)(446003)(7736002)(86362001)(2201001)(6436002)(186003)(68736007)(81166006)(81156014)(8676002)(478600001)(8936002)(3846002)(6116002)(2906002)(14454004)(6512007)(53936002)(6486002)(486006)(26005)(66066001)(118296001)(229853002)(102836004)(6246003)(39060400002)(36756003)(25786009)(4326008)(72206003)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0463;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: htUnTqxGGJdBvg4Jx/gUNG7E143k0z+yGGHmFt/zz1SU85dUPsNeW2Mo3cL+6153MDbY5umLt4i1EyqZMrGNeGPF8Y0qq8EKXYt04GEhifPqxPDvDv9VbNeri4JT6+VrFVSaDFMZUnvhCYkxiwRGDss84T8mkMhBMeLcfkl8mSo40ZFf/PwwlAjwrya2gtL96KKGYpOrEPgUlZq4sCUMj5dtUoDlyPBDf9fOvoHL6FUHW9cUeXvaD+xtCNIORc9/MLsQT7ciDRbAh6uEaQUKlEEAr/5gGMpKO4QwG77a8P9s53UfruyuqmAQQxHgzQqxJIq/gZLA1o1Q3lxlSf8NSdsrsrFPLp9ZCJ4ggpZvBlg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <FE78C6CAD2D98D43AF4CE7A385775723@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27a9c60-6879-4d71-dc1b-08d5f62241e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 13:42:13.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 14:11 +-0800, xiao jin wrote:
+AD4- We find the memory use-after-free issue in +AF8AXw-blk+AF8-drain+AF8-=
queue()
+AD4- on the kernel 4.14. After read the latest kernel 4.18-rc6 we
+AD4- think it has the same problem.
+AD4-=20
+AD4- Memory is allocated for q-+AD4-fq in the blk+AF8-init+AF8-allocated+A=
F8-queue().
+AD4- If the elevator init function called with error return, it will
+AD4- run into the fail case to free the q-+AD4-fq.
+AD4-=20
+AD4- Then the +AF8AXw-blk+AF8-drain+AF8-queue() uses the same memory after=
 the free
+AD4- of the q-+AD4-fq, it will lead to the unpredictable event.
+AD4-=20
+AD4- The patch is to set q-+AD4-fq as NULL in the fail case of
+AD4- blk+AF8-init+AF8-allocated+AF8-queue().

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-


