Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3191090-1524776146-5-3682898457972236699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524776146; b=bG7hchGygvF1xwe2lpfCDOKJp8HUwVVtD5chFxlKkv/nhYR0rD
    pwvD8SGBu4QrrRT2SlOO2NVN4lvgCvh+KffX8YBzotK4SgUV2zMEONJYTvrF4nPG
    YmUA0HczZZ5ee7D+auk7iLxtHLGKJBldm5s2f6KDVTl8eZC7ZMc4G3bsJuesCuQN
    dllLbUFA/tpsini3GO3Yq5IxWRppLw5VGeV6+f7h2MR4Mx68pJpqQseFA1l/qHeC
    yTY90+U6q1pPzjCCvrFZl+wqYeWM47ll+FCtTQ5VwZ5ljb5Oc9OEc3jX6ac8XG9W
    EOXb/G3fsj908O7DHrf99wg+XvexMqMCD8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524776146; bh=tgPu6
    Hzh38O+Py8/XudzFA3A2Fy+l2nf8IjisfSNWds=; b=sNQ72v1QGwoqb6Tlqg1Fq
    9LXsgjteQuCI6Gakp5pTqnhY4cuk7WlDSlyhB4QPtaMRJIV5k/NAO5Y8L3SCrC5C
    ZHTcDS5O2ACn/POhkaFbIHt7fmKxq+di1cQ3nzXi0FFMt6nddbSDdHsz1URHdozP
    jCzaVccfkw3du3zPWw6paCApHYY9mn7cYnNmqB5XnbGVWTtj8GltV2PMYCznB7Rr
    b7axuBiZmLLbIV7kSep3aJVzvHpI1A8qh4JFEnLi2nDl+SRq3SJ1pvW37VK/Tjct
    /iEYHF+wBNEdVKNnmxeUEM02qCsGUQyRSlfcRFYwa+oszaEstaXektYX8wvB2n+l
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JdtVJKil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JdtVJKil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHsWrDVIy15rzZ+/qHtSQ45Cx/vbGAB6ELecTrugDCc35IM5aP3HNy+lsvSJcRqF/GUJcHFZ/5muDvlZT+mY84RRqlmNxZXbDRyiRl5sniV23ADGejeD
    2V5IZGAyFxvTBskfW5UwVSldleqZEOslaz7bducXvZFpvM8mTotyrfnd6kfxex/1QpDlf5eQ9MPuqFtQ0UKSVAeXjhsoD6P+cSleHHLC1LXGdHRA/HZeZjL2
    erHdkiME3BIf+yVwmuQhrg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=R4fxTKrshSIA:10 a=6RrQ652yKWUA:10
    a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=-3s3PlHBCDVvyqGv8nkA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, KY Srinivasan
 <kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: Fix the offer_in_progress in
 vmbus_process_offer()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix the offer_in_progress in
 vmbus_process_offer()
Thread-Index: AdPdoKfzRngR012LQ7GfpBkEd0k4zg==
Date: Thu, 26 Apr 2018 20:55:19 +0000
Message-ID: <KL1P15301MB00067BB599826701A41A23F8BF8E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-26T20:55:17.4478484Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:b::47a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0071;
 7:DuBCdWt4jbl363XoLhwpmwJN/RYx5JJR1y0rsCJi6TznB/dOjAbsotCNtp91XLaXYx/c8LhkGJaIcCNjmAjaFWUzOMVLGkRv+KfQ3ae1wjisKRpYIdupGy6yisQCrCtjXY0rSQ+/HArhI/Pqts52tnjuK8Kn+KZ4+xImPQWR6gc9Z8CAAagpv8eUqWK165d71+euGqaczOcE4BIlDpRxOe03AmlcD9ocuhZI1qzQLgH832gpwMJGvulrs6ChZBql;
 20:1FCptmzUL2P1btXFnbIaD9ZeKSEE6YiQXgL2E5hHa2AD8vdAbn9dllQ+SJt91Ry0cjLo7FNzOkM6KldXxNXP4QN/9iC5LRVrRk8Ll673Tw40GDsmnSxrdZmsMrKDAX8agIC3RC0j8GSy3Fl92JJJkuA+f9v/TxFiRrIwg7qJ/EQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0071;
x-ms-traffictypediagnostic: KL1P15301MB0071:
x-microsoft-antispam-prvs: <KL1P15301MB00713F4A8356B493B6855088BF8E0@KL1P15301MB0071.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0071; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0071;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(81156014)(53936002)(1511001)(33656002)(3660700001)(8936002)(77096007)(8676002)(6636002)(81166006)(2900100001)(74316002)(305945005)(86612001)(102836004)(86362001)(99286004)(6506007)(10290500003)(7696005)(6116002)(2501003)(478600001)(7736002)(105586002)(486006)(476003)(5660300001)(106356001)(68736007)(2906002)(46003)(110136005)(25786009)(97736004)(54906003)(14454004)(10090500001)(22452003)(55016002)(3280700002)(1857600001)(4326008)(8990500004)(316002)(186003)(6436002)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0071;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: vr6BrJydlDsDu4O+OmR8qpJNfMTp1yRiaVNT3J3a92LoMp8mfXrod5tOrvxcH3kafeRY626W29EeGsIjFHpuAxbSwiYgYQOhRh+j4bxodibytzdaX6fLwMklQg0WBBQod3r5dbmZXdD4KPLJpDJvhai7QbUjzJw+RCZC7+p9RXMdBeIAnRQtHAiRC+x+M/po
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bde8332e-78c6-406d-302c-08d5abb80587
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde8332e-78c6-406d-302c-08d5abb80587
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 20:55:19.2636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0071
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
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


I didn't really hit a real bug, but just happened to spot the bug:
we have decreased the counter at the beginning of vmbus_process_offer(),
so we mustn't decrease it again.

Fixes: 6f3d791f3006 ("Drivers: hv: vmbus: Fix rescind handling issues")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Stable <stable@vger.kernel.org> # 4.14 and above
---
 drivers/hv/channel_mgmt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index ecc2bd2..f3b551a 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -527,10 +527,8 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		struct hv_device *dev
 			= newchannel->primary_channel->device_obj;
 
-		if (vmbus_add_channel_kobj(dev, newchannel)) {
-			atomic_dec(&vmbus_connection.offer_in_progress);
+		if (vmbus_add_channel_kobj(dev, newchannel))
 			goto err_free_chan;
-		}
 
 		if (channel->sc_creation_callback != NULL)
 			channel->sc_creation_callback(newchannel);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
