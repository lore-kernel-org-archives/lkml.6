Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2196818-1524246228-2-7863114182970673816
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
    1524246223; b=JOsYx2VNh/VlJdeCPkz4aQJavI8KQlFZgGlHp7WpYpidA0nnev
    iEeU8Ddowa7DWwq/PKW++8GJxY8kBzuzNLQ0hRATI6BhVKMn30bXO2ykuH9U3B8R
    vc/FU8YwuUPSYvCrzgNEseo9OCDOdNqmGOVcbjA/9zNMweWyz7tyN1TzjvoYWVQK
    U80J4BLMnAm2MMVPRDFSPm43RNA2NZMPzjQzxir6UpjVkfgwbnnS6ednt2GC0R01
    NPvHxifaD5QUKYz0nXIuIcrx9QKplEGZp6N+Kp3m8YWYk6nMqDmrFOb0AK5KSglE
    YGMEUnftBzqNB/3Ep7bVvSky9RkDlPK3BcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524246223; bh=NLKPMb73MV
    2DMnPeri+yHRWk2smxtGOKkxH5iJWRCB8=; b=Ag7SXViMP6c1tvwi88prXEXRnz
    FIwjNznQfxljJqy+cGZ8C45O7N8X1L2GAIqGPtUBC6C5vinscX97HBg4kkyqciDm
    cGYwF8uRzjpUG7DgX7rtSYHXywbe8H4orC7EbofGpAW1BxqWsey5fefuYNzIi6Rn
    dSnettmgEj0fMeLJMeq/b5sGB2VJ71yJMSodXVFTVyDQkkrRcWC1G6Nif58prcoM
    X09DsGoRTjdrW4m8/yfobiLUlkGUf4Tlvtv0QErCzEw4BjIJk6SIAqoaL+Nr22Tt
    erBYEkBdAMHmkVCt8s37Qwiyc3WYSnYYzvU7sqVtDEpQh9thVycPhJuq/nUg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TxhYaL0f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TxhYaL0f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGTNfFdwKEsURTRNBhTWOZzPfQimU8W2vK1Rpm3t+T1Nc2z8SGM3/hxqpiUDGeNyCpr7sq3uSHQMwgq9JGwAz73SPEk8dDMBWF9HKfKcvvKJyh6z+bEm
    boubOETWZz3zLxtR3bwUfRUiRmSSezhUnqacKM9xXRaVM8zcciMqeqtg6VR3G/EBvh/CrZzNwSzmM3lvqfsPNdGdTXC9VpeWyadEStoKnoTUKjm84c0AFCli
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=F-eafH2JolcA:10
    a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=2bI4E7VnGr-FBsSscKEA:9
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbeDTRnZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 13:43:25 -0400
Received: from mail-pu1apc01on0110.outbound.protection.outlook.com ([104.47.126.110]:22304
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753514AbeDTRnQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 13:43:16 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Jan Kara <jack@suse.cz>
CC: Pavlos Parissis <pavlos.parissis@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Robert Kolchmeyer <rkolchmeyer@google.com>,
        Guillaume Morin <guillaume@morinfr.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jack@suse.com" <jack@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        Josh Poulson <jopoulso@microsoft.com>
Subject: RE: kernel panics with 4.14.X versions
Thread-Topic: kernel panics with 4.14.X versions
Thread-Index: AQHT2Bw3Fl4TtFRnH0qUyqkfz/cZJ6QImzMggADXTQCAAHkuIA==
Date: Fri, 20 Apr 2018 17:43:01 +0000
Message-ID: <KL1P15301MB00060AA8F117D973C92D0F48BFB40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
 <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
 <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz>
 <KL1P15301MB000619E372AA3A2FD505ADA5BFB50@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180420102136.a637r6eoghxjqhaf@quack2.suse.cz>
In-Reply-To: <20180420102136.a637r6eoghxjqhaf@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-20T17:42:57.8004747Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:7::6f7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0087;7:3qY5n+OZGRf+C5cmnn7ps1QqAWYO5PD39OMsu7jtfHMamaVckf91vTf7KSP/E+cqcrq5biyO7Ve+InTcWa0OvcISf1ve8QTz4T8HCB0C9eKkiTsyZSkmHxTcoB3FergxB0wUkW71hgmX8gKjHViokg6r6lEy4VOcUz8jbdbzxP+lW1l33vvj5gDxBtydRgG3k499er2jVirDEvUodfLUibRzBwPXpYBd4hiMs2UPqWxYsbTHco4hG41FBmvJh2ud;20:uPSxS0DpOJWOfpJTg91vdiMKfF3hvaCV6/m2JME7d2iHPg3rz9SKYRF4bBoYi5f8mIuFYaPxIy5G6i0RiQB3srvklZa3ODApG8qAPw2caQ1d9OYK10LfMVt7/6ZwvvnF02MfC0Gnac7MctzHJHUR5FcqFDloHKnMJ5YLegP5rTM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:KL1P15301MB0087;
x-ms-traffictypediagnostic: KL1P15301MB0087:
x-microsoft-antispam-prvs: <KL1P15301MB0087CA75D09BB471ED0F62AABFB40@KL1P15301MB0087.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501396)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:KL1P15301MB0087;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0087;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(396003)(39860400002)(39380400002)(366004)(54534003)(377424004)(51914003)(305945005)(10090500001)(7736002)(2900100001)(53936002)(107886003)(39060400002)(5660300001)(8676002)(4326008)(86612001)(74316002)(6246003)(229853002)(33656002)(10290500003)(478600001)(6116002)(8990500004)(6436002)(6916009)(9686003)(8936002)(3660700001)(7696005)(81166006)(54906003)(2906002)(76176011)(86362001)(55016002)(46003)(6506007)(316002)(14454004)(3280700002)(11346002)(186003)(77096007)(99286004)(22452003)(25786009)(446003)(5890100001)(476003)(102836004)(93886005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0087;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: J6ZzZWhpJbQfhMdfJlrYuTk26LFiC3lNkBMRkzOJr3hhMfBI/yZd8wq+U3VIrZRbYWGoTPJAXbZKOA0zIdnfEDt7aYQpGbNJdc5vAGpKx+6KKMQKqP6DrZbaIytpZKxosIfDUnLkYM4fxzMSy8kB0GsTVOJeFHIvuDgUw/pqFdyyeTD+m0/Eaaf+oTGsJpbH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 19b490c5-f3dc-4a88-244e-08d5a6e629d1
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b490c5-f3dc-4a88-244e-08d5a6e629d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 17:43:01.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0087
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Jan Kara <jack@suse.cz>
> Sent: Friday, April 20, 2018 03:22
> On Thu 19-04-18 21:37:25, Dexuan Cui wrote:
> > > From: Jan Kara
> > > Sent: Thursday, April 19, 2018 13:23
> > > Good news guys, Robert has just spotted a bug which looks like what I=
'd
> > > expect can cause your lockups / crashes. I've merged his patch to my =
tree
> > > and will push it to Linus for -rc3 so eventually it should land in
> > > appropriate stable trees as well. If you are too eager to test it out=
, it
> > > is attached for you to try.
> > >
> > > Jan Kara
> >
> > The patch's changelog says "... this behavior results in a kernel panic=
."
> > This sounds like a reference to corrupt memory causes a page fault or
> > general protection fault.
> >
> > But what I saw is only a lockup rather than a kernel panic:
> > watchdog: BUG: soft lockup - CPU#10 stuck for 22s! [java:87260]"
> >
> > So I guess what I saw can be a different unresolved issue?
>=20
> Actually I don't think so. The list iteration simply went through stray
> pointer. That can crash but it can also end in an infinite loop, or it ca=
n
> just randomly corrupt memory. I've seen all these situations with similar
> problems. So the fix is definitely worth trying.
>=20
> Jan Kara

Thanks for the explanation! It sounds promising!

We haven't been able to reproduce the issue by ourselves.
If our customer still keeps the setup to reproduce the issue, we'll try to
test the patch.=20

-- Dexuan
=20
