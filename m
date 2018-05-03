Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2569529-1525354108-2-4269595767387851818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525354107; b=U77GUSnCFcE6ug892qNVTLqXpCBMSSW2muDbEaCTM8tzMUcCCD
    0+6u0EUkv+VJNFj62vFOlHqgvXNn/YVcc4Q81gM/HcqiG+K6eUcxVt97CojN66v/
    nPFNbdwAkchOLpw8AzZRxM5BD85G+LwFHnEAB2sD5QcAGQrmf3Xswr9QXHaQ4HyZ
    rYrVREb+rs7t04GTaYPIY+5mxhDhp/1dsli6seoy0ELlpFZ11TyttQE5pt7EcpWI
    JYrWDtuvug4hP9OoSvrjHqSWiHEC36AURQuhV/L0iH8LTA3U/VdlTPXBQUPFX5CK
    W27XqEw3fBftwkgW8pCa5KnFQrVnP5lWUcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525354107; bh=i5qeX2Yt3chNgboQzikYDxTyZNgsmswzOXx1rLOimgE=; b=
    KP1U38Z2FXF6M1Zc6Qarx1iwtzdKhfBfkS0vH9UyCLkUbpAIwZpwsNyTJqXTuZ2o
    IVGjPQXNgtbc2ZNruNTZMm+Qd+CwTqI75nu4enuewN/gaEqUz0suMAa+s/AKzMHE
    7T9wjVn6BlCbfpm66zqc5jGhbID3DFr+DXU8X9YjxPC6uMO/szh2AT+J/9Hae6Z0
    jrqWYX0+uncSG4KRsz1aGnS5mVjnyQ9/rRZiPFU7Q0jXhZeSOYNuL3dtB3KX+NFJ
    oGYAiebqLGe/pPs9iLokjx5loa2l6s8l6dXLUHg4RQX846XHttTKqkn4UpwpfV4m
    bdT3IwqkjyEAp38ixLEmTw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com
    header.i=@microsoft.com header.b=l5nOyVly x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com
      header.i=@microsoft.com header.b=l5nOyVly x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfANgtSQ80CamgBcEjtCHboKqPfENfPRb9H35FH6wyyTlUnKdiTGL12xZ8sHpSN73VMKXjm/ea2DXEVYAIKMr9at91E+2aqTpmhO5st+ywLzrgaPkjG/z
    PN3ZUA04tTrHRxYH+ryLTVGRtFOJd6zzp1ki1Qzxbwas08rYeE4C4qI24/HuIhAuCiV2Xwd2rasss+V0PTixKlbeup5IKrx5dvpk8R/uloopXYGqTTjFpZg6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=t7jK0ymkFd3tSvDWxrMA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeECN2K (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 09:28:10 -0400
Received: from mail-bl2nam02on0119.outbound.protection.outlook.com ([104.47.38.119]:57656
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750947AbeECN2J (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 3 May 2018 09:28:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAIAAAugAgAAB5YCAAAMcgIAAAh8AgAAH3gCAAATcgIABMtsAgAAewoCAACg7gIAABqKAgBi0yoCAAECVAA==
Date: Thu, 3 May 2018 13:28:04 +0000
Message-ID: <20180503132800.GH18390@sasha-vm>
References: <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home> <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd> <20180416172327.GK2341@sasha-vm>
 <20180417114144.ov27khlig5thqvyo@quack2.suse.cz>
 <20180417133149.GR2341@sasha-vm>
 <20180417155549.6lxmoiwnlwtwdgld@quack2.suse.cz>
 <20180417161933.GY2341@sasha-vm> <20180503093651.GC32180@amd>
In-Reply-To: <20180503093651.GC32180@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0905;7:aTj8rIJOIeQ2ClXOvsDT6oMS7ix5iRXAeA+k6+NwoPQUBGrNfbclIdTwwmRyl8C2OO3fRGHMqtfSBXM3gD60wu2RXpv34zko6vCUpzLfSaF4J7L/UL7lt06shIVoolESoKIcA2rKlvdhT4tcZS+w+greiSgxEuQy98RePCMJdjFL26J48LzFfHo4/H68IEbPu6b9IonV6Nv9G3RX+ZgZuZU6omxSDqag9/iiEwcqmqSHElPbDS0/TOBKRNxLAlrC;20:4OZR9bRyduSJLA86wC79dsYeN0GpPw0erXldvwyR1tknk0QmNXvvUAaAH4/La4FcTqvG5loKSL+n3r19SO1sgfsivX4lSdWuYFxcKOFC+ZtxUxfTITqnU4EDq/HKuRLGdlUnGoMZkupDmaMKL2q59W+49Uw65D7M3lqcJSIyTqM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB0905;
x-ms-traffictypediagnostic: MW2PR2101MB0905:
x-microsoft-antispam-prvs: <MW2PR2101MB0905B9575801CDB922C2750DFB870@MW2PR2101MB0905.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MW2PR2101MB0905;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0905;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39860400002)(396003)(39380400002)(346002)(366004)(189003)(199004)(52164004)(377424004)(86612001)(68736007)(5250100002)(53936002)(2900100001)(4326008)(6916009)(25786009)(229853002)(6436002)(6306002)(6512007)(14454004)(105586002)(66066001)(9686003)(478600001)(33896004)(97736004)(6246003)(39060400002)(72206003)(10090500001)(5660300001)(1076002)(486006)(2906002)(76176011)(81166006)(966005)(26005)(316002)(446003)(3660700001)(476003)(11346002)(305945005)(54906003)(22452003)(6486002)(33716001)(7736002)(33656002)(86362001)(575784001)(81156014)(6506007)(8676002)(102836004)(10290500003)(6346003)(186003)(3280700002)(7416002)(106356001)(59450400001)(93886005)(3846002)(99286004)(6116002)(8936002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0905;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: kF2W2GkH2yLihUPdr0xJt/d4y+xAAqrNrU2C5OAX5YSuwHs4/dvCGA3helj3Kc6iN+fNB3vvRJAJQ5Jl5mPZ0AH7lz57zw/u0Iuw7JC1+TwFWsdUart1dzlwnEhlRqwnhycbeS5Ng/M4e0eBU9JgfqBvF006+mxNNvuUHfo9JdH0Of1n+SZAp/nxv8KLshcW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <889546DA857A2243B0CBD37E2EF4F4DB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4dd53718-df56-413d-082b-08d5b0f9b3df
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd53718-df56-413d-082b-08d5b0f9b3df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 13:28:05.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0905
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 11:36:51AM +0200, Pavel Machek wrote:
>On Tue 2018-04-17 16:19:35, Sasha Levin wrote:
>> On Tue, Apr 17, 2018 at 05:55:49PM +0200, Jan Kara wrote:
>> >On Tue 17-04-18 13:31:51, Sasha Levin wrote:
>> >> We may be able to guesstimate the 'regression chance', but there's no
>> >> way we can guess the 'annoyance' once. There are so many different us=
e
>> >> cases that we just can't even guess how many people would get "annoye=
d"
>> >> by something.
>> >
>> >As a maintainer, I hope I have reasonable idea what are common use case=
s
>> >for my subsystem. Those I cater to when estimating 'annoyance'. Sure I =
don't
>> >know all of the use cases so people doing unusual stuff hit more bugs a=
nd
>> >have to report them to get fixes included in -stable. But for me this i=
s a
>> >preferable tradeoff over the risk of regression so this is the rule I u=
se
>> >when tagging for stable. Now I'm not a -stable maintainer and I fully a=
gree
>> >with "those who do the work decide" principle so pick whatever patches =
you
>> >think are appropriate, I just wanted explain why I don't think more pat=
ches
>> >in stable are necessarily good.
>>
>> The AUTOSEL story is different for subsystems that don't do -stable, and
>> subsystems that are actually doing the work (like yourself).
>>
>> I'm not trying to override active maintainers, I'm trying to help them
>> make decisions.
>
>Ok, cool. Can you exclude LED subsystem, Hibernation and Nokia N900
>stuff from autosel work?

Curiousity got me, and I had to see what these subsystems do as far as
stable commits:

$ git log --oneline --grep 'stable@vger' --since=3D"01-01-2016" kernel/powe=
r drivers/leds drivers/media/i2c/et8ek8 drivers/media/i2c/ad5820.c arch/x86=
/kernel/acpi/ | wc -l
7

Which got me a bit surprised: maybe indeed leds is mostly fine, but
hibernation is definitely tricky, I've been stung by it a few times...

So why not pick something an actual user reported, and see how that was
dealt with?

Googling first showed this:

	https://bugzilla.kernel.org/show_bug.cgi?id=3D97201

Which was fixed by:

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Dbdbc98abb3aa323f6323b11db39c740e6f8fc5b1

But that's not in any -stable tree. Hmm.. ok..

Next one on google was:

	https://bugzilla.kernel.org/show_bug.cgi?id=3D117971

Which, in turn, was fixed by:

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D5b3f249c94ce1f46bacd9814385b0ee2d1ae52f3

Oh look at that, it's not in -stable either...

So seeing how you have concerns with my selection of -stable commits,
maybe you could explain to me why these commits didn't end up in
-stable?=
