Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3766210-1524439649-2-16213157459228657901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524439649; b=tzuoquFRhy023t45ltnSfR6Dq/MrTqh8ZksBX6MSpkZcVAGAsW
    iGFmSbaDF6vrMHxzNBextKTwhXM9MNR4rcjvD6e1SLKrSlN99Qr65DbbxQxdPZ0O
    XZYXEk8nrDTreGujwsMpy10/n0rsT55h7XZoEwQy1juOQ67EQ+equfs772RqCSev
    CqhaxO8B3YOA6eGS/KSn8iZ08gYK2LPBK/C7Mbzmdp7kyOWfcnUzGoZxKPKtK2Gn
    ZLNjg05t6IPLAOc1iYTEt+g+Ti9BWL7dQGPtMEzrAxQJOVrAiA7Y6bAMVI7T9YOr
    ENCQGpDs/ksc1ZKMLnlklKSxy6KkW8q3qOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524439649; bh=e05kWp9Xki
    2PBJrDcJbelgJr/G/tADuhT1izr16lbgo=; b=tMcDAWciNXFAeE9RexKSN28b+x
    FKSGdRnH6s9H5BE2k2wck8Z2JBVrsjE0aEi0Fj8KuCcRChKv4BxnfF2pdIuVjcz2
    THXhA08PWFvwEKSeIc9FXjt3KHAdUzdu+m6RlT73LV5Bef0iLvKVZed1uQt7jWvx
    nZy88yOPfTw9aSjQkAoIPaLRe13KaLqMXWso2WgFE5f2FwUoEy7TIbuUepFMLgEs
    0U3E5ycDhiLm2+fw3Hdd8/5IRuioVsWej2mi1A5rtbOaSQsx/iLrH8idMbOFWpxT
    iJcv23paGtZLPV+4LkmeLMBhvuwWK9MZ6yBbE3QSi2C0KjK7ITRBZ4ZraDGg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A4Zdus4m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A4Zdus4m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ1Y12p91C2e6c2g0IioQzqQSqW2z8UFtxr608iAmAofolswUdB65mhse7QB8qruZeZD5SYIORHHW1YENbEgm5eDxrQwIsvI5jRi/xhgGOBgfK7j+vNQ
    PpO5axdvLFr2K53pFLSRbLevsfJoO5NeYxHYzj3JHzszPpY3XTn0PK7dQfFQjWv5wdRNGomuCefykNITSbhLFhcVeh/ebuzKMyzfCYFFwakms+1Y+4Logyu9
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=_TKFW_rNyuwA:10 a=ezrDjaGQ7gEA:10
    a=e4gefjvWLagA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8
    a=Y5uYT7XmatoUH_M79b8A:9 a=QR12a3v1FKLuMbuM:21 a=Of005SegHAtC6-Tc:21
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=HvKuF1_PTVFglORKqfwH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753716AbeDVX1N (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 19:27:13 -0400
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:49773
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753644AbeDVX1L (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 22 Apr 2018 19:27:11 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Long Li <longli@microsoft.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v2 1/6] cifs: smbd: Check for iov length on sending the
 last iov
Thread-Topic: [Patch v2 1/6] cifs: smbd: Check for iov length on sending the
 last iov
Thread-Index: AQHT1oDjzGcq39RzU0qbElHNScrUY6QNco3g
Date: Sun, 22 Apr 2018 23:27:08 +0000
Message-ID: <DM5PR2101MB1030B8026AC0E48F3E96E739DC8A0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
In-Reply-To: <20180417191710.14855-1-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-22T23:27:07.3255512Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:zl26zSwEQznH9T8N5uR/5fDFWl5lbhn4/mA1Ee55hRB78tXWursSxgRGlzJ4HbMtqp4GO+WeoYm87dEnHFc0XUYHBbOOEUdhnNYmfuhPJFz2xVv8w5uU3U1Z3J1n0ZHqBaezNrSFbQtJML2ABQVXFgxLQ2udkl2xqqr0N9dcSvGDD150PmD12lG0JXQnDr12gdEaMx8RdsruNEGzzBBFo1kMdIDs7ksQQVeyvNXLeMZVRCHxkKnBpBH8WL3poSBG;20:4Az+fmrXq98qPc49gxHSj6Nppef4k/6NnmOJT9QD/Q5tCphml8Zr/4Dtb5sM5opj9tkH8QT6C50FcGW/S/Hj3YSKJ9Ivktl8eVY9mqjP0EL30f3rrBwFBSg31E8ok1x2NTz1GbVEAsW4qIm01+USVJgfE5RyESu/AmOyQycSK/A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10138E6A6833364BA11847CEDC8A0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0650714AAA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(13464003)(5250100002)(2501003)(2906002)(86362001)(575784001)(6246003)(2201001)(86612001)(5660300001)(3280700002)(55016002)(3660700001)(1511001)(53936002)(2900100001)(66066001)(9686003)(6436002)(53546011)(6506007)(102836004)(478600001)(10290500003)(59450400001)(33656002)(11346002)(446003)(476003)(26005)(74316002)(4326008)(110136005)(25786009)(7696005)(305945005)(72206003)(229853002)(8676002)(3846002)(8936002)(316002)(6116002)(22452003)(81166006)(76176011)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: 2wOvlmIJwiAty47/o//puB+UzdDtFrvUqY34XdZIxm51qmBsQ3j9XkJhZzKS7RlsUuHDOFn9Brp7jOfhbMCYCZzy8FXtqHWdIAOgLPYFAGFAfBd9PTCLHGhFv4oDOwmcdFATk+qTP7EV6wW9OU15FnvvnYxoothWkkv5sqrLnXv0qSiyBntbmWWFZheFqpai
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 74842e7e-a8e2-4742-96a7-08d5a8a8916f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74842e7e-a8e2-4742-96a7-08d5a8a8916f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2018 23:27:08.9523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
> Subject: [Patch v2 1/6] cifs: smbd: Check for iov length on sending the l=
ast iov
>=20
> From: Long Li <longli@microsoft.com>
>=20
> When sending the last iov that breaks into smaller buffers to fit the
> transfer size, it's necessary to check if this is the last iov.
>=20
> If this is the latest iov, stop and proceed to send pages.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

But a question unrelated to this change arose during my review:  At the
beginning and end of smbd_send(), the field smbd_send_pending is
incremented and decremented, respectively.   The increment/decrement
are not done as atomic operations.  Is this code guaranteed to be single
threaded?  If not, the count could become corrupted, and
smbd_destroy_rdma_work(), which waits for the count to become zero,
could hang.  A similar question applies to smbd_recv_pending in smbd_recv()=
.

> ---
>  fs/cifs/smbdirect.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index 90e673c..b5c6c0d 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -2197,6 +2197,8 @@ int smbd_send(struct smbd_connection *info, struct =
smb_rqst *rqst)
>  						goto done;
>  				}
>  				i++;
> +				if (i =3D=3D rqst->rq_nvec)
> +					break;
>  			}
>  			start =3D i;
>  			buflen =3D 0;
> --
> 2.7.4
