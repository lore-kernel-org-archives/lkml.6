Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbeE3U7Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:59:25 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:17128
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932499AbeE3U6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:58:01 -0400
From: Long Li <longli@microsoft.com>
To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
Thread-Topic: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
Thread-Index: AQHT+E9dvsQOBWcv606hJ7KjQvSo1KRIuMWAgAAHlnA=
Date: Wed, 30 May 2018 20:57:59 +0000
Message-ID: <SN4PR2101MB07338FEF563C5EE974191591CE6C0@SN4PR2101MB0733.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-3-longli@linuxonhyperv.com>
 <14063C7AD467DE4B82DEDB5C278E8663B38F01CD@FMSMSX108.amr.corp.intel.com>
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663B38F01CD@FMSMSX108.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:1:fde7:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR2101MB0878;7:rrhFngCDvJg4uN5w3MzrvfkvAznD7W+uRgDOxkeSmJ6quSNkOejqcDetPQmPXi6NrLJpBe2mWCCbg+Za2gxaI+zccHgo0gvhfcy5n/tflSTImBEZfnkc9WYYo013qKx5UYQ0GL0MK6H3ZJDJUpKQ0DJAU+bRav5WGRDNO+us4J/v9zexEv7WEF3nC4ptFTxWvSi4tBTY5oa4+n09/D+dex8Na9yxiwBBCh6wtUnzYTBh7LKiZwpXgykP3PkzMMYT;20:KJgS0IM2rQ7dbvrcn20+yslR+B7O7GVEnNpSnc9J9qUmv1EYNZ79EkfiTSsNOQKQ+E5D2nPDvVPYRqgplXPfBGpHCPED3vY8fAQzfv4orHJ0aXruGbUuidDtb5fZtuE5o4d2S1JQ9mwWW/vMkZj1fdDhKdUdjyAnvfYwrn3QUDY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:SN4PR2101MB0878;
x-ms-traffictypediagnostic: SN4PR2101MB0878:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <SN4PR2101MB0878D56ECC5B8DA3716E2334CE6C0@SN4PR2101MB0878.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(219752817060721);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN4PR2101MB0878;BCL:0;PCL:0;RULEID:;SRVR:SN4PR2101MB0878;
x-forefront-prvs: 0688BF9B46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(13464003)(68736007)(6246003)(6506007)(97736004)(102836004)(3660700001)(14454004)(8990500004)(3280700002)(2900100001)(966005)(186003)(106356001)(105586002)(10290500003)(10090500001)(25786009)(8936002)(99286004)(2906002)(478600001)(8676002)(86612001)(33656002)(110136005)(81156014)(81166006)(316002)(76176011)(22452003)(46003)(2501003)(486006)(7696005)(74316002)(11346002)(55016002)(53936002)(446003)(6436002)(5660300001)(476003)(5250100002)(7736002)(6306002)(305945005)(229853002)(2201001)(6116002)(86362001)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0878;H:SN4PR2101MB0733.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1oxISbvH7o3prAKVg889ldYx7OlT9muwQWc/ToYWeI4aNuuggRHTxLQ8ZE77Wws3utY0Pl5VVN+/wXlxTKMzRYqqEEw/x9wLoJhfMZzBSkO6SLZF72QE4suPkX7LN8zKkMHhTiSrX9ul4NmgPtajVRg9f1bD0rlFBS9fFrFXL47G53to2o/sbz8W3Qh28xi/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a4e188bd-3ce1-4818-45d9-08d5c67006b0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e188bd-3ce1-4818-45d9-08d5c67006b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 20:57:59.2004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0878
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4UKxcMR017654

