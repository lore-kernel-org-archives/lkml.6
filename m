Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELu7ZQzHY8ctcuVh4L1f3OYnx8oSVmemKApuQroFd9ueZbdtCWrTiJTNVPOoDZ1PPW1fmTAT
ARC-Seal: i=1; a=rsa-sha256; t=1520484990; cv=none;
        d=google.com; s=arc-20160816;
        b=0+LnWm+a6s0TcQ1OuhYX7mmTODqYZjJ1rEVNfwoXYEuhED+vtrJim/3AV5B/fv2FzH
         z3WP5jyLS6hMlc1bSFrhHdXj+LV0ZjzGhKOAC5VM/cQ659b3NWYnA0r5fGzJ5NIH/M8R
         /y+whE2aBtsv14BJV2j6D+yBjetXVIIroM82BLVGP+uNroFhklvfHlI4qdfvmpY9xCqJ
         OsOId1ZUMMZ81hQ2Bh4cMALYh5kFxFAqOgi9p++iry2fGUvEGqJY1IIgoBeUsLbLSY9S
         AzpG6aTYFoCtZYpbLUrMLxZVbT/YJK5EGayW5EGLhOYiXg+WxG7WrHbAlDpA2/DGZKxD
         tKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=rU1gceEf74NFvb3EDNrihaP1dIm6Vep6sPGAHabyh6c=;
        b=ncgjynHCY+EQGVbij0bIjNYrCv9K94REf273hY8ag0ywFQIeBwrmFM0vlqyTwLxnMQ
         HttcPbwn/F5xUc66YzVEgTP1e5PCHOwnE9+hrGvaWlDba7jZOanKFIXS6UDsXPaJCfSh
         KoR33eqIdR9CC3fnLwX31hOxP7SMd+1knXHYFRdHaCqjfEfU3a5ilzrRT5XLHk5H2MSe
         m/DH32HbQZcGKFzhm4O49fmW6dp87Hi1DgqRm76YpTUSvg/gjG2uYLviD6HdYW9kiOiM
         prLj5UFKktoor+3c/eeT5FZHnJ62Zk5l7lTbapU7XFmVBpvv7OGaukC/SKv36IWa0FW3
         0Mkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=aQfShBoE;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.94 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=aQfShBoE;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.94 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Potyra <Stefan.Potyra@elektrobit.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 26/78] serial: 8250_dw: Disable clock on
 error
Thread-Topic: [PATCH AUTOSEL for 4.15 26/78] serial: 8250_dw: Disable clock on
 error
Thread-Index: AQHTtpnIZh0MDoAHj0CkDHx9dGZXfQ==
Date: Thu, 8 Mar 2018 04:56:12 +0000
Message-ID: <20180308045525.7662-26-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:fwRb8wkH3SKYGd+XWb3G0ziqouu2b7gFZ6PtXWJM5cVsFEo3GnkpxW8NezrbXd2vhqP1cWRl/QbbzkEmqBRxXT1Vlbo6DzFv09eZeIhFfD2wiAqv3ksvZESd/4Ey2M050g0fl1Uu7pdZfN5V7vBJPk85M4xUx79BsMIPiqaXTCgHs8FGGwRdD6KsGH1mYkZTVfbUwZhi1Qp6uzr8paAF1XKn5qJkFyZhyfCCob4Avh0SUPSqA14cnkG9AtOuooHZ;20:TJmiwZ7mVggRHwbgIYGveI45keOiyVOTDBYdmFNucrQ5V6XeLqn8N1enELuPhtLXmVBFCIWgqlSyixc8izmtFiI/ihcXLbx2yscSQzxRPEyznqzItBhoCojEx4EW1ROB/YczCUXW26Pz7meVf9XYHWadPEgrs2gZzO6HsycXwzM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bda89be-7f49-4d55-807d-08d584b0f440
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111770A6DCFCD7194CC42A6FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: M5rw81ws1ZmIfo06UI0I6tZXBgAXWG6bFzHc7TvnHMs9wR9Se0Jw4PwJtWlVswIw3U37VUnKWGc639pLBPxErN7H7njzuD8xcVksQTxBcSQ8t6k3ZXfAU1+epD9fWv4wF3emVCPbTb8Op1D/4j0EZyVVY3gfVbyjJgS/3P3sGiuqhmJ1xVLJIUCeAyEKoOsT/iUJMd9QSOKqfwEYrNxiZPtxAnpKOG0EQN1bKMomtNh/eTdwSrTs4DgaxZZ8Ju4vNqtRB4yVkIiqDGrbUJqFFDX+0f7CvE899bfHpn3WAWIRTDPWivufI/AterrrC4wvnqy0d3QuaRSKXKLRgETykw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bda89be-7f49-4d55-807d-08d584b0f440
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:12.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344069250068768?=
X-GMAIL-MSGID: =?utf-8?q?1594344069250068768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>

[ Upstream commit 8af016aa5a27c6a2505460eb4d83f1e70c38dc43 ]

If there is no clock rate for uartclk defined, disable the previously
enabled clock again.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 23f5b3fdd04e serial: 8250_dw: only get the clock rate in one place
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/82=
50_dw.c
index 7070203e3157..cd1b94a0f451 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -509,7 +509,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
 		dev_err(dev, "clock rate not defined\n");
-		return -EINVAL;
+		err =3D -EINVAL;
+		goto err_clk;
 	}
=20
 	data->pclk =3D devm_clk_get(dev, "apb_pclk");
--=20
2.14.1
