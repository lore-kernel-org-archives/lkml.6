Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1208887-1526324198-2-18353561800970439911
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526324197; b=LKOF2Uf91wMELkjLDPgIBnClBZoZA69w8yqfttUTB39vSq6Wh4
    wT0tPf98njehaXtxr6IWPNfHw6rD1THRFn61mFez5lumUFtOxFFD9Mfj1U8MrSuO
    HPs4GQE91kGeVLJEZZvuAwAUmjqV1mfPF/g1bFZv2pj5Jc99xspMV9943b0+kFxz
    8XuH2yb/JIxKdHvDo9e1HRyj/s9kCEOmnVJWDLcTKYQlzBHOrVlv6uy7T+rrWV68
    dK3HGpukXeSOrVhqme5ttaURxK69uBLKIWtfY2uWe7eX+tptPgUxPQuD1wCdTNTx
    llSO6IXPi3N95QIU/Jq2qwL3c+yEMLEFF3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526324197; bh=j5E+o
    7npuiK+T2nBLjdCJilrI3z/d11srrodAGLHIeg=; b=cwESFPpyTkd5f9gKpt7Yu
    Taq91qtK42FTbzzIg97QfopLKxTAdz98AR4mwY2HKu8Q8KJhgaR1w+VSiVf6XSE5
    2mLrQRCNVJ3xkdLp0VvyE7fhCztivcRS8qDQclhA+8x3DiRalGsk4uS8kk10fRC1
    IZgHcVmzfeONNkM7ySAtGpPhUCefO2g5Sv0MPtFPw7VBSKw5XJFQVVWkq6M7tBBU
    IjxbDNsZP6WsnN4afv6Xc9JdjZUhVziiEKnvNwhhGkOIrLwdRAHdbE2/6S0EmJ29
    BTtzORIY+uXWfIWn6DTBkFeR+hTGkMxrT4xA5BYEAisauz0fS1pHPZPPEvZOukSk
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=UnGlBulh
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
    header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=UnGlBulh
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
      header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE/n4H3ttfFAmKoWXmyllyRhiuvWF+M5yWZ86qVWMcV0h2Gr9kRhNlLpK7DUEGNlNu5B5q9zoURDKPS02wl7yRuJvKSjl7wqEfTPKyotDyAZkFNZ+sT5
    jbsiZ476kxmZRayTmswuh05wIhEkkkZmXSpcv84YETtTBKbu+a2Vx7Pdc4QnewMfuHgvf30EFXIQs2qQMaFH0fnIcTYAwOBYdHL1VbObheVHrp9Ygkgbbw9y
    Xq+ouO/M7Ylcj+COqtOKgg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=R4fxTKrshSIA:10 a=i8TdBrTEp8QA:10
    a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=pXj1rxGmNPTeqkeHHYwA:9 a=CjuIK1q_8ugA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Thread-Index: AQHT6dQOF2Jt1OtZ802pCkKtamiImKQt6r+AgAGeN0CAAAMjgIAACSwg
Date: Mon, 14 May 2018 18:55:50 +0000
Message-ID: <KL1P15301MB0006C2F8F9E32E736DAB082ABF9C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180512093033.12325-1-kys@linuxonhyperv.com>
 <20180513102409.4adc5200@xeon-e3>
 <KL1P15301MB00063E97D759B64F1CEC046CBF9C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180514111755.371d1d46@xeon-e3>
In-Reply-To: <20180514111755.371d1d46@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-14T18:55:47.4868415Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:c::70b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0054;
 7:nyBod1Mr7SMn0npe90h2udfXBvqy+FiGvfWTRkxXHSdXfE4GmpgUFrHUjIPZ0/CYdWVHJng5I0fJ84dj1V6PVEtqKQV4Alz3uAaw6ZzDQOU5sH94wkqKJNRrvUoDihH+v3YJr6zqVbfZN9pnQ8Oust5cgOEJVTco3HVYuUEcQTnJy/9CXnwgnbtnkGKHFVJwQnE2dqEpWvYZVsiLExTWMVLP03/g1vtG13RoR8BcS7slinj96Lwdypq5Mq9RNEuT;
 20:V3M4R/lQmPbq//pVMq5kLi4MCCwfg2ZZwtc0o1VewIs9eNb/LxZDrdYL3M1tKbkL/o0sSUdak//SE2kpzEjrPbuPQ+tAu3Ml/iR28MxRvH1otwZ/hq2EpcmRZfMD2uWJ7ww2GvTklNU/PB4ZYsXg8w7mnhv0GGkueYYy/zkgnUg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);
 SRVR:KL1P15301MB0054;
x-ms-traffictypediagnostic: KL1P15301MB0054:
x-microsoft-antispam-prvs: <KL1P15301MB005477C60F16D807D0059C3CBF9C0@KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0054; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0054;
x-forefront-prvs: 067270ECAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(396003)(39380400002)(346002)(366004)(189003)(199004)(24433001)(10290500003)(105586002)(106356001)(5660300001)(99286004)(102836004)(97736004)(3660700001)(25786009)(229853002)(6436002)(3280700002)(446003)(46003)(11346002)(86612001)(86362001)(2900100001)(2906002)(68736007)(93886005)(8990500004)(81166006)(4326008)(10090500001)(81156014)(14454004)(8676002)(22452003)(55016002)(7736002)(486006)(33656002)(305945005)(6246003)(478600001)(53546011)(6916009)(476003)(6506007)(76176011)(74316002)(186003)(8936002)(6116002)(77096007)(7696005)(316002)(9686003)(53936002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0054;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: EtEEZCuomqPEv9IFopmEj8z9PpiReaOSgwa2LvvKEZCY6BL/aEvVKQ7fQUJwfJOA6sGv2jNOQM+a/BZkGY7heMm5JATUV2S2ZlQnCz8yB3Fq4ifr3B9GFEgE2vsh+7su9t58odbIf2RZEJs4ODFAswR80RiUmbsDeaTHJxtcDx9RWKIZViHA3GCfSxVbhPEA+OmCssVWi6mgnDpyN8zPng==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b3802b23-5ccb-41dd-fe5b-08d5b9cc4fd7
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3802b23-5ccb-41dd-fe5b-08d5b9cc4fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 18:55:50.1050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0054
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
 "kys@linuxonhyperv.com" <kys@linuxonhyperv.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, May 14, 2018 11:18
> To: Dexuan Cui <decui@microsoft.com>
> > > ...
> > > Hate to pick o the details, but buffer is void * so cast is not necessary here.
> >
> > Yes, it's unnecessary in C, though it's necessary in C++.
> >
> > I found the patch went into char-misc 4 hours ago, so it looks we may
> > as well leave it as is. IMHO an explicit cast is not a bad thing. :-)
> >
> > Thanks,
> > -- Dexuan
> 
> Kernel developers like to be concise. In fact there is a smatch script that
> perodically  gets run and more cleanup patches get sent.

I checked the "git log" and confimed you're correct: there are a lot of 
patches that removed the cast from "void *". :-)

Then let me post a small patch for this.

-- Dexuan


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
