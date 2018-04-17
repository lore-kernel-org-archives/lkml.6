Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-669745-1523937686-2-7235002703818556691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523937686; b=BZ+SSAXl36KXYpUzNDJZcGSO4ofyPJOse/WTbU8jkHGwTaSBhi
    TappMQlrHMQsYqB6hvGPK2aJ9h3xP5HPX647IKLSmEFyQZgsIZ/OlX/CUx8HRz9Y
    teFhpkcekpWYSEmdG1rxFDHzv8c4LdG8Wgm14DCZ1mjHL7XprEiiuKQTunfEUW0B
    RVyJAcRywbe+6QacxNlFmPhysrqKM/t3BcHSiqDMa2RnIqcyo3s5xMomI0lkDDdq
    MvCVabdpUUz/M2UDvVvioiOpFGV++20la264iDX3/rHjxt3YEH+0gzEWEHtjvmRm
    FsRJ79MAX4IFh+LqlsKDSxlYQzKV9gn/xL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523937686; bh=NwuLMzu8mt
    aYZryVO25mpka5KI8GTjmk2yxdsbx2rZ0=; b=l+j4xZ6PrZ84HWbOjiXIqGBNtj
    UxRzQfDCQA1MqHYRuKDhJV97ijdZ534ELlpmY6C6d3W6hYiertXX9cQsEOeHO6OS
    efQ2Z+YMJSDZf6Msvx8FtVcUAgPU7Pp/penQ3l8tt2HTF7AggvkeMttPnbpdfIxN
    1C7IMSkw3f26i9PX3Ya1dhQj3jrpEtzAftnZ8UZmsir0m4HAdfIeWadSoOeBj8Xf
    pL/NyDqaV7oNuQhwJhePepVuui5A+xHUjiZKJwwIGYmnS1fTbC6LIISK4tbrsGmI
    oBZImqmZHORDLygoCNl3Ai37oaHOKGtk7QB77T7Dd6AFMe2MRebMqihemt1w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=qbyIf31y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mellanox.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=qbyIf31y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mellanox.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDV8SImWD7pj9E2vURQXJj8TV+8GccwMFw03FonvDh3cSEX5PiUMSwU0gDvKS+EgeQBOEncMDhTsOZJ+PLOXGeEsdD+O9ocEtfU37ShPe5hZaBWRJ+RQ
    4XvpJMcTTiPjtNP3aIR/8+CfIwbRgjnfBZV2A57UEm6WpEWfpoWVoogme5yGaGs8bhaJ0uoCcQAtMkVXwGznyFEt5JSC/cBJq176X/18jFfgU869hjGeH5DJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Jm_mT5X-4QkA:10 a=BhY1vy-N530A:10
    a=CmCOOYeSSB4A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=oc4Ydm_t_UAA:10 a=VwQbUJbxAAAA:8 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8
    a=ePs0dZ3EL0qgRR8dqMwA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HvKuF1_PTVFglORKqfwH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750738AbeDQEBL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 00:01:11 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:17728
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750725AbeDQEBK (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 00:01:10 -0400
From: Parav Pandit <parav@mellanox.com>
To: longli <longli@microsoft.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/6] cifs: Allocate validate negoation request through
 kmalloc
Thread-Topic: [PATCH 2/6] cifs: Allocate validate negoation request through
 kmalloc
Thread-Index: AQHT1eYvvWdTfOeF90KRqV1zAW+cKqQEVHxQ
Date: Tue, 17 Apr 2018 04:01:06 +0000
Message-ID: <VI1PR0502MB300847394E1E25FADDCC0BB7D1B70@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180417004918.29213-1-longli@linuxonhyperv.com>
 <20180417004918.29213-2-longli@linuxonhyperv.com>
