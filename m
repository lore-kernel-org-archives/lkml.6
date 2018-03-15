Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-426994-1521123668-3-7162708938988032891
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
    t=1521123668; b=u3iAw6SkNkWEals9Nv3QoR0lFtYeE8K97KOT0pgxM+FUkpu
    Wd6EHX9CWEBIusNHlqmfw4rDganlQBxy6fWVvQlZmJsPE9vyKEsdooQy6r/WcXXR
    gVP6Kj22sbsQllVMz7FBGqxjbulMkMJKcuQUtA2N5PVADPIsdjjF/MijYGSVyz0R
    jSgE70K/v4Ku+s4SCIAugovjI/0jiGXeoxAEHpn1Uiy/wxJAdzhDpWliXkgK6N0M
    cwa8VKhhn1z0IgsK8h1ld8LyBim/1hpLyvQO8n8Q8nJmZ5Ac67QWZY+8MKPvwwbN
    i/h2zl0S2eov22uvcWoIJtHfAw6jYUqScjMWX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521123668; bh=I
    zvj0H57FIk1qzmSKtL/odMrCypVD6QBLF4biX88LuM=; b=fpAiT71RU/U4Jtk5e
    8HiKqTfBaM6yGV/GPgsXWsz/6rd/8f2INwu1lFcSAt+I588pWJvQbYdU2Tcw1iQx
    0D8tBpkPq46C0ACG4aiZe+VptzF/5jFnU1sAjqOdq4wTQFmYggVeUGCqcGW1CCIh
    BfRfnIK1noLsxF/DSuCkr/2/z2z3dCCSK9XM3dxuqT6/g8jnhhtTVIYBPSZukNxk
    dFD/0UxHVZ0MCx5utK1NWowqzIztLXV49AwqL6O3zMDoXMUv2G0H7qwPWctiyBg7
    sfeAqrOAFjLmBr++DiAsT2aBzqQoLqdivjAgd+VmhVE8GcOOmjLMfzkNbaSZbSjk
    2zfnQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BPQKbwlg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BPQKbwlg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v4 0/2] PCI: hv: Fix some real issues
Thread-Topic: [PATCH v4 0/2] PCI: hv: Fix some real issues
Thread-Index: AdO8O2lFPnJW7+KoTAyHL2NY+y1jaA==
Date: Thu, 15 Mar 2018 14:20:35 +0000
Message-ID: <KL1P15301MB00063BF6E1FA30CAF7BE9A7BBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T14:20:32.6879378Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2601:600:a27f:df20:d8b5:442c:6a7d:25c6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0007;
 7:SKaxn3CAfV5+stpkoTu1AVHGyP8itvcrxVYu1bYJwhzn8YhNaVXTkTf4b/iW4S7q3/YrbId4vRkjiKrkigoGrpGDx9mn3djKxodQYQVHKhADBf5yzkWuRdnoP4iOQsWSTWl2lDJ/cGUWxb2HSgtSqc6xyufva49OKxil8kc0OfIIQW5EPfOXBnUH39rWw0rdOQ7hCK2oVxQ4hfCG18d3Yp0BcpUrGjqX7ciES3Eunz4u4QiwmuQSoayoqiIedBf+;
 20:NF/ZOW/40iMrbfbp8Q78c9LhENfpBW1aLMUzoYoA0r12Ax5ilZR3Na3ayo99bMr5WEGfHteVyrYrPxzW0RjkvpLxoDg5BnCbHScuAQg4XHG1X4Pz5n+7MLvmPWGPYRHjMZ5tkLpIiG1fRsxr9VLk/5K5rZir0TQTfn/PjbQqqPo=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f83eb90-2467-4197-75e2-08d58a7feb8d
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0007;
x-ms-traffictypediagnostic: KL1P15301MB0007:
x-microsoft-antispam-prvs: <KL1P15301MB00072D7E96397BC293E4BD08BFD00@KL1P15301MB0007.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055)(278021516957215);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:KL1P15301MB0007; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0007;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(189003)(199004)(54534003)(107886003)(6306002)(59450400001)(53936002)(9686003)(46003)(97736004)(6436002)(6636002)(105586002)(8990500004)(4326008)(2501003)(55016002)(10090500001)(6506007)(2906002)(3280700002)(7696005)(478600001)(7416002)(10290500003)(99286004)(22452003)(1511001)(8936002)(7736002)(106356001)(305945005)(86612001)(74316002)(77096007)(102836004)(81166006)(966005)(81156014)(68736007)(14454004)(5660300001)(2900100001)(25786009)(33656002)(6116002)(86362001)(316002)(186003)(8676002)(2201001)(110136005)(3660700001)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0007;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: lETuUNWOSRCbqpaUz6/Dhd8udc8YwJhbNBaAr63w2uFnqlgh+DZPiCoA0dnlpSUs0JmEKfS2lNspqWG2Svzrp5u2ZXBqNKVK98dhKGs8w0Zl0w/7OwtYJEaXxHMLi+1XgrnPz/bJAi7KSoWyf1xhcad+AF0QCP3zJptgAl94/HCME4CouLbofZwo6MZcP/NWqR3+oQnfdZCMOcoqbipYZa42HjUT/IRHqeRAA5rMXD68tps5SCLt6E7hOXKodZrxD+lTMCTGxjJTmMbiHv/h6q9cI2udy+pXyK7HS9lKauq2PncwcQMX50KYAQPp+vn6PQbOVHiul32b9xrMBGxMhQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f83eb90-2467-4197-75e2-08d58a7feb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:20:35.4564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0007
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The 2 patches should go in v4.16.

They should go in old stable kernels too, especially this one should go in
v4.15:
  PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
Otherwise, a UP v4.15 VM can 100% hang when we pass through a VF
to the VM that runs on Hyper-V.

There is no code change since v3:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1628496.html

I just split the original 6 patches to 2 series, and this is series 1.

I fixed the order of Signed-off-by/Tested-by/Cc, etc., and added a Fixes:
tag, and fixed the other format issues in changelog. I hope I didn't omit
anything this time. :-)

Dexuan Cui (2):
  PCI: hv: Serialize the present and eject work items
  PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()

 drivers/pci/host/pci-hyperv.c | 75 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
