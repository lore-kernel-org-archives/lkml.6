Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsmKLGKHxk9HsakPNZV3eXAaZZ/f+6OnqsG4Y47JsnhWUwWBAzUbk+W6iZ3CPGT+YpaGGal
ARC-Seal: i=1; a=rsa-sha256; t=1521475097; cv=none;
        d=google.com; s=arc-20160816;
        b=DjLVrD0YoR1rqOMOvYfxIBNeylLcIHfLpgbNirnULDEnt3WGwgreV8A8o4luFF6P5V
         03prIvwO0avyEx9lCG2bvoLx5B9Et/kYVmZe+cSe+AEMkU1hNS0SZUrAIWb9oVvwD1J6
         Dco1PsKl3GELrA58b1I5jZJyi8Jj1l5otBaNnvCsPRPU0KYLOv/cpdR0gmdWTESGZTKE
         Igxyh3t5UEa0+ijwersD2NDk9mMy47jFU5kKrHAn6xkUexyDViMN61C/ic20YxEvR6HH
         9i2P1jmB1VlBaJy86wmGqBHWZINpm8k9p6LXF4IVp9UqOUcBriWOD9MJTrQ8qWfUPLHh
         zyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=LJAjbidbIehI8cemSDR+tLdhW1IklLibqy8ki0jtzG0=;
        b=YNiWvqiFMMdnOr8C1rnArFPOJMkx2pVlX+AKk+9fhDc4cUfoCEgd6AV5ddn6qr0gy5
         vrI/AXHAxBOEBHEUGolBNdhjSkuHIOdwn9pAtZPppFtVfXV2NXhVWCMTUFfnp5yJDWgw
         PjCr+PC+jvSLo2BLzPBzmwUXN8t2pWSTdDZr6MBIuq1DQqlXFVilL9/YVN5pkamYTe/L
         KcEquVVA/Hb0TSY2bnrlPeu9zs3L6xiVhAhdRfKcJvbIorF0PSuIHWQelbfnS7FnKOwK
         0LpfCR26F7Wcpn6n37cer/rXe5TjXTtnAQMVay6ra464wmRWwVkGK+yPQtji8Ffymt9Y
         BMfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LkKjxS0H;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.117 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LkKjxS0H;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.117 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>, Jorgen Hansen
	<jhansen@vmware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal
 Hocko <mhocko@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 021/281]
  drivers/misc/vmw_vmci/vmci_queue_pair.c: fix a couple integer overflow tests
Thread-Topic: [PATCH AUTOSEL for 4.9 021/281]
  drivers/misc/vmw_vmci/vmci_queue_pair.c: fix a couple integer overflow tests
Thread-Index: AQHTv5sWLS/CK2kTzkSHu4NglkoL5A==
Date: Mon, 19 Mar 2018 15:58:14 +0000
Message-ID: <20180319155742.13731-21-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:Cd157g7FEx/+PyBhbWwOp6DQKnF0HU3BcqAOkRABMmi4yKYk0qHDaLmwoFGay12p54pxKh9Q+RM5Xvm9gg7FPftcupqiZKzu2H4PCtjSMkbo6O1FaI1FCrB72APq1C3yPqAuA/4kAncXRukkaevWqq41AscOicR7rn9GEueR4hHMcOIMR1qbju1yn6V39yLKqi+2DHYf4fnpJv/9OvhC8AxiphqSGGmNEqLCNuJF9SiiClySrmjLkkdyUndmTDmA;20:TV19R3b7ppz246AAvzqCR74fv67CnCZEGUwteGwJwD11ybjH0Iq2WwPnKzv2gmjhKcESuBl17rdMBri527LmUcdfsgtorKJfJFFUKoCowCUsSwLLWlwCXGu2DBPDgkQS4CR+o73yht0Wnh8z0t+hygCwH9yskA8UjTOI/XXNeUE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f136ec2b-fde4-43e8-7440-08d58db23971
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726C8B3BCFFF9630190A1D5FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(966005)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(186003)(1076002)(3846002)(25786009)(6306002)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BAWXTWLNXS/KU33tNT8tKuuT+23pZs/Sd/dDCWuSXClZLmPiNUImMcIrNPw/KKWj8YzASXCszKREJRLi3viw+OwwTvVFaZv1c2gN+rISsbNQQ60pkDvHHnCRY33PLUcxcx4gEUdX8ycaSBsGrj0UlP+l7QKXBqzG3Bgst5nw6UueLklvt+27pTqwACfp3wfsf9OsxmGHZ4qJdgwIiOYIxg/ml9A09VhQZ+IBZxbqUU3YmhivsNd3n8GLoJaiiudL833DqHZSpC41ePBnj8A+kfPwL6p/BUPEiZBwknOOb8s9I2c3g06Y/j/kBeQLnT1co1QvWDzBa4OfIOKsIIgRag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f136ec2b-fde4-43e8-7440-08d58db23971
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:14.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382272038209671?=
X-GMAIL-MSGID: =?utf-8?q?1595382272038209671?=
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
index f84a4275ca29..f735ab4ba84e 100644
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
