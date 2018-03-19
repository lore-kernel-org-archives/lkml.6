Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494720-2-1788962303861356046
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
    t=1521494720; b=unWLUd8Lyb48cYaIWZdyyDKQuPV9EkxwdoWApRH9HYpuCCD
    zrAOcUfMlSXdKAo7SPk8EvFMkyr15eO5h7BA6jjIkVtPXyqo9yDnh21IwVsiqSm0
    xIwByOwnfrEVN7X1Lpz4O2Gbv35jC7zYexAA6ykgAJ/uvBD/JUnNqOfvkue3teKI
    8yQSbA+chKUuI/4jfriZTtvPBktwQyIx2LEMtBlRbP2nL3NkIF8CiaraYkFri1vW
    SWbANQd6YI7wo/U2XpLfT4LcJtSpbiPicCgKTbIYyA0uRswmGMf9ddss6wQbZ7Yb
    PrpBDoD5EHp1wQDQh9M8Fp0LMU2C8k2u2OnVZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494720; bh=I5pq25
    tVxrOyWHNubINYJqKxM0WKMJsnuY1fHCH+niw=; b=TG0wGcJH6Rddq9WU/vLHUg
    1+mEgWQeQOPP/TS0fnz3qsbPjqvMCflTKujsudmhZym2GLhhcdapNQ5cp60ZaEkd
    dvatC/e3Q2lbPkfOpyx4Sopd+pB6A6u9z4sIQ4LsO6me6zTbo3pT9rA5mPqwS+jj
    nlYl3/WI5XIuFlrG4w0rpZgGNNd9baXiqCGZszIuQECr0kHXw3yghJqxiE+tsGcP
    mA9pfB6tE9A3C2V6Po4TTjUiyuAGWr64SkuU65mxOfwuDhbgWg0QXOz+ZrhSrnG2
    R6zwA7N7VnWXArRmqmQ+dj1U7N4OFfo8TSVs/zmfQYfRlW55jibrBIY6Kuv7kCLA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dknnxRBm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdelkeenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dknnxRBm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdelkeenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031733AbeCSVZR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:25:17 -0400
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:22848
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934830AbeCSQAW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 077/281] mlxsw: spectrum: Avoid possible NULL
 pointer dereference
Thread-Topic: [PATCH AUTOSEL for 4.9 077/281] mlxsw: spectrum: Avoid possible
 NULL pointer dereference
Thread-Index: AQHTv5s99+bVoAMszEurgC1EoQ0eLA==
Date: Mon, 19 Mar 2018 15:59:19 +0000
Message-ID: <20180319155742.13731-77-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:UO40JKRZ3G2GmydDZaw/XoWWLcaFLQkvFZ378UfH1Bwq4YqocGth0KDeBZfyJIBHOLNJq7z8wzBb+hwBke27BMtFyLEAaMIm/K/B0rrCHJ6WtCHTIQbV7awKCZ2Ciser9aOKq5dU2TJJYdiI4ysn8vOSd9SeLGFJbM6hQBpKYEVXGgrNRgaXec5BtRdgBTP67qKKjtGX4U/WrLudGmwUyLkxLL7lTU4NRQBzyJ16kIJJWBthy93yCX12RctVhe4V;20:z+Di6dA+7k9S0+CADn0tp0SdmHiJ/IvTPLlD2Wszlumy2sTWBko12hGvO78Sl26xPJ7bw2FK1bIAcMN8ZT0DaFX47MoLJYlqDA0rxx4goF7OdbMyOM+NIt0OfSHBGs8ga6ORU3nfhhXFaiu1UfYzfIkHIBxf1HI6kCMX1yaPQOA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fd396d0-103c-48f3-87cd-08d58db2799d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB086949CC5F6CDC6B8DC10863FBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(575784001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qycqkklluHvf7BvJuiw9TowB6d9FctZlb2HqWyUvds+QNeVnNJ+si+/AwLgo7EYpEM3ClDDNFMohz2ZO9URA6W2H7JQhjuXB0YGhKrQ6RW4APC/bg86fI1qrdCmUj6E4NfggXoaRqnCtQ9eC824ZwkTUeZS3rnub/wORVmwgUqsrWTVSZvZ/KBNcveAMyYCJBTNmJmoOfru+mrcrB28FvJRAaPvYJW2Onq50hTbJo/3CNj7gxwwvnfaKd61dn6CDm3ALCIt5jQLtrGa1bwxPst5B+lVptbX55XGQuEyMec9PV5YYerS1a3TVcdGgnp7ktOFOmvaMkCJ1XgCkye47Rw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd396d0-103c-48f3-87cd-08d58db2799d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:19.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit c0e01eac7ada785fdeaea1ae5476ec1cf3b00374 ]

In case we got an FDB notification for a port that doesn't exist we
execute an FDB entry delete to prevent it from re-appearing the next
time we poll for notifications.

If the operation failed we would trigger a NULL pointer dereference as
'mlxsw_sp_port' is NULL.

Fix it by reporting the error using the underlying bus device instead.

Fixes: 12f1501e7511 ("mlxsw: spectrum: remove FDB entry in case we get unkn=
own object notification")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index bea9ae31a769..60e1edcbe573 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1448,8 +1448,7 @@ static void mlxsw_sp_fdb_notify_mac_process(struct ml=
xsw_sp *mlxsw_sp,
 	err =3D mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid,
 				      adding, true);
 	if (err) {
-		if (net_ratelimit())
-			netdev_err(mlxsw_sp_port->dev, "Failed to set FDB entry\n");
+		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to set FDB entry\n"=
);
 		return;
 	}
=20
@@ -1509,8 +1508,7 @@ static void mlxsw_sp_fdb_notify_mac_lag_process(struc=
t mlxsw_sp *mlxsw_sp,
 	err =3D mlxsw_sp_port_fdb_uc_lag_op(mlxsw_sp, lag_id, mac, fid, lag_vid,
 					  adding, true);
 	if (err) {
-		if (net_ratelimit())
-			netdev_err(mlxsw_sp_port->dev, "Failed to set FDB entry\n");
+		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to set FDB entry\n"=
);
 		return;
 	}
=20
--=20
2.14.1
