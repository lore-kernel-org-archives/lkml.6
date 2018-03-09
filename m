Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-951107-1520613478-2-9793738939943717363
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
    t=1520613478; b=n82NUfZeF7jZ2NP2VNqbdboe5Rc6yr/WZNPTXb5YGUvj4Vm
    7k4dEL6/jCCFnFLQ+znY0MnQdLetLJnoAOwgmxQO4oCMT5d9T6edoM9ey9qbZDhk
    LHnrmV18/hqKHcEaowk3uMy+6v1F3BH+Uc4LhpLTBILzjZ103vI+2og1LS9FRBrJ
    3l1m1cJrrtXZHtU8BtVt2aKT7+X5HVPJQrAizTS4DvIOUGPwTWTMTJ8hYbDV5j4L
    zBgNKLdR2Y1YZbmO8kwoTIL7ERAGrWXnVY80zWaMXE2pZkp409CrZ+elmhn5cUog
    nBloFouBduuGN7zDh84eKhefOFxSFz4wW1IpBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520613478; bh=MCOGOtSkIyZvwSMdvAtO7fFRy6aW2Sjn2oKhyu
    HbNRI=; b=IEVui4qs6YP6KH4Kx9T9hYJthrHyzmtUBBPXX73brX1Bfp1hhRwi4k
    MhSuWUKFO/PtQrkMjSiYL/vKEtZdqdSu7549KUkMCUYEdtjvzGgA6EEhOUBPwyOK
    6YQI0ZBI7ZzKUHhc2Xu1k+6CvF4cDzGwh6ZLx3CcpSZUCKVBDMkhPZsQNdj/BWxB
    Vmx5fyhWBMLXdSj6xnZXYiUnxjqS3gZBD9rP9oK26sMdIleJhPiDpmnI72FnsaLo
    1cjXXhkUIWjNoyHJebFZcm3Ww+Ws2UWOhs40hQngJBf5MH8+LRcZChqubrCJ19T+
    AKzlvfMsafPmBz046rVw5mZ6fUIOT3nQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lMvLxoW0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lMvLxoW0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932072AbeCIQho (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 11:37:44 -0500
Received: from mail-bn3nam01on0133.outbound.protection.outlook.com ([104.47.33.133]:64256
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932075AbeCIQhm (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 11:37:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Darren Hart <dvhart@infradead.org>
CC: Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Santeri Toivonen <santeri.toivonen@vatsul.com>
Subject: Re: [PATCH AUTOSEL for 4.9 025/190] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Thread-Topic: [PATCH AUTOSEL for 4.9 025/190] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Thread-Index: AQHTtposmBik9FB2uEeSwWb0rNBdXaPGm4sAgAACbACAAAexAIAABiCAgAFw4gA=
Date: Fri, 9 Mar 2018 16:37:40 +0000
Message-ID: <20180309163738.cxddga5qzwm4n3bz@sasha-lappy>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
 <20180308045810.8041-25-alexander.levin@microsoft.com>
 <20180308173914.GC11045@localhost.localdomain>
 <20180308174754.GA28545@kroah.com>
 <20180308181526.glcmj32nmu6c2hqk@sasha-lappy>
 <20180308183721.GD11045@localhost.localdomain>
In-Reply-To: <20180308183721.GD11045@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:j+vnTEaXxHLjwxVEHGkRcBBFSkQNZOnFKAOuIht4b62oCuOWA5MzT67NqIVIUQryn1Ms54lEBKUzkAO/aeISHbwLNxnaq8wxUcPPdMA0H7CcpQXnsUjDxUKGdeAo+jZ82ROZ+RMYnboeuWahiqWU2JMbBDMsdAq/aPE1ZmkaQP/8BOuf50k+qI+fa/dNELuuliWO75MXu7eM/YAYCp1gxMnCNw3w5HmKE7p4wq/aKcWC4kwaHa3emJY3KVNIpLO1;20:I//S+9btXx4uQEzHD7q/18VuFGoW48Q3FIO3hA9SenMUJnaKpc6gSHq7X2fdJOjibPXlceNaxDEk+E4U5dugfvC1p5Oj/Om+iDkAvFRf5f2QcFGy7U+lgk9ECyZy8euk8al5fYAuM7AKnDL5/HfemoeHuQW1bREkxMRZFtIzlvY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2de8c04e-74f1-4506-2858-08d585dc1337
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0982C3F252C714D649C2FB51FBDE0@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501255)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(39380400002)(396003)(366004)(346002)(189003)(199004)(51914003)(25786009)(33896004)(81156014)(81166006)(86612001)(22452003)(68736007)(8676002)(316002)(8936002)(5250100002)(72206003)(7736002)(5660300001)(106356001)(2900100001)(305945005)(2950100002)(6916009)(6436002)(6486002)(4326008)(10090500001)(6506007)(6246003)(102836004)(14454004)(105586002)(229853002)(186003)(10290500003)(26005)(93886005)(478600001)(53936002)(6512007)(3660700001)(2906002)(9686003)(97736004)(86362001)(99286004)(66066001)(3846002)(6116002)(1076002)(76176011)(3280700002)(54906003)(33716001)(59450400001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sLOa3I/iQglXvs5PxQlcndE4gmZfJ79uIt0NJu0MQCbLuHKZzVM9NkONeGhDse600EkAVUcr9fwhz0jmHqSu92lIAb/ydAmPV6HDwe1qA75ZlUNmZY+GN/CzSppkye88zlOtXjDHvVKsE0gtT9TC1xPxplvsNOa/xlS2qvsA6XGoWmyHc/faNbQWxqQvTIrsyscnMLXHsxGe/y46J7ZEbvt7oKmIYhT91EbgBFKFym0zw7W62E82GnOQc2O3dnneHCgLkIiMttqhaBJ2RFfacF5GyHwoPpaJbqc7GKSO7+E04VmjdWWFoI3yA35PyWALbyqe4YPrYHeD98i520cAsg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E76D3355615D4A43881808DE0EA32BB5@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de8c04e-74f1-4506-2858-08d585dc1337
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 16:37:40.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 10:37:21AM -0800, Darren Hart wrote:
>On Thu, Mar 08, 2018 at 06:15:27PM +0000, Sasha Levin wrote:
>> On Thu, Mar 08, 2018 at 09:47:54AM -0800, Greg KH wrote:
>> >On Thu, Mar 08, 2018 at 09:39:14AM -0800, Darren Hart wrote:
>> >> On Thu, Mar 08, 2018 at 04:59:01AM +0000, Sasha Levin wrote:
>> >> > From: Santeri Toivonen <santeri.toivonen@vatsul.com>
>> >> >
>> >> > [ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]
>> >> >
>> >> > Asus laptop X302UA starts up with Wi-Fi disabled,
>> >> > without a way to enable it. Set wapf=3D4 to fix the problem.
>> >> >
>> >> > Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
>> >> > Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
>> >> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> >>
>> >> Hi Sasha,
>> >>
>> >> I'm curious about this AUTOSEL tag, and what about this patch trigger=
ed
>> >> its selection?
>> >
>> >It's "magic"!  :)
>> >
>> >Seriously, it's close to magic, there's a tool that Sasha is using that
>> >takes "machine learning" to match patches that we have not applied in
>> >stable kernels to ones that we have, and try to catch those that we
>> >forgot to tag for the stable tree.  Not all subsystems mark stable
>> >patches, so this is an attempt to catch those fixes that should be
>> >getting backported but are not either because the developer/maintainer
>> >forgot to mark it as such, or because they just never mark those types
>> >of patches.
>> >
>> >Sasha has a better write up about how this all works somewhere, and
>> >given that this type of question keeps coming up every other week or so=
,
>> >I think I need to add it to a FAQ somewhere to point people at to make
>> >it more obvious what is happening.
>>
>> It's pretty much a neural network that knows how to classify a "bug
>> fixing patch" based on things such as:
>>
>>  - Code metrics
>>  - Words in the commit message (the NN knows about the 10,000 most used
>>    words, and their likehood to appear in a bug fixing patch).
>>  - Which files were modified.
>>  - Authors of the commit, and persons who got Cc'ed/Signed-off/etc.
>>
>> So in this case, there are a few things that "helped" this patch get
>> selected:
>>
>>  - The word "quirk" in the subject line.
>>  - "fix" + "problem" in the commit log.
>>  - Modifies drivers/platform/x86/asus-nb-wmi.c which contains mostly
>>    quirks.
>>  - The patch has minimal changes in code metrics. I don't have exact
>>    numbers for this, but it seems that in general patches that do very
>> little have more odds of fixing bugs.
>>
>> And I also manually review all the stuff that get sent out, and to my
>> human brain it looks like something that should be in stable :)
>
>This is really cool to see, thanks for the effort here. Good place for the
>application of AI/ML.
>
>Have you considered having this work on patches submitted? If the machine =
could
>respond to patches that don't have stable or fixes tags that it thinks sho=
uld,
>we could address this a bit earlier in the process, and perhaps get a more
>consistent labeling, as well as get the maintainer eyes on this, reducing =
the
>amount of manual auditing you have to do.

Yup, there are a few ideas on how to get this done earlier in the
process such as integration with checkpatch and a mail bot a-la 0day.

Right now it's still in the experimentation phase, I'm trying to improve
the results based on review feedback I get from maintainers/authors.

A good example of the above was that the NN was very keen on including
commits that added devicetree bindings since those usually happen with
hardware enablement which usually goes in stable. The issue was that
sometimes the code for the hardware didn't exist back in older stable
trees, and building the kernel wouldn't catch this error, so it's one of
the things I'm hoping to deal with before it goes too public.

--=20

Thanks,
Sasha=
