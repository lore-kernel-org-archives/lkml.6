Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1673992-1521823275-2-2785892692836271926
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521823274; b=vATOxAABR4JYs/2L3y53CQ5QHCzTf01VM+mjBOgJBsF75DG
    fahSALn9DwNO01HG8yo8+Ba2uWkF002u90SLrEiL+zZXNRVbuXVoAu6KYrqxkiUf
    LkfA+XBBZRAER6M23YHZrLTi/+B0AGwR0P5YWveZVDSIm6XyjeijSWmxpHOO6FmE
    Z7LoAzKRelKPsOEmShzz018aa06Y0EiO9Yc1ZKRIAoeqqX8sV5LMJbyRNcAmJLEp
    IA7qJa7p7vZinmkZ3H1gTwym8Sh2tL60g/DJTYKHvWE/OicOF6jBBvQF5JHPvn+Q
    p8YhjA9EztkYDU86KsgXidvUrpQqSk6hD/o2Wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1521823274; bh=AS/WQcyXh/8SAa/qmADQggmpbyr
    knw06V0lTa8wvYq0=; b=Us3fUiOr9ZzTUnd5gfITFS1OpYn6z1RJU1C4vHFqWNq
    2z31jx3/FjopnCaIzVroFi71+y8yCCwUPiE9RDNtV/XFlA69wtL2ZXBjxJLiS90J
    De/qAdq4guOzHxqPRjdpQO9BpmxumCss9McAVaf3iqshRxz7WsrtkJpRvlmzivm8
    xC06rv4g+SAUS1Dt1VwtFr1ynqUZQ0EFkS6zlkOVZ5HoLtq6NuTBrj5muR/B4HsC
    ilAnN1NAwGAi147xHMcS5cd5DbkY/4DW4r2dbOwClyHD287bkeQo2UypdslbIV8H
    DwBt4UFXhhxqp3a0a6atmp/uqNifrIuGFsTw0ea2XKw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HAV5cuhy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HAV5cuhy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu/D/DaxTLK2/o0CSPNG8bCOBxaPRM+cAgABaE+D//5pngIAH090AgAB/YQD//9WnAIABmXUAgAKzfoA=
Date: Fri, 23 Mar 2018 16:41:02 +0000
Message-ID: <55A0639B-3C54-456D-95C1-829332C024EE@microsoft.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
 <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
 <20180321162555.GA16028@red-moon>
In-Reply-To: <20180321162555.GA16028@red-moon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [98.232.109.128]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0699;
 7:EinE67k1i54+vsA5z5BSI8PLdfBImUbI/eROO5is5oodHr6P2r39eslPz8wj3D7MpEDp+Fsqt8yfuKYNXB7hS4EfRpUY1BxPc52XKFEM4rH7fjoID0cRd5TgJN4FrS7x7yEGtXkbT62MZNAods17PNVmEacrp+aNBJNJYZRuD0r/l2LdVcNO+/QBkd2e7YIRdjHAumFXjIUSjLtEjAnjcBTBEPpSv4kfJ301lJRPIHAdLKPpffHsFFelXm7nqybh;
 20:o57Kg6DIavT5zNLpIMb/KG4ewQHKjHJQPApLhlzH8iCm4cEW47VNObMT3SncemGqYTo9PnO3RHLtxrFAhhuZ4AwBWS3bd47rFB4ckvO5VRqp1EpJQlAbBuEcClnBLpCL8xxjAQ5wXxbRslCLZU5Nl1jWTGAge8sdkFGlzWu4aH0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9ea147a-fc1a-4faf-3d0c-08d590dcddae
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0699;
x-ms-traffictypediagnostic: DM5PR21MB0699:
x-microsoft-antispam-prvs: <DM5PR21MB0699C4C62A27DA9DE9F967F6F6A80@DM5PR21MB0699.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0699; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0699;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(376002)(366004)(39380400002)(346002)(189003)(199004)(81156014)(305945005)(82746002)(72206003)(446003)(68736007)(93886005)(106356001)(478600001)(5660300001)(36756003)(54906003)(10290500003)(2900100001)(7736002)(11346002)(8936002)(316002)(81166006)(86362001)(86612001)(14454004)(8676002)(229853002)(83716003)(3280700002)(6916009)(99286004)(22452003)(6506007)(6512007)(6116002)(6486002)(53936002)(10090500001)(2906002)(3660700001)(105586002)(3846002)(25786009)(33656002)(76176011)(102836004)(4326008)(97736004)(186003)(6346003)(5250100002)(6436002)(26005)(66066001)(6246003)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0699;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: Bj7zrrAe6OyUGVQwcuasVhaLDGW+7Tc3hHf4L+7o3wFQQ4U+bLVG/+AEnvZGNyLrx3XuASiDdYIONXIYsAskdusDvt2pYbtF66aATV6lDL/DPLRzv4nsDDnwE0aEG+gPqgMcP8imkDgBIHn8wgEiTQRiHZM1egTEPC7CVO8VX821hH3f84jZhbogUOpTIsaqkB/W54fQmQQhJP9mtvacPagHkJTTox/gX728Es5O4qVoDMYmxNs0CI9o0QHkWtH420qhS9rj+YrfuYV/VAau3NxPzplp8jjeXNAPBNxe09ZyxSSkT7AUT94MOlRlIWKOBh4H1nFVQ20Mc5gO0jmu9A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <377C91B14182B5418B4E3B04FB4B881F@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ea147a-fc1a-4faf-3d0c-08d590dcddae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 16:41:02.7440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0699
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

    Please read the link I sent you in relation to email formatting.
    
    Then add your description above in a way that anyone not 100% familiar
    with hyperv can understand it - that's what the commit log is for.
    
    You are sending this patch to stable kernels, patch above has been in
    the kernel from v4.14. The patch you are fixing since v4.11, you ought
    to be careful since you do not want to have broken kernel versions owing
    to stable patches mismatches, that's why I asked and I will ask again,
    are you sure you won't trigger a regression by sending this fix to
    stable ?
    
    I assume the bond driver mechanism is now done and dusted.
    
That is correct. I have sent a v4 version of the patch. I am sending this
patch for stable kernel. We have tested and I am sure this should not trigger
regression by sending this fix to stable.

Thanks
Sridhar Pitchai     
 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
