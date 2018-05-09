Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-699659-1525885557-2-12087434702382866782
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525885552; b=PSd/yP7lXoTkY/ZSFwKazeuMWmzrmei9OJdn2Qavuji8GtmSYZ
    o7PkLX64VCS/PXO6G3Gy7Mszabe8q7f6PvkVFxZGuwfwoiIWynwKc4hgoPzGWEjR
    gMG+QKaWo+f1NDzrYniihyxClngYS6Qh6Jv4Gswf9F3v4CL5vgAgxqX2ERXTKYzY
    Jq4Wz/XddtfEAX8BvTV6/9uOauWOYuAqSymZD8cw/1fxZJglxTZQqHpRmWbKw7ph
    Cwa68OFkkd30ceIPspoVcSpanCc0XhUO6K1W90pfW7aaS91pFLL3yaGBwDk1wlHH
    XD7gZt5xG1hXtTJ3LqQReokZ8VXZV1FJHbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525885552; bh=v3Qw3
    jvSMyrdc0ASFHn6+z9fPpdyegS9WbRp72FMNSg=; b=kGf9orXzfUY0wvEw/BJ3P
    ymiZTI0gKABiC6GxlLp5Y1sQBaXGHcPhoMz86g8e7ufzzfl1RS7nts8M9DQJV7eh
    x4UcbjcHTsTl6qgC670Vq7DHMVeu+1ltuOHjlZU9JGndaPKIxNPIU2/OXrsRYL0y
    LprvbV0fUw9ggYHVAvIiG8gRS6PyfIO6iIHntOfB6aydxcoDTOveAR2pUvUikGxI
    0/i5pnCgGev55IOFtLwxWSHyz7/TU9j1jmVADJaFffoWQtcTVmXSWlJQx5mk/JqW
    X46bI5KbV1qHK5WivNYTgTNo9M3L8JtZ4hs3AiyF0RrSi1vsFjG/NBqvGWkkFC49
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=QgKY2R9g
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=QgKY2R9g
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
X-CM-Envelope: MS4wfD7q1NP4RxTLw2iJi414heE07vZIfL3KGrCGMzPGS6KcRO0Pm3K6kCj5OhA6Mq1oBRLZUexvbUBzTSKAhKf3elbLeSVGxHSoeEplYG2RifzKs17mKqEs
    BfMWdQX7eEstWu8gB9FMnPeAejC1NV3GUWNPTXv+6fGaCih0+jMND6IpA/0YCqEHk0gpl4N1EF/2B09AqepIj1xpfaZW8eW25l8eSsk033XpCwHkzGpRg4fU
    hyekhGhaxwo0O2GYcRVk9g==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
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
Subject: RE: [PATCH V2 1/5] X86: Hyper-V: Enlighten APIC access
Thread-Topic: [PATCH V2 1/5] X86: Hyper-V: Enlighten APIC access
Thread-Index: AQHT4252kwlb1L/FzEeK3lpHkIBHGKQnqMNg
Date: Wed, 9 May 2018 17:05:38 +0000
Message-ID: <SN6PR2101MB1120FB47BCCFBB1C3E04856FDC990@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180504060653.3240-1-kys@linuxonhyperv.com>
 <20180504060823.3345-1-kys@linuxonhyperv.com>
In-Reply-To: <20180504060823.3345-1-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-09T17:05:36.8150731Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:a::4a9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN6PR2101MB1119;
 7:b408w2lYK0wJJR7E0Cg5c8WVe9SXXBmROrCHlnwztyfMgiwK5ipwzR1KsCl7s4vCMl/q45+28Y6Hn/txnv4365HbpXdWksiEYnUjDTwSbOTC3JskCJfz77Y9ipGq8xeKIHzZhEQjJCTWr+jnzohLA0URzBnR5u2cuWNmJHTC9pk1DNZ2n801GLx38PQBaTVvPDJzhplKTyBIcEA5QNcI+6JsscNH8UhPpVpS1smfUmtCO8aiHfN6J1paVMJqg7dk;
 20:2O+FrKezfBlh7GWfTr/7hf8SQboTP+GDU7DPFcGTIHzA9Ts+z83RTlf4DFei9LWCX5dFa0jAoRw12LFK7WjPabM+9ApgCsXEfsGYFR7Jau+jPTjJB2UKvGvur+ohf1UbfVXCtwDpAQ6eUwjwArF7EJgzhV6D9UKgRLqvX8B3jQU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:SN6PR2101MB1119;
x-ms-traffictypediagnostic: SN6PR2101MB1119:
x-microsoft-antispam-prvs: <SN6PR2101MB11195E4D167BC7A842BEEC3CDC990@SN6PR2101MB1119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:SN6PR2101MB1119; BCL:0; PCL:0; RULEID:; SRVR:SN6PR2101MB1119;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(199004)(189003)(13464003)(59450400001)(11346002)(446003)(2501003)(6506007)(5250100002)(6116002)(53546011)(99286004)(478600001)(476003)(53936002)(72206003)(486006)(3660700001)(316002)(33656002)(6436002)(110136005)(22452003)(3280700002)(229853002)(102836004)(6346003)(2906002)(6246003)(97736004)(46003)(2900100001)(8936002)(7736002)(5660300001)(74316002)(2201001)(8676002)(81156014)(7696005)(55016002)(86362001)(14454004)(105586002)(305945005)(1511001)(106356001)(8990500004)(7416002)(86612001)(10290500003)(25786009)(68736007)(10090500001)(9686003)(81166006)(76176011)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR2101MB1119;
 H:SN6PR2101MB1120.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: u9ksuMInWZkZ5yazvO+aucP53/Dt9EhSW1hFzm2FIT0elRK+e+kADyHe295B6BErl2MoxLGXvDhRA5R7CifAM7u255iXaE0vH7vu25l8hGZZQVfBqFJw1m2nHKfu/GRt9fZ6J8Z/e/CPxAOcqDIenrk7fNwqKnr/x8QSPMVVdmRVoDyoBBB4HQf+Q9RjWTzZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0307405f-f563-447f-0528-08d5b5cf16d4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0307405f-f563-447f-0528-08d5b5cf16d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 17:05:38.7613 (UTC)
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
> Subject: [PATCH V2 1/5] X86: Hyper-V: Enlighten APIC access
> 
> From: "K. Y. Srinivasan" <kys@microsoft.com>
> 
> Hyper-V supports MSR based APIC access; implement
> the enlightenment.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
