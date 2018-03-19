Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482754-5-3804896669345946358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encada, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482754; b=n8yN3TIBfOMHK85oeYUkNrxEt0XDvOCyHqb/oUDE6UmVajm
    dUznuqwGSp28Pvk6QqDYKerRChR1GxWRspVSbQRMWG6D5dYITANeyezRymbhL67U
    7e3dYcXghURzgT9fj3XZFPNt05Zizjl5N+eTDZt3OS56OPvQgUlDKu69XlbbulWO
    Xt+2KaKfcxil3pWIRAOofYsj8/InxQOM9aYEGIU5SzsuyWKg6pPmNkrkN/AkWjjF
    t9COc/ov0GiG1cWVYcfVpfCb45hiAukb2u0+MOprbEnKn38J2Z/SF8bDQCdZlDCE
    WLtVPNBkYBn7N2TF2+fCmgbgJWAXc6s5kQxW+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482754; bh=bw8Nar
    quo+aYYb5OH63Sd849RmTtL+ergnW6z90Y3Mo=; b=DtLbh9KVR5IOXUotWAWSkv
    ClTpFWKdxpE5PeZdYMesTUiWTkOQ8K+hwcNpYRIdejROYuAT1t8IkBlmZin8uGo5
    5MybCEqWGPXBxyjA3+sc94BqWrgDW0qS/aXnxEdJmARiKvvj/l3+niMOmD7lpS2H
    w78xeNQxVrHkV+/XKtf75OV/G8FNe3Rl+NEDj4bLdItWliGFX1tgCdJUFJdhsshd
    vqbdbh5IYwgN29U+1osNVh6Jo15hcTmEZjg+pOUc6FdG8ZPw66lzVY4jHOvXsbPr
    BY1hZS8vn40+W9aOIQdgbeZzNmDIu89Qc3TYNCedUid1346tqw324a3aJS4FfFdg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cyKrd62K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejfeenucevlhhushhtvghrufhiiigvpeeghe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cyKrd62K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejfeenucevlhhushhtvghrufhiiigvpeeghe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965611AbeCSSEi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:04:38 -0400
Received: from mail-co1nam03on0096.outbound.protection.outlook.com ([104.47.40.96]:50816
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965152AbeCSQDx (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jia-Ju Bai <baijiaju1990@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 183/281] qlcnic: Fix a sleep-in-atomic bug in
 qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M
Thread-Topic: [PATCH AUTOSEL for 4.9 183/281] qlcnic: Fix a sleep-in-atomic
 bug in qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M
Thread-Index: AQHTv5uLNuG/3QWuQUero51iqD1QDg==
Date: Mon, 19 Mar 2018 16:01:30 +0000
Message-ID: <20180319155742.13731-183-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1094;7:3h8DgX4aVcQCXP08Tu2pIRLduVnmqC098DvGr9Xf6qWOdMF+rqsWSOepnvS5XyDcgv5JSfRA6shyoGSrpS/rF3IPSqLnoL+L76iA32+H2V9c2NnnUQbKkKnEEJ0aIqBi+iCw68QxesIqqVLjG3QYbb6aBUlWtcAvu+PA46xuOXQ/4HNg8RCGyaU7ePHq8xb17wcbFHBeHXADzP5/68ep2lUfWehkS1hZ/6K79vCzpoS7M0vntWu+iVE7uJp9OjIV;20:lNWujBidA3O8FnZTmS5QrSFa982Lddy/y3LMcAN7g1DCBD4hutATXgxfckfS2ghz2hdXNq1tmJJ8kHiPJfC76xXY7jQSWpZZEHpWH9m9VJz54PoNf8i9ufE78o/Oynv/2xMxLqsCYa24+f2Fh5OIJcBRqlFxGPMrF5FXcFOGKA0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a2c37a1-30f2-4ff2-e3aa-08d58db2ffde
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10942310AF93B48773208BBEFBD40@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1094;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1094;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(105586002)(8936002)(6486002)(3846002)(6116002)(3660700001)(86612001)(68736007)(7736002)(316002)(1076002)(305945005)(36756003)(6436002)(2501003)(14454004)(99286004)(15760500003)(76176011)(4326008)(5250100002)(86362001)(81156014)(81166006)(25786009)(8676002)(6666003)(54906003)(2906002)(10090500001)(186003)(2900100001)(2950100002)(10290500003)(106356001)(3280700002)(110136005)(22452003)(478600001)(59450400001)(102836004)(53936002)(6506007)(6512007)(5660300001)(26005)(97736004)(66066001)(107886003)(72206003)(22906009)(31853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: aNrJSzmPKc1vi8XAxpiBVJC3Oh9BC7r0oB5YQqZQ16hnMoYX45O/d4c6GfAhyW4Nq8S/+WU3v0EpERMQnFtfoAIXH7lk8nfqduyNoNn1GuyQPbxQ53JC5B7EIrkfplJnc+EJjFcaLoLIyN3wTsSXH/EbNlUJmvc+144UHTAbMi5xGY+TiDqP/pdovbFlMRJxqsk3qnqEwbEbx2Ui4GjjaH6faHhLkTCCMyo0IgMq4FQJD+vOdey0pxPru0UvxzgfzVoQjX/IYw64WwIjItqliMZQV3YMU3ACC5VCDJ92uFPfqCwlm2BFNfLmZHQKVQXH2leifDn+9orIp3U9kd56Qw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2c37a1-30f2-4ff2-e3aa-08d58db2ffde
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:30.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jia-Ju Bai <baijiaju1990@163.com>

[ Upstream commit 5ea6d691aac6c93b790f0905e3460d44cc4c449b ]

The driver may sleep under a write spin lock, and the function
call path is:
qlcnic_82xx_hw_write_wx_2M (acquire the lock by write_lock_irqsave)
  crb_win_lock
    qlcnic_pcie_sem_lock
      usleep_range
qlcnic_82xx_hw_read_wx_2M (acquire the lock by write_lock_irqsave)
  crb_win_lock
    qlcnic_pcie_sem_lock
      usleep_range

To fix it, the usleep_range is replaced with udelay.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/e=
thernet/qlogic/qlcnic/qlcnic_hw.c
index 509b596cf1e8..bd1ec70fb736 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -341,7 +341,7 @@ qlcnic_pcie_sem_lock(struct qlcnic_adapter *adapter, in=
t sem, u32 id_reg)
 			}
 			return -EIO;
 		}
-		usleep_range(1000, 1500);
+		udelay(1200);
 	}
=20
 	if (id_reg)
--=20
2.14.1
