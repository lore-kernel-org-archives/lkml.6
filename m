Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240266-2-7386666496968355317
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
    1523240265; b=UK9NQJ4O4K4DEuD4FaJ2O/xnx8RDKMKvczOYdeZaGh+nHSv3rU
    k09VxqGwuy2J11J0cwIcTJukCJU9+opIxPwp9g2PEA6gU4DSeQtEwf2qFGz0E+4V
    koEXm8WP3Rz8wIzUqoB2uTlYtNzbs3oI4gNIvwhGxXDjDZRoNzuPiVN8ngXu9Sea
    90+f6AfPNQI8Ttu6yL1nWoUWXpULwozpbVOLrQHUVZfNhVIsiVqjhlf4wso95MiT
    uQe0Ck+cu8yg53dPDVSN4Ng22EXw/n3jETMbgYxRl143c8bSBQXFJXfBNdC1MjCt
    VDeE+55UAeTrCKjXNgRYOGf+EKqQtf1Sa57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240265; bh=VkbKKT/y3U
    bZ3fLghCPU/EjYDJJmsWkEm8L9wZdr4yU=; b=XZY4dQYcvFBXG+rIPwqYBPLVrm
    kibhX/FkdDj0yfgyxncEvQyXbwvdFJNgagKMrV+TL6BBCWosmN79NCYR4Tb0bgi0
    2e2xIkHT6/RWkPqkl/TgQvmN80aWw9XObcDdXBFUUhBseBdhizM7Mgt7lfmmkym9
    ccbvoeTbhxLIKt9ttQbzkWchrjv4QVUpLZfc+EegpSF5A3jjOjSZyg+rtgAqcjYg
    TeaXPjV1x3tKjwwcLTAt34rDipJcMw1U5bGwdbnD4OHNodUqroYpiktCDn2tB0oR
    GOeKBG6/OA6wIbDxYFOoqBsyT1z4Idd7cVcg5QRflH7Gs7LnfJKA/TSBdahA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JG8unQwq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JG8unQwq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIIxkrmw38vLm7EUI/CNOWFsq5g7jq/7UC6U6HYe/eoo9wMQLtLVaIV1d0AwssFOz5jDB0GrswIlTacbH/+SmPEineheWVHOTQnckGswFYB57u7FaX7u
    Jteb21KLpuAMa2d+ZWIt8RN1kqI2NO9poHrVt53DP+4a+S7oP/An1xl5zWP/ROTvKXGVWqF4RB3iJoVsmNpYVfS08lrksGIv9Yt/9rlniT4giH6hHWRgcx/o
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ZdMjq-C-GChI8KKn9W8A:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755657AbeDICRm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:17:42 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756070AbeDIAa0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 132/293] iwlwifi: pcie: fix command completion
 name debug
Thread-Topic: [PATCH AUTOSEL for 4.9 132/293] iwlwifi: pcie: fix command
 completion name debug
Thread-Index: AQHTz5kjGoracPjDlEOOB49y8QJHog==
Date: Mon, 9 Apr 2018 00:24:35 +0000
Message-ID: <20180409002239.163177-132-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:gpVlTQAXyOuNWgtEHij6sQ6Oy7i5ND4+9n48b6SzcNFjAd5KS/tY+IftJzLgsQ5iYbD5OEnhIIGjm9ryJMlvNK+55kzJeP2S93AtgQrGup554sIfOvPB8Z/sfYTGRb7OE+IXC1WkLc5avFYnq3GGJLTW/vV9snbgMpN3TaywPkaqO/4PQuRzLTG640XblzuMbOCJ5QWQW9AOJ2XGZ87pN01DXGa31FYUDACRCQ84ic3Q2HfA8VPY/EA+pTV/XxZE;20:zbAOuiw7+KfCcibECfAkkcm+Af0JJjoxzJ9aI6gj0fCOdem84Sjn0qq4N8IgDIKSH6KR07eElM5QCz5cHatnE81zpBgiAYMKN+4cDJa/FgWlrwUnMnRgND34Vus5W3Cuj+a/9c7GfFFi73XkbBQ7HVeMF8D75Kqa5hoCKD0jE+E=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa0ccf8b-8048-4731-dc3f-08d59db11430
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807D1F85DA096334F45A29DFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: HcnkCeoImUPJsxRJkf0JjkpWkfyT1sQHcbxOSFUcJZ/LT3pwAiupeemYEDL5/VReamhxUoqwhw2yylN2zh1AnlHYAz9+o1GCpz/fMEtwiyouqfYROhNi75SwDFfupXN6GrJdwj/pNvlRCSKwsI0Z9rXIEzBD5/95yPrQeRe7ZfMx8qJ5nwuTKqIqPzlKvuTHA9ElIQs61G7l4h/+JvEq112ddXmA9qdMztfN/DwAsLNFwDcm8mhqXaeMrHQ+gcx4FLMa3DT8uPYox2ShFhou1WKECkJZMyFowA97EO6FMgDLahS0z+Rud+5LEL8M2cW3MDDjUmYnr5u6SmtvnRK3mmrdoOlLB/xPRbbFD7NqqFh9zRdjuOiKAjKPVE/ZuVD460pubclNJuPuS/iPhDgYfUwbPNJtEwVHei4COyO5GHY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0ccf8b-8048-4731-dc3f-08d59db11430
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:35.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d490e09784a9d0a63f831e5f1104b4826e666b0c ]

When the command name is printed on command completion, the wrong
group is used, leading to the wrong name being printed. Fix this
by using the group ID without inappropriately mangling it through
iwl_cmd_groupid() - it's already a u8. Also, while at it, use it
from the same place as the command ID, everything else is just
confusing.

Fixes: ab02165ccec4 ("iwlwifi: add wide firmware command infrastructure for=
 TX")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wir=
eless/intel/iwlwifi/pcie/tx.c
index e1bfc9522cbe..a1f264e0ff74 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1766,7 +1766,7 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 {
 	struct iwl_rx_packet *pkt =3D rxb_addr(rxb);
 	u16 sequence =3D le16_to_cpu(pkt->hdr.sequence);
-	u8 group_id =3D iwl_cmd_groupid(pkt->hdr.group_id);
+	u8 group_id;
 	u32 cmd_id;
 	int txq_id =3D SEQ_TO_QUEUE(sequence);
 	int index =3D SEQ_TO_INDEX(sequence);
@@ -1793,6 +1793,7 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	cmd_index =3D get_cmd_index(txq, index);
 	cmd =3D txq->entries[cmd_index].cmd;
 	meta =3D &txq->entries[cmd_index].meta;
+	group_id =3D cmd->hdr.group_id;
 	cmd_id =3D iwl_cmd_id(cmd->hdr.cmd, group_id, 0);
=20
 	iwl_pcie_tfd_unmap(trans, meta, txq, index);
--=20
2.15.1
