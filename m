Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2693687-1523995882-2-13308547189704523019
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
    1523995881; b=wUFBbpQ2LkE2oc/Vo6wLpGn3hqJxHZa5w8rM2VPENKI2SB2tRa
    AaQIJkBYHempTje/zcZx5xgCfzPBJeIO34na6NYGZNGv7vgSc2cpfa/SkyGPuL82
    SrdZ9jVFcIMPcybFNtmxsT95YRPLzrK7ST2N5UvTLtUOyS2AVDn+c8P4OF6A33+y
    GCr+P/ASlRa/45Ye1J2nD0118Lg+19wY3W61dIdjzOn7CCa9Sp30w1tm0v4f8vQ6
    3pdwYjgAKQ964gKpDgjjGqoZm1U1ptnig+GONGUkzgIIobJSM/WBEic+yzCZ0vep
    GZyaXaP0Dy3485QEtqxx41KR1d8yj4eAh3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523995881; bh=hv/c2hxnJc
    tW6etd41Lasi4p+/f/DFb3O+DzqR2+CxY=; b=R9dg/H4BKiDpTtFe+1+kXwW4DM
    OrtAWPjNKjpfZDCoAMHtbKIaOJntEgBbuGd9WvQfqDiLIJgfx7nFaD3KBfP4ySXL
    vF1ng0g1J5/04m2IAMa2wRnBIyAzwUYkd4q2fazKS5aigEJzbiG/4zsK2kiIyROL
    1ldq6GbDabkOu5dJSipSrIm8kdI/RfGik/RhzBCRcOaXqAqCpQaOhX0fTy/mhpyH
    yiE/ea+75gsFHm6Lu3ty+ztBt8lhg89QDhaMgfgAhOxUDyjtxVZfbYSHe8hV3kJW
    Ezxj265vuwvQ3/jBrULxeDI5qnuxAdQOVit60Y/DVwfgfP4EhWOu+3QW+hlw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OS1Qt+Wa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OS1Qt+Wa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKIClYZCRymp1+aYmQM4szRZT4WzZpW7vVfsxVNth27LXu8JgdPYTAmE2n2zr3LdujVbiyZDV/51AWoN5G/ao6BqOM+jygWo9y4/tEScPe9JFTzNHbHV
    RuKX8IHIGN2P8vXZ1guu3xa1+NAw6U413B8PCQlAsjYNz6PuDRVxKosPV+y4AN5aVoaoEVKuxLgUJHXCEJ99OL0WQ5s78biRPH3VmqGuzy7xqFmkTJEys01w
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=IYp8n1Yz95QA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=VwQbUJbxAAAA:8 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8 a=CbDCq_QkAAAA:8
    a=fX5_NLwobyYyc7j6HT0A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=HvKuF1_PTVFglORKqfwH:22 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeDQULS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 16:11:18 -0400
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:49510
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751204AbeDQULR (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 16:11:17 -0400
From: Long Li <longli@microsoft.com>
To: Parav Pandit <parav@mellanox.com>,
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
Thread-Index: AQHT1oDi/JtXjb7nnEuffEhFIifliqQFYCYAgAACRmA=
Date: Tue, 17 Apr 2018 20:11:14 +0000
Message-ID: <MWHPR2101MB0729D25984E4C57E79355794CEB70@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
 <20180417191710.14855-2-longli@linuxonhyperv.com>
 <VI1PR0502MB30080A26FFC2A6132397C549D1B70@VI1PR0502MB3008.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR0502MB30080A26FFC2A6132397C549D1B70@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0729;7:8KrLydkEegdpks92mFx/ROfs2YKRoqDFUUlKjm0W0v3rP1gz0hVh2Yt9PCEwOe1R5DikiJAa+YW+gu5I+omRlJ8GEg+9I4ZP+uUv+Bt4LufhYNzIaxFEQLXrUKp6NaaLLlZP/6P/GCM0VDSyzypOK/s/kAQJb6yG+fU6tiQcwHRe0PW3QSiBqgOkkF3x3AldqBbhjLcSQs86+EgUeDuN12q/um8mBewInprOg7CqTkOh8oV09WnDttcUxbaxFLdU;20:eFKKncQKwIKQOjlSMZ7aXVg5kWJf/IuCyXvAtEkcfwjHfdDpobvDrMJcZlsEx7VzJ7GoTwq9CoYbATqEktcluZ/rVi5LQgvs8OI6kmzl/Ft4YvqE3zP80uns3lzuOussLbHGjyj4PuRfVSUzMTdzNMSv3JVQwoFa18sHl+7xPk4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:MWHPR2101MB0729;
x-ms-traffictypediagnostic: MWHPR2101MB0729:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB072969E8171C9A6E4359205CCEB70@MWHPR2101MB0729.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501361)(52105095)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR2101MB0729;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0729;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(13464003)(9686003)(110136005)(3280700002)(575784001)(102836004)(10090500001)(2201001)(4326008)(86612001)(86362001)(316002)(6116002)(8936002)(5660300001)(8990500004)(14454004)(8676002)(22452003)(10290500003)(81166006)(2501003)(478600001)(305945005)(15650500001)(74316002)(99286004)(186003)(3660700001)(6436002)(2906002)(7696005)(33656002)(5250100002)(25786009)(446003)(6506007)(229853002)(476003)(7736002)(76176011)(59450400001)(53546011)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0729;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: dLZ/wAIOV4qyzO/hM4SpI8rDfOZ4ed8Sx1MVHWwUnxlPzVbgrpODUsiHOgBPJO56rykiVqE7GAomxOO84vYICSaA9UK9BfbWuAyXaWKhlXjS/iaoo6zQpCSTINqhRg7kjjZx740WKTggLKXnLSncwKphedjmpFPWhZofbGuO6WW1SRCkKat3F7SfHx3YQ+cf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8bf7ab6b-917b-4345-61d7-08d5a49f5f46
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf7ab6b-917b-4345-61d7-08d5a49f5f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 20:11:14.7527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0729
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Subject: RE: [Patch v2 2/6] cifs: Allocate validate negotiation request t=
hrough
> kmalloc
>=20
>=20
>=20
> > -----Original Message-----
> > From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> > owner@vger.kernel.org] On Behalf Of Long Li
> > Sent: Tuesday, April 17, 2018 2:17 PM
> > To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org;
> > samba- technical@lists.samba.org; linux-kernel@vger.kernel.org; linux-
> > rdma@vger.kernel.org
> > Cc: longli <longli@microsoft.com>; stable@vger.kernel.org
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
>=20
> Format is:
> Fixes: ff1c038addc4 ("Check SMB3 dialects against downgrade attacks") It
> should be right above Signed-off signature.

