Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2510764-1520532956-2-2433988930402478861
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
    t=1520532955; b=Rgmn6n+VdrtUjJ1+mQ6igDdJUKXIElqh+foqjMSFJhiY8GO
    +MYni/JKns0Ci7uU5dlKAr5cST78wKXAAXq8t9QUbg4tee4QrOMMO1eiIl2roRxH
    16c2hBJFSMDk+ymForJLyyspsK96zUAkWfllYrdrNYZ7TIWEJE5OfgXGGR1qH9bT
    XSjKmo06C2H6A/2F5fJRXgfAPKaQioGLbr27GpGDFehBzs0GnYbr1ErlYXdFL85l
    FnjhBQCsXjbePTxtgsTbcoost6roMxpqwyiaP8f44RqcaTgfOh1d254cZUTkd8Hh
    QCYrW6XMS1FQlm/JtK1YzeAvJYQhPzucitRD1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520532955; bh=tc+iZFdgpl707yobMcTX+Q+Nab0mDKYheXfppE
    MD2sM=; b=DtaCn+pBsdadyj5W8Y89Hmq57u2lVq5RknE2DGFeFfLNQAn8Ls8naS
    U41EyR5enRU+qUEMnWYN/32cVXaTNtk9gRftI4bop0LmGnzjWnIRpGYbxY2wDqf/
    VP2qjbuETLLNiEWxhUC45hFs/NreOO6vQ0JOyudyaLkxQppzM2OIGmgXAOt+J6Lv
    A/LMaCAsEjBVr4uJZY161Y7XWAz5Kt/OAu3iIAREA5x03JIR80ptOxwDNzJVo6pn
    WXbvI8XNQIrsW24lmUR1t042NOdyh7qoUkeRiSrIuzWuFgvRnZ2csHdHRuxw9xCW
    0N4MlMsPAeS0VoZgtLiec7Gc2HpxLinw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QIoxQI3r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QIoxQI3r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeCHSPb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 13:15:31 -0500
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:29824
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752023AbeCHSP3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 13:15:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Darren Hart <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Santeri Toivonen <santeri.toivonen@vatsul.com>
Subject: Re: [PATCH AUTOSEL for 4.9 025/190] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Thread-Topic: [PATCH AUTOSEL for 4.9 025/190] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Thread-Index: AQHTtposmBik9FB2uEeSwWb0rNBdXaPGm4sAgAACbACAAAexAA==
Date: Thu, 8 Mar 2018 18:15:27 +0000
Message-ID: <20180308181526.glcmj32nmu6c2hqk@sasha-lappy>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
 <20180308045810.8041-25-alexander.levin@microsoft.com>
 <20180308173914.GC11045@localhost.localdomain>
 <20180308174754.GA28545@kroah.com>
