Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3282151-1519145341-2-4320780562208844309
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519145340; b=h4q2azIpFT5Xh6GgcxRuzDYYKSjHhsTNaKALHDQ7Ebw8Swl
    0hPCipGEKikyI/yH4wnn+L8x+axhO8nY2PS71eOEXNfHlTDvrwITDV7kV1o24UHz
    a+1p8yk4bt48mWFTIvQVFNcui8ocypspMkbnifiscjiJuS8GZ2pejO/v8KBUXi1u
    C6thPmaxg9aSebbFSNJiIBkUQnvj7wR7ge3jz+PT3d+4z5pTw+0c5HwEF0IMvfyU
    TFgqWcI6VKpaaRlRoosiik+4Eo9kiAgCrgNO9rtmfD5pFCAloceaYmMk97gWojUj
    Inq6ipV9WWPQSBGTBzu9gWNCF5mbSGz4bsoN4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519145340; bh=R
    Tmk86QJQgXNR0/h2B3dRyp4qgM+yQ/c8rzUfq+Wsrk=; b=UwFkSl0kkZY82qe8t
    TrX24gyTSfGFbtlMgw+lq6RpgqHZzT3va1KggTA0HmX0ir1yJ4ry4KpmZziZlqY1
    BNVZcVNMmWMKIiOwPGWtmXoQxodawjZfbZ73b+6LBZDjzt4jZ/xgGk5pPCS6A3Bs
    bXOt1LabOVPX0IWVE6pQC9EzSzhtVL8EG3P6+763VAy3dQsaTAVmlQxBpktwCRmI
    Y4ikFmIVn/Ap9r18PhUwt+7ynyV3qvn9VZTt4TJKsZjc2yIPPPmr6piNziLWVvq0
    YgRvmL6+LqYPzHnmwUvPIUxQk1xy8bGMFyjBj8Vt7yZICt8iCha/2P6kk1Yuf+Ko
    G0Pqw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eu/qCYgM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eu/qCYgM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: KarimAllah Ahmed <karahmed@amazon.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] X86/UAPI: Use __u64 instead of u64 in hyperv.h
Thread-Topic: [PATCH] X86/UAPI: Use __u64 instead of u64 in hyperv.h
Thread-Index: AQHTqh4JMqo3qqolIEiafDtLlZ6qdaOtgPJQ
Date: Tue, 20 Feb 2018 16:48:50 +0000
Message-ID: <DM5PR2101MB0888CA2B75450EC38B8BD80EA0CF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
References: <1519112391-23773-1-git-send-email-karahmed@amazon.de>
In-Reply-To: <1519112391-23773-1-git-send-email-karahmed@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:dd83:fea:de1:6d4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0872;
 7:Uj39ks6XhrAMBduf4xME37OQy44Ad54YbyvsTf/AP3rmuwAKrnYKLtB7jLhG5wHn1xq2pTnAvr8i/OzCZlKoAbLyfqndPBCYj3QEUumaYJmwW2+4ge9cu/aTE3WXUyPsnFFfOCtnOHl1X6Fc9mu64ymPwOhezt7umJsBiTdoYVJctRfOUoFWw7G3GwlVTqhEJYPl34TKUzerTRw7aKgvU5/CJFQ67lSUDCVqmhogHezCpzHJo71JyzDfxgRZcNq/
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73c92107-28de-4ebb-03b7-08d57881d193
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);
 SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
x-microsoft-antispam-prvs: <DM5PR2101MB0872CCAFF4C3EDA7201A08F4A0CF0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001056)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231140)(944501161)(52105037)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0872; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0872;
x-forefront-prvs: 05891FB07F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(13464003)(2900100001)(3660700001)(5660300001)(106356001)(6436002)(6346003)(186003)(102836004)(6506007)(53546011)(5250100002)(33656002)(2501003)(55016002)(229853002)(9686003)(97736004)(105586002)(81156014)(10090500001)(8676002)(81166006)(8990500004)(68736007)(53936002)(6246003)(478600001)(3280700002)(14454004)(2950100002)(8936002)(10290500003)(74316002)(7736002)(305945005)(2906002)(76176011)(7696005)(86612001)(316002)(575784001)(25786009)(99286004)(4326008)(22452003)(2201001)(86362001)(6116002)(54906003)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0872;
 H:DM5PR2101MB0888.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-message-info: T5P25/5FpRkRqB/EKwmq5jFlE8fM8W9xe+25OZZyR33o2EOilBBtVEHvaLBjl0P6rmNVw91E3iQky1+0JEo4Owz8DYVFouvgcgzqWFBbvmWH7alJgOf7nQzJ7S2gX41A67C0MvrdG1xZ2GYpuHxH/mv7wM3J/CoydtniuyHYvcg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c92107-28de-4ebb-03b7-08d57881d193
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2018 16:48:50.3949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: KarimAllah Ahmed <karahmed@amazon.de>
> Sent: Monday, February 19, 2018 11:40 PM
> To: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> x86@kernel.org
> Cc: KarimAllah Ahmed <karahmed@amazon.de>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; H . Peter Anvin
> <hpa@zytor.com>
> Subject: [PATCH] X86/UAPI: Use __u64 instead of u64 in hyperv.h
> 
> ... since u64 has a hidden header dependency that was not there before
> using it (i.e. it breaks our VMM build). Also, __u64 is the right way to
> expose the data type through UAPI.
> 
> Fixes: 93286261 ("x86/hyperv: Reenlightenment notifications support")
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: devel@linuxdriverproject.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  arch/x86/include/uapi/asm/hyperv.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/hyperv.h
> b/arch/x86/include/uapi/asm/hyperv.h
> index 197c2e6..0994143 100644
> --- a/arch/x86/include/uapi/asm/hyperv.h
> +++ b/arch/x86/include/uapi/asm/hyperv.h
> @@ -241,24 +241,24 @@
>  #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
> 
>  struct hv_reenlightenment_control {
> -	u64 vector:8;
> -	u64 reserved1:8;
> -	u64 enabled:1;
> -	u64 reserved2:15;
> -	u64 target_vp:32;
> +	__u64 vector:8;
> +	__u64 reserved1:8;
> +	__u64 enabled:1;
> +	__u64 reserved2:15;
> +	__u64 target_vp:32;
>  };
> 
>  #define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
>  #define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
> 
>  struct hv_tsc_emulation_control {
> -	u64 enabled:1;
> -	u64 reserved:63;
> +	__u64 enabled:1;
> +	__u64 reserved:63;
>  };
> 
>  struct hv_tsc_emulation_status {
> -	u64 inprogress:1;
> -	u64 reserved:63;
> +	__u64 inprogress:1;
> +	__u64 reserved:63;
>  };
> 
>  #define HV_X64_MSR_HYPERCALL_ENABLE		0x00000001
> --
> 2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
