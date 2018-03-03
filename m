Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELv4gqLgoSCfRui7n4a7DIFWcRRAIWFO8iE0KKTI8W+DwId/WtaynK8UTUDAChXfLz+laMug
ARC-Seal: i=1; a=rsa-sha256; t=1520116814; cv=none;
        d=google.com; s=arc-20160816;
        b=HTftwlCp6e//elViMs5j4CtAB+aqvEtwbAaU1csVhLgdrefbavkEuBuWHV6Bq58Dqn
         pBr2INRycW7jg/f6RfOWs+2ympLeWM6c9lT0/bFqffzzmmQ3itipHcsQd1NS2XGgNQif
         Q22/v2u6mtYbrFNCpRQ3QgSmXVrt8LrJzUM0kFR/2usPAf5NiJu/9JwzUmVbg9p+SDWt
         ItT37JDiuyLMXWW6j3BxpAoeZneQZb3WEuIfGAl2i/aA+tIByDj87v1f0nDgpBzjk2fM
         Ju6Sv3fgz6gUkfn97IF+8yNm5CkbzoZFbUQDfpEA1hVGz6zfjjoKBhmjEdDMsVIN9gF8
         aI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=82OIpGLuekXB9LpfnUN/WN8Jy3He6shny6b6bQjdCNU=;
        b=HMu8vCu3SmXCgJ1UUO+oXSrzt8DoOnRBuhlDwchcYHsE+fzpD6pGKZbga31Z9703fi
         tzhkAXQFiwZRKUkUy2vM37rSSaoQjKyJ6ADPqadDcYupWG8MtqUcYzv2jQOiGCiJNpCn
         ldPTpXQLMmmOYZz9VaB7fICGuxJAPB6NZ6VyKCmO1n+/h3iONUIkFqUJr99a/X7CyXF0
         FmgnbLYHkjDHXSiPWF/8TJF1y8bZgd4bDHgK9Do9dLvDx5GEnnXCslfrMaVFRHWkPcX6
         IHnoBdhoKgmWa8CpBrVS/kb5QSBlan20qKVe9dmb8UN9m/X8sLDYFj0H99nAuDUcW+w1
         hjKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=aIZtrtwt;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.123 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=aIZtrtwt;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.123 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 090/115] test_firmware: fix setting old custom
 fw path back on exit
Thread-Topic: [PATCH AUTOSEL for 4.4 090/115] test_firmware: fix setting old
 custom fw path back on exit
Thread-Index: AQHTsz9oXfdZssGVXk6ECeEmDp+0QQ==
Date: Sat, 3 Mar 2018 22:31:43 +0000
Message-ID: <20180303223010.27106-90-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:g5V4fW+oH6h0xMt8CGbFXGuzh+PPfytapQ55jaCbbP0C8q//lLhTe+Grpk97Pq0iZpPkix+k44hydgRs3CIhIwmhjbdoZqSFpNNB6rz1iHw4CFC0OvE+qIaZj5l8warO1Zn52vjbMLGrN1YulA/Kl1ZbXyf+LIWOk8Mgvbsmw7trGZAcVDSnHmdF/bXQZ4uRHOIb0XbokX92gX2PEiaU18cZ8xxXGYLVohksxRtbN81o5hbx3psJg4lYwaxx2PfD
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f17ce085-4a21-4082-3732-08d58157b9c7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0939FD6D4FD2208BFF278A1AFBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(6666003)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: y9bvVkFiCGz3eZpYRkxnYbm1YQmHzgHWqitXq3mgpTJrOffXb8olMMLY2m/fRPhTtH1MnXmUVosDoMAL4dkn2wbCsjVbgToQWmNpY/5ajShi4/e0s1vX9bns8f7li2yKfR3pAMYH1eq+6UuwkeAJGOClS0LDxJe8V/E7iN+HhUk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17ce085-4a21-4082-3732-08d58157b9c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:43.5114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957039179445581?=
X-GMAIL-MSGID: =?utf-8?q?1593958009098333985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

[ Upstream commit 65c79230576873b312c3599479c1e42355c9f349 ]

The file /sys/module/firmware_class/parameters/path can be used
to set a custom firmware path. The fw_filesystem.sh script creates
a temporary directory to add a test firmware file to be used during
testing, in order for this to work it uses the custom path syfs file
and it was supposed to reset back the file on execution exit. The
script failed to do this due to a typo, it was using OLD_PATH instead
of OLD_FWPATH, since its inception since v3.17.

Its not as easy to just keep the old setting, it turns out that
resetting an empty setting won't actually do what we want, we need
to check if it was empty and set an empty space.

Without this we end up having the temporary path always set after
we run these tests.

Fixes: 0a8adf58475 ("test: add firmware_class loader test")
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/firmware/fw_filesystem.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/test=
ing/selftests/firmware/fw_filesystem.sh
index 856a1f327b3f..61f9b1dbbd9b 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -28,7 +28,10 @@ test_finish()
 	if [ "$HAS_FW_LOADER_USER_HELPER" =3D "yes" ]; then
 		echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
 	fi
-	echo -n "$OLD_PATH" >/sys/module/firmware_class/parameters/path
+	if [ "$OLD_FWPATH" =3D "" ]; then
+		OLD_FWPATH=3D" "
+	fi
+	echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
 	rm -f "$FW"
 	rmdir "$FWPATH"
 }
--=20
2.14.1
