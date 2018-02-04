Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3773008-1517759363-2-15808041088323450207
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
    t=1517759363; b=CvvUH9oX+6reYbP2R1M5oS8Cforaf/TDAGTXlyyE7jVAn7w
    zW9F0WLVDoU8zwy09KgZcW5t/+MA8dcsOvIiBpPunBbpitwhddgDniLKtxzeNDIK
    2K2Q+LHwT2cxzu1QclpA+oy8/D1AzBOqrLrjdOnJi04TbptMK5YWr2GTdbzkAro9
    j/gUI9hoDcsX/aX6g24VWx3vMIEgfA7IvPWVhKsDdgw3jDaB+/PihN/YMsuQgxSt
    0+QjYKt/l6p4uYwXhP1mn8x1geiDmXMc/5XkKC8sqOU924ZVzNOhMFUzwfUxisu6
    8bQMKem0sJElhGqCiOf+CFHznaRL5uKOjqC78EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517759363; bh=fc0G4SBpDmLqIeeUYZ+QFLMovmZE33ayiGd/XP
    5TId8=; b=K1SxdbOEy56fNSWwfDIClcNdySE3SAsnXxjzK0yTTFgA5vFByq9U9C
    7BKvPaGcLn52vENOTuGABYMdI7hqW//s8f988G6fqH/vancvftP+PckmseItRsuw
    APywxHKmd1PebAJD+fliQsJnLdg622TSLJPMQYY/6kySDbfSdXsSizHGXDKEKbmt
    SeN9wwQtiXJJbnPgsc/qMP5mKlzhd2omZhRHoD7/bjMbg63FuC/ov58EzCrkIpvu
    d1wJEcNmwtOkN1ySowBgtcd7EMwr+HY0rWeaOUG64D7YVepyl1eVwwWu1zwY+6uj
    mv9EHRGi+iz4Ed+2UhKcMphf3Bhge7FA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A0oRs3ga x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A0oRs3ga x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBDPtL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Feb 2018 10:49:11 -0500
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:11808
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750995AbeBDPtK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 4 Feb 2018 10:49:10 -0500
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
Thread-Index: AQHTnRjyue81aK36CEu9eh05vWJz5aOTItkAgABBrICAAI/mgIAAcLqA
Date: Sun, 4 Feb 2018 15:49:06 +0000
Message-ID: <20180204154859.zfkp4oia5iorewo5@sasha-lappy>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd> <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd>
In-Reply-To: <20180204090531.GA29468@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:xf5TLWlcaEczNMzRkeL50rmY1DknGvr5K+F3PAs1Ztmr0nuvlYPLxfQ8ww4U9jhfPJts2XESBZzWSovEw+u+SRfXURnNVaEyq24zXOoJ/J3yaBU9xt0y4UTNYk7bXh/arzI9j9xq+8Y4/QWfVm/mpnJXdyYEg5tbHFgXCQgScU+Sq8P4xsJGHK54zrYTxSrfCrUroi0P9op85IqIC2JjXPt7+CCubWI91w+CgluQibUjyrmYQm1UjvWX7sffgFDe
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f90d51ad-c3b5-442c-fffa-08d56be6d35d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
x-microsoft-antispam-prvs: <DM5PR2101MB1016907E1846D0395DED2E95FBFF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 05739BA1B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(396003)(39860400002)(39380400002)(346002)(377424004)(189003)(199004)(575784001)(3846002)(6116002)(68736007)(86362001)(106356001)(102836004)(1076002)(99286004)(93886005)(6486002)(66066001)(6436002)(14454004)(4326008)(186003)(316002)(26005)(54906003)(10090500001)(25786009)(6346003)(6512007)(9686003)(6246003)(39060400002)(86612001)(53936002)(2900100001)(22452003)(8936002)(2906002)(81156014)(8676002)(33896004)(76176011)(81166006)(33716001)(5660300001)(3660700001)(229853002)(6916009)(97736004)(2950100002)(72206003)(3280700002)(105586002)(7736002)(10290500003)(6506007)(305945005)(478600001)(5250100002)(59450400001)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: oHSJPsBMsaDRZR2bEA5Ytm8GZCDG34AUkpN9ZiT2URCocQkSydBu5VTXoIb7coqe1Sh9kSLuRrrFdcBiuaeGxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C3F69C61AF7E0449CF3DF314CC7C5D0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90d51ad-c3b5-442c-fffa-08d56be6d35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2018 15:49:07.1173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 04, 2018 at 10:05:31AM +0100, Pavel Machek wrote:
>On Sun 2018-02-04 00:30:36, Sasha Levin wrote:
>> On Sat, Feb 03, 2018 at 09:35:26PM +0100, Pavel Machek wrote:
>> >On Sat 2018-02-03 18:00:59, Sasha Levin wrote:
>> >> From: Matthieu CASTET <matthieu.castet@parrot.com>
>> >>
>> >> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
>> >>
>> >> With the current code, the following sequence won't work :
>> >> echo timer > trigger
>> >>
>> >> echo 0 >  delay_off
>> >> * at this point we call
>> >> ** led_delay_off_store
>> >> ** led_blink_set
>> >> *** stop timer
>> >> ** led_blink_setup
>> >> ** led_set_software_blink
>> >> *** if !delay_on, led off
>> >> *** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW i=
s set but timer is stop
>> >> *** otherwise start timer/set LED_BLINK_SW flag
>> >>
>> >> echo xxx > brightness
>> >> * led_set_brightness
>> >> ** if LED_BLINK_SW
>> >> *** if brightness=3D0, led off
>> >> *** else apply brightness if next timer <--- timer is stop, and will =
never apply new setting
>> >> ** otherwise set led_set_brightness_nosleep
>> >>
>> >> To fix that, when we delete the timer, we should clear LED_BLINK_SW.
>> >
>> >Can you run the tests on the affected stable kernels? I have feeling
>> >that the problem described might not be present there.
>>
>> Hm, I don't seem to have HW to test that out. Maybe someone else does?
>
>Why are you submitting patches you have no way to test?

Because.... that's how the process works? -stable maintainers don't test
every single patch that goes in. Never happened and I doubt it ever
will.

>Plus... you don't have PC keyboard? You don't have thinkpad notebook?

Nope, all the (limited) testing I do happens in VMs, which don't expose
leds as far as I know.

--=20

Thanks,
Sasha=
