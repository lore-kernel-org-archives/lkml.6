Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116450-2-10933144936668488837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116450; b=Dn6/qy/JCOd2WW7+wI27O2KPIMavcaHYizpaGDSd83qdEfW
    a2VsbVMFJlfbl8D41zDhyjpZAwwHrfPKsW5qL26RMLfYr72lfuD21NJnr2juVBsV
    /NAOVO15XEZjFwxJBPqLGJaCzuKzCsRmvMCR5QrB7+Kr6kSUSxTL36Dvu50E2DT1
    xGNwAxUunI31uevA5vzWYj3pnlMgEWa0G/xI5DEStBAogRsxV52+sXl8WlTtOLYg
    FM8n+xuKOpZTPFNisKLu0AnnrFZSiCZDHEsS8h1Q+TZVgKQ+jW1XlJPKo7Sjh1S5
    OUbFWCaOPhHnz5N4av5pYYb8Ha36XXQQn5exzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116450; bh=ewZOCL
    b5e9ETj4YFvO8pzQrEs3SAx3wmZMQq/H1Ipso=; b=K/nlXoXJphzKwIPZo6Wi+m
    GiQH9xnTY51tgqwAB2pCthYsjFaWEbEKy8b6xPoQBX1Pap3F635hB5BSikUJ75cr
    yJzy4wedS1YmD9o0gEPuSR5M0wBZG2ppiYa2eNmZIcXlo841OHQ6WoGiwyGSNkpR
    3s6d25lNFdnv8aWAqarJdA8QYmyDbf6eTcEdEvlf8zRfN4T6uW0mmUhmxBYrQZPo
    YSZzcBbwvM1Sd7lY9iiUBqtPD+a2ICgb/uHr91FGmbplJpSNVN6ZWMN0qrmuYrrS
    s5ubR9jZdrD1RLs8X1WhVcp1LN4CexKXG4rEZFEqNtwId7BIEXwQ7oQLzorDnF+g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q59xGZ6r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q59xGZ6r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933646AbeCCWdy (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:33:54 -0500
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:4864
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933058AbeCCWdw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sinclair Yeh <syeh@vmware.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 091/219] drm/vmwgfx: Fixes to vmwgfx_fb
Thread-Topic: [PATCH AUTOSEL for 4.9 091/219] drm/vmwgfx: Fixes to vmwgfx_fb
Thread-Index: AQHTsz7/DR8Tq61e3Uu3jkYINC/+EQ==
Date: Sat, 3 Mar 2018 22:28:48 +0000
Message-ID: <20180303222716.26640-91-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;6:C21glNoBS16q9vLZXKWDGItbAzpL28Ps5WoF2KKINyQxvIW9rG079urkq2cuDm35k+OEmxYiAk1OXbrFqCNjxuwpHwWe7dUK4XQO5kyodN4gxGB5L9R46NDZsXjYJsXRXjYqRkQsKuMFOiHkUm5xH3cz0P6x6B+mafUD/hqkBYBgiIYcJUBZRVCBBGbvKPj1BWii2C7OztwZFpTI6BwWkYfiKncPk1ahuo5l/vHJYafKZDzm45orZsrV9xFeXF+GuVcj0JZM2hx/OnSXd8noctFjdRjHELiDtcdi2DfeQOPRwqmeUtXaVhAqEj9l66pGzvNouLFASeQLhEqz7MiBXtYetfdonLhP0olALIQIShjQMCkh3JE97xdEtKPBpHtv;5:PAk9Eh7CLdiEIZdzyTLy4ub4JUtkia1UVlc1gTabuCOBF0u3tDX71UlrpmZWRdscag3lq51n2JyIKFr9HOVWovXhUq5LFdUkx7NfvjOmK/MRLajz/4rMiiMIOZ2UBo2qYYiPwkDwETpkWSembFdIwtONkucG9c/1DFCJlG+KwsU=;24:b684Lt/eE0bCEPhPU+jcoyL00fayVPASh53muhOzbLkk1u9+kWvsPsB735Rqv5S8lHsLMNHfDrTzLhiJFrI9E3bj1HI4AcYvn2aidQ9H0zA=;7:QshFeXu3YJonqeOdckD0L1E29KGsTx/6mTvW4w9os146fdyjv3n/lM+HAB4bopMLhDudG6wlvyBkTBUTQfqPVo1OdIpq1Z+qn5/2pnBcoFQdDDS6c99hct2vuXZr6xSw12e9eIHL5OEiCXdU52mplUDsSoxNllNrGfULGC8bd0UTOHIDtNg1kcR492XzBszx+RL90O9sPC0f5r2U73IpMzPQiOvNvnCCqMPglc+rHetcw7heobL3BQMFWT7SQSrb
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d1f5078-8b5c-43fe-a2f9-08d58156d685
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036BC7C8C07CA55175810AFFBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: wXMXOemRZwpGSaKh9euEBEkCa3PvAOez/gozhJBFojo99x9o7hrd0OhjoDApGNm245x5tD3INCgthsvNLUGhyWJbj+vhQtPLTjtyVdjbZDPcetAIu8FAmpAgykqQFaOYirtULfAVcdsZK8Nh8uvOfoVwqouRNAq3KWfYlij7hGk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1f5078-8b5c-43fe-a2f9-08d58156d685
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:48.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sinclair Yeh <syeh@vmware.com>

[ Upstream commit aa74f0687cfe998e59b20d6454f45e8aa4403c45 ]

1.  When unsetting a mode, num_connector should be set to zero
2.  The pixel_format field needs to be initialized as newer DRM internal
    functions checks this field
3.  Take the drm_modeset_lock_all() because vmw_fb_kms_detach() can
    change current mode

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vm=
wgfx_fb.c
index d2d93959b119..aec6e9eef489 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -433,7 +433,7 @@ static int vmw_fb_kms_detach(struct vmw_fb_par *par,
 		set.y =3D 0;
 		set.mode =3D NULL;
 		set.fb =3D NULL;
-		set.num_connectors =3D 1;
+		set.num_connectors =3D 0;
 		set.connectors =3D &par->con;
 		ret =3D drm_mode_set_config_internal(&set);
 		if (ret) {
@@ -821,7 +821,9 @@ int vmw_fb_off(struct vmw_private *vmw_priv)
 	flush_delayed_work(&par->local_work);
=20
 	mutex_lock(&par->bo_mutex);
+	drm_modeset_lock_all(vmw_priv->dev);
 	(void) vmw_fb_kms_detach(par, true, false);
+	drm_modeset_unlock_all(vmw_priv->dev);
 	mutex_unlock(&par->bo_mutex);
=20
 	return 0;
--=20
2.14.1
