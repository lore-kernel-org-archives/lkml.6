Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2397738-1523988721-2-12260508894938540516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523988720; b=eYtFv/rWA3Fc1sRtR9bEYEfdxCz+XsajL4FfRsMGO6p91wC687
    5dDaBsrC80FxmBKQN1+CC3GF0LkK1lR8oo60mM3ZdCShDziybQr4c9eVl8ubqKQx
    StGvckBFKH0Wno8vvl2jI64nqReBW/CA4MrhEackS4cnc3UaRtEDPBfci3aQJ5D7
    IMsdrkvcHfvSRYCLpwPPgQKnNKQnHhXWYjtP/+UUsk4PsnFZg5zrpN1oh/c63AfQ
    v1Cv49YTowBM+FyD5z1BDVRrCXUDLhDBKBPRPWw0lBKTRIyVM5nYfJf92AcYe8s5
    rneMG5J1twZhfQLpGzTUMe4/cY7Tad9arxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523988720; bh=LidwDzbiZD
    opT99J31+IdDh27UHYpeHLfQhJFfMJTo8=; b=JQ63Se/dFGVuAzlnu596ejLqM5
    1Wv7WpLWlWzKKzGNFk4o65cbpA7I+lt8WOV7GeBszxtR/QHY2CvV16bxEhch2O2b
    rD5fS6b4W++Bzi3qbYQO+sq5rFSP35V2l4WTK/FRQGH/lnlfZn55abJrV0enJJHm
    C1RJeO8+sg3HzrAmKRxy3h4lXdrO0VwoefpPJ1SoPwWPrjlZwEFS8lXuTtx01qE6
    uPhCG56yMyj7Io81lhfMFHCraeAA/2oSwYkjmzHf0PRO2jHb7n5dQkBCJQZNpWwB
    3ShHzTaFCn5aUkI6W+yVx7plrDEovLKG32Tx2Eoh7lH00NmvzWb6zn9dWfuw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mSIPURFR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mSIPURFR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNGDP52ACgD3r/ILkbZxYJhx1IWuaBHU/9ZDMoLkmE9aIEqCB8dyqGKtjHkL438r49PVBoNFWkHKlxgD8uAkwxuu42eiZM9L86gfe9oSy3XxkycQA+Bc
    cNUJoma0YvdzK/D6I2sy0k5kKzvg4W94k5Z6zCm6RBKygnXUg4ezdM/RvZsWcWPSIXCtIQQJJX/bhTtk9lVRajosdpVpnRWmCRhRR3bJdNwrKw7oZZ3Na7UD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=CmCOOYeSSB4A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=VwQbUJbxAAAA:8 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8 a=UqCG9HQmAAAA:8
    a=-LTlfl57AAAA:8 a=hMmGTLv4v7l3NmaufaYA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HvKuF1_PTVFglORKqfwH:22 a=4yBhqm45maw-wbmcY3s_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeDQSLr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 14:11:47 -0400
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:44393
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752510AbeDQSLp (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 14:11:45 -0400
From: Long Li <longli@microsoft.com>
To: Parav Pandit <parav@mellanox.com>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/6] cifs: Allocate validate negoation request through
 kmalloc
Thread-Topic: [PATCH 2/6] cifs: Allocate validate negoation request through
 kmalloc
Thread-Index: AQHT1eYovdtgbxsyaky/WWx2hZxzdaQEVZ8AgADtNnA=
Date: Tue, 17 Apr 2018 18:11:42 +0000
Message-ID: <MWHPR2101MB0729B22028B722198A51E3B3CEB70@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180417004918.29213-1-longli@linuxonhyperv.com>
 <20180417004918.29213-2-longli@linuxonhyperv.com>
 <VI1PR0502MB300847394E1E25FADDCC0BB7D1B70@VI1PR0502MB3008.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR0502MB300847394E1E25FADDCC0BB7D1B70@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0812;7:sCq/2VSXyfViu/U/VwTZdUzrQAS8s52B0hgtB9trKW3AundxMprEgAIYYYnO5/hHAfRjXD8WJtsWtm0UwGt1N8XKi5gOSzWuKUwajjKKrgIt3Yu4MuRV7j4a/oLhKay4zOLwt962/2ZtLUSWh9n6SiID4EEF2Rmtt2ias+FW5yWe+z+jKMwCOMc+Xghsehge4JEDSR528TTYxvCcZFvU48PwSVVejZ68Qh9cfqSKZhtSFB/bNJ8TbiTFfPBBTTSy;20:5Dp14yU5e6pBJa1YRYw/2Q7bOoDhva7leeZl/tB4yntEIK+GHoZjnQQ4S0JUctE+XAvqtVP1yfFTR7LMaMqhUHarLhGW7X7rZr9zdJH5BkvdY/ufBWhpf+6gCzICR4nZ/Ci2oe/I4pu8ejQ5jaSlSIjVbuZFmY79IpYwMooP7yo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:MWHPR2101MB0812;
