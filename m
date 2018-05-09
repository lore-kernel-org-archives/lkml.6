Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-699659-1525885603-2-2734431399798397496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endaca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525885602; b=nEAfGCFZJw3++2ssKfaJZBcJG4YkLX5k61eE7nVCx7F1W5PPG0
    +3X1vWWx/cZuXtLv9HQVg0e1h0G+3nwEnp+5drc1GD3UPO79grrpA3ehj9AOkLrs
    vDy3NPU4qMeMTW66oSYXDiyoRYztbR90e52BW2QN6LPfIYMEx1yWRrqFcEuxw0wG
    BSj8OgODH8rLbyU6kv/j6eW8pcpAVWJaIRi9FNCdLi9MsdAz2qfyr4nUPZ63vTvK
    mbn0vKm4Y9zbFBSfiS9G+8XNAJQacrUSR9WV2Xx3P5W7BXk4IM7aMx2bY2lh7wRP
    8WeeNO1sSOxm2zMVeWQ9XsU/RrCX+I5yhkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525885602; bh=VDT5v
    bKjiQdMdRd7M2eE84xhHfBIeA0D+y9SEjnl+Ug=; b=Yn8lN/r3txM+HDFBypi0v
    ITD79q2Wys2f6lG4WUns3q4GDeVisZPyBAmyq12EI8oGJMK3999IQiyPKRUoG/MH
    QwCztxH3fOAeaL30XeJgpHdVsV6AcY1c/yn0mCf+WrlWjwjvIiagsCDrA47pjXOm
    VIDFKXEKSK7dTuvbEldK/sS9BxyNQjqD1QMGSWubLAy6GMz/8fWAa3GyMk0qoFKE
    x4tDQLNGc7gEyjERXCWNwwgZgMwM6CfK3MARsJLcuxQa+sRHmgb5LvJQT4gHXmH9
    RtQcKpGmygIJeCRjG9Agmzq2ZsATVhx1VVTTTLdJZ5Bb14xi58xhG6UsIIM5dC85
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=lxaWdY6s
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
    header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=lxaWdY6s
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
      header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKuB3DCfhlMNmH06txZsbuCtO5CgUAUN0SiDN8cbUp5JY0H6fGcyJpQPIJRd9Ktz7pp/gCZneF3npiB3b98aYLC8HVz+Hc9qt9mqQ9eXA4J7/H46i4oc
    +Rmp3LzkA3MsEAsn2HMFTwwWPZy6DYNTdaRYSc92it1Bcr5e+TFRYxdNiuzgiEvJizxW/EXWc/DMM3uuE5O6FQwE5pkBHW2A/QOpWV1f4c6ZNM5Hb2upXXSi
    V+lgxrcXc4QmtyXok0WyWw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=R4fxTKrshSIA:10 a=LGqW9EbBbJ0A:10
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
Subject: RE: [PATCH V2 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Topic: [PATCH V2 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Index: AQHT4251QJMqVW3ZI0yZ51gWq/NdfqQnqREg
Date: Wed, 9 May 2018 17:06:31 +0000
Message-ID: <SN6PR2101MB112007166EF9AAC9822C697ADC990@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180504060653.3240-1-kys@linuxonhyperv.com>
 <20180504060823.3345-1-kys@linuxonhyperv.com>
 <20180504060823.3345-2-kys@linuxonhyperv.com>
In-Reply-To: <20180504060823.3345-2-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-09T17:06:30.2656130Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:a::4a9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN6PR2101MB1119;
 7:gIHuZwuT0KVowys1NdgZkhQdI/+CIanRR0aJCO40y1lmc8S2ZQIgvVUrjGeh9Tx8knl/Ou+HdVvQsbZHMLZnREYUs1rR5ITA+lVmgNQvCg49NpDPvTbm2XpyWXJqGSxIMn5+DCQwjPEJfwE0iQzNRVBWeHu0uV55NyQdcQFvAEl9/xWNx8kE3d6Rg2SxX91Bq0YX2RjEzaU+Ln93J64nddg/+hJojRvtRtIdqJk9v1jsH8gEZ8Bxl9XNbhY2IRsN;
 20:WLQGziVPNiRPWWey6FwIC1DjuLJ2MEsTEXmol708zm/iBKtIKm9ekLXkgw4EBhzwlE5m2wJiPZvneZwaOtv6T2G9kE4//P4wCO5M07RoKiWvMDf2t4olPIEQIMaCd/wvCPBJjh5j0j+Ho8iay7GlzQrcR8Oaw3bF69zuYYd5Yj8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:SN6PR2101MB1119;
x-ms-traffictypediagnostic: SN6PR2101MB1119:
x-microsoft-antispam-prvs: <SN6PR2101MB11192E350E6591A3415C2955DC990@SN6PR2101MB1119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:SN6PR2101MB1119; BCL:0; PCL:0; RULEID:; SRVR:SN6PR2101MB1119;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(39380400002)(39860400002)(376002)(396003)(366004)(346002)(13464003)(189003)(199004)(2201001)(8676002)(5660300001)(74316002)(7696005)(55016002)(81156014)(6246003)(97736004)(2900100001)(46003)(2906002)(7736002)(8936002)(10090500001)(68736007)(25786009)(9686003)(10290500003)(8990500004)(7416002)(86612001)(76176011)(81166006)(1511001)(86362001)(105586002)(305945005)(14454004)(106356001)(6506007)(5250100002)(53936002)(72206003)(476003)(6116002)(53546011)(478600001)(99286004)(11346002)(446003)(2501003)(3280700002)(229853002)(102836004)(22452003)(110136005)(6346003)(486006)(3660700001)(33656002)(316002)(6436002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR2101MB1119;
 H:SN6PR2101MB1120.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: FnzLcWVbIlHivqhsiwNXBD4wjzM8baQb8OkXN0xEGuBUGsXu45riwJcNV2mEZlMKWTvqOVwJaU3D3u/50wEZ3k2yaY8kKabBXTqu4YupTqygGOF+ZJ9idghVEIRDk3Vcm04QJ71cpiLeuOaQD5t6PuRUiiZk035GWrwU1LVQQ4BPUbLnsWSlGJFO5DMWpD64
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 009d7e0b-7527-446f-f1f3-08d5b5cf3654
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009d7e0b-7527-446f-f1f3-08d5b5cf3654
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 17:06:31.5716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1119
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
> Subject: [PATCH V2 2/5] X86: Hyper-V: Enable IPI enlightenments
> 
> From: "K. Y. Srinivasan" <kys@microsoft.com>
> 
> Hyper-V supports hypercalls to implement IPI; use them.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
