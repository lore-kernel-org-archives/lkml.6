Return-Path: <Alexander.Levin@microsoft.com>
X-Cyrus-Session-Id: sloti22d1t05-2505978-1525352579-2-3745550367901598566
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='104.47.37.112',
  Host='mail-cys01nam02on0112.outbound.protection.outlook.com',
  Country='US', FromHeader='com', MailFrom='com', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Alexander.Levin@microsoft.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525352578; b=DZJGGvrIcZNr02/Q43TT4Ci1bU+sy4w0rA9lnXxUYb2PQHVq7j
    5EmJr7+r5Abu5VOv3rVceIiEjns3/eWKzfiv/K9Im5h2fXytXC2mdD28oOj7ZwHx
    O507S+pTXdTGG++qnFuqcnknbtWC+TaNvRfhRK6aJ7mj1tFW925Bn420yt5I8Jdn
    Dn2d1vUzsXlHhBa3MrFPKK8vdPffnQXeqiydCDrX7kd3rKdeC1vBgbTGRIh+aPmw
    YMQHcvduXmKylIrM+sYxJNoT6nIYWRQfW5c6BihO42J2QujgXdNoDF1rxaBKmo8g
    JQOHhbEJH+ArdEGiVUs75KVzEla1Gf7TT15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=fm2; t=1525352578;
    bh=LAxO+Ad1bgVZmHpFSClVfxmTsNregH3duMi3+4JPP6k=; b=EgWn1bPXe5Qw
    DCEddTc/Foo6Ot/F84P+UkptbcMYGY5JkGCuEzltvboGC8qVtz+9E1TYZHbSB5B7
    Fx/0jJ6aQkghQPZCqnuse3cl5GaKr6enlJc87N58W5bmkQGrCj7/f5crtT9Ym3F1
    o1TSJDCuAaWHZK0QAJf/OPm+03UTmpofkO+UEARieZy6G6ryIojLCDsTK1095bV1
    3fKHAgfId0Snrchy7tVBix6AwVzuRxFtkSdaf8vMUi+J0N64hNO1rLMf1qN14VWs
    QtEsBuHpOpJ42z7RqvB+zQzFJ+4kK4AUaMrKBLi30aLr0g08eTu3rp+KlAU+RL6+
    t6a5Uk2Y0g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com
    header.i=@microsoft.com header.b=bi37lIrC x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.37.112
    (mail-cys01nam02on0112.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com
    smtp.helo=NAM02-CY1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM02-CY1-obe.outbound.protection.outlook.com
    x-ptr-lookup=mail-cys01nam02on0112.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com
      header.i=@microsoft.com header.b=bi37lIrC x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.37.112
      (mail-cys01nam02on0112.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com
      smtp.helo=NAM02-CY1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM02-CY1-obe.outbound.protection.outlook.com
      x-ptr-lookup=mail-cys01nam02on0112.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM4rhclj9Y7q13klIWP/a9n3WjKu4KMKTBK8lLeHg7Ikyqkw6+hRMepRq+Fun23btulj353bF4VCKdAPPTCG3rAn2NfKuWrgjvgOh9hwaBByW3NgALK/
    0xc5h4lnyUZ0FUnvmQUOuNEYwNV18Fkcj/MfTKwZxDMWSQ8YonC5KRnS31x+gmuQ9t6LbcED/YpzrpePmw5BNHMYXYl1T57jIBT7ZrjF423U3WNQCMqnoB91
    iXwtqUtYiAEBREcKwvp3Lw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=udvMCkCjW9z/lAnn2xPK/w==:117
    a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10 a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=kClDuHN0n2msv_DL5PAA:9
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Jiri Kosina <jikos@kernel.org>, Michal Hocko <mhocko@kernel.org>, Greg KH
	<greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAA4zgIAAAxqAgAAynoCAAAVdgIAAAfQAgAAJ3ICAAALKAIAA3PcAgAAHvICAADGIAIAACO2AgAAFT4CAAA/sAIAAA+aAgBjAOoCAADHBAA==
Date: Thu, 3 May 2018 13:02:52 +0000
Message-ID: <20180503130246.GF18390@sasha-vm>
References: <20180416211845.GP2341@sasha-vm>
 <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
 <20180417103936.GC8445@kroah.com> <20180417110717.GB17484@dhcp22.suse.cz>
 <20180417140434.GU2341@sasha-vm> <20180417143631.GI17484@dhcp22.suse.cz>
 <20180417145531.GW2341@sasha-vm>
 <nycvar.YFH.7.76.1804171742450.28129@cbobk.fhfr.pm>
 <20180417160627.GX2341@sasha-vm> <20180503100441.GE32180@amd>
In-Reply-To: <20180503100441.GE32180@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0905;7:JJBhFuYst1ZMOoJ5cPcj2wnQ7ZMHx0HMTr+aKba0J7ldjuE2+GIlFKwFCsyC1qjyyML36ecLiSQU9+C5tejiFZ0560niTzNvg09Tl495qdujgTVpjLFNLbQUmJueD3troPYn9jlvoz2RAMrW+z007ry0K1HoodzPJVKAMF9GT40oJu/qmCAB02q8fnxhxo3ya32wg4sqv6oTvGcz5sWZFKoCPFsdsdcK3MNwlgM6ZjTUZ2ni5V+vFrB33AkrfSmC;20:X9+SyWABRYpcA9HYv1iAcavihDglXoF67mJIqlFuGmd2/HX6GbdnUb6ZXSmggSOlFOsuV8qcPrJ1iTUQCItj4S8XkQhNVLxZ0Uq2VdUChxM5ndLBbKCtKNnCatRNzjhRU0s14xeWGGLitFkio4oXYOhCOjtE/DszgHqTj3dCiK4=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB0905;
x-ms-traffictypediagnostic: MW2PR2101MB0905:
x-microsoft-antispam-prvs: <MW2PR2101MB09054344FD5ABC542A3993A0FB870@MW2PR2101MB0905.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MW2PR2101MB0905;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0905;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(366004)(396003)(39860400002)(39380400002)(376002)(377424004)(189003)(199004)(11346002)(305945005)(54906003)(476003)(3660700001)(86362001)(81156014)(22452003)(6486002)(7736002)(33656002)(33716001)(76176011)(2906002)(486006)(26005)(446003)(316002)(81166006)(99286004)(3846002)(106356001)(59450400001)(7416002)(6116002)(8936002)(93886005)(8676002)(6506007)(102836004)(3280700002)(6346003)(186003)(10290500003)(53936002)(2900100001)(6916009)(4326008)(86612001)(68736007)(5250100002)(6246003)(97736004)(39060400002)(10090500001)(72206003)(33896004)(478600001)(1076002)(5660300001)(14454004)(105586002)(6512007)(6436002)(25786009)(229853002)(66066001)(9686003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0905;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 4WLufsakdENrhqwfOQCnGLi6+RqXDruGrtCPuTZVB3BJe9LCLyzUCxvKYwprPsF+uma/gzS9gZdp5HsHVK6FJ7GQhWJmq/8AC0gHlZgNd/h/svIzEkF1Vk8+7n+dzfJjmmbQdCsOMDCn+STj+c7VtXngUWYEkhyZQ9qf6RzCVL5cf1AplhGPVwLnYH34qknC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E6010D53D94404FBD8E0CB0E73B6235@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0ef682f3-b79d-4b7a-7f79-08d5b0f62e30
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef682f3-b79d-4b7a-7f79-08d5b0f62e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 13:02:52.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0905
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 12:04:41PM +0200, Pavel Machek wrote:
>On Tue 2018-04-17 16:06:29, Sasha Levin wrote:
>> On Tue, Apr 17, 2018 at 05:52:30PM +0200, Jiri Kosina wrote:
>> >On Tue, 17 Apr 2018, Sasha Levin wrote:
>> >
>> >> How do I get the XFS folks to send their stuff to -stable? (we have
>> >> quite a few customers who use XFS)
>> >
>> >If XFS (or *any* other subsystem) doesn't have enough manpower of upstr=
eam
>> >maintainers to deal with stable, we just have to accept that and find a=
n
>> >answer to that.
>>
>> This is exactly what I'm doing. Many subsystems don't have enough
>> manpower to deal with -stable, so I'm trying to help.
>
>...and the torrent of spams from the AUTOSEL subsystem actually makes
>that worse.
>
>And when you are told particular fix to LEDs is not that important
>after all, you start arguing about nuclear power plants (without
>really knowing how critical subsystems work).

Obviously your knowledge far surpasses mine.

>If you want cooperation with maintainers to work, the rules need to be
>clear, first. They are documented, so follow them. If you think rules
>are wrong, lets talk about changing the rules; but arguing "every bug
>is important because someone may be hitting it" is not ok.

I'm sorry but you're just unfamiliar with the process. I'd point out
that all my AUTOSEL commits go through Greg, who wrote the rules, and
accepts my patches.

The rules are there as a guideline to allow us to not take certain
patches, they're not there as a strict set of rules we must follow at
all times.=
