Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490207-2-7741552807973852845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490206; b=JLUdh6JVmTQLVcYQOTojgyxNLMy7RiPCWHPWfjdrBF4iA7i
    SGdnLpFtGkSOSQhqaNGi1gyGwg03Orn4ZY2QVVPU4eL8ZsRudMJ2GdSHjYMXVr16
    fZ/tilrtp2lTv3fvDOzfhc0AqaH8WZs2JX8cL7lkrb9vnHVnaReYEED5USMB9fzx
    TblGcLC4W6i+9nkaneZwJIABQw6Kzr2AAzL622c+jzwmEVK1cLoaJEvxfCWYAyHh
    uoMluCciv4dcYhNVTqx3jEKPO0FZuRiY3qp8QbdvsHv2vVtPLd31991+WSIMTsn+
    0gwBnjzHX86l04bhEtxDSv39kIH/CPGXb4e3AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490206; bh=nVqFvg
    FW+7fOS6TOXZ3LjiRliSRmGQRcitTKlxdGPak=; b=u+QTiuuJrwos0xYWA0oHxo
    9WXn9eno0WfCFWyGzK6RAFB6f+wVNrCb9PDwr18u1eefCv8bt4cH/nht0C7SFKEr
    L/BRHpmP/8LVe3IpVuaxvTf//Bo1O7NusBgs0iJW7JaizBFJau3FnnuTHvxFdGjB
    T+PATg3lY1FGkL7f/ggi2Jpl1nLqYFBcTi0z3niRtElkJ4W68IQaRPsS9UFOaGFf
    lvu7CfxaHHhfSmBmpn3JC8MTCBkpLYYzXw1I1wnUyhYByWjvKRoQgsWLq1XTAZME
    5ZAmS8G1BEHnITDs8xJW7RK1VkZIhs/T6W1v3yQCKm5mBAI2sqr1zzMHEaW7M5Jg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ffNTLU0L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ffNTLU0L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935415AbeCHGWa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:22:30 -0500
Received: from mail-co1nam03hn0228.outbound.protection.outlook.com ([104.47.40.228]:52768
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935397AbeCHFAp (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liad Kaufman <liad.kaufman@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 048/190] iwlwifi: a000: fix memory offsets and
 lengths
Thread-Topic: [PATCH AUTOSEL for 4.9 048/190] iwlwifi: a000: fix memory
 offsets and lengths
Thread-Index: AQHTtpozT7leODWb4UuQ0N0ihZaZ6Q==
Date: Thu, 8 Mar 2018 04:59:12 +0000
Message-ID: <20180308045810.8041-48-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:aKtfV2v6G5vyqvokkAh4YVKQFLUXNxuJM7OuIS7oyXiJv3GKzyDvz3XJM+ZInGSV5QhQszUj5vHMp2oJtWsnnnLeE2YHCtql8KJ3CjGI10NwenXFawYLxdxfbi/AhNGZUlw5vt7OFEKi/FpiJl98v6Btsy4mOhZFweraSRsDUryRXr5trggtENXeq0twWlvc5Izl76Qe1ToycrgpjtWhU13joG0zHbVxI2z8+0YUps0a3KOrolgkeJMgeDRfjGDz;20:xzz2eyord6OFct4MN8YUU6ucXBxfPPNJrtSaWAlfc9TL3LffLn6iYBgwXjjJOU0TihAhW6VbfdEuoB4sS7o7EpwByJVmPN3pVrN/CV/4A/G6FkhT94JQVPr6Ps5cIMhfi+IopWaoL9ebv5ecytd7XKir43FAzac0mLXDV9nOFa4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bb2bfcc-ba88-41b5-9440-08d584b18c25
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109DAC593C150ADD0ED0589FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(575784001)(4326008)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(129583001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Dr1U3xXfVRxUjUPOdH4PCQwSqk5SCDMnR+/I8MWNOnlBdjkit1cgflfph0xHZ9FIyMXJuXP7RNxCRpS6VS41eeM6lY3W/epZLC3v3o2lFn0x6JSIFWDP9/jzJXyaWWJDldCRNX5YoYdRlvgNyLMcImPFHB2uYOvPb9jIQuUHnZd4QpFa+0Uib3Oyx6nIfLFZJI+IDYnbxF3V9qVQK0PdwlLlFp/KY9LkF2yZsHqYUzxf5BMydADmNMN4Wjycjedqy+Ng6GX37L9r0NlulqMexd6+kj+k/0/jH4zGKaMJcXdXoBBfPhL0nPWDdlyFa7hBbglyxWu05Cn2Ex2vvidsqw+HMwBPgH5sdUWQVh3yEAm4lQMFYwurj4JufjM8XXYY26Lhms2Sg7Kb7wuFxezrbQ==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb2bfcc-ba88-41b5-9440-08d584b18c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:12.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liad Kaufman <liad.kaufman@intel.com>

[ Upstream commit f4d1047914ea05e0f8393944da18f6ee5dad24c4 ]

Memory offsets and lengths for A000 HW is different
than currently specified.

Fixes: e34d975e40ff ("iwlwifi: Add a000 HW family support")
Signed-off-by: Liad Kaufman <liad.kaufman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-a000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-a000.c b/drivers/net/wi=
reless/intel/iwlwifi/iwl-a000.c
index ea1618525878..e267377edbe7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-a000.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-a000.c
@@ -65,12 +65,12 @@
 #define IWL_A000_TX_POWER_VERSION	0xffff /* meaningless */
=20
 /* Memory offsets and lengths */
-#define IWL_A000_DCCM_OFFSET		0x800000
-#define IWL_A000_DCCM_LEN		0x18000
+#define IWL_A000_DCCM_OFFSET		0x800000 /* LMAC1 */
+#define IWL_A000_DCCM_LEN		0x10000 /* LMAC1 */
 #define IWL_A000_DCCM2_OFFSET		0x880000
 #define IWL_A000_DCCM2_LEN		0x8000
 #define IWL_A000_SMEM_OFFSET		0x400000
-#define IWL_A000_SMEM_LEN		0x68000
+#define IWL_A000_SMEM_LEN		0xD0000
=20
 #define IWL_A000_FW_PRE "iwlwifi-Qu-a0-jf-b0-"
 #define IWL_A000_MODULE_FIRMWARE(api) \
--=20
2.14.1
