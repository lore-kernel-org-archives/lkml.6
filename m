Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3493315-1520434712-2-4309921898963739451
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520434711; b=CwmhrStCPWn7XQDuTaiNUPudhWb7c9OAkvamF98egQ8NWoT
    sAAQfpF7USLVP1un/V/h8egJKm6zmV/vcxnVEScodiJ7hzZl5InQaqwGCkEkXw2W
    g+/i6cNZ6inFz+oyupfAvuNZ+z73MejvvCPYER9ep6TIhqjO0q7VoX70YSZhXUyQ
    ioSUZR3RGFmcWiTPJCzKjkN0apBjKJ2o+yl3ndZYJ27JuxHMKDZGh/XYtGuM++Jj
    mow4zTXgi5VgcWtwmCtEyvBny2ntzwLGM+18CxpbG7RDeUoHIWm5hSdxOdR0BnIB
    mwX78FzwaH2qJsAl06GyZfm8Qg8dnhmlOAHHshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520434711; bh=Aq0i1ijF2jfBbEIrwq+p292mcxjzPRDuW9I0IW
    +uwa0=; b=hWGGhciyMZlZV9/opGYUm3qY+W9Pt5MHhMm7HjhWHRBMk1lZ+LFxPm
    CxdS+M8jeF+JNz6G0odK1v57/U5POgP0GwJNZmHdRoNBHjzJfusnaK5x8H1bown+
    JkhOEeCmp7IeuZn8mi7l4ryc96fBD4wpv+iTvnNc6CYP4scT0ZCeL1LjZpWemsVc
    rZoAp/VmFuqoaDhoOstHB+uyR3/9P3dYWRtkqdi8y6gGEp74SA3gah1Elzo8DMd1
    VGR4jojbktp88qYFbCQNPkwmZZ5AczKnMr1utr/kUGGV/dCDrTuRHdx5yIaRqBTK
    fVy2A0cpEdi7hrQNPmb7TsORJ4jzRaFA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KKtY7Avy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KKtY7Avy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeCGO63 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 09:58:29 -0500
Received: from mail-bn3nam01on0127.outbound.protection.outlook.com ([104.47.33.127]:45467
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754500AbeCGO62 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 09:58:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
CC: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 4.4 03/34] mtd: nand: gpmi: Fix failure when a erased page
 has a bitflip at BBM
Thread-Topic: [PATCH 4.4 03/34] mtd: nand: gpmi: Fix failure when a erased
 page has a bitflip at BBM
Thread-Index: AQHTsgQtgovGbdiw4U+JNRdUpxG2GqPDvm8AgAC1ogCAAHFdAA==
Date: Wed, 7 Mar 2018 14:58:21 +0000
Message-ID: <20180307145820.a6p7g4zzw4phdb66@sasha-lappy>
References: <20180302084435.842679610@linuxfoundation.org>
 <20180302084436.171257760@linuxfoundation.org>
 <1520371350.23626.23.camel@codethink.co.uk>
 <20180307091236.741b7fd2@bbrezillon>
In-Reply-To: <20180307091236.741b7fd2@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:+QZDmJ5lOg1Z4U89MPlVR/HluUX7xTWt8MAEGzFBwD0A1ZdzR1tuGh5AL7VnzNWi16j6eXksUXRybTIueZV0j07VFbZtNtJ8W07J1hzMXzhDRPmTnqNgtzI8eoI0Cs6mrP/12GZbSZR+3DO97C+vPupaVBSMR5joaLLzRS1LB2seQ3i0S2csfFTyPqwAzpHlZWb03IYa684owhTOQ3uRvwdTarPq6Z+1JUXryhIHLjWlg7aI5qcKNm55P2XYSOJC;20:iVHGZUjj6KvNkygqdNHmTEdK5msJqlI9mE9Eqr4Pz7lrxozG1ZP3XtDzoJL6KZjNQ8u3PvLlWbiWdqQsGCd8dXwOsnmksh6zpQpI3c+es+xmQj5BVJ6k9kYseP1/lTHQrowRnQYy9W1o/ObDJE1xgoeDQG8ztXr0s+UpBjcA7AU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 107fe08c-db08-4d68-99d4-08d5843bdeaf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10321BEFF180F1586D466BD0FBD80@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(39380400002)(39860400002)(376002)(346002)(199004)(189003)(377424004)(99286004)(316002)(54906003)(72206003)(86612001)(478600001)(3660700001)(66066001)(14454004)(106356001)(6436002)(25786009)(6246003)(4326008)(53936002)(6486002)(76176011)(9686003)(6512007)(10290500003)(68736007)(5250100002)(6916009)(2950100002)(186003)(8676002)(105586002)(93886005)(33716001)(97736004)(8936002)(33896004)(229853002)(6506007)(26005)(1076002)(81156014)(22452003)(102836004)(81166006)(86362001)(575784001)(3846002)(5660300001)(10090500001)(6116002)(2900100001)(2906002)(7736002)(3280700002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: M0+F4jFBIxGLt5QUYZ6ctQk/B9U+m6LPw7E6J746+N7R1Gk3xz8ODWVukc79kbcoLLMFmExuw7ZPFVXNJbs7N6S5QSqIe+6vAiGedwrpr6NjfnB3pIwpa/Wa0TsMeIfyY4ojKXzVoOn0HBv7f+KfAj4LAiiJitlOfdMmsr+FUr75Nn0ERYnZ5cI1a8ymdPAB7DLE8UVrHxwpzxKRTGmxKnzh7rYX9Gf0/UbYNguA6Tgzmsc5j6/LBggqB6VtCReMRjwmpepDN2wvhQjFReTpGpmplh4YWoO/sjnrwUpzTZ6szr4wCOw8xib1S/+ksVr8kEcydgN17Bd5jz4pZDT/0g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E523F9C7B253374391BEE76ADB475050@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107fe08c-db08-4d68-99d4-08d5843bdeaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 14:58:21.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 09:12:36AM +0100, Boris Brezillon wrote:
>On Tue, 06 Mar 2018 21:22:30 +0000
>Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
>
>> On Fri, 2018-03-02 at 09:50 +0100, Greg Kroah-Hartman wrote:
>> > 4.4-stable review patch.=A0=A0If anyone has any objections, please let=
 me know.
>> >
>> > ------------------
>> >
>> > From: Sascha Hauer <s.hauer@pengutronix.de>
>> >
>> >
>> > [ Upstream commit fdf2e821052958a114618a95ab18a300d0b080cb ]
>> >
>> > When erased subpages are read then the BCH decoder returns STATUS_ERAS=
ED
>> > if they are all empty, or STATUS_UNCORRECTABLE if there are bitflips.
>> > When there are bitflips, we have to set these bits again to show the
>> > upper layers a completely erased page. When a bitflip happens in the
>> > exact byte where the bad block marker is, then this byte is swapped
>> > with another byte in block_mark_swapping(). The correction code then
>> > detects a bitflip in another subpage and no longer corrects the bitfli=
p
>> > where it really happens.
>> [...]
>>
>> This seesm to be a bug fix for commit bd2e778c9ee3 "gpmi-nand: Handle
>> ECC Errors in erased pages".  That's not in 4.4 so the bug fix is not
>> needed, though it doesn't appear to do any harm.
>
>I wonder why the fix was backported to stable releases in the first
>place. AFAICS, there's no Cc-stable or Fixes tag in the original
>commit. It's probably something in the backport-to-stable process I'm
>not aware of.

It's an attempt to mine kernel commits for commits that should go into
stable trees but were not marked as such.

Thanks again for the review!

--=20

Thanks,
Sasha=
