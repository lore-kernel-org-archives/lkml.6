Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELv/oTiqcBl3ZUMDT8pi6TjlcVPuuZpYV+x0yUc4wdwn+rdZ9Qy4/TE6v0Ny3/3e3fvNLZNj
ARC-Seal: i=1; a=rsa-sha256; t=1520116096; cv=none;
        d=google.com; s=arc-20160816;
        b=nrwcDvlOpEK9JREajpq/QKrzkfD008XioK2X1Y00ZhledFfWtGqxIXrpxsi4mhXB2R
         lUuY4YDpvFsFriAxnuf2v2y+JOCEIOR3CewWYPX9cBr6K0/9Ls20d6GvptvpYHOjdINS
         CuYN6Ob76jLkI2rA5snQnDwAJ7RnW01rOjfxTToqMPs/YONR3D7ZQDJ5UCitONUatHxh
         HPSPnNxU8BLKIhwnG6zt/KX3TkGgp3M+3A4qdsNkcv1fnKYfju+iV7YT0mcDzx9lNThR
         oWU1dqjqBINPVpD1JdqGvTvRASysJ/gzzaNzs1/V+T/7XsgLrdGif3GsesDKGQhlSdzX
         OqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=nPlzdUbNcLxbKVX7yMVCoDfdNpUhVeQzRza/eJ+1P2E=;
        b=H5Dd0Sqnmqm9ITZRFRBiRtVMjIrOJuHcQ5yD+drXl9ERGY51DPvr+yHTA3b4juR/bq
         iaS3C/MJ1Cg82ZA4b/cd6ULPkJTKS63EF4oq1ezKUnkARVH6JfpbSVq3uLiNnuVk5JM9
         sDlwJhy4NcVBf8IGkpihj+tvFW7V3gcxNsjJINIACRT943Jk8/yk9uxEZNr6NB56ngpE
         O+3chEkMEpZ6m9TxWeBruTBHAVbTkcVJqIP86FSVPxywhkMHTI1ff3Plrl8B5dg/uGOP
         eYycAJWaoOXnAsBg2JKpn57TQ+1TnTLaCe7lG60jfjqOAEidbpru95kymTnKNGewqsnC
         hIOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=l5eC9tAQ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.94 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=l5eC9tAQ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.94 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 18/84] test_firmware: fix setting old custom
 fw path back on exit
Thread-Topic: [PATCH AUTOSEL for 4.14 18/84] test_firmware: fix setting old
 custom fw path back on exit
Thread-Index: AQHTsz6htXrq6Piduku50mF4d1DxCA==
Date: Sat, 3 Mar 2018 22:26:10 +0000
Message-ID: <20180303222518.26271-18-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:qn2SyaOqT6IcQG1XNKEpYTz8pEzgQF6Xj7rO4hfLjM2m01n6O+w4c3lIZCky1VsCvbCIm05WAtg+lQ9TbhxZUvHiV6ME5bGmS2pQZHWAQRa4Yd12Zkr3mQvrDG5RN4nbi6+MjSlucJYwcDq1LahTAsqxGdO3vhq0fQtLiATI+MOZgaypOURu4xfX7EXCfiuC0R2gfW1WCWOIBCq4CDSlK2sSY7xhrX2C6rpZ+qwsWvqJnkKtcXnLpudgdamufQ5L
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 133a3464-8cf0-45d0-2f62-08d581560cc9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06F8EC40BBFD757E058662FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ZBPZ3YcJ6LpFaFB21p2wTx/+4x6/NKDsuZhcZmNWqbZ0D9/rze7xQs4YoEBa9cgdUUs/ZSgt8XbJRKB6wJSYrHf6jIgeV8frVzM+7cNAln4CzxxKo26GnKB8ildDvmtvK1JCKBEwVGPBM3iIeqvJPMzP+rngJOxT41yzk6VkbXI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133a3464-8cf0-45d0-2f62-08d581560cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:10.4473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957039179445581?=
X-GMAIL-MSGID: =?utf-8?q?1593957256400022630?=
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
index 62f2d6f54929..13ade39fe832 100755
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
