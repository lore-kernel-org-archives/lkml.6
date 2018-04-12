Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1272426-1523548886-2-11883713065930523735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523548885; b=bgr9++w9bWA+340U/6jdhEKGxhPu6jd/7P4OSXzQAk5l1ReeQU
    3Gep7XghhQPyqbQzQv3R9Q6W8WtqU9XhaoCrD10HEjtrHAYtngBjYODHWDzw5Zkh
    xwsNh5uFyk86v4ZLYfUqi+CWXGmsfaBKg6aq5g4MrUn2N+r0vZq/CgSZ24LADa3U
    OioYtC32Pflor23PltfdNuNuvVKWgsFygQgIWrmSyGWKFa63byNAcZGoKWL6w1p1
    sxB6TCfs42/5exj6Sl+gUEH+kmkqqV40oPZL4CXOe++aJKEbmUX71BHstSKW/NHP
    CQA/AsKB0439qq+FLcr7Jcm24EgK/RoisVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523548885; bh=Xw/JD
    CcSyEiGRixDLcKECDlrGvlx5OEg+yd2PBg7uHQ=; b=NZUwsQPUq4VpZrt3whA4l
    uk1y6CKM2b6IdEXKzNcKHzxL/yxgwCtRcHIxXZNfHQ+JTUzWs2CT7Yy8YjtfcI8/
    Z0rfkW9txqv9hBtSYuX5IrYh0cfG126ypEhwNHQB1HtVEvNCjylWVxNM1KuySqEd
    ZUGCy5vnWvIdfk475ku4Px0Oo6OQXG5ZkydG1MWGvLOw0RuR37kCuFxCZjiTFRDa
    ib7h3e4LaOC/4x8cUBo8Yf5OTSjWB3GskCaDf8QC9ulun9kPX5zusijugVUkUF1E
    5HgbPQFzUrjmRWsMbKJrKetZw8C/xkpwF4aoPzV93pBdPqVPI79FoWCFxlaxFyYy
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VdjDGJpe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VdjDGJpe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
X-CM-Envelope: MS4wfJlDZ96lBUvdvaRG89Yz43nlNRv0MNgZtq/Tw/vxaY4XUkiAAJof9EdoM7zib9rWxyonjncKOC0S4rEtbB59EOKR6SR+Y03FH76h6xwgRYlFJy1j6ps6
    veQNrxnNtBNzuRuAUDWP9CxRliGn3cpHBiKow4+NRXZFpuY6h5oD7/z7gG4FBReo+xVhbmoxTQ53LL8eeCRAJbHv7NxgMg69ethccqVa/B1x90XzaSOREqwz
    3kPddXgssC5ESc16LwvVpw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=qKRqC2NImX0A:10 a=EHDZXwS4o9oA:10
    a=ubXFrgviyK0A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8 a=Bi5RjpFab4xWVdDkU-oA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>, Bjorn Helgaas
 <helgaas@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Thread-Topic: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Thread-Index: AQHT0gg1KkzwJtR5pkqCGCt02NQD26P82icAgABDuAD//6p1AIAAfbWQ
Date: Thu, 12 Apr 2018 15:46:14 +0000
Message-ID: <BL0PR2101MB1108227C3E52DE4462A9F93CCABC0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
 <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
 <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
 <9832EE81-01B3-44AB-8B3D-EEA32AED07E0@microsoft.com>
In-Reply-To: <9832EE81-01B3-44AB-8B3D-EEA32AED07E0@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-12T15:46:13.2647587Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BL0PR2101MB1011;
 7:evsM3xWd7KvoZ4R0GoK89UeQ6pL1ENHSrHw2lIHZY+3nRtDU2jt/BCugYQ6f8BpJ1i9iMUECbqDUZ2inKkoSRxmSMP6I1f+eS//latxaqGWCr6JTdbI2U7ScBCAx5E25DAzqUji2VHuxpygT1yJZoMCvKy4Nj/BknkNlkcXEO0x0gqn3+TAJG6g9eRI7DjlofIGoalJopjgOZO8bmhrumo7f08iKxQUAvtAuGT6fbnhC3TvFuS73BmqUlRG8Bzaq;
 20:G/mmLD2mMDhJwx4xCrMN8EWStkpJTgGcp22uipQdAIA5xv3Cq+rdi8MaproV2Qse+B5dw0U1Rcoj94qAgvY7VJrIx2YVPRiHAXb1i+oWdbCdm1giZW0iAct2wOoS7da9cPTlENuvWnZo6PfjR9I3b9R6+v+RkSbM3sHjLyDOmZg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:BL0PR2101MB1011;
x-ms-traffictypediagnostic: BL0PR2101MB1011:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB10112189B5DD52CD3E4EDB77CABC0@BL0PR2101MB1011.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231225)(944501343)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:BL0PR2101MB1011; BCL:0; PCL:0; RULEID:; SRVR:BL0PR2101MB1011;
x-forefront-prvs: 06400060E1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(40224003)(13464003)(199004)(189003)(110136005)(26005)(33656002)(66066001)(7736002)(3660700001)(446003)(305945005)(11346002)(2906002)(3280700002)(476003)(2900100001)(74316002)(1511001)(229853002)(8676002)(5660300001)(10290500003)(81166006)(25786009)(81156014)(8936002)(6116002)(14454004)(106356001)(5250100002)(478600001)(3846002)(8990500004)(486006)(10090500001)(86362001)(7696005)(55016002)(4326008)(6436002)(93886005)(76176011)(6246003)(86612001)(105586002)(9686003)(54906003)(316002)(22452003)(6506007)(97736004)(53936002)(102836004)(53546011)(68736007)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB1011;
 H:BL0PR2101MB1108.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0b313a31-08e6-43d5-aaa2-08d5a08c85f2
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b313a31-08e6-43d5-aaa2-08d5a08c85f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2018 15:46:14.4130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
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



> -----Original Message-----
> From: Sridhar Pitchai
> Sent: Thursday, April 12, 2018 11:14 AM
> To: Bjorn Helgaas <helgaas@kernel.org>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> Jake Oshins <jakeo@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>;
> devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
> domain"
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

This patch should only be applied to later versions after  0c195567a8f6" (transparent VF). Otherwise it causes long & random names of VF NICs for bonding. That will make bonding config difficult, especially for auto config.

Thanks,
- Haiyang
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
