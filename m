Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1601348-1521427941-2-211488504912193151
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
    t=1521427941; b=UrBlUYUFBW9upuaoTyaxPHtpMkHEHb4ljJC1aZ3tcjL2RbL
    ab9N8V4RcdNV+3XT4rBMHhvysF9pXaFpDIx7j43tYJNmN9z0GWOsC15KM/BOYd+J
    S2OfSdJy7WcX4ZjF0pA4wkNX9S71NDe1wG/cbzbWHQ4IgSEAkSC4KnyNwnB+le+/
    /PDfQppiJqs6Mx+F4CSXGcSBKPb44hKaStBhrGfivQmQBJMh3/oO10q0oGIlXVOY
    G7RAjJPf5CP+cwp6+QBD4O+k9vCxPwJcUMFl/bJnuy9rtWlTDHBjTaFJpGh9fnQt
    PylwxCNS/Osj5uGZoDnPx4VIXEMo9u+uCTnTN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521427941; bh=4
    4KRn17W8ZHUh8hE7Ps75EublvMo5drHBc6bWUVd61g=; b=Sxn/Qh/v1zTGwa1gR
    qLbgHTZKt5iLxYj6XUftEB2JdPR6Fwle3iIunxopr4dwidOZecr/u0khQINVqkaH
    G3iLpxWM2d02qcwJyWiImWdqVLcascZHSjn/XnZIAm0PA1/hhBKcai7o2boRtgfg
    SFxFFpeGXLEQVgCjx+qNw9x0RN+3+GaFmrM/xGps7REMHbSzlk8QiK2NHJ1r4kYu
    go1YoVwd2N8LtfgplJm6cMSb32lU0JRazgPZJ+7qSQlS0lm99Fvu7fU5gOgbh4rT
    LM7IAsV+unZg/e4lOccn0adqk9gEbBPPL/9JV/A9iN5qlC+uvKd9sClc3b33kTKu
    wE7Ig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dbLWW+8R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dbLWW+8R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Thread-Topic: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Thread-Index: AQHTvsjVSUKB8TnsSU2Le10VAKx9KKPW3Jbg
Date: Mon, 19 Mar 2018 02:52:08 +0000
Message-ID: <SN6PR2101MB0893202C038AB406C6A6546BA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:8101:f39b:510f:222a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN6PR2101MB0895;
 7:PGPqB9AXMDlgzaMApBJ6eOhp7365kd2V3OtVVGAUik0rOL1XJoOQ2m7323/bjve3eEk0wf2D90FrTsWcnDr0sb9cix2onM5BxJaDRW23zsD1aIS7FHskAQbkzUUYl4Tb6j9ZAJwcohWGjUcNm2icaIkgRYqmi8cUaR0XdWjInipUty7+RMUVyjob7CaP2G/dqC274+C5mL3fRmFaH1NMi3B8NX/kTDE7jg+wKF98dT3pgysZl5MIcHIdXcYdkCsg;
 20:lybCc9N5Cp+kf7gMo/2DTnCG2bpMfUVoxWKE1vhb1Z92FvTy6ryeh4SIjEXP4vf+lLvTbWbxq1YDu68jC3dICtVMth1Ui46Zck/qvW6AAuzHxpv7RsUgme+r/k+H3BECHFJjQ3ge+qcWp6nUbx2qPPWrTEijfCHR9+osdqw7R1s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50c9440a-b3ca-48d0-19fe-08d58d44681b
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:SN6PR2101MB0895;
x-ms-traffictypediagnostic: SN6PR2101MB0895:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <SN6PR2101MB0895AB06A91DE068F964F540A0D40@SN6PR2101MB0895.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(211936372134217);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:SN6PR2101MB0895; BCL:0; PCL:0; RULEID:; SRVR:SN6PR2101MB0895;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(13464003)(199004)(189003)(25786009)(86612001)(97736004)(4326008)(6246003)(53936002)(14454004)(229853002)(86362001)(39060400002)(6116002)(6506007)(102836004)(53546011)(74316002)(8990500004)(46003)(305945005)(186003)(7736002)(33656002)(5250100002)(2501003)(10290500003)(68736007)(10090500001)(8676002)(2906002)(3280700002)(2950100002)(99286004)(81156014)(22452003)(316002)(54906003)(110136005)(8936002)(2900100001)(5660300001)(1511001)(478600001)(55016002)(7696005)(76176011)(9686003)(105586002)(6436002)(3660700001)(106356001)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR2101MB0895;
 H:SN6PR2101MB0893.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: 4D27BPynSin0S3ZRnOdzq1WfHH8wtt4drXIXTNDzf+Ce0Ld/Cy6ANtuO9oiXwBXXc9Sz+F/RK5qaW4JOjCH1fyltMfxbB2WKYuHC26hFdGUFcAt2wmwgBUDohezwyXGgCU3EgHHaG31lMkGlWzRW6aDknUs3wBcL4luZEEnaeu9Seg0DC7tfxqLbVzsSvpIi+NrBVCcyY4FmsM6Yh2Vd4wXOCjIcUnppbTCltuQf31r5NrO8tG2TLe+nvmRIXQnHSPLjLsAypRbPa2awxPLWLGPWgXcfRAK4fKxoUP+0yjO2hN2FGR8wx79IIYqRwEkHjH58BStwMwj/I/9VoTsv2g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c9440a-b3ca-48d0-19fe-08d58d44681b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 02:52:08.5451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0895
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
> From: Jia-Ju Bai <baijiaju1990@gmail.com>
> Sent: Sunday, March 18, 2018 7:53 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; bhelgaas@google.com
> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>
> Subject: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
> GFP_KERNEL in hv_pci_onchannelcallback
> 
> hv_pci_onchannelcallback() is not called in atomic context.
> 
> The call chain ending up at hv_pci_onchannelcallback() is:
> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
> hv_pci_probe() is only set as ".probe" in hv_driver
> structure "hv_pci_drv".

This function is setup as the function to handle interrupts on the channel. Hence the
need for GFP_ATOMIC.

K. Y
> 
> Despite never getting called from atomic context,
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
> @@ -1887,7 +1887,7 @@ static void hv_pci_onchannelcallback(void
> *context)
>  	struct pci_dev_incoming *dev_message;
>  	struct hv_pci_dev *hpdev;
> 
> -	buffer = kmalloc(bufferlen, GFP_ATOMIC);
> +	buffer = kmalloc(bufferlen, GFP_KERNEL);
>  	if (!buffer)
>  		return;
> 
> @@ -1899,7 +1899,7 @@ static void hv_pci_onchannelcallback(void
> *context)
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
