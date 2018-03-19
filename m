Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476658-2-1575860866327591295
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
    t=1521476657; b=aG/QMhAAIxZGQ1zsqp1e0qBRD8AhlHgVluMf0zgr+a6MT7V
    2xPwMiyJIXIUV0avS/VHU2xR/uNOTVrrOBWWIJCKYjdFjoYwiqKQanGkcOSBCVnC
    uFOneNrxDqgFYYbQzjZ/Znn9iD599AnWIhfyqoy5sxKUOyOPhsVctX+EzZtVUTWi
    WclwZin+poIzNKZQOKGFKJvSOeQjJinMrZ8Ulyhv5NBoQUhgYvyrc+vvrLHlR9FL
    o1Gw/Iv2EM47HKOIhDZ848XayKW0ToYYVDg0TwP+2BbL3tI2x4yeuhVe6Hpz8pCG
    zICF7GNdKFmHuQslwq3AJ1kvhubQZreOiPEX43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476657; bh=kNy8kT
    DlpyswzQB8GJVyo7v3GaIBQWo8zZc6k/n2LKY=; b=OzwJllrujwxyHjXCuLbztY
    uLLkaMvAPupJopJyOx4XSnsNbFrQwcxbPezN2JYEXMkNDNHZlWZ1RaE/TAt8BE/D
    JAoMKyRa4CFK/lDdO9rT41wWj+3mue3aaQ9cEdTxwEFzsgUvbuds77qpPAA9QLSe
    XfG91uE/ccLgfDmUKpKx5ifqQuaHosPd4/fSBu3SSlv/R1r3ENWaV/bmxjtpjb6f
    i8pnyqCBtGORQtMtBc12vTIYBY9hHg9jRPZkgUJsEW5KL1xw19jQkFwzUKuQGKOA
    EhjLFt3QS7W2bzqRgDpuzFfy4o3cofAcSnMt2MhRfDI5Uv19hzlzQyyl08vMPqZg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aQrQ8EFz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieelkedunecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aQrQ8EFz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieelkedunecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935452AbeCSQYP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:24:15 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:50448
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966890AbeCSQOH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 072/102] tags: honor COMPILED_SOURCE with
 apart output directory
Thread-Topic: [PATCH AUTOSEL for 3.18 072/102] tags: honor COMPILED_SOURCE
 with apart output directory
Thread-Index: AQHTv50mtHhi4eVAYk6zTlWsQkXZ4w==
Date: Mon, 19 Mar 2018 16:12:59 +0000
Message-ID: <20180319161117.17833-72-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:qGk6rgDyWgLQUmu4T7mtqyj9D0c2dv4t17n1KK4h82WqesVdpm+Nwq3Klyh6Dq8ZHGj7duME5wmj0dnb6KnKwWEIqP/jEilczgTkMqBNax9nyib4OV2mVYkOoOjfbx8eOd3U8Xs5ZpsIjPzwqLwvHU0nIA366MgEQ+P8ne6vIYyINMpBHC6+1jzQNdvYVkWdPxbiXOeAgArAXA3HysE0rVGCdZJ2ov1OHDBVSpNzxYTLGPWOJf+NXlv6w4diD/97;20:oEVIZCjKGkJ2V2+UP9n/ZRhaelnW4obcGLH+dZrvOkQ0WvgyDFcfBS0wJrpfXWFsbZ/af/iIgO1+ZUJbVVMr/Qz3kC2tNSLW4Vnyp4aVtsefYpq8/gju8a+qPS4NLOTtg+zlntFTgdcoyEQAqsafgk/+g6WV40Di3jUmqbmfkXQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bdeed88-ff90-47cc-b67c-08d58db46d29
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063F1AE13BC49F1C8F26BEDFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(575784001)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ghxm3iCLsR6Q98xV8GjWoD4KMFjr6Ds4LZzDrDqrKDHvntp65lXuANNhDNDB+C+OulzUX+WKgAF3z36KYUYmZXGS5EEyXlYDBM2WJTkbshe7wjrkXr2Gpdc7ic7dTXqj5qs8FJqDQCRfnPVfAYGoE+03NIx8+B1fROOVU9Cv51llSLNgkCL3MUv97LbKKsed9v6geJjTm/SLo9PqJpzdOaZ2NnMtHwr1DM0IYgB4auQmqg/Fe373RdHxmWMVrWoAIj9nG+YCPFIIp1r0aSqOWIE6G6M/VegjpWClF2KUKTRppRIpAWBVRIOC+ujcmW+OjNufjhwHoULl87YhphQPkw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdeed88-ff90-47cc-b67c-08d58db46d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:59.9994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robert Jarzmik <robert.jarzmik@free.fr>

[ Upstream commit cbf52a3e6a8a92beec6e0c70abf4111cd8f8faf7 ]

When the kernel is compiled with an "O=3D" argument, the object files are
not in the source tree, but in the build tree.

This patch fixes O=3D build by looking for object files in the build tree.

Fixes: 923e02ecf3f8 ("scripts/tags.sh: Support compiled source")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 scripts/tags.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index cdb491d84503..7056322b53f0 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -106,6 +106,7 @@ all_compiled_sources()
 		case "$i" in
 			*.[cS])
 				j=3D${i/\.[cS]/\.o}
+				j=3D"${j#$tree}"
 				if [ -e $j ]; then
 					echo $i
 				fi
--=20
2.14.1
