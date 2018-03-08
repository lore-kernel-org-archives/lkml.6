Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487403-2-11453777355960351328
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487403; b=vgv7n00K7RpxsHKVNuB/9k5AtKTcN6Apnb0bhxMjcM3O0AR
    0nGnCkVbLy1APFMZK0Nqeu0qb2o7277dCadilEW0GcztT6QfmZKgIrD/e/Z2iFHV
    6XyOvMXB6K3BrF0Xmx80B25CNTBiE+G+epI96wY2nBnoSu4fYc0Z3rnrSCc9W7EG
    NBOMHrYDVaRdiUqh4edYsuq0OXOAP6I9vTL8zc54iI3dNA9S0xn4FG0TeUEMr3wy
    +3faO8hctSVA+47CEAUhOsoeEEuGdQXF4dafTQpO9SXvqOrhyTdGvJWfW/X5hCqo
    z2j9we2vSrxwQqjqz4ohNEblP5YOScMa321Ph7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487403; bh=2uyQ+A
    52AAlSpbFM74+0BlcUepT11BLhrfxg+3wNT3k=; b=sd6/FSJjV5jHSlUrHGSINM
    qVYvOUSnls6zu8GTLc8MEMAs8/sq/4m7jbdM55XYi8qNficwl3C3l/3OzOrLrogk
    bDXlJT1PKNQ4r6a3BJ1bzbuH9oiVFf7RwQ0Ul8n4U6dAEelqeVVLUU0U04unpAP7
    pp9jYNeGO4PXShateCUFjON0XJV51XVdu3udWx1TKE8MSxusDsUCHu68WAXYqPp6
    X5yRxjr01J3Bmw7a8gmZMRalJ2GfXGzZVbgXlDxb0YczerQE9KBakR6frgoZ74Um
    L5n2z4UwSy6ydIHGginW6TJDjHLLRQPE/iUNEbPkMqv7ki309zfSSUT2Lj/RLxAg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VddhwOLL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VddhwOLL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966268AbeCHFga (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:36:30 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:29143
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935284AbeCHFF5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 041/101] ASoC: Intel: Skylake: Uninitialized
 variable in probe_codec()
Thread-Topic: [PATCH AUTOSEL for 4.4 041/101] ASoC: Intel: Skylake:
 Uninitialized variable in probe_codec()
Thread-Index: AQHTtpqM6Xh4R2feS0qvTckbTKeD2g==
Date: Thu, 8 Mar 2018 05:01:41 +0000
Message-ID: <20180308050023.8548-41-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:2ZElq22fABA/GBaRLSC9IxDAiRMqCUPJPc5iSscBjAotovEbIeVPdJrpJnACGIVuvSIktCLZeVGuusVwmS8BX+QzHu1xO1HKAEIy14VQ3aRUMMsaz6UEmlxKaAJsTkUkeP2Svfo+o+RubcGNJ3gXnadSqDfmuAGp+UiHj1IzrZodu7tlTwVHHVxDPMzgFd5buRYIgJ6kIOICmQ+ACnmDIzyVUOz3dfXQpLMrjJ+i9rKOnyzM510IjFjp+8hPdezf;20:26vgQuaKhFGHtJxRO8i9ugG5oXdgLr+eOI0n5DvR/T38C4hPVBVMMsXrTtTpljp2VhjD+5gUqDwcsqwVuiBbZ3fwVfg+axe+vawO8iltK2rqHWUQIgl37w/u/2IhU8D9q0DwRB8zbT+g2UiENf7TkgIHmGX4OjOtl2K4mV3Vq44=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f4818e3-56dc-4419-0a8e-08d584b24622
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09176BAFCC4CE01EB4F982F8FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(575784001)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sgpLWiM1Ksec6AdQOKbZ6FFTR0ecDSxgp7ToqFvKGA8VvB6yUI0YMWkvuY9sj4U3AbtuiriDSj7FTfvFl0088D14lAH/N2bWW2cxhvr7M0/xSlJMbba+3LonDlDwsg7hmw8EV+5OSNBpKpr4mZD3CkTeUmKermXRRd2qSf5e4ynzbomltRRtK6ijkdespoqZwjA8zft+ZNP1y+t1u/HsJ0gBnnEqd5xOMBbjosko02FHIFPBuCy2lGoc0pJ+xjN9O91HmMpKAttB4L9Ov12F9qY0zBYbtABJxPFPkg1Jwt8cILILIZUaSdOF2MVHYaeR92QMbQrfrEw/tJmCrQlrng==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4818e3-56dc-4419-0a8e-08d584b24622
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:41.7944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index b4844f78266f..f6c3be192cc9 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -280,7 +280,7 @@ static int probe_codec(struct hdac_ext_bus *ebus, int a=
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
