Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625563-1524098723-2-12346528963044921737
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524098722; b=TRCsC2d+DKAcE9Nyk+ZKzc09mDhdqSuTSx8B0e3mLjK6I/2KUl
    F0WdWTzFjHHqkzGWXI+tJXvi22iDsxSFkCWL/a/IWumaTXuF8T+fPcFsk6lVe3D7
    zIc0BiqbWAeYB8wEsvnGMnK9BbSmel0SnMfcz+HzaMe9UfPGPAMsGAhxpKmSuIuM
    1zTV+hVSqcFu/TemvfoGfczup70GaRTGBiuTwGwbGsKaNtplNgBzvmHo6y63ibcQ
    QrS6LHDQ7uekZpOMNtRKp2KMPCAN2WmV2dJsm/+GzQwfW5FQ/ZKL6a4i2Nvz/nwz
    mFi8A6OiUDUhpsMnQkH3JKZKuSL0BeI94xAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524098722; bh=Lc1oFa0Ndx
    4ZGVtDnv++zL5IMc1kkkJrXeNKQBWKG0I=; b=cPC8H8AhUfwEEyZ+QM5ntgWOMU
    ydbIE5Bq1mSYwlRBTbBLb03PvzBeouhMBZTuGdN50iSnbkXWHTkIumW9voUlxVl8
    saZKqAvYAOyEWAfIM/dFYYF8xwJ+DSaHakRC9udow0nzVHkk4pq0pzHpQOJLvO/K
    b1YsC1ztjsgMMYy1OfPwQNhVxCbycC4Pq6X5Owqq9Rz43sPuQv4f5V2knDwrA4rZ
    Jd4M8f911xgvloCkukuoZhyJKiTgkfXtGrezvN3b03gZb+5huOS+4gu52hYOx/KN
    CbeBeRG8ZFIuMoM+R7TUVvVjR49L0aTn4x/ipLb0bHShLRL1lfXkjmB9VkPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IeemEBBp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IeemEBBp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPw8REAWQXAv91tNNDFqNY8hYPmQJFwnXfqcb2Pl/SV1jPHrRiAnVPbW7488JAvCmNs16kwwK2eBHbXDlYTdLxNtbgabuPzppGD0xLQP2Rc3UHiFqj5x
    Gb3TTNTtQraK+7DGBBgZS2uNg76l0+fuqlc7QsZ3zgN6y62AI4ytjFTy848bDdY/N5LZkMkErs/9B/R642blgCeV5i3T2qap+UuxB6KkM1emJdXSDcnmM2vL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=_TKFW_rNyuwA:10 a=ezrDjaGQ7gEA:10
    a=IYp8n1Yz95QA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8
    a=CbDCq_QkAAAA:8 a=YE4yETFCQBwIUkyYGTcA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HvKuF1_PTVFglORKqfwH:22 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDSApT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 20:45:19 -0400
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:46080
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752391AbeDSApR (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 20:45:17 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Long Li <longli@microsoft.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v2 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Topic: [Patch v2 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Index: AQHT1oES6WnlDP3ofU2l3KWy9pX/X6QHP2hA
Date: Thu, 19 Apr 2018 00:45:14 +0000
Message-ID: <DM5PR2101MB1030884AD39F91A77BC0E16EDCB50@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
 <20180417191710.14855-2-longli@linuxonhyperv.com>
In-Reply-To: <20180417191710.14855-2-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-19T00:45:12.3883014Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5SPR01MB348;7:o2lqtrLVKwv1fONPdK+HbI8vSpix1mOa2km+qEOtCnPMmCJsuIWZwO5f6nu+BUHXnTFLAVdpB3YgJfG8JxvnVXqY7SzVxTe2fwzkho7bkrvFl+4Gj5rn6TDeL5A2kbVnlwySWw8LCj4tkab0TUzwfyp0zGmGv0UI9FCtW9rQh/vDq7W29AWH4grhJPQAN1LKEmnP9Fq6EuX8XcaI3TLBr3xUzUn5h5Kg9m7XUfPJErj7Qom5kQNWr4oxJnx6nG2a;20:9/Bt9fbsXePPNtRkAUW9oev+rv6islj4jcHuEd74pn+haAoBcDcuiBwD0RuEmPrxbVc0Ih2Hgea7WeISvnPXAp3uusxdygQEvDiQRUiwQfVWpNV2YmvfZGqi6XazRyDwDPowOQdDPNoBopXPk6kZqKz0YxALIntd4a30vHVMv4w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:DM5SPR01MB348;
x-ms-traffictypediagnostic: DM5SPR01MB348:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <DM5SPR01MB34856E568781BA0F0CA0ABEDCB50@DM5SPR01MB348.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(192374486261705)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501371)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5SPR01MB348;BCL:0;PCL:0;RULEID:;SRVR:DM5SPR01MB348;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(346002)(69234005)(1511001)(6436002)(5660300001)(10090500001)(55016002)(9686003)(86362001)(74316002)(575784001)(86612001)(66066001)(7696005)(76176011)(7736002)(305945005)(15650500001)(6506007)(53936002)(53546011)(2900100001)(59450400001)(99286004)(229853002)(26005)(102836004)(2501003)(476003)(8936002)(11346002)(81166006)(8676002)(4326008)(316002)(5250100002)(3846002)(110136005)(6116002)(25786009)(10290500003)(478600001)(72206003)(33656002)(14454004)(22452003)(2906002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5SPR01MB348;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: NsVYRVCUd7sgtegiVViccIv4g0NzGPQh+gk9QxY1mazEwk3Y6IlUqpNYQgUZbjTWNkaitvU2Sww2ktGYdw3fZ/f+8MRRY3ANBndfSawc//HO/IwRbmryglbaBNtBWc0Tjjy/S3y7BWw1t+NLNZNJ3WXsW+GOfncAxFcf/d9f4wOmrkG638KlHTZERp/AOPmU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 477608ce-8b6e-4441-e2c2-08d5a58ed111
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477608ce-8b6e-4441-e2c2-08d5a58ed111
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 00:45:15.1560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR01MB348
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf
> Of Long Li
> Sent: Tuesday, April 17, 2018 12:17 PM
> To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org; samba-
> technical@lists.samba.org; linux-kernel@vger.kernel.org; linux-rdma@vger.=
kernel.org
> Cc: Long Li <longli@microsoft.com>; stable@vger.kernel.org
> Subject: [Patch v2 2/6] cifs: Allocate validate negotiation request throu=
gh kmalloc
>=20
> From: Long Li <longli@microsoft.com>
>=20
> The data buffer allocated on the stack can't be DMA'ed, and hence can't s=
end
> through RDMA via SMB Direct.
>=20
> Fix this by allocating the request on the heap in smb3_validate_negotiate=
.
>=20
> Fixes: ff1c038addc4f205d5f1ede449426c7d316c0eed "Check SMB3 dialects agai=
nst
> downgrade attacks"
>=20
> Changes in v2:
> Removed duplicated code on freeing buffers on function exit.
> (Thanks to Parav Pandit <parav@mellanox.com>)
>=20
> Fixed typo in the patch title.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/cifs/smb2pdu.c | 57 ++++++++++++++++++++++++++++++-------------------=
------
>  1 file changed, 31 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 0f044c4..41625e4 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -729,8 +729,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_se=
s *ses)
>=20
>  int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tc=
on)
>  {
> -	int rc =3D 0;
> -	struct validate_negotiate_info_req vneg_inbuf;
> +	int ret, rc =3D -EIO;
> +	struct validate_negotiate_info_req *pneg_inbuf;
>  	struct validate_negotiate_info_rsp *pneg_rsp =3D NULL;
>  	u32 rsplen;
>  	u32 inbuflen; /* max of 4 dialects */
> @@ -741,6 +741,9 @@ int smb3_validate_negotiate(const unsigned int xid, s=
truct cifs_tcon
> *tcon)
>  	if (tcon->ses->server->rdma)
>  		return 0;
>  #endif
> +	pneg_inbuf =3D kmalloc(sizeof(*pneg_inbuf), GFP_KERNEL);
> +	if (!pneg_inbuf)
> +		return -ENOMEM;

Immediately after the above new code, there are three if statements that ca=
n
'return 0' and never free the pneg_inbuf memory.  They should instead set '=
rc'
appropriately and 'goto' the out_free_inbuf label.

Michael

>=20
>  	/* In SMB3.11 preauth integrity supersedes validate negotiate */
>  	if (tcon->ses->server->dialect =3D=3D SMB311_PROT_ID)
> @@ -764,53 +767,53 @@ int smb3_validate_negotiate(const unsigned int xid,=
 struct cifs_tcon
> *tcon)
>  	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
>  		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by serv=
er\n");
>=20
> -	vneg_inbuf.Capabilities =3D
> +	pneg_inbuf->Capabilities =3D
>  			cpu_to_le32(tcon->ses->server->vals->req_capabilities);
> -	memcpy(vneg_inbuf.Guid, tcon->ses->server->client_guid,
> +	memcpy(pneg_inbuf->Guid, tcon->ses->server->client_guid,
>  					SMB2_CLIENT_GUID_SIZE);
>=20
>  	if (tcon->ses->sign)
> -		vneg_inbuf.SecurityMode =3D
> +		pneg_inbuf->SecurityMode =3D
>  			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_REQUIRED);
>  	else if (global_secflags & CIFSSEC_MAY_SIGN)
> -		vneg_inbuf.SecurityMode =3D
> +		pneg_inbuf->SecurityMode =3D
>  			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_ENABLED);
>  	else
> -		vneg_inbuf.SecurityMode =3D 0;
> +		pneg_inbuf->SecurityMode =3D 0;
>=20
>=20
>  	if (strcmp(tcon->ses->server->vals->version_string,
>  		SMB3ANY_VERSION_STRING) =3D=3D 0) {
> -		vneg_inbuf.Dialects[0] =3D cpu_to_le16(SMB30_PROT_ID);
> -		vneg_inbuf.Dialects[1] =3D cpu_to_le16(SMB302_PROT_ID);
> -		vneg_inbuf.DialectCount =3D cpu_to_le16(2);
> +		pneg_inbuf->Dialects[0] =3D cpu_to_le16(SMB30_PROT_ID);
> +		pneg_inbuf->Dialects[1] =3D cpu_to_le16(SMB302_PROT_ID);
> +		pneg_inbuf->DialectCount =3D cpu_to_le16(2);
>  		/* structure is big enough for 3 dialects, sending only 2 */
>  		inbuflen =3D sizeof(struct validate_negotiate_info_req) - 2;
>  	} else if (strcmp(tcon->ses->server->vals->version_string,
>  		SMBDEFAULT_VERSION_STRING) =3D=3D 0) {
> -		vneg_inbuf.Dialects[0] =3D cpu_to_le16(SMB21_PROT_ID);
> -		vneg_inbuf.Dialects[1] =3D cpu_to_le16(SMB30_PROT_ID);
> -		vneg_inbuf.Dialects[2] =3D cpu_to_le16(SMB302_PROT_ID);
> -		vneg_inbuf.DialectCount =3D cpu_to_le16(3);
> +		pneg_inbuf->Dialects[0] =3D cpu_to_le16(SMB21_PROT_ID);
> +		pneg_inbuf->Dialects[1] =3D cpu_to_le16(SMB30_PROT_ID);
> +		pneg_inbuf->Dialects[2] =3D cpu_to_le16(SMB302_PROT_ID);
> +		pneg_inbuf->DialectCount =3D cpu_to_le16(3);
>  		/* structure is big enough for 3 dialects */
>  		inbuflen =3D sizeof(struct validate_negotiate_info_req);
>  	} else {
>  		/* otherwise specific dialect was requested */
> -		vneg_inbuf.Dialects[0] =3D
> +		pneg_inbuf->Dialects[0] =3D
>  			cpu_to_le16(tcon->ses->server->vals->protocol_id);
> -		vneg_inbuf.DialectCount =3D cpu_to_le16(1);
> +		pneg_inbuf->DialectCount =3D cpu_to_le16(1);
>  		/* structure is big enough for 3 dialects, sending only 1 */
>  		inbuflen =3D sizeof(struct validate_negotiate_info_req) - 4;
>  	}
>=20
> -	rc =3D SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
> +	ret =3D SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
>  		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
> -		(char *)&vneg_inbuf, sizeof(struct validate_negotiate_info_req),
> +		(char *)pneg_inbuf, sizeof(struct validate_negotiate_info_req),
>  		(char **)&pneg_rsp, &rsplen);
>=20
> -	if (rc !=3D 0) {
> -		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
> -		return -EIO;
> +	if (ret !=3D 0) {
> +		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", ret);
> +		goto out_free_inbuf;
>  	}
>=20
>  	if (rsplen !=3D sizeof(struct validate_negotiate_info_rsp)) {
> @@ -820,7 +823,7 @@ int smb3_validate_negotiate(const unsigned int xid, s=
truct cifs_tcon
> *tcon)
>  		/* relax check since Mac returns max bufsize allowed on ioctl */
>  		if ((rsplen > CIFSMaxBufSize)
>  		     || (rsplen < sizeof(struct validate_negotiate_info_rsp)))
> -			goto err_rsp_free;
> +			goto out_free_rsp;
>  	}
>=20
>  	/* check validate negotiate info response matches what we got earlier *=
/
> @@ -838,14 +841,16 @@ int smb3_validate_negotiate(const unsigned int xid,=
 struct cifs_tcon
> *tcon)
>=20
>  	/* validate negotiate successful */
>  	cifs_dbg(FYI, "validate negotiate info successful\n");
> -	kfree(pneg_rsp);
> -	return 0;
> +	rc =3D 0;
> +	goto out_free_rsp;
>=20
>  vneg_out:
>  	cifs_dbg(VFS, "protocol revalidation - security settings mismatch\n");
> -err_rsp_free:
> +out_free_rsp:
>  	kfree(pneg_rsp);
> -	return -EIO;
> +out_free_inbuf:
> +	kfree(pneg_inbuf);
> +	return rc;
>  }
>=20
>  enum securityEnum
> --
> 2.7.4
