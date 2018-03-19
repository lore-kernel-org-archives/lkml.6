Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELs5c+cKW1NEUs6wWY05tg6jMuQiq0kvYcz4U2PzasUPsf3grHsS4DofjXLgvFqzYMLl/ipS
ARC-Seal: i=1; a=rsa-sha256; t=1521475608; cv=none;
        d=google.com; s=arc-20160816;
        b=lye3TKr+/QgQ2iGhstiGNiU940B6yMKzU7G1JgzNERcEIinpCWNVcjNjNEDOmxmqth
         LNC1Uzot3W0DCaFFUvgmXfJj5KxMZAxJ5dquMU9ctw1vjm3FzYQXeGlhxIdCd4SZg8wk
         /qC2fJ4Qoiov5K+FfI9h3Q9gEuvPT0j+frT2L35lbk1gYag7fTDN1DTfmwMQq/tniRPg
         DVTKM3hhdrXp3lmsalpPeQzAdmPWxB5SX7X50T+w8w/skQqkfsdQaHYAGbJMbenGMFmQ
         k8Vu2YK+miC6uDXcBq4Wd1WN3tEKdd54IaFOvY5YW3fcziZxihsP0zEAMU2AcOvcpYra
         xwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=XwRKf7NTxIhCHnkb89fORZa1TOuN9Dh6ZzX4F51utLs=;
        b=dJdJ4bNSNa0rCMZmSgXmaVT4OPDpl0+UYzDlZ2ssQRpSzlbUknZ4K/U0akrJf5CFVh
         wDqz0pyMmJvmGxIFPXTYzHzZOH1kl0glVhKugOuYuSEL+UeEJOqC+yUDtjGqi6e4Kb93
         Zr3MmihuD6qiXc7hM3L8Df9sNMqePQME1+GCFRnSa5euH8Ka0ANnedhwaHj8HaAh9uBo
         D7kjQW5gbq1YvJBX9lEzJcUB7WShkNMWOgZlKbMPTJs4BmK6XtZPhi0xHch6XBmMKjN0
         N7YHvY4r1LIpodb3QjWTASRDz8QQlpiljuX9mm4AqcO93h73BfVeuEBJVYIbPV3vldWz
         d7dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XY8hnmhJ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.116 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XY8hnmhJ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.116 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>, Jorgen Hansen
	<jhansen@vmware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal
 Hocko <mhocko@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 015/167]
  drivers/misc/vmw_vmci/vmci_queue_pair.c: fix a couple integer overflow tests
Thread-Topic: [PATCH AUTOSEL for 4.4 015/167]
  drivers/misc/vmw_vmci/vmci_queue_pair.c: fix a couple integer overflow tests
Thread-Index: AQHTv5wgS+ptyQ51U0KlagTNjdr6pQ==
Date: Mon, 19 Mar 2018 16:05:39 +0000
Message-ID: <20180319160513.16384-15-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:55q9SGQAw2xR0HLFeEvf/RmqGsihgcomfGde2iRkGF9HxQ+oZFaAQU4Cc5yaDphrubT2jRzCi0l7YYVAYg2jZrgka5pU49YdA2qrXYDbIMmj0mEzoSEgSLsH9qssRad5FCLNdxBFzJIfyOcBrhoTdepkeCGMEsLCW6EZUCcLSu/iOHJQHawTFVTOd8Sm46GuByJD9FbLpHGMyOw5JmvgREvPOprF+wAPL1PITVo3ViY7EVhoKWmiBb/GmuQTXbNc;20:CDUWRhT1Z1Rf9V/Lot80PFBely4PaLce3sY3irQ47tZur3KR2AyLa9jssZavQ6Gl802r4FWWSLZrJmfo9x/bXZnEN2akJFRp6c10pQDQ9lYHmgFf9xl+pkyLhp4v5QZnasFuuHo45EtduMdO79SiBt5/jhD8mzI8sSly5+a0FKY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac22132f-fc2b-48d7-f99b-08d58db36a9f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109372DF6428012DB0139CEDFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(6436002)(86612001)(966005)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(6306002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tu8Hw18yDWXCjY939F+dc8yZRRdVtaoEXe9ESnBq6ambKtvBhIeoTM8x7Y0BWXJ701nX8m0d4LHGjcHC+2RHjYNa2Rj2uVTkPlnPI3De/e9rDIgJJckOhrzpe6zyfpK9I3RHcRVP+hfEm4QMTfW3b00mM/xQjX2Cg7tx6QsUZmu6mlimkqw9PjlyEhi7teEotZgveLnwFy33K4jDP/PYFm8WhHqHMUiEYG1ZwSZPlaZG+j/EnrqlqNNTrrihUVAZTCmFWxKEVDPqzFV0ziyPgC4Ky3/rIbynGhKlL7f6F22/c8HfjA4Trw3dHDZxugW02ac++xG5nGyzVok5jaHlCA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac22132f-fc2b-48d7-f99b-08d58db36a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:39.7958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382272038209671?=
X-GMAIL-MSGID: =?utf-8?q?1595382807527145027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 146180c052a00172f4dc08eaade836fd02f61fb5 ]

The "DIV_ROUND_UP(size, PAGE_SIZE)" operation can overflow if "size" is
more than ULLONG_MAX - PAGE_SIZE.

Link: http://lkml.kernel.org/r/20170322111950.GA11279@mwanda
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jorgen Hansen <jhansen@vmware.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmc=
i/vmci_queue_pair.c
index f42d9c4e4561..cc277f7849b0 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -298,8 +298,11 @@ static void *qp_alloc_queue(u64 size, u32 flags)
 	size_t pas_size;
 	size_t vas_size;
 	size_t queue_size =3D sizeof(*queue) + sizeof(*queue->kernel_if);
-	const u64 num_pages =3D DIV_ROUND_UP(size, PAGE_SIZE) + 1;
+	u64 num_pages;
=20
+	if (size > SIZE_MAX - PAGE_SIZE)
+		return NULL;
+	num_pages =3D DIV_ROUND_UP(size, PAGE_SIZE) + 1;
 	if (num_pages >
 		 (SIZE_MAX - queue_size) /
 		 (sizeof(*queue->kernel_if->u.g.pas) +
@@ -624,9 +627,12 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size=
)
 {
 	struct vmci_queue *queue;
 	size_t queue_page_size;
-	const u64 num_pages =3D DIV_ROUND_UP(size, PAGE_SIZE) + 1;
+	u64 num_pages;
 	const size_t queue_size =3D sizeof(*queue) + sizeof(*(queue->kernel_if));
=20
+	if (size > SIZE_MAX - PAGE_SIZE)
+		return NULL;
+	num_pages =3D DIV_ROUND_UP(size, PAGE_SIZE) + 1;
 	if (num_pages > (SIZE_MAX - queue_size) /
 		 sizeof(*queue->kernel_if->u.h.page))
 		return NULL;
--=20
2.14.1
