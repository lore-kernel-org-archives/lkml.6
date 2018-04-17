Return-Path: <Alexander.Levin@microsoft.com>
X-Cyrus-Session-Id: sloti22d1t05-2214042-1523981197-5-13122660707461869014
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='104.47.34.132',
  Host='mail-by2nam01on0132.outbound.protection.outlook.com', Country='US',
  FromHeader='com', MailFrom='com', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Alexander.Levin@microsoft.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981196; b=m0MWS1q73LXBYjEMoBFXG16912J5jbFDmZBMk4DrwwZQdIW+sZ
    5O9RAK/QbxNMokwjq17uRkVmrx0N30UKsXUTXpwno9eBLqZfr6bW2oFQl2pw/2qv
    fYuIA86FH8029/GWwF1TBuvBH349psvtp1dRMcN8ZxijE0q1wnOiAvpBESEkZhRs
    1eOzfcj3JLux1Q2zuJ4GD8RxZ+GW3i5uqFQdN3jls4X11u7gHuYUVMMqNl3eisQF
    HWOFZJTz7aBIwazJFXxvGJpXei7UkoDW6OYV1MPi3ZvusqjsvbUKAh8E/ba5oznn
    gTkZ+ycK9I/MTI2S/jyCVWksamzPqA9Rd5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=fm2; t=1523981196;
    bh=K2u8dybJVF8OKuvXeolXcl0lLhBrlkLbccixtN/b76w=; b=A4W8QHh/VqPJ
    d+j6UV2HeHgzK0cTmuXLcNPkLIk4qy0sAY3v/c+BS2XkSVmIG8N6hbUCV+htA7A3
    tl5QzpdCZQdWPA3DfP/qHEONy+ueW2a/9X8s4Y5ZHTGUOHHBicaH0rk7hJsAPdwQ
    8MId7CTtALKJMszBU80YSq++cfdS1n0THTsU/vM5+bEjImeGzdVmWCeXfHUT1mp2
    qEz//C5B9kcosisPa/bKOmHZpSyGgDHHJWaPfW83oo9iSrXNqyouIGqwn8Fnmoht
    DsPRFOH/AN26tE3KMoI+mYKG+pD1etBvBny6ev76LSAys0hNfe4aPe6Ce6UR4v6G
    itXQvgTRpQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f3wVhpQN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.34.132 (mail-by2nam01on0132.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM01-BY2-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM01-BY2-obe.outbound.protection.outlook.com x-ptr-lookup=mail-by2nam01on0132.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f3wVhpQN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.34.132 (mail-by2nam01on0132.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM01-BY2-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM01-BY2-obe.outbound.protection.outlook.com x-ptr-lookup=mail-by2nam01on0132.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIrMhzdasBzuAafSxPzFeLe3zVLHhDxX/EIRHE3cdQJQteWRmCPTL+k8kCQ9869NrwkRp3AJkrmizIHwg4gLI2Ge97No4HdOKxGvdfN2UffAKlNhbOfn
    p5LT87Up8tn8fQmswvoKGXBFGhdQ1tP6wDrk4usllQIKkKVZ9tvNrevDYLHTGXRa5IXWq8MkBKin6g1O2DYg1rBEQvlIZB6h1yy30RfuaztLcgUD63f2To9j
    uRDWYJNmcULjtwdePWB+VA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=2wdq1CsefauVh77NmnHuBw==:117
    a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10 a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=IONl5P_BQFjyhRKIYAwA:9
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Jiri Kosina <jikos@kernel.org>
CC: Michal Hocko <mhocko@kernel.org>, Greg KH <greg@kroah.com>, Pavel Machek
	<pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Steven
 Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, Cong Wang <xiyou.wangcong@gmail.com>, Dave Hansen
	<dave.hansen@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman
	<mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Peter Zijlstra
	<peterz@infradead.org>, Jan Kara <jack@suse.cz>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Tetsuo Handa
	<penguin-kernel@i-love.sakura.ne.jp>, Byungchul Park
	<byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAA4zgIAAAxqAgAAynoCAAAVdgIAAAfQAgAAJ3ICAAALKAIAA3PcAgAAHvICAADGIAIAACO2AgAAFT4CAAA/sAIAAA+aA
Date: Tue, 17 Apr 2018 16:06:29 +0000
Message-ID: <20180417160627.GX2341@sasha-vm>
References: <20180416203629.GO2341@sasha-vm>
 <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
 <20180416211845.GP2341@sasha-vm>
 <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
 <20180417103936.GC8445@kroah.com> <20180417110717.GB17484@dhcp22.suse.cz>
 <20180417140434.GU2341@sasha-vm> <20180417143631.GI17484@dhcp22.suse.cz>
 <20180417145531.GW2341@sasha-vm>
 <nycvar.YFH.7.76.1804171742450.28129@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1804171742450.28129@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;7:RAu/nLKwWMIghYu/yOl29Rr411VM5h4jaVXGlJjappeM1tEyTNN6WDfIDvjgVeQa1NwFUG3gga3xclxk8P05h1Vvo0vsTi7g5/oGw7aBodNKdmqEVKekbEWpWkSBvwNUpmnsho1OjfolLwuEOBg/SlrdQcmteuSAeP5aZjPnQgKGgY5Ibj46aCFHgHJQNoITRrsatfVfT+q3DCRxYh+faKlzQsceAK1jKde/few1DGSMx7DFSQHAHDMovrxnvrqC;20:rNP2awZXHkCL/Qz6SpCpWW4/fyTDmydWTU/eY4Rnqg6TvkTPGwKASLaa2gRI4pQeEz/kIVDDK9d4rAyUWy5y1nFizKG8ceM7KSUVS6LwkmzSYPKefZ2bJMGHOig1ydOHItCq0aka4YfbEzrRpG6i+Q/pPUQHIa/d8qL5I5sohkk=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0808AD250F1846B79A8E0E5BFBB70@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501359)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39860400002)(376002)(39380400002)(346002)(396003)(199004)(189003)(316002)(6436002)(54906003)(33656002)(14454004)(6246003)(93886005)(86362001)(86612001)(72206003)(39060400002)(22452003)(10290500003)(25786009)(105586002)(4326008)(6486002)(66066001)(6512007)(106356001)(8936002)(9686003)(68736007)(2900100001)(10090500001)(81166006)(8676002)(478600001)(53936002)(81156014)(3660700001)(6916009)(3280700002)(2906002)(229853002)(102836004)(1076002)(5250100002)(186003)(97736004)(486006)(26005)(7736002)(11346002)(446003)(33716001)(305945005)(99286004)(7416002)(5660300001)(6116002)(59450400001)(3846002)(76176011)(33896004)(6506007)(476003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dBX4yJjgo4K5Q281FX1ql5HtXSE8jgzDBZXgSM6ctniU0o/DXksDq44oUBtmWThHLTx1GEt4mAE4suVX+LTdWS9uJ5PZKwxlKi8FXwdYBpmPKrzYfUCC3DKXzzOIl9/HtvOi66hNJoCk8rFbG57A7QKxb0sYZA8Syy/2oINe2C7Ul4MOF9Cnf3RZsVowkmkA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DBF7BC322379548A28EE157D5D0E93D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8aba46c6-3a0d-48db-fe28-08d5a47d2e9d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aba46c6-3a0d-48db-fe28-08d5a47d2e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 16:06:30.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 05:52:30PM +0200, Jiri Kosina wrote:
>On Tue, 17 Apr 2018, Sasha Levin wrote:
>
>> How do I get the XFS folks to send their stuff to -stable? (we have
>> quite a few customers who use XFS)
>
>If XFS (or *any* other subsystem) doesn't have enough manpower of upstream
>maintainers to deal with stable, we just have to accept that and find an
>answer to that.

This is exactly what I'm doing. Many subsystems don't have enough
manpower to deal with -stable, so I'm trying to help.

>If XFS folks claim that they don't have enough mental capacity to
>create/verify XFS backports, I totally don't see how any kind of AI would
>have.

Because creating backports is not all about mental capacity!

A lot of time gets wasted on going through the list of commits,
backporting each of those commits into every -stable tree we have,
building it, running tests, etc.

So it's not all about pure mental capacity, but more about the time
per-patch it takes to get -stable done.

If I can cut down on that, by suggesting a list of commits, doing builds
and tests, what's the problem?

>If your business relies on XFS (and so does ours, BTW) or any other
>subsystem that doesn't have enough manpower to care for stable, the proper
>solution (and contribution) would be just bringing more people into the
>XFS community.

Microsoft's business relies on quite a few kernel subsystems. While we
try to bring more people in the kernel (we're hiring!), as you might
know it's not easy getting kernel folks.

So just "get more people" isn't a good solution. It doesn't scale
either.

>To put it simply -- I don't think the simple lack of actual human
>brainpower can be reasonably resolved in other way than bringing more of
>it in.
>
>Thanks,
>
>--=20
>Jiri Kosina
>SUSE Labs
>=
