Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-880990-1521138525-2-16741160778332560477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521138524; b=K6uhjUh31SMRBxoszw95tTC4F3aPZVRhDA/37IaFcy4tCLI
    p6JEGyUIkeFvLyG4HU4PhkNVyfeeuEnT4p+cuoxv767TAqS8p+LPgGwEivso41PY
    2v6wf4yVPJzIgWD0VzlsHqWD+GWLyJm6Sxhdb6O6oY3aQse7CNEmWRS6yOWbGbAL
    s7ORzN6xavjd7Tg99xDM6BdkB4yxZxoPi9y0st5dwR5r+zl0pRYMxvLqDxBW7O0m
    vuV8wJ/WahTEEw9Omz8Zz2rp4obE0BfRKe2gclnnktMJlsm1pd4dVmZxS16L7QWu
    bWDnZHXUIRW//MUJgN2OItZtO0a5Vu/QbxEQMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521138524; bh=e
    DV9vsphkf8AScQFl9ttIBZf4vLKBkVB2fsGeV9DVYU=; b=hp8NaI+rM/Ouw43oJ
    cCQunsz1Y3vyFdcT1mqe47WhVKyJiEl87ZMzxdkZtn/1vCpCu5EDVVs1fdeVUZJc
    iFs5s0Zbh/a9IaFl2TU9Fgu5e4vECWr7oPfDjyW0e2o5rpBd7eF7NkHVFL3CbV0z
    wRkTxOlC2eyUkZYbD8zQ084ZRape7GJvsILP6uhXrI2SEzuc5mM7IJ0wNuj0Nume
    qT+fqqdrePszdplVi8SLcfwfiErsCuXCMgZpdgzR7wAmCwWhuzL941zB/qbktTfT
    zYxnsAX6ZEJFgWf2gWv9rQYOAqocA0TBheqSmbDWOkyHxPU4atkJhmaWwwTmPkVA
    g1JQg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NC6l8QnM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NC6l8QnM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work items
Thread-Topic: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work
 items
