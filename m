Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238885-2-2314170173022831215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238884; b=DUJFGLmWZChHnhjdnAoGHC9yBPQVhVqL07nHHxyEfvvO7Q7Ccl
    sgniaGc8/dyK7pcJ+mC1GKJzm9Mevnn7yKH9YxYmafZRRS3KRX5YMP4NEc4gWXWP
    utsHmy9YG//hxG/LzzkpKH+8NPCb3p0Xhnz5O6eNRkzSJhYzg7FDP5nAzXvv5YUW
    RJmazxC9uM//Fx1GFWmcgenUhwnAWTL+yUt0njbtDUyXPDqfBdOfriOtq4lyj3/+
    U8jn2IXQIlbapYwlSCMVpD9BDY6dF75oht8ez4rZOSwX8iQYfNAju8mfzIsmaQK3
    oGPW6l4g5gcc0iyTMZXL6FxCmVGPjob3OE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238884; bh=lZkZnSeEV2
    aBth0eJSdVps7Xao5y4q9K+ndwh9cWYTg=; b=DaB6MihV5v2biOBPiTKqK2Q46K
    zOKGXLphJSZLHgn75/iFKfdczGqrsL3vm/F1yL1j3WZ7/VTcBcR7sZvgsfuk74z/
    YbRHB9np24GwQjJ3IBoTGbVEnp9tGk6NkhTPDld4k6COOnocj0FC/G8N61mFy5OC
    q/8LD2elUC2WtmasJ7SWsXecSAs93gzq/lQpgfMjK9RwEy2GunF3CMmPnZ29zvgt
    MaNzyrUkh4KAks5T13eKHipn01A73x8gnFzH7j7Yrke8iL7u/6typ3uBX70adkqI
    3uuA/Y0oS4h/hiznKaS9z79bdGGS2PwlQumeU5QN7tVM/d4XHOFCnQOqS9yg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DguCHVoV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DguCHVoV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLwug5idwPNk9VYjPbY5V+Krxwd+z9M3+Gqbt3YyBwO9Pps29n8Xd7GEvpV4SEIyEPFBJsPaDW+NClUVM13HeIfMNDdeGuIaZpKE/DrhAB6ejJeFLwQ6
    RqlOsrZFNtA02ILU9hQU9DEQm7nGfWU6L6K58fyQ1wir1k4CBTKsDT3+/ZNPyu8Xx5UvuGOokPyuemh3mApOiqqQivc+6Wm7EpbTuUJ1M3cuMcNEy5ClMbpg
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=1EsaE_6oAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=1vR2FzZSdyBwo_47p4gA:9 a=dteP5O-kDf-mquxc:21
    a=g6DQjF21BmwqRxgD:21 a=wPNLvfGTeEIA:10 a=3ZumFrijQQ-2J9H5h8ct:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932134AbeDIBy3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:54:29 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932271AbeDIAdM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "weiyongjun (A)" <weiyongjun1@huawei.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 235/293] mac80211_hwsim: fix possible memory
 leak in hwsim_new_radio_nl()
Thread-Topic: [PATCH AUTOSEL for 4.9 235/293] mac80211_hwsim: fix possible
 memory leak in hwsim_new_radio_nl()
Thread-Index: AQHTz5lT+ZTea2Sa/E6IaCyaZAmXDw==
Date: Mon, 9 Apr 2018 00:25:56 +0000
Message-ID: <20180409002239.163177-235-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:Iflv/tUW2lQSACcg+Ye4+6ru5qWdCFQkpaBCYUy/xfzt1fQQhTqVRwkLmY3uu6IlO8DoIK2F9pjSlsONs7sbsHZ1l5LbgTw5NVWwI1BfVuxVejiBwBHN2brTfXyM6bXFczHG05j2vPS/S3bdztRWF/an/BqNzH1Me5ftXawloMSQY6IZgLLHMChVtSBV3JnKKnFBUq11kqDoy9AVffIRYMRwlnk3vbLUKxfUOkJQLWKEk81UaKvcFfFqttuL0Sr+;20:KB6oSQnN3sI7BTt67fszCRW4CP+wOSjJcAhYzckyj0xGrAVbnrdCD+fdK2Yee0XIL7wgHOTkMFi6uIUv7VPeiA9Ug8YNLR6QRR6vUJ2A0NKawHUhR7eTZcGfHXG6xwce/4d/TT/1pfrw/GNg7IvmNkhWFrHZcBkHUK9I1thgKtc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0554e8fb-42b1-468d-f0d8-08d59db176c0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09026CD6E73D6FEEB68DFADFFBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fBvI6nezYOZTNVlckek+hv04DzKBJ9PH/ZkY2nZktE7ZFpHrZ9et65V9Euiile5M8OI0dWBwXUL0ENR92PAje18nAkXev+oID/3jFhyFGK6FvIJG8F/dBqGDNH4rotofd+5aZyBwwhbg2OCHoTxSDAr9ZW1hQNBciOhsoNjTe60DZnFEr4nTGM467kRhBIk+JR5D91zx5CaOk31XlNadm12v7z6R5Tgup+jhvxi4sN7ji++RkoIHYzyHcgSQ1n4kMJa7TLh/6r+Qc5fYkMY0lbc783GzJvt328CSHiw26GlNtuEnq79xVs0+s2A2jN7aofXtRK9X8jSwetJz7MzXVGhhxMMpoQ0Tb4ezqB3AEXABVkJMEQLLxmI42zgSCqoi9zyuYumwsnfeYmT6f6mpXGW4DMKUUwot6wDfTP8QYAg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0554e8fb-42b1-468d-f0d8-08d59db176c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:56.8317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "weiyongjun (A)" <weiyongjun1@huawei.com>

[ Upstream commit 0ddcff49b672239dda94d70d0fcf50317a9f4b51 ]

'hwname' is malloced in hwsim_new_radio_nl() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: ff4dd73dd2b4 ("mac80211_hwsim: check HWSIM_ATTR_RADIO_NAME length")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index 4182c3775a72..eb6a145d2ed6 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3084,8 +3084,10 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, s=
truct genl_info *info)
 	if (info->attrs[HWSIM_ATTR_REG_CUSTOM_REG]) {
 		u32 idx =3D nla_get_u32(info->attrs[HWSIM_ATTR_REG_CUSTOM_REG]);
=20
-		if (idx >=3D ARRAY_SIZE(hwsim_world_regdom_custom))
+		if (idx >=3D ARRAY_SIZE(hwsim_world_regdom_custom)) {
+			kfree(hwname);
 			return -EINVAL;
+		}
 		param.regd =3D hwsim_world_regdom_custom[idx];
 	}
=20
--=20
2.15.1
