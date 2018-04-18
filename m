Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1550894-1524093515-2-12845239078517877154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524093514; b=vJFP9o/1srmrIxA5u1QqUsJMYUdqNtkN+GdCBio+ss9wYlfGk0
    dSDXLjme5oYOLdbUbOimSMRwonXwAxM37nzF0PudmsbbMohH112cJkGfswkXooRV
    iIzA1DunI4dmJAoLQJu+n5eSitCVFhqen/OOo23+Lx5EJJOWHP0Qf33EOgr9LpYN
    OHaMUV+sOWOPuizJwPJwAClpqLC5qN1hMrJjkVgHXOtorYUE141kzYuyioi1o60C
    8AsRpStMIwWUZGn+tNp9IFOWLBMj6eIul0iuknPtMtIBKHIKVl39X6rYbF5ks8bh
    WVnTYDzSMkLducZk1olydXdoyZxafKGPfSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524093514; bh=AHc/F
    /yKEVMhZgqnqO1c9+V3Y4oEeIpP4igkq6HY8tQ=; b=wNmleV0+DLFLTjRJ63dnX
    Q6X17BjWn8YgX+oYv2PHHP1jzIQfVEBfPkXfBoob7s6J6TYv6h0Zil0A9SR1GFtz
    wvTeTusMeZGfWt5jhgaujnRA6dRG/h09pYQBNNtjywVzu7dVkpcY9FbfSB/JofkZ
    g67sUyJiIDrYl9BdLsGDN2meN39GgdXh2H07yBo2Y3oGDg/aHO465R1K9XNwQLhI
    hdrkTpWbycLyKpOaIUroGnTJ9qjVL2TcbtrRyAq5koM2onGsq8fRVfN704969ckw
    JpGdrzDNhQmF687X5qmv3O2lO9Z+r3v9EVwWGiTwYQJy8LXG5OgU4LTe+umJbMFe
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HC7qTtKu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HC7qTtKu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDrBLZoOYGx0UmTEmZgtpgZ9lE2D0DV5R3ZlqwsIm6r0l76uGw6zaaPXweUi+RFA9vNxt2eTMwvpV2zYWH3gd4/f0GbtNKhcJUW2Q86Hw9hanHlD+wPv
    FSzg0tP1c8756B+jLaSzxCn9Jb04Lx4CmS/NWNYnf0fe8FUbV2AioAkb07kaM4wdT+DCLzR60qqGXJ7EzU+Uax9qzCb19TxzkCNtmpSonvdODghzQE2TzJ6c
    JvWUCfNwfODWvwkpl+JZVg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=R4fxTKrshSIA:10 a=qcIjco1Mu_QA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=6n1iNii3AAAA:8 a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8 a=N5xKz68KBvi0wFkQl8QA:9
    a=E5iL7HGgvEjgd2Aa:21 a=EHygHo3u-_NEYZOj:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=qL8UFIJES1IU-uv6apQ6:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Long Li <longli@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>, Long Li
 <longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "James
 E . J . Bottomley" <JBottomley@odin.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] storvsc: Set up correct queue depth values for IDE
 devices
Thread-Topic: [PATCH v2] storvsc: Set up correct queue depth values for IDE
 devices
Thread-Index: AQHTwieDOFEPhIGzxkyq2vCO89MZ9aPfnEKAgCe1+8A=
Date: Wed, 18 Apr 2018 23:18:21 +0000
Message-ID: <MWHPR2101MB072978A101FEFBCF2D32E872CEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180322214718.29547-1-longli@linuxonhyperv.com>
 <DM5PR2101MB1030FD5B6261CC7BCF0092D1DCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB1030FD5B6261CC7BCF0092D1DCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2101MB0730;
 7:RIFJdGnIm1xyzSIePGrWuXJN6Dc0O7R/uNT8Y7uvGERFatSu+libtfEFObGxgMOovdvKE1rYrmpueeYhWt5p8vBYga5YtZp/ei14R6ujaCqQYfk/gHJ+HRvNU5k/m4h4F9wKXF6fVTYEyEE/T0ZS01ixosXMT0t++rVvLiaYxe4KLCtcyaUiHeWJob1kI8m0vSDisEfppVtBu/yUCLEyCr2wSd1WcXon63f2hbBWjEN/R98shayCI1uZ+v0+8aVz;
 20:kmNR78PuYRC6TjUcWFnQvrcamh7lyr0MbFzejzpsCIPY1qe2zLik+ojDJvlTfr/1NRxPVvVBHAKX3qDjwu4ff9RhHE6un303jyGjYHHTuCDep5Y5Qc6W0Zz0q3n6XmKXN2PLkxq+oDvhxG3218y+G4OjAG6fvHF3aKMDIaiHfDQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:MWHPR2101MB0730;
