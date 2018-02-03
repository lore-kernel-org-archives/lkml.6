Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682031-2-8736784241317447455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682031; b=CfsAWXZW1SCGLZNe2vy37eLdZ/YZ7futZJxGJkDXMcomw4u
    SAGO9S3NNX9QvLKWsEmlg0hhzJhltUmYWdsvtgmiixEvJQA2aU/mAW/cKF+S1xN9
    4cKEDbJYJ35eFOKinsiyvbha7yBdtaMs6nOF/7VKeA5Q+ztsQLRibkQkycrEayw7
    CRjgcB0pa4mGeVosxvMzffIUxCKlc0IB+r8bkr26Kxny1V0BLnUERAuE2fxVrSwg
    i+vrN+JBZKFgfeTDoKI2tYUT966Qu3oEsnI1XWCpR2jz5xqp8nGMJxgXBC4VzJl+
    YSyHO2sPRvRYkdfibi730TCTKh/D/xTf1Om0AMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682031; bh=fL/GeW
    77PAKJtmFo+bt6DRR5kvsSXUTqmn07lcwWmXU=; b=TnquuHtOrqRMm8Rh/n+YRr
    PWFlVzr9iVLotXmFf5Wgogqkg3hQrwyPkk988QP0K+FjfAg/pPEkK42i+l9y+rTH
    pBo2X2DRRn+MH2ai0Jypsn0KQdmd+oPEWdXyWKecZNBLBShl+oDV10uN6UoGXYkW
    1l5uxHl5oSGKZ0dP6ObFlb/9tNX5H9HIci+fXKg91YIWa1ny3Gc91KwHKxvD3+zM
    Ha9MP1FvJYDSA+x3m2GQ1jDQ8Hpuvk72RjV/zzDozppHoZjUHd9dRxb+Q7NHz+Wg
    GiqvnSIR2qu46g6bJ8OqtpNVrVlwOMvd6Kfco1zgNeFVqdZH7OfR4OSb+6CHnFVg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PwKU6XnK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PwKU6XnK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeBCSU0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:20:26 -0500
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:50832
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753388AbeBCSGm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hao Chen <flank3rsky@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 42/52] nl80211: Check for the required netlink
 attribute presence
Thread-Topic: [PATCH AUTOSEL for 4.9 42/52] nl80211: Check for the required
 netlink attribute presence
Thread-Index: AQHTnRlb6vCSRE9BIku4KmBuQ8AKMQ==
Date: Sat, 3 Feb 2018 18:03:56 +0000
Message-ID: <20180203180303.8490-42-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;6:Z6bH3ssTe2HAunnROZNq6yDWrWvMu9+Rtpd9XRJVXHZHdNWZtCQ+5+S5ljcImKEB05X0o56svN2vu7PArPYTmRKq0/eYP0EfrFY2Fzv4+h05BNkP0F/hM7eqtlDvzD+hdSTs9h0y9pJY+hhBcYQ9ECuNd3UYqhd0GvPD/jiI7IGV29BhrLZMW8/1JTOHuNinIhKQQY7Oiw8Bm1neuO4zR6gwfYB6TQAvDtZ8QbWun5WFQu+tuzvrZrmhEaY2Tyb8ou5s7Mrd/LVFNqSQoG2I48/qBTrD73kHhLMXbuOW3em97OPiJzHUIQnGVuYncgvXM9fxOSmOguOTV8ZkCz2IIw7mVZKwIMKSb7LjICdyX26+O/agaH+WTLupdjfDH3pX;5:LPEYSvOOcS+G3DX70oHgoUYkU2RScWDWQu7BSxrqN8uHe8VL+4JHjVFNfjd+3ZHkWaWPgvTTeHkx2y8veqDNztIg9fLV+Q0jzOBTKENjFa7hcUxnEOHK/o+YxdpGW44s929+fk5CeKCwDZM3KKW4SWrjJ5VwMO+bfU7I7MTZiBM=;24:wucr8oYtVKlP7dkF6OQMttGy1L2taZtznA6cFjDeS3NjlFyzFSBuuqbbGB5zEE9m1tKUaIGgRrsFtggpy2DpiVzECvpjvgDyd4QTj6EVQ6M=;7:scoYx7TqFU14t6ZhaqW1yqKh1DKEhvrVGpJG5X0bH8jrEMEDT0p9a7OAobIpyStfrw+ow7u7pTof1I0zDi4020dLpXGlmfBejJqmIIjWDkerN9vzcDRemmiZryAbO3fk8bGQmZ/E+2kOvUD2YkvIoB9Q3sMLshYZtQbmn0ns0ISwCvjBbV5DtHrc9IRumvbiqFN7DPsaunN5C79ccp9D91gTKKPQ3cUQZvzZH188Ihw83aTXVuJYJp0PVu830Jcw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e56de5e-b82f-4675-2f3b-08d56b30a11b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB101294FD9F09C47CEA697286FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(39060400002)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: n04U+dmBJEMOPN9DYl7E2t+NBzo/vUmxfI3WickXMMsrBkdzSxTwGT8b0CtuubmbUurMiN03btCO4I8YLKchEQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e56de5e-b82f-4675-2f3b-08d56b30a11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:56.6589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hao Chen <flank3rsky@gmail.com>

[ Upstream commit 3ea15452ee85754f70f3b9fa1f23165ef2e77ba7 ]

nl80211_nan_add_func() does not check if the required attribute
NL80211_NAN_FUNC_FOLLOW_UP_DEST is present when processing
NL80211_CMD_ADD_NAN_FUNCTION request. This request can be issued
by users with CAP_NET_ADMIN privilege and may result in NULL dereference
and a system crash. Add a check for the required attribute presence.

Signed-off-by: Hao Chen <flank3rsky@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/wireless/nl80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c626f679e1c8..7dd925d07e1b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10774,7 +10774,8 @@ static int nl80211_nan_add_func(struct sk_buff *skb=
,
 		break;
 	case NL80211_NAN_FUNC_FOLLOW_UP:
 		if (!tb[NL80211_NAN_FUNC_FOLLOW_UP_ID] ||
-		    !tb[NL80211_NAN_FUNC_FOLLOW_UP_REQ_ID]) {
+		    !tb[NL80211_NAN_FUNC_FOLLOW_UP_REQ_ID] ||
+		    !tb[NL80211_NAN_FUNC_FOLLOW_UP_DEST]) {
 			err =3D -EINVAL;
 			goto out;
 		}
--=20
2.11.0
