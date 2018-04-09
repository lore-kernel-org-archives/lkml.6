Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241398-2-16939555976663862223
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241397; b=XDum0+vvU19AV6Et6BNTa8zQwjmzxUKohp/2WMdQ1KDxePezfP
    yNWJrMyoG6+xKojMHv2N1rBdm2RH6FHAan3/7Cz/tprbdPNbdgWMJ0c6buQXS2zp
    qZ7y3GaXSSC8OKgqsiQF4dN65aAbiJRDKTNiJspGpndjEW4ejSWmbhRwkj+hpcWh
    2jMfW9a79mGWWxWYPop7D9fUzcRVIHr4cXMd3RF9WInBm1WBBoNwXXrja5WcRlsT
    /RqFyXpCw4RVxakJSlZ0OODG5kYXXvBJXIYLhHRIHxkwQ97EBX2xSprEAkOXr86Z
    BX2txnSQJYzN/ZsOCqYPeSOpJZtBux3Hsc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241397; bh=/s312puWS8
    8UrLu1WagIDH5Qdn8TsbspiVKhMCOtwt4=; b=isdWpKrC4h/pRv6Ej6IBx9Ri8B
    z9aFo3Zb+OWmNL8a18otiWc0U//VYlzuUP5GhEsn2H5xdbPWNFBSnAc0CJDhxFKD
    9Q/O53d7DTwnuejx5+TGASK4XBJ+3H6IdIY9J68dX5hPg449OeoxVE6UoJCQoapv
    6ZCEGNH2AK+6Jbrw/kmvTNWzhEEhqGR2cpUlvRfx3ZviTb9CdQXsZlDwPtxqZHNw
    ifdz5BHknUfZdKP+17Z98a0Wu/7ULXtLKGkdR4DYJJ8R1cDpTPOy9ogm80Mf6hKP
    Pi7BNSwNm8IrVHHcDF/fu77dPIIC7rMNF0IA2wLcxpsD1N29FUGV2/yf81vg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SHw1IfQ5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SHw1IfQ5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDnqEe00K+SftPRCTtLvAE5GKS4LFZyC45pIYHA6rOi7XVRHyn+7vDtq9lMbs0HQdMz/VXMMAPmb6Ne1EnzwLkvIktKhpK6MNy5Rj28WIKLFG8Su84jR
    yym2K/2t0VtLp8qTUvQZjeHmJrrP7C9CWHPc1qAVz2Qda1yYg3Kr8QoIfOs/NSCtehK8rXbArOUxiGt+Xbj5EsFFh+QT3KhZOnM59QRax0hjJFjKEdgfP1vZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=AGRr4plBAAAA:8
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=oEvlakYsqTb7HUBMxl8A:9 a=wPNLvfGTeEIA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=bOnWt3ThIoLzEnqt84vq:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754282AbeDICgU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:36:20 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755629AbeDIA1g (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 050/293] scsi: csiostor: Avoid content leaks
 and casts
Thread-Topic: [PATCH AUTOSEL for 4.9 050/293] scsi: csiostor: Avoid content
 leaks and casts
