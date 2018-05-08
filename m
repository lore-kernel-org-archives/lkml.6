Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3571979-1525820788-2-8125891604323150521
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
    1525820787; b=S93q3Umn2EbMsxCLgk/fquGVxD7iFpzHMOezy7ob8JBvYzjuZp
    R9cVD4q3LTNjubiJiG1GF5fPFV55ARg3KOh58GWT1KoxBFpakZe3AI/Jb/Fi4nqc
    pXTEDA3uXzp/S3jIgZizh9AEvBY6X0NHn/jPdcagIEwADkPo0nSaXLksG2W04QrU
    RMkGMR/xxfsNkpFssa4thNXDe1+PRXXqyJutte9TThocI5+Dr1AsuE1jd0Jqn0IA
    /D8hZyqDjRWKEsXdcAF01RMoXqS8R+L5kkP0jiGdsYgy1xmOl6HsefT6JyZB//YU
    hksopWre5E0DC9VjZ+/iu4CTWSVy7fpLqIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525820787; bh=Si7gR
    JVAY80weo3PerQ4N8Nfa/JBUIqGmDV56mhV1+g=; b=FaZd8uh3evNnZV3/yLYV6
    WEpg+PONYhb5pAuD7cuihjK0t0UoBNaZzIfhgrzBYeVw9KtOUh1VXKy7rek2WgnB
    J7cz02phpsuGAvi+HKW1Gat0rs2o47uKmuUhkLHcR/Vq1+GDFuTPjf0NL5aFoVoI
    KIMkp5IaetjFGsnX2WJlNGMDRgQlH0GPCZcj5IqsJDVyUYX9JnJb7FRbkea6mNE4
    xE4udOm3RIjVuuM9dr84Olp0Vc8fEY1wjEHgwAjSbzGp14WRrx4OzYSC/7x7Vpl0
    btHuG9ScikaRVSH5btn78oUOWht5SNBGAnGNzH1t2nuMuUyKb0ndoDfLyXxX18zY
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=dnuYnqxi
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
      header.d=microsoft.com header.i=@microsoft.com header.b=dnuYnqxi
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
X-CM-Envelope: MS4wfDsXpzLph41ZdN/xJJEvgmtCeFZNUQtY6x2R5ZkKlI03e3kumufxQYFJ2nHzp4hvCgC8ZGInT9dbDURto2XFmQ+FipyiZnePsVz7j3++8uwGbIFOleqc
    P4FGbpBZKAIowhN1v8ebm+18ou+7uRT5za0ZSuCDEwMOKMN05maGbkHXbgKLn8EJLaRDyvjQl59SKCHxRokZZMaACldFwRIM06kOGSLA3Ik7+4MqNz+d0o7F
    L/b0v4dXA/ukyL3zlfdpDg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=pP0Gbf12DoIA:10 a=hyy5rRJ4iSQA:10
    a=i8TdBrTEp8QA:10 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=WdetqbSWoILD-OKlLNIA:9 a=CjuIK1q_8ugA:10
    a=3Sh2lD0sZASs_lUdrUhf:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Thread-Topic: [PATCH] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Thread-Index: AdPnGpZjEjN6JH3ySGSQrnm2yoYh9wAA6qmAAABexPA=
Date: Tue, 8 May 2018 23:06:02 +0000
Message-ID: <KL1P15301MB00064D52564FA764B6B00CE9BF9A0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB00067B95F6D0B3D97387E315BF9A0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180508154525.37b6ddee@xeon-e3>
In-Reply-To: <20180508154525.37b6ddee@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-08T23:05:59.9761146Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [131.107.159.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0038;
 7:bE1EE3x4Tg8y/wNMFkqLZ8t8sUH1ILh+jmfKQOdZOWBzYeoqQ3k3ReVWh7qPXhcuSIB9GsroL8CtOX+Osuz8SaZdm7WQXrcHsNjbq82LK3Gd9bUEtogIeFZ+52w7ILB616H19a3fzXSfujfSpHuydL95OKfBr8RXrP72iHWB0bkCWofAOjlIylQyyD/Y28mpf0gxh8WCmdyaG7dQMNWteyWfj/GxQyoBwjkwoHIT66kNoCiH5gRaswd4SaNVqbfg;
 20:8NBpkU7y3eibCwmFF/XOaVL2AS7y6QmytzhtWTMXzTsMlXYpSs1IcA4F784eSbVtT0LkYIbkMMZX3MbA1q6wlJHlzF8y5QnePu6e9nHbTVgpN/W5/YxaPsv2KzXerWBPUs0QXXpfB8QBPekX1/IUvxCF4FwYimHSdFogCC0FoK4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0038;
x-ms-traffictypediagnostic: KL1P15301MB0038:
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <KL1P15301MB003801F5AFC46A9B1C153F96BF9A0@KL1P15301MB0038.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:KL1P15301MB0038; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0038;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(39380400002)(39860400002)(396003)(376002)(24433001)(189003)(199004)(316002)(8936002)(33656002)(2906002)(81166006)(3280700002)(305945005)(9686003)(8676002)(22452003)(74316002)(6506007)(68736007)(55016002)(10290500003)(81156014)(6916009)(186003)(99286004)(7696005)(25786009)(26005)(2900100001)(54906003)(97736004)(76176011)(77096007)(102836004)(5660300001)(4326008)(6436002)(8990500004)(486006)(53936002)(106356001)(105586002)(66066001)(86612001)(7736002)(229853002)(6246003)(6116002)(11346002)(3846002)(10090500001)(14454004)(476003)(446003)(3660700001)(86362001)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0038;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: 7u/uIS0quacs9D3cfhKa8O3KsrZR9Pfv10I9KXMuDml/3SW7SuO4M0A/XvWYv5pecBoKz0jK/TkgNmB6R9pqhDKLcJ9GGcq2vmCNsopeJtFs1NhF/4QrK5C5ycayU85+CLVHQAfojpIh1O0YRnlaCY+O1gS7S2he9hPcdng9VORZLkTJUVKpfM8BYtK6a4R/B2yVZU46S9v8iV4uFn/hag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 458c8b4c-b483-4cc2-ce7b-08d5b53845b4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458c8b4c-b483-4cc2-ce7b-08d5b53845b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 23:06:02.9802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0038
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
Cc: "'olaf@aepfle.de'" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Jork Loeser <Jork.Loeser@microsoft.com>,
 "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
 "'jasowang@redhat.com'" <jasowang@redhat.com>,
 "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "'apw@canonical.com'" <apw@canonical.com>,
 "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
 "'vkuznets@redhat.com'" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, May 8, 2018 15:45
> On Tue, 8 May 2018 22:26:21 +0000
> Dexuan Cui <decui@microsoft.com> wrote:
> 
> > @@ -63,6 +63,9 @@ static __u32 vmbus_get_next_version(__u32
> current_version)
> >  	case (VERSION_WIN10):
> >  		return VERSION_WIN8_1;
> >
> > +	case (VERSION_WIN10_V5):
> > +		return VERSION_WIN10;
> > +
> >  	case (VERSION_WS2008):
> 
> In a future patch, we should get rid of the use of parenthesis on this switch
> statement.  Lots of other cleanup of this code is possible as well.

I agree.
We can make another patch to clean up this function. Maybe we should
replace the function with an array of versions.

Thanks,
-- Dexuan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
