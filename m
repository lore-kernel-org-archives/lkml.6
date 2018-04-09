Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236446-2-13535459525134041565
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
    1523236446; b=EeYPD6NkFB+T1C1N2cGEt98aP6A8pjQ99G+9ZD54OrVvfZZlF8
    /wwx3c+GnOwQjEnxZM4rbmGwqc4K0zL1+dNsrzOuevP8zTnsWmuXjYrqdN66YqfK
    8r4FBZ3ID06NWzIuH8LlfAcWK7Rxg2vObOCcWCnfuY5VOLilSahmBekujP75vg+h
    ypIOY4S9UbgzIFg6HcNS+pXmq9H5Yu/FEWx9vwYyaqfPMWbRBZOWLJCcNEi/EEUJ
    aO6iunwjmHdPPy22zB54TCB+dwy9CNq280+NOlyS4UgRvu6IExsrg/sOdwOAeSpg
    bXQE/m+lDHePC6PVsoUK8/evtrXQ0oMCdPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236446; bh=lZkvwL77nw
    wZcR82IjsreHZuEI7WNumqwzfHjBw7Hgs=; b=QWSkRiu0B85vvrx0bOhBgbKA3m
    /Hha00m58MU7ioAMPWNI0S4OtkBMI05STCHjYcCcI0ywNXoVroHLujuQYGSPKX8+
    rJEubX8B4vg5HInNO43yBpgw7kV5J08eQrJJnOxYKEDoTGoOoPLBKjk4XRgXmstY
    78WCzONnmEO1BgkFiM0/byHA0zHzPSMz9dPZKQclkrWFiURj+RvX/YOOd+xxhTwE
    JW12n44Y5KcS9vri/P5r7Pb9pgks+inMTH3KK7j3KOnbhbqHOJ35oUuubbfLZFg3
    xBq7EqQFqBnh889PKhiOyOizPtzU4jg1NVNLMr2cBYEMEcUocr/Yk0Cf9+NQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OtZ6BVzv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OtZ6BVzv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMxIDZG47Mgl8bLDnpOUVJu7uAlHhmWYR/vkQr+oBNIyAFwaszFbwz0M/e/bMAeWOiCT6/9I4vlOmrmeYnOxSOx6rgLvN4LNtYiiXRcpGaU5o1SMvx65
    pB65gUEZBouarABstCib8MYoXD2voC8o7izZob+6CY70YSPhVUs6WMkrv2jeQ/eEda5GTwy6/I+tNyAgQYa4ApmscLWDBtZfU3hRVw6suWh0vrQrMSZwRhhJ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=1EsaE_6oAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=1vR2FzZSdyBwo_47p4gA:9 a=dteP5O-kDf-mquxc:21
    a=LdMjILow4WDEMZA0:21 a=wPNLvfGTeEIA:10 a=3ZumFrijQQ-2J9H5h8ct:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeDIBNm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:13:42 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755517AbeDIAif (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "weiyongjun (A)" <weiyongjun1@huawei.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 123/162] mac80211_hwsim: fix possible memory
 leak in hwsim_new_radio_nl()
Thread-Topic: [PATCH AUTOSEL for 4.4 123/162] mac80211_hwsim: fix possible
 memory leak in hwsim_new_radio_nl()
Thread-Index: AQHTz5nNsfbD5/ppNkCA/Ssp7rn4WQ==
Date: Mon, 9 Apr 2018 00:29:20 +0000
Message-ID: <20180409002738.163941-123-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:aYgFl4acohxLGL+dn8Ct0r2leQNHcWmadKM0o+ycwmLkk5aP1nQIMSfTiEPKoaJcsdJsC+0awQaB/huz1IdmwdZ4nZ9lSTMV7fwYFseYIS2c6uEOHqV12XxSH4IsMvgt/IxkYq2/CGRVYh+3HrnMMX/sk+b/MHFtDjRGgMVb8TIKZuBOjg4eyKdVeUlz9VT5pQIuixB6b21m1Lbr+Ncrr7yTG0tRNWckW2h2J0L3tumGEhyMuMB1iTw7CD3UBpad;20:gT8/TfqzknAJ59XUc42nLheGnKJ6gC4bI1sE8kWGVgQWFPb3jOFtT8Yve+2iT05p2eudfHvO7kC+38NT2orauA52bSWSdhjMCSKIYe3du5yejcbe5RHDdz/1egjBRPGsSv+j7TvAf2AfGYkgDjswMcCSxincQObdlAZv8ApxgXc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03ceb711-f323-4e9c-9c5e-08d59db2389f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10950FB67E1168C0DEFB38E9FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(575784001)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: OKZ77YgeKiXXx4bVV2L9jGU/yJw1Shkb4tivSXfZwcrdyHvw0rNwIEHIgCPNMaGtajV7wOhrzhpgiif/HWSjPpuUxrdKd4Ewsixmjz34leSJcHfAQ4WJLylMAFbAlrqCQN41hV6SyzYc/YbxK2Tnl3eP74/BxAU0hLmwjAZTPmxd/eqoBMsMFY1E9ETWPTvHIuA8MZx/Xck2FO2gON5NnF/yWc0UzZCI64MEY80Jwwj+181mhAaQKFJMcpJpejM0EH5fO+UnrowqtgDHLjfB8Yts2RM2xnaATOClNwexB72LKKdT6eY6/O5c5ocBf3w7BYuiXxO7RUY7ycbzd6AY5ZrPK6dJTQjG1fgtwkSPmavmerczad/WKTPaRYXPYvZ3fNEW2R27cr8MWMyTMRW0GdOsTkh9zUHew4ciY6CyNxc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ceb711-f323-4e9c-9c5e-08d59db2389f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:20.4274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index 8a9164da6c50..e8b770a95f7a 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2925,8 +2925,10 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, s=
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