Thread-Index: AQHTz5j7Ov/h/F4C+0aasIraEihH7g==
Date: Mon, 9 Apr 2018 00:23:29 +0000
Message-ID: <20180409002239.163177-50-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:PSFTNZtmotjmgdCWbZoc3gD1TiltziA5wyr/N9olBGnu4d8xxwmVKlEJHCmLe1M+BEisK65Xu2qxU0UXz7SIoIlsLyi7Jar7EDCg92DOPwgy0dNFoWDTc1fw59GK8brdmZEGqFZQfkJe32LksCCvQEx7s+kwOSfXhVece9AKymojtBpRymLVm8lNmoARuLWNWMFX46VQjQPRLfFUy989C4WXYyCOw7AkysFUQXSh6Gm/1QR4zTXpV0Yl8DTFSh+z;20:/cLH+r77uoV4oxazOb89XAQ7pzlFl3Xo/GydBGjaw5f5ONYskheKeicwB1+5NRXOSM65m/G7Csk4TrJRn4Mk1ufcZmMHDZx0buj3f392HDghz2/2o72d+Lf0gwJvbH3FUE4jtSgpQG25TL+pL0k2Cwn2n/f4v8z34fiwF1d5d9Y=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a15c08f-51f9-48cc-684e-08d59db0add6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031ECA9849DFF76C724ABB6FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(39060400002)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oLlrzOSybHZZau2kseFUX7BCnWiMKkyTT/4kVN0TNP+IH+DXhb1KMAIRJjoK5KPvBLgGy8AVlca07/RBnp5BLNEDqP2nZrePZPU7hHq13fs9m3DlPObc154aFgsMYdKIggVIpxvQ4ARrsq2k2raiZPjSrKglGbHyxY6nb5fWCkPm9jmR9INs4fjrRCEoUkJnIc1YMrytHNuqnGcBJXbWGcyTTiOPMkAGAeo3gUYz9aIPBrbLCZgTx0cl/ksznTErljPidti7049gY5gr8yWnaVgBeRbr0CayJCuCWqxvTKKiBRspG2zxaTqkw3h5b+fsFzOpRKvJyP4kqc7b4V35+RbzBuKdbG+WXJ9tn8YjtuTpuLneDRgIHHYhPqDbnbE9EpnqTj0uhezhA+AL8cA8X/bySrY388k9ZKOMytwZDZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a15c08f-51f9-48cc-684e-08d59db0add6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:29.0655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 42c335f7e67029d2e01711f2f2bc6252277c8993 ]

When copying attributes, the len argument was padded out and the
resulting memcpy() would copy beyond the end of the source buffer.
Avoid this, and use size_t for val_len to avoid all the casts.
Similarly, avoid source buffer casts and use void *.

Additionally enforces val_len can be represented by u16 and that the DMA
buffer was not overflowed. Fixes the size of mfa, which is not
FC_FDMI_PORT_ATTR_MAXFRAMESIZE_LEN (but it will be padded up to 4). This
was noticed by the future CONFIG_FORTIFY_SOURCE checks.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/csiostor/csio_lnode.c | 43 +++++++++++++++++++++++-----------=
----
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_lnode.c b/drivers/scsi/csiostor/csi=
o_lnode.c
index c00b2ff72b55..be5ee2d37815 100644
--- a/drivers/scsi/csiostor/csio_lnode.c
+++ b/drivers/scsi/csiostor/csio_lnode.c
@@ -238,14 +238,23 @@ csio_osname(uint8_t *buf, size_t buf_len)
 }
=20
 static inline void
-csio_append_attrib(uint8_t **ptr, uint16_t type, uint8_t *val, uint16_t le=
n)
+csio_append_attrib(uint8_t **ptr, uint16_t type, void *val, size_t val_len=
)
 {
+	uint16_t len;
 	struct fc_fdmi_attr_entry *ae =3D (struct fc_fdmi_attr_entry *)*ptr;
+
+	if (WARN_ON(val_len > U16_MAX))
+		return;
+
+	len =3D val_len;
+
 	ae->type =3D htons(type);
 	len +=3D 4;		/* includes attribute type and length */
 	len =3D (len + 3) & ~3;	/* should be multiple of 4 bytes */
 	ae->len =3D htons(len);
-	memcpy(ae->value, val, len);
+	memcpy(ae->value, val, val_len);
+	if (len > val_len)
+		memset(ae->value + val_len, 0, len - val_len);
 	*ptr +=3D len;
 }
=20
@@ -335,7 +344,7 @@ csio_ln_fdmi_rhba_cbfn(struct csio_hw *hw, struct csio_=
ioreq *fdmi_req)
 	numattrs++;
 	val =3D htonl(FC_PORTSPEED_1GBIT | FC_PORTSPEED_10GBIT);
 	csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_SUPPORTEDSPEED,
-			   (uint8_t *)&val,
+			   &val,
 			   FC_FDMI_PORT_ATTR_SUPPORTEDSPEED_LEN);
 	numattrs++;
