Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496119-2-16363616780053925142
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
    t=1521496119; b=i1KPrb/Hn5i4Nqa6+rVFuQSwPsvhSIHDDxMsz8ua5VFTVbg
    3MrOLLopY0s5LZQcahQ8VtVuvadPbRlYD/TzXwfiGGK0fuaJmE6nNdoF70YEtJeq
    DxkkZnLw2qvDhzbrBEpLkF8Xkio9WHvF73ATuNsvThAj0B3m9b6I0D0lnlXlB5je
    02YT4qnNDQB7A/ZXJzc1XMz9efqp0x8jfTys7uS6KHUr5LiTJ3c14FfqvrSHrOFE
    a0HVm1FEwCROu7HUQ0xefpxggBj2iXkJ0ZOMieGkR2yeIwHNT3q4uc/0v0npfYJu
    DNUQNTpKVGPDtXcsfLB6q8FcP9u6krmRcXw5DzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496119; bh=zU28zo
    0Mh86TX6nMMlA+H7wPa9L5rfJRVcwFbU11KVw=; b=mTO239Y2Kp6+hidiEbZK5D
    99QXBkmXgD6hx/y58b1QbA2l1FmdHzmHBf1yLtmeNgEHcmRkHRtPF6QLh+LIhIll
    a0+rQZRLk7cfx3OLUVqhejXa6vDHZrwUXXaCeDk1TGD6IqqliReumcfRG14QxD8b
    Bu0wunvlmLygsZcqtqgEZUto1jXDhVgg/0OjzuYgXCbtZKXFtb/gbz4903X1F1Wl
    6nVaLbImjyngYfbfHgo0NMeSfh3pYc+/kwX1cVmkz7gLIPfX86252yUIwyF8AfL9
    6+CzFAytHY3o/XpU8yq8d/oGRopyyfba6NBWqZdTqroNzPzj1gfiDGuk0kzK7pfA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qu684EG7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleduudenucevlhhushhtvghrufhiiigvpeegtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qu684EG7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleduudenucevlhhushhtvghrufhiiigvpeegtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964925AbeCSVsF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:48:05 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:11541
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934487AbeCSP6P (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 015/281] qlge: Avoid reading past end of
 buffer
Thread-Topic: [PATCH AUTOSEL for 4.9 015/281] qlge: Avoid reading past end of
 buffer
Thread-Index: AQHTv5sScDdmGSdck0yPe19oc8qfmA==
Date: Mon, 19 Mar 2018 15:58:07 +0000
Message-ID: <20180319155742.13731-15-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:otL7JBbOKwEi5t+7umm/wd0fVbMzXyL/Q53csFKPdDgUFTWhtjO9JzAyCmGDK5tjjzDYDzWAwsepw6RMPjD131/iDULBEDVcOEXWH7ZqVdNq5gBi26E/DJCzPTUgVcWiRovBA65oxxC5fiLPNTBLhAs+WszOrdsBYVYAma0vps92x/7zz3cEy5towqULAtQUHAihau6NWo9t4hReENIT8K8BAucOwzOttSdtSc8LluD1wlXUuHUdkT8IsGAci8jl;20:nrdtxKRBrqmEwtFlecP9fzsoEZcOMLVJ/XmFRsIJCYdVB9LMNG53Yw8o+DEspISTNhxQYD4tzKntQUCrve4xQQDxTLq/0FC4hHVX7ROOVDWfxgneFnl0+LJ9dodxce54qASuz8WMhUiEM0QeC1wWrxjry7VwoXBmka/X7SsWxT4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff1c1e2f-b82c-4373-0957-08d58db236b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07260BC50A547033B4C92709FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(6666003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(575784001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(186003)(39060400002)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: u/0iWVuEisPGnt73SepAeZBTXBx6qOuONMGKa7hfZJTAnl+MNEvZZM5lruTjtaTlhL0azOcPd6uBr2VSAhZKe7ccj2kjT/lVlJAW0zr6V0aIO5h2FRQaoBINYJ3tg/0+pUpEK0xrvfztTLqi+dQngmfx4fvc1P/SQSsxuWadqDkyfUkUmPYBeExBd20JnPz3LuqpAwiTqss2s7EV3IDBG+cOh68WyNA4SokZPuO63WhB1sLU8ANW6jhRojWCmthxPSynvaWbNeJkm7Mv8LY73zkua+GG89i2hQrx4km5xmcnGVrTnnrGuBU4Jq9s4tYBsmkLHvbrX01eJyrpEf7TxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1c1e2f-b82c-4373-0957-08d58db236b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:07.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit df5303a8aa9a0a6934f4cea7427f1edf771f21c2 ]

Using memcpy() from a string that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. Instead, use strncpy() which will fill the trailing bytes
with zeros.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qlge/qlge_dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_dbg.c b/drivers/net/ethe=
rnet/qlogic/qlge/qlge_dbg.c
index be258d90de9e..e3223f2fe2ff 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_dbg.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_dbg.c
@@ -765,7 +765,7 @@ int ql_core_dump(struct ql_adapter *qdev, struct ql_mpi=
_coredump *mpi_coredump)
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.imageSize =3D
 		sizeof(struct ql_mpi_coredump);
-	memcpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
+	strncpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.idString));
=20
 	/* Get generic NIC reg dump */
@@ -1255,7 +1255,7 @@ static void ql_gen_reg_dump(struct ql_adapter *qdev,
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.imageSize =3D
 		sizeof(struct ql_reg_dump);
-	memcpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
+	strncpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.idString));
=20
=20
--=20
2.14.1
