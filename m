Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2662433-1523995171-2-8222946193618824740
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
    1523995170; b=FybVhNED11aO6PGgCJhm6DUF2J8NjroRFud2zwZ91Il938I6R7
    vKCotItBpn420n2rX4DfjXh2YOOyx9IBjxCpKbp4VUnwUcg3pGjaRIhUwJ4fCFVK
    i5JRbjqjol9xdU8dee1z+7Q16mv2DD/lLihBHVeYz8+JqTez08l58oR3LTfGP09x
    gqVv7aeXPEOiSzzMEn/jz8L3Hfls3s2DjjhKqh4r/lbGLc+NSVbwqQQHwIjDA9sV
    Qknr0zVio2L+PxfZ0GWH9loQiEVPwqBQy7cROCaUA74r/28qAA1ji91FPCmq3N/F
    +0Cd56piZnt+c5kWETteeAYzD/eRmvlZFo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523995170; bh=KCl3cFsItV
    gjOZPa//JMA0ASv2vQuIqi18axigKy8p4=; b=McnhH9JGjXs8sjy608FXSYtrxN
    p0bE70pkuGFJOT0OKlOnWcprBNHk0shzkX17gaJNygdm0YQTZJuW88kE3CmgzYnm
    25XLal038lJnuIPjt+YFCL/Gd+J7YvYJwhvD44MwKWubybFPp1/MVBoYT/cMF9k8
    kNT2vpV1SUfpQWEIa3z7TCnHdn2O+rl4sGzGrPylM1hDK+8gZRd49DTxgkCEjnfp
    hGKkb0yr2KxaX13TX3y64QrZnO/1gFiLq7iuhaYATsJAJkT7iHtDpddQGMw87Lr1
    eN/PoPHv8YyeyZhv6vPsgOI6dC1hDA/xHQucvx5jcDS+eVcFvBCiOhjfp7DA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=DOY5WIi8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mellanox.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=DOY5WIi8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mellanox.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOqEiJjgunA6VHU4Iel7Sipp/qS4qI1c1ZHPR2WSLFzwwa/4mbegqDESTjuFTgvm+gnElzOGx7jY48vVpmmhv5pC9/Zb+D6LJncC3BbDMf9VRPJyetuO
    SLWWoSuTKtqq3WaR1v3zCOD0VJq2Qtgp9Ec56Hpc28uR6EyKZZKKY5hGCndzQSlN+TbEtHDCQtR+kJuE7Lc8XKUsSdjtkhwibRFUumuM8du24MI4EqhDUehf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=SDJ9YVQZnCsA:10 a=uc37bbs8ZioA:10
    a=IYp8n1Yz95QA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=oc4Ydm_t_UAA:10 a=VwQbUJbxAAAA:8 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8
    a=CbDCq_QkAAAA:8 a=2ayqhItY8tbNbS-f8cAA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HvKuF1_PTVFglORKqfwH:22 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeDQT71 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 15:59:27 -0400