I will fix up and resend this patch.

How about the rest patches (1, 3-6) in the series? If they don't need any c=
hanges, is it okay that I resend this one only?

>=20
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
> > ++++++++++++++++++++++++++++++------------------------
> > -
> >  1 file changed, 31 insertions(+), 26 deletions(-)
> >
> > diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c index
> > 0f044c4..41625e4
> > 100644
> > --- a/fs/cifs/smb2pdu.c
> > +++ b/fs/cifs/smb2pdu.c
> > @@ -729,8 +729,8 @@ SMB2_negotiate(const unsigned int xid, struct
> > cifs_ses
> > *ses)
> >
> >  int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *=
tcon)
> {
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
> >
> >  	/* In SMB3.11 preauth integrity supersedes validate negotiate */
> >  	if (tcon->ses->server->dialect =3D=3D SMB311_PROT_ID) @@ -764,53
> > +767,53 @@ int smb3_validate_negotiate(const unsigned int xid, struct
> > cifs_tcon *tcon)
> >  	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
> >  		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag
> sent by
> > server\n");
> >
> > -	vneg_inbuf.Capabilities =3D
> > +	pneg_inbuf->Capabilities =3D
> >  			cpu_to_le32(tcon->ses->server->vals-
> > >req_capabilities);
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
> Please check if strncmp() should be used or not.
>=20
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
> > validate_negotiate_info_req),
> > +		(char *)pneg_inbuf, sizeof(struct
> validate_negotiate_info_req),
>=20
> Use sizeof(*pneg_inbuf)
>=20
> >  		(char **)&pneg_rsp, &rsplen);
> >
> > -	if (rc !=3D 0) {
> > -		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
> > -		return -EIO;
> > +	if (ret !=3D 0) {
>=20
> if (ret) is fine.
>=20
> > +		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", ret);
> > +		goto out_free_inbuf;
> >  	}
> >
> >  	if (rsplen !=3D sizeof(struct validate_negotiate_info_rsp)) { @@
> > -820,7
>=20
> if (rsplen !=3D sizeof(*pneg_rsp))
