Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C09C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A48206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A48206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeJBWft convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:35:49 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:44264 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeJBWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:35:48 -0400
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 47CCF1785;
        Tue,  2 Oct 2018 15:51:45 +0000 (UTC)
Received: from G9W8454.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 4AECCB8;
        Tue,  2 Oct 2018 15:51:44 +0000 (UTC)
Received: from G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) by
 G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 2 Oct 2018 15:51:44 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W8454.americas.hpqcorp.net (16.216.161.4) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 2 Oct 2018 15:51:44 +0000
Received: from AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM (10.169.2.149) by
 AT5PR8401MB1265.NAMPRD84.PROD.OUTLOOK.COM (10.169.9.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Tue, 2 Oct 2018 15:51:42 +0000
Received: from AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::49a5:eb60:599c:78a8]) by AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::49a5:eb60:599c:78a8%5]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 15:51:41 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: RE: [PATCH] EDAC: Don't add devices under /sys/bus/edac
Thread-Topic: [PATCH] EDAC: Don't add devices under /sys/bus/edac
Thread-Index: AQHUWdgoCSh2YfNBoEKJ2ttajFOTeaULKTaAgADxVxA=
Date:   Tue, 2 Oct 2018 15:51:41 +0000
Message-ID: <AT5PR8401MB037188B39CB70EB18ADAC11987E80@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180926130340.6b22918b@coco.lan>  <20180926161749.GI5584@zn.tnic>
        <20180926181035.GA1132@agluck-desk>     <20180926182317.patqjso7nzw2oxiz@hpe.com>
        <20180926230257.GA5666@agluck-desk>     <20180927045244.GA30912@zn.tnic>
        <20180927214400.GA2249@agluck-desk>     <20180927220355.GF19687@zn.tnic>
        <20180927221054.580220e5@coco.lan>      <20181001124754.GD7269@zn.tnic>
        <20181001224313.GA9487@agluck-desk> <20181001222257.45e4fd59@coco.lan>
In-Reply-To: <20181001222257.45e4fd59@coco.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=justin.ernst@hpe.com; 
x-originating-ip: [15.203.227.12]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1265;6:Rm3USrtGAoIROuHWWpBqAannDBcXOSbnjuxCHwkjimYyMVGrIc2r4DW2K6HRn8TVGWl6Jt852DPiKKrb0nPeEKGfKEbQslHgPXuPYonU7TP1ALGYa0YVULbkXpxhaz6W0IYeFOiRqBSo/LkgM4BBn0BWUhE74CBoO7dynz/OJw+bhpYTScqbqMQXSawHAIDzSrO/jRuFf5c/KOPn1ATcwDi2sTRcHlI2YIXDdNK966bnbI2gJWevNXki7oRlpPqa4oR0PiSguerA+/pgejrDUPVJDT7maIW/AMYiH5BTIRk81meHR0TK9qdPyIy39fl4cPkRqCofucUN+yUrsMg5iIwTnYvt7OVBnNlvPc9naLuSWC9QAfZRitq3dRJzRr3+ZywrRDXWMmIM3/vzMJg2WAqLoloEE7ymyL4wtxjTc4gUjBeyXPjqhZLrUOjQXl+jQ72QFNEuGsWXcbEUMtEUQQ==;5:5XMXucp8G7zUa4dLIgQ46KkSqw3cZPuTJGlItfUWzNYDGgAPDYvuFCC7LDAbviIr/0ONvKzvV4g5OUdJjDLVQcDc0sPkHGos7Z5qoFTaR4YiugP3kOYkM9qDVq/gGL0T34BmhTCGOEPDpDVBJ8KcYg7zbRU6ZysYNKF+VLT8Pq8=;7:+00ZfNca3xR0TUonxMYe6IUZ9zazXsV9nfhppMNd0mpSlBE7+74oK5qUTIZIlLOzJaJUEDVKE50dt2NcdogknrBpy6meOO4d35YdVWO3kiBrpaIhuBF/T+zsHYL6xbSMsQ5FFUmp9B2l3fJDTN1tLpzittXR/Q7JlCsrUcFGdp81riRFnUyJg8AtKkDhaEyJQRCAkrV7xDAfWKpIc106H1wxVDGeeOJE4tzIiSUURrAMmSqQnC3JykRUr2Rlbx/g
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(189003)(199004)(13464003)(55016002)(86362001)(76176011)(316002)(478600001)(33656002)(26005)(7696005)(186003)(53936002)(966005)(102836004)(6306002)(93886005)(9686003)(6506007)(6916009)(53546011)(14454004)(6116002)(3846002)(105586002)(106356001)(2900100001)(74316002)(305945005)(5250100002)(8676002)(7736002)(97736004)(229853002)(6436002)(81156014)(8936002)(81166006)(68736007)(486006)(11346002)(446003)(476003)(71190400001)(5660300001)(71200400001)(4326008)(2906002)(99286004)(66066001)(14444005)(25786009)(256004)(6246003)(54906003)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1265;H:AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 5c3c7503-aaa4-4fcf-0f45-08d6287ef228
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1265;
x-ms-traffictypediagnostic: AT5PR8401MB1265:
x-microsoft-antispam-prvs: <AT5PR8401MB12654B39980B2BE14684609987E80@AT5PR8401MB1265.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699)(222181515654134)(227479698468861);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AT5PR8401MB1265;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1265;
x-forefront-prvs: 0813C68E65
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DaUbFeGLmuvu9zmDXZEOkYcYFxT9BR2x1BrCEtq6hjO/RIEiS9zo7yM1Oos3suPIsOPLw1ZtY/4Jw+nY+Ntsph/XsWEUjCYKxgGYhTeHvxjRthi73k6FuesVIpDgsZQZgUpPBjo+nEDfkk/tJrymXpry2lJBZOcx8DOcwc25O/ZX9slpWVPvSMhMjORX6cIIsW8Am4jO0GxzoBuufAwvQycLJoQxp2VAYCUh8jsvkXTVI5oUnkIUcOeEm5BRQdB0y3S+gvIJUmqsd6RcHExnE1gExuHHlp6xMhvMx45dNlRu1Kl+4/lgxW11aQqnj61T5gBIRdUF3LSJ12Z3RX9cQKbZC7h8CxGKWEB8NbUGinU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3c7503-aaa4-4fcf-0f45-08d6287ef228
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 15:51:41.1487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1265
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The combined patches work on a 20 socket system. 
Thanks!
-Justin