In-Reply-To: <20180417004918.29213-2-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com;
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB2943;7:baLAR0oLBjpUzqV+IprWI04OGHgHV3NGBNI4hWXwUV+s7h3MetpjSmkKqujFtUOdaD8mo2kulbd/n3NGfDw6mew5Gmdkt+3lyAT3YC9FZ0DyRl8/JK6eCGhlxDPeL09EfvHO1hdFSusPj6w/+GribQ0rL8l9/I04u2sWRIXptFEDT7Z9Xo5o/Xymk/88/W9QS3blklvvNQ4Or/IZOltuSkWibqWToK7OfzLssiR1hny3OXBKZa2W/6FWI8LZjARE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB2943;
x-ms-traffictypediagnostic: VI1PR0502MB2943:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <VI1PR0502MB29437A91DACA9E9DF837DC30D1B70@VI1PR0502MB2943.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0502MB2943;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB2943;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(396003)(366004)(346002)(13464003)(69234005)(199004)(189003)(14454004)(446003)(66066001)(476003)(68736007)(53936002)(55016002)(11346002)(81166006)(8676002)(81156014)(1511001)(486006)(186003)(110136005)(59450400001)(53546011)(7696005)(102836004)(6506007)(2201001)(305945005)(99286004)(9686003)(6306002)(316002)(6116002)(5660300001)(7736002)(3846002)(5250100002)(74316002)(2501003)(25786009)(76176011)(106356001)(2900100001)(105586002)(97736004)(229853002)(33656002)(6246003)(26005)(3280700002)(10710500007)(86362001)(2906002)(478600001)(966005)(8936002)(15650500001)(8666007)(3660700001)(2420400007)(6436002)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB2943;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fjBwiBOAtaLNFccF9ArMgpHpLLke+KeInnwattIPOVvPC8D95S7Z4LGTm+Y6/gywwU6g/c9K5BndFvGkrLHNgE6WbIYHn0/62PfepbXeoDIyPKAuqTLzuh3mlV9E66IjUfJDrnZbm29+xuEoZOCDQWXgUCuvWhBimG7cHukHbBLt84fhx/ttuphYaLl3ULD4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 825a9bee-a841-4a0c-9abc-08d5a417d866
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825a9bee-a841-4a0c-9abc-08d5a417d866
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 04:01:06.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2943
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> owner@vger.kernel.org] On Behalf Of Long Li
> Sent: Monday, April 16, 2018 7:49 PM
> To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org; samba-
> technical@lists.samba.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; stable@vger.kernel.org
> Cc: longli <longli@microsoft.com>
> Subject: [PATCH 2/6] cifs: Allocate validate negoation request through km=
alloc
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
Please provide Fixes ("12-letters commit id") "commit string" which introdu=
ced this issue and it is getting fixed here, so that other can apply this f=
ix to older versions.

> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  fs/cifs/smb2pdu.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c index 0f044c4..abbefe2
> 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -730,7 +730,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_se=
s
> *ses)  int smb3_validate_negotiate(const unsigned int xid, struct cifs_tc=
on
> *tcon)  {
>  	int rc =3D 0;
> -	struct validate_negotiate_info_req vneg_inbuf;
> +	struct validate_negotiate_info_req *pneg_inbuf;
[..]
=20
>  	rc =3D SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
>  		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
> -		(char *)&vneg_inbuf, sizeof(struct
> validate_negotiate_info_req),
> +		(char *)pneg_inbuf, sizeof(struct validate_negotiate_info_req),
>  		(char **)&pneg_rsp, &rsplen);
>=20
>  	if (rc !=3D 0) {
>  		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
> +		kfree(pneg_inbuf);
>  		return -EIO;
Instead of duplicating code here, please jump to err_rsp_free label. Kfree(=
) takes care to not panic for NULL pointer.
Or for clarity define new label.

>  	}
>=20
> @@ -838,12 +842,14 @@ int smb3_validate_negotiate(const unsigned int xid,
> struct cifs_tcon *tcon)
>=20
>  	/* validate negotiate successful */
>  	cifs_dbg(FYI, "validate negotiate info successful\n");
> +	kfree(pneg_inbuf);
>  	kfree(pneg_rsp);
>  	return 0;
>=20
>  vneg_out:
>  	cifs_dbg(VFS, "protocol revalidation - security settings mismatch\n");
>  err_rsp_free:
> +	kfree(pneg_inbuf);
>  	kfree(pneg_rsp);
>  	return -EIO;
>  }
> --
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in =
the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
