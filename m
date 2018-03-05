Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2487537-1520280471-2-17495960371438604707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520280470; b=bRNun6K2hXKz2ciHbJor8gwRxdKC7ZeeNIWM0zw9SJoFxxK
    IguZ/bGqLn2BBYmiwKZvp7xUs35RDyW1BnDoEyCqesTcWsfwAE037WRnppbWywnB
    qYuBLQIPQT/NMENwZnCpxR598tS8GvBYyOeT6+my1IKHoA9D8eSO14gmxw4fogpE
    5gQC7E/+2t9J5xN65zQAy+t5gwzsi3+lTWyi8aUJ+wk7FfuldkXiobA95zHlQai7
    E+iYyFSKGzCqPlSGb8tiC8cx2zBX3HFjcSK+f9jvqR8q51gUihcrvcbBO3x1J2Zp
    hEo1Dduk7zliMjepYqu5IXK4bYofvWjg40L6rgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520280470; bh=jVapP09lPEz7wepnUlHFx9RLwYdxjMOXRCFHXr
    wYi+g=; b=mfe8+3bniShOS9XfcXe8vcI8kKLxQxAyjKXBCxZvmm/tk/NEXMtXhw
    Hxa+3lgmga+PFS53P4guaGiFjT7/gHFbHf4EKjcexRMFK3l+sAIkQu6BwcQXkQLm
    9zLiZeME3RnJkoBM2hxFTgj3frjCJ/8dKSgehUgwHDoQVmzDwyX7e2jVEtNqIdb3
    FlrpUu91x/fCEp5Noqlirr0ULOuVPKXPkLfJfRxdrMuXqwsARuyw6m+QT6y50DLb
    dEWMnQ1FWYy8kq/+uuqcKC3LvZOy4mAqo3gzktMCkMp6365QzdhZ/ukbEKAQsT1L
    y768bZL1tzprm3mll7U6l59H+PMeAyUA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WfiTDXii x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WfiTDXii x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCEUHt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 15:07:49 -0500
Received: from mail-bl2nam02on0110.outbound.protection.outlook.com ([104.47.38.110]:27570
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751764AbeCEUHs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 15:07:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.9 002/219] spi/bcm63xx: make spi subsystem
 aware of message size limits
Thread-Topic: [PATCH AUTOSEL for 4.9 002/219] spi/bcm63xx: make spi subsystem
 aware of message size limits
Thread-Index: AQHTsz7gbxq43L/790e5qAZ18oup4aPBcW0AgACjVAA=
Date: Mon, 5 Mar 2018 20:07:46 +0000
Message-ID: <20180305200744.afw64js6wnmyfqrb@sasha-lappy>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-2-alexander.levin@microsoft.com>
 <20180305102310.GC8588@sirena.org.uk>
In-Reply-To: <20180305102310.GC8588@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;20:Kdr7/P4HJZ5IxkbX3OTcLG0UqIcUkJXSnikwZidAsQIudwmCogOEgDXnHq4d4rKcgIpXmAsSC1lsWZQEo181YBQOnLBFJwz7h19/1P8vZTmvajGUosiat9ulqkWral2gfKGF4AdKQ8xX2hZ5tAdK7Sqil2DFo+7ixH4uxgZocZA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2a12812-b87c-48c9-1c35-08d582d4c355
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603322)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07269FCBF2BF769315329C52FBDA0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(189003)(199004)(4326008)(22452003)(6116002)(3846002)(1076002)(97736004)(3660700001)(39060400002)(66066001)(99286004)(81166006)(316002)(54906003)(33716001)(5250100002)(478600001)(3280700002)(15650500001)(10290500003)(86612001)(25786009)(2906002)(72206003)(14454004)(5660300001)(33896004)(105586002)(6512007)(9686003)(106356001)(6436002)(10090500001)(6486002)(6916009)(26005)(76176011)(229853002)(2950100002)(6246003)(68736007)(6506007)(53936002)(186003)(86362001)(2900100001)(81156014)(7736002)(8936002)(8676002)(305945005)(102836004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: mHpxKB/loQQmyiYL5O7KgGau0J8k4qIez0vtPWxhYSGl002DRVuSlD4rsGweF8TB6vciF7FhCDTQKf8T3PGa6LLj+ubK8CAS1KV1zLrp2Gg3RFQeXksqlVhQCVPfG0qBq+nl88I7NIhNh0x4hxipzzMA9J3vqIlh0nRxelj2dZN+T8hrG33ahxuiTiJ+7BW4aBb3DjuoOscwGaMYsCLH7QzkzTivbhRRItXJSPaSoI7d+3KI9gN+NkjrT+dFlkHXH0qzCj+kl4FMUwf3iLAKYZHhjqGD0DGxXW4c9rkmLRHyKIEcJ37taJ1uS9m8sMz7EfVwbudfxLSr/B4M9QssEQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CE15D163C562B43877A4632DE99261E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a12812-b87c-48c9-1c35-08d582d4c355
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 20:07:46.3284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 10:23:10AM +0000, Mark Brown wrote:
>On Sat, Mar 03, 2018 at 10:27:56PM +0000, Sasha Levin wrote:
>> From: Jonas Gorski <jonas.gorski@gmail.com>
>>
>> [ Upstream commit 0135c03df914f0481c61f097c78d37cece84f330 ]
>
>Why are there so many more patches for v4.9 than for more recent
>kernels?

The v4.11..v4.14 range got processed, and all those commits are now
being pushed into 4.9 and older.

>> The bcm63xx SPI controller does not allow manual control of the CS
>> lines and will toggle it automatically before and after sending data,
>> so we are limited to messages that fit in the FIFO buffer. Since the CS
>> lines aren't available as GPIOs either, we will need to make slave
>> drivers aware of this limitation so they can handle them accordingly.
>
>This seems really aggressive for stable...

Why so?

--=20

Thanks,
Sasha=
