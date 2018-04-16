Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4150847-1523913065-2-11390715994077590636
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523913065; b=t5Z/tHVaZj3rpg3oJG5HB+ckj13QR7/Fm0qmuZiq9VkbSe0eCS
    qcYR8KWlBfV+Aglyb0kSUfEfV84c6mZ8pRrpViNdAcysEW8uSj5TyxSxJGQ5wqfP
    QxAzJ12vttSS/rutgPI4nHzJp9RXcDyRl93l509xRKX01hqZmn8feVJrNMDw7mXD
    Qv3BOtBIoKHePBrg1xYCOMYJKRg8ueF15M/xw76S0P35hrfrup2jLmCCWnDMctCA
    wkYEkTtNgj+8rsznO8HJUB2ZGv32xZfAoEZweKpBk0nAftKqX9S5UhfHD5TJbdVd
    tvBJB8+AKDtPb/qLF9gNriKpaOKc0pS70eDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523913065; bh=SVczgDG74q
    IBq34B7DNAtk4z67TTfRWWyUCxDiUmr6I=; b=oO9a1PNIMODEdJXDzpPR8y7rBH
    4l0I3leM4eLfPH3IdsSRcNzcz9sPoYoRR8RHhs4/UFeMljVyKSbHRorJyONazx/a
    uvta1xv96QJOHeeOO9wZiGk5LAx47EYnXZJe3ACfsN5A3rFeYrMro9ohzy9Xq57A
    JvRfzKY5I1GjRkk+RV/WXGXji1UDIG7Z3ApSe56g6R21mD9aHvoKDieJTwZnp4hl
    exyOufoOx0JGCCeOn6WnWLkQ7aKxqYyvnmhKsGzC3S0LpYpJ/pezehVKQTqW65Ai
    NcDoNFMsCB9/yLVb5VVmVNytb473N3BQgxdn/TtkkK8b74q5pZGlTSg5iypw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V6ShJOsb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V6ShJOsb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKazxC52hBhfOz+1hhgGjF10RoEgBk6h6G7P1uQc/BiWLcB8l3Ssl64xEj8az1wyi/N9bbyINWiurOQM93he8o8CCl4MKRh20YAaUO4a1+cMb7d5RGVl
    /L1fQCCulrG5nq6IA/ymrM+N84zX6nFRtuPsL7suMPRw96qULCll1TO8XC5ghQmIMCc0VNlWO2SsqJKlNrZYsrYlhlyIrnIyB+uAz7U/P7w4SWkoSiwBhMic
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=F-eafH2JolcA:10
    a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=j9rpqodEW2C3JiCyNiIA:9
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbeDPVKu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 17:10:50 -0400
Received: from mail-hk2apc01on0127.outbound.protection.outlook.com ([104.47.124.127]:64512
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750709AbeDPVKs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 17:10:48 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        Pavlos Parissis <pavlos.parissis@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jack@suse.com" <jack@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: RE: kernel panics with 4.14.X versions
Thread-Topic: kernel panics with 4.14.X versions
Thread-Index: AQHT1YZ2Fl4TtFRnH0qUyqkfz/cZJ6QDdryAgABq8lA=
Date: Mon, 16 Apr 2018 21:10:35 +0000
Message-ID: <KL1P15301MB0006B378757EC8F6B4D87BBBBFB00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
In-Reply-To: <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-16T21:10:28.6635984Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:e::785]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0088;7:UlgN4Ll1OTw/EzN2SCDL8vc3+BdQUoSOG4gE7a8IrJ0oUbbCc2b6jHAtXiET+KxvGNodk7dzKbxGwYprWGoklsoikkam+jsToF7ZtWviNghzaGi0TegrPXjouHC6jIxD0XVva1CUu3Dz/EObbdLdplFjc1N2O5xGPW9Gq9YUTBQeEipXkJuZkUuMUNpNZwLph985SIaR5tovdfBMua/+VwWPAbjlTXg0e97EXIz4Eg71G6LJ/haMjxgdGys60Z71;20:o9bgwlKP51ZguhWmGi1JFvFig3PmVNdFJg4Pa65vyTKENrvJNkGrol4jOjk4SGxzgqbxG10ujtcocWQti1bo+ynBc3y7DaHg+qig/ZlTHyMJ3j+1iKUA9pa5e9mO5cyaofgJYyTJuSy5g6Y0n2m3BKfrkdsmBrsRj9VKEP42fkQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0088;
x-ms-traffictypediagnostic: KL1P15301MB0088:
x-microsoft-antispam-prvs: <KL1P15301MB008808B436EE615891673587BFB00@KL1P15301MB0088.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:KL1P15301MB0088;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0088;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(39860400002)(376002)(199004)(189003)(54906003)(110136005)(53936002)(97736004)(81166006)(86612001)(81156014)(8936002)(9686003)(5660300001)(6246003)(2900100001)(10090500001)(305945005)(74316002)(33656002)(8676002)(55016002)(105586002)(8990500004)(106356001)(486006)(476003)(11346002)(446003)(186003)(46003)(2906002)(77096007)(3660700001)(4326008)(7696005)(76176011)(102836004)(6116002)(6506007)(7736002)(25786009)(3280700002)(22452003)(86362001)(14454004)(229853002)(6436002)(316002)(39060400002)(10290500003)(68736007)(478600001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0088;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DYR7xcVvGEYUfNMkoPwemnwWzgRjv0ZZGnno05cHCGMxurgTTkfpMSylWhHSj+dq2RCxT0orJRiShlJqXCWBTRhiOjok/UDytuuWlVNKPpxWNrl2TFyH2e5LDEHL7cYlRPCf0+7cdIN5rdp6Rd/Chfd0KHToJahCOOEzGFSozFcKpPxpYSvHe/Q+J1o+8MOp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f4cc7642-5da3-4d5d-7aeb-08d5a3de7f3f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cc7642-5da3-4d5d-7aeb-08d5a3de7f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 21:10:35.1195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0088
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Jan Kara <jack@suse.cz>
> Sent: Monday, April 16, 2018 07:41
> ...
> How easily can you hit this? Are you able to run debug kernels / inspect
> crash dumps when the issue occurs? Also testing with the latest mainline
> kernel (4.16) would be welcome whether this isn't just an issue with the
> backport of fsnotify fixes from Miklos.

It's not easy for us to reproduce the fsnotify() lockup issue, and actually
we still don't have an easy & reliable way to reproduce it.

According to our tests, v4.16 doesn't have the issue.
And v4.15 doesn't have the issue either, if I recall correctly.
I only know the issue happens to v4.14.x and 4.13.x kernels

Thanks,
-- Dexuan
