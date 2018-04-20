Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbeDTSlV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:41:21 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:33618
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753607AbeDTSlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:41:19 -0400
From: Long Li <longli@microsoft.com>
To: Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v4] cifs: Allocate validate negotiation request through
 kmalloc
Thread-Topic: [Patch v4] cifs: Allocate validate negotiation request through
 kmalloc
Thread-Index: AQHT2Cb+Jx11ZVs1LUqy6Dx2GbNJSaQJvwwAgAA9l1A=
Date: Fri, 20 Apr 2018 18:41:16 +0000
Message-ID: <MWHPR2101MB0729D25131DCC9AF638E0449CEB40@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180419213807.3128-1-longli@linuxonhyperv.com>
 <c8924b83-dfa2-a44c-a425-deb7e03d0bf1@talpey.com>
In-Reply-To: <c8924b83-dfa2-a44c-a425-deb7e03d0bf1@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:c::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0810;7:UsJ2Uie+2Avny0p/wgfqpXZonmmbtI8IEy1yiEhgjJWy4EOmnSTDGWNUMZjpCAh5jy59EEEvgfG4eHomaJni3vrpAPd3fcMkOU+fVdPuXcapaT7voIyVo7UWzIbsMYdiYg13ZMcXLnBZadVOZlW0alecvjZ19JmFQwfS2+70hn/eg1bUdbE+SWIT9efCufMdj404SC38GrWp8/2WoTO35KtRLW6f84dlHo3bGpud6JoSJaCB7MxjmvKKROvR2Vs0;20:0lHsviJQfyCnNcsQzwxJ9lgo0LPMx3yOiXlZZ4+E779OtYpobiYS6NuwVy5oA+PyF1LVRJ4NKpLde+1WRpjqvA1I2OCn0HkwiQA9PbOR8asMBOCKq6bZm6mF4603D6YxnPvh1F1NoerQev/ANtpL0TTWuLsB+XOwvjgJK8l5IME=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:MWHPR2101MB0810;
x-ms-traffictypediagnostic: MWHPR2101MB0810:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB0810E58B99CCA17B1A7E29FCCEB40@MWHPR2101MB0810.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501397)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR2101MB0810;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0810;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(346002)(366004)(376002)(69234005)(305945005)(81166006)(478600001)(7696005)(446003)(316002)(11346002)(2900100001)(46003)(33656002)(3280700002)(110136005)(74316002)(102836004)(6506007)(186003)(59450400001)(53546011)(5660300001)(22452003)(76176011)(10290500003)(86362001)(2201001)(7736002)(8936002)(6436002)(86612001)(6116002)(15650500001)(53936002)(25786009)(9686003)(229853002)(476003)(5250100002)(2906002)(55016002)(8676002)(3660700001)(2501003)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0810;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: myhdd43F6TkOmPIFaxmzZfDqwQ0cBT61G+y2PVNMNL6GrK5fJT91/LHOfqM/y8bePJ7+nnSyDubHgqXh/4jSgczVEzjarbZsy3wxVJS5NXHEsFwLtXCsG7DRuB1V0B37P1k0sdFsTtoP3X0XY0gFRfdO7IGK+OSAMSQELJkWIcG/k2yjlc6vucLuDGRA36HQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5ee7c83c-e032-4551-ec31-08d5a6ee4cc8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee7c83c-e032-4551-ec31-08d5a6ee4cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 18:41:16.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0810
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KIfQ04011867