In-Reply-To: <20180308174754.GA28545@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:ZLfaDy7kc8CFw/Iiv4ZmKksZ3Wf7THEeHRCf6HGgeW0RENb7XGZhB9jh44p2aWSslcnjeryNRPidikgWTrkrqjTlGrxML4DDyyMtgUWnifs1g6YTKzyPJ1BMoMEDCl03N3cjjlO/3t8J8orG+zgiOCJwBmxK/xis7vD4QdAQkHkSsVo8Al2MEb6J4LCaoSHQWzgBakQTC9gvVwkQsshDb+A7pPBpz8vsFdvD/p/bz69vI6pAmBggXUPU0bVYTCTW;20:RUTJnwEEq0zhzJqi9iiULEZdY2kWHN/oK9MGiTJYwxX1OPQ85qTLIx5cfhvynhsZA/06vTaXSGsjd0ItSoTMqd9D/F1o9HZarv/hm0q4iW/5BSEB6wLBso6H0sw9/XKg/RPxxe74MNE5RrBtuIfwrVaN6wAre2DDZCYgndkGc0s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ecbcd42-7283-4528-dcd0-08d5852091e1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10451D50804A390D3EF280E2FBDF0@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(396003)(376002)(366004)(39380400002)(39860400002)(189003)(199004)(6246003)(102836004)(1076002)(93886005)(72206003)(478600001)(6512007)(5250100002)(186003)(9686003)(99286004)(14454004)(86362001)(97736004)(22452003)(68736007)(6436002)(2906002)(33896004)(86612001)(10290500003)(6486002)(54906003)(316002)(76176011)(81166006)(81156014)(8676002)(4326008)(6506007)(66066001)(229853002)(2900100001)(25786009)(6916009)(106356001)(2950100002)(33716001)(3846002)(53936002)(105586002)(6116002)(5660300001)(10090500001)(3660700001)(3280700002)(7736002)(8936002)(26005)(59450400001)(305945005)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: KTZozZHW8Zl2qVVzKJb0myq7E4jGeDHJGtEJ+vw/+oF1Ui53I38NGu3mreN3gEfnbMjHjyZz7/EEEDhgje9tyF2jpZ8f4QMG5b7q/3x2LE+3GNnHlpcXn5hKly8r8gVgG/Dsz+PniwwzVj0yX0mVmgpKRhb2W1VFHo9MOzGVTdzny29srNxw3s4PIlYvAxzq7fMRESSVdCvyPSl2h6nmHxTmlXpz7jJrxG3VGgSNz7Vdi8/JHIFRkJibpEUtSl4pAJ82je01OFJuDElLJyy6FInaqj3dfu/bLPn0GNOqeScwyx0ygIHzKf/RuM2sMzl3nDiU3YRuAophcSUX1mY17A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E23889B78619F04497975BBE0F0BE9C1@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecbcd42-7283-4528-dcd0-08d5852091e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 18:15:27.4388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 09:47:54AM -0800, Greg KH wrote:
>On Thu, Mar 08, 2018 at 09:39:14AM -0800, Darren Hart wrote:
>> On Thu, Mar 08, 2018 at 04:59:01AM +0000, Sasha Levin wrote:
>> > From: Santeri Toivonen <santeri.toivonen@vatsul.com>
>> >
>> > [ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]
>> >
>> > Asus laptop X302UA starts up with Wi-Fi disabled,
>> > without a way to enable it. Set wapf=3D4 to fix the problem.
>> >
>> > Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
>> > Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
>> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>
>> Hi Sasha,
>>
>> I'm curious about this AUTOSEL tag, and what about this patch triggered
>> its selection?
>
>It's "magic"!  :)
>
>Seriously, it's close to magic, there's a tool that Sasha is using that
>takes "machine learning" to match patches that we have not applied in
>stable kernels to ones that we have, and try to catch those that we
>forgot to tag for the stable tree.  Not all subsystems mark stable
>patches, so this is an attempt to catch those fixes that should be
>getting backported but are not either because the developer/maintainer
>forgot to mark it as such, or because they just never mark those types
>of patches.
>
>Sasha has a better write up about how this all works somewhere, and
>given that this type of question keeps coming up every other week or so,
>I think I need to add it to a FAQ somewhere to point people at to make
>it more obvious what is happening.

It's pretty much a neural network that knows how to classify a "bug
fixing patch" based on things such as:

 - Code metrics
 - Words in the commit message (the NN knows about the 10,000 most used
   words, and their likehood to appear in a bug fixing patch).
 - Which files were modified.
 - Authors of the commit, and persons who got Cc'ed/Signed-off/etc.

So in this case, there are a few things that "helped" this patch get
selected:

 - The word "quirk" in the subject line.
 - "fix" + "problem" in the commit log.
 - Modifies drivers/platform/x86/asus-nb-wmi.c which contains mostly
   quirks.
 - The patch has minimal changes in code metrics. I don't have exact
   numbers for this, but it seems that in general patches that do very
little have more odds of fixing bugs.

And I also manually review all the stuff that get sent out, and to my
human brain it looks like something that should be in stable :)

--=20

Thanks,
Sasha=
