Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1601348-1521428502-2-6797093889266887161
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
    t=1521428502; b=RRvvq5zGpK3NbVWgDQ/ss//usBQSVakuzgjSmFvCpd4EISi
    ApDE/oAG94BgKzN7E4IyDKL0ySOamhD0/BO+GgmTTZeoK1kratJgtWdcNIhVGN2Q
    yj/7oFx+q6MhDU1pTxGFx3ci+EcocAArI0R3YUZes330BjBgvxUh+pDrRLeWY5mf
    Vdrhx1i8ORVMX298KckwGqWMRyBurViaxe54IwUQFcd1yNznruCEUFLf01nIDe5a
    mnEuCTXGjg3ixR+dxA/usg6mzueQnRnbMMhibYVojrf4sHrnpLfZ/9xuJNNr663K
    YX3fRFC3aOrXqH6WdBsGTbDho1ZfFK53YsVFONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521428502; bh=J
    48NCIzuInTqetbkDosGm19RA3SjapLcbfwJwaqa5+M=; b=Gq1amFpZ3Un0UREEB
    Yn+jH1uN2oE/Op2VEOK27VS/gaOTiIwYB6oQlVptab9a0CpfOz+jOAZJZvoyvRdH
    R+AnsLyf/yG4q6WtEYwEOBFqsv3eHoGWtfEUaalUp/YAPQYcmkftbRoF0da1dGft
    yXffsXy95g9TsypjYVkjWfMlYfB75I7O74dYibusR7YtmZG4kOa1HwhNzeN0bQbY
    jn58cGUogK6VdSUekb24FLaEsTz8k6eIK8d6sUfmGKKG/mxrv9VP3zFCFxGdVlkX
    F9xkS3PJWJXOnknucptfsmPZTmT3lUfWIPGxSpj9RDNxXCqfKIcO/BOVe4qx4OKq
    9nB7g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H0h75kWV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H0h75kWV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH] vmbus: use put_device() if device_register fail
Thread-Topic: [PATCH] vmbus: use put_device() if device_register fail
Thread-Index: AQHTvoUaSaPHx26coEaurL53qMiDJaPW37dw
Date: Mon, 19 Mar 2018 03:01:31 +0000
Message-ID: <SN6PR2101MB0893ED30DA3AAFD4B3E2064EA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
References: <bd6526dedf570a226ee024907be9a8f2bb04803f.1521355469.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <bd6526dedf570a226ee024907be9a8f2bb04803f.1521355469.git.arvind.yadav.cs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:8101:f39b:510f:222a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN6PR2101MB1021;
 7:52ueQFhaugaHwvKgit3bcFcaKzobFsLRhxF7kY4JuYJ5l8pJlOYaY/V9KQzXFzX5d7k1SJ0Dir9sBEhCbsfsI+0miEVzELHGtCXAhLZ6dcGTwxNme6cG/KO8t5b4OR0aygMZhhHAwTZdsDpKbZSdnrIdXSdn6Q9/BAous9oL1AA0lz+NE66Eiwc7NS+UfKqMJlQ6yiRsQ8OSySu0mlex9HlS1ys5oiiK90bWMrSarXX9JFt4Bjmb/RXBiIGgyPp5;
 20:b5kGOn9KjWqt3RKv3q3NjpGA9cQx2rfJuGPiCxE7ab24T2WKxYtnZ81tbaAYHofWRXQEI/zEm7qhRVI4MftoJxtmrwaDlK9igTRR3wh3r1Ol0XONvLqExcwkGxgeLsIvYaovKhOkrHG5YnY9WQax/d7wPLWqxk+y0UZGQLqB/sQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdff0304-6d14-4241-1356-08d58d45b77c
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:SN6PR2101MB1021;
x-ms-traffictypediagnostic: SN6PR2101MB1021:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <SN6PR2101MB10216D27B9AF744133BC0C97A0D40@SN6PR2101MB1021.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(85827821059158)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:SN6PR2101MB1021; BCL:0; PCL:0; RULEID:; SRVR:SN6PR2101MB1021;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(376002)(346002)(366004)(39380400002)(39860400002)(396003)(13464003)(189003)(199004)(59450400001)(2906002)(81156014)(6436002)(55016002)(102836004)(81166006)(8936002)(575784001)(86362001)(14454004)(316002)(5250100002)(8676002)(33656002)(6116002)(6246003)(966005)(186003)(9686003)(10290500003)(2900100001)(6506007)(53936002)(6306002)(53546011)(478600001)(2950100002)(6636002)(68736007)(4326008)(3660700001)(25786009)(86612001)(39060400002)(1511001)(8990500004)(229853002)(3280700002)(7736002)(7696005)(305945005)(5660300001)(97736004)(74316002)(76176011)(99286004)(106356001)(22452003)(105586002)(10090500001)(110136005)(46003)(54906003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR2101MB1021;
 H:SN6PR2101MB0893.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: dyXdESfG12avKgeeGbrdAsutYwAeV5REkbxJw7b31LZHTsG4+FeNxWUlKu/BNXtKu5ol31NNa/uLYpLtduE7woWlcAAUiDTDpnilOwOapDmR8oQjCNYS48dd5PFvHMebBb7n/IJIgXIT1tEVwc4l/vmpgEQdl0449i281a67k8aeeoYelk5kkjgxQJQS3Lxq2JknYBhk58+swnxHuMyhdUhAJgfYiorEEh5LmXQimd6QgK3PzWydKtyz88BBDXO501PUJdMmNbQt5lxmERy+yrvf6EMz2C2vH5bwAWAxL4TmjxlD6DFWJej9Vb/5AstrKZLPfzK6arDh3eIXwJCjbA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdff0304-6d14-4241-1356-08d58d45b77c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 03:01:31.1974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1021
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
> From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf
> Of Arvind Yadav
> Sent: Saturday, March 17, 2018 11:48 PM
> To: Stephen Hemminger <sthemmin@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>
> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] vmbus: use put_device() if device_register fail
> 
> if device_register() returned an error. Always use put_device()
> to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/hv/vmbus_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bc65c4d..25da2f3 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1358,6 +1358,7 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>  	ret = device_register(&child_device_obj->device);
>  	if (ret) {
>  		pr_err("Unable to register child device\n");
> +		put_device(&child_device_obj->device);

If the registration failed; we would not have acquired the reference on the device and so
we should not be dropping the reference in the failure path.

K. Y
>  		return ret;
>  	}
> 
> --
> 2.7.4
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdriverd
> ev.linuxdriverproject.org%2Fmailman%2Flistinfo%2Fdriverdev-
> devel&data=04%7C01%7Ckys%40microsoft.com%7Caf95bfab917f4e1fa4b008
> d58c9c3b72%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63656952
> 5011478334%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> oiV2luMzIiLCJBTiI6Ik1haWwifQ%3D%3D%7C-
> 1&sdata=%2FEb%2FMTY2SMh8sY1tar2c8Om2uKPUZAXIUQkrG0q07CA%3D&r
> eserved=0
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
