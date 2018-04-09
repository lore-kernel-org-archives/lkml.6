Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246481-2-13837863605184227184
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
    1523246481; b=vNIrThg0Jk4abPvM9LQJZFz59ufgP0n96G5vEzpG5gzhxBySRh
    2Vj6yTNKyJDOlFh4QW7YXbziwkb6cnQ8jYSBq7Kt7rwbOzQQxqwYwfOzUfSFAu24
    146/hx7irr5S9IHpDLvDN7OEtK9Owz1Ns47TibX7CTnavKl95JUhrDLZiTj8L9Kk
    2c2QnqtAClaRaWJtSaMOxN6gcprHHqvWmf7PWWDcYzzB2XD0YIREVRupR7sMx3O1
    pZ51MTKvxvypHq30FXeWPfLWWfjJaaG5KkeUaQcfjh1iRLzySFalMwhhLVo+RHbb
    lUmbKlG6dgj3q3SZFduxFubpF4Po64OUw8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246481; bh=5YyBx4yDib
    RSQKLsRstvTyMx+ZQ9um4HKCStREksnhU=; b=HZNVWexG/XSmu/rz3UnmyKNSJP
    Rqpuna0FwURcv2cG2l8PqyUwuwCgiB0YrpkMsb5i//IQi7P2NivWR/LCBEIbPOSs
    iFguEne6cHUJdZBLiLpVSF6Ulkqf1pHz1UH04AW7Lpo8SYbx+IQkhx+iTcMhbqXO
    vGiTI6ybMKx1W2xEU9aJGuC8SyRa7zDK4FJ64yU1occY777BMk23+6NgMsV0An0U
    vJoe9yYcx6BoP+zlVuyrwLR/3s7agoSqnTf1AOR6TNZHVELmFFCB6gi9lMnM1PAz
    8zqT9JNCgQ2eOes9T427ykxu+7nyOJ+77nIBNMQSCOmglC7g9ziqqjHiaaZw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nC9/CKfp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nC9/CKfp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLfh/g2861kZJyhW10mi34g24jENVJ+H0rVpBFKsiOIipvKZHMUGQBVPfNm9sdyWVFZ1i7/2TXvfddFDny7wgfYhB07FMbaQIYqAQot3Ru7OvRt9zpp8
    vC/yK6mzoPdCT6av7UaxPrYkFT0/2teqf8a0PyHw/MyBIE0VbKgHTUigunU0O5SwN5TjOhq2EtoW/J7D49hOqCAQlooFjZkn8xSYoMBJv89q/HjRibS3LXHV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=1EsaE_6oAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=1vR2FzZSdyBwo_47p4gA:9 a=dteP5O-kDf-mquxc:21
    a=LdMjILow4WDEMZA0:21 a=wPNLvfGTeEIA:10 a=3ZumFrijQQ-2J9H5h8ct:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeDIASL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:11 -0400
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:43410
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753331AbeDIASD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "weiyongjun (A)" <weiyongjun1@huawei.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 059/189] mac80211_hwsim: fix possible memory
 leak in hwsim_new_radio_nl()
Thread-Topic: [PATCH AUTOSEL for 4.15 059/189] mac80211_hwsim: fix possible
 memory leak in hwsim_new_radio_nl()
Thread-Index: AQHTz5gm0kxe57aJokKZqOLRcPmeDQ==
Date: Mon, 9 Apr 2018 00:17:32 +0000
Message-ID: <20180409001637.162453-59-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:mDk8rtnC7JdgaNqeemVxiHRvTKMlJmdWr8i0MFAWOglKwqduF4ASxrS+Bg6i7aYdvQiWa9MM49G+gNZ8M7eQnyDaqsjidbaHk+BaNl3NhBznsWhra0bSjNHWTPgC1pxBxdpkELR81FygV1/hRSn3c5Ezk2uDHR3jcg5TCPcT11VLflJ4h85T+nGZx0AssEwu93VZ1ia49pfV1UucGvIaPLnNLrCI0pqsHSwHU/hFUW5Rrj2kr/ug7PwXbfYxnQDL;20:jNqj+7vYY0GgxdGqlCdYsflG7sVREeK2tT8RjeljrOkpLhsW3cq4Bw30xfI6Sd7f7TOtLMGWV9mICIMC61izjpQZ9vA/HegP3wA3GeRztPJaGaVBGiFo0fFiDkyKtsz0Rpiqbpdr05qvaK/baXjRNqGpLXzghd7OOw8ykIMi1hQ=
X-MS-Office365-Filtering-Correlation-Id: 57e2f192-add3-4c42-43cd-08d59daf583d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10468C4972D94012601EFE9AFBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(575784001)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bDqdoDGkgZXEs6P5SX/dfpmzJOqwoH2/4IU08cXKGfoXCGCj9NVa/xqvLMto5zbTUvU8UdQ2ilRpKy0O1EvNuD7GpX51bRnUUFl4Miboh6DltDZEEfeFBQ5U2INJ4p8ajJGJPaugfOjuwbCtufpQwQOfsO9VWH8Ii2exSfLAA3g2tiC96Tf4ygrCi9qnK9KK8MkZmFCbhscK0zAtPzN0LzNNEPoX8Zebolqj2QYBs54Hsru0gPHnRtRPPTSSLPL4S82Z7c/gqnONxM6SdWupYJ9RMTSGTETJfsmqHwTI7d8KDJ/QXZ3wAmS9zKodU+kAnP65fXVRkMZeKvopOBAVrxkzlQaM/mJSHw5y4VS0Mf9H+RM+s6uOmvumVY7RouZtHSuG3+Gl+2a7CBsi6kzsRhrN9aeEsEfImUczRqZmiiU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e2f192-add3-4c42-43cd-08d59daf583d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:32.0718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
index 731d59ee6efe..479250bca605 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3155,8 +3155,10 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, s=
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
