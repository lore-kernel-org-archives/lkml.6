Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1222381-1521412638-2-4137059274418054928
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521412637; b=Zfqa15KmSLDdTjD0MtsJ/flfaC543s8hLsgvev9sSCdHStS
    2T+RGIAjCxETVW6pjQa/7ezXptOyu8Ky8Vl8nCo4eDL2Fc0pixvGE4qzfG7bcMkN
    DrGBSpFZfnLHuqqj1f4zxVJa0+N+7uyUumXAGTWOsRamLb2BoT4AJDd/sxhY37HX
    fp/tazzmvpDEQljrQbSrBK6OZal4JYHzyJdBYT+p+t0SVcN3tAPm8ZVu76kd6FkC
    39ts8wedfSSaZxXqsFf5HZg+7K61n0pMVel6PhGhtszIiZiEpgwe+FO4PnJE3C6+
    G2ssP54M/lliFEJG2zXOeoK2zlu+mQf5OC/qG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521412637; bh=c
    Tdc3K8H3+ciNKSUJLJvfJwdcUedcBWhCFAggpQEc/o=; b=Rqgmt8AWU3elvdpPa
    VMzHmK+TdsocvqnuHEs5QAeCkSrfVIdrNGvdLxfr2DSB5W3SswH9WvLGBnYSffiQ
    e7FexB29i/kIzkrv2FWnZNd3ULS2vPRfN/a5FXE9WeBqSCHzGEoGhgQs65lJ1IrB
    9GR0xnJf020OsGeVyPqoyLh6ox1Jz6rWhJ2oCv+VZlKTCJNukng/r0U1V863K9Ed
    p57olWojp01GVzEsAGdGBiUGl1S1adzTfc/mbYAEaKU5I586FOHlrSQVlke2gBxL
    CqS95bpjzIt3LIW51HJDnzec+NgBz6a772B3rdn4o7oUUsc6+CO8lV1lKEedT38y
    VHFeA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/l/qQeP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/l/qQeP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH] vmbus: use put_device() if device_register fail
Thread-Topic: [PATCH] vmbus: use put_device() if device_register fail
Thread-Index: AQHTvoUgz7NIDmL0UEiY7KwnBfP37qPWlbIQ
Date: Sun, 18 Mar 2018 22:37:06 +0000
Message-ID: <DM5PR2101MB1030D2ED42CC7E46128E89FDDCD50@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <bd6526dedf570a226ee024907be9a8f2bb04803f.1521355469.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <bd6526dedf570a226ee024907be9a8f2bb04803f.1521355469.git.arvind.yadav.cs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-18T22:37:05.4082440Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1080;
 7:pNjm43GMrEHoT4BEc98cznbbgm3C6QP4PjXwcx9T6A4MYDdGW9NrGQ5iXwCH5RNjMeSp4NNC2uE+CCufUY10qwLxok3Xu4oZMfCmoes7vfwYhNG2vipynEBirjp+605r7MaNbec+OGpzuuclAS/mPizjrT9EwbozcJpq/O0Geg9MODVHZPWa+r8ZSUd/zsN5g8gaH0RkJ+PvN+tPTfhNoiia2tKmyRXgCkmkwlquLi9/BvDzwug5Z/Syqr/SJAnX;
 20:rtfmG48vgcj7jY6BVtYAxZaIMqLQkiuD0RfKtCyrC1UcomMyDfJGuMEEtbh6PqNw2ZXNSnqlbX697AZamB7BgY71+E2suJcryx/FJn/T00fgvdRc7x7R9q3vEMgXBUEICYJw848k4zT5NlhcDrvsW23b6BCpjZqfSawlC8g1NNI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 658d8745-5e13-4e6a-ea36-08d58d20c799
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080483073A92CF39665E39CDCD50@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1080; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1080;
x-forefront-prvs: 06157D541C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(13464003)(86612001)(8936002)(1511001)(72206003)(8990500004)(33656002)(86362001)(105586002)(22452003)(2900100001)(229853002)(66066001)(7736002)(25786009)(5250100002)(102836004)(6506007)(53546011)(68736007)(14454004)(6116002)(3846002)(4326008)(3280700002)(39060400002)(99286004)(97736004)(5660300001)(3660700001)(2906002)(76176011)(74316002)(186003)(54906003)(110136005)(53936002)(55016002)(9686003)(6246003)(10090500001)(10290500003)(478600001)(8676002)(81156014)(81166006)(305945005)(2950100002)(26005)(7696005)(316002)(106356001)(6436002)(6636002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1080;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: 6t967ITJ+9Rg0pDiHEU/s0WmGlri8xll01+9v8zRTjnQw8FsuMIQYqyxvqYEvvXrOb7FHRS/QLa3cG0khBbbUT6wptfoKaf2RZNJkNWLd1TYkMYG9Uha86pzTNyMi+7ij09rP6TxbB4fBKL3Xft2pcM0Brqds/Q/bWCiNhXWMVu69+nunBTNKkX81f3cpQsU37uQJnJHr2HYD7gYjyfZ8ItmKcILbyyKR4W2g44DG3CNG315RLUkzv8cZ5pPx+FxJ3rdoAUsuEqW8gUqdMSlFjCwRopVXS/r2SNf1hLacHmJ+Oy5sWDmLIAlzZelhSnwfnJqFfAp3NvZvX9qwT6Q1g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658d8745-5e13-4e6a-ea36-08d58d20c799
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2018 22:37:06.8524 (UTC)
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf
> Of Arvind Yadav
> Sent: Saturday, March 17, 2018 11:48 PM
> To: Stephen Hemminger <sthemmin@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org
> Subject: [PATCH] vmbus: use put_device() if device_register fail
> 
> if device_register() returned an error. Always use put_device()
> to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> ---
>  drivers/hv/vmbus_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bc65c4d..25da2f3 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1358,6 +1358,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  	ret = device_register(&child_device_obj->device);
>  	if (ret) {
>  		pr_err("Unable to register child device\n");
> +		put_device(&child_device_obj->device);
>  		return ret;
>  	}
> 
> --
> 2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
