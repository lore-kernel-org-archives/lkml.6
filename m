Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-440706-1521656005-2-12590403513352933411
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
    t=1521656004; b=WQ0pVKacS/qeacZi3OsLYGG+VtbiMSLh3/9MN+nniKQOdb4
    UoKdCF54MH9QJOeCteXt6T1EJQn1rNNml0Z8HA0sx03xqs+Fa/es45omZ/exq7ut
    hB4+iD+6p6dVCo6hZPsUgHXOZRr0K8SnugcmvMk7tM8dsVldPqvfeJxENtzWz+3y
    HeDwQ3jgTbnKzyK5IKsn8pJRS7fhNli1epeqi9wP+XGiCMVg3uholPTI94+lgg+U
    mUe6E1vJDeA8JtzTCDcEm9OjHdmeIO6YK5wr6FkQUPBLzO4NA7U4iI94YT3Atfrm
    g+OfbZR2yeykoNDj+5MvCW6TSTxGYxiPsnwjawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521656004; bh=0MCpFqiW5eNodtBssd4RaxjO9HXoYbSNmRB6PF
    XF3rQ=; b=Oiu7MCiErd0N4JUSuOZBobCnBs7nzAyqEGT9rycropCR/5o8fIOdCh
    XpC7RJqXxjeYzaO5gR8dc4DyS2gT8kKW+2i4ryLDFF2CQjsk8oenBmJO0PfdZIw/
    +MXlhbGRYO0MC0em6pNkjAt6NG/2pjDU1aqdFaS4OTQEoL1SkW0Iw3w0pe0VkZoh
    JJGl2TMcuxISF3XjF7J1Iyi920ztirSlhPnegCJjwmI7jhxgKtU4zDZ7xA4ZE3H5
    3dqRCHBQTuVS4b74MK1ZXumKhPVwjc84qMTs+E3q/3H+8GAzU1SHOHmBCuz2pOUl
    aEXZYPQMqLkhYTPh51NPWHesc4IlI0/g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dewOCpZH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dewOCpZH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeCUSNW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 14:13:22 -0400
Received: from mail-sn1nam01on0116.outbound.protection.outlook.com ([104.47.32.116]:15647
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752136AbeCUSNU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 14:13:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH AUTOSEL for 3.18 044/102] fix race in
 drivers/char/random.c:get_reg()
Thread-Topic: [PATCH AUTOSEL for 3.18 044/102] fix race in
 drivers/char/random.c:get_reg()
Thread-Index: AQHTv50SKnpWhYnAQUCZrzeeMQkI+6PY4g8AgAIfRwA=
Date: Wed, 21 Mar 2018 18:13:18 +0000
Message-ID: <20180321181316.v55ryf7ekck3rgwy@sasha-lappy>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
 <20180319161117.17833-44-alexander.levin@microsoft.com>
 <CAMuHMdUHR5-ULz_9Az1dq4CreydBA4xceeozhitJ=JR2vRhraQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUHR5-ULz_9Az1dq4CreydBA4xceeozhitJ=JR2vRhraQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:i+CcEc2XHJFhC+Iba9qFT5q6cdQTFrX3EGjoJ7bGOehmE+QrhA7up4rG4R0wwo9l4qx4MNi7/t8nuBrxVrnC9UXJz2dQ5Vop1vBaCTS6fY679+JEz+g0DpZNpbNMJzfwIzxcLtrKAiZIt2rt8/ocb4Tjgo/SjDP0Rk0pddGRwcPoYHO6W7EbsG8RY9qY5MHmE60TZ6bS19pKpmpw8x+uwkql2b9HwVRk1wWXAd6jVzREQ24EP9WeC7NlVYXY+EqS;20:/EmH+8GWbeUzSTeoEeFNhrPS7+4uZ5C0MwV9oXrZYvNgUhxmEROX/61w4wS19tXHeF1JlHjWbthol3IZ7kgFNqGQps6cDveE+d9yRdyb6Pv8FoyNM5hN6L6Ni9DcFnJ553xR3YXfCWwG5pHdC4uZqjKYmtBKLKwMEvAdmu1dJhA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e14eba6f-55c8-48c7-0a78-08d58f576c73
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917C775E50C88BBDD955640FBAA0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501316)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(199004)(189003)(4326008)(6246003)(6436002)(5660300001)(6512007)(9686003)(6486002)(66066001)(33716001)(305945005)(3660700001)(7736002)(53936002)(81166006)(105586002)(99286004)(102836004)(81156014)(25786009)(446003)(68736007)(186003)(6506007)(26005)(97736004)(76176011)(86612001)(59450400001)(8676002)(33896004)(2900100001)(14454004)(10090500001)(575784001)(6116002)(3846002)(5250100002)(2950100002)(2906002)(6916009)(22452003)(316002)(229853002)(478600001)(72206003)(106356001)(1076002)(8936002)(39060400002)(54906003)(10290500003)(86362001)(3280700002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8PmslexACDa4WL5fZOfH8bY5ouQOJhj5bIQZuPMa3C5SHCf6Img3pjumWfi0MiWscJxbW5iPVLmKOhTnLvi1McXCgywP6U/NfmD/dyakMJQH3EUflAk9rPFcTI4PkeGGPjdkApgMiGcrGibqsGuLTbTcbU8Wbc5AEIWbjjuNepQ3YEZ9PugRqiModj5wimFHh9oVHoiLEApEcMO+JZl0D5QK93PHxJwOYFI+RwBptPCbYGYVieJyhUmWifyCTY0gISCePv5dSPEox1OxVkIt8Lv4tGcu9dm3WB0xV3UvQNbbekkjB+m54vCf2TTmLdBkZfepx6L83fQlb2MqZbxpfg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF7AE0FFAFF97E4AA9AC95C366F1DE98@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14eba6f-55c8-48c7-0a78-08d58f576c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 18:13:18.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 10:48:48AM +0100, Geert Uytterhoeven wrote:
>Hi Sasha,
>
>On Mon, Mar 19, 2018 at 5:12 PM, Sasha Levin
><Alexander.Levin@microsoft.com> wrote:
>> From: Michael Schmitz <schmitzmic@gmail.com>
>>
>> [ Upstream commit 9dfa7bba35ac08a63565d58c454dccb7e1bb0a08 ]
>>
>> get_reg() can be reentered on architectures with prioritized interrupts
>> (m68k in this case), causing f->reg_index to be incremented after the
>> range check. Out of bounds memory access past the pt_regs struct results=
.
>> This will go mostly undetected unless access is beyond end of memory.
>>
>> Prevent the race by disabling interrupts in get_reg().
>>
>> Tested on m68k (Atari Falcon, and ARAnyM emulator).
>>
>> Kudos to Geert Uytterhoeven for helping to trace this race.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>You probably want to apply follow-up commit 92e75428ffc90e2a
>("random: use lockless method of accessing and updating f->reg_idx"), too.

I've grabbed it too, thanks!

--=20

Thanks,
Sasha=
