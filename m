Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED4CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9121D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kxX6xENh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9121D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbeIGFSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:47 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:26944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727655AbeIGFSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2izWQ+HmiglaB149a9FkxYWqnLw4R+dF3xjLVhLoZU=;
 b=kxX6xENhxpZvUotXkFvC2VfMLKytZpXWxirgR/E/aAac3VnOs+NxWbvPh628VlAtJXuc36VetrCQkhwa2KTs+c98SZ0YyeiUQjaTv99NRDlksgrmu4PtGg4lBJop1eyBx/DOJInXxXEoxJU698tAuGXYDYqOtIVVXsDSMMWwx9E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 04/43] ALSA: usb-audio: Fix multiple definitions
 in AU0828_DEVICE() macro
Thread-Topic: [PATCH AUTOSEL 4.9 04/43] ALSA: usb-audio: Fix multiple
 definitions in AU0828_DEVICE() macro
Thread-Index: AQHURkMUFZbn4Rf+7USHuLd8/htIIQ==
Date:   Fri, 7 Sep 2018 00:38:21 +0000
Message-ID: <20180907003816.57852-4-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:vHLMSwCypBoT2RsygONVdKY0Qu7OKDaAN2ay3anRkOyKYg0BrUiHC8qY8cx7mcrHKJzBcxzG1ZVZmUJ9Nx2EyLzg9FL7QXVVP8595K1snfichX6gpqZDf42MyIMz8wfZ/jU6zjhw1InX+7ja/CgGqURvGazrxuUgC4dbQwVduTyxgvowCfn2a814+YswEXUTL4ttFVCyCqmqP5lApdpxPvTV5oUs4YQzh75w5f2Dp5WiL1hbpizztnXb+cGAtBgFulHUipoVYCkfdP+m6uTVP5m/Y0HgDQD594gulzA36q1Yt4G2oSTQXxDY272wgh10ahJLSQPjnf1p0j0aj2DwItBd9ZCJZ3rJ/riIuJGI3KoTDPzgr0XmRqT3iAmH3X8GdoELF0EFyY9yAD/VBYl1SYag2kFZiUgDmJefPf/PhmXjdE6jx0eJrwR5cQb1D3zudnohSl3V/CiVqtTkY32SBQ==;5:VPc3SkrxQcvU0rOYk3uR+D4F+UZsbK+81WpR5Z6A/c8qcyKyKuiY9HGl1C+1DnTTBV1FhIL6Ok/I6YobgFqEJ5PalW1Rpio61Tgx0NhhRV63477UU5BD9yw7CWFUK2/f2zUomT3kd5+wbDKOH8+ZRgeR6aLDjrUD8FnKa+2fIiI=;7:vgGQzVsuumqlpX1YGp//bHZTmk4p3LBuyC0O5xr1VK2qbZTql0dg1TiPGedO4TULqg+rjdrwDgudiou646+sRtmud6vwO0WlbOJeD44UYkA1klPqrjXmwX9Jbciuj6yGeKg/X1MyMAvdRtMg0A9Rd5MnhVggLKCicPInPUsazl6TyWcSmxxwBLWNzmW2BJfbvLkgL1ijaRjcqVJC0ZYWEMweAucd6vppuAJj3WS1D8990G6/Efmdmg/n2cijORSg
x-ms-office365-filtering-correlation-id: fb4cb254-dbe3-4b71-d78c-08d6145a87ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB014938F224B979A28793DA2AFB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(14444005)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(575784001)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tfxRFnxmpxq9FB9neIEIUSaRZuDTHnVozZJveVzmGpH+aKeOM6DjsYsDxjiIRS4bvliqpjoSJnjMSZkA2miA9O0OXcNdXQPPyYbCLNSmcFupO0slVspMyVUZcXwsQ6ousFysHDXXDosZaQ+mFoSQ37FABEemxoBCSXSR1+XtVVt0/gh2LoZg1k8h0tnehH3iw4PEGweMy8caGhUQl88i/CVuZPxQhOaVi0Hm2Ut6B2BaKqc5ylKkKE8+GFGb57e7ltQh+/StbCB+PHJFcHFx2go8kceWa+0V39/zpidaAzSOf/uQwNtGFVqXE2hE1k2JHOLiSfFnUH80O+iq2QyA44HEBDmZJg5GMpzV5eyiyGg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4cb254-dbe3-4b71-d78c-08d6145a87ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:21.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit bd1cd0eb2ce9141100628d476ead4de485501b29 ]

AU0828_DEVICE() macro in quirks-table.h uses USB_DEVICE_VENDOR_SPEC()
for expanding idVendor and idProduct fields.  However, the latter
macro adds also match_flags and bInterfaceClass, which are different
from the values AU0828_DEVICE() macro sets after that.

For fixing them, just expand idVendor and idProduct fields manually in
AU0828_DEVICE().

This fixes sparse warnings like:
  sound/usb/quirks-table.h:2892:1: warning: Initializer entry defined twice

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/usb/quirks-table.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 69bf5cf1e91e..15cbe2565703 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2875,7 +2875,8 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
=20
 #define AU0828_DEVICE(vid, pid, vname, pname) { \
-	USB_DEVICE_VENDOR_SPEC(vid, pid), \
+	.idVendor =3D vid, \
+	.idProduct =3D pid, \
 	.match_flags =3D USB_DEVICE_ID_MATCH_DEVICE | \
 		       USB_DEVICE_ID_MATCH_INT_CLASS | \
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS, \
--=20
2.17.1
