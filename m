Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1668458-1524512083-2-8131538781973154146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524512083; b=UFNp+yexHusAdmQRXn9HmF9yXaYzafWGfJlt+nf1/CGia/Ev40
    kPi9MueiGQu5IPRkUDGo03xJ4VNJNEk1P7oBi/k4eiz1bJr/JbB08CYcx/vt4L3C
    5lTwrIvDMo59B1ADHWxIxonGZ/q0hfWRSn4sBOLL0DZwfXnQgKknNhoTzhkfMGm2
    kf015mEoIxgw8auhnQ00xWfLeV6A/a0YhRgMENjHBL+3LH4i1l4RzQ4LO+dt44jB
    6eesV3fQRpvEi6f66PaxEUimaB78eJ1v/H21WMFOP493xsR1bG4Q2NdEm4k7a8un
    wkV09oTikApvuuIygI/yhtbNLuixgUMe2PpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524512083; bh=/0+q7jgeZZ
    8BLCX+9xnc/wvoz9UienDCQY18qF8MWGM=; b=OCV5HbnwPREh9m/O7QKMGmjpJp
    8+daN0UFX9No/arQUjONvlXqmn5BLarAD+gZFcpH5l6irQYDB1xqknDN7Pn9Vatl
    nvURcNZupuiVdAvQfFrlrJ+iPxhEL672WxHSXp7RoW0t7JITIsnTv3yu3i4WePAj
    1kQZjGso0OqVei9URHKukKSeXv6lwO9W+97TqY4NbHGgyVNP4JTpzxmvnPc0n+GK
    l4P57N+oX/zYzVKQe/YZPk3zfML99v7nzX/L+qmo951bkJ5MlXk60/lCbATElxjP
    fKiiC8Kom2fow+mL5/FyY/+AQzVzXgH25z2rxzrd+8at6zJubbC1LmYPQHEQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R/ABycN5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R/ABycN5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGDQ3NGkypBohdZaJrdEWawNIRnQCBKNU8ZlwJdnWaObQ0FAlQDeklyfghjJChwnYYvzYzETGer1tIY9MSOjAT5MXl/QG88oFT/2R9ueQ/OB9AiXgZ7Q
    cIqxFPcbkasCSmOpS5/3/8EoKeb1EU+HYP7R4cUA1gHJnt2czKmoCpFb+S3xuGKYoAdVhTRApj5HXHFvn5AKNFk2P8D4e1Rzc9+/VrxEO0loSAjQDKbyzsVL
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=e4gefjvWLagA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=VwQbUJbxAAAA:8 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8 a=aip6mLvEsr76wh07GZgA:9
    a=TmxZqaorOEYiFNM5:21 a=_ytHbtnQxTxftYeU:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HvKuF1_PTVFglORKqfwH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932461AbeDWTeh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 15:34:37 -0400
Received: from mail-co1nam03on0117.outbound.protection.outlook.com ([104.47.40.117]:22848
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932122AbeDWTe1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 23 Apr 2018 15:34:27 -0400
From: Long Li <longli@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v2 1/6] cifs: smbd: Check for iov length on sending the
 last iov
Thread-Topic: [Patch v2 1/6] cifs: smbd: Check for iov length on sending the
 last iov
Thread-Index: AQHT1oDczlFY9I1UcUSc2vCj92i4pKQNddoAgAFQOsA=
Date: Mon, 23 Apr 2018 19:34:23 +0000
Message-ID: <SN4PR2101MB07337EA730A456125CF72787CE890@SN4PR2101MB0733.namprd21.prod.outlook.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
 <DM5PR2101MB1030B8026AC0E48F3E96E739DC8A0@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB1030B8026AC0E48F3E96E739DC8A0@DM5PR2101MB1030.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:c::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR2101MB0814;7:Ya8TMz5nUxZVPmEP3FVVqaaCVIHcTYqTnB2TJg6l4qqhf73u/y399TujZ0DLevCd1kZzlAnaONpysKbee2FiIWkKIMaO6D+Z9IH+tltUy2mZmrMWU94qEMX2CMgtucLCz7/d7eidqkHjZVKylSQE7cy+fq4+WbsjH0kZu0bhmUV+6q6U5V3HNk0SAVo4YJX/OXLG7lFwkDRUiLROkhGyUpLKrsgGoa/Yg6XdBkPrQ0LKLkxRiCOjtzZYGUgERmGb;20:P3Zx/e9V6Kq1q+GfpuOcCnXSfRfDPAL9oacf448M6WwdAipJ9v8kN0Y5LJqVk5iX0w0/6z189iEnnSc2muZiqwgg1xuSxQycewlW8GJB70KkUqiR773nCJB/HPOJUdC38OdvHDEAV9WbVOnIzud4v8eASZ1+eRmslHjk6O6rgs8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:SN4PR2101MB0814;
