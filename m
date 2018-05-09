Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-680809-1525885684-2-1092935124370276552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525885683; b=AvA+3JP/bK7fWXZ8OYU0Q+IVAZRdqr4kC8KPS2Okk5vxpqS+xS
    +rTMyMFHX7ozF6cOttbq/geKs2g5kCSm+tkkvjE0gRGbSr+ak7PZdzzMYvM/2Hpc
    B94+BiWMtMiYCLkxtsq6pIkGeN4avy+P04+6+rwj7H1ffLMjIs6uSrXyW7MqLqO9
    zw073KuoshcCBH7c3WcvU+oIMEOMMK4r/X3gbZIFQLTKdirlfeZW8bGjkvu3OIKr
    E9mzSCkREGGcmdxm1DXT884D7htYHWbyckLfP5Yd3J6l6+UW4YJtSnZHLJMI2auw
    Ndqj496M5yK+UoueW4aVpFpvwJlECtYzw7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525885683; bh=BiYTN
    LV1MbbEq4YERXzpDu4oaUOHKbJkHFOCqUnZUwA=; b=bkKuPZtDnNJLvu2APgIIA
    JWnouN/NXhZfQms2aCnxBFO11hNl4MAUCbVkew/FouEE/7nXcMr956rWc/skUeGj
    uK9Oqe2ZNqTGDeKvtrYHB9U/BtL8CTMjX46FfZcU4bFD8NR+Un69n7rdU5fFQdrq
    ggJOz40M+122a55rLCPJ8V1syB/alMciEM0XKu5A10eul+EcMWNSit5PKxrrZ5jK
    knbcpGqfhe0EKljFpPDY/agRn+cVSZTDkThRVI5FPczHnaw+7taHyOsUF5ZIcpG7
    qUM9NzSrNaChPOA8biNWSaCiEykTnXFIiSG08XbJhaOMvHSmJDdYG4fVaQ/JH9LG
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=AUF9tUS8
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
    header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=AUF9tUS8
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
      header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCZmPbk83T/GFo/AaeCc2Z40IuGoMtBwdi4+MTaBhB9jBUpxpBZx2wJy5AYk1nXZxvMalrIHb3xTHG2DxZheh9WDa1quA+La5eOi5jkkA4s7rHM/UT41
    Te1ph6saB8dewKD4L8PpigoGcrQ7qja0GDz4Q7tiN98UXdzWMov8iWI03+oq82TyFv1ZusRVXPMRIIfzyzP21ayqRO39gjJL/hlu/VHrA2s6cDO563H+Sj2X
    vMTbQx7gujVtUzHtBOqoWw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=R4fxTKrshSIA:10 a=LGqW9EbBbJ0A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=yMhMjlubAAAA:8 a=s7peT8EUuh0m-dQXGEMA:9 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_BcfOz0m4U4ohdxiHPKc:22 a=rjTVMONInIDnV1a_A2c_:22 a=NdAtdrkLVvyUPsUoGJp4:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2 4/5] X86: Hyper-V: Consolidate code for converting
 cpumask to vpset
Thread-Topic: [PATCH V2 4/5] X86: Hyper-V: Consolidate code for converting
 cpumask to vpset
Thread-Index: AQHT4253HsuZm7QJSku1CYJeQjLbc6QnqYPQ
Date: Wed, 9 May 2018 17:07:53 +0000
Message-ID: <SN6PR2101MB1120D8E3191B580BCAB8D3A9DC990@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180504060653.3240-1-kys@linuxonhyperv.com>
 <20180504060823.3345-1-kys@linuxonhyperv.com>
 <20180504060823.3345-4-kys@linuxonhyperv.com>
In-Reply-To: <20180504060823.3345-4-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-09T17:07:52.0672157Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:a::4a9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN6PR2101MB0928;
 7:a9T3IhAbY3x8J25qMK2uHHDzxy3sQJQl4FztFH3atrzuQK+ZsclKuwM66cZ6uV2xoII7CofRHPq3/X5IYJU4Mmv2hWwQO1FvykfhqqohydhGS20BlrR+vEtlxfrwZZv+t4L4xQDQncXlrD1hH3GMQ6cvJKgFrzaXKi8ypQnPNi+1aaiybL6I9pq2KGYCRFwt46eUF+oEQtPccNgFBDqdiEYkdRy9Z601HF+uB7lf3ys+iPQLLHRcdb4jzGYQSDN6;
 20:VXE+YVGI61N4sCqApDtJyZhQf+FeN8xsKHZU8NdCWa56rnlgdeC2DandRHPYEbrdcjp1kWc/vkuvWEENG74V0ud+tbZ+++G6muXB3maODUaVA/VQy/wDSmfIXZGR8UFlh0pVPpg5/JNLSe5fq1h2kjPYUTk5nfUWMzkbS2ldARM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:SN6PR2101MB0928;
x-ms-traffictypediagnostic: SN6PR2101MB0928:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <SN6PR2101MB0928942BDA0D02C6728B42B3DC990@SN6PR2101MB0928.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:SN6PR2101MB0928; BCL:0; PCL:0; RULEID:; SRVR:SN6PR2101MB0928;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(346002)(39380400002)(366004)(396003)(13464003)(189003)(199004)(106356001)(3280700002)(2201001)(14454004)(68736007)(10090500001)(105586002)(316002)(110136005)(86362001)(97736004)(1511001)(22452003)(7416002)(5660300001)(229853002)(8990500004)(6246003)(74316002)(3660700001)(8676002)(305945005)(102836004)(25786009)(7736002)(6436002)(53936002)(446003)(81166006)(2906002)(81156014)(46003)(9686003)(8936002)(76176011)(33656002)(6506007)(53546011)(2900100001)(55016002)(10290500003)(6116002)(476003)(7696005)(5250100002)(86612001)(486006)(2501003)(99286004)(11346002)(478600001)(72206003)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR2101MB0928;
 H:SN6PR2101MB1120.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: asxVWts8r6hbWt+J9+MNBlzCs6HrDKogvBLg2sog9/efDW5RHES2xj9JYvXaS05Zrp3ya2ZSp6GDf1Me4fxKckPsv7qRhPOxZx5r0VSTt7thyg2Lzac0GtXK/QfHznIcJ7OLiVF1lc3PlpQBAoXepvojYjXOKkCMHRh2N3jWWA0fyEjH24gyB1nbrHqVcvdA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6ca4649a-185f-4288-d286-08d5b5cf6720
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca4649a-185f-4288-d286-08d5b5cf6720
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 17:07:53.4013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0928
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

> -----Original Message-----
> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> Sent: Thursday, May 3, 2018 11:08 PM
> To: x86@kernel.org; gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com;
> tglx@linutronix.de; hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>;
> Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Cc: KY Srinivasan <kys@microsoft.com>
> Subject: [PATCH V2 4/5] X86: Hyper-V: Consolidate code for converting cpumask to vpset
> 
> From: "K. Y. Srinivasan" <kys@microsoft.com>
> 
> Consolidate code for converting cpumask to vpset.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
