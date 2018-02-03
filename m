Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517682940-2-12529886803289235515
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
    t=1517682939; b=fzA+lo0FliR7opjT5+AGzTyZFKz/xyFZTEgeukh0jsWTZ53
    /oYeHn1YVgU3XBNkkxt10qaBV0iw/QWdvMm0z3XfyomABuGRlA43nfFvtkInUOV+
    l1vy94vP1QmzSOojstQKukbGKtDsJvrpukVjI0rWRxh5th2rN4mE8XtOt8/+FXQq
    0ezUWaGFqaRAFy3onAXT0kFp+CmXQgUYNlXAv9yDAnnFe9xXfdHsdij6U/54mA51
    9QvQAvejyeWK3eXe2jV/lXkvssVPbYWgUmXZTzCfGCdo2b/a42iT14acDaJJFJ6F
    +pobrhvvS/brCogA+ZEfThGJM7ziuYA6MCBm4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682939; bh=pQYTa5
    4LEx0aI41ujyIyAuYmbklIJNmo5BKSeExzDvg=; b=eCWZML+Y8CxcipHL+QsOv0
    HYUL5PTKtjpuftQU3xjIABLq070Kv49a/RrFE2+IfKI8UcA6w1pzNGY+6ozFYcW6
    QrBm8rtpkr098I5ty0zH8jsN5AiN/GCuqalezuOB9kRCzNYUWc5slpb+P9pdxeGe
    SlEgepOfqw7WljiUOhRo2eAZs0J2pHJCVX7sSRjdeBf5sSzf505R9OT9Tp2nHvT+
    xQ3bBRAr3IpAmeeITvKQxrY2YO1PHeAmWlD5sJBOAZ0alrPSdQjsbWhKVD/Muw6A
    gkCe0cKRTYLvypCiRN3eaDTahruXGlcJgYqzN0eVFySEpTTpCHtb5P8uN9FHg73g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D4VLmAov x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D4VLmAov x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeBCSff (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:35:35 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53867
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753254AbeBCSDq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hao Chen <flank3rsky@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 087/110] nl80211: Check for the required
 netlink attribute presence
Thread-Topic: [PATCH AUTOSEL for 4.14 087/110] nl80211: Check for the required
 netlink attribute presence
Thread-Index: AQHTnRkBwUdZONWnUkWXayVe2sGL5g==
Date: Sat, 3 Feb 2018 18:01:24 +0000
Message-ID: <20180203180015.29073-87-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;6:mdK227OdsN/VFM5m4gH6wyYc+TzG4twfQNKlPE/LHro2LQ8oki6zP+J6VFMxlNJKxx+R8Z4MzemgPBIpArNVkGE0snLZfOecbJ51cGaqpAXPRSlyA2dCrAqEuvbamzih5lzuJb297o1OAnSF3XeoPT2AL5vXVtVv7vWNbaZPsFEc52N4bZFRUU6JP10V8WAc4m/DASr1g959XXlQmqUJSl3aBcv10uJxAsXgzxHFVr54OPK2xsAemRcg0klXivWAmssnf5NyOQQlyFTSoknkQ24TffHVPYEN9gnFk6nhn6HF+KV2XWU5ajeg09jfYlBNFJa3uZIH0tpmROa7TxQPZYC7Y3YSE5nCaS4yzqOaSD94Ydh6gvJ4xcog+7ujPbtn;5:4ujEsGyAug0SCAJoiyQLO8hdY2qywEQ2om+qPFMm0mJ2APPdbqrMh37XqnEQB1/QO4J/BpYVSPhI9OPskwqWUBiryVWP9hPbMD0fUTAD5R8D0bvX5NyQkSXfKc4HdVZTw6+tQPk5pvIFSxPSBbYtZSj3VamGuQs4B3PwkdKufEQ=;24:HdBdXiwpvsakB0rc0HjkLskjBt6TuhyGPiKz0loZ9KbDnI2GOReQN9WTqtu8LGST3SGfhRW+KDdBN6R2fEj/+Eggr053YG5RTWmxfmhzT8M=;7:FJm284e20PKZt+61tQa/OZED4tnPESjB7bj5QVXG7O15r7ZCTR6K3vEC996IhR1xSseRc95PkwvRghv5swpIc5HjoV1jJ/oYpwVuw/QffV1g3rD5KanymI0IvqM5f5RWDxq+Gkwg0qBrS6+UDJd0rJIh0V8FRLn3YV836nlcEmmz0389/gHhvT+qq6l1Ko8rTIvpfKbad/WjReyNYjYHzUDabjz6w+SbEdp99SNaHK0Q1SuwYhCceBio5xOGJEtA
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4605fbe-eae6-4fa3-f4ef-08d56b3041a2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB10416FE260A054B98304DA73FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(39060400002)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: nhYz8gUWZMoJ4VDyFqnXtJ0WEkl0tUiD3/YXzUF+FxwzRTkTsYySLnEQ7k8xxsRVzBvIZYEcEDuz90a6TF/nXw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4605fbe-eae6-4fa3-f4ef-08d56b3041a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:24.4721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
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
index d396cb61a280..93837c1b49eb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11298,7 +11298,8 @@ static int nl80211_nan_add_func(struct sk_buff *skb=
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