> Subject: Re: [Patch v4] cifs: Allocate validate negotiation request through
> kmalloc
> 
> Looks good, but I have two possibly style-related comments.
> 
> On 4/19/2018 5:38 PM, Long Li wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > The data buffer allocated on the stack can't be DMA'ed,
> > ib_dma_map_page will return an invalid DMA address for a buffer on
> > stack. Even worse, this incorrect address can't be detected by
> > ib_dma_mapping_error. Sending data from this address to hardware will
> > not fail, but the remote peer will get junk data.
> >
> > Fix this by allocating the request on the heap in smb3_validate_negotiate.
> >
> > Changes in v2:
> > Removed duplicated code on freeing buffers on function exit.
> > (Thanks to Parav Pandit <parav@mellanox.com>) Fixed typo in the patch
> > title.
> >
> > Changes in v3:
> > Added "Fixes" to the patch.
> > Changed several sizeof() to use *pointer in place of struct.
> >
> > Changes in v4:
> > Added detailed comments on the failure through RDMA.
> > Allocate request buffer using GPF_NOFS.
> > Fixed possible memory leak.
> >
> > Fixes: ff1c038addc4 ("Check SMB3 dialects against downgrade attacks")
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >   fs/cifs/smb2pdu.c | 61 ++++++++++++++++++++++++++++++--------------
> -----------
> >   1 file changed, 33 insertions(+), 28 deletions(-)
> >
> > diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c index
> > 0f044c4..caa2a1e 100644
> > --- a/fs/cifs/smb2pdu.c
> > +++ b/fs/cifs/smb2pdu.c
> > @@ -729,8 +729,8 @@ SMB2_negotiate(const unsigned int xid, struct
> > cifs_ses *ses)
> >
> >   int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
> >   {
> > -	int rc = 0;
> > -	struct validate_negotiate_info_req vneg_inbuf;
> > +	int ret, rc = -EIO;
> 
> Seems awkward to have "rc" and "ret", and based on the code below I don't
> see why two variables are needed. Simplify? (see later comment)

This is for addressing a prior comment to reduce duplicate code. All the failure paths
(after issuing I/O) returning -EIO, there are 5 of them. Set rc to -EIO at the beginning
so we don’t need to set it multiple times.

> 
> > +	struct validate_negotiate_info_req *pneg_inbuf;
> >   	struct validate_negotiate_info_rsp *pneg_rsp = NULL;
> >   	u32 rsplen;
> >   	u32 inbuflen; /* max of 4 dialects */ @@ -741,7 +741,6 @@ int
> > smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
> >   	if (tcon->ses->server->rdma)
> >   		return 0;
> >   #endif
> > -
> >   	/* In SMB3.11 preauth integrity supersedes validate negotiate */
> >   	if (tcon->ses->server->dialect == SMB311_PROT_ID)
> >   		return 0;
> > @@ -764,63 +763,67 @@ int smb3_validate_negotiate(const unsigned int
> xid, struct cifs_tcon *tcon)
> >   	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
> >   		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag
> sent by
> > server\n");
> >
> > -	vneg_inbuf.Capabilities =
> > +	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_NOFS);
> > +	if (!pneg_inbuf)
> > +		return -ENOMEM;
> > +
> > +	pneg_inbuf->Capabilities =
> >   			cpu_to_le32(tcon->ses->server->vals-
> >req_capabilities);
> > -	memcpy(vneg_inbuf.Guid, tcon->ses->server->client_guid,
> > +	memcpy(pneg_inbuf->Guid, tcon->ses->server->client_guid,
> >   					SMB2_CLIENT_GUID_SIZE);
> >
> >   	if (tcon->ses->sign)
> > -		vneg_inbuf.SecurityMode =
> > +		pneg_inbuf->SecurityMode =
> >
> 	cpu_to_le16(SMB2_NEGOTIATE_SIGNING_REQUIRED);
> >   	else if (global_secflags & CIFSSEC_MAY_SIGN)
> > -		vneg_inbuf.SecurityMode =
> > +		pneg_inbuf->SecurityMode =
> >
> 	cpu_to_le16(SMB2_NEGOTIATE_SIGNING_ENABLED);
> >   	else
> > -		vneg_inbuf.SecurityMode = 0;
> > +		pneg_inbuf->SecurityMode = 0;
> >
> >
> >   	if (strcmp(tcon->ses->server->vals->version_string,
> >   		SMB3ANY_VERSION_STRING) == 0) {
> > -		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
> > -		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
> > -		vneg_inbuf.DialectCount = cpu_to_le16(2);
> > +		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
> > +		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
> > +		pneg_inbuf->DialectCount = cpu_to_le16(2);
> >   		/* structure is big enough for 3 dialects, sending only 2 */
> >   		inbuflen = sizeof(struct validate_negotiate_info_req) - 2;
> 
> The "- 2" is a little confusing here. This was existing code, but I suggest you
> change this to a sizeof (u16) construct for consistency.
> It's reducing by the length of a single Dialects[n] entry.
> 
> >   	} else if (strcmp(tcon->ses->server->vals->version_string,
> >   		SMBDEFAULT_VERSION_STRING) == 0) {
> > -		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
> > -		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
> > -		vneg_inbuf.Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
> > -		vneg_inbuf.DialectCount = cpu_to_le16(3);
> > +		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
> > +		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
> > +		pneg_inbuf->Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
> > +		pneg_inbuf->DialectCount = cpu_to_le16(3);
> >   		/* structure is big enough for 3 dialects */
> >   		inbuflen = sizeof(struct validate_negotiate_info_req);
> >   	} else {
> >   		/* otherwise specific dialect was requested */
> > -		vneg_inbuf.Dialects[0] =
> > +		pneg_inbuf->Dialects[0] =
> >   			cpu_to_le16(tcon->ses->server->vals->protocol_id);
> > -		vneg_inbuf.DialectCount = cpu_to_le16(1);
> > +		pneg_inbuf->DialectCount = cpu_to_le16(1);
> >   		/* structure is big enough for 3 dialects, sending only 1 */
> >   		inbuflen = sizeof(struct validate_negotiate_info_req) - 4;
> 
> Ditto previous sizeof (u16) comment, with a *2 this case.
> 
> >   	}
> >
> > -	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
> > +	ret = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
> >   		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
> > -		(char *)&vneg_inbuf, sizeof(struct
> validate_negotiate_info_req),
> > +		(char *)pneg_inbuf, sizeof(*pneg_inbuf),
> >   		(char **)&pneg_rsp, &rsplen);
> >
> > -	if (rc != 0) {
> > -		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
> > -		return -EIO;
> > +	if (ret) {
> > +		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", ret);
> > +		goto out_free_inbuf;
> >   	}
> 
> Why not leave "rc" alone, and set its value to -EIO before the goto if the ioctl
> fails? That will simplify and make the code much more readable IMO.
> 
> >
> > -	if (rsplen != sizeof(struct validate_negotiate_info_rsp)) {
> > +	if (rsplen != sizeof(*pneg_rsp)) {
> >   		cifs_dbg(VFS, "invalid protocol negotiate response
> size: %d\n",
> >   			 rsplen);
> >
> >   		/* relax check since Mac returns max bufsize allowed on ioctl
> */
> >   		if ((rsplen > CIFSMaxBufSize)
> >   		     || (rsplen < sizeof(struct validate_negotiate_info_rsp)))
> > -			goto err_rsp_free;
> > +			goto out_free_rsp;
> >   	}
> 
> Would need an rc = -EIO here too if above comment is accepted.
> 
> Tom.
> 
> >
> >   	/* check validate negotiate info response matches what we got
> > earlier */ @@ -838,14 +841,16 @@ int smb3_validate_negotiate(const
> > unsigned int xid, struct cifs_tcon *tcon)
> >
> >   	/* validate negotiate successful */
> >   	cifs_dbg(FYI, "validate negotiate info successful\n");
> > -	kfree(pneg_rsp);
> > -	return 0;
> > +	rc = 0;
> > +	goto out_free_rsp;
> >
> >   vneg_out:
> >   	cifs_dbg(VFS, "protocol revalidation - security settings
> > mismatch\n");
> > -err_rsp_free:
> > +out_free_rsp:
> >   	kfree(pneg_rsp);
> > -	return -EIO;
> > +out_free_inbuf:
> > +	kfree(pneg_inbuf);
> > +	return rc;
> >   }
> >
> >   enum securityEnum
> >
