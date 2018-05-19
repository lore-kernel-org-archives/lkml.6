Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbeESFyb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 01:54:31 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:17040
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750743AbeESFy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 01:54:28 -0400
From: Long Li <longli@microsoft.com>
To: Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC PATCH 05/09] Change RDMA send to regonize page offset in the
 1st page
Thread-Topic: [RFC PATCH 05/09] Change RDMA send to regonize page offset in
 the 1st page
Thread-Index: AQHT7j52VzZjxd9xEUOYpRRW7EvLQaQ2P4eAgABOcEA=
Date: Sat, 19 May 2018 05:54:26 +0000
Message-ID: <MWHPR2101MB0729768F05DC55631C07605BCE970@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
 <20180518002214.5657-6-longli@linuxonhyperv.com>
 <8a32557a-684a-bf6b-bb1d-3f1f0d5c32c9@talpey.com>
In-Reply-To: <8a32557a-684a-bf6b-bb1d-3f1f0d5c32c9@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:e::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0810;7:0uDcR95mVYdI5d2heCw6Dfl/iRHf9w0VXMsYrDq4TaFLqvk0Cu0OauIN6BoncyHgSSLyOX5i3aXXHnYJvNSOqLX7FDzUH2NPndTQyJSizTM4wt9flg7yd9paIAopVcQADD9pep3tI7MdIJsrBaUflJ6t1Ao32IExfpDREZhJMtQqmgT0mRVtxKM/LdXbLZy3eMUynvcLNhnFYheBHLXVUQsMCh3zfHKWNWY7hUhWVYRPeFrHXvZEaicmICcskW2N;20:gWQW22Ndo+mcfJOqPR1iSZ+z/ZAUrXg6cbaqMDAGWfzRwTdc2RTviowN7Mp+vAxJJMzVSSoJazMIvR0ScuRFCX4NiRt0DuJ4lxUmp02hxWey8lTUV0sQ73Uw2mRZiFGxxAVdvmv6eBxR5gXG7Y6Uql5Jw09hMSAyozpoDH5UEMU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:MWHPR2101MB0810;
x-ms-traffictypediagnostic: MWHPR2101MB0810:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB08107BD6D6D06E96181F86E3CE970@MWHPR2101MB0810.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR2101MB0810;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0810;
x-forefront-prvs: 0677FFABBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(39860400002)(366004)(189003)(199004)(76176011)(7696005)(8936002)(68736007)(446003)(6506007)(186003)(11346002)(53546011)(6436002)(55016002)(229853002)(46003)(2201001)(7736002)(575784001)(305945005)(2906002)(5250100002)(5660300001)(110136005)(81156014)(86612001)(86362001)(2501003)(316002)(476003)(3660700001)(22452003)(81166006)(486006)(3280700002)(102836004)(8676002)(99286004)(74316002)(33656002)(97736004)(10090500001)(10290500003)(478600001)(14454004)(8990500004)(2900100001)(9686003)(53936002)(6246003)(6116002)(25786009)(106356001)(105586002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0810;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WCjq9FovlfOV0p81teFPP1YiI9FRUYwgc5dWXx2cnMT5K9jg5IsHEQe6P7nPRVxpzwsOxs5fi1TFtBdW/UiWUzahn5V08rGhYmuUV6aaHSUEZFgXF++b82HmjlRmaDG1Aeg3PHZ9aHiHlJX+XIt5ROL4PUlzAnOXAuN3tfJVgupcNQ9BLXUjlyuMdrkhjQ3w
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bf39a497-2ed6-4aa3-69dc-08d5bd4cfaa8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf39a497-2ed6-4aa3-69dc-08d5bd4cfaa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2018 05:54:26.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0810
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4J5sc2E028158

> Subject: Re: [RFC PATCH 05/09] Change RDMA send to regonize page offset
> in the 1st page
> 
> On 5/17/2018 5:22 PM, Long Li wrote:
> > From: Long Li <longli@microsoft.com>
> 
> There's a typo "recognize" in the patch title
> 
> 
> > When doing RDMA send, the offset needs to be checked as data may start
> > in an offset in the 1st page.
> 
> Doesn't this patch alter the generic smb2pdu.c code too? I think this should
> note "any" send, not just RDMA?

Yes, but for TCP the direct_pages and page_offset are always NULL and 0 when cache=rdma is in mounting options, so it doesn't really affect he TCP code path in this patch set.

This behavior can be changed, and it will work with TCP too.

> 
> Tom.
> 
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >   fs/cifs/smb2pdu.c   |  3 ++-
> >   fs/cifs/smbdirect.c | 25 +++++++++++++++++++------
> >   2 files changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c index
> > 5097f28..fdcf97e 100644
> > --- a/fs/cifs/smb2pdu.c
> > +++ b/fs/cifs/smb2pdu.c
> > @@ -3015,7 +3015,8 @@ smb2_async_writev(struct cifs_writedata *wdata,
> >
> >   	rqst.rq_iov = iov;
> >   	rqst.rq_nvec = 2;
> > -	rqst.rq_pages = wdata->pages;
> > +	rqst.rq_pages = wdata->direct_pages ? wdata->direct_pages :
> wdata->pages;
> > +	rqst.rq_offset = wdata->page_offset;
> >   	rqst.rq_npages = wdata->nr_pages;
> >   	rqst.rq_pagesz = wdata->pagesz;
> >   	rqst.rq_tailsz = wdata->tailsz;
> > diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c index
> > b0a1955..b46586d 100644
> > --- a/fs/cifs/smbdirect.c
> > +++ b/fs/cifs/smbdirect.c
> > @@ -2084,8 +2084,10 @@ int smbd_send(struct smbd_connection *info,
> > struct smb_rqst *rqst)
> >
> >   	/* add in the page array if there is one */
> >   	if (rqst->rq_npages) {
> > -		buflen += rqst->rq_pagesz * (rqst->rq_npages - 1);
> > -		buflen += rqst->rq_tailsz;
> > +		if (rqst->rq_npages == 1)
> > +			buflen += rqst->rq_tailsz;
> > +		else
> > +			buflen += rqst->rq_pagesz * (rqst->rq_npages - 1) -
> > +rqst->rq_offset + rqst->rq_tailsz;
> >   	}
> >
> >   	if (buflen + sizeof(struct smbd_data_transfer) > @@ -2182,8
> > +2184,19 @@ int smbd_send(struct smbd_connection *info, struct
> > smb_rqst *rqst)
> >
> >   	/* now sending pages if there are any */
> >   	for (i = 0; i < rqst->rq_npages; i++) {
> > -		buflen = (i == rqst->rq_npages-1) ?
> > -			rqst->rq_tailsz : rqst->rq_pagesz;
> > +		unsigned int offset = 0;
> > +		if (i == 0)
> > +			offset = rqst->rq_offset;
> > +		if (rqst->rq_npages == 1 || i == rqst->rq_npages-1)
> > +			buflen = rqst->rq_tailsz;
> > +		else {
> > +			/* We have at least two pages, and this is not the last
> page */
> > +			if (i == 0)
> > +				buflen = rqst->rq_pagesz - rqst->rq_offset;
> > +			else
> > +				buflen = rqst->rq_pagesz;
> > +		}
> > +
> >   		nvecs = (buflen + max_iov_size - 1) / max_iov_size;
> >   		log_write(INFO, "sending pages buflen=%d nvecs=%d\n",
> >   			buflen, nvecs);
> > @@ -2194,9 +2207,9 @@ int smbd_send(struct smbd_connection *info,
> struct smb_rqst *rqst)
> >   			remaining_data_length -= size;
> >   			log_write(INFO, "sending pages i=%d offset=%d
> size=%d"
> >   				" remaining_data_length=%d\n",
> > -				i, j*max_iov_size, size,
> remaining_data_length);
> > +				i, j*max_iov_size+offset, size,
> remaining_data_length);
> >   			rc = smbd_post_send_page(
> > -				info, rqst->rq_pages[i], j*max_iov_size,
> > +				info, rqst->rq_pages[i], j*max_iov_size +
> offset,
> >   				size, remaining_data_length);
> >   			if (rc)
> >   				goto done;
> >
