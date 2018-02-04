Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2187044-1517704252-2-6755774603324664369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517704251; b=KHtkwsrWBi75p9sU7C8DxyWQeF7kzUd4W30qGQiae8sWhJF
    Y3ALygYtrNSd3KjWshhUnxncUD0yPj8j1HMkGqld2ffCc8dj8RHgjDSyeGhUopye
    x9g0JXbt+cXnGTE1jXJ60+fKcMGn9o0ILdsc9uVFgYK6RFyb9PxOR5DuFUTjSH5Q
    73+jjyXZjCKYbsNKmIPrddWYYSGJoMchrB7oWmTs1z/Zd4hTu0zCHPS6aoxUDKg/
    WPPt3jg9RoDdvjNpAQv6ZGziRlDVLK1TMg3nnwEvANw0XllusUHgDOLmj599BQQ8
    zAdk9EjglSuNG8+g9UO5dodtI0vdQswpkZqDl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517704251; bh=yv9nv45yLR9E3uztAmRJI4pMcLjvH+IcpX+Eyz
    B1dJs=; b=GMkYQDWgGtTOpYVtOpB0fZNs4wBL1WC6D6zbPbeRvnslVd974KhOPE
    QD6v90lF2w6hzdysfS/HDyGR5WG69riqhvYYIRMWva+Q272XbIAkm5lYy0TcXk+a
    v06GeVkWynqxI1MGK2VLDhsMcirRh2ZJvvT+Ymk9JKLmQhq9fA5Rxw+9i8Tyo5ha
    yP4Tzup6+ed8Y/sQnCi9GQ2IuFlQzAJPOJrnwit4fEv1hR2ppkyWXstzI3cQPtrZ
    pbIdNjOJ2kKA6hbwrjnODW/oRz9XUXlO82IgBVKYQ9PVnj9wBoWSMDyo+KRtCzfi
    LEhR0XRYNjRPLUjS6MJXfTj3SsyTl4gg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XxKw9+V4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XxKw9+V4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeBDAak (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 19:30:40 -0500
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:23504
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752193AbeBDAai (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 19:30:38 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Thread-Topic: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Thread-Index: AQHTnRjyue81aK36CEu9eh05vWJz5aOTItkAgABBrIA=
Date: Sun, 4 Feb 2018 00:30:36 +0000
Message-ID: <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd>
In-Reply-To: <20180203203525.GA5860@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:h1RFVhaYqKf2wq6H9IJMOPJ6cOidtXJJGrBxQ7tMBm0xCkC0HdI56ALWjg69R/SVcx326LEguZxzFTZlGENT8VpyxTzza1aVTA5MmmypWFiyUBDLYOZNDHacfDkCfP87xZLL/3T9ti/haO8UWC1k9vWJ5iSHSIVz02CK8b8fyXPdJK212riBCQF81nwUupxa0vgZkFCXVpzb0MozOcaYwEGLjbFhJIE8xEDMtJj2bSWEtC8Xf0RDuXzADWflpiJw
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5053a7d5-9fcd-4ca8-5fae-08d56b66826d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
x-microsoft-antispam-prvs: <DM5PR2101MB0901F72BDB6E149308BB945DFBFF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 05739BA1B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(346002)(39380400002)(376002)(39860400002)(377424004)(189003)(199004)(22452003)(6116002)(1076002)(2906002)(106356001)(66066001)(5660300001)(8936002)(81166006)(2950100002)(6916009)(2900100001)(81156014)(4326008)(25786009)(68736007)(86362001)(9686003)(53936002)(575784001)(6346003)(72206003)(6512007)(478600001)(186003)(76176011)(59450400001)(3846002)(33896004)(10290500003)(6246003)(26005)(102836004)(86612001)(14454004)(39060400002)(6506007)(5250100002)(6436002)(99286004)(3280700002)(3660700001)(97736004)(229853002)(8676002)(7736002)(305945005)(105586002)(316002)(54906003)(6486002)(33716001)(10090500001)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: MhW8Da2EokN/LLgLvrLqAE0gcIYkRwW/xDQzqTgoHW/i7DmA9GuXT5mYOa144SDuT7dfoOIDu9r0Swaeg1s9xQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB18DC4E6503B041AD4B573CBB9DE78A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5053a7d5-9fcd-4ca8-5fae-08d56b66826d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2018 00:30:36.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 03, 2018 at 09:35:26PM +0100, Pavel Machek wrote:
>On Sat 2018-02-03 18:00:59, Sasha Levin wrote:
>> From: Matthieu CASTET <matthieu.castet@parrot.com>
>>
>> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
>>
>> With the current code, the following sequence won't work :
>> echo timer > trigger
>>
>> echo 0 >  delay_off
>> * at this point we call
>> ** led_delay_off_store
>> ** led_blink_set
>> *** stop timer
>> ** led_blink_setup
>> ** led_set_software_blink
>> *** if !delay_on, led off
>> *** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW is s=
et but timer is stop
>> *** otherwise start timer/set LED_BLINK_SW flag
>>
>> echo xxx > brightness
>> * led_set_brightness
>> ** if LED_BLINK_SW
>> *** if brightness=3D0, led off
>> *** else apply brightness if next timer <--- timer is stop, and will nev=
er apply new setting
>> ** otherwise set led_set_brightness_nosleep
>>
>> To fix that, when we delete the timer, we should clear LED_BLINK_SW.
>
>Can you run the tests on the affected stable kernels? I have feeling
>that the problem described might not be present there.

Hm, I don't seem to have HW to test that out. Maybe someone else does?

--=20

Thanks,
Sasha=
