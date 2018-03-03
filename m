Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520115857-2-11200037503643693884
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520115856; b=VK7DjfUWi94szgf9EySCsg5rogSZXInzbOcZJUsXx1wShUc
    NVmDjeid4mXHS9JUltyJBVwjy7eskT64OwQM6Y2YtuPfrAMuqTftb4HEAdu80whl
    0KN5S6ijmOMwpbdQTko4QG0QpLoWiKagdQ0j7pD2r+cIQkssThmlySVkmsxVWktT
    EebBuZWc9P5kLYXYrMCVODoJNQJLpAr+qKTtpBsK4oFjLLXDxHDn0qBHgVmvn/r9
    7IUTwQ/dh6b2CCYxe+1gdJHz3XNymOCs/9G05ta6FUx60sX7ioB1lE3amHKCsX8z
    IN6nsGXQjfSoGpLhqFh6NDHNo8TwIZGfHtxOghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520115856; bh=p7M3LIT0ycxquBoVEyX+e50ANE
    MJ1SKe0rYgheSy8TM=; b=qWeuXjKFZJAZEl56J++C9/bIo9Ax3ESxfdPvlQgbVs
    CSSNaluQREd+HGtcFPPBDSQviAovCz4L8TJaIx55LUVJPY4k7/lGskFU1sx5UM32
    aWHCsuRoFw+l5CORBT9dbSR9Cuf8Kog+Qe9Jm0cnlS2QMKEjhyrbEUjGRETI9Y25
    UDhmiU/6+k6fDupKTZZNrjprBbdKz2AP9OOjR15I+/xKLEFZxM/NByf6YVxvWbC7
    zJRncK2Cds261dz7ZMH+MduogMu7Zepia/U6XUGKvq5ucqJoDsrObir0C5X6eMtc
    3oVZYq+/Nf+xJi2e2YagekEOKOewlLwng+6LFR57ja7g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H0QdBkWo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H0QdBkWo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeCCWYM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:24:12 -0500
Received: from mail-co1nam03on0138.outbound.protection.outlook.com ([104.47.40.138]:57624
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752205AbeCCWYL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 001/102] drm/panel: rpi-touchscreen:
 propagate errors in rpi_touchscreen_i2c_read()
Thread-Topic: [PATCH AUTOSEL for 4.15 001/102] drm/panel: rpi-touchscreen:
 propagate errors in rpi_touchscreen_i2c_read()
Thread-Index: AQHTsz5ZOPse6B2JyUyiSVCOfTbF5w==
Date: Sat, 3 Mar 2018 22:24:08 +0000
Message-ID: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;6:/KbBN7f5EEURV10p/jX93uHFbyFvP6PhIh5qgi7LYZ/PtUEn3wAKHGvTKxteyWOEoPY2P+XStU8gxNsdSii3EU2b1JJdXBKzcdKJnS+ntBUDRkIV4XCdnG+kX115l6BpzS82rqxHKwAevSOIC+TfhNH8284KwdsJrtt8PVHk1MMRJobUS9TrdJSgTyJtb7AIGRfTah2y3S13y7lXS8QA/UClBxTEW/5MG5hHOJOi5cgTWhC/bNz1zyfkwvxFS4NvmgtfYApkO6KU1SpPsd9+YlOdZMm0OwW4ljtjirqJ/iQAT7AIAGMt7kt3QDnRj+7jx3HPRDp2aNso/7T5uSNBxBEXSVKMUjk7qtzaQP/Xl/CDMCMGvIeoR3nfJeiU+8Yk;5:rYsduDAVOXxeU2uqRTqKvUecfFtIMh8fV09UA9FWsZymW4jN96mTiC+qdC1YCC+4cFdkemAPv+mbb4QFT/yhpXKCNv/umJ/JkdrYymJ0T4HmoonYeY+OGUPxk0nabMJGKrfUReDDZgxrDBb7GdBRBrCbayF127x4TCrLaXg+h7k=;24:2mA1uXljRWwVAOWwjHcpOc4HsIjy/llagX65eX1wMe661Y+miuS//ROqBk6E9WlLreP9OGO7Th7BAQAQ6lrL5HuvhURaIQTzgf4BFZOT/Ng=;7:Oek3hLKniKY2KtrqqplVCFqk9eZrjqYDL6jkwgc7DUlvWzigcPOlEoI9Ab++UNWXPwg87c1WkC84pEGSNfM2eTAUBtzAut/GBlabf9fUopBLz3xhaFf1jIgCHkuN04AbAKW30V/FG93JHv8DLGK2JOZiALi9sQsxMOOkVH6FmocbCatljwWdqx3vRsDSkLQPiiSw16YQNDCNM5B5jcEGAe84ZaFCLxsibiYc/tGmN+097aXyb+CkTgXVtTNm1qm8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 571b3c06-81e5-4661-e5ee-08d581557bb1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036201EAEA31018F701E87EFBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(6306002)(2501003)(966005)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(25786009)(106356001)(2900100001)(15760500003)(14454004)(54906003)(10090500001)(22906009)(70780200001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: XIzI3qS1Dom7gjc5cdfGEAp/NCDJXIx98OqX1VudFpCD1kG3R1Rc0luDJ9xxbwXrzb+eTGBRbUcUY5MAUfG/4laWz+YYSCEdX4VzYwnMBnkh0A2TJOgV8T0j5Kep9+4kWtKatpwE5ftxrkq0MYtUmW7Bf5ytbHZ8BsvDTpA57BM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571b3c06-81e5-4661-e5ee-08d581557bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:08.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 85b4587f8e94143bafb8b6a4003a5187b9a8753d ]

There is one caller which checks whether rpi_touchscreen_i2c_read()
returns negative error codes.  Currently it can't because negative
error codes are truncated to u8, but that's easy to fix if we change the
type to int.

Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touchs=
creen.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20171020002845.kar2wg7g=
qxg7tzqi@mwanda
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/driver=
s/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 890fd6ff397c..d964d454e4ae 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -221,7 +221,7 @@ static struct rpi_touchscreen *panel_to_ts(struct drm_p=
anel *panel)
 	return container_of(panel, struct rpi_touchscreen, base);
 }
=20
-static u8 rpi_touchscreen_i2c_read(struct rpi_touchscreen *ts, u8 reg)
+static int rpi_touchscreen_i2c_read(struct rpi_touchscreen *ts, u8 reg)
 {
 	return i2c_smbus_read_byte_data(ts->i2c, reg);
 }
--=20
2.14.1