x-ms-traffictypediagnostic: SN4PR2101MB0814:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <SN4PR2101MB0814AD0C872C5D0E93AE807ECE890@SN4PR2101MB0814.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN4PR2101MB0814;BCL:0;PCL:0;RULEID:;SRVR:SN4PR2101MB0814;
x-forefront-prvs: 06515DA04B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(13464003)(446003)(11346002)(102836004)(6116002)(6506007)(53546011)(2900100001)(76176011)(59450400001)(3660700001)(3280700002)(2906002)(7696005)(2201001)(33656002)(86612001)(53936002)(6246003)(9686003)(55016002)(575784001)(86362001)(1511001)(478600001)(25786009)(10290500003)(5660300001)(74316002)(4326008)(305945005)(229853002)(476003)(46003)(6436002)(316002)(22452003)(8936002)(81166006)(2501003)(5250100002)(110136005)(7736002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0814;H:SN4PR2101MB0733.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: MjxlOWfVFn9XbEDhmsDuJHlF1FCFKpakGjsVR/7DPjju5aOUgH3Ujb13N8iObYoDe1sz6OIYOHCEHJ6WSwHW62ijZJJ4hBtSwNfbAuMrH1nsPgnW+BcaKY+mf560ruXRKjWPtkl1m+GvSLmPAQO/FBvWFcMxWyrwkDCfrKLwUgsS7zyQuo5RX0bfXKlceJp+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c8b9e6d7-5920-4034-2f93-08d5a95137ff
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b9e6d7-5920-4034-2f93-08d5a95137ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2018 19:34:23.7847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0814
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Subject: RE: [Patch v2 1/6] cifs: smbd: Check for iov length on sending t=
he last
> iov
>=20
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > <linux-kernel-owner@vger.kernel.org> On Behalf Of Long Li
> > Sent: Tuesday, April 17, 2018 12:17 PM
> > To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org;
> > samba- technical@lists.samba.org; linux-kernel@vger.kernel.org;
> > linux-rdma@vger.kernel.org
> > Cc: Long Li <longli@microsoft.com>; stable@vger.kernel.org
> > Subject: [Patch v2 1/6] cifs: smbd: Check for iov length on sending
> > the last iov
> >
> > From: Long Li <longli@microsoft.com>
> >
> > When sending the last iov that breaks into smaller buffers to fit the
> > transfer size, it's necessary to check if this is the last iov.
> >
> > If this is the latest iov, stop and proceed to send pages.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Cc: stable@vger.kernel.org
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>=20
> But a question unrelated to this change arose during my review:  At the
> beginning and end of smbd_send(), the field smbd_send_pending is
> incremented and decremented, respectively.   The increment/decrement
> are not done as atomic operations.  Is this code guaranteed to be single
> threaded?  If not, the count could become corrupted, and
> smbd_destroy_rdma_work(), which waits for the count to become zero,
> could hang.  A similar question applies to smbd_recv_pending in smbd_recv=
().

It is safe. The transport sending path is locked by TCP_Server_Info->srv_mu=
tex.

The transport receiving path is single threaded.

>=20
> > ---
> >  fs/cifs/smbdirect.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c index
> > 90e673c..b5c6c0d 100644
> > --- a/fs/cifs/smbdirect.c
> > +++ b/fs/cifs/smbdirect.c
> > @@ -2197,6 +2197,8 @@ int smbd_send(struct smbd_connection *info,
> struct smb_rqst *rqst)
> >  						goto done;
> >  				}
> >  				i++;
> > +				if (i =3D=3D rqst->rq_nvec)
> > +					break;
> >  			}
> >  			start =3D i;
> >  			buflen =3D 0;
> > --
> > 2.7.4
