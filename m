Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489487-2-7694054733824832019
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489486; b=QW7/OcE0NQO+MCtTkPBsgGqbgftpJaIjpNMxysGV+L2+5Wh
    +JRJa5TCpgKAU3rTO2o1RfNCGJgqoAoN3ecVcyzacNF/n7Nyowd0TDLi0YyjNmAN
    wUm4HtNY8oC582UqjR5Wjooqkmfm2YQNOlpVcaHeKoYIcXJHXmCAj2O9YbwM4iiU
    ElGplYYJ0+UubS9q9AWEGZqdaqLNaj1+SbVMOChvLO+rlmCyhIWpJCViRKBtmzqj
    hu15b72KdPVPtRQrxDptA/VgypJRSdPm36RzaeuXMQbVolx3nZAuhSng8Dmq4Weh
    VkUlynEIN5SYiqQFtZZD/nW31N+7y3TGsX8YBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489486; bh=07xX+9
    yIBmCYEnuVb1z8dh5tu9/nyEBJW3G8p9psXMA=; b=M+s0ZPboJlY2kmgoCbg5OE
    1/umFbTH2GEzVSr1W3vHTK3bTeg2g12hu821FY03xxUQQAeRwULmlzZ4zD7H4vD/
    8IWAJVBFPRcwNtj14M1JQdKrM90AIaq7fGpWspz6fFOBtAO8MgyRpgW5GFbLArD/
    6DlBltTOTMceSwLPjcB2YnEZfD4a3tW5gWGsLV7pM7prFksQfE7cthO/cEkY3/s2
    eL4ic/2qJKib4VbYcfh9QyBMC8L/qrgmmlhX51M7LUX97EgEkHNOmdDt6nbpdxan
    yqesljS1RmxYn02gbzJeC+sepychgCu8OPZd56NIl00rJse9PQ+JdqZK8EUqE0Mw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=naXaW4mW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=naXaW4mW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965875AbeCHGLE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:11:04 -0500
Received: from mail-dm3nam03on0116.outbound.protection.outlook.com ([104.47.41.116]:61650
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965401AbeCHFBi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:38 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 079/190] tipc: check return value of nlmsg_new
Thread-Topic: [PATCH AUTOSEL for 4.9 079/190] tipc: check return value of
 nlmsg_new
Thread-Index: AQHTtpo7EqhIhIxAqUeeCkNlVJwHuw==
Date: Thu, 8 Mar 2018 04:59:26 +0000
Message-ID: <20180308045810.8041-79-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:sxOvtI3OK/UgZgv+P81ktJGCNwHsNKj22O+Zkrkf7B2/pJ4uaIXe5z+0894g7AKFAxR5pIhqOv2x3sE70xVLFY6g6tCqtxbNKZfKEueR2nfPhkBNLuFgam6ByDkIIUoS54OO+AWKyGSMB5Q9WuvKgC179GAMtXEkacOo3RM4DbIniythY96k24VtB6AD7GcxZIse/eRGhoAtqkb1bf4zC3a2HMWgiUHXDyqR0YVAkI86ZGwoLtZ9dP/PpLrZQoKW;20:IVA6ndvAdjAHGQR7h/4BWRJChW2N7yLOaFkjmmtKcKbiJI+Z5wDCzhvJxRFI2xiwDdMfABgCAff20fk1p3D5BwO53gzptqh+SzSmXsZwhaCjAnLZ4ym/gWCtjFnMFFQM2bIoZgRtqk8VoKqq+s7LOLYrgEj+aJ4ceG8SCV/uSgg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21509a82-fb50-4ccc-d29b-08d584b1a64e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09017AF1FE68551CE0D9A4DCFBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: q26ti6Qwr4gbZaFkHCupatSHomIZTTz8quAVmtmhvA9RN1gW/wkl56xRfaUcE+1Gmgk5Dvf86dzn5lZQTTYkrFqMPk2B7zT+rulTlC2mTI9TP/8HNoSMPLX1/SxR70L52XqY8wu3BvGnBW6uu7vZSBF5gZQJnlF1WK4DZta0ArzrCoIncjz7BGs3WHm4o85UrVpd+7AANpFZTxUwm/xqtPFmsTDA0JuFppq3srJUTdOArh1IRfQ/sy6W9PrU6eCGBSHNyzdVf4N3Mq1uOGDptuVoroAozcib8bqEb46S9gmv4Wf3JUIBXLpggXBTLohzB9uhQb/ElobxgJI3GL9dcA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21509a82-fb50-4ccc-d29b-08d584b1a64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:26.7178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 78302fd405769c9a9379e9adda119d533dce2eed ]

Function nlmsg_new() will return a NULL pointer if there is no enough
memory, and its return value should be checked before it is used.
However, in function tipc_nl_node_get_monitor(), the validation of the
return value of function nlmsg_new() is missed. This patch fixes the
bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/tipc/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 5b3e1ea37b6d..db8fbc076e1a 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2094,6 +2094,8 @@ int tipc_nl_node_get_monitor(struct sk_buff *skb, str=
uct genl_info *info)
 	int err;
=20
 	msg.skb =3D nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg.skb)
+		return -ENOMEM;
 	msg.portid =3D info->snd_portid;
 	msg.seq =3D info->snd_seq;
=20
--=20
2.14.1
