Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1222381-1521412865-2-14624271174130697857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521412864; b=h0b332fdWXEhaUvUec8I7RpgjHf/t7BFqdHvc3GXRrTEOf4
    yw9+SeIwh5p//WyfCGLCG98C1VAvuyPoKEdoU33fvbsmLITFN8sUHy5HwNtjzo1e
    GG0/VRll8z06kk1VCAXQAkjUv5e//g+9zRCxjWYaEnapPWs2vyTayZDsD7rUD9mB
    YtUUicIc1nYpl3o3U640VunY7Y8FLbcBDlaOLlq7eraVd3WCOWfSUT0Crj21q6Lw
    KIWC56Svh3z1aHtoxikfFx5JIjCqdLKO2u+pYF6pSv0TsU+H8PTxnfh19J6W29Ig
    w/hDDOu7YBSWsleBirk0c+jQJDR9f3ZtXtRy0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521412864; bh=+
    fjVysc+xN0urahlKVGJRvk2fAmwXI1EEkHEnIOMCWk=; b=B2Vam/4K+12JcQPsV
    3pGi/8lnvLVKaQgOEzpEjv/TMyHihhdMETW6QMgWe2RxQ755UbQef20BOCQZvJzu
    d73osO5ThqWGt3t18C86yePr7L1IVd03CccaUEafz8OdzgwRSlVv+jPD0fFgDn4T
    QtWicEq2qPFkBFwnx1nxaMefeprd0BQ0+Jl8zQmNimTbDNshECYo2SH7VHFpCvoe
    CggYqrlWmyoELsrOcMon7HebG4317L62K850tS3YEpjQPjuMAAA+KoTdoJkAN9lW
    2QsHjOeVnHx3EV2AB31gJN3CwhJnSzqaVzpGCI3Z6JjP3W/kI19vk5ApfWeU2Vox
    UsHyA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=isIM9fkx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=isIM9fkx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Thread-Topic: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Thread-Index: AQHTvsja6KbTRPVg0UyrOUPXmgRmnKPWlbsA
Date: Sun, 18 Mar 2018 22:40:55 +0000
Message-ID: <DM5PR2101MB1030145AB251BF2F31FBA4BEDCD50@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-18T22:40:53.8933675Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1080;
 7:hULsFqYr1fadHw1kH2RFZl4BrkyZSRWYCle6Y7CI6wJkRnIiVwRpBgUmM4p6xNDiDWMv+9hwIWNkXwp40+5tEomC3URfu3uWV3EYzO5bw4JaiT0bZ+1gmkGZnqiPcOL38Fk5Wmpf0M4LCZAI3zveRSqY2meqqu0SgkNCpWlu04Dsbo2Dey0VDhySZqbMS428pClNfjorlnKaSh2bnjr50FTu/mfZolTn6pH+9STw0CSDHEf3LKtm6NqEYqrIbrVE;
 20:4d87qYavPyndoIczl1KBE9b3Db3fBoQizQXah5A4i8ON0uiLRMbYhuCyObswXWB37EitTK8jfEm6+PvHh9a8ti1hKZsFoITFVXf6VBWq7T2jCKva9sRYywUxkhJceQA6GVmSLqw/4To51bCApMn7yAq99cDKBs+UapqkuhZLQpo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 393bf07d-c432-4eb3-de48-08d58d214fdb
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10805D2181C42E636CFBE1ADDCD50@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(211936372134217);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1080; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1080;
x-forefront-prvs: 06157D541C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(39380400002)(376002)(396003)(346002)(366004)(199004)(189003)(13464003)(74316002)(5660300001)(3660700001)(2906002)(76176011)(54906003)(110136005)(53936002)(186003)(39060400002)(4326008)(6116002)(3846002)(3280700002)(99286004)(97736004)(2950100002)(316002)(106356001)(6436002)(26005)(7696005)(9686003)(6246003)(55016002)(81156014)(81166006)(8676002)(305945005)(10090500001)(10290500003)(478600001)(33656002)(1511001)(8990500004)(72206003)(22452003)(105586002)(86362001)(8936002)(86612001)(25786009)(102836004)(2501003)(5250100002)(14454004)(53546011)(6506007)(68736007)(229853002)(2900100001)(66066001)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1080;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: rzesWP/ruTL0lxLWfenVeP9lXowgsVY8VobsAkr4CKR0akXR78iyC3mIJYAAvRtrGwE0+GHXwO5qvJ+Z539uVR5nIis6xLjx1PUatmEuFEe4fcInO68CY/8snBhBrHx80myq2mg7p2WhJgzxerabf5UHrLY3+QmT9iPQqJdtTvVJtavrEqiCeli2gTeoZ/sfo8XghcZkGoHLME0vDbARrirhW8aP9rDfwHNetqqs5Wrxgk+2UpSNMEtSPKahAcZ88CGG2Tbc1QSX/UeLr75xU/omL9cymbJrvibYL+CtanusDhsMgyyF6G13RvoClYcrx3P7UGRtIbfmw8HjVPH+1w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393bf07d-c432-4eb3-de48-08d58d214fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2018 22:40:55.4068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf
> Of Jia-Ju Bai
> Sent: Sunday, March 18, 2018 7:53 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; bhelgaas@google.com
> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> Jia-Ju Bai <baijiaju1990@gmail.com>
> Subject: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with GFP_KERNEL in
> hv_pci_onchannelcallback
> 
> hv_pci_onchannelcallback() is not called in atomic context.
> 
> The call chain ending up at hv_pci_onchannelcallback() is:
> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
> hv_pci_probe() is only set as ".probe" in hv_driver
> structure "hv_pci_drv".
> 
> Despite never getting called from atomic context,

Not true.   hv_pci_probe() registers hv_pci_onchannelcallback() as
a callback function that is invoked from the VMbus interrupt handler.
So GFP_ATOMIC is appropriate.

Michael

> hv_pci_onchannelcallback() calls kmalloc with GFP_ATOMIC,
> which waits busily for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL
> to avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 0fe3ea1..c5c8a99 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1887,7 +1887,7 @@ static void hv_pci_onchannelcallback(void *context)
>  	struct pci_dev_incoming *dev_message;
>  	struct hv_pci_dev *hpdev;
> 
> -	buffer = kmalloc(bufferlen, GFP_ATOMIC);
> +	buffer = kmalloc(bufferlen, GFP_KERNEL);
>  	if (!buffer)
>  		return;
> 
> @@ -1899,7 +1899,7 @@ static void hv_pci_onchannelcallback(void *context)
>  			kfree(buffer);
>  			/* Handle large packet */
>  			bufferlen = bytes_recvd;
> -			buffer = kmalloc(bytes_recvd, GFP_ATOMIC);
> +			buffer = kmalloc(bytes_recvd, GFP_KERNEL);
>  			if (!buffer)
>  				return;
>  			continue;
> --
> 1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
