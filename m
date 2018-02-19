Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeBSNX7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:23:59 -0500
Received: from sesbmg23.ericsson.net ([193.180.251.37]:60831 "EHLO
        sesbmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeBSNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:23:57 -0500
X-AuditID: c1b4fb25-823ff700000038f0-f6-5a8acfeba4f5
From: Jon Maloy <jon.maloy@ericsson.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com>,
        Ying Xue <ying.xue@windriver.com>
CC: Andrei Vagin <avagin@virtuozzo.com>,
        David Miller <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "roman.kapl@sysgo.com" <roman.kapl@sysgo.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>
Subject: RE: BUG: sleeping function called from invalid context at
 net/core/sock.c:LINE (3)
Thread-Topic: BUG: sleeping function called from invalid context at
 net/core/sock.c:LINE (3)
Thread-Index: AQHTp9gEjRaqnRZEEEmyW8L6dG8lNaOoP16AgADsr4CAAosP0A==
Date: Mon, 19 Feb 2018 13:23:50 +0000
Message-ID: <BN6PR15MB155309E2A35F66298DAD8E2E9AC80@BN6PR15MB1553.namprd15.prod.outlook.com>
References: <001a1143e44e58485f05655fa8ae@google.com>
 <CACT4Y+bxubQ0yqi777mgQdT6paPS+wWQo79T+jPqztPJ=gTYhw@mail.gmail.com>
 <b6b1e370-d3ba-4db7-228f-a3ccaf502992@virtuozzo.com>
In-Reply-To: <b6b1e370-d3ba-4db7-228f-a3ccaf502992@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.176.1.91]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1585;6:SKB4RwY8lcJI9Ph56MojRdeLFzZE8XpXKK1ookNZn3uDStouzFDMhHJ3cFDLuxWzXqldKlD+UmOeA9PGRfFLl/9PdlJiTOAuHTSWJicDk1uS08BrGKhEkvV03lXaginofdgqlZH4CdSBnJpOtXwmTmHhsLi3uKwxL28lGEHM08z0z5OfKpqzM0D7fEYpJoYtDCuXm5/LYruJpmCTBnHqaGUJicvXTWz5qEKlHUqp7wEWrkDO/hWEk3zPRRdxRmN7MPDjZgy9Ia2zWnUAj3hFgUDh6Br7L/HWXpaxQarWTj3R/JyGruZjn8Bl5L+s0Zc3JgnaV61tJIpUzRBwagemTdLJZDakpa7jlAs551KAScTtsujAFuKJkhCJma2ZSI0l;5:fgiB3NNLAKHxr2/FRWGA/9g+ayD01/q2/iMvGaWUrjtssLy3n7ywv+cxQ/ERMZs9yZt8oCOvhisVhYqNdei1rVwTTpo8Z+X2GjCNev8I2z99wwxlmKJw4LRtGahIIlaO8y6TWfJ58973NfCc+f/YT6v50FG321mUhvORE74VFt0=;24:o2g6v/uVfXuYJNu1D1joBIPvwyNlgBYbR6iWdkKsASFyKgcqi0CigLezINYOvEKP053PoB45eL+tF2D4HQrMuObV3OT63rrnUgaQI8YQIYE=;7:Man4VkyeqSEA5hvzJXCiazzPMNHDdkF9JS3vJZCr8IcnWbDx8mWWR+GeFSIhUbc+M7XyuNDsYkRoTaY5SosnKbSCbJmhq9NNd4Ak3SABLjjAteWRAi0lCkFBntVaEtijOB81H3AdIIvk2ulFmDZm1atU52TsOtsHa6bqX5xYTKucY1VjXzr2EexlwRKTdVPcaEsyQem2k34WDf6Unmbsc7PUk6t4H4AgsMLg/r9JORWpL3mzIar9WyiQkavRyXd1
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 3cdecca4-c4a6-4b2f-99c4-08d5779c043e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BN6PR15MB1585;
x-ms-traffictypediagnostic: BN6PR15MB1585:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com;
x-ld-processed: 92e84ceb-fbfd-47ab-be52-080c6b87953f,ExtAddr
x-microsoft-antispam-prvs: <BN6PR15MB158501F16A3DA93FAA2C4BCE9AC80@BN6PR15MB1585.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(215639381216008)(158342451672863)(9452136761055)(211936372134217)(42262312472803)(153496737603132)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR15MB1585;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1585;
x-forefront-prvs: 0588B2BD96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39380400002)(346002)(39850400004)(199004)(189003)(13464003)(5660300001)(8936002)(6506007)(25786009)(74316002)(77096007)(110136005)(53546011)(102836004)(54906003)(478600001)(106356001)(81166006)(8676002)(81156014)(2906002)(186003)(316002)(68736007)(97736004)(14454004)(229853002)(26005)(2900100001)(3846002)(6116002)(7696005)(7736002)(66066001)(7416002)(3660700001)(99286004)(3280700002)(53936002)(6436002)(76176011)(86362001)(33656002)(105586002)(2950100002)(9686003)(55016002)(305945005)(4326008)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR15MB1585;H:BN6PR15MB1553.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: nzmCRMnj0ESGZ7wfIqK6YfBjG0aksnbQ30YM2Bcer6v3yoGRoRMe0R0GSKklQxVFlI/1IOYzJJd7WMent0QMi5a2Cy4hvtOiOgPSmgs86S6jsErwlp0b9T5UU3uTLZQyALrQxfktvQO4QJX5+gSwJpzOlEgtV2v5TUsilN1SW+w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdecca4-c4a6-4b2f-99c4-08d5779c043e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2018 13:23:50.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1585
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c45OzvOBp+X9MXotjAqSC2DDiF5ieBEF/yjP9yodOVBLZuy
        qWkXmCZqE2/kNTXHLKM0FJ0WOktXrjRqlSh5CZuXUiwwrbQize0s6L/f+z7Pw/N+8DGk+5TI
        h4lTJfFqlTJeRkuoiogHgTs/W3WKgEo5O/+pRcxWWTMpttCWJWZX2jLFbFtePWK7Kl9RbH97
        Fc1a9F7stY5Wgr15tV/ENjS+p9l3xmqSNVrPhki5NwWjiDPeHSI4fXMyZyrqpbkO/QLBmRf1
        Iq6pz4S4ii9buYXmDdzsYzPiis3ZVLirQhIUzcfHpfBq//1RktjB2Z904juceqsnHWmRHuuQ
        CwN4D2QVDiAdkjDu+AkC7a86WhiMCCwLdWJhWESgLxhzKrcJmDUNORQKzxPw9P4EKSjlBHxo
        H3DaLAgGR6sJew2Nt8FMaY6jxhM3Ixhv63FESDxGQuvzrNUIw3jgk5BVIbcHPPEpaBn/IxI4
        DGzGPLGdKewLljcFDrsUn4CSD5eFshYEBsNrh98Fh0JTx7ijGGEvWOxrcDCJvWF4soYQ3o3h
        lslKCrwWZiaWRQJvgpE7zyiB18PbmlzH0YAHxaDP+YoEwQ9ai744+SiMd3Y6Tc8R3J4bdAo7
        4KXuJmm/FGE5vJiSC+sgKM8tcxafg5XuSroQ7b7x3303VhMk3g6N7f7CejMU59rEdpZiN+it
        mKT0iLqH1mp4zenzMbsD/Xh13BmNJkHlp+KTmtHq5+s2/vZ9iPo/h5oRZpBsjfRQn07hLlKm
        aNLOmxEwpMxTyh5fXUmjlWkXeXVCpDo5nteY0TqGknlLqzyyFe44RpnEn+P5RF79TyUYFx8t
        Oph8r2s0IjG9UTf7Y2ORZCxksaYl1uAbGLCl5Mj3Y9NXBqwPXivvKiK7t2QPl0f7pKRmFLqq
        8uWG6/WHw0uDqYiRuu1DaXM7p5e+6Tqa5qNiLo0k4qXYILenH7UXHh2r3Zc5YqNr1T3Le2uU
        waUHqtwaksS6sNRhf21uRllRvi1ARmlilbt2kGqN8i+yKucqeAMAAA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1JDO55A019794