Received: from mail-ve1eur01on0042.outbound.protection.outlook.com ([104.47.1.42]:58900
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751878AbeDQT70 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 15:59:26 -0400
From: Parav Pandit <parav@mellanox.com>
To: longli <longli@microsoft.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v2 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Topic: [Patch v2 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Index: AQHT1oEb01Uf5oA4GUOijBkqXu9oSaQFXQ4Q
Date: Tue, 17 Apr 2018 19:59:22 +0000
Message-ID: <VI1PR0502MB30080A26FFC2A6132397C549D1B70@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
 <20180417191710.14855-2-longli@linuxonhyperv.com>
In-Reply-To: <20180417191710.14855-2-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1SPR01MB021;7://jqtvqA69ZlITAo3h97GdAiNnl6XwHJCwEAQqs74by68Q9nt34lcfrGOwtRchujzx7+rgXgWMbYmGIYD3AplG7NS/T6O2P0uoSwIpxGVxnu3/5F3DTdbMqchk5dNNA3xNsj7J+P3peYfHGZh59IB8DhTOWsGiPGwJsjhnfy8wwEdjnnAo16I3HBUhtmWARp6vx0YyNDNE/FQ3L5aJZesrtlSt/eFy8y7k8e/b7W97HpMlJ+H8/JjoW+9N5h8G7t
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1SPR01MB021;
x-ms-traffictypediagnostic: VI1SPR01MB021:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <VI1SPR01MB0218F06C78E4B2EDA6EDF5BD1B70@VI1SPR01MB021.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1SPR01MB021;BCL:0;PCL:0;RULEID:;SRVR:VI1SPR01MB021;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(376002)(396003)(346002)(13464003)(6116002)(53936002)(102836004)(14454004)(4326008)(8676002)(15650500001)(66066001)(1511001)(2201001)(8936002)(6246003)(3846002)(8666007)(81166006)(110136005)(575784001)(55016002)(9686003)(53546011)(5250100002)(25786009)(2906002)(316002)(6436002)(86362001)(26005)(6506007)(2501003)(11346002)(476003)(5660300001)(305945005)(7736002)(478600001)(68736007)(2900100001)(7696005)(3280700002)(33656002)(446003)(59450400001)(186003)(3660700001)(76176011)(229853002)(74316002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB021;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:nov;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: 2bviYgwF4M9L7S58Ub6HfcjVgWoDRU/h47Z5ZGdiJfBsTIRepnV5xlY1vAw7jRjh0JpttMTgyEga1y8B4ssR/Civt4JqlD9lytBYxAGW47eLE2GyuhaW18jioYK7+te8YP/Inrgp8ggVj2t+7M9iWwW1ndYH1F1UDJ9W+oTIJzIWn0L8D1afVSFAcJsX0iz2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4ce4808f-0e1a-49cb-a7cc-08d5a49db6de
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce4808f-0e1a-49cb-a7cc-08d5a49db6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 19:59:22.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB021
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> owner@vger.kernel.org] On Behalf Of Long Li
> Sent: Tuesday, April 17, 2018 2:17 PM
> To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org; samba-
> technical@lists.samba.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: longli <longli@microsoft.com>; stable@vger.kernel.org
> Subject: [Patch v2 2/6] cifs: Allocate validate negotiation request throu=
gh
> kmalloc
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
> Fixes: ff1c038addc4f205d5f1ede449426c7d316c0eed "Check SMB3 dialects
> against downgrade attacks"
>=20

Format is:
Fixes: ff1c038addc4 ("Check SMB3 dialects against downgrade attacks")
It should be right above Signed-off signature.

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
-----
> -
>  1 file changed, 31 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c index 0f044c4..41625e4
> 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -729,8 +729,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_se=
s
> *ses)
>=20
>  int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tc=
on)  {
> -	int rc =3D 0;
> -	struct validate_negotiate_info_req vneg_inbuf;
> +	int ret, rc =3D -EIO;
> +	struct validate_negotiate_info_req *pneg_inbuf;
>  	struct validate_negotiate_info_rsp *pneg_rsp =3D NULL;
>  	u32 rsplen;
>  	u32 inbuflen; /* max of 4 dialects */
> @@ -741,6 +741,9 @@ int smb3_validate_negotiate(const unsigned int xid,
> struct cifs_tcon *tcon)
>  	if (tcon->ses->server->rdma)
>  		return 0;
>  #endif
> +	pneg_inbuf =3D kmalloc(sizeof(*pneg_inbuf), GFP_KERNEL);
> +	if (!pneg_inbuf)
> +		return -ENOMEM;
>=20
>  	/* In SMB3.11 preauth integrity supersedes validate negotiate */
>  	if (tcon->ses->server->dialect =3D=3D SMB311_PROT_ID) @@ -764,53
> +767,53 @@ int smb3_validate_negotiate(const unsigned int xid, struct
> cifs_tcon *tcon)
>  	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
>  		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag sent
> by server\n");
>=20
> -	vneg_inbuf.Capabilities =3D
> +	pneg_inbuf->Capabilities =3D
>  			cpu_to_le32(tcon->ses->server->vals-
> >req_capabilities);
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
Please check if strncmp() should be used or not.

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
> -		(char *)&vneg_inbuf, sizeof(struct
> validate_negotiate_info_req),
> +		(char *)pneg_inbuf, sizeof(struct validate_negotiate_info_req),

Use sizeof(*pneg_inbuf)

>  		(char **)&pneg_rsp, &rsplen);
>=20
> -	if (rc !=3D 0) {
> -		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
> -		return -EIO;
> +	if (ret !=3D 0) {

if (ret) is fine.

> +		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", ret);
> +		goto out_free_inbuf;
>  	}
>=20
>  	if (rsplen !=3D sizeof(struct validate_negotiate_info_rsp)) { @@ -820,7

if (rsplen !=3D sizeof(*pneg_rsp))
