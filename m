Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487212-2-9721888064790050168
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
    t=1520487211; b=u5COJVKl4e4m6wzHrwqAVgm7+LeC2PzDx0v+cKkxHikiLQx
    z1hQ39HuppF3RCL3a6Xucl3jDvElkMd2bxi2NoJX2NozGB8lS8fWg7nr/oIweEl7
    whHjf/Il0UhLvdmEcWdJEpKxsA9oM00em2QtprFskuknsK0TSgVFUVAHkfdZv67D
    uI+fEYfO+BJYxHfLBx4G6S7Ahkb6mF67A9RLnV+//mUvZ0wKOu3rOqWETg5ybar+
    tSTHACbN31JrRETLRMterHEu4XiyNao5aphyJ7zwFwJy9rH9TJ4iL9iE82kgB76a
    6+PbFluRpiLRLIv6KYPTuOUKsVttSSHz7ZltkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487211; bh=Yy0WvU
    rGVFH+PUd9InxXNzHI5AKBfbyJ/iMqRhbZ3Y0=; b=FJeemB94p2YgqmS4yVngHU
    2Mk6f11TDpY9YELnN33jotZzGeZHRQlpnbo9WHbJhgfCdcX1o3ZWjz1oi1sR6YrY
    1IFJeRDarFxdlyzF5CD4zrDhV0NrPwb4C7AZbJ5Z0RjBcatsml+pM0I1plPLjVPy
    e1JrKScdy2ojei5VezeMV3BQtjsGC5QLnir8udyOKsBz+YmQBvc+kp4hArWKtcFJ
    ccShplk+8NZObG7dv2IYMF3wNYVtxeDFHcx7EYIifRfwuNYvmOli/KDmXBQkuv5V
    mc+Tlk0mFQn4ZMgUOXvmTcT6s3Y6S3stURhTdHfYNJGDPSgbaatTbdXqLYICz49A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cTR4tmlc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cTR4tmlc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966390AbeCHFGQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:16 -0500
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:12788
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965226AbeCHFGN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 049/101] infiniband/uverbs: Fix integer
 overflows
Thread-Topic: [PATCH AUTOSEL for 4.4 049/101] infiniband/uverbs: Fix integer
 overflows
Thread-Index: AQHTtpqOa0uW/MIU+kWRWk/IMGsFkg==
Date: Thu, 8 Mar 2018 05:01:45 +0000
Message-ID: <20180308050023.8548-49-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:VF64rzYK7tGkLE9hEzTNJMNNHfLUyG6zBVlFiGv1uxDp6vq0Qx24XZNCZJ4hb9DOLbqjSdz/EOCFlP9bi3n52fcCdu3L+Y4bA4JH5Tc5Z0EgOO5NPlNZ5sl58apVLf6zUFhYeCREtR4UdBlsxlknTwRYbaM7ecGDRmGOasiX3GK8QFmtWojlsU0jw27AyoIfFiGoATY1i+M6EqEpmtBs9KMSkawEnyCXDjTwQG9R3+XXpvCaTafHaRWr3dcgi++T;20:FclwJoJ/LXmQ2xunQpr4wgCBJ+SZgv2MrEPJcnJkQIY9Wi8bCorIhC2lz+c8m2LrHgzjD7ZJ9cg2dc/ReE1raQzeW6YiImWnCpPOcWHuk1UlfS9NWa559ZXyleEESUmSwuqdFcVjRRhLUkWb8DRfSwqaIuAKegU5vjbSCPsD+d8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 177fa085-3b82-4296-1581-08d584b24f19
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917A82B6AC2F5FBA89539A4FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(575784001)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 9ajeyYqZqU5g2ud7xDsh6Ni12XiyImbbDD1M77byMf0CypXxsGhEpCZfIW/4+JuUfiMc8HnqbFTwgoHYvxYUJKZKk378ltCLeBkfAzBo2qMpY4O+GpfnynnNW2n+IItF+73ggf0VVbDDCVlnnwWjCw7t5MYvkwABeIEbIv33WExFZqHe2leEF902yN26L2olbUBJRbIUu05gFCC0Sn85NKUkhiGv5t1+t0NLgxBzghCm3zRevBCFZUBsozSlS3ul5ncNUrip6Gv0rDwqGAQLMmPzpioNSCQpigIUg/VyCrPUtwTzych6MvR9MLRZ+tvepskHdkdXMFw03TiOqubLfw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177fa085-3b82-4296-1581-08d584b24f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:45.2168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vlad Tsyrklevich <vlad@tsyrklevich.net>

[ Upstream commit 4f7f4dcfff2c19debbcdbcc861c325610a15e0c5 ]

The 'num_sge' variable is verfied to be smaller than the 'sge_count'
variable; however, since both are user-controlled it's possible to cause
an integer overflow for the kmalloc multiply on 32-bit platforms
(num_sge and sge_count are both defined u32). By crafting an input that
causes a smaller-than-expected allocation it's possible to write
controlled data out-of-bounds.

Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core=
/uverbs_cmd.c
index b7a73f1a8beb..3eb967521917 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2436,9 +2436,13 @@ ssize_t ib_uverbs_destroy_qp(struct ib_uverbs_file *=
file,
=20
 static void *alloc_wr(size_t wr_size, __u32 num_sge)
 {
+	if (num_sge >=3D (U32_MAX - ALIGN(wr_size, sizeof (struct ib_sge))) /
+		       sizeof (struct ib_sge))
+		return NULL;
+
 	return kmalloc(ALIGN(wr_size, sizeof (struct ib_sge)) +
 			 num_sge * sizeof (struct ib_sge), GFP_KERNEL);
-};
+}
=20
 ssize_t ib_uverbs_post_send(struct ib_uverbs_file *file,
 			    struct ib_device *ib_dev,
@@ -2665,6 +2669,13 @@ static struct ib_recv_wr *ib_uverbs_unmarshall_recv(=
const char __user *buf,
 			goto err;
 		}
=20
+		if (user_wr->num_sge >=3D
+		    (U32_MAX - ALIGN(sizeof *next, sizeof (struct ib_sge))) /
+		    sizeof (struct ib_sge)) {
+			ret =3D -EINVAL;
+			goto err;
+		}
+
 		next =3D kmalloc(ALIGN(sizeof *next, sizeof (struct ib_sge)) +
 			       user_wr->num_sge * sizeof (struct ib_sge),
 			       GFP_KERNEL);
--=20
2.14.1
