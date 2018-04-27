Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524810577-2-17381556143011811420
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524810576; b=AQwwxLQdSZqJd9Z7VxHQYGNhdZN8A2zOevYDtNvk6Iyx8QWoWV
    L9D2RlO/8pFqYTOlRNqd7Lgp+xDGkAusV99ms0yq55mJLTbXYQyRJksYarREK0qo
    ZsKT8n7N3uXkBtn+krLjEAXmVZYKd+VrSG6m0NKzt4PkvKlNrezT3ikskUTC2dI6
    zxi+8etjtOH6EnJ4yUKCSZHqnemdMWiB3OBx2xP87kKhtuXzCSMuNHNn9FLy6Lro
    rGNrSHDR5ErufDwGG46ztny8hfzw5ZygSPEdXcx3ODeOXY2uAUel7O/dfCSJYX97
    Mu6aFKwKifTK2vm9FsXgk400vqKtlMnyqAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524810576; bh=j6kJ9
    VRGXK0v59gh/EXtzcdvQJiWY339YDTnNNCRjOE=; b=X7sShZI47lBncS06m20b+
    xXFyXz3HqvrlBK5g7uQIgb4X5y9cuAzDQMO8F3hWGThQTmr9beVMLNcDjOprso9g
    VN6ecr3bEsYtZCqDPYHyL1X5SO1PZT76GUZwNCh3zJ30WoPbe7llQG8EDrFE4Qtv
    jbW0HgVsP2tR+OwzBLcIvUJNPkzHCk66BBwKJID5Iq19fnSmq8jIwKmydnwJQYx4
    W/+ZrssaiN/pvEliu5a5BPwthXa7Er/kXSK6xs/YA2SIBghkGVjuyjIZz0OEJN2H
    vkESzYoCAmKjr1u2qijU8V9eb3qO6/bYVBzYvCcFTgsJ2N+Xc7BayIGpG+dMDtoA
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MXYYKdD4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MXYYKdD4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
X-CM-Envelope: MS4wfItfkbDKwPh6jEMIkItnJAnSEMsRFx1YcZToa8so4jhci6M+eX91JcBZ64SR7PySN0zYdAWYRnJrItFWDIYsNIVLOZOTmEDfpjnKRQl+F3jP0VFdw7fw
    VdfUIzeg2ds3jwe3WIr8ZVrGJBL95UdLoEY4dLqa7IcrYrMzREjNvohwBAX6cunGveR3I50ceVxyWTTj9ZECmS8h1O5jqlcA5a9vv/c0/r2N/8txqt+DMcVS
    rZFjNbLD99kF2sWxlci7eg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=2_GqYZIPIjsA:10 a=3FPzuyYqfa4A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=Odnh0R2cAAAA:8 a=9yko_0rtkezvrOF8bbsA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=rjTVMONInIDnV1a_A2c_:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=lNAA6UHySJB7qmBR1x20:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH 5/5] X86: Hyper-V: Consolidate the allocation of the
 hypercall input page
Thread-Topic: [PATCH 5/5] X86: Hyper-V: Consolidate the allocation of the
 hypercall input page
Thread-Index: AQHT3MEtzJqayRx9306HiBfrsJ+cwKQToOeAgACGgvA=
Date: Fri, 27 Apr 2018 06:29:25 +0000
Message-ID: <MW2PR2101MB1113D86F6625FE95B5F25A67A08D0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-5-kys@linuxonhyperv.com>
 <alpine.DEB.2.21.1804270022340.1596@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1804270022340.1596@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:3d34:9b63:3fe:d485]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0985;
 7:aleHXm8yraMy/9JvPg17am77bskcyr6z024Rrzrh5TApY7Iz4YAg/KHx7ZRWjamhSXyrwuejayGUixamEI4BEyYjYrtRBhrjLewH1avwfI7ZETmqkxBhDqdGGosZnZkGng8tfF/iBKWdE5J2HanyC6lnBZAPzbTOt3ZZLuT0dlueW7YkTHQ1J2GJBpQwqdEnu+JEZUrNMcEmeR0BFWQDDURmCmWYvYuQV6qHv1OCTfmt+QaiJhkKXVpZFdXmWAvm;
 20:IAisyNeslPbqju2JElC0NwYabtzwVGOVUpWej+oDlRHPMPAssBfjlkJ4MKM71mRZyKml13DcbBWn15sgOaY4uSjWVkZWdwHko3FfwlcAxgEqsDrExyJRoXJPfl5baTCeMM6h1lmJvxhQL7gbNlVmQ7SZMGeeYqGNxu9FwMXQ35c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);
 SRVR:MW2PR2101MB0985;
x-ms-traffictypediagnostic: MW2PR2101MB0985:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB098576C897F160AF666F43D7A08D0@MW2PR2101MB0985.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);
 SRVR:MW2PR2101MB0985; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB0985;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(189003)(199004)(13464003)(10090500001)(55016002)(9686003)(14454004)(8990500004)(6436002)(3660700001)(6116002)(86612001)(33656002)(2906002)(25786009)(3280700002)(53936002)(81156014)(8676002)(4326008)(478600001)(81166006)(8936002)(6246003)(54906003)(68736007)(5660300001)(59450400001)(7696005)(76176011)(6506007)(7736002)(102836004)(305945005)(53546011)(74316002)(10290500003)(2900100001)(7416002)(99286004)(22452003)(316002)(446003)(97736004)(11346002)(106356001)(5250100002)(486006)(186003)(229853002)(6916009)(46003)(86362001)(93886005)(476003)(105586002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0985;
 H:MW2PR2101MB1113.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: vVXoLWjbAYzlxpoqLjfbOiChfLuLEuZfIleqFP8+zQB6BX5hvy0zwbtVr7fSM/GknKMzh+mbe4+rbDL8UQpIsuqtdVhzXfbpbrHpDIjrlHXTYB+1nZVWKCsyZ0ppM5Or0MsYJ2aCatcBdO3a6gG826qVhEZM7S4X9Kya05TzxIBAe/dsf4tp/SsdgToKaTWf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 861e00c9-3fe7-4f02-19f8-08d5ac0838c7
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861e00c9-3fe7-4f02-19f8-08d5ac0838c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 06:29:25.3710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0985
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "apw@canonical.com" <apw@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, April 26, 2018 3:24 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; hpa@zytor.com; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Subject: Re: [PATCH 5/5] X86: Hyper-V: Consolidate the allocation of the
> hypercall input page
> 
> On Wed, 25 Apr 2018, kys@linuxonhyperv.com wrote:
> 
> > From: "K. Y. Srinivasan" <kys@microsoft.com>
> >
> > Consolidate the allocation of the hypercall input page.
> 
> Again. You can provide the new way of allocation first, then you don't have
> to add code first in order to remove it later again. 

I have implemented the new way upfront for the new code - the IPI code
[PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments.
What I am doing here using that infrastructure for the TLB flush enlightenments
and getting rid of unnecessary code.

Regards,

K. Y
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
