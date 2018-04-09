Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241508-2-2849477461403944191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241507; b=Y3Y2CVG1i6Of55/pRe82zYO0kWniHlpIJbIqUkRt95zufBg1y2
    SXlKp6QdZnegX6d2XSIu9Uv9dPhsgcY+5E3EqucWR3ZQGgt4yF0GHQf3nQBs0+EQ
    q+mxm2E2RdM83Nt2pqZbMVMU8jiq33gQhfkuEtkRjcAdLmbDiTwyvUl2cTbJxH2r
    ++VqM8UUZzcCk7KDWjUX6gEGMS/YnSuELPZnxhokeqhhgNvgCj/BY6yd7qpDEDZl
    oNA/xSqO93pJCBT3lYa7NoE60l5CbfnASWkXFgK8zAby3GWGJXrAqzfY7wD/rO8P
    vCRjom2slZRg4hiKGppJISKFUsPCcctoX3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241507; bh=DOZOIUhlji
    OXM+4G7JQaI4aEELKlR3ldjaJa/bHEXiA=; b=EfkSbyBhD5H4Lcby9aUyOf5ceb
    DozKapmQgXh6e8MTbo8VEIyJC2+gMyKmje/J2hkUO9gA/ug0bFwiHBIL+8/wYjuQ
    1586bQQ8HwdgwYcixeV/2s5eisF3FT/Opjpa+tLkzSwje0pRPrbN49AqYfJsJUpz
    DaoYPhqYPUgZ4Ic18ZsdOHOS2t0BKOw3gLHn0XYdry1i4O9GkLn7GERTntbMb7Rm
    EW300clORC3izpdXz8/lD33ad+BEOF7FmS7/bkYnXhjvkGSP0M2dgLNWTCtcKuM0
    fv3ORUoLZ+ijf9hHk3uUcpCHyPzteHdXlYBRSi/6AT6djTRxekPFDqu1yqCQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JDx/MnKW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JDx/MnKW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL9kvPsPqH9xNizMpDJkoNHpCFqvMd4GP4stynZVM4m13wuRUWRQIMMAzuk2rIS4N4VfvP+PGI85PyvG3DIy3WzEsbKPesmm9k+jfVkAU6dOFHYnS1V6
    QAqgdn1EwtqHwCSO61m06V758KycZN57S6K1zt6EJwkcJN9Qh2AjyIMFPv6ZTTZ0Xcttph1sI1sH8mdhLDh4lYWYiRL206S4wB4GjKn3kWK14JCtSXVm06PK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8 a=yMhMjlubAAAA:8
    a=doU7KjFTIhEns1rJz4IA:9 a=wPNLvfGTeEIA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756092AbeDIChN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:37:13 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755613AbeDIA1e (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 048/293] drm/vc4: Fix resource leak in
 'vc4_get_hang_state_ioctl()' in error handling path
Thread-Topic: [PATCH AUTOSEL for 4.9 048/293] drm/vc4: Fix resource leak in
 'vc4_get_hang_state_ioctl()' in error handling path
Thread-Index: AQHTz5j6eJd1i067wUybzutI4QRO6w==
Date: Mon, 9 Apr 2018 00:23:27 +0000
Message-ID: <20180409002239.163177-48-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:VS4u/Tr4Zqq+ptuNShCtQStvUrmZT7DNYQOCtvtwVATeNky70XMW/Nj7NnPRPMI8YyAjUaSbzdL1tpaTPrFGeBBeAmuH23aKMzHFx0EVYrrUuNO9W6dP0R3N4PZFBEeNs2qqZah8T0ClOvGyiO7JikdJcVrQKkbjA1AlKlw/akSLz048Zp/wtzPJ/ldp3YJ2GdXlnF7O0rUDj+lFu+TPH3awGyQajviCxppg25JEQ/OAki2j5qMa+eIged1fBLxD;20:J/TThlQJP6XreEZdZuozef7ZyYLcmLZnhyKgG7AqFGOm5q9v3mdR+CQ9QFb1frq3quG2dm+36JMoChm4MCOUJFFUZS/TwljiFII3Jrwq0zrJnVFx2BbCDaad5NOr0dQuopUcXUN7bZISbjXboHPlQIVLCS8CSOw9a6MjNTFbnA8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fc698d4-e60f-4d6e-e5a7-08d59db0ad31
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031CEC571DCF1ED6B51D300FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(15760500003)(966005)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: W/MiNOFGY4bg9xJRQpwq80HS54yCDeOZMTVS4jZJFtPQz8AM5O4yFZoSNXeIQc7dC7ctNRBGqLhE+IWezN9zb935dcb8hJdNyuXUlr3O3QZw3UqLQwpFrUw+wuYvODlrOfIDFAqaoQ3USzQGW/fVuIcVNTB9E6IPRAPCWiM6zac3SAcnM/Wo2y/ScnGtxgXVI0KbOrmz7VQymYHHHet2LIBEuQZKtXOLP16Lgy/rNDkaMyRBb066iVmreJgNFyWFfGWaPlk7zAkvSHzK5oGmdH5A6o0lMEQFc2MG0c/uCBmHfKRzKx8fLq1v+1g740Ogb4XveY0v33HPlni0CZs6ZSZEOqxKNzoB4kANT31zaKRW4knNSWyCRw7++wycTkrxs0Qhx1zitg6ZbVQl1BruefOHOeMHEMB1yApQFrg0n0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc698d4-e60f-4d6e-e5a7-08d59db0ad31
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:27.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit d0b1d259a4b58b21a21ea82d7174bf7ea825e9cc ]

If one 'drm_gem_handle_create()' fails, we leak somes handles and some
memory.

In order to fix it:
  - move the 'free(bo_state)' at the end of the function so that it is also
    called in the eror handling path. This has the side effect to also try
    to free it if the first 'kcalloc' fails. This is harmless.
  - add a new label, err_delete_handle, in order to delete already
    allocated handles in error handling path
  - remove the now useless 'err' label

The way the code is now written will also delete the handles if the
'copy_to_user()' call fails.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: http://patchwork.freedesktop.org/patch/msgid/20170512123803.1886-1-ch=
ristophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index ab3016982466..b608cd463d4e 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -110,8 +110,8 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void *=
data,
 					    &handle);
=20
 		if (ret) {
-			state->bo_count =3D i - 1;
-			goto err;
+			state->bo_count =3D i;
+			goto err_delete_handle;
 		}
 		bo_state[i].handle =3D handle;
 		bo_state[i].paddr =3D vc4_bo->base.paddr;
@@ -123,13 +123,16 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void=
 *data,
 			 state->bo_count * sizeof(*bo_state)))
 		ret =3D -EFAULT;
=20
-	kfree(bo_state);
+err_delete_handle:
+	if (ret) {
+		for (i =3D 0; i < state->bo_count; i++)
+			drm_gem_handle_delete(file_priv, bo_state[i].handle);
+	}
=20
 err_free:
-
 	vc4_free_hang_state(dev, kernel_state);
+	kfree(bo_state);
=20
-err:
 	return ret;
 }
=20
--=20
2.15.1
