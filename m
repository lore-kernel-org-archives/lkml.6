Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117877-2-586953819922256414
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117876; b=CdqpguF2OML0RwONmJMzqjA8kPkLNs2v5R6EEMRtFRBP7EU
    Ezbp6wstoctL4+Iwu4QlmZjhH69rBrKdlaygDjdaRcSt4antE5DwPZwIhVWJgqZ+
    1DtTyEExv14cNMPMez84kXv5TEjYiqrU55nN/VnzNwdWfxwTQKacytC9fsy2p32J
    q1NpHWvyKFrFs01nAab6MA7tnc+2RvQdIo3HDGD/NkhVGwnluMWoJQ7Q42QDZCIe
    Hf7KjwMcFq+ubrJXfZ825JcDtWR/hTxDTgudLQatp8hMRnCErIGdGpXR8lBhfJOI
    Ucm9zDKPYbBaZDY2MXHdosvkFXlhNZrD69GVEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117876; bh=MU2+jN
    tIrv+dI1ov2frxHDAX3O15NZFGLfH1cMZcLhc=; b=uDgJ/SgLw9rCnf3wGZScQC
    v1p/RLQvbNdlSDlfflf6xD/aVjjlLPM8xX7jJLrCQxHIPdh0m8YrNMMshHwObvPB
    FIbMfNLQTxH9ZhPCa64pWHZt/JKHj0F7fxH/O8p4lCW95WXxoYdJIHwx6qoWefNK
    wFM377oGtiX2SlN+TTG8hFAO4N7L41px9rJBlDHvIRQySy5tqYQNwZcI7dwte5it
    y/FbpIQJv2vX+9gesyy7aL2P4TAj9wlhrWDciRtdOE22iqL7NFyJw+u+SoSRMvnh
    MDdoKC0YGjvVH8MsCZ7Jdaw7hXCpZ3Nedr/cDea529DGzJ9I+FExCBxPJcqeUQHA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ezbKT+Q1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ezbKT+Q1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935424AbeCCW5t (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:57:49 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935338AbeCCWk4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 112/115] ASoC: nuc900: Fix a loop timeout test
Thread-Topic: [PATCH AUTOSEL for 4.4 112/115] ASoC: nuc900: Fix a loop timeout
 test
Thread-Index: AQHTsz9vBmRrZedEfEqjP4LenWC1TQ==
Date: Sat, 3 Mar 2018 22:31:56 +0000
Message-ID: <20180303223010.27106-112-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:2bYNCfni2HuUYgbqnY/OBoDai4dljR9KCfnm2Xrj98Jse0r1Igi0lHympvtjGfFr4fTUNN2jseycX+owp5JISCdGJJXbhgRuF3BaT+JL2bcdNzP/k2d1uPyZFZhGBMkfqUvDP6+JrCeDaMBYsAh+cXrBGIzwHhhM50DNCVJbVX2NJ6znajsSbYtBlSvK++Wq6YySZR5CwDI1NkQ18S3SQqnHFPRpx+gKqHHnKy2TzWEPqbxwVo+otUJu3y9VQUw6
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f6d6728-7743-443d-b0db-08d58157d207
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344B99146895FCA04B0C2F3FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +hhlbyMYkB7IfTE4Lg6fEuSbzIGqhFcE2TThOiOQlPynBCbMPeDmkxofiVm/R/eRw4Oju/XX6yAh6Pp14iC+Pagt8PEX+UtfahJkjaIy7uR5DxyGbPUf7PbhJsBqW3wVK2wAZMkKFwGsqs4CYbHHRiyzUlpkPuflgWhlqDIjzdY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6d6728-7743-443d-b0db-08d58157d207
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:56.6051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 65a12b3aafed5fc59f4ce41b22b752b1729e6701 ]

We should be finishing the loop with timeout set to zero but because
this is a post-op we finish with timeout =3D=3D -1.

Fixes: 1082e2703a2d ("ASoC: NUC900/audio: add nuc900 audio driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/nuc900/nuc900-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.=
c
index b6615affe571..fde974d52bb2 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -67,7 +67,7 @@ static unsigned short nuc900_ac97_read(struct snd_ac97 *a=
c97,
=20
 	/* polling the AC_R_FINISH */
 	while (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_R_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
=20
 	if (!timeout) {
@@ -121,7 +121,7 @@ static void nuc900_ac97_write(struct snd_ac97 *ac97, un=
signed short reg,
=20
 	/* polling the AC_W_FINISH */
 	while ((AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_W_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
=20
 	if (!timeout)
--=20
2.14.1
