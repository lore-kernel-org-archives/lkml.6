Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485266-2-6621314828449522400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485266; b=BVWLuv02fu4ezer+tgk/XLrByiIkWU5kR0hoHYnXNYFIZgz
    ccJoJusvPIcrojbCd3tNgVQmXZiOo/2j1WbXBr3i4uf1xMNnL3BL4xg/SBsxpInV
    S4/s/tfB+f4tPFeT8BS4y71myH/kIrTcktNKMa0F6h+74xlsGuM39lnnTgesYvsy
    OaaLqBUxn7sZe6tcQ1qH6gQPfiVrclY+uqfNaYNajIYqv2boQpXR2/A/l+2BZJK7
    okNlJmE1lbr13QV7K0q/wtyzW0W6+rt+oglJ8P3Do0Lmem34O+G/vmDAI6+XFcIG
    ZmW4cPv8p7j66sptdb+kttB4Nl7sU7zMm0Oqbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485266; bh=lHk85s
    HffHCNw0uNYnhPWCcUZlFv3qsX4BsY+5zA4Yg=; b=VURiEaXN4gQZCtvRcqbP1/
    7769CthpUbMD2n9dWfkdwVeEDTEBd5HNjHGGBQTH5A5wKMXs6eGh2wEIVqWudGRP
    w/MiO2Z15rtEtJ/XbiQmw4hOFyN2XEQ2YOT6tDJRQkRrPPrw/I40iyQB9KD82bDm
    O8wjMvqavPeXlv2hQqcEYUWKJ/ML4pC4cNvo4fyDP5AbFv4S+Cd5dHdQMoNdHZ2u
    e0Lb/AoW85juJY33Rg/qcaOFj7gTsZphR5LFzpAspz+7+nrKW028GeqeUiq/9Xjo
    imH2vgEJhZzIG8ZBK8S8oDbK3LMclWrUXLm+XFe2EiSuhyQcvCYZJL6QhQgQXEHQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fnhsFlZs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fnhsFlZs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965610AbeCHFBB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:01 -0500
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:45238
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965212AbeCHFA4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 051/190] mwifiex: don't leak 'chan_stats' on
 reset
Thread-Topic: [PATCH AUTOSEL for 4.9 051/190] mwifiex: don't leak 'chan_stats'
 on reset
Thread-Index: AQHTtpo0tpHvz18hAUO73THKFqVYwQ==
Date: Thu, 8 Mar 2018 04:59:14 +0000
Message-ID: <20180308045810.8041-51-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:1c4KMSdMIF0LvElMH/sTvgKccN1XW3Y4nkcMMh7l7ADM++JujR+0hwjNAn4aKDddWVXdC4xXFO38bBPS3T6ks1a+vnsE1qxIuGUbrBU1s6oyeaY+HDdOc/OrT8PRSzr75rciWm41JcoVU85NzO1Q/FeYIOT5xHUW/P2RmGveCFnaRGJWdcM6q3SPwcl7gYQvhcbiBIHo1iTmIgVm8M5oad15Jb4ODsirxqyDam7H2J+aMlSNIunSjJl7QOIG9d7r;20:JRBJY2k8ZMtePQssi2a1eouwTexk8kGh3p3Exr3+0Wqliu6/Lqk0Jecb/i93YuJfNpRjWbgKmtxvrYE9Pj1BR6r+IrEEgCv5zRguOcjTp1KEVEp7VsDD4D6rhbRhO+AmwZwF2UhgHJfjmObL81e+k/le9qPp5QHvqVBYEwlzRlA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f75e802f-e0df-4762-da62-08d584b18ce1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11098626EA12863CE9317B22FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(575784001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: V5jMAOlX4Zongp8y2+fWnbDgz/zDAygtAGWLt8G/JCMLDLxaFpdDa2BexmDPkX3AOMNKuUUukNyx4daR7VSAeOUf8hspUnSbrKnBwtDr/iBzMOyuiacc2V9V755ylpVgBif1Ax9UHagK6RIYM3jBqIxUc5e7APgqfi/U8ydsMuW/argHdwT/RlkEwa8fh92u084XJbC3qQtCsN+YfsBcaPIcfFiGDIKddTpfD2KIzCAky2z8i5F6iYPXAFQAF0TNhNopLqCefPWD9A5sO/F7zk8ddfH0XOtg7X2hXkWgGupnfOD0ZZHACKPxDQySRN8BTf557GnKI51cLKkRh//Atw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75e802f-e0df-4762-da62-08d584b18ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:14.1919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit fb9e67bee3ab7111513130c516ffe378d885c0d0 ]

'chan_stats' is (re)allocated in _mwifiex_fw_dpc() ->
mwifiex_init_channel_scan_gap(), which is called whenever the device is
initialized -- at probe or at reset.

But we only free it in we completely unregister the adapter, meaning we
leak a copy of it during every reset.

Let's free it in the shutdown / removal paths instead (and in the
error-handling path), to avoid the leak.

Ideally, we can eventually unify much of mwifiex_shutdown_sw() and
mwifiex_remove_card() (way too much copy-and-paste) to reduce the burden
on bugfixes like this. But that's work for tomorrow.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wire=
less/marvell/mwifiex/main.c
index 2478ccd6f2d9..1e36f11831a9 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -146,7 +146,6 @@ static int mwifiex_unregister(struct mwifiex_adapter *a=
dapter)
=20
 	kfree(adapter->regd);
=20
-	vfree(adapter->chan_stats);
 	kfree(adapter);
 	return 0;
 }
@@ -636,6 +635,7 @@ static void mwifiex_fw_dpc(const struct firmware *firmw=
are, void *context)
 	goto done;
=20
 err_add_intf:
+	vfree(adapter->chan_stats);
 	wiphy_unregister(adapter->wiphy);
 	wiphy_free(adapter->wiphy);
 err_init_fw:
@@ -1429,6 +1429,7 @@ mwifiex_shutdown_sw(struct mwifiex_adapter *adapter, =
struct semaphore *sem)
 			mwifiex_del_virtual_intf(adapter->wiphy, &priv->wdev);
 		rtnl_unlock();
 	}
+	vfree(adapter->chan_stats);
=20
 	up(sem);
 exit_sem_err:
@@ -1729,6 +1730,7 @@ int mwifiex_remove_card(struct mwifiex_adapter *adapt=
er, struct semaphore *sem)
 			mwifiex_del_virtual_intf(adapter->wiphy, &priv->wdev);
 		rtnl_unlock();
 	}
+	vfree(adapter->chan_stats);
=20
 	wiphy_unregister(adapter->wiphy);
 	wiphy_free(adapter->wiphy);
--=20
2.14.1
