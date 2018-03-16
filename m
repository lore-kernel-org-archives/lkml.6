Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521222128-2-8851462847693939139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521222127; b=uPc/dBLIH2BYz1B6svr+gV6KwKHlcTzuIkhXmXNRi4w8PqF
    3tMk2ymQ9WfCVlE7cgnYRc2xopOu3o4xA4hVnhi9fXLbe7zEKNLVclx/KeAO2nFV
    2K9FXnGpvC+acRlP3tNwEPVDl/plcBgvXIiNFCHVa5nabTodO7JTg2RldjgaXh66
    TWeEeoSXsUodSdzfrX5VssKb0WWdThdZGS42HYiqoe4fN2Prv47DMcVv8TaMElwR
    qM46mor655RMhlLN/gx91Xa2bMVTGlGSJDjhomeJdNerifXO+XgLiQFwgnOLubCw
    td0mZ+8ZNJdn+vboBKyHCrdne/m+cLVLsd2cwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521222127; bh=Q
    gNcvOff7cflBwAvmz30esVv1ZFQZZnIHg0pS0jZDXE=; b=R1+ttFRPP7JwHQnqh
    rOTvnAlK4ZtFqqQTb59yiTyJvwHmBc32aRvwO2EvyHqmw5FsRdJHfWGosBUIcC8y
    b8zUu0qoD80o962X6L6LpvAJGIpZrZhPhuUTIhsn+XujgsAtCKW0PcjUXrk1hh6U
    T9pUM6PejgqhMA8ecmystcKfHKK/W/s5MIxXPsM6oj3krIBe+lHRAd/tLcJh0H9d
    f84M5q+F3nno4XbT0/kuvNrHYpk6reaHs4MoRA35r2+sWh/eN+eVjK24sr+OPKfD
    tpkcLSP1z4XKx2d9C3XV+3lnAfKoC7UjtywnM5EIasMooP4RWmeX7/U+xc56neuA
    VEskA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dKs7z19q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dKs7z19q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Thread-Topic: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Thread-Index: AQHTvRUvoNaABQDMC0G3r2/gk+Xw06PTHeHg
Date: Fri, 16 Mar 2018 17:41:27 +0000
Message-ID: <KL1P15301MB00064DA6B4D221123B5241CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180316105424.GA24198@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180316105424.GA24198@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-16T17:41:26.0382290Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:e::40b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0023;
 7:2xsV3nhBiW8NCMSuTHSC9mDGs+1kvMnUXatnECE/V/ZqscIn5WDo8pqKWZaI1aBnPI9sJJ/KddhlpQnqrJTkTuAbnkgE8fW2lKGsxG1UZBuHOVUnx8Dbxr39iWkisRAA0oK0G6lJoxMfbrref2u/nelviuArHr6Tw2d/WOr2/0fP2Plr4zWBM1saVUMIwPK8CpIw5A8uVc2ZxpJlh4HfBi0JATqUNAwl94AiUQXcv3V+g69SOtpdKl/u1Khssvwm;
 20:5meboK3U+OO4Rwl1lEBjm0lVg9KgkFX6dE0w2CuimXiZ/u9xQh+TT2Gnmbv2HwZeGBbDEZyjPaPOkpW7UXUOE4Jy1sNINyph7SyRlheYC9sWh7toH35P6VCSwfLAP0g5S0W2dP7w1YOyD24zABAlzYv+0oUxyQ3VT3LTmsjAsxE=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 058397ce-0f95-4429-ceb8-08d58b6525da
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0023;
x-ms-traffictypediagnostic: KL1P15301MB0023:
x-microsoft-antispam-prvs: <KL1P15301MB00233A4DBA1291174D6E208BBFD70@KL1P15301MB0023.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:KL1P15301MB0023; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0023;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(966005)(7736002)(68736007)(33656002)(10090500001)(6116002)(186003)(10290500003)(2906002)(3660700001)(478600001)(3280700002)(106356001)(6506007)(105586002)(54906003)(22452003)(2900100001)(316002)(102836004)(305945005)(8990500004)(14454004)(77096007)(25786009)(4326008)(53936002)(9686003)(6306002)(55016002)(6436002)(59450400001)(107886003)(81156014)(7416002)(81166006)(86362001)(76176011)(7696005)(99286004)(8676002)(5660300001)(46003)(6246003)(97736004)(229853002)(86612001)(8936002)(2950100002)(6916009)(74316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0023;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: HmermEp2aHKwGFvJWLkbmF1xg/LMpMCK3CMS/WxbCzEfC7Ya2+6c+sIpT6AK+BivMNT9Ak5X+jhx/actWq7sCmCg1sEtb4eCCu1XDiT/E2I82RQbqdRaMT5rl4xS0NIAbtSojJDAdWe8yAzZGV677g/7xu8YbOTgZFKCig8Ww2aNAA9GmNJLywN9k/7kZTEbMiP7fF14V+gLro4Ps8aD+rv5XWJeollCE9mmpaixejp+c7GRZOnbAVywU5IIiNAd4ZIYD3TuEFpDJDzPEdtu9zMI1tuiua1JJbSaapk9EmDtj6ClYdYZRL0p4y+Yp5uypnUidOxVowQIreG1YjODjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058397ce-0f95-4429-ceb8-08d58b6525da
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 17:41:28.0483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0023
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
> Sent: Friday, March 16, 2018 03:54
> ...
> Dexuan,
> while applying/updating these patches I notice this one may be squashed
> into: https://patchwork.ozlabs.org/patch/886266/
> 
> since they logically belong in the same patch. Are you OK with me doing
> that ? Is my reading correct ?
> Lorenzo

I'm OK. 
I used two patches
[PATCH v4 1/2] PCI: hv: Serialize the present and eject work items
[PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
only because the first fixed a real issue and hence IMO should go into
stable kernels, and the second is only a cleanup patch, which doesn't
need go into stable kernels.

Either way is ok to me. 
Please feel free to do whatever you think is better. :-)

Thanks,
-- Dexuan

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
