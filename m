Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1222381-1521412932-2-1640693349321284342
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521412931; b=aa2EnroII1LhpYretc96fRykXJ4uSpCMnzQX6lYZ6lIpHbb
    FXndV4/uRaoqEeY8t3X2GT2cnwmkNOU38mP6/Yrh7pJz5IUfMjcmGMNja8yuStUw
    UMdl5ZNL/r1p82eQOJjF4+TpaMYCSpCkntJpwC/39zsXtBgmgF08vqK/qVvzzUjg
    eAbGWb/HWoYCzOUvJGnRHTYIOqG98KxdvB7ysV0iUUnS7thgV39nQUmL3VWJ8g+w
    erfriKpn0AeyLeKKok2ZpD9yH3Ru4uZGuWNNEAAv/dIPSMh2j9plv9RA58bcL+sx
    HrEaBAuQjg8GkijFuXxf7FiS8NZkDPUkVE4U2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521412931; bh=c
    x4aVOeTz/W0hhcEBl6DlYg1Rbfuk6y5ghGVYcDbvsM=; b=XesqpvEA+X3hkrBPB
    m031lIV1BpP5L6Zh0qoa13tKF7sspXZM+CcFXiHl0o4Lg70cpHcYqRPUOqp6hd38
    ReFCgwv0DJiTR6f0Doq196TRgO816QVDQQVbqwOV3M/byXiL2jnyJBe5nNmq+63p
    +ypEakKNzqn6cCe4Sx3sRkakvu4zdOs1mSCcu33t+0kS6FDJJ0J/uWm8oFLmL3p4
    r7rgN/Boz2CoCG1mibiqGeE3B7gK+nkefgzxBLQG4jYEzAHHuFEmiY4j9AmRI8O/
    hp7cJbaCuf0a8S1Tt59Le5qyXFpJzGjh6/Abm5TA+onrexj2ugEOfN4TKV+yd+qH
    W6wOQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sn+M7/7Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sn+M7/7Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in new_pcichild_device
Thread-Topic: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in new_pcichild_device
Thread-Index: AQHTvsjq1bq08Tgi00ewLH9desMDpaPWlsvw
Date: Sun, 18 Mar 2018 22:42:00 +0000
Message-ID: <DM5PR2101MB10305A8292BCC1F75AC578C3DCD50@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-18T22:41:59.3937081Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1080;
 7:P/eIK42TKW7OCgvPKnVCbXTCp5Ty6dYitOZn1DIro+OMRBMUlNs7qicIjexlb+pJt/XBmc5zYmZu+6UcNoxhi3904pCci3Mthh0eIjyh1Hle6VlzUacUFpJ3RSGHVV4WLADTXWrYfBzujtBUYSNc0073qJ/o135u5KZybo1scMx8kVVpmhgPxaQOadJKMlVDiHt4ZdJzNzr//oyPrbmOcPgkL3RRNf41SnYrqfBERpGdEgvkLf1VSo8n0L9OiZyN;
 20:ByD+d1Cq+RGFwThdJ9SQ6/uHbWuW7qONsgvYfbBMeNdWjFzwWHLU3bUWtstLahcQk5nYZwP6mEYAb/cAhdddlXgox93aLCtG7KF0fFDETBNe4t+KCZqg9PniLq6Pbjm6ekAtL5sXuGniA3t9QH3CvOwMblAvlhYpm/+1yoaUdng=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a11e65f-9afe-48f2-6286-08d58d2176d2
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080CF08CD68F94799F03EA1DCD50@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(211936372134217);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1080; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1080;
x-forefront-prvs: 06157D541C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(39380400002)(376002)(396003)(346002)(366004)(199004)(189003)(13464003)(74316002)(5660300001)(3660700001)(2906002)(76176011)(54906003)(110136005)(53936002)(186003)(39060400002)(4326008)(6116002)(3846002)(3280700002)(99286004)(97736004)(2950100002)(316002)(106356001)(6436002)(26005)(7696005)(9686003)(6246003)(55016002)(81156014)(81166006)(8676002)(305945005)(10090500001)(10290500003)(478600001)(33656002)(1511001)(8990500004)(72206003)(22452003)(105586002)(86362001)(8936002)(86612001)(25786009)(102836004)(2501003)(5250100002)(14454004)(53546011)(6506007)(59450400001)(68736007)(229853002)(2900100001)(66066001)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1080;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: ik7wh/wSsqI/ULhIcaIYlsXl5PKbfO+lkGVFJL+Z6Yt3I72H/6KDKhM8XIcb6QxfVF97fyUJigcc3QK+aKzWeP78Ejg/3rQIUfX/PB1PhEFDTEqdX33xBxerhxbCXa/ykUDZq0W81tap+/7BqeTSVr1/3wfpAV8kVKIYtDwA7lMNhg6Tuo+ZXwP2w79iO5hQddKG0Uulg7HM65CG6vlf++We7Enqvu7q+XTpHj2EVNc8Sd2nIyiK7vZeRK8q29NMliQ5C9tGGgIqFfh6pMCCmAe49pQr3lifs6RUYuKZ+qSs3oLKR4l4zF77SBQUDRghv/IxReX3KKrFxQ/7HL2pgQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a11e65f-9afe-48f2-6286-08d58d2176d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2018 22:42:00.7778 (UTC)
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
> Subject: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with GFP_KERNEL in
> new_pcichild_device
> 
> new_pcichild_device() is not called in atomic context.
> 
> The call chain ending up at new_pcichild_device() is:
> [1] new_pcichild_device() <- pci_devices_present_work()
> pci_devices_present_work() is only set in INIT_WORK().
> 
> Despite never getting called from atomic context,
> new_pcichild_device() calls kzalloc with GFP_ATOMIC,
> which waits busily for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL
> to avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> ---
>  drivers/pci/host/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 0fe3ea1..289e31d 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1500,7 +1500,7 @@ static struct hv_pci_dev *new_pcichild_device(struct
> hv_pcibus_device *hbus,
>  	unsigned long flags;
>  	int ret;
> 
> -	hpdev = kzalloc(sizeof(*hpdev), GFP_ATOMIC);
> +	hpdev = kzalloc(sizeof(*hpdev), GFP_KERNEL);
>  	if (!hpdev)
>  		return NULL;
> 
> --
> 1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
