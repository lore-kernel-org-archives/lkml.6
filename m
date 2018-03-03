Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELspGtO7XM+NkoSGVhAhu3DK490tpWtB1OrUjenuHvGAPB2y14x4EgJOsG90tvczps3D6cJl
ARC-Seal: i=1; a=rsa-sha256; t=1520116501; cv=none;
        d=google.com; s=arc-20160816;
        b=J6zvvxN2Qk7FvrZjjrZsVL/+dOwAPZ7HQOA//dIyCsb9kOpRCoXdvc1DxxmUJT6t0h
         skA1EfDG+Gf2nOLPtWDI0HuNxPctSwBW1h1hj3MIlXj7wOxyK/NhNvwgvN+BBmppXiuL
         CEChi100mFzTX4cO9/l2lLHvdoyye2KfqsbKjhzksst4Wt9yqwh0muKuzNNpIddeU5I6
         89AVtkyi0HXglV7Opq969A75Nk+1yYu/SpmmprhgG08ehMTPu7P6JWkns8apFQHy7upS
         bAXdFbqepqCE7lS3rpRANo6hFPEDToHiqUhLc9C0knQBuXqsn0VSqXFvHitkNWgddYFz
         G9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=AYjrqjFi0cuFSaDJ4+gIgC/B7gwk/iOdsLU6C4rKY+o=;
        b=QTTYoqefySzfA2K2LpKa1Fc0Ys3Qu9bvumE4dzjgbun1tPnwJZzvPyjiY6Oy8OhhQV
         BUQLe5VYWBQCVRcFiMWTcZhrKTnfYC1RFKYRxivk99pRLVL4KjhpqC4eKHOgckgvAB0n
         WtdwE51X04W+HiS8fYouD5byu653NMVggCMMrAOEfQ4k1Ya9jDNLblfpQMMlikp33gbY
         zsEZR7pXLw3JVHSqLUVaGIvggVfQqRptiRGVimUn3kXM++08x25cden8/VboxefYxdKk
         IM8PYX9betVumoTn7i2n70Pvpt/klUUNDOaeinynk9D9qyERrGt8RSkRffCDNjLqR+yD
         ha+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=FO4gS3NS;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=FO4gS3NS;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mike Leach <mike.leach@linaro.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 132/219] coresight: Fixes coresight DT parse
 to get correct output port ID.
Thread-Topic: [PATCH AUTOSEL for 4.9 132/219] coresight: Fixes coresight DT
 parse to get correct output port ID.
Thread-Index: AQHTsz8OYGldflcBaEWx2Ie5s/f15Q==
Date: Sat, 3 Mar 2018 22:29:12 +0000
Message-ID: <20180303222716.26640-132-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:hb37OIMw3eZsvbtX75b0pe9EYYqieFif+ITY5n81TlVdEYzGQp/7tGBdpVtNy0m+ubkGb5noa7US+oB8Rdj2UcxusroTWTWC0zWe2HVV+BRC4eC5rZQ2q1I6HnqpaIGB3xIR4L83BJlTOcIM4S9A8HbaFHh0xw0sTQr+/KBYkpkKKX9tR4d1c4+PeiR0eRAmanRAsO4756BXkyjonorlVboEBDuz3RzWVSFJvi7q5v/FLWaBzvdFNDY0sZmM0ANCZu35Du8T+DNId2mH0SppC8ZkPwXgPnfqJyux/DGswuK9oEmLB+arWyZ1fIBjpBgyhrri7rWWxHOSyo/Jrp3WDkALu+jCiDOOH6VmpC4szSM=;5:xXg/hW6l2DMFIZtnv39AFAyZya3dn2TwBxEOhp19AfL5VoPZ+2C5dmCOl46iPRrUWB7rHhi/SBu+XIF0yPKIpViqMHx+5GTeL1nMAm4bTw6a+ck3+Uiak/1hirx6L6qQAIqIhCZ2Lyqj5YsXFtXwpNlts+R+z5bO79Umfo88VgY=;24:h3AHMaF0PhyFuGZimdhVhiZwsoBNp/J1XnYUkrUS7zCKmJ18kUP1JgAo05t4oiX/ZwfQf5Iv9fHl6P4j8M+mONnl27kQZ71seEIGZXNpz7g=;7:+xLuXIs/XoccSMzbHC7M+r6VRlfa36VpwdqevWZhPNhb7Yls8PfAkik8J8cZsQ70KJEkjk1VwSHWhimvYchvRM34z57meoRHgSAntQErnqGS0QQ8nD9T3Uem2wYyERlg+hrNbD4FvnbBnb9DkxCMftFJGlp1Un1ZIMImH2ruGe4UJ/zKCZ7oNHUamV9OyoE1/6EBs1vph/GXkukGkKCEVYPUakbmVSnqzoCcLM1cTvn3szxqQa50nfMON70s6pJo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fea73e61-1ef9-430f-cb2f-08d58156fa27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB092444B842DD2AB612F44E48FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea73e61-1ef9-430f-cb2f-08d58156fa27
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:12.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957681084226533?=
X-GMAIL-MSGID: =?utf-8?q?1593957681084226533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mike Leach <mike.leach@linaro.org>

[ Upstream commit eeedc5421dd3b51de73e6106405c5c77f920f281 ]

Corrected to get the port numbering to allow programmable replicator driver
to operate correctly.

By convention, CoreSight devices number ports, not endpoints in
the .dts files:-

port {
     reg<N>
     endpoint {
     }
}

Existing code read endpoint number - always 0x0, rather than the correct
port number.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing=
/coresight/of_coresight.c
index 629e031b7456..09142e99e915 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -149,7 +149,7 @@ struct coresight_platform_data *of_get_coresight_platfo=
rm_data(
 				continue;
=20
 			/* The local out port number */
-			pdata->outports[i] =3D endpoint.id;
+			pdata->outports[i] =3D endpoint.port;
=20
 			/*
 			 * Get a handle on the remote port and parent
--=20
2.14.1
