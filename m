Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1272426-1523548613-2-16058730734366383353
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523548613; b=oti1CvGagpbg/kd7Ve3O8xFMTu8XbJS9uiuAn65rY1EoVeUDXq
    5JOzKsFvuXZnkbpiZmXAGd6brwYvc+HTaH0Vo1w9RSnIl3PE9TMk+W6KHMgrqmiR
    C/LZNg6d0QWOw49c4t3jNasfxl0W3hMTEhZk6e+cNUSZjau+e2ybhC37E3xe9TGd
    GvHbqUOmDKNqL5e4Q6mTaKg1M5edCEZ131fq+AdNfEEBQe4B+kqcdz4YEZTRxLGg
    DvSW2tLrVtUff5hOozLLn5yiPVNWksL7ZO5ML5YuStCC6DVE2ARttbj2kE2H7+r6
    YnkLRrLyepMmQRBlPt7AwDaBt01mB5POt3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1523548613; bh=eI5dZGUDrCoDf6ALW87ScNVus4q8cph
    AL0BpU9vYQkQ=; b=j/IdzMNEWTWm/tnHCZnSSiS5YgbfPRhX+g0EUU2isjr/bzj
    pP7HB2J1tnluEtLIygj188x2q1h0WDlMd7ud0kRYsRsllN9enMS7nTdND2GYnk4g
    6t2jeM9F4whIVzKhQo+aImuEyH6vsmLYpUOZBDeoDrRjrImmJrvrdb+CV/lrcWYm
    6wDWwP20yc2M+9v9U+Tf9ZMeJ5SZB4PMShvJgEIeIEoJ1+ILAiNzWLS26meNU2xh
    hGv3lc/eH3or6HZ2WsY1fAKfIPr5ELQBLrhzoir1IJFbkbBC26X85m74ja/xERfS
    EhFLDUIdX8MHD/7JU5LhMSY/INvMeiLIvf8881A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jRgpd37b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jRgpd37b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOT6GpBl8u1yOcPZ8kUfvswyHaew0ulMU1xgYTnrL09xG8FvWBjF/isIi5jL6eZeIfHwQmip6ADNhI/RF1gjjdHfuX3Mi70RFXdPAYVH/WzAg9YFBxtF
    9QSTLGZpV+/w39/HPqIqtpGvGDYaR7SZqffWuhAaDfHdHbnJoe4h7yYjph2nYZNxJDq0pqxKmyfgFInEfvKkdCoYP5Q/IGUu/f5hQgn/x52T0+hgPx2oQFDY
    yyY7eD0OdyiRU6cURmSRAQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=eLbZPmQD8QcA:10 a=db_EfGoRKvEA:10
    a=ubXFrgviyK0A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=k-sZY-qtlBd_RAL_x1oA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Bjorn Helgaas
 <helgaas@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Thread-Topic: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Thread-Index: AQHT0gg1KkzwJtR5pkqCGCt02NQD26P82icAgABDuAD//6p1AIAAfbWQ//+OP4A=
Date: Thu, 12 Apr 2018 15:56:42 +0000
Message-ID: <F8BC8B81-D3A4-40F7-95F4-CAF77A7917B7@microsoft.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
 <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
 <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
 <9832EE81-01B3-44AB-8B3D-EEA32AED07E0@microsoft.com>
 <BL0PR2101MB1108227C3E52DE4462A9F93CCABC0@BL0PR2101MB1108.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB1108227C3E52DE4462A9F93CCABC0@BL0PR2101MB1108.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [98.232.109.128]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1130;
 7:nHPYvF+mNY3WUylpWK29xh41Q6ns8QyuT89NH03SMWl5xVoiRpr9XJj7ig2oM2PGD56ZbwH2jG3q9tYS0+SsGJe3yEmplxsidZ45AwWjogGkhGEVWp4+qNomMUlj20GizPQB2WEpFmfM4n0KCKlKGnGrcCHlO0CunxEIm+DrgwcDor1E0Nx4ACzBBgszJRS2y1I1KHhNd7KNT7RDvsy9oI/A3/OurdYZ/lV11UfU6Y5R0058fXuryIt6SpDsuJjs;
 20:EUmF+rXoz5qW+fVBsx+gAsfjpyL49bF1bwMFCHmTMlK6iSfJsuzbapjhCfhrRhSJntwNzPX0iapVWfI29RiC5swyDuxFUd8g10+9Ag9sGxRPYvy7QCNQSVARQqP6Y94dEBZGc8S5U7j2zLH+L0dZzOsvv0HY8gbEvKWvXuGXKzY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);
 SRVR:MW2PR2101MB1130;
x-ms-traffictypediagnostic: MW2PR2101MB1130:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1130CC55E2EC29ADAA08D5A9F6BC0@MW2PR2101MB1130.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231225)(944501343)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);
 SRVR:MW2PR2101MB1130; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB1130;
x-forefront-prvs: 06400060E1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(376002)(39860400002)(39380400002)(189003)(199004)(5250100002)(68736007)(105586002)(229853002)(82746002)(72206003)(10090500001)(33656002)(14454004)(6512007)(99286004)(5660300001)(76176011)(446003)(6486002)(36756003)(6436002)(53936002)(7736002)(305945005)(2900100001)(59450400001)(6506007)(97736004)(6246003)(86612001)(3280700002)(3660700001)(478600001)(1511001)(8676002)(66066001)(2616005)(3846002)(6116002)(2906002)(106356001)(25786009)(81166006)(81156014)(4326008)(486006)(10290500003)(11346002)(86362001)(110136005)(476003)(54906003)(22452003)(83716003)(316002)(102836004)(93886005)(26005)(8936002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1130;
 H:MW2PR2101MB1129.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <938EDD2CE1BC894980930114B9270748@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8ab829c1-cebb-45ef-9b26-08d5a08dfc17
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab829c1-cebb-45ef-9b26-08d5a08dfc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2018 15:56:42.1660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1130
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

    > 
    >     >> I am still not happy with this patch.
    >     >>
    >     >> -  You do not explain at all the dependency on commit 0c195567a8f6 and
    >     >>    you should because that's fundamental, if that patch is not present
    >     >>    this revert breaks the kernel as per previous discussions[1].
    >     >> -  You are sending this patch to all stable kernels that contain the
    >     >>    commit you are fixing - some that may not contain the commit above
    >     >>    (that was merged in v4.14), you are breaking those kernels, if not
    >     >>    explain me why please
    > 
    >     >If there's a dependency on 0c195567a8f6, I totally agree that
    >     >needs to be cleared up.  I was assuming that turned out to be
    >     >irrelevant.
    > That is right. There is no dependency on 0c195567a8f6. We just need to revert
    > 4a9b0933bdfc.
    
    > This patch should only be applied to later versions after  0c195567a8f6" (transparent VF).
    > Otherwise it causes long & random names of VF NICs for bonding. That will make bonding
    > config difficult, especially for auto config.
    
    >Thanks,
    >- Haiyang
Ok. I will update the patch, as Lorenzo suggested. 

    

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
