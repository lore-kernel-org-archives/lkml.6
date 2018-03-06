Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520295460-2-9086241792729280134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520295460; b=GFHziLQZrzHCEiPiDJqx5yK5X1ylKmcqkh7zCkJGqtGpU/D
    q07rmAc3NW7NatzNJ8JFAYoHjORD9z8OWRmbQwSOQdYl4VGcNr7POoEUg0RVM4Qm
    Qx5Gv/DlIsBpqPodrAWvtgBcOyRZpCvScFbIHyN0ADtLKm5I0XXzUDMRcr86r5+/
    rgKxcZ/EBysUedc8q8Grm7ncwe+xeu/oS4VZr8IqpFUFwLdkwTEOmNbB4Vz017Md
    xguVVbgSof9c7oNeMJaA7FKUbboMP4EOt8LSAFaA2sHcZZJv5fVQB9Wxp+ld5GNG
    uuufaT81M+kzKndvn6Pvg6OGcgJI8yCByATKXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520295460; bh=5
    /GusiQKUiP5EDWeAslub0sqaRwXPaoBpZ/qfEIqaCU=; b=ep8dWs072RJ8F3vZ3
    WbjyBf+LGA1m9/m5Px6O6SqfxGh+P0VijB+2TzHrvWj9hNG2aEj01cGp+UilRzjS
    kQSV1KIWrk8WGmWwnAQ7GyIztzrWuq8Cxkzw7U5dINKVajahVi3sS2yEmAC3Jpih
    1VYT2C3yJqxWroc+/wNYZ+YJy8cdhDRBtAISEmDXRCXxrnCbF4TdGj7j5SzJJ7NU
    l30UTSoOvkxqJ07L70v5mA+fswIq53aJv5mbyGS1jN+5LFb5fblzQ+hb/tvtDZBl
    QPatoFXIaz5k/mlVd29uq72kaebn4MqWgkbf6Q/8RspO1q5gmM+ojI74oT99YxQk
    AuHjA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eHOtYGpo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eHOtYGpo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: RE: [PATCH v2 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Topic: [PATCH v2 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Index: AQHTtLdILulEelG7Ik+GDDlpqOy57KPCTzkAgAAF6iA=
Date: Tue, 6 Mar 2018 00:17:06 +0000
Message-ID: <KL1P15301MB00062E5D982DC248708DF286BFD90@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180305192134.32207-1-decui@microsoft.com>
 <20180305192134.32207-6-decui@microsoft.com>
 <DM5PR2101MB10300B0494E43D69A20C86B3DCDA0@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB10300B0494E43D69A20C86B3DCDA0@DM5PR2101MB1030.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-05T23:47:30.5230940Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8::46e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0085;
 7:UuUOmIdmV0vArSFHt0GwKkLzaeBg4DJt+DnKAt8XyG5xptmqlG6hvFoB/nk48cFYxD+y5YfRbHUdbW+fA+UFESl2zeSfKrZ1kDPrslMR7rZfjoDv5iZ5C7lGMh5wkQJYOk8MdeioK0OH/nbOy5mBwJlrbbVO9HLqahjGOj3I/UFYGBqyhZYXGJ9NXJwfJH3Awer8srTYC7BxF1cD4e5gvuPlMNQt+DqZ3kvpHKta6Hs1E69NvIhVJnRsw65PwHqI;
 20:5mQ0bEkfYuPj9P05VYG+sLokoJAgKaOTBuK1yXh2wl7YexqxBNVCsz1R/jfXyfACNy4IYL0FrpV7SuIIn9b7qt52xGQw349ez35MnJZJslZWSIIuqGF/xGPtI1tZeOLaiT6RG9GrzdbZZXUmi9KMHnUsixR8o1Mf/zQE6I91UNU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5516826e-b1bd-4152-23b8-08d582f79872
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:KL1P15301MB0085;
x-ms-traffictypediagnostic: KL1P15301MB0085:
x-microsoft-antispam-prvs: <KL1P15301MB0085BC67908F5AE6AFB9E203BFD90@KL1P15301MB0085.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0085; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0085;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(199004)(189003)(305945005)(81166006)(81156014)(106356001)(2201001)(10090500001)(316002)(99286004)(5660300001)(54906003)(97736004)(86612001)(74316002)(6506007)(33656002)(1511001)(86362001)(105586002)(102836004)(59450400001)(7416002)(22452003)(8990500004)(8936002)(8676002)(110136005)(7696005)(46003)(7736002)(6116002)(3280700002)(2501003)(6436002)(2906002)(25786009)(2950100002)(55016002)(10290500003)(53936002)(3660700001)(68736007)(14454004)(76176011)(77096007)(2900100001)(478600001)(9686003)(4326008)(229853002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0085;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: Q9WSljVYY2desXwXVg+BErO5ehRhquFyXDi02rtp+kFFTBLHjEnzRqrjLSgW8NvNuldoozxJioVV955OzsaPSfiVLwlcrw0QWN2AHZ/dwWgo2nw5ZJhlww9n+s1RyYK0NUAPY+/B8u7oEPX0Y+22TFvpA3rlv7t8g2AOYKXoz9ZffEuJnVXGouoT0gnJLhWTRxHQADmp0sp09V/VFS/IyfYaIsXQIXybubIRwn17nYpDezHBSm8gLcaLb3MjE87M6OHxIFZndzEVziqhQ47HhEAgtd8c1Mq5kOoF3Exa7WNgUE6y9ic2Ut9jd5W61qlAwbky0/CNO5ktmSovI1BKvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5516826e-b1bd-4152-23b8-08d582f79872
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 00:17:06.3768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0085
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jack Morgenstein <jackm@mellanox.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Michael Kelley (EOSG)
> Sent: Monday, March 5, 2018 15:48
> > @@ -1756,11 +1757,23 @@ static void hv_pci_devices_present(struct
> hv_pcibus_device
> > *hbus,
> >  	}
> >
> >  	spin_lock_irqsave(&hbus->device_list_lock, flags);
> > +
> > +	/*
> > +	 * If pending_dr is true, we have already queued a work,
> > +	 * which will see the new dr. Otherwise, we need to
> > +	 * queue a new work.
> > +	 */
> > +	pending_dr = !list_empty(&hbus->dr_list);
> >  	list_add_tail(&dr->list_entry, &hbus->dr_list);
> > -	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> 
> A minor point:  The spin_unlock_irqrestore() call can
> stay here.   Once we have the list status in a local variable
> and the new entry is added to the list, nothing bad can
> happen if we drop the spin lock.   At worst, and very unlikely,
> we'll queue work when some other thread has already queued
> work to process the list entry, but that's no big deal.   I'd argue
> for keeping the code covered by a spin lock as small as possible.
> 
> Michael

I agree.  Will fix this in v3.

> >
> > -	get_hvpcibus(hbus);
> > -	queue_work(hbus->wq, &dr_wrk->wrk);
> > +	if (pending_dr) {
> > +		kfree(dr_wrk);
> > +	} else {
> > +		get_hvpcibus(hbus);
> > +		queue_work(hbus->wq, &dr_wrk->wrk);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> >  }

To receive more comments from others,  I'll hold off v3 until tomorrow.

Thanks,
-- Dexuan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
