Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234207-2-9193454321625205297
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234207; b=Q+ri4Z2FYm1aCiW/9vmxEs1nwoZRyU6hE3hVpDmLE/DpVS1p4e
    mRqpyHuwNGpAm/bB5ik3Fli99koT8Axe5vXsh6GsNf+6sk9JS+AoEUuf93irSXlj
    Q7+A2ppM4rt0ZN8qxw7sFOfsdnMy6A89MDSRuCwQYhAv6KkE/jp0YzbpLS0BuUWn
    vFelLKcIftiFjdWPq5efuuNW3RWf5HI7cEyoWvrU01nRirsK9vV4XzBuaNQjyAUm
    ibrtuRMmZ0mKed6/jQ2rJd+A+nbl582+7ZZVnoiaGrqlXftxp1N3EZQ63rDyUyRG
    Sji7IdaQ5Q1a20uzrC8lZf+9XWOGSWkQ8TGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234207; bh=0Roijwog9O
    nuSgByLK9oxLECDdU5DvEFAwLGTFwaKBo=; b=KDsudFHpsIES6zmGXiXB4Ga6ob
    bsWmrS2bVWTjswUDn6NBk2yeILg8PgKbHiTu5HVtjjCjEjvLRsOq3op/P7J640lf
    ojc71dMbNnNS19S8aOKoM+I42qHQ0sD+WZGA9Uc9NYO8ytT6tooKqh7z9LPL5cyA
    o1NkIDvntGzA76BOnoKN4A3YVjmodmlLyaJ8ykDmGqU4akLmkUqg1BAWC1FIe9dJ
    WJKyJ3xj7ot9KF5dRon98jMYlGEvPW1dWj0rYtfrpWaMnItbgGJoFr8s5iRKLcUd
    WVlCXlBAPJ8r8Z4rz3lrl/VXg+jGgtIcLE7nezDK8kS1bhCsJhJhJwtfW4Fw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RBidX4DZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RBidX4DZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9ieq6xaExyaxi3XBr09a53VK/hnmqfhIkFlesCE9u8gQ6KclhGVDZh/aYzVVhDNyNHGN+Y7itIO2md8s0BFlEANMzDOfksRPoGzSRgs9XWJAjHxZiO
    Ze8zTFLIakHs251EOXx+AeWu51SC5vYauRjU9MtQMgq5atO/hUjSXzi+rTFcU51/dKYSJScAAWEApTbqYhpOASHSr8YYpIAkjCoSHJeRyA+1hRndLqdiitnH
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zRKbQ67AAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=FbnaQ8Hq_s0ZBRUY5coA:9 a=wPNLvfGTeEIA:10 a=PA03WX8tBzeizutn5_OT:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbeDIAgT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:19 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756701AbeDIAgP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Edward Cree <ecree@solarflare.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 058/162] sfc: remove duplicate up_write on VF
 filter_sem
Thread-Topic: [PATCH AUTOSEL for 4.4 058/162] sfc: remove duplicate up_write
 on VF filter_sem
Thread-Index: AQHTz5mr8yRMoL3wO0SfB/F1L0W7EA==
Date: Mon, 9 Apr 2018 00:28:24 +0000
Message-ID: <20180409002738.163941-58-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:WfZKuudlthJOQYEzAK7uvFc5bHvcrObjyRRDOsVBrpw3Ogm9gAQHty0f/LKyLcAVLMDsJjLvHCydwMpWDH8BSN25hXUD4VFdirHgLP3V02LcS1+YRaLExEIDMrkOwXyGAVv1EFtX/xBCjJHGEEPv851CV38KtiDHehPt5Fc5LPyM4I1wMi+PKlstUCF8D3uG/5tby2XoWAk6gclnOca4EQQwUY8EmEFlQDvQ1GO8Ee+g69I4wDxSXlzfn5zxlZRn;20:Z+i6r/V/W0vjFTKHLUCFPNHqQUD0JrDc8BnEqICnXXpS69sU3SXxD4qngVXctvGKxJIiY/cmuj7qaAkAfoyXH7n5OnhDUBOOql/S8CQYbYUNBvloHQ77oLWNFVcFLXW75xA0VUYad669p12NHvebQBR4gr2IvTmiPbj26MfO5sY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35cacc07-da82-483c-7491-08d59db1e4b8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015D754D3EB9E946135C8EAFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: GUn8lscGxtFoFRaQEOZWlowtiM1RRbkhzSsjHSv1V+9AOR2HqCPr2SYDALVYnQtfklF6D7NkPqqU+omAEPQAifBnXVc5EOgbSd5s7mJciHNgJZIJoEbLFDpBv82oFgjM7HLGVQT64ZzSt7HTC+gs5fpNKqnrNDAY8s9wginG+yHgAo7oiKsatUh4dkG8h02VFih1syk+vJvDNNWVsFQXMG8+BPDFqut5ie60FklCP5TgCaqr9YeqVTezmYN/pzbhDa5qAINh9pQDjH7iquKStDdyhJjYqcTLe6D+AQduWWSotYetEjXRS3I2ehGuUaLRZVuEDbE2mTZBs5E1e/SSXe0t/QQOASwU76yI06IZRcmP5r1MSv7bxnqYbHpANt8wmk3oUO+oUN6CeRvrugjLv2eBLy4lbloc0RPWvlfLF8k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cacc07-da82-483c-7491-08d59db1e4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:24.4425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Edward Cree <ecree@solarflare.com>

[ Upstream commit 57f0c9cf58ff7fe479137ab847a886d0eed3ad1d ]

Somehow two copies of the line 'up_write(&vf->efx->filter_sem);' got into
 efx_ef10_sriov_set_vf_vlan().  This would put the mutex in a bad state and
 cause all subsequent down attempts to hang.

Fixes: 671b53eec2ed ("sfc: Ensure down_write(&filter_sem) and up_write() ar=
e matched before calling efx_net_open()")
Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/sfc/ef10_sriov.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10_sriov.c b/drivers/net/ethernet/s=
fc/ef10_sriov.c
index 3c17f274e802..a0226b11eab2 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.c
+++ b/drivers/net/ethernet/sfc/ef10_sriov.c
@@ -631,8 +631,6 @@ restore_filters:
=20
 		up_write(&vf->efx->filter_sem);
=20
-		up_write(&vf->efx->filter_sem);
-
 		rc2 =3D efx_net_open(vf->efx->net_dev);
 		if (rc2)
 			goto reset_nic;
--=20
2.15.1