x-ms-traffictypediagnostic: MWHPR2101MB0812:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB081278DF68DCFEA161A73C06CEB70@MWHPR2101MB0812.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(9452136761055)(189930954265078)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR2101MB0812;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0812;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(39380400002)(396003)(69234005)(199004)(189003)(13464003)(25786009)(3660700001)(2900100001)(3280700002)(106356001)(102836004)(97736004)(81156014)(74316002)(476003)(575784001)(86362001)(11346002)(446003)(53546011)(46003)(81166006)(22452003)(10090500001)(8990500004)(9686003)(105586002)(55016002)(316002)(2501003)(110136005)(33656002)(6306002)(5250100002)(6436002)(6506007)(8676002)(53936002)(5660300001)(8936002)(478600001)(7696005)(99286004)(186003)(486006)(6246003)(229853002)(59450400001)(966005)(6116002)(7736002)(76176011)(14454004)(86612001)(10290500003)(15650500001)(2201001)(305945005)(2906002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0812;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0VFuVsnpTh2Xx5VzRjpj4wpspFwkK9MsrhJS8dWLbKvX+xnvHnepQ85s3cFx0NyT44uj+RkY8suoKYAa4Pe1agW4TnsbHt0akP8YWiNF+dwVs1ls9iqyOj5fhWNWWkj5Y386/th29GRyem3aOwlNbVs4tRSstiEbyyDp+xOulReqVb8PG8DIuszx9Xbvxus3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3590839e-7277-477e-edbe-08d5a48eac72
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3590839e-7277-477e-edbe-08d5a48eac72
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:11:42.7380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0812
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Subject: RE: [PATCH 2/6] cifs: Allocate validate negoation request throug=
h
> kmalloc
>=20
>=20
>=20
> > -----Original Message-----
> > From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> > owner@vger.kernel.org] On Behalf Of Long Li
> > Sent: Monday, April 16, 2018 7:49 PM
> > To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org;
> > samba- technical@lists.samba.org; linux-kernel@vger.kernel.org; linux-
> > rdma@vger.kernel.org; stable@vger.kernel.org
> > Cc: longli <longli@microsoft.com>
> > Subject: [PATCH 2/6] cifs: Allocate validate negoation request through
> > kmalloc
> >
> > From: Long Li <longli@microsoft.com>
> >
> > The data buffer allocated on the stack can't be DMA'ed, and hence
> > can't send through RDMA via SMB Direct.
> >
> > Fix this by allocating the request on the heap in smb3_validate_negotia=
te.
> >
> Please provide Fixes ("12-letters commit id") "commit string" which
> introduced this issue and it is getting fixed here, so that other can app=
ly this
> fix to older versions.

Will do.

>=20
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  fs/cifs/smb2pdu.c | 38 ++++++++++++++++++++++----------------
> >  1 file changed, 22 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c index
> > 0f044c4..abbefe2
> > 100644
> > --- a/fs/cifs/smb2pdu.c
> > +++ b/fs/cifs/smb2pdu.c
> > @@ -730,7 +730,7 @@ SMB2_negotiate(const unsigned int xid, struct
> > cifs_ses
> > *ses)  int smb3_validate_negotiate(const unsigned int xid, struct
> > cifs_tcon
> > *tcon)  {
> >  	int rc =3D 0;
> > -	struct validate_negotiate_info_req vneg_inbuf;
> > +	struct validate_negotiate_info_req *pneg_inbuf;
> [..]
>=20
> >  	rc =3D SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
> >  		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
> > -		(char *)&vneg_inbuf, sizeof(struct
> > validate_negotiate_info_req),
> > +		(char *)pneg_inbuf, sizeof(struct
> validate_negotiate_info_req),
> >  		(char **)&pneg_rsp, &rsplen);
> >
> >  	if (rc !=3D 0) {
> >  		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
> > +		kfree(pneg_inbuf);
> >  		return -EIO;
> Instead of duplicating code here, please jump to err_rsp_free label. Kfre=
e()
> takes care to not panic for NULL pointer.
> Or for clarity define new label.

I will fix this.

>=20
> >  	}
> >
> > @@ -838,12 +842,14 @@ int smb3_validate_negotiate(const unsigned int
> > xid, struct cifs_tcon *tcon)
> >
> >  	/* validate negotiate successful */
> >  	cifs_dbg(FYI, "validate negotiate info successful\n");
> > +	kfree(pneg_inbuf);
> >  	kfree(pneg_rsp);
> >  	return 0;
> >
> >  vneg_out:
> >  	cifs_dbg(VFS, "protocol revalidation - security settings
> > mismatch\n");
> >  err_rsp_free:
> > +	kfree(pneg_inbuf);
> >  	kfree(pneg_rsp);
> >  	return -EIO;
> >  }
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rdma"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at
> >
> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fvger.k
> > ernel.org%2Fmajordomo-
> info.html&data=3D02%7C01%7Clongli%40microsoft.com%
> >
> 7Cc8c0b791819745b7403408d5a417d9d2%7C72f988bf86f141af91ab2d7cd011d
> b47%
> >
> 7C1%7C0%7C636595344704783010&sdata=3D99vU6g%2FE5b8TG8Dn2MngmNw
> pP5MghgdoV
> > hBf0sak%2B0w%3D&reserved=3D0
