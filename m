Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3747066-1521230114-2-5727142191477337489
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521230113; b=fhD+0oh2D9uD26pr7s5Nbd9TjhwmYd/+DEA8fBHwcbQXyXZ
    hy8egfHmOV81FDDLRDEfVfXEudcoKN2IQ61gDIPUXZws4p0SIFE+z/X/tAZjevgz
    I/vGLG+7v9r90WRcQX3Rzizi+oloQXc4yFA7dqNfFtRifhCGDNYYSk6RlFnBg0Zm
    9eFFYQG38frLYaeBk/jny4wbP+zIEsvlx1r3+Izp9M2o4WMd6nGiGoKS5o26Cvlx
    MY69UhWT8DalwM8gQKIqk5KkjeicRzeP5GnApH7AeQ/qc1mvyt+WCMKRDCrcJh3H
    hPdhtPi80Mrpm18dCdZH+bHVbrJy8fGuyNT1v7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521230113; bh=/
    1LfLdftWHv7gImcemRfutuWg7FMpk4hpnkJKPe013s=; b=p60HL+o56B3rO7rzX
    tV9XhgLQ7yuI8vLDmUZIhnuZ8p7T+G8/XwD284fLCMLY0lJNN6HHbrMlfSHaa2qp
    jO2sFQ5DUGM3tvThE9ja4ogGjmuBNy5RELDphkf0yaIpiA9QlvPcPMf9Zkw7JaY5
    IGNbf5LrFLlcXb9G68Q8QIelSQB717K9tHDIY68zzPEJ/Jem+TLV/oOf13z/7vAY
    rKsZDZgmNQ6a6tZfzut6nv8qSFIno4ZZHm965Ej1HKlL26zC+SMzAVwCL7jN1Adt
    rJJISFP4Xdln6divYE6cPI9ZfQMzEDLljabxS+q9jMJmMvjw+Q5VIUdi6HkxWQ0h
    5yVzA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LXrtgYbh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LXrtgYbh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Thread-Topic: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Thread-Index: AQHTvRUvoNaABQDMC0G3r2/gk+Xw06PTHeHggAASFgCAABVKUA==
Date: Fri, 16 Mar 2018 19:54:36 +0000
Message-ID: <KL1P15301MB0006B990BEA39A8179D5F8CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180316105424.GA24198@e107981-ln.cambridge.arm.com>
 <KL1P15301MB00064DA6B4D221123B5241CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180316183158.GA13569@red-moon>
In-Reply-To: <20180316183158.GA13569@red-moon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-16T19:54:33.0513555Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:e::40b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0085;
 7:CIDO0BmK8jvbgjRVYpjq+xgqIy690NujyD3rRvlPDwLxF5icuTDAAB0v+vXaY4WFDWdGy8g0oYDgVG76RFOcaELxHraJINAsG7wj3d9x/ymwgcShCG6uKt4sOBV7MnU70QtUyL2171M9QeQOjbAeEXkCn2N2EXssVBbQND9riJDADcRNeRsSATlzuBxP2Z2Ot5NAgI9O2yXvvCrBmNTic53Dg8N30RrGVDufL4jL0+mgZT5YU2ru3kiXiu7kLWDp;
 20:j9nl4jaD2kr8TCwJ7thmwKwE6OV9wqoLEPLzo63PN5dOL1IUTwQEq5cTjjF1g9Wz96DIfR54dIUPuCLMZpUkvckZ9H//lCveZx5iWpUukp91ggNZ9s9UHr6ZJBQliUY11/6RxF6BQ9/K/BoJFDF2GfjcwoEC5N1idqXisclQats=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f569179-a37b-481f-5bc3-08d58b77bf43
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0085;
x-ms-traffictypediagnostic: KL1P15301MB0085:
x-microsoft-antispam-prvs: <KL1P15301MB0085C508D7A258FE6F2CDFA9BFD70@KL1P15301MB0085.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0085; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0085;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(39380400002)(39860400002)(346002)(189003)(199004)(97736004)(186003)(3280700002)(8990500004)(305945005)(6116002)(7736002)(6916009)(2900100001)(46003)(102836004)(53936002)(229853002)(10290500003)(6506007)(7416002)(77096007)(2950100002)(107886003)(6246003)(5660300001)(93886005)(10090500001)(9686003)(7696005)(76176011)(55016002)(14454004)(99286004)(3660700001)(6436002)(105586002)(25786009)(68736007)(86612001)(8676002)(8936002)(316002)(2906002)(22452003)(81166006)(478600001)(33656002)(4326008)(54906003)(81156014)(74316002)(86362001)(106356001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0085;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: 0nj1oiYP/SPaoPEsb+up6lEajFkLy2FGBwEdEZEq20Cb0TlWAWWuOMQB4Hu5DGjzL1G5JB8OeWDkU8RrfZgBzC2roD8HN2wVUjmrbXBw1NA9u3ByfgAmN2s0eE4rZ9EnPy/3T5us89XZ8dP5aW3ReTgnq6KDrvit480wzHj03cfdTdDt2wRYrIj5h7hFwM//JmFgtEHOZ3AgMMqEF92AB4GNdHdD1Ldns/ovdYQ5mJohNlywSOCi3hNX5jtTCjpkZ/LZYtzalAal+8y9R6AavC+/awOAZpYUkBNZzPsBZsFA/V76YY+o64RRhnCanTgmUuOEp8NXpFHMfPuGN/wApQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f569179-a37b-481f-5bc3-08d58b77bf43
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 19:54:36.3590 (UTC)
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, March 16, 2018 11:32
> ...
> 
> OK, patch series reworked and queued in my pci/hv branch please have
> a look and let me know if that looks OK for you, I won't ask Bjorn
> to move it into -next till you give me the go-ahead.
> 
> Lorenzo

Yes, it looks good!
Thanks for updating the commit logs!
I'll try to follow the writing style in future.  :-)

BTW, I hope these two still have the chance to go in v4.16:
PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
PCI: hv: Serialize the present and eject work items

Thanks,
-- Dexuan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
