Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968315AbeEYUjb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:39:31 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:65086
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968269AbeEYUj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:39:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <CAM_iQpXMbtUWsaGBrpJH08dM4p9oVwpMSGrev1PThbP5d23sdA@mail.gmail.com>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org,
        kliteyn@mellanox.com
Subject: Re: [PATCH 00/14] Modify action API for implementing lockless actions
In-reply-to: <CAM_iQpXMbtUWsaGBrpJH08dM4p9oVwpMSGrev1PThbP5d23sdA@mail.gmail.com>
Date: Fri, 25 May 2018 23:39:10 +0300
Message-ID: <vbfo9h3zd01.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P193CA0014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::24) To HE1PR05MB4697.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4697;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4697;3:HkNnV323sObsdR8+WrPthG4iglFA+nBcsVIz3tWz9nIRDn0dSKzSa/cA3k9VfCK3oaIYNQxesY15ue3FyfQblNhEuvcsXjXkAzS0pSAoVj/wq6RfM38+XXKSo2xtAaZx7CFuabhTqDEd9nOHuczpCNVexYmolPlA9Xwk6QahGc2k3H8yQrgHd3X4oixI3QkQ5a1zyKBt0B4iWA7Mp3/YwQ1azJCDAPWwfciETTmAFeTZjLZAyCV8YvN2Ggs7SM7W;25:4OTYJR76bXMWg1J1I+x9dtPMDsuDZfwKU0f0bIDmo+dzq1VqxvIFgQT+xfQgIIqDFZ9WsJTFTMFz5Pw3MGAmY6BiBrhVbUkJC/vPOFTTjJVbPrET2RPjTM1fbcJygBe3gFaNW2Br7Q0NgbOVfycpsUKSGQxkPt6DmD3TkO9NiMANNK+qLp+kXcKO9NBydi1GA9/n2qEFQDkvq1TNvpVuc/XvSAw7wIuxxOMJKpjKGyFMDQyB0kzCqY1NgaJob571M7kMrwosyrHnvoyukxYPPhNNkE57Kgnh0e3LBesTzZjlizv5jnpJHUILM8P/uj5OIPILk2y2IY5BK11cpIKG+w==;31:RNjhowK7KYjM3m+cor6IfEfY3m5OfN0xkwqUwWeZ982jCbTP5cqUEEoPLcHQF5QeA6qHJB2KBZo0+cKjPU4z0oKzjErdUmRZAlCuyXey32lzeT+H7Yjs0sEeTFFA68IvY7yMZjK2swTU4xKbBbHrKpmVfsR80LIr66u5/MhStOMJyhNDVSEo4QcDt9nNhH5cU9i6tOsveV+E4b5k6ZI7+Em+8gyNjECs/AAtMcWuxxU=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4697:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4697;20:xOjBToAUjLrCu6b4ITMKRIHADCRrRl5voJ5X/qBg4tDttTHa337fmYnrynQbH0VLI63hm+MzXPr09jBCTBmReroFYH8yBdGnw2GLcACAuMm7eDOaDbwG+uHX72fzNlSBU2xQHE2OC3PPo+4pJmbt++v3pN/5c/DA3Hc1hPSXBpRSnsrb7WjTLPnn763px1VBSJZP3KhA88W3GYKSKakkKPquv0W45ZjyBpgPD91+CKsU3/Hc/jdDlwtsvuOPcU1BEMwXOjgVZAjRII0+oVObF6MorFhUrhcM5o4bCVTLayzF0XCvq0iUw0Y5CXcOSMKnqDRGMrwJ5hF30jumeQIPCQpunmwf0UaKis6edZyZKFMSGWwXTKcY6DYpl8J6dKZ25nxjtc9k3t1B9aMB02y/yZeCoWedTu6QBvx7HpUoiSljs3CxrRKNIqOws6zScO7JRMYqAfIUFikLBQQf6AoXi076t0nFjQbHXJFP3zxst6mO3BLn2Po1kTZHg31dyQ/u;4:53OoOx398krkGP0BX/ZgNyOdUQBdD/fY0hFjvwUr4U2vwQlIcRBvOb6H08E2RabCZ4dKJI1p5uCS96i/Wdty4wY7j+cnwRfAkNISxvQ0Xzs2VB29ZuAnxg55gr132TZgcFnpEA/F6SXBaj0e+SeKufqxogGlUwXo/7YlgUjz7SMfHchnkGCGDX8chwFgfyqeBeadnXaOqxeFCkxQOsGWFy2X/967nJetfFKkbiAc0KdloV9QtXoYWP4Pj6O7HJxlVOvBw3KGcGKyG2pq+oP3NYLTkTxyjl54I4IWis3CpWjTuFTz7OMHY+0W/8r3qg8s
X-Microsoft-Antispam-PRVS: <HE1PR05MB469716089ECD0B4155F0DA51AD690@HE1PR05MB4697.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB4697;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4697;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(199004)(189003)(486006)(66066001)(59450400001)(47776003)(229853002)(305945005)(6916009)(8676002)(48376002)(81156014)(81166006)(50466002)(106356001)(476003)(6666003)(105586002)(478600001)(956004)(11346002)(53546011)(386003)(446003)(345774005)(7416002)(9686003)(6512007)(53936002)(76176011)(25786009)(54906003)(316002)(97736004)(58126008)(16586007)(68736007)(4326008)(51416003)(6246003)(3846002)(26005)(107886003)(39060400002)(6116002)(2906002)(7696005)(5660300001)(8936002)(52116002)(86362001)(7736002)(6486002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4697;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4697;23:B17wNujUHZ0sFW7rh9D6OVqIIJTEnUU58eHFiq1m9?=
 =?us-ascii?Q?BUrD3hX70CIAFhgwOkgIuXTjY6nwLNQcRv4UgXoPy4NF38cKF5D3zjcuhpTy?=
 =?us-ascii?Q?IUnZAb9Mn7VwrLKSdCGLSDJ0j7qT2HywKg7C61vzZnsxMe/+KaEZIR8YmsIh?=
 =?us-ascii?Q?YVGNJP05pbyI2PO+rE4XzaBtQnn55EsHnDkoj0SPmBS6XPw+7mDaHGlP0H/G?=
 =?us-ascii?Q?V/frERbKq4pnF8JBdnv3HG1dgyRPJpql13gePlY361B8cbHkVPfvlu2rXALy?=
 =?us-ascii?Q?0MvYkUghQBrW89K9/OGw4ReKemixmM6prJ/N6n1UXw98O1fYRst2TzhJ+mJO?=
 =?us-ascii?Q?OY3fXN0qKvtNG95wRVMutOXSvysFxT9sUv0Vx8FBkjO1dd7m9ilJ8ccIHuc7?=
 =?us-ascii?Q?USAiJHvWF2HUC226Bcyotd/OxLZC4fQ3zVg+22VygnnBRvPmeQHMts8AOxjD?=
 =?us-ascii?Q?K+MZZ2yV3UOsHz6dz10hpPziA28h30BjSwQ6TkTESRgk4TiIfnD2QSIFCHrx?=
 =?us-ascii?Q?IWXtJJ7AqDU7gjK7aHflFDt0CQ13vPF1xIxOx+NUYAkhr5ok3OfLuVtji2HJ?=
 =?us-ascii?Q?OEM5BuOFhHM76upryGNs566Hz+OYhqTtbogQU0rFb1eb+8Hwihj7iqJMW4nK?=
 =?us-ascii?Q?oWNH6RLweaTWQVa9oiCq0fr62Lzmcs0AQKl3ZDOza3O1Jjrvq9SFufEwu2R3?=
 =?us-ascii?Q?aLRzfawbyE7s6MgIdrxyDp8rNTRSfhpGTEPLj2TmkpQU+9TYAtD3ZnK1Fj7g?=
 =?us-ascii?Q?9733BEB3VJuaT/2RjzRSUHy2oMulrHvsmrFGUuwSz3WAJ571lPNhZunmyaOO?=
 =?us-ascii?Q?X7UkfUSecyDWNleVehVeTsab+15Xc0nQANIPTqjS3owt38QL4AGR63w+Rfno?=
 =?us-ascii?Q?tq+org/Zmml/Tqj5mXPhMw9uXDBdEW7+87xVbBAn7gcT8DrviKxq2WbA03Je?=
 =?us-ascii?Q?sAdSkLT/2rHxmeB0HXPjv30YKDat3iRDGS2z1MslMvbvZbBvzvDLtNiMysUy?=
 =?us-ascii?Q?ja+9yxWeLH4NcEIT64uZM80w+8Zv2ClWfR0UzblyhAvPBPTU7rWG1TrTgCGe?=
 =?us-ascii?Q?iCZJsDLDawS9jZrEVELezafJISpDtd8MCeQS6gsBPTtX4NGtaPvGPinso/Qb?=
 =?us-ascii?Q?aoQifHt+iUteDLk/bA/uhfehWwY0A0rI8qcPCYi/nP4aG6dKhsN8ZB8nXjJn?=
 =?us-ascii?Q?Igb6wZz0YxwneYVDf7IUPzE98DB0eauJVhyEMs+1/4huuRXaxYHuj4Nau7a7?=
 =?us-ascii?Q?D2vVkD+o8kiMyMiZLZa3SQMBjpo29+quT1c0GZdZeNMXuesSjG2t3EkR372l?=
 =?us-ascii?Q?sLXSco+e4apk+x+3yT6Lv1fkIoa7NWKPMMddtBJ7amP?=
X-Microsoft-Antispam-Message-Info: UMePCXAR6WkrPB9D0J362DoUQw7hPVU7tQNGRh8whqhagqQRpaoVB5EjAEpwOIz8rTVEO3qX7nRIbzD7wAkmvKVxkMEzjqMQdpntji8vyPx6p5Vkhm3JKsksup4QW3Z7tO0KHy/tz084WTu2RTsq6P7Iuvmurtv5AC93wtfyU2Dw7fJffqmBjfzWH5zyT+/X
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4697;6:vZR6ItKEZx64NXt5l0ritsc/E0B4uCamS2B7+PSuzfhedB5RiEj+wHtMM8Njbm7hOdYNa2J9wKDDOBIJacMEEpSV1ovarA8z2i0cB/d2/Tz7t2Fut8RdOlwfqt8rtnA39+aeW848v0sgDmUUP+7Mri6CXXJjvilHdNWZam9G6vBXsPaWK0ZPYZLe1eKejSq+eZJUkFyFhZIwQEL1esRKZcwCzmdFgJ2cokuTNbi6J1rL2lmCJ4J4NCXriscQXE8ZgjwB6XlzT10OekCUnA4s9804IUEdxVxgqrck8Abdy6RPM/q2FsQolSXzGSPiWPpQAcO1JPxGTIhP0kP6H4qTlf2kldCOyxtk1Ecs5139AIK5DY5hQT4APqTgsWW1kkiOWc9ZSEaLio3xeFAxRUPhprAJXzcodZBY+GfG9a++x1VUD5UjAPFH8q6/jaXSzj8hJoZCskogAAnnZTFD/Er/YQ==;5:ZG930TaxhBnYweA+vXgKCDEXYzzj9a4N78fYWCjaxpg0AZuwxb1pJQZtC2DwkaiJrdFBHmQuQF7s7CiixJA7Y6RlA1k3OAY7NPkmN1PrcVT/O1ZFjNjJdtqNG6e3R0YuBqUBS4A+3Y0hJgWAVyfiGJnVU/B7obmDCDOkyYiR5FU=;24:r8/ZISfi1Dc4sPdk994dTGXKuL9XQM5iLvTzC7cj9q/ynnQ6Ao1hQ0KFofHcShvWL1jvRPwblJAMqTXf/o8B2RJlY7SC7FAo2ZPK44syYn4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4697;7:8843d2RnZpysclbaHgO9LbWlK+tHpy05gril7BbDRu500liTNemqsAe8Av9mjc28xaDUICWO3YAoSZ5NAFma26a8LyagI4ubJcEVTfjH0V68q6zTm89akL/j2fp8StRVU1lWGXEqIfuDbKGZnmKlrYS8QvFASQZf8Ds7GeC7RpJSDdhjbxYfxJD0ArO6E05v3u6+bx/4NTtHLYia4VlB+f3lmIqbNnI9lAVb+buXlqaTt1i4pW8f3HUX2Buz+gjF
X-MS-Office365-Filtering-Correlation-Id: fa3b50cf-c405-4cba-72fe-08d5c27f9918
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 20:39:20.1069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3b50cf-c405-4cba-72fe-08d5c27f9918
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4697
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 24 May 2018 at 23:34, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Mon, May 14, 2018 at 7:27 AM, Vlad Buslov <vladbu@mellanox.com> wrote:
>> Currently, all netlink protocol handlers for updating rules, actions and
>> qdiscs are protected with single global rtnl lock which removes any
>> possibility for parallelism. This patch set is a first step to remove
>> rtnl lock dependency from TC rules update path. It updates act API to
>> use atomic operations, rcu and spinlocks for fine-grained locking. It
>> also extend API with functions that are needed to update existing
>> actions for parallel execution.
>
> Can you give a summary here for what and how it is achieved?

Got it, will expand cover letter in V2 with summary.
>
> You said this is the first step, what do you want to achieve in this
> very first step? And how do you achieve it? Do you break the RTNL

But aren't this questions answered in paragraph you quoted?
What: Change act API to not rely on one-big-global-RTNL-lock and to use
more fine-grained synchronization methods to allow safe concurrent
execution.
How: Refactor act API code to use atomics, rcu and spinlocks, etc. for
protecting shared data structures, add new functions required to update
specific actions implementation for parallel execution. (step 2)

If you feel that this cover letter is too terse, I will add outline of
changes in V2.

> lock down to, for a quick example, a per-device lock? Or perhaps you
> completely remove it because of what reason?

I want to remove RTNL _dependency_ from act API data structures and
code. I probably should me more specific in this case:

Florian recently made a change that allows registering netlink protocol
handlers with flag RTNL_FLAG_DOIT_UNLOCKED. Handlers registered with
this flag are called without RTNL taken. My end goal is to have rule
update handlers(RTM_NEWTFILTER, RTM_DELTFILTER, etc.) to be registered
with UNLOCKED flag to allow parallel execution.

I do not intend to globally remove or break RTNL.

>
> I go through all the descriptions of your 14 patches (but not any code),
> I still have no clue how you successfully avoid RTNL. Please don't
> let me read into your code to understand that, there must be some
> high-level justification on how it works. Without it, I don't event want
> to read into the code.

On internal code review I've been asked not to duplicate info from
commit messages in cover letter, but I guess I can expand it with some
high level outline in V2.

>
> Thanks.

Thank you for your feedback!
