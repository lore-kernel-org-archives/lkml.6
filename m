Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeENUqx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:46:53 -0400
Received: from mail-ve1eur01on0067.outbound.protection.outlook.com ([104.47.1.67]:47680
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752042AbeENUqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:46:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <23f37e5a-dd30-0ad3-a5ab-df22bf0ad7f9@mojatatu.com>
User-agent: mu4e 0.9.16; emacs 25.2.1
From: Vlad Buslov <vladbu@mellanox.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, pablo@netfilter.org, kadlec@blackhole.kfki.hu,
        fw@strlen.de, ast@kernel.org, daniel@iogearbox.net,
        edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 00/14] Modify action API for implementing lockless actions
In-reply-to: <23f37e5a-dd30-0ad3-a5ab-df22bf0ad7f9@mojatatu.com>
Date: Mon, 14 May 2018 23:46:28 +0300
Message-ID: <vbfo9him0d7.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P194CA0005.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::15) To HE1PR05MB4697.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4697;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4697;3:7RBoBNNeseDiJL3Kc8JweVr1kluLVViG/AWuizS1Su3VKt2wNogpz6BRlnsHe41qSOqHer/L6TybT2sZikLnnqV4jTcUQXAM5hcmcpYcze0gVxUSI6D9zx+WY3f2nqQoVoRovZ3LOrf2tzWhIQk0iAJWlBbi3K/3D/9k5arxGB3YnTr8bSmxNvFOGSn7nRcQRQZ5muiZr4VGxewnwXYgxxQCzLLiT9IA/vEC1GyRIlsDS/Ok/8xSXuhAnttcaJD4;25:xj95YTs8ujPasJUGH8Cz8WNV5Swoe6sWRpGaM1RZvq/ai4Cgm2tHgQEVcd6BiosPP39XhwyIFhbwwm3y2QmTIOY6gqJHlyILite0W0q0/RhYWvxZhrz6Oo25TwrFfciF00t2YgTbVmsWVKYqz0Gp/ClSRctDLpE0CSAs+AkCeGwup3EwOBA2FlAeWC5zEibRXvd4oVe+hnyqiODjAIwgXZ6NcTC9bUvACpwlf+QhJQQR7bPp1LECddgEBp8CuPNjTnZ/OwEAb9gWYFu/c/mY/lZflkNEu4sO/fEcZrNfVpt/jcTVOQ4iTx+QBMhDPUC0+8KIcCHM5B8ErXEv38P7SQ==;31:FWEPnwxtCUBTUsj66FPHhYrBv+5DpC5tcXtIXsp3TIr0PpPIzgCvFuf3lJDpuAV72hZNG6/IMI5YZdjin7qJfg7DWjy5mQcQHHcXgO7mbUmgnI2hZmy+NSYGR27UK5sWv7+MExb+00O8zv9aGYWGypcq21/ncyZniAiEkbKK2yWPbF26e5DbxAJo7S4/WEc4GDFioA88Io3EOqDFYq8f9FIl1JHAtgpYYUmqPv+3WE0=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4697:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4697;20:WXiojTAOI2BgUvvKU5coQWRM3V7PmbxoDMzgIwxOYs/PNFfPxKZYQtNMCFqs07SMZgW1jELdjk5H6cfQILtq6cwjyobpOIzjK69VcFdZX75iM3SRIyIgH1VqQrSDJzxSSg/fhyCJc1412rrykAP/u3nhPeqducVlOA+SiLgXKtKqF2yaGdVlw/OXv5BH0B/+X0QBFahWOvIMEjlEE0C3LEibZaCEz15PX00NufkZjh8PSF6cwheG36HcWnOyEl4KrFebljK+CaywfCKzyKVwBgos6Xicg2l9mNCfwU+GfQDeEYRKlZiF9s0hJY/3Fee7b++fyxG8mBhCodpkYmZSJLw4c5UWJmkgb7tMrilebZAP8BxixVJvA/ohoV9oAWUePSeRAEAU/EpP+mp0ARQqI99spjt7zmcluKZYFQ99f2JzuWAGoHBUQyonw2S4eoMO+4EfU3jl4i/qHmnCt3nTGSVwezfFIER12T09fIj/gzwpNHyyTJsucd0QKAjtJTtN;4:o1hzoqUsREAry9Sk9tvVFpaUnDQ7N/DNtr8SE235kx13Rv3SzOUPYZdecrySJxoTa9VfoHEnMePPRxTiLpRGrIHLiJQOHNrlINcPh3ZdbYdnvoAdPTonDHVlTGllz6M+XHseR9vs+3tN9PmFPfuV0QGFA2krxplo8OGRXaQ9+gohT6jjMWBD0StZNmyBVq4Ec2VsyxAXOUM+eqdSRJd1r/SbtclwSy0vMXpIBP0pMXOj2hoZVCPUFBCRQNY45MtdwF+EyxzKOSl4sg8iplEZrw==
X-Microsoft-Antispam-PRVS: <HE1PR05MB469734CAB11744AAA8916EB6AD9C0@HE1PR05MB4697.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR05MB4697;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4697;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(199004)(189003)(386003)(59450400001)(6486002)(478600001)(305945005)(3846002)(106356001)(6116002)(7736002)(105586002)(50466002)(47776003)(446003)(76176011)(53546011)(16526019)(86362001)(26005)(476003)(486006)(8936002)(66066001)(11346002)(229853002)(48376002)(81166006)(956004)(81156014)(8676002)(16586007)(5660300001)(6246003)(316002)(2906002)(7416002)(52116002)(6916009)(7696005)(6666003)(51416003)(97736004)(4326008)(58126008)(39060400002)(107886003)(25786009)(9686003)(53936002)(6512007)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4697;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4697;23:mALZhwkGgby5CbyO+d/pM5xTAnRpCUjMWyrlPtbpX?=
 =?us-ascii?Q?ZEQbTVQFJOztKsV9wjuGFAtACiJNNrdg/FmVMjJMkuS0YLdg9GnmCfXyWMLd?=
 =?us-ascii?Q?rtPOlMr4Y0u+SinvR8/1yXTghsbuRQrmTwVhEXmNWJdCILveIzkzUm3AyY76?=
 =?us-ascii?Q?YCYr4Hshd5zGzZeiMoV2yEMTMAPQePspYPJfGDPyQ2jLFthss4JhMYg/n4Z2?=
 =?us-ascii?Q?2U/GwCAcL8ROXzFGY3L0YctMamZK389wo64hmOMdTT0zljGv6FaMU5fzwydu?=
 =?us-ascii?Q?jZC9rsBAw4owNm3d8wOUqpJ94dIdXUwjIS9oTzDVt7vbGoG2zIzZVmkXdoim?=
 =?us-ascii?Q?bpXqxg2WHXOGyBNlmDD19M8SoHoo0eFY71Dq+7Kn2WagamFQPRQX6LPzW0uT?=
 =?us-ascii?Q?AwkM4cY8HSbXiz+vJUITb3Nn1fOmWuf5cK3P7nW3KoIF+QZUlPwn814+J+G7?=
 =?us-ascii?Q?H4R43g165whrPKvyx/P8Tp+Ew41GSJ17kc/WvO4HPpzV5xVDZ0WUygLxA297?=
 =?us-ascii?Q?C3diwDSd5G+B5dahvzVvYmfA3pkPrmOxOrpKU1tt63Co2RfL2VV/qhWwdgpZ?=
 =?us-ascii?Q?Kd+Iwf3RsSLsL2Xkuq1IXWt2INBcXSbf4NcaD9Q9+3ghMHSNSXUOAXRFMOFX?=
 =?us-ascii?Q?uVAB9Ei8OH5NwgzoG76jk292OkfkmGmp/M4i3AQKupJN95YG0Urr1Sq2Dyvi?=
 =?us-ascii?Q?e4OHc2JkoQWhEa7Pemrq/QwXIP94tb2XziFlY0Q4ddVX43qTKyRIpZl/1gIN?=
 =?us-ascii?Q?6dEIuQwaQ7/2M0O2Kvf+U0yu/8Wwww1haG3Tqrs30MgYj8om8O02cMr0Rpe4?=
 =?us-ascii?Q?KcoxDp8L3d29xjNP6CE/ARql+9n3eKiypg3Khptjut4siJBRaLdm97XZ6tRw?=
 =?us-ascii?Q?/tqGTGFxmui7kgeUh0daQOnwiY+4gyRCKjDw6a2uRf5BsyCAiTs1Oqz1ADY5?=
 =?us-ascii?Q?DAA/yYbvI+u2oYnidGHEgsamrk1q1Ej1cBvaNgrlatLBgFZe17fomF/XZtam?=
 =?us-ascii?Q?QXESVn86CdN0sDLL+9jXon85q4QU/zLhffHJ9zylriwiRhCrwe/nfH/R31K2?=
 =?us-ascii?Q?EPqvrz9J2jYVZ7Ehx/nswJTQMDaDdUx62TtrL7EiUNpQG0RuSAw4W0wOcEUq?=
 =?us-ascii?Q?G3qu5O6q0PWmrfzJLsSxLkgQaC1jmNBpIe7/WPiEQ2eKfMVCSQIO5G4QQcpG?=
 =?us-ascii?Q?rjmLRFLmdLYDLs4m+jM4NiR4InKVUKHCKThiN4fsjD5AmeWDLuA9vjv6xJaL?=
 =?us-ascii?Q?wwrD2ttejDiM4zJYUbEKthlNpGbSSsjhCOUFGxZAf3eLUDvghL2OuqJvRSKi?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: TTrSgqd52l28z2Ptb7oxyerKFo8thW/mccAt2lvD5s1tUY09Wvlbr7dq+Y5zRvoHrBvG2jY3ZxSn/txnLf52s2lTxSCul/kSUsRCN/WB9Uf8kdQDg0DOsP5/SkixAJUqjHk1VunLWR9VSlnE77NoWLslBWKvzjrDHzcKiSTp8Y8wM3BBdJDgTLUGYf/Hu544
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4697;6:kMze3mcuc+7QTdUmtrnw+mZ7Fmmi1U/G6Xe6FvpL65piZ6k3V9tmyWELGJG4tR4L8StszM7Mtn6JgxQGV03I764nJu9VVD+U2EYMdwWSppCXqdRrU2fNlan4CQOYyXjrdVp+pZSUtQM7owyUPgLkYSN447rQhunEicP/jwSqbEKRWo3P2Ofbv6VJ8+U4VmgRD1u6XHoy+wTM1rLD8xP7MwYSngSUHNW2LJIcgqlKu9l4Ts5c36ggk5eKuLlC50Uzv7vhc0fpLRjeyWqtrMg8kbg95jywx46GN/ftqjCTG7/NcLZzq3CHx2lyUNg6vi70PPBGCj3nJneKvIXFcWcECcIiXdVi9y28QmYQcBJz7hdiL/Nr1hDhN8lV6mxl7T03fLxH6Xf2A/iXHm6Pe5iJeJV4YILy98yzB3osJ3VNg2Ax4IYA4bW/ONkrQ/NzxwA1CMK4GWfMnfIU9/Ulg0ewqg==;5:eAJnkjcWhTVfxg+sWxxjQRSn2SYXats0LZSyqVKmykxwjci6TLNWyX5Rnd7iaIs0sXvMPmD+d68rmExNIKimQ+Cac209IawQTFOI+8jj21wTXPBVbSEdKLfRZmGr3EXtkIFilcjr8QzYpRiCYCbGLLRkBwXkxHgBzv1GlBdpO48=;24:Z9IvN+F+Wx7NGo0sHUz6UUQ6w8+aMYPOOPi2IZrjT4WY6ilsDv9NlxWNCNm3c1nepF3ZkHSvNz8CoBCQdWEVDrqOJ6q/8IqKQDKgQHunGEU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4697;7:KZsgg072OhgLujPhU0DiDBxvFeW5nAfsfbOPuYK4NLFZ3ZJbL+HIBBrjlHVTv0xtvedSh8ZIHtcyJph6FoONQB+9Orhr7qMP1lgSTFN9kVeKCnCMODODxPNL1i33wJcKNBjdZ7dwzMxcgWlYpQZcDYBubgFRTqljkFObCYu+ON9CQCfE+WqRoFwaPcRcXNheTaobRx1wHwBywAXeUs3N/MBoUXEGevyrePnPE5ZrjdwGLMvIxyhhgdWGggOoeQ3c
X-MS-Office365-Filtering-Correlation-Id: e675ac2a-9ef7-4e69-3425-08d5b9dbccaf
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 20:46:39.2209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e675ac2a-9ef7-4e69-3425-08d5b9dbccaf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4697
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 14 May 2018 at 18:03, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> On 14/05/18 10:27 AM, Vlad Buslov wrote:
>> Currently, all netlink protocol handlers for updating rules, actions and
>> qdiscs are protected with single global rtnl lock which removes any
>> possibility for parallelism. This patch set is a first step to remove
>> rtnl lock dependency from TC rules update path. It updates act API to
>> use atomic operations, rcu and spinlocks for fine-grained locking. It
>> also extend API with functions that are needed to update existing
>> actions for parallel execution.
>> 
>> Outline of changes:
>> - Change tc action to use atomic reference and bind counters, rcu
>>    mechanism for cookie update.
>> - Extend action ops API with 'delete' function and 'unlocked' flag.
>> - Change action API to work with actions in lockless manner based on
>>    primitives implemented in previous patches.
>> - Extend action API with new functions necessary to implement unlocked
>>    actions.
>
> Please run all the tdc tests with these changes. This area has almost
> good test coverage at this point. If you need help just ping me.
>
> cheers,
> jamal