> -----Original Message-----
> From: Mauro Carvalho Chehab [mailto:mchehab+samsung@kernel.org]
> Sent: Monday, October 1, 2018 8:23 PM
> To: Luck, Tony <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>; Anderson, Russ
> <russ.anderson@hpe.com>; Greg KH <gregkh@linuxfoundation.org>; Ernst,
> Justin <justin.ernst@hpe.com>; Anderson, Russ <russ.anderson@hpe.com>;
> Mauro Carvalho Chehab <mchehab@kernel.org>; linux-
> edac@vger.kernel.org; linux-kernel@vger.kernel.org; Aristeu Rozanski Filho
> <arozansk@redhat.com>
> Subject: Re: [PATCH] EDAC: Don't add devices under /sys/bus/edac
> 
> Em Mon, 1 Oct 2018 15:43:13 -0700
> "Luck, Tony" <tony.luck@intel.com> escreveu:
> 
> > Nobody(*) uses them.  Dropping this will allow us to make the total
> > number of memory controllers configurable (as we won't have to
> > worry about duplicated device names under this directory).
> >
> > (*) https://marc.info/?l=linux-edac&m=153809709903987&w=2
> >
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >
> > Boris: Apply this, then your earlier patch to get rid of the
> > hard coded limit on the number of memory controllers:
> >   https://marc.info/?l=linux-edac&m=153797567628947&w=2
> > the combination works on my 4 socket machine. Perhaps HPE
> > can test on their superdome.
> >
> 
> For both this and the referred patch:
> 
> Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> >  drivers/edac/edac_mc_sysfs.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> > index 20374b8248f0..4c1bee59c2e6 100644
> > --- a/drivers/edac/edac_mc_sysfs.c
> > +++ b/drivers/edac/edac_mc_sysfs.c
> > @@ -405,7 +405,6 @@ static int edac_create_csrow_object(struct
> mem_ctl_info *mci,
> >  				    struct csrow_info *csrow, int index)
> >  {
> >  	csrow->dev.type = &csrow_attr_type;
> > -	csrow->dev.bus = mci->bus;
> >  	csrow->dev.groups = csrow_dev_groups;
> >  	device_initialize(&csrow->dev);
> >  	csrow->dev.parent = &mci->dev;
> > @@ -636,7 +635,6 @@ static int edac_create_dimm_object(struct
> mem_ctl_info *mci,
> >  	dimm->mci = mci;
> >
> >  	dimm->dev.type = &dimm_attr_type;
> > -	dimm->dev.bus = mci->bus;
> >  	device_initialize(&dimm->dev);
> >
> >  	dimm->dev.parent = &mci->dev;
> > @@ -940,7 +938,6 @@ int edac_create_sysfs_mci_device(struct
> mem_ctl_info *mci,
> >  	device_initialize(&mci->dev);
> >
> >  	mci->dev.parent = mci_pdev;
> > -	mci->dev.bus = mci->bus;
> >  	mci->dev.groups = groups;
> >  	dev_set_name(&mci->dev, "mc%d", mci->mc_idx);
> >  	dev_set_drvdata(&mci->dev, mci);
> 
> 
> 
> Thanks,
> Mauro
