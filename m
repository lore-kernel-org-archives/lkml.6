Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtaKbiyopEJwdiJrrBLSAD5Ct41TQNgzkSuriRTIMKQK2slgcXe81Gdv8FkzawP+mlv17tV
ARC-Seal: i=1; a=rsa-sha256; t=1520115890; cv=none;
        d=google.com; s=arc-20160816;
        b=sc58ylQvimODH4caJloojyaP/ck7ulYUvPqxtNW2EkMIPsxPK/nbFdyheERkQ28rnh
         c6qj/YyBoSoH019i/jOobA2FMTWqcVI7Fm1W+SwiRqcpXaBk3XqLPP33ExF9mam7GC/I
         gXf5D21/gAR23dibXWjJgF383MQM87sEfUmHNFlnqFxiPCzTUOpHBhStWPbDblczyizu
         1G8spBTAIlWB6FRwcglSug96DkbhBqrFyyFN/5kj0iyBI+P7E/g+iQNsoqHxDKpS11ek
         a+xRCkdDLvBLkc0zPrKC5W3R6zI0prlvt2dNMBdaKkukjILNAdeifhGmNjs4itHddc6+
         Y8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=AypZlyKPqCqeSAxIzQfzu9LA57ng+IAlT3Oy8ze3WC8=;
        b=RENBmU4WDx7pL3IGpCA5JLWAjSmIdVEmpFKb2e1pBPORZQlaCqKSGMlpFYYHcv50Ie
         cFQfAkRWol2vjSBn0bZuNlS5GAeO1sxSgmhKm8ZCeM+M0GTwRL3uhOU/CCsInCDPThJ4
         INPITl6eqUK3y599OfoNMf3VRIZe9V+XNkv3xwFxFxmBDI5zR4gxI6uoQ75pQ8pzsW3T
         7E3skcBqN+tYMYHv0TdB/SUEEINS/3y2U95slPQOlkPW0G1ID4jX7VHsp4EylTWapK84
         zqGlDTK2OvYQuLUJLLXEBfuuqtSY0n2J65d6IV7CvHSNCliiOqnu6AwJy51Gr8uYmsD0
         xQmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LKaMwrPc;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.139 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LKaMwrPc;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.139 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 025/102] test_firmware: fix setting old
 custom fw path back on exit
Thread-Topic: [PATCH AUTOSEL for 4.15 025/102] test_firmware: fix setting old
 custom fw path back on exit
Thread-Index: AQHTsz5iLe38xhoajkep+C+CvuAOng==
Date: Sat, 3 Mar 2018 22:24:23 +0000
Message-ID: <20180303222318.26006-25-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:SBO8XWNWK8w1hLZUdnW+Zgmw9Th2KCFj4kmTtqYSk2y0cEGmnEEgTGjqa2PF/qVYeJxqVG0wDf+76b6/Kba7SIEKD3lA0Wzy9WfBUwJAilG0hUaSBy0oMwAeYt91iRJEgWp2Gkn1UgIrr7avptVRsG63xa2gLcFSRfpRAIJI7WgCyYiWhK9oRolY2EB7VqhfIml+5PBj2vBMr6pThM5r2vHUsDN/Fi7n2LcZX8jBjB2owTlx8kHh2TQF+eye6HVA
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42762c44-673e-42a8-0fba-08d58155930b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09703AAEC68E5CB21CF954C6FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: /ljmAwy4Ut/fA/xJyuKPJz8PLZshQtDEPNaF0Rnc+26iAlke9H5DiteCwD9+LTVpcrboQjXpLt384ya+YYKKKIubAt8MLAOT/96gowRcPG75rMWm+roPV9QEAaZA9yjXqVXC/WhZd1NdMWZEoCh+bnDZsf++42Tnc4bRPQd4SH0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42762c44-673e-42a8-0fba-08d58155930b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:23.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957039179445581?=
X-GMAIL-MSGID: =?utf-8?q?1593957039179445581?=
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
index b1f20fef36c7..f9508e1a4058 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -45,7 +45,10 @@ test_finish()
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
