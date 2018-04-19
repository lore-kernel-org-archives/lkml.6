Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1694581-1524098957-2-16331377955408535432
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524098956; b=SN2/Y+AIhFzrsrcfodoeml13eH+Kt3VkmYRVSpLmJGO+ne+JKR
    1bAQlVtXfvDUEzPp/l2vCF0jJTZXXYVdgR+P/zjh3pm/9ESBihBpOUSsfGkgsmxT
    s+lostjLzwQi0FAtaKOG2n3cxN38/LfpEce4nu/Tc/ZKiyuD61I3iL9VHQ4Y6fOO
    bmVWi1WwgT7o00xEUYHFgxV0ATC0conTzHV+OA4cl+bA+kvkS6FAPsq7RXfhyv/z
    ZGI4oEkuIItsGVWZECbwZxul9Q/tBwxx44UcQ0fMTwFP6/AvjfuTEwMkc673Yq8b
    E5Ey/GTjuQbmO3yfQthch4uB0oXRbrfdknXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524098956; bh=T9S0mPN9O2
    EFw6zoBjLk+tRSQv50QLri/8+aYKavMbQ=; b=buuurg3qwodOTyjoln2GOEWs+F
    2x/U2a6ZG3lnScT8VgWeKG5zdOYAjIJL4cdmpbST0GivzqtpRdUKuzTJqUCsg9RD
    GIzzuDnthbLAHEnn626ms7h/+zLownN/oCLrkfkhAOOvQoKMay92q30C5BLuBkzO
    OHnN/5mE8sEGYey+OimCyjGKQYMTSBS601uj82foS3LdOTN31sJ6wyHvUSma6mdf
    NMChb/5yc40W8P1/3aXXL191FMujjhZUckRWSteQ4AhiNse1qLmaDl0rDpDIzH1B
    YF77UnRRtzhNm3hdG1nZCKso7cQnnx2sZwmoPkhehtkYXvF+EJAEedZffHLA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i6C15MmF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i6C15MmF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDU9jn3yU5F/Twdu2Xl1UqffJB87fVHeYP6x8lD61dqzRPl0vdKcTGiGixD2LWSogJErV45Z8fjpWWuenKiezwnTOy8wnLSVknuG3CcC217CI/HZW7Lz
    Nt90G6AdV7Cips3O1181dUEsfisijSqyci54aRJtRwsqhWEyEcb70gQjrybYVYRwyHXbg/vwI4XAzRVHzDbfztJc09ZQFw5G/AdGsVMPt6aHa9OUkLK7m2Pz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=IYp8n1Yz95QA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=VwQbUJbxAAAA:8 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8 a=CbDCq_QkAAAA:8
    a=umGIU3MyncoIrPxoOWgA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=HvKuF1_PTVFglORKqfwH:22 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDSAtB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 20:49:01 -0400