Hello Jamal,

I'm trying to run tdc, but keep getting following error even on clean
branch without my patches:

Test d190: Add police action with maximum index

-----> teardown stage *** Could not execute: "$TC actions flush action mirred"

-----> teardown stage *** Error message: "RTNETLINK answers: Invalid argument
We have an error flushing
"

-----> teardown stage *** Aborting test run.


<_io.BufferedReader name=3> *** stdout ***


<_io.BufferedReader name=5> *** stderr ***
"-----> teardown stage" did not complete successfully
Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'RTNETLINK answers: Invalid argument\nWe have an error talking to the kernel\nCommand "action" is unknown, try "tc actions help".\n', '"-----> teardown stage" did not complete suc
cessfully') (caught in test_runner, running test 54 d190 Add police action with maximum index stage teardown)
---------------
traceback
  File "./tdc.py", line 293, in test_runner
    tap += run_one_test(pm, args, index, tidx)
  File "./tdc.py", line 229, in run_one_test
    prepare_env(args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
  File "./tdc.py", line 177, in prepare_env
    '"{}" did not complete successfully'.format(prefix))
---------------
accumulated output for this test:
RTNETLINK answers: Invalid argument
We have an error talking to the kernel
Command "action" is unknown, try "tc actions help".

---------------


I've updated both iproute2 and kernel to latest master and net-next
respectively, but error persists. Am I missing something? Maybe I should
you some specific "blessed" version of TC?

Thanks,
Vlad
