Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521472979-2-13207898064016023702
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521472978; b=mdlsGeD3rvMSIMxF/5xnWuS/hAnMOTjm0aJNzMB/87dbjsi
    UBdfW+sBGCsTlFojv3mJCGKZuTi+hMce/Tl4oZU7cYxMPqN5dPJy6VpfqcRBwjNi
    xJabLJw5UoNznt1t+HM/mcZYrCmEX/3jp7WVtMW4LOmPKDVRT7h0RqC0fGeNrMbv
    XGQeE3bQX6xSyZ5T0OE8YU5WH8X7BLmFp1sHKX8ltBQz5HCWOCYGRG/PT5Vj6dRG
    67f+2Jw+DTYG83/oB4LWTWFZXIgEe6vvUYNW8XW56dn7xImF/Aju5qMTOLDZhO2W
    sLW/Ud+ThvNtlIUJLVm6tMA5Gw+XPgL2Ay//0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521472978; bh=b7PAtkHzMvDLPQdxINnrdOmM4E/TBejquyUYJw
    ON+kg=; b=ljphWeo8mvZQ/bqq/e7zEgv2q/F7duZAP4RbDwYdfSsnVqsqt75J4o
    obKZzMjm+qgrJQZrlYBHS6RJ5U3b7W/m7i6mK1PJQeA3IytRl3fht0N9tpAOklrN
    j3JARrWmUAdwbnd1liFG6vliP8T329fPYIchg8og3M0L/LO2+U4vikEOgpF7GZ1O
    8yL3GNYkAHvjqes55iEyhdCvQlgnbfsYl3NMVfKSAho1KMh4T31ArjhXBX8Nr7vb
    JdCGDc6CfuZiP7yieGwBg2g564G6MfJ8VrkrBDRTx8t+tS88aFrX5o8YqmRbErpI
    hT5tYMZbVz6PvQccTyYDARTnnzPwyIFg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fONsnL/4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtvdenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeltddunecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fONsnL/4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtvdenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeltddunecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933088AbeCSPW4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:22:56 -0400
Received: from mail-co1nam03on0121.outbound.protection.outlook.com ([104.47.40.121]:10592
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932878AbeCSPWv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:22:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 12/67] KVM: x86: add support for
 emulating UMIP
Thread-Topic: [PATCH AUTOSEL for 4.14 12/67] KVM: x86: add support for
 emulating UMIP
Thread-Index: AQHTtpn6RxGhJxHWy02eLbnawN2M7MGVFwZS4kKoBwA=
Date: Mon, 19 Mar 2018 15:22:47 +0000
Message-ID: <20180319152244.ekaloppjdbtg4gjo@sasha-lappy>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
 <20180308045641.7814-12-alexander.levin@microsoft.com>
 <1211566882.5943983.1520491599636.JavaMail.zimbra@redhat.com>
In-Reply-To: <1211566882.5943983.1520491599636.JavaMail.zimbra@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:PWAMkCl5GnW7V7S0pAqFaGbvskKiRQ0ZxT440gnRNdoa85RrHdAe9NQzj+NFPtF/Q3gJjWRV2e/86aAxLgvGWuHJTZoT8YQsq/6LxQq6qQCAwtI8lG9OTpGmiTgUt4kKV/xxOkquABW+R8fvbYwbfav2LU9wsYjLT9m1VPus67xniLqwCmA1b9XwBz1k6aYp/ZN729J6mnA2IRco+pMkp8BhngnOzfwBhdiFqk+/YzEsouOFIM98VLzZL0bwPI34;20:Wz+8+Y1lnp41fKLn4QnrgMrvTzozA74cumcPyT+ulQnIe4cr2DUVHaW18p67ngZj4n6jp+Sgi2x+iXJHNRl7SdGczCZ4EaURelhHv8veMkA3PcRL+FV7rZ71ZWAdOsgx4O+BugN5TFjfQY3z2WHrAo9qartzdWxLlT07y6YPPrU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e25d9ed6-26fe-43a0-674a-08d58dad453b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048EDE93D30C056B2C71417FBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(130873036417446)(194151415913766);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(13464003)(189003)(199004)(10090500001)(25786009)(106356001)(5660300001)(102836004)(26005)(6506007)(8936002)(2906002)(575784001)(186003)(2950100002)(6916009)(86362001)(66066001)(5250100002)(3280700002)(4326008)(72206003)(68736007)(10290500003)(86612001)(478600001)(81156014)(81166006)(8676002)(2900100001)(1076002)(33716001)(105586002)(6436002)(54906003)(53936002)(6116002)(3846002)(33896004)(305945005)(6246003)(316002)(6512007)(9686003)(6486002)(229853002)(14454004)(3660700001)(97736004)(7736002)(76176011)(22452003)(99286004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7FM5wz6wHsHxc7EsGy+F6dOF689rAeH/B3TRdwOWJjXXOPBtsqb4huz8GOPtZ3jvhZSv7UJ7UVY+Ohz/NUfGbQ4lgB9+7EWq+PiAtU3EG3l8U614c7Fjt+LQgDROBjXRz3myV8rq6DVfTaJ1gLPzcfoA5TjsAbGCk9VvBLMoJbJS8GhZixvAr/PEKO1hsde7N81Ac/IJBVWfEbOAIxZ3syX2HOiY/3eVioGQ0OOWLCidv/iZ/ToBiS3EDZpl2o28XIGeyttK39fhE8o/ryfUZLoL98N+l/fKszPiKK3o3Y4n5u3SPZA37eqSxSCjAfpouP9nryqAQqpM5DLX/EYhRg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05587E6C657F0B4AB75B5650B05F95C8@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25d9ed6-26fe-43a0-674a-08d58dad453b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:22:47.1371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 01:46:39AM -0500, Paolo Bonzini wrote:
>
>
>----- Original Message -----
>> From: "Sasha Levin" <Alexander.Levin@microsoft.com>
>> To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
>> Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Sasha Levin" <Alexander.Levi=
n@microsoft.com>
>> Sent: Thursday, March 8, 2018 5:57:36 AM
>> Subject: [PATCH AUTOSEL for 4.14 12/67] KVM: x86: add support for emulat=
ing UMIP
>>
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> [ Upstream commit 66336cab3531d3325ebde36a04725dddd0c42cb5 ]
>>
>> The User-Mode Instruction Prevention feature present in recent Intel
>> processor prevents a group of instructions (sgdt, sidt, sldt, smsw, and
>> str) from being executed with CPL > 0. Otherwise, a general protection
>> fault is issued.
>>
>> UMIP instructions in general are also able to trigger vmexits, so we can
>> actually emulate UMIP on older processors.  This commit sets up the
>> infrastructure so that kvm-intel.ko and kvm-amd.ko can set the UMIP
>> feature bit for CPUID even if the feature is not actually available
>> in hardware.
>>
>> Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>This is not enough (there were a couple bugs, plus you have not
>added the changes needed to the handle SLDT, STR, etc. in the
>emulator).  But since this is a feature, why is it being backported
>to 4.14, especially without any testing??

Hi Paolo,

They were proposed for stable as part of the automatic patch selection
process. I'll drop this patch.

--=20

Thanks,
Sasha=