=20
@@ -346,23 +355,22 @@ csio_ln_fdmi_rhba_cbfn(struct csio_hw *hw, struct csi=
o_ioreq *fdmi_req)
 	else
 		val =3D htonl(CSIO_HBA_PORTSPEED_UNKNOWN);
 	csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_CURRENTPORTSPEED,
-			   (uint8_t *)&val,
-			   FC_FDMI_PORT_ATTR_CURRENTPORTSPEED_LEN);
+			   &val, FC_FDMI_PORT_ATTR_CURRENTPORTSPEED_LEN);
 	numattrs++;
=20
 	mfs =3D ln->ln_sparm.csp.sp_bb_data;
 	csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_MAXFRAMESIZE,
-			   (uint8_t *)&mfs, FC_FDMI_PORT_ATTR_MAXFRAMESIZE_LEN);
+			   &mfs, sizeof(mfs));
 	numattrs++;
=20
 	strcpy(buf, "csiostor");
 	csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_OSDEVICENAME, buf,
-			   (uint16_t)strlen(buf));
+			   strlen(buf));
 	numattrs++;
=20
 	if (!csio_hostname(buf, sizeof(buf))) {
 		csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_HOSTNAME,
-				   buf, (uint16_t)strlen(buf));
+				   buf, strlen(buf));
 		numattrs++;
 	}
 	attrib_blk->numattrs =3D htonl(numattrs);
@@ -444,33 +452,32 @@ csio_ln_fdmi_dprt_cbfn(struct csio_hw *hw, struct csi=
o_ioreq *fdmi_req)
=20
 	strcpy(buf, "Chelsio Communications");
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_MANUFACTURER, buf,
-			   (uint16_t)strlen(buf));
+			   strlen(buf));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_SERIALNUMBER,
-			   hw->vpd.sn, (uint16_t)sizeof(hw->vpd.sn));
+			   hw->vpd.sn, sizeof(hw->vpd.sn));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_MODEL, hw->vpd.id,
-			   (uint16_t)sizeof(hw->vpd.id));
+			   sizeof(hw->vpd.id));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_MODELDESCRIPTION,
-			   hw->model_desc, (uint16_t)strlen(hw->model_desc));
+			   hw->model_desc, strlen(hw->model_desc));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_HARDWAREVERSION,
-			   hw->hw_ver, (uint16_t)sizeof(hw->hw_ver));
+			   hw->hw_ver, sizeof(hw->hw_ver));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_FIRMWAREVERSION,
-			   hw->fwrev_str, (uint16_t)strlen(hw->fwrev_str));
+			   hw->fwrev_str, strlen(hw->fwrev_str));
 	numattrs++;
=20
 	if (!csio_osname(buf, sizeof(buf))) {
 		csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_OSNAMEVERSION,
-				   buf, (uint16_t)strlen(buf));
+				   buf, strlen(buf));
 		numattrs++;
 	}
=20
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_MAXCTPAYLOAD,
-			   (uint8_t *)&maxpayload,
-			   FC_FDMI_HBA_ATTR_MAXCTPAYLOAD_LEN);
+			   &maxpayload, FC_FDMI_HBA_ATTR_MAXCTPAYLOAD_LEN);
 	len =3D (uint32_t)(pld - (uint8_t *)cmd);
 	numattrs++;
 	attrib_blk->numattrs =3D htonl(numattrs);
@@ -1794,6 +1801,8 @@ csio_ln_mgmt_submit_req(struct csio_ioreq *io_req,
 	struct csio_mgmtm *mgmtm =3D csio_hw_to_mgmtm(hw);
 	int rv;
=20
+	BUG_ON(pld_len > pld->len);
+
 	io_req->io_cbfn =3D io_cbfn;	/* Upper layer callback handler */
 	io_req->fw_handle =3D (uintptr_t) (io_req);
 	io_req->eq_idx =3D mgmtm->eq_idx;
--=20
2.15.1
