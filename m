Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488537-2-16756979800921031147
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
    t=1520488536; b=h0whSiVtMFYCRrSkAUMWW7WojRJQVvciy16cHR4IQDNcYeA
    VjXIOI80YZz6uFM5gXzMHn7P7SUUptovfOiYipsXLtrcX2POCM3J7D01KxNAMmCv
    aqkh8sYHYEorwJ0oXGqStkcOidkgjYnGTwXiiHWpgRNaS06l6RNbHNyGbHRAkxUv
    FpiSxEbXiUctd0z5mOIuU+pwwrtrtyL+rOppN31VqaELwm03QS9u5IFms9xZWJDP
    C3mzka1eyZhHLzsuwyeBzOh3E/dPK3LwRRV0AkTAEQ3D3RwdtG2BVsMnXfq0UEUm
    5qq0WcHPGdWGnv3Xik5gBRujkBwQ8hwFi4s0HQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488536; bh=dKF+F1
    z+Ns72/GrMw9rlhOLXVXBjWN9dwGOZr+koKqI=; b=McKHZlBfW9TSmePdz4f+4i
    YwX/AOPcQQCoUJDN9xk76OOUtjvUBfA//Px/okIg8taafgX9gmu0zHs2VSIswqY/
    Xv5tE508kMJYsVznIWtDAlbWOlMGGQq4a3BKUO5QOKc3ZgHEFxSwlArx1Oka8/Hs
    SXsS0ktAu1SxQV1L/ZKywPv0jvQKvPksnKHflihphMnvp78+KP0BY5+2VflENPwa
    CMl831629776qxjjSKKvgzs9KFBx6wIVreMkVnKRqAhVPVPz08C4oSUUzzjVDmYM
    Lr8cAa1p61MpF77ObRzNhKPQpakPLVB82PP+OuNLbYdVPESfFoJXz9ImF7E5xbEQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fG2fyDH5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fG2fyDH5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965655AbeCHFzc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:55:32 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:45512
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755336AbeCHFD5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 152/190] Bluetooth: hci_qca: Avoid setup
 failure on missing rampatch
Thread-Topic: [PATCH AUTOSEL for 4.9 152/190] Bluetooth: hci_qca: Avoid setup
 failure on missing rampatch
Thread-Index: AQHTtppPwAPiQSIrL0uKK9ekny2Glw==
Date: Thu, 8 Mar 2018 04:59:59 +0000
Message-ID: <20180308045810.8041-152-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:r7cWPKu6f4Xt9WqbwIHWEUoj1X3CtiTuwWxKoL9SNlbtHZCkJWBBP8tlR04pa5CsNGLawPUNsNigcwGl1uKe9qF0Z8F5wbLw9BcFZ3s2UoKqWe80y+WHf3wEbw55C3xD4Vl0HC540pSw9xEtcNNab8sxX1cIroDhQIlJmEEUF/hZMDKtMMOTYXzUDYGS/HV8alfuhzI2IcKz40KWHQK2I6WszdFMQ6EPXsSteS/FYNwQabzf4qm3yiBPsoFyc+Ne;20:zMgvyND/pyX37Qb1RbO3pZBw+Q723Jjh/aPRy7+g22UDoaNKbo8VK8ejq1jHSA1eZf9F6+3VcR17ZBUPRUUu8C0Xu4mOZl9fi1bG3SdvEUexnnvlPJbGjUryic4GCIq1T27d/UFjMZ1vmR/EdtgH4PnFvARQT8z41SnaQvJrtwM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 335ed3aa-2ffd-48e5-f7c4-08d584b1fda5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090220B8DE30A5BA9E8B363CFBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: BlOaXy9AYk8NRpviluHk4GEcgmSxxq8kveJEhNALpu9WdhmybAXOWGg1m7PcEz087IYIm2ovoOkYQzzCP3Vhm5T0vi/J0vKqy+mRAxPgrRS/cJ7wyEMZ2YkbqntigZFd9mD+F9gV6wNj2efbfsjSbMq6DMhLyxjF9bwbOOwjagUhzH+JPZVPHWPt4JM9PH5h++pMZ3Qaj9xgx09zQSWysIhKjoCpDmLVyyQ8N1fM7hhwXkDzeQb2SM4NoGNHC/uFWyYGtQMt/hhRYUErMEhbMPd+TNZKrRwZQEMZwPOU6pfDqvI7JyxfiMx7zX8n4N/Rc8TtwfdRpG+E0vnTuvT4xw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335ed3aa-2ffd-48e5-f7c4-08d584b1fda5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:59.4720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit ba8f3597900291a93604643017fff66a14546015 ]

Assuming that the original code idea was to enable in-band sleeping
only if the setup_rome method returns succes and run in 'standard'
mode otherwise, we should not return setup_rome return value which
makes qca_setup fail if no rampatch/nvm file found.

This fixes BT issue on the dragonboard-820C p4 which includes the
following QCA controller:
hci0: Product:0x00000008
hci0: Patch  :0x00000111
hci0: ROM    :0x00000302
hci0: SOC    :0x00000044

Since there is no rampatch for this controller revision, just make
it work as is.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 6c867fbc56a7..74b2f4a14643 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -936,6 +936,9 @@ static int qca_setup(struct hci_uart *hu)
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
+	} else if (ret =3D=3D -ENOENT) {
+		/* No patch/nvm-config found, run with original fw/config */
+		ret =3D 0;
 	}
=20
 	/* Setup bdaddr */
--=20
2.14.1
