Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239525-2-12984116504686116568
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
    1523239525; b=rfD6EkANIDU9CFy4lpPMJv+u1R6s0eqx2PWy6xqutP65b3t7Jt
    vUh6daTNgK/B2vB8ng5cvhGCYhqo10VEEMtD/511C/PkyBM5p7Zc+znk8AI5CqSy
    Sanx9QOASRe6MzXzhRuSHCimwDWjSAM69AGahSztY6MWYxPUN0Xo8bRMroJcafyu
    tz7VJHAjKKvxpR40x+UqLLpHrAk8rVyoQ7ZgV0bN1H4GrKNphGbYJrEA2hJ/ZKyI
    o+wL9tRuLXEMGnl3l8SSVLFRn7LsEgMLFCRwy2UB2zv24S8R77ywzybM7Wfd2m53
    xFhNiQMUbsRKarP6y5FJZiJjSpxGPHvjz3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239525; bh=s3uelvErmi
    b4GIAJO95YZIXEpckOmgYDxQFj2vxWWYk=; b=ZBL7taUAc5TdEhri3jkqS82yHs
    Z60un6KHMmTAzRigmnr2tw54RQuZfDNzWi2QXCWSncKsY6g8WmwCNQwyOgmnvkdl
    86zAcSElLQvxzPE1xhs1fIASFaeDnUuPVPRQBpkjWw1E31h05Jb9FsIxS/jOaVmg
    S+XU0AgPPo/0iZYkqEzIQz9BHoEHdeg0nxy8z9mDpFfgYOQLDlZ+8r03CAh9M75p
    cscqnwZYq8rdNvyzK4TPEDL6LsD7g/282aOq1sNKa5ap5MJ/Gr1kCbUBGK1I3ZOn
    dVaVZkOit0XFWavfKiBgNK0CWm8yzajaypnCipgmLJjWH51ou2eXaXmHvEAA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h3BxY9gA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h3BxY9gA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFd8lybkJT0mLJpH/FpP0Fy+ciUkHtIqsomMA6ytO+/6a/8//F5oxwwk3mYdPu4CL91HCdUr5siUxcDq39tX6YDRaUgVwJ6FDluLButDthdCMzoS+HD6
    Tpx6bbvo62YhJpU50D79xwSbyDokdB7IpXwGGZj5zFsKh0Ay5svQ189eQDsc3sN9sxZdrLlw0eFgBs0n3/9j5XHJOs98EJSE9W3cGV0msv099/LgmMMZUy80
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=smfoY8MmjOmHQ3ktMiUA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757762AbeDICFU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:05:20 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:32931
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756362AbeDIAb7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 184/293] iwlwifi: mvm: don't mess the SNAP
 header in TSO for non-QoS packets
Thread-Topic: [PATCH AUTOSEL for 4.9 184/293] iwlwifi: mvm: don't mess the
 SNAP header in TSO for non-QoS packets
Thread-Index: AQHTz5k86K2aOSuVRUa4vC5jHRSVlw==
Date: Mon, 9 Apr 2018 00:25:18 +0000
Message-ID: <20180409002239.163177-184-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:Sxk6P5UpvG5ESakHGIMacmbecKkXw+naXuLfP/ilKK4gC2Fkl3XRwmiQCWq6PoK1I1fhxEru04iIyVbGLjbk5YuHG4cvP6djh0YPFcCJBZ6fTD2HsV9qH4VzbRH+B00tLyhu2HzhZt2fKdXIKOX5cKt0Hl02wCasbQeKLwEYOJ5xKxxfRm9L4tTULNFLiQHBAzIZZMRua9BXu906n2rCXMkrVo77jiL1vTEeepRZ7rkUKcbm4EDgFTmM+oACohCt;20:PL4mhSBUVhPH7EfkAMH0OBQPC+LFOmnG1oA+/x9/UeDGa2FGeSX4m51KpMra+/nYPIF46mLaQwXlh3S9eBPejL8428jrw6C10iJEkoJ1ZThDBzbppueoMExM+kJjoBsOXnKHkpbhcxygk4USN70scUmu8mafm/+nfHk8RztTus0=
X-MS-Office365-Filtering-Correlation-Id: 68e2910b-bf1d-4740-874c-08d59db14d1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112660AB66982A12ABB2A566FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: i5F9F+JgCyjBEdP1cvjsJeeWH12HEovBqssLmxDzSLoZFJPjJfz071QbnOpwi+XVIL+Ushi/esw0UVH7JCdUKbT0xMmc+LTkhv/jRKMSRSCe9/a8S5IZ5LnutksQM71EIQzpPTFuVXtg7fCr/uTZpq7PhC1IILbIey+nMMV40RUhFNXLKuswwxFjgQgqnR7PR5GHqsOhorRFo65ZvYaPDwOkkT0ZbSY9MD9xnSC6aVgqbqWhlVfMRjl5Log8nP6iIA2PCLTtKXHChT/U9dFZmxc7kvB0o378WpOb5PkhOEy7azrEXRQNjJD1QtVvP+AhO6gElMaYp2olnZzp9G76vEjX9AZTqW43zbV6rro6Wj4z/a8WXL+9kSkJq3uPN0tJ7xyAcqHSn4RHeIetoIl4Y+AW6L0lYTlpO0zS+Fzar20=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e2910b-bf1d-4740-874c-08d59db14d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:18.1126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 6344436e9d3f4fb4878c12169477d4beb5b825ea ]

When we get large sends on non-QoS association, we had a
bug that mangled the SNAP header. Fix that.

Fixes: a6d5e32f247c ("iwlwifi: mvm: send large SKBs to the transport")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wire=
less/intel/iwlwifi/mvm/tx.c
index 790952e48262..5dfd6a775e2b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -786,11 +786,13 @@ segment:
 		if (tcp_payload_len > mss) {
 			skb_shinfo(tmp)->gso_size =3D mss;
 		} else {
-			qc =3D ieee80211_get_qos_ctl((void *)tmp->data);
+			if (ieee80211_is_data_qos(hdr->frame_control)) {
+				qc =3D ieee80211_get_qos_ctl((void *)tmp->data);
=20
-			if (ipv4)
-				ip_send_check(ip_hdr(tmp));
-			*qc &=3D ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+				if (ipv4)
+					ip_send_check(ip_hdr(tmp));
+				*qc &=3D ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+			}
 			skb_shinfo(tmp)->gso_size =3D 0;
 		}
=20
--=20
2.15.1