> Subject: RE: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
> 
> >-----Original Message-----
> >From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> >owner@vger.kernel.org] On Behalf Of Long Li
> >Sent: Wednesday, May 30, 2018 3:48 PM
> >To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org;
> >samba- technical@lists.samba.org; linux-kernel@vger.kernel.org; linux-
> >rdma@vger.kernel.org
> >Cc: Long Li <longli@microsoft.com>
> >Subject: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
> >
> >From: Long Li <longli@microsoft.com>
> >
> >Add a function to allocate rdata without allocating pages for data
> >transfer. This gives the caller an option to pass a number of pages
> >that point to the data buffer.
> >
> >rdata is still reponsible for free those pages after it's done.
> >
> >Signed-off-by: Long Li <longli@microsoft.com>
> >---
> > fs/cifs/cifsglob.h |  2 +-
> > fs/cifs/file.c     | 23 ++++++++++++++++++++---
> > 2 files changed, 21 insertions(+), 4 deletions(-)
> >
> >diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h index
> >8d16c3e..56864a87 100644
> >--- a/fs/cifs/cifsglob.h
> >+++ b/fs/cifs/cifsglob.h
> >@@ -1179,7 +1179,7 @@ struct cifs_readdata {
> > 	unsigned int			tailsz;
> > 	unsigned int			credits;
> > 	unsigned int			nr_pages;
> >-	struct page			*pages[];
> >+	struct page			**pages;
> > };
> >
> > struct cifs_writedata;
> >diff --git a/fs/cifs/file.c b/fs/cifs/file.c index 23fd430..1c98293
> >100644
> >--- a/fs/cifs/file.c
> >+++ b/fs/cifs/file.c
> >@@ -2880,13 +2880,13 @@ cifs_strict_writev(struct kiocb *iocb, struct
> >iov_iter *from)  }
> >
> > static struct cifs_readdata *
> >-cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
> >+cifs_readdata_direct_alloc(struct page **pages, work_func_t complete)
> > {
> > 	struct cifs_readdata *rdata;
> >
> >-	rdata = kzalloc(sizeof(*rdata) + (sizeof(struct page *) * nr_pages),
> >-			GFP_KERNEL);
> >+	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
> > 	if (rdata != NULL) {
> >+		rdata->pages = pages;
> > 		kref_init(&rdata->refcount);
> > 		INIT_LIST_HEAD(&rdata->list);
> > 		init_completion(&rdata->done);
> >@@ -2896,6 +2896,22 @@ cifs_readdata_alloc(unsigned int nr_pages,
> >work_func_t complete)
> > 	return rdata;
> > }
> >
> >+static struct cifs_readdata *
> >+cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete) {
> >+	struct page **pages =
> >+		kzalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
> >+	struct cifs_readdata *ret = NULL;
> >+
> >+	if (pages) {
> >+		ret = cifs_readdata_direct_alloc(pages, complete);
> >+		if (!ret)
> >+			kfree(pages);
> >+	}
> >+
> >+	return ret;
> >+}
> >+
> > void
> > cifs_readdata_release(struct kref *refcount)  { @@ -2910,6 +2926,7 @@
> >cifs_readdata_release(struct kref *refcount)
> > 	if (rdata->cfile)
> > 		cifsFileInfo_put(rdata->cfile);
> >
> >+	kvfree(rdata->pages);
> 
> Is the kvfree() correct?
> 
> You use kzalloc() and kfree in cifs_readdata_alloc().

This function is shared by both non-direct I/O and direct I/O code paths.

Direct I/O uses kvmalloc to allocate pages, so kvfree is used here to handle both cases.

> 
> Mike
> 
> > 	kfree(rdata);
> > }
> >
> >--
> >2.7.4
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-rdma"
> >in the body of a message to majordomo@vger.kernel.org More majordomo
> >info at
> >https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.k
> e
> >rnel.org%2Fmajordomo-
> info.html&data=02%7C01%7Clongli%40microsoft.com%7C
> >e810388a534643737ab108d5c66bd6df%7C72f988bf86f141af91ab2d7cd011db
> 47%7C1
> >%7C0%7C636633088833938755&sdata=iHKiji2rUhLHpbH5x13SJBWCvHExSr4a
> rz9Xiv3
> >1rMQ%3D&reserved=0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.ke
> rnel.org%2Fmajordomo-
> info.html&data=02%7C01%7Clongli%40microsoft.com%7Ce810388a53464373
> 7ab108d5c66bd6df%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63
> 6633088833938755&sdata=iHKiji2rUhLHpbH5x13SJBWCvHExSr4arz9Xiv31rMQ
> %3D&reserved=0