Thread-Index: AdO8O3aRSVmxMVp3Qwu6AztIm4xINgAQ81WAAAFLJ6AAATH/AA==
Date: Thu, 15 Mar 2018 18:28:21 +0000
Message-ID: <KL1P15301MB00065FB13CC4AFC4C64DFBB3BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006C96F94181FFB93A222D8BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180315170131.GA22134@e107981-ln.cambridge.arm.com>
 <KL1P15301MB00064712309002FB85341ACDBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB00064712309002FB85341ACDBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
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
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0055;
 7:gjSrlPJ17AQwEqHx6/HAe6rEr8mTplsQMA0DBhCKVZYNtd+jDKUdM3XxmGDb0J2l3N/AexVRBMeTuD0Jco5wK4lUFkoKSLnBPs79WqprnNcCXs+u/zHtgr5dVQojcDOcShjKcF/cVDrFUegCc4QDChD5Zi4NB1v0HDZRTdC22aVAD2vusLXlglZG1T1WAY3UjVhbHs8YEEr6/j5nC1a36zHtrIYpMMD4WmbFslYUimgHOWwJr6G+242Ld+coUiAR;
 20:YfxZg93G6EuiW1tk1YC5rca69z1TGZKPtoLujCbSGBO2tN/ryTWtDJBQbRsGg1qbkBGP6FxmNvdO1MHMTIn10PM4iJxAIoILL3UgGXKMKpFCH+vWLQZ3XBxXVGAf/ZqyHDiT+VsfGsjdXUv6yBZ+n/p80bM6DvynQGL7D23QL2g=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1db45b65-9746-4785-4a3e-08d58aa2883e
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0055;
x-ms-traffictypediagnostic: KL1P15301MB0055:
x-microsoft-antispam-prvs: <KL1P15301MB00558A79D6AD0D0F30611F50BFD00@KL1P15301MB0055.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0055; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0055;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(51234002)(316002)(46003)(53936002)(55016002)(59450400001)(3280700002)(2950100002)(2900100001)(229853002)(102836004)(86612001)(9686003)(8936002)(33656002)(478600001)(7736002)(6246003)(6506007)(68736007)(107886003)(6916009)(8676002)(74316002)(105586002)(81166006)(5660300001)(10290500003)(25786009)(81156014)(99286004)(14454004)(10090500001)(76176011)(7696005)(186003)(2906002)(4326008)(22452003)(77096007)(86362001)(575784001)(97736004)(8990500004)(3660700001)(6116002)(54906003)(6436002)(2940100002)(106356001)(7416002)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0055;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: kyO+LXhoZciGI1K0NVSKWEGKe3F7KNcnEbNriXKPm9aKQE08c+Nv08ldw3ZzwpKhHHUbMeb8LbeNpBIieTEJTcJleyq8Lgt5PgesLob3eR8NUy12XJrLdMS/xtb4Cg5qjlG53II+QpKEU5rqewTCKJwWDcTyPqwK8eQuNLqu6tpaeWyFeiFfmBr0o8yCkOnyx8Au2z4V5TdaBIWQTxrYR8zRQ2IyC6MXXWAyzrhpFAdi5Y7qjN23CvV9sUEVfMj/DhlxttNqcIoDMtZOicnEudgcv6f2BS97Z/0UGlG4/p2bruIZcPFcZXEFeVuOniPHae4sO1sFFEC0qRLbNatJmQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db45b65-9746-4785-4a3e-08d58aa2883e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 18:28:21.1974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0055
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
 "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "Michael
 Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "'apw@canonical.com'" <apw@canonical.com>,
 "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
 "'bhelgaas@google.com'" <bhelgaas@google.com>,
 "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
 "'jasowang@redhat.com'" <jasowang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Dexuan Cui
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > I need to know either what commit you are fixing (ie Fixes: tag - which
> > is preferrable) or you tell me which kernel versions we are targeting
> > for the stable backport.
> > Lorenzo
> 
> Sorry.  Here I was hesitant to add a "Fixes:" because the bug was there the first
> day
> when the driver was introduced.
> 
> Please use
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft
> Hyper-V VMs")
> or
> Cc: <stable@vger.kernel.org> # v4.6+

BTW, the bug here is a race condtion which couldn't be easily hit in the past,
probably because most of the time only one PCI device was only added into the
VM once. But now it's becoming typical that a VM can have 4 GPU devices so we
start to notice this bug. With 7 Mellanox VFs assigned to a VM, we can easily
reproduce the bug by "hot-remove and hot-add VFs" test:

general protection fault: 0000 [#1] SMP
...
Workqueue: events hv_eject_device_work [pci_hyperv]
task: ffff8800ed5e5400 ti: ffff8800ee674000 task.ti: ffff8800ee674000
RIP: 0010:[<ffffffffc025c5ce>]  ... hv_eject_device_work+0xbe/0x160 [pci_hyperv]
...
Call Trace:
 [<ffffffff8183c3a6>] ? __schedule+0x3b6/0xa30
 [<ffffffff8109a585>] process_one_work+0x165/0x480
 [<ffffffff8109a8eb>] worker_thread+0x4b/0x4c0
 [<ffffffff8109a8a0>] ? process_one_work+0x480/0x480
 [<ffffffff810a0c25>] kthread+0xe5/0x100
 [<ffffffff810a0b40>] ? kthread_create_on_node+0x1e0/0x1e0
 [<ffffffff81840f0f>] ret_from_fork+0x3f/0x70
 [<ffffffff810a0b40>] ? kthread_create_on_node+0x1e0/0x1e0
Code: ...
RIP  [<ffffffffc025c5ce>] hv_eject_device_work+0xbe/0x160 [pci_hyperv]
...
BUG: unable to handle kernel paging request at ffffffffffffffd8
IP: [<ffffffff810a12d0>] kthread_data+0x10/0x20
PGD 1e0d067 PUD 1e0f067 PMD 0
Oops: 0000 [#2] SMP
 
Thanks,
-- Dexuan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
