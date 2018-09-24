Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D35EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B36D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HuSlCCD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B36D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeIXVBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:01:37 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:31232
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730217AbeIXUwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ5pdyB9LjokPRg8DiAuYSujECh4qEj+Gmv2nx2rTP0=;
 b=HuSlCCD/PNe5D+ggCHCvKrXIQLlbS4aACJbdIkK0JnhiVs/00dzwGyTUtwCTzZijDe8jkWDYhSjDx7Pm0SaO6bwVWQTmHS623pf23szDpq/59ruOzIaRAQDg6mGx87TNt9/kLxYMef7nck8MrdYkrR/asZVxh07H0sVOIDKn3Bs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 02/36] mac80211_hwsim: require at least one
 channel
Thread-Topic: [PATCH AUTOSEL 4.14 02/36] mac80211_hwsim: require at least one
 channel
Thread-Index: AQHUVBW3GBBuOUxlG0aHDbado0igEw==
Date:   Mon, 24 Sep 2018 14:48:55 +0000
Message-ID: <20180924144851.164533-2-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:dZIKEusGhqmyNBajQTHLjd5EYLAMXG3gf0FjZ/EiQoslnA4DNolngF3M0MtCivxvrABuImltZ5TyjeuPtvRC0yVGtQGyeF3uszMuDDVUNEf3NliW9EVwLHdMyC1BQDvv82WuIxyH830ZYWQub3Lli9o2VcS85gM7/7KMxDpJGj4hq6qltPJxuXUjekyEpxvjrwuqrLzuy7k7MRhsNfCKNoIwbrqifXJPjzJEDwx8P2+JbiaiBNhfpxTQtDnYCfi2SybOencRLMcCDISkKtrdisk0yLFO/pfvssr+hfv9rcdXgBzmwiwZXUiXpad60U6zle2a3LVoH/2jqrncpYmwrNSdwSi5mtrKmLbgL1qpza3PHfqtjvBNzQZzFsEPpQJHxmiwSGv/8qWdJ4dhwN1++o6K8DLz3k1dn+VjLR2d5Ea6MYCMlGL8q1VfXyqn64KeDWTiomGItJ7C1omCbz1iVw==;5:Qnpka/CCGD5cRpGGt298WH64BqBNvHD3Xa+QxxDHImvSpWlPSaIei+gOSlNJfyaEfQ0ZDMJbHA0GqhX8y8K8cLIKnfUSfiVnt094SlwK2D+YM7BrpMhPmLvykt73vwvc+VfNF31UJF2uOLIU7vfSSwJTqrIXQ74zEUquire1+us=;7:AM+Kwed5lgG8yZCNtgYjvmfiVFffG2uMYpVjN9+u3OSb3VpRR/ESoIrJNaZKKw7/GCDSItrWEEUg2UghUzo3ekZiFI73LT59ikebQYWbSEaSeuTVIoh+LIm0Mgwddk5yXHg+6SMxvKhCdzhQqBSL6XVazMColgI+JLa/8181zhrfesFbs470fWpPpC5C02FOskZGOaCfsHu3POEpC9lcNyILyC9OMIahpLg0pH6S9JHeL08Zib6yuLzHHAWIL2yH
x-ms-office365-filtering-correlation-id: cc21b088-b63b-4617-7beb-08d6222cf48f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04700188216E60BA0D385F0DFB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(575784001)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P7HAfOS4g9gjy8vxMje6KzLo8Bxc0K+mFQlyubnMUutLOksYoV5llmNImP2TmcSheIbz4HHNgITg72rIvu3xGiBVOImkrejKB6WTHx1u+jHoa3md8hv5NS6UrV4kvdYUoz3/tD0mZjbIeXww5irtUCAhaZqqKNh+mrQndtwAH86vqCZ3LVY8C0sTr1Qs/G7syO6Zu29uss0iS15WMGJJG3qvNzf/REu8BhM0wNN6L4jnw8YfnvFUUVbAWIsbn+DJWTyGLE8dLGS03qw8ScUOKbLiKbNBkpKQtIk28y8UdPdME0aAQSVTrpbZP9qkPMjf4lgxANaPLgSBiMB1oNW0nb1HzaP/MJbrL5ucyy+CM7o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc21b088-b63b-4617-7beb-08d6222cf48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:55.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 484004339d4514fde425f6e8a9f6a6cc979bb0c3 ]

Syzbot continues to try to create mac80211_hwsim radios, and
manages to pass parameters that are later checked with WARN_ON
in cfg80211 - catch another one in hwsim directly.

Reported-by: syzbot+2a12f11c306afe871c1f@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index d686ba10fecc..62fcf57e2299 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3124,6 +3124,11 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, s=
truct genl_info *info)
 	if (info->attrs[HWSIM_ATTR_CHANNELS])
 		param.channels =3D nla_get_u32(info->attrs[HWSIM_ATTR_CHANNELS]);
=20
+	if (param.channels < 1) {
+		GENL_SET_ERR_MSG(info, "must have at least one channel");
+		return -EINVAL;
+	}
+
 	if (param.channels > CFG80211_MAX_NUM_DIFFERENT_CHANNELS) {
 		GENL_SET_ERR_MSG(info, "too many channels specified");
 		return -EINVAL;
--=20
2.17.1
