Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2367869-1523987721-2-18196511775901178930
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
    1523987720; b=p05a7UrlBV3L7JMUCDjDHXn1LP6kF6uGbPyrsxxTd0MCiMS8MP
    CzUa9SWKU5AnZTfwEIsGkZ5jyP7koaaYj9eCtI9bTVziYD2N2I4B9awZ8b1/UpU0
    dNgLtNMaChsczy9Fc946KEHVKCxYrIC4E2tfglNtDkUY/lhvWV3RvTNG+mTmDa9R
    HExs8NEIhrQLlnyxgxppJ0BLcSNr4mPv6wabeGayMf3OlpuRgllOZjAaXf1/3g1E
    yoqt0mFUsf4noqjLeZNqP8h3wmT2N1Hm1sLUbEmKmcqu9xXN9/hSiAahDNxRWPyr
    gUE+qOkSJZq9EotI3TfmQyu0H2vKdHtH1l/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523987720; bh=DEwfYJGrNz
    RM6AhvZOg1D5kXn619SAtLNzTjVDxaY0k=; b=SQ9Jy5FRaONtqrdmbcsPylD6mR
    BT+kblvpcurtVdLIAzMnG5PvB9coVbUCJuUTEjMXH8qV1biK2BUMIvCGN15O36HH
    5jBZsKmoATtpB1NPEmy0C1ZpQ/Zz/QhN0RvN9ml33D5Ir83tdWtI6+KtN6YhpL5j
    53B0Q3iV40al4Xl7RO5Cumv6BS9CxzfHjEIlkvABD0o3OCpZZBKYAIBYFAlvXzwH
    Kes1AzBUOUANJNW8EJcnl+ZSmeBrUaY1qHaj5Bq2dzkYjDwQF4dCcfsRWKUm2aRU
    OgSjd/p+iDqD/0JyajJ1gOZANlXpt81xMk6ybedeD4gzQGDdJb9yIE6gpIJw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kHywlYXh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kHywlYXh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMPar4d8DmBf+jKxG0TycKrTBT5wJ0NQ+p+n/HMRmQt4Cmph7fQJ6/9N6f8H6l6DIq7ySAHdA9FzQcF8Urpsj7xswBE73L7jMlDwEE3yTIs4XpLDnTxF
    xoN8vlW6i1Pyc/JGMAV8+wjTq3pAVZfiDjFBytGkguEEFXqM1rH1S8co5kjIQxxXydzs96tFfwAZx2PYnZ7Cfho1f2FEaDeoq4dNUzNxYL+DfipDZOc1uqy8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=hjhv0kSH_I0A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=yMhMjlubAAAA:8 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8 a=Uo7PLVg6AAAA:8
    a=3IOYHEpcAAAA:8 a=OjFuwaGmNVfRNwH48pAA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=2fu9dSCF6UiAaB7K_VZn:22 a=pMmX26BmL46gMeuRjYg5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDQRzG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 13:55:06 -0400
