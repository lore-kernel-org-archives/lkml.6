Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482452-2-4795939949436834182
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
    t=1521482451; b=aYMvWB1/xpP0gcHkEZnLHpr/GI6PkQx9pD+qGXecH0qQjYs
    AaKXpw/L5uG3V3LENJ0qdn0WCiZuuwUSzhxbloRufYYu8CTBtZbd++Fs+ZcmNBHY
    iodI6SmzHdpFx5ukuHXY1WEYc6sPpfXyl82vL7snIwbu7SZswLieK4RLO7Oy1JlX
    AisVNHugK1PlxxiI2yHqkOitcQrMDQ4dMLjZ8ZmMVI3HNcGeDoiwlN22O52biI+6
    uef9VzfxRhKKsnPG0l9bR+PsU6UkNA04jE6rWqG3YYz+KGeiS0556hsmv2/i7/0G
    tXytfE7ze0n+KNSSmV4I9EajRvGD53GFZYb2uZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482451; bh=DxC2bG
    HWuW5QZTP0NpibWrQ9zHrEKakEpHs+WolDH3Y=; b=idqOdHM9uX2rLxWvxpvd8e
    iCpSLdoGx/zRRcVqM6BCAmyNQCPAkH9Vej9mqhF1Zkzt+wrKtlP9dCaQISi0hWzx
    GIuyvT9fFd9Jji7MhUSudlg6gzh0rhx8RxQOYx5Mqo+xT1f/Htkeshsj00KpUx+7
    nBdRZja4Bg4sxHtQl7WqW2jGkTgC0ogYDOiReCglG4OabpO6Ln565XeX0Dbeu2tx
    ngmCAvMpegDxaRt/s02qJZuAWj03ab8M6qQBZYvmaSwYH90QqV+9ghB6vwRbSbPs
    kAqI+IjPja8IRv2hN+ejh14QGTk1R2sNqhVYFzP6fkPgcAxMycZDX4Z9tFQbAH7g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S00IpRnk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeegjeenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S00IpRnk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeegjeenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965684AbeCSSAV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:00:21 -0400
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:26624
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935070AbeCSQEP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 204/281] iwlwifi: mvm: Fix command queue
 number on d0i3 flow
Thread-Topic: [PATCH AUTOSEL for 4.9 204/281] iwlwifi: mvm: Fix command queue
 number on d0i3 flow
Thread-Index: AQHTv5ua4tK62F5tK0O4nNIYrlXG9Q==
Date: Mon, 19 Mar 2018 16:01:55 +0000
Message-ID: <20180319155742.13731-204-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:LRObUylRTNpcirW0Vw48RelPvcnG9oI+okTxZajBFxubq2OJdX0mdK5Hcc9Ns15KeJT731zVRHzk6lVQDcEN+77rWsg/2UOlVXQyEQikgk4f4OM0QHEw6GiFFoxeFBG12f8f6Co9dOM37nb+qqKYtDKak1LRQl8DZ3rUbbjig+691oltrHos7qzdNQh8PZG8MkFQr6MMsM0G75OTxVWR5/fdcWLwAt9l+L/iF9Y9BhopHbOIBFd5mEVTMODB2O7e;20:Er9LiSzpEOO93Bk+L/tRXej+YMfFQ5AYnJ4IkdHFpaY+t76rwnWdKrLCp5TyzT4URH+MIBnMM1nAXNEFnFI8HxWDzHxlYihTwEF0k/d4ZDxp35B1sRbvpZlj7syAq/A85djd71Y10I6oEVRm3e+lDzvl+sA0iYnnjo47s86uI+M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc89a0ef-148f-4b73-637b-08d58db30712
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727AD6FA2739264DD4CF3F1FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: bjg5sCeez9YAROgkKt2CUoZ9o4aGbDMwGoh02mhrESTZOr8VyLMzujsmRPbFPKnAg0UML4sSuv8EKYPMnx4GCiJsYO8e1E6xXSC5al5coz8lqxPPtrGZHv4ErA8G0EJr/waZHmQfOLw8kDHVf9HUhjhhZq5Dux5MMq0fZxt12KUG34es9OZxCBeVAAKfGhfM4Q9qpm9zOCT9z/1ZIeql11LqoFN87DmgcBcBITi/+lvrsWX9uZcH9Id9BjKqMazGTxT1nkRbTxV6vXUOlg65Yz266vpXyCL4zqQl3Mb9a4MITxrZZpAEwoTMlk5Hcdy8QjhkPgbI1XTc1Zj2EZ3AVA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc89a0ef-148f-4b73-637b-08d58db30712
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:55.5306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

[ Upstream commit c72c37b7f392ad7edc10b6092fa48c632ba6f4ed ]

During d0i3 flow we flush all the queue except from the command queue.
Currently, in this flow the command queue is hard coded to 9.
In DQA the command queue number has changed from 9 to 0.
Fix that.

This fixes a problem in runtime PM resume flow.

Fixes: 097129c9e625 ("iwlwifi: mvm: move cmd queue to be #0 in dqa mode")
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wir=
eless/intel/iwlwifi/mvm/mvm.h
index ed9bf8c759b4..2b1c691bb4b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1666,8 +1666,11 @@ int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 =
sta_id, u8 minq, u8 maxq);
  */
 static inline u32 iwl_mvm_flushable_queues(struct iwl_mvm *mvm)
 {
+	u32 cmd_queue =3D iwl_mvm_is_dqa_supported(mvm) ? IWL_MVM_DQA_CMD_QUEUE :
+		IWL_MVM_CMD_QUEUE;
+
 	return ((BIT(mvm->cfg->base_params->num_of_queues) - 1) &
-		~BIT(IWL_MVM_CMD_QUEUE));
+		~BIT(cmd_queue));
 }
=20
 static inline
--=20
2.14.1
