Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521477760-2-11481639634699669556
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
    t=1521477759; b=MUXF18u+UyNjgRlshE8G9wIsuCj4TY9hUSQibEUuLef0Ye5
    DZGGFQkL0/SM4wQBAuoGNP2F8PpBqKhh5qEPWu5ozYWzexgUXavxUCRPUAQ8n1jP
    cvokZCQCW032ZYbLQeFAcyy0+1+HohZIdvGH2pvzw5gDYrKt29JM11uI07cQo5ea
    jN69idhHbSw84kswRJL3VDvfj/5Y6RXRWZPJLkHaZ30AwTsSU6Lu91xMSOQ2vCHq
    QNI7WGBXvrCQfoobIshgqU02HrtehiaKb8fcnVFRsn7u1y3fDBpj2jgM9OrPSKG/
    XikYAvLOTR3Q/X8M/BM/ypD/brZfDaJ/3G6FOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521477759; bh=V8bPmdZFZcctkmGtL+8BHEbSwYLllLfB6SLRpU
    5QE1k=; b=XkW+qW49idwHRxzTbbOUvJEIozv+n5BzhyQpO7lloXF2SQLgTByzfV
    tEEnfMR/I8wyBpWvs9Azl1cdv30EHu3K6i6bG0oLzEkgZd0uOTGEk7oGm5B1raiN
    /UxLwd7TNYmsEjQyjl8vC664kItzlYDed2bTuHjw0p0ERi2qMtM3Ymb1mkygWeJp
    mzR2lbz0Sy7YlVOlcX37VkLmatwdzoVqsZb3Qc1lrtcf26gKmyCUYSddsEtjfxqs
    VM0OwovZjSV19F4lMAhychm9aY2v2/oYELF2KYHNnMrVZ6QJ5g9RefowdvcPiz7a
    08oKM2RdSIuF+zhCG1WxSpq7kk2w2ZHA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kVEZS//h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtvdenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehkeegnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kVEZS//h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtvdenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehkeegnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965268AbeCSQmW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:42:22 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:46377
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965614AbeCSQmI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:42:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Tero Kristo <t-kristo@ti.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 4.14 056/109] clk: ti: clkctrl: add support for retrying
 failed init
Thread-Topic: [PATCH 4.14 056/109] clk: ti: clkctrl: add support for retrying
 failed init
Thread-Index: AQHTvTyLZq5gmSSEcE6mRLJMHKBK/qPW7pgAgAA2BwCAAKNVgA==
Date: Mon, 19 Mar 2018 16:42:06 +0000
Message-ID: <20180319164205.jd233ouwt3avcmvs@sasha-lappy>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.001660820@linuxfoundation.org>
 <20180319034408.wi6wfosbcckw22j6@xps>
 <67169312-ba94-7a68-56cf-8412d8b42169@ti.com>
In-Reply-To: <67169312-ba94-7a68-56cf-8412d8b42169@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:qFzAwwe3xLwThhahOcwMedOVQlPnnICS/GEvLUfbE0qA/SZCkFJtW4sNnQDiFx8p6x95t/MVWXunsvy7ZYq0BgXIhu6/jdIykUvcSCq8oorq+fQwTOTIO66gjuldGw3rxCJD9qZ2PbKmO4Y2z3F4MgPbqHBB3rYP6rj6eNJ/O318P+MC4zAsBj3KWN2sOi7sdiObNkBFM4t7lURJlNzAGFnlb1aGZr7w4FuDsu4GGFvdbJNcK2tUdOjU9J7tR/eK;20:Q1EEtTerq45mJk4hPG+/YSI2vBAVQm+mLSUFxWwIj4Lm07prZLXAcpMSSDQiq8smRcLm/q7mUZRYsWOCU1jHybyMO2y2FTIoO7FfLoGycm7xJcW1zdZ+ilcgLbi56EMdCqwmywMm26dCXxKZZHdBvle6Gkrnn554nDZwK3X+QeI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b8bc6cc-6e0b-484d-dea0-08d58db85a4e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063F3172FBD56A6C1748C0EFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(366004)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(3846002)(8936002)(6116002)(1076002)(8676002)(3280700002)(81156014)(5250100002)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(93886005)(9686003)(6512007)(316002)(6506007)(66066001)(106356001)(14454004)(97736004)(229853002)(99286004)(6916009)(2950100002)(76176011)(33896004)(10090500001)(7736002)(305945005)(6246003)(10290500003)(72206003)(68736007)(478600001)(3660700001)(25786009)(86612001)(26005)(33716001)(6436002)(6486002)(186003)(4326008)(54906003)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cf7zMzhSrbmexdptHST4+vy9JWMjzJclXzEu47YDhFOzynDVb3M06r05UPzjmnCZSmsFSMjY+jnowgV244MyryTVfwSdJFDH0H2AQSmb6DsIvp51eY+KViRcBiDLrydRXQlon2ihbhNTnfVwfzkNl9UL6pPH66ef9gMrjeSg/EYHEk5uD/BNqlr39zR2OnX1ytnFjVTOskSWJ+rpsZAnA/lV1XWLUvWCsNPRTzooh3gWZA0YmOxKLG5rJgvMhMdMABtxzNi9yzat0/+a9q+Ixyim0wNG6lmsFBmhlxW1AbEM1O0+YGeVGfMJPaLNUf9hcQ66jXjCv7CEPxzH3rZ/Mw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <553CD27E3303B84C9E3B00391F910231@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8bc6cc-6e0b-484d-dea0-08d58db85a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:42:07.0259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 08:57:30AM +0200, Tero Kristo wrote:
>On 19/03/18 05:44, Dan Rue wrote:
>>On Fri, Mar 16, 2018 at 04:23:25PM +0100, Greg Kroah-Hartman wrote:
>>>4.14-stable review patch.  If anyone has any objections, please let me k=
now.
>>>
>>>------------------
>>>
>>>From: Tero Kristo <t-kristo@ti.com>
>>>
>>>
>>>[ Upstream commit 729e13bf58e643b9accd2a14c55b555958702fb0 ]
>>>
>>>In case the clkctrl node contains assigned-clock-* entries, registering
>>>the provider can fail with -EPROBE_DEFER. In this case, add the
>>>provider to the retry_init clock list so it will be cleaned up later.
>>>
>>>Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>>>Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>>This fails to build for me on arm32:
>>
>>$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- O=3Dbuild-arm mult=
i_v7_defconfig
>>$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- O=3Dbuild-arm
>
>This actually needs commit ffb009b24388b896d9ca8b54e39a879302142518=20
>("clk: ti: convert retry_init param to use void data type") as=20
>prerequisite, otherwise it fails building.

I'll pick both up for the next cycle, thanks!

--=20

Thanks,
Sasha=