Received: from mail-sn1nam01on0119.outbound.protection.outlook.com ([104.47.32.119]:13964
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752963AbeDQRzD (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 13:55:03 -0400
From: Long Li <longli@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/6] cifs: smbd: Check for iov length on sending the last
 iov
Thread-Topic: [PATCH 1/6] cifs: smbd: Check for iov length on sending the last
 iov
Thread-Index: AQHT1eYqyKsM87hAhUebjn5kwuJot6QEj9CAgACuqdA=
Date: Tue, 17 Apr 2018 17:55:00 +0000
Message-ID: <MWHPR2101MB0729066A1D5BB83987440EDECEB70@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180417004918.29213-1-longli@linuxonhyperv.com>
 <20180417072923.GA15310@kroah.com>
In-Reply-To: <20180417072923.GA15310@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:6::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0809;7:85kc9XnTa1hx3nWl1Dpzc1SsQeo7QFvohvgAuH+SleZ84p34VYCwYVS36l/EzCE4xDM2XVzGRUuz8XxGlSIPFBPxQvXnE87xf3C6bNBB105ko2hU23UYSW6RaWTTPuEW5Vn4lg17t3Jnvgyfvx1AIqxwHsiaF3s5rOdpVXQdTTGyzyffkLnOJTnb5hPQffXkp+oxNJDX1Q4ORoPqA1WDjWtX6puxgUhHsg0zxXjUvl/HB0ylVU65sc39ASOao17d;20:6EITyYjE1+NU0bbxNrUs8ABgsDQ0xy51uCYSTjkrx+6peAaNvJKN2hUNVDIEpW6k7/V1VLqr+zi39axkv34/0y82mpQSMLKpdH/VwyV8RpXGc2jXsmZafmgD6UDiBQoFV4O7pODcSmwEvXyrn8ArHOE61at0o3D7Xtfx2GBLVn8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MWHPR2101MB0809;
x-ms-traffictypediagnostic: MWHPR2101MB0809:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB08090636D9FF5D0D929CB498CEB70@MWHPR2101MB0809.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR2101MB0809;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0809;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39860400002)(396003)(346002)(366004)(199004)(189003)(6116002)(105586002)(8990500004)(6506007)(476003)(6436002)(55016002)(25786009)(68736007)(4326008)(7736002)(446003)(486006)(14454004)(10090500001)(106356001)(2900100001)(46003)(5660300001)(102836004)(11346002)(186003)(6246003)(229853002)(99286004)(10290500003)(7696005)(76176011)(478600001)(53936002)(54906003)(3280700002)(81156014)(305945005)(575784001)(86362001)(81166006)(9686003)(316002)(22452003)(97736004)(3660700001)(86612001)(33656002)(74316002)(966005)(6916009)(8936002)(6306002)(5250100002)(2906002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0809;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eeFoKfuiKyQgyyODxib6fQUmBX0g6CrQaiZEo5T46Eh4rblYGRmWxWT6tFlZWTcTo8qh1if6pa2cB6uDIt0PdT66OTReOFVP6vlKg/upoy15OyH3Pl5Pmt2jRtRBRb8EJVAHQyAcOnu5v/F7NpJdqNROwiFWgMoltXV5wPRvSzwcByq49DKqepZO0LEKhBIn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d43ce328-c7e2-4bfe-f08d-08d5a48c573f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43ce328-c7e2-4bfe-f08d-08d5a48c573f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:55:00.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0809
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Subject: Re: [PATCH 1/6] cifs: smbd: Check for iov length on sending the =
last
> iov
>=20
> On Mon, Apr 16, 2018 at 05:49:13PM -0700, Long Li wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > When sending the last iov that breaks into smaller buffers to fit the
> > transfer size, it's necessary to check if this is the last iov.
> >
> > If this is the latest iov, stop and proceed to send pages.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
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
>=20
> <formletter>
>=20
> This is not the correct way to submit patches for inclusion in the stable=
 kernel
> tree.  Please read:
>=20
> https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fstable-kernel-
> rules.html&data=3D02%7C01%7Clongli%40microsoft.com%7Cec2fc0284244483b
> 25bf08d5a434f6dc%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636
> 595469807590402&sdata=3DYXqnaTFgRyUyN1ubhCcyblT2ni%2F%2BCowPYJSFje
> 6PuCk%3D&reserved=3D0
> for how to do this properly.
>=20
> </formletter>

Will do. Thank you.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in =
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fvger.ke
> rnel.org%2Fmajordomo-
> info.html&data=3D02%7C01%7Clongli%40microsoft.com%7Cec2fc0284244483b2
> 5bf08d5a434f6dc%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6365
> 95469807590402&sdata=3Duu9VQ%2BHscmeFJH6kQEf39G2a7Y8M9hMmvBI2s9
> T1DXs%3D&reserved=3D0