I don't understand this one. tipc_topsrv_stop() can only be trigged from a user doing rmmod(), and I double checked that this is running in user mode.
How does the call chain you are reporting occur?

///jon


> -----Original Message-----
> From: Kirill Tkhai [mailto:ktkhai@virtuozzo.com]
> Sent: Saturday, February 17, 2018 23:23
> To: Dmitry Vyukov <dvyukov@google.com>; syzbot
> <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com>; Jon Maloy
> <jon.maloy@ericsson.com>; Ying Xue <ying.xue@windriver.com>
> Cc: Andrei Vagin <avagin@virtuozzo.com>; David Miller
> <davem@davemloft.net>; Eric W. Biederman <ebiederm@xmission.com>;
> Florian Westphal <fw@strlen.de>; LKML <linux-kernel@vger.kernel.org>;
> netdev <netdev@vger.kernel.org>; Nicolas Dichtel
> <nicolas.dichtel@6wind.com>; roman.kapl@sysgo.com; syzkaller-
> bugs@googlegroups.com; tipc-discussion@lists.sourceforge.net
> Subject: Re: BUG: sleeping function called from invalid context at
> net/core/sock.c:LINE (3)
> 
> On 17.02.2018 11:15, Dmitry Vyukov wrote:
> > On Sat, Feb 17, 2018 at 4:00 AM, syzbot
> > <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot hit the following crash on net-next commit
> >> 65bd449c32c2745df61913ab54087e77f9d9b70d (Fri Feb 16 20:26:35 2018
> >> +0000) Merge branch 'tipc-de-generealize-topology-server'
> >
> > +tipc maintainers
> 
> This looks to be caused by commit 0ef897be12b8
> "tipc: separate topology server listener socket from subcsriber sockets"
> 
> Thanks,
> Kirill