Received: from mail-sn1nam01on0133.outbound.protection.outlook.com ([104.47.32.133]:35600
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752336AbeDSAs7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 20:48:59 -0400
From: Long Li <longli@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v2 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Topic: [Patch v2 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Index: AQHT1oDi/JtXjb7nnEuffEhFIifliqQHQlkAgAAAvYA=
Date: Thu, 19 Apr 2018 00:48:57 +0000
Message-ID: <MWHPR2101MB072950054CB911F674EDF11FCEB50@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
 <20180417191710.14855-2-longli@linuxonhyperv.com>
 <DM5PR2101MB1030884AD39F91A77BC0E16EDCB50@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB1030884AD39F91A77BC0E16EDCB50@DM5PR2101MB1030.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0873;7:dAdkNZGpnJMqE52Qvr0vsZAZZF6lCvzDhoU5RKpcJI9ikVyqSXTR8b6jNczu8s4hs3XKz7MqOdMhbHr/pt42IrezDB66F2+TMhcePaBy3hMIZOYrbfOD5oOvjNVaygc8LmtIzQTd8aeEiLJ1YuCOaX2h6iAlWnfS4fSoiDVJWZqgNKGeQYAT1IYw+df/bc/edPstMJbcVsRWy8KPBKs9ydW69L2rNSX7wWYBxAqOp2YkH3/Bt87UbFJBVCw9O5YH;20:wF0f5Wz1twpHRMLeXsJu9qVAj/ffsDIkwJzgk2gVNQz5gXak76Wa0YM8m4Xi5TrSd+XAIHs5xtYrG4OVEXlN5ph5CXl0p9t740J4UlOdHhanSUNYkrue1hCn6XQlksNTakTdNMLoK+nJRTluzFPXtSgcS1X6T32sqf4hm0TaHAE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:MWHPR2101MB0873;
x-ms-traffictypediagnostic: MWHPR2101MB0873:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB0873CD87F11CB16BBAFFD688CEB50@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(192374486261705)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231232)(944501371)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR2101MB0873;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0873;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(39860400002)(69234005)(86362001)(33656002)(10090500001)(575784001)(15650500001)(2900100001)(2906002)(7736002)(8676002)(8936002)(81166006)(74316002)(14454004)(305945005)(86612001)(6116002)(25786009)(53546011)(11346002)(446003)(1511001)(7696005)(76176011)(59450400001)(6506007)(6436002)(229853002)(102836004)(476003)(2501003)(5250100002)(4326008)(5660300001)(9686003)(478600001)(99286004)(110136005)(55016002)(10290500003)(316002)(22452003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0873;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: 2GjKJDMm6WTdRbTlnUU6yyx/6I0OjiR8iOx2IWcItIETtoBjQNdr4myAyX7A8aGeziTL8aSz+G2f1DEd/gXZFlWZjzGBD4B6iU5vp0zr0fTDg/SZgKR1xGG+N2sMNwnSXk/zVptbNnwJ8YGjUunvfFzhNPxyGmsOb5YLx3oRyvU4U6hdDTNy4WXFtwn0ZBz2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9add73fb-cd7d-4c23-6b6a-08d5a58f557e
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9add73fb-cd7d-4c23-6b6a-08d5a58f557e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 00:48:57.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Subject: RE: [Patch v2 2/6] cifs: Allocate validate negotiation request t=
hrough
> kmalloc
>=20
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > <linux-kernel-owner@vger.kernel.org> On Behalf Of Long Li
> > Sent: Tuesday, April 17, 2018 12:17 PM
> > To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org;
> > samba- technical@lists.samba.org; linux-kernel@vger.kernel.org;
> > linux-rdma@vger.kernel.org
> > Cc: Long Li <longli@microsoft.com>; stable@vger.kernel.org
> > Subject: [Patch v2 2/6] cifs: Allocate validate negotiation request
> > through kmalloc
> >
> > From: Long Li <longli@microsoft.com>
> >
> > The data buffer allocated on the stack can't be DMA'ed, and hence
> > can't send through RDMA via SMB Direct.
> >
> > Fix this by allocating the request on the heap in smb3_validate_negotia=
te.
> >
> > Fixes: ff1c038addc4f205d5f1ede449426c7d316c0eed "Check SMB3 dialects
> > against downgrade attacks"
> >
> > Changes in v2:
> > Removed duplicated code on freeing buffers on function exit.
> > (Thanks to Parav Pandit <parav@mellanox.com>)
> >
> > Fixed typo in the patch title.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  fs/cifs/smb2pdu.c | 57
> > ++++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 31 insertions(+), 26 deletions(-)
> >
> > diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c index
> > 0f044c4..41625e4 100644
> > --- a/fs/cifs/smb2pdu.c
> > +++ b/fs/cifs/smb2pdu.c
> > @@ -729,8 +729,8 @@ SMB2_negotiate(const unsigned int xid, struct
> > cifs_ses *ses)
> >
> >  int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon
> > *tcon)  {
> > -	int rc =3D 0;
> > -	struct validate_negotiate_info_req vneg_inbuf;
> > +	int ret, rc =3D -EIO;
> > +	struct validate_negotiate_info_req *pneg_inbuf;
> >  	struct validate_negotiate_info_rsp *pneg_rsp =3D NULL;
> >  	u32 rsplen;
> >  	u32 inbuflen; /* max of 4 dialects */ @@ -741,6 +741,9 @@ int
> > smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon
> > *tcon)
> >  	if (tcon->ses->server->rdma)
> >  		return 0;
> >  #endif
> > +	pneg_inbuf =3D kmalloc(sizeof(*pneg_inbuf), GFP_KERNEL);
> > +	if (!pneg_inbuf)
> > +		return -ENOMEM;
>=20
> Immediately after the above new code, there are three if statements that
> can 'return 0' and never free the pneg_inbuf memory.  They should instead
> set 'rc'
> appropriately and 'goto' the out_free_inbuf label.

Thanks!

I will move the kmalloc after those statements.

>=20
> Michael
>=20
> >
> >  	/* In SMB3.11 preauth integrity supersedes validate negotiate */
> >  	if (tcon->ses->server->dialect =3D=3D SMB311_PROT_ID) @@ -764,53
> +767,53
> > @@ int smb3_validate_negotiate(const unsigned int xid, struct
> > cifs_tcon
> > *tcon)
> >  	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
> >  		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag
> sent by
> > server\n");
> >
> > -	vneg_inbuf.Capabilities =3D
> > +	pneg_inbuf->Capabilities =3D
> >  			cpu_to_le32(tcon->ses->server->vals-
> >req_capabilities);
> > -	memcpy(vneg_inbuf.Guid, tcon->ses->server->client_guid,
> > +	memcpy(pneg_inbuf->Guid, tcon->ses->server->client_guid,
> >  					SMB2_CLIENT_GUID_SIZE);
> >
> >  	if (tcon->ses->sign)
> > -		vneg_inbuf.SecurityMode =3D
> > +		pneg_inbuf->SecurityMode =3D
> >
> 	cpu_to_le16(SMB2_NEGOTIATE_SIGNING_REQUIRED);
> >  	else if (global_secflags & CIFSSEC_MAY_SIGN)
> > -		vneg_inbuf.SecurityMode =3D
> > +		pneg_inbuf->SecurityMode =3D
> >
> 	cpu_to_le16(SMB2_NEGOTIATE_SIGNING_ENABLED);
> >  	else
> > -		vneg_inbuf.SecurityMode =3D 0;
> > +		pneg_inbuf->SecurityMode =3D 0;
> >
> >
> >  	if (strcmp(tcon->ses->server->vals->version_string,
> >  		SMB3ANY_VERSION_STRING) =3D=3D 0) {
> > -		vneg_inbuf.Dialects[0] =3D cpu_to_le16(SMB30_PROT_ID);
> > -		vneg_inbuf.Dialects[1] =3D cpu_to_le16(SMB302_PROT_ID);
> > -		vneg_inbuf.DialectCount =3D cpu_to_le16(2);
> > +		pneg_inbuf->Dialects[0] =3D cpu_to_le16(SMB30_PROT_ID);
> > +		pneg_inbuf->Dialects[1] =3D cpu_to_le16(SMB302_PROT_ID);
> > +		pneg_inbuf->DialectCount =3D cpu_to_le16(2);
> >  		/* structure is big enough for 3 dialects, sending only 2 */
> >  		inbuflen =3D sizeof(struct validate_negotiate_info_req) - 2;
> >  	} else if (strcmp(tcon->ses->server->vals->version_string,
> >  		SMBDEFAULT_VERSION_STRING) =3D=3D 0) {
> > -		vneg_inbuf.Dialects[0] =3D cpu_to_le16(SMB21_PROT_ID);
> > -		vneg_inbuf.Dialects[1] =3D cpu_to_le16(SMB30_PROT_ID);
> > -		vneg_inbuf.Dialects[2] =3D cpu_to_le16(SMB302_PROT_ID);
> > -		vneg_inbuf.DialectCount =3D cpu_to_le16(3);
> > +		pneg_inbuf->Dialects[0] =3D cpu_to_le16(SMB21_PROT_ID);
> > +		pneg_inbuf->Dialects[1] =3D cpu_to_le16(SMB30_PROT_ID);
> > +		pneg_inbuf->Dialects[2] =3D cpu_to_le16(SMB302_PROT_ID);
> > +		pneg_inbuf->DialectCount =3D cpu_to_le16(3);
> >  		/* structure is big enough for 3 dialects */
> >  		inbuflen =3D sizeof(struct validate_negotiate_info_req);
> >  	} else {
> >  		/* otherwise specific dialect was requested */
> > -		vneg_inbuf.Dialects[0] =3D
> > +		pneg_inbuf->Dialects[0] =3D
> >  			cpu_to_le16(tcon->ses->server->vals->protocol_id);
> > -		vneg_inbuf.DialectCount =3D cpu_to_le16(1);
> > +		pneg_inbuf->DialectCount =3D cpu_to_le16(1);
> >  		/* structure is big enough for 3 dialects, sending only 1 */
> >  		inbuflen =3D sizeof(struct validate_negotiate_info_req) - 4;
> >  	}
> >
> > -	rc =3D SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
> > +	ret =3D SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
> >  		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
> > -		(char *)&vneg_inbuf, sizeof(struct
> validate_negotiate_info_req),
> > +		(char *)pneg_inbuf, sizeof(struct
> validate_negotiate_info_req),
> >  		(char **)&pneg_rsp, &rsplen);
> >
> > -	if (rc !=3D 0) {
> > -		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
> > -		return -EIO;
> > +	if (ret !=3D 0) {
> > +		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", ret);
> > +		goto out_free_inbuf;
> >  	}
> >
> >  	if (rsplen !=3D sizeof(struct validate_negotiate_info_rsp)) { @@
> > -820,7 +823,7 @@ int smb3_validate_negotiate(const unsigned int xid,
> > struct cifs_tcon
> > *tcon)
> >  		/* relax check since Mac returns max bufsize allowed on ioctl
> */
> >  		if ((rsplen > CIFSMaxBufSize)
> >  		     || (rsplen < sizeof(struct validate_negotiate_info_rsp)))
> > -			goto err_rsp_free;
> > +			goto out_free_rsp;
> >  	}
> >
> >  	/* check validate negotiate info response matches what we got
> > earlier */ @@ -838,14 +841,16 @@ int smb3_validate_negotiate(const
> > unsigned int xid, struct cifs_tcon
> > *tcon)
> >
> >  	/* validate negotiate successful */
> >  	cifs_dbg(FYI, "validate negotiate info successful\n");
> > -	kfree(pneg_rsp);
> > -	return 0;
> > +	rc =3D 0;
> > +	goto out_free_rsp;
> >
> >  vneg_out:
> >  	cifs_dbg(VFS, "protocol revalidation - security settings
> > mismatch\n");
> > -err_rsp_free:
> > +out_free_rsp:
> >  	kfree(pneg_rsp);
> > -	return -EIO;
> > +out_free_inbuf:
> > +	kfree(pneg_inbuf);
> > +	return rc;
> >  }
> >
> >  enum securityEnum
> > --
> > 2.7.4
