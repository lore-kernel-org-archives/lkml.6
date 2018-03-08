Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489630-2-3821265586407144079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489629; b=n0Scw2cZzFyJP3LAdRzoZiwgaQ9BhzbitVNDYTXuYgP2JcH
    WUnTitQTFt7rIRYGnsXRexgChhJ+0FqOOK43VDGQgmvO5V6EvjFvL/P5LGJ140nd
    RpG1oJgm1xpFOP7n20AYV9SCYfqT1megA849Wute1L411TyDIqBPw06sevHJw2ST
    qBrC1DfSijzkx6a71IJ4Ul6nqRRFVG9xzpGge6TJUDxj9vQZJB057J5+yebxHNb6
    CRZH6LZPistPTHkmOzjzAIoHN+15HxCrQrJ2/4971/rWWVpHpNyekpzIolyuZmIj
    JYttgPvyeR2wrOCRVqiHD26SzkdU9gteC6TM7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489629; bh=ZcCeYz
    92h2GtUHoWq2L1VIGZVlUH7Dx148YQe/56cts=; b=iN6iw+2+2wVPXUJ6jrUeRq
    CRKCg2uJq0Wi6Z37wST6qp4PYqLdICA5GtarNh6W7kY9Nv6IXQmQnytPlLbIajFB
    OJ1hrWxcl+7d/H1ffnH6nKhATPZAxKHAQFrIX3WgtfL82dH2kpGuTw+DHNSGQotV
    rEkQMJZUj7REOAS4ef6kKBbuZr7/TM86RJ6B1BMM+UF79HjxoOvByasCHOvR+D9B
    mm/2NbNYDk7I2oT0W38SadjQQapBV9M0oRWDzYZk9aaVln7RS05TN5xtmy/EIN/Y
    /wXJ3nW8arT7m2jkeMS+3P6T0q3Vr6fMGsysuhJpJsY9MvnLpvtuk06rRU9+bDOw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gNMpBpuO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gNMpBpuO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965747AbeCHGNq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:13:46 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755329AbeCHFBc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 069/190] ASoC: Intel: Skylake: Uninitialized
 variable in probe_codec()
Thread-Topic: [PATCH AUTOSEL for 4.9 069/190] ASoC: Intel: Skylake:
 Uninitialized variable in probe_codec()
Thread-Index: AQHTtpo56UScCz6GVE+LOJOljqUUtA==
Date: Thu, 8 Mar 2018 04:59:22 +0000
Message-ID: <20180308045810.8041-69-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:xPFf5zUNvn38QqP8iNkYSvMmzn0mDDedqOJTiTTUGag5v+MTEIDw0ZW8VXEnJ6ejYK0balqJXaGcaUjQP/xv4X0D2jPPNSDrNeXbLMLk2VrdTmsHX619ztacE6vhCcWTUNLieJr7h9nVfL3pHa9VjkFMCml+2RXQNCUMgCWYtsk2H/WH2cJ9uKBpk3O/jRhNEW7eZVg6g3XQ5nlwrr55lojEkat/T9GJy6mucUw7v7hCuvephCE3ghSatCvOxbb/;20:Xo80Oxv47idgJaIia3uRX3B49tBkDLM7KUs3SPZosWI9By73jTq0uuYrYJyEdJp7tTiaXa69ccHUR2X/g9UStP/XAqCc5vSG0aEq+P8l9GwUutPtlCeQ9PGM/yA/0yvk9SWnF0RcIBDy1yuwecnOSfHBv6slsNjuV8jA88dBsM0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a24cb52f-afe7-4b6a-e690-08d584b1a3b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099903BA5E730F596D20B45CFBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(575784001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: H/UjLj3MJ9hGDCGkr79+LkPKQmmHLHj8xKd1Pdz3pU9Rn2cvxw1bpPVod/yHL5t9s6FIZoh2/l1E8XurVzC2JAwxxLfUGeOsjRn7HPu1yg7dYo/zyXoBCfIURiPCPjDrLli4ODsQsRUEXubDpIGInLcudxb4S3KHkxrwnMl41AXtcshYnb5TszkfaSRb9XSy2FOcEtvAscrhaIT545o+V7voJYgL1CBNLA78Dn+Syrud9z3EZDL0sNJrtRRcC5bZ1mrAmXDVJItC8AAuH+xINsEf5BumpvmkKFGWI/cgA57hUhWAue86qlAC+eC7dT/LPjnyhNFTYvZ6LpCAQlZiSg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24cb52f-afe7-4b6a-e690-08d584b1a3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:22.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e6a33532affd14c12688c0e9b2e773e8b2550f3b ]

My static checker complains that if snd_hdac_bus_get_response() returns
-EIO then "res" is uninitialized.  Fix this by initializing it to -1 so
that the error is handled correctly.

Fixes: d8c2dab8381d ("ASoC: Intel: Add Skylake HDA audio driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/intel/skylake/skl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 06fa5e85dd0e..3e526fbd267e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -457,7 +457,7 @@ static int probe_codec(struct hdac_ext_bus *ebus, int a=
ddr)
 	struct hdac_bus *bus =3D ebus_to_hbus(ebus);
 	unsigned int cmd =3D (addr << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
-	unsigned int res;
+	unsigned int res =3D -1;
=20
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
--=20
2.14.1
