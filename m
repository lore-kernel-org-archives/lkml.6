Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-779193-1521136530-2-3063086534565201566
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
    t=1521136529; b=su7MUe8cxUC59Yd6xMVlrj/wSYdByJdsaLmE7JTlORBzNPY
    wdY3UReGoeeIfPGaNVKI+I2AJuBSfN23vqLDeKxjfAjFtmiI+Vn9iuptyaRq2l5u
    nfOdLQmpQCp4SYiWQWhdnfDj3p3vgmxC2ZSV3HJd4SNO2RvCVJwifTRils3fF2LH
    mva/wKOj0V6zoSKjvXjMVWmK5QqxyvZ1+VmxMXODBgNR8aKojTDHIyV5o17szGta
    oCGxmZhouYYHOKhfALdLjhJNWu2w0IIPnRkhPTrPxxJx2jgGGsUPhNqrdFaW8PRH
    8cWTOdFUWZxqP9vNcYq/qFBXy9GFmXS+ZnNIJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521136529; bh=+
    iZQHuq23tpRU4m+3B4x32u/QBt5qGKOJHnz8vBvXZs=; b=lcI0JyJ+eWdBqDG91
    97WfJ//YBRy5VtaT4D5BhSfwxFMnYtDhptA1iEZrSd3DC3Z1Kb2fs5SXwCL/WE0/
    n5PL4062+K4zVZqSVkI8MKynN5YFzJj6HqdZjpqTUc3INIsWG0xn2tZhxn1jv4Rn
    SlqxxaMYLrXyfkoiZtaFYbvD9J9Vn7FHfGh0OkFELTaCSRKRdLNwm1ZWjIXVqL4S
    9lyjRwxgFY2kYDSxpOuezJHwDV1CXR4dPh9K2QyS5Vs8AJgKaNv/23yF/He+lwuK
    +E+y/O5UGLAzmDLukmWMqcJ+1pFAf3EDPgTFcRbnFJPTlS0Sjeo3aZH5hd9kOOfS
    L+D9Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iCuQhi/S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iCuQhi/S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: RE: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work items
Thread-Topic: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work
 items
Thread-Index: AdO8O3aRSVmxMVp3Qwu6AztIm4xINgAQ81WAAAFLJ6A=
Date: Thu, 15 Mar 2018 17:55:03 +0000
Message-ID: <KL1P15301MB00064712309002FB85341ACDBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006C96F94181FFB93A222D8BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180315170131.GA22134@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180315170131.GA22134@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T17:55:01.7168159Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8::39a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0038;
 7:QDPwNnmQ0sXh+tvBT/2XF3DEU6cRGZMIFmM0fXqUsv30EimluB8b0xEu/aNH+I13mkcVzJZ2EsshihoFUyoI5dKJGw0i5Yteu2LPkzEH6/CUJqNPYoI4AbHpNf9sEkgnFnI4puPDmXfRK/GTSkker2beEMJ/7L7Akhc9KaPUaTzpNnWQaoHw2k4eFGcklrXH2VBurmIBM7fWToK2BjIz66U6TmLez2esoVP84tC/Kl0bhpVCu1fURSyKcNMxSxAW;
 20:ZxDdM6OmoE3SfrE1NS/uqCvUFAvL2r0PYHzC7PIiDr7aLLtkuibVKgLvHbDdIz2uZV6n+jf5A5HWjnx/dwFkt4ZuzWrDzR0Y9yF0fbIAbier6n/fBU4gYHM7zMmTj+9DeCRif4B8pUaPoVMT/yUi5AtYDa7ighhLD9w66wObxOI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8760c97c-dab4-4f3e-5c4f-08d58a9de147
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0038;
x-ms-traffictypediagnostic: KL1P15301MB0038:
x-microsoft-antispam-prvs: <KL1P15301MB0038DBEAC0374A5CA696BD39BFD00@KL1P15301MB0038.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0038; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0038;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(14454004)(46003)(6436002)(10290500003)(186003)(478600001)(5660300001)(2900100001)(4326008)(53936002)(10090500001)(86362001)(575784001)(9686003)(2950100002)(6916009)(97736004)(77096007)(55016002)(6246003)(107886003)(106356001)(105586002)(99286004)(229853002)(7736002)(102836004)(6506007)(2906002)(316002)(25786009)(22452003)(8990500004)(74316002)(7416002)(6116002)(68736007)(76176011)(3660700001)(54906003)(33656002)(305945005)(86612001)(7696005)(8936002)(81166006)(81156014)(3280700002)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0038;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: XHoDttLnst+rJKMfZQulYSdAASSC5lhuChl12cNc8Y7E6/eN2PeEuN3Y4FQspalSh8saIHYzgGmuhIoGp6sK4Ubt/CeXtfBvGXu6Xn7vkBBFv3PACk7kaNxoEapw9bARaS9fCaNh+rYSCBvmTz32Svcqu5Tde7jM3ZFL/GpqaIFcgPfEEgPWDBOMTyuG8jDxaqWHnHhyNqrRAXI/8J1O/A81JMlu+T9RxqzcBIbNctoiQDTPB3uCGUo9mCqD2J0/HJq1APd9UWPaCwm+n5EH7W0yRJqorN5ZGsnFyhseeuLNeopj3jVaiwWrXuiZtjlKe9zv/B/WrvbzKK1Z97XDqQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8760c97c-dab4-4f3e-5c4f-08d58a9de147
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 17:55:03.2310 (UTC)
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
> Sent: Thursday, March 15, 2018 10:02
> On Thu, Mar 15, 2018 at 02:20:53PM +0000, Dexuan Cui wrote:
> > When we hot-remove the device, we first receive a PCI_EJECT message and
> > then receive a PCI_BUS_RELATIONS message with bus_rel->device_count ==
> 0.
> >
> > The first message is offloaded to 	(), and the second
> > is offloaded to pci_devices_present_work(). Both the paths can be running
> > list_del(&hpdev->list_entry), causing general protection fault, because
> > system_wq can run them concurrently.
> >
> > The patch eliminates the race condition.
> >
> > Cc: stable@vger.kernel.org
> 
> I need to know either what commit you are fixing (ie Fixes: tag - which
> is preferrable) or you tell me which kernel versions we are targeting
> for the stable backport.
> 
> Thanks,
> Lorenzo

Sorry.  Here I was hesitant to add a "Fixes:" because the bug was there the first day
when the driver was introduced.

Please use
Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
or 
Cc: <stable@vger.kernel.org> # v4.6+

Thanks,
-- Dexuan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