x-ms-traffictypediagnostic: MWHPR2101MB0730:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB0730D0C15ACCC5881ADAD7E8CEB60@MWHPR2101MB0730.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501368)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);
 SRVR:MWHPR2101MB0730; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2101MB0730;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39860400002)(376002)(39380400002)(13464003)(86612001)(2201001)(5660300001)(9686003)(53936002)(110136005)(6246003)(10090500001)(8936002)(575784001)(102836004)(46003)(2900100001)(86362001)(6116002)(8990500004)(316002)(10290500003)(22452003)(8676002)(14454004)(2501003)(81166006)(478600001)(305945005)(74316002)(33656002)(99286004)(6436002)(7696005)(1511001)(5250100002)(446003)(59450400001)(6506007)(2906002)(76176011)(53546011)(229853002)(7736002)(25786009)(476003)(11346002)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2101MB0730;
 H:MWHPR2101MB0729.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en; MLV:sfv;
x-microsoft-antispam-message-info: BbzHcy+kPlt7iQrU2QDdFP0eCA55o5RQ2ZPEr2GXQHsCiPUKNW4M/9vHxwOtBiTqcaOHXml5Nys/hjVM8pG8nhJajgtPUlYL/IceORtGcJYSb5ZS9HGDrrYDOcR/wABZBkYb5W5iYdFZ1sf0m2oQW+/jAZIGHiK74hIRVJR4P7g6H/2czGfpCa4EzEFTcnAl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 67151bbb-d588-4122-2982-08d5a582ad89
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67151bbb-d588-4122-2982-08d5a582ad89
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 23:18:21.6853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0730
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Martin

Can you take a look at the following patch?

Long

 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > <linux-kernel-owner@vger.kernel.org> On Behalf Of Long Li
> > Sent: Thursday, March 22, 2018 2:47 PM
> > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>;
> > James E . J . Bottomley <JBottomley@odin.com>; Martin K . Petersen
> > <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> > scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Long Li <longli@microsoft.com>
> > Subject: [PATCH v2] storvsc: Set up correct queue depth values for IDE
> > devices
> >
> > From: Long Li <longli@microsoft.com>
> >
> > Unlike SCSI and FC, we don't use multiple channels for IDE.
> > Also fix the calculation for sub-channels.
> >
> > Change log:
> > v2: Addressed comment on incorrect number of sub-channels.
> > (Michael Kelley <Michael.H.Kelley@microsoft.com>)
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> > ---
> >  drivers/scsi/storvsc_drv.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 8c51d628b52e..a2ec0bc9e9fa 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1722,11 +1722,14 @@ static int storvsc_probe(struct hv_device
> *device,
> >  		max_targets = STORVSC_MAX_TARGETS;
> >  		max_channels = STORVSC_MAX_CHANNELS;
> >  		/*
> > -		 * On Windows8 and above, we support sub-channels for
> storage.
> > +		 * On Windows8 and above, we support sub-channels for
> storage
> > +		 * on SCSI and FC controllers.
> >  		 * The number of sub-channels offerred is based on the
> number of
> >  		 * VCPUs in the guest.
> >  		 */
> > -		max_sub_channels = (num_cpus /
> storvsc_vcpus_per_sub_channel);
> > +		if (!dev_is_ide)
> > +			max_sub_channels =
> > +				(num_cpus - 1) /
> storvsc_vcpus_per_sub_channel;
> >  	}
> >
> >  	scsi_driver.can_queue = (max_outstanding_req_per_channel *
> > --
> > 2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
