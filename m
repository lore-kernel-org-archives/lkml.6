Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497636-2-9793530873208708900
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497636; b=wjNkdybkfIUDQZDlSqpMpGwhrDO8BZFRna/bHJvzW4HR0lW
    QCPIbs4QcUXtlWgCT2ZwvhgOk+x5PHt1b9zWe/pVtIE1za1GRr6CPWZIqFVgevwW
    7sYo2K40txrofGTsWmFwBa5RJlBWU5jmN+agv+s2SzX7JuMdoWiab629CDzSVLgB
    AOMyhbSqUmFj4JCEjl0m75Po4bGPLGr2+RE/HJuMfyW6ux1XbIwzuuVbMoBPYPzg
    nm308st5wz1so71yAIMu+f59R6AyNpGp5FB8dOFdkCv6LhKRIQthRpfhFMFih9oi
    4fO8RAifHNNrnwl3YjsIJ0Kixa8swjUNwXMNY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497636; bh=0ozKZ0
    B2u7jZCkTgObmDsiPiO+MCiudibDtmzIoumqY=; b=wj5IMmmdiGW2r+obS3qkV3
    E/tHC93yZyxRzMGncuUnqzViaqKD8+5MOSQNGF34bi1gfGCKYv3Xyhag6N5fcvSX
    oeTj1URyTt6nhYyJz473OK0ynuvxHErtJAd2pfp0fU1aJDoh8eViin5JdmgG3Yd/
    OVV7qiw589X3x6iH6xjlSMCWTha3inFLDAndcPbzGk5oTLPb9Z219GHSl50nz0aH
    4hdREFSigjtHSw8ILXfiRrKhTXPYapB0G4V1GhbCAqaGH7C/NwmXF13KkLcPymLf
    TXymKvHmpqwwfM/C33UWFIHZxzmxnkyh5JR82NyRH83tZwwnHCWnDzkE9vZu0AXw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EsSGpfal x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieejieenucevlhhushhtvghrufhiiigvpeegvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EsSGpfal x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieejieenucevlhhushhtvghrufhiiigvpeegvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934073AbeCSWNk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:13:40 -0400
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:45512
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934247AbeCSPyZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 02/97] i40iw: Correct Q1/XF object count
 equation
Thread-Topic: [PATCH AUTOSEL for 4.14 02/97] i40iw: Correct Q1/XF object count
 equation
Thread-Index: AQHTv5qMtGbfTtwfm0mn7STgs0AvTQ==
Date: Mon, 19 Mar 2018 15:54:23 +0000
Message-ID: <20180319155411.12348-2-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:oOPYI6NjhrqKjsFvCeQLf2jZsr0qtUmTk/AEc6+0M704NJtpGdHqxC/MF6oq8uN0IP9sAjNnKuXZiwsnASZXFjAsryZp3J+2Z4b2YRKGmvu4NmthgBvPjjN1aJF7t6Rcv4sHwn87z9K5ma03r3gz262w45GbbFcoF1/SHHDcfHVjXopXCS9xaTGphaSz5e2RKSwH5nuX3rM8Hkqcu3C0Dxg3MHFjxyK1dDk0sG7z3sY+udKFbg+Y4uJoU7FhxdQb;20:QRpvDLV25TJM36At77zkd8RfICVrIYN1YvGrilEseqoyzTLyajtN3vgDTLcDe/v8JoVz9nx8710PGcPO1w8rGSwb52pNfIWmLjx3CaxEn7Mhi8KuP99qSRVnDWBpQWPEi7u+0E9bXl5MP8FOeJY7CZ+cJinYx+0P+v1vC1eaS/k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efb1612a-5e89-4d80-e553-08d58db1af51
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08069E16D49D1A15501D7167FBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(102836004)(6506007)(53936002)(86362001)(575784001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Zl94YwQHIIi8g4TE8cA6iLiPlSQQ2tAVKUzV+W+HjwZHrgUeOs8ojy8G1My/2gnFvdCgu6kSoJe84mb+5aW0IhevmrSKK6FOdIV3jSoKfq6d9a0T/T0JlpzDt9meyZSY5h9QTy1AdfKByfKSlEQCn++KXWZvYii73qO6/d/pBk4+WtjK0V45W2IhLz1ivTAMhp1zMdrctCDW32o7BhhHN2UtSU2JRbUxhlY0HRFE71JvlAwcAKvlsJ/6WHb+XpfRGehIQjCroF7l6pPzHsg6Yqj/aqP6WHsmyIzgxUA8AwwloDEIVLJFDcpk9MizeQ8LYjgYsg7hvhLTONdNCcsxOg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb1612a-5e89-4d80-e553-08d58db1af51
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:23.1229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit fe99afd1febd74e0ef1fed7e3283f09effe1f4f0 ]

Lower Inbound RDMA Read Queue (Q1) object count by a factor of 2
as it is incorrectly doubled. Also, round up Q1 and Transmit FIFO (XF)
object count to power of 2 to satisfy hardware requirement.

Fixes: 86dbcd0f12e9 ("i40iw: add file to handle cqp calls")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/=
hw/i40iw/i40iw_ctrl.c
index d86f3e670804..472ef4d6e858 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -3875,8 +3875,10 @@ enum i40iw_status_code i40iw_config_fpm_values(struc=
t i40iw_sc_dev *dev, u32 qp_
 		hmc_info->hmc_obj[I40IW_HMC_IW_APBVT_ENTRY].cnt =3D 1;
 		hmc_info->hmc_obj[I40IW_HMC_IW_MR].cnt =3D mrwanted;
=20
-		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt =3D I40IW_MAX_WQ_ENTRIES * qpwant=
ed;
-		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt =3D 4 * I40IW_MAX_IRD_SIZE * qpwa=
nted;
+		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt =3D
+			roundup_pow_of_two(I40IW_MAX_WQ_ENTRIES * qpwanted);
+		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt =3D
+			roundup_pow_of_two(2 * I40IW_MAX_IRD_SIZE * qpwanted);
 		hmc_info->hmc_obj[I40IW_HMC_IW_XFFL].cnt =3D
 			hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt / hmc_fpm_misc->xf_block_size;
 		hmc_info->hmc_obj[I40IW_HMC_IW_Q1FL].cnt =3D
--=20
2.14.1
