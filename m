Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1254786-1523546047-2-5265652586849436844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523546046; b=h+PCVOQkETXbkNOMdw+tqI6GQQa88XeBeCgFdt2m7duQ/JmNwA
    zSc8YszeplTGtYRcXiqJDhwj0E2pEK8vJCdSmDp4lVhHrRDUblmro3p9LYTnSWxH
    dlA3WIrBBMQT1hT6Av7dG4jzVnJmv5ETgBv3+CQlcHja5EgtRRAfIvjaVYzXI7Rn
    FHvwoj4vJyXR3Tiq1CBonzZEqHWxEEE4zaNBQ/rtbpzd/vuzRr4HS7KxVre0IPAd
    8erzhAaSXrQr1eqUhC2SJGvZmatveyaVOeMxELOxivTS5f0WqG/z10DFaxZy2XyE
    8xur1hH0X2mQ9JyYlMV+7M8OmaIT3jRd/2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1523546046; bh=vqPRKHYEjORKYGq5bK79tQ3Uh/pZToH
    Thvb+cR0duYs=; b=w5iNWFp2ioxxldR0q6CH9mV3pCpDQzttJSnRrTIS7W+mpDh
    dTCe9ZkObNF+Qk8poagsv/qV4t2db/xCgGErZcut7iyhCL8wgbuTtxfemSzPPrZa
    DtcgjTwOU/JiA2cWz8zZMqteLW+0ZelIEaXB5kMpeceBQE4gn9WqQQIH9u8J2zy1
    TNory+mHNXlE6ERv5Fh9AeP8TnOBm0dyW8HTt3gYFqFuv4etKA7a9eQqqgMgxDP4
    GaM8H4Sdx4dhTxJfMUHXChHBiFJtPwQBG976XQJaPuWgReeWS0cVu4HVM+UwUb/l
    4iRGbNjT8nF/sLLU0rdaKbVQpP18ymS0nbLU1+A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WQciFs03 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WQciFs03 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL/fh9GD+aGXSCGxBnfQPChofkxa6zko4vzkw4f4LMX9VZram2zge2klvBDyc2EMHlr8AR2J4vlCdOCB4jlnGi3NVFRiexYaDRAKXW78HL8HF5XeCJcc
    wyn20KTeAUxSWahTjStduUj0isjMVM5jAjJSXhpQpsh37wML1ZyojcXXeGqhmdzsZX9PFfFPp4YJ/Tz7n1uyuYG2OwZdiCxjSYRpuQZdmE9yEpOX3Lvakily
    uCZBVPrab9lhmiFR4LO7WQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=eLbZPmQD8QcA:10 a=db_EfGoRKvEA:10
    a=ubXFrgviyK0A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=lMRTlDfn-qOvFNRDo-IA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Thread-Topic: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Thread-Index: AQHT0gg1KkzwJtR5pkqCGCt02NQD26P82icAgABDuAD//6p1AA==
Date: Thu, 12 Apr 2018 15:13:55 +0000
Message-ID: <9832EE81-01B3-44AB-8B3D-EEA32AED07E0@microsoft.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
 <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
 <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [98.232.109.128]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1066;
 7:sMnhy+41s8xVLmZPcYnOEYh28vbD9owcVYH8VkD2S/4B1hir/KnkOFTjsxkznA/50GQ8fBsyV2Uf0v8IH20OBBanZ04fch8ey6CBK3Tp7v04jUqbaKhpy1k64/rXJVyKyTQIlh8J3Rqw4n1POsHQ+gT0JccZ60gx8vbA6OdrEvB/mOl5gFTIH+CCbDYSV/rfoCivxR+6EEDimla+FiiuZ9vB39XiqznEe+tEhdLmEBj1XL7NRsZuTmcPnz73atYp;
 20:fTu3Xb41txfCIRXs3V3B/g9E6hRyUexuTmaUYK+nmgkmveE9yq5BCZ89v7aSm7QVKzHYRoSGSqBH56I1RtwlsGix9ARLiaEoj1lCewNUpcVVG5nnswmk46jII+XgajKY3nmgQC6XEiKNcp1IvjI+x/fV5+bKShEq1zbMRddJjdo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(2017052603328)(7193020);
 SRVR:MW2PR2101MB1066;
x-ms-traffictypediagnostic: MW2PR2101MB1066:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1066530941613493E6884459F6BC0@MW2PR2101MB1066.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231225)(944501343)(52105095)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:MW2PR2101MB1066; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB1066;
x-forefront-prvs: 06400060E1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39380400002)(346002)(396003)(366004)(39860400002)(189003)(199004)(446003)(476003)(82746002)(486006)(54906003)(186003)(76176011)(36756003)(26005)(110136005)(66066001)(72206003)(6116002)(2616005)(6506007)(11346002)(478600001)(10290500003)(68736007)(14454004)(3846002)(4326008)(2906002)(83716003)(102836004)(25786009)(3660700001)(3280700002)(5250100002)(86362001)(6512007)(106356001)(7736002)(2900100001)(10090500001)(305945005)(6486002)(86612001)(229853002)(8936002)(33656002)(22452003)(53936002)(105586002)(316002)(5660300001)(81156014)(8676002)(81166006)(6436002)(99286004)(6246003)(97736004)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1066;
 H:MW2PR2101MB1129.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <C14A781883657A45ABB07D0D6E55172D@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6d11afb8-43fc-4190-d62b-08d5a0880206
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d11afb8-43fc-4190-d62b-08d5a0880206
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2018 15:13:55.1341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1066
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
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>, Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

    >> I am still not happy with this patch.
    >> 
    >> -  You do not explain at all the dependency on commit 0c195567a8f6 and
    >>    you should because that's fundamental, if that patch is not present
    >>    this revert breaks the kernel as per previous discussions[1].
    >> -  You are sending this patch to all stable kernels that contain the
    >>    commit you are fixing - some that may not contain the commit above
    >>    (that was merged in v4.14), you are breaking those kernels, if not
    >>    explain me why please
    
    >If there's a dependency on 0c195567a8f6, I totally agree that
    >needs to be cleared up.  I was assuming that turned out to be
    >irrelevant.
That is right. There is no dependency on 0c195567a8f6. We just need
to revert 4a9b0933bdfc.

Thanks
Sridhar Pitchai
 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
