Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523803377-2-16315547403677721290
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
    1523803377; b=gKPh2nSV3oqaPDmGm0Dyb/hgO78elsjU1fjuysane4D51zyAyr
    hJOFsLYMXFssHdm27fjkTDqnC7azN5f5dfy5CskNp8oBhv1n2jQoN6xhuAZoHUJp
    6gRuDBN9txXgzbq0n1AsXhZSy+aYH/gl4vjdDp4IzntiIjOyXOLFYC+D+muyiFqY
    oC7dyVah3HF3S5HggKIIer8f92gUd50D0GL8i5vExdq+bPJowoSDwiiXeIR1507b
    7Re5ndQOg+X7L/VFKH7zu51FMlh8JtHVWmNjp5muJrDGLy+6rCxidFIgnztGgiM2
    Kfyp6YE/Wo+LuR1raaySsDfO6N4OsaMAuOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523803377; bh=67dOsfooqDOywFw97uKmu6LSXqe1uccEelq8sjarJ8I=; b=
    gxXnaIGdwnuh0ARbNkddOavlrVrN8V8ey6F9YuAoT7itTb+nRVsC/hcA4d6p8MlE
    IMhye/YC80w0+rFrtt9qCPUXlF+tdnwew6fT+yCbefHB4ERaEXOaWut058KvlV63
    +1y90Bs13YaHnwTPPxXLVYkJ3gQUE9NWEjGjd2S4zoB0/1YUlY0wo8DQH8M+Y2kS
    RFJHrPS1B+l4XU1WMgsENSk8CYgBaE529ODGjh2Fn0cuv6B1DRiJPXc531I5Kb8S
    X1pg9lLxawNdBkm4NccV+2BAV+qQM/CIuhOvJiZnRC2EOELLu4v5KOTwJMznwi0Q
    i3qEgC1H9uM7z1FQTD32+A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KRA21Yww x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KRA21Yww x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCTGiHUmKtJTA01QldKvbODmvJWJpq6Q2v3Sql3djZegthtVJdfYS6PRKKhYsaGv/Py/vAhkjhtoqk79u7v5+TlfAujitAAv2rgvEaUDnhsyRp0uNqVi
    BPRKy1A/XYL0M/KR3Dc2CbIYtSh1HdbiezmipWioIQpWV87S9lBrCdVDrk0Ho5DZrZPv4Pzcu532kfvP9bV4udUMd2SBpi1n4jA/DlK0ElDfeD8CdE/8ct5S
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=2GYZ2dX-zESQm4657vwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeDOOmz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 10:42:55 -0400
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:29872
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752457AbeDOOmy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 10:42:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Petr Mladek <pmladek@suse.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwA=
Date: Sun, 15 Apr 2018 14:42:51 +0000
Message-ID: <20180415144248.GP2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
In-Reply-To: <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:P/EDypxRp3ZcF6NUukvBTsDafAF4yJ4HjoH9KzuwMid7XUrzlerMInP0/r4lb3b4kmncRhaViS2vnidITJvajAg8NOSbo1BYaLOJEduHt3finF1ZhaoI0vwYyOXMnc5I/72ZpgLHvg7w+v6jfE4uWSzRatJ8OoRGNIZDrwFy+81HOajRR/LQ8fdUf7/y6cu7GZKSato/CpIFYmqf1n5EnaZrH6TVhwWGAQYRoAW/XP7eqZgIvvzZMiiXYxCifpP0;20:9rWMj8klF38fFo9JzRZpRX1iWU3bL438OzZNdvO7kef0/92y8kBr5JHbOitdEI9LzIzJ5wDpbliL+UKK+r8hWzitiA8m+FdUdGYLiZH5tozsapPNRlK718xDioEiqhDCRezffTqCbo69Qq+fRXeFk2DMceKTaTrq5XBQIgCUNaQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983A97DC7DE2EDB4445F2B8FBB10@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501347)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(54094003)(6506007)(5250100002)(7736002)(102836004)(229853002)(6916009)(9686003)(6512007)(99286004)(76176011)(305945005)(33896004)(2906002)(1076002)(86362001)(39060400002)(3660700001)(86612001)(53936002)(2900100001)(106356001)(3280700002)(105586002)(33656002)(6246003)(486006)(22452003)(10090500001)(14454004)(476003)(11346002)(72206003)(446003)(25786009)(26005)(6116002)(3846002)(66066001)(33716001)(6486002)(4326008)(68736007)(186003)(5660300001)(316002)(10290500003)(7416002)(97736004)(8936002)(8676002)(81166006)(81156014)(6436002)(478600001)(54906003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ANsGbJLo5zCOH+r4T9sM+Ilr49LIimtyumQxVTB+dxt3i9a7LrU2MQGhA0thzCWYEHuQQVt17FhFXVysduE/m+OExzKF0orYjc4ploxS09nla9PQxr7DmcD7zzS2ZAZyc+8SHb6QvSVPdlb2RZQ9npsLXjNSpM6wTusnndIfdaSXy7FGzmujNmSHp1rQn9jt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6E90050B59FD7458ECD00BD16074263@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 01f3b719-3d4e-42f5-f801-08d5a2df2a68
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f3b719-3d4e-42f5-f801-08d5a2df2a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 14:42:51.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:22:46AM +0200, Petr Mladek wrote:
>PS: I wonder how much time you give people to react before releasing
>this. The number of autosel mails is increasing and I am involved
>only in very small amount of them. I wonder if some other people
>gets overwhelmed by this.

My review cycle gives at least a week, and there's usually another week
until Greg releases them.

I know it's a lot of mails, but in reality it's a lot of commits that
should go in -stable.

Would a different format for review would make it easier?=
