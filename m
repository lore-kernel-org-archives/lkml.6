Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeETSmZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 14:42:25 -0400
Received: from mail-db5eur01on0045.outbound.protection.outlook.com ([104.47.2.45]:2373
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752568AbeETSmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 14:42:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-10-git-send-email-vladbu@mellanox.com> <20180519215246.GD5488@localhost.localdomain>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 09/14] net: sched: don't release reference on action overwrite
In-reply-to: <20180519215246.GD5488@localhost.localdomain>
Date: Sun, 20 May 2018 21:42:08 +0300
Message-ID: <vbfpo1q9njz.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To HE1PR05MB4700.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;3:B4szs89NTOS1yS8NczH7Mkw5CO1uUMd6bY5iVk4XtOjPHhwfgplSDky7e3OBKFBjqVM7BfqLpZ6qZb/bfspjNORYhEwkJ/3hizxC8vrMw5v9K6Ov0BluC7kYV1GaCkfeVJ0G88RL++cCqv6M163u/8OnYjWlcNalBVGgzwIICaKI+fYzyZuGRGU/rmZupaqbvqjYosQAZ2lp4W3p/CWbxojNN/isriAcMTnL/1ZhQ8IUHh/IW/mXYecYKwWtsG6C;25:tMa3OHCiRF83oSRci+C8qIEJtzl44DkAZKjbdU43h1INN+ZiE3rrIeNbQoSwTfQc69TPv73cXbAzfEyNOBmV9AMedxMxP9IJlDAOYkGylvBHSYLzdEOurARVZOotfUg/lbApy/lLq1kw/Uim9FLnOqdS7s7MWf5cjCnVtaN6D2NIy6K8EIZO0KWvl5yF9IXbD/tnUEknAwIkZWmnj+Xs+5Yx4UwgJSXabP3WnNVLaRS812MDZAcGhHwl2G/LXDhqKrGi4I+musDFloIqAjrSkEn57vGl1MWu5A10lh2DI0F9xMuAYbynHqEn9HKcnMh9NqtnJYkrDEJ9pKa+VF5wFQ==;31:/gpTP6P+taEveh7OQvvNdQbZe+Y/M2FKG/z9GKhfpetmkVaGUepz5V/t0aKLFBVU1ieVu+IO6G86BHkHU4+FPF2cYGheqrDvwixXBYtPHFKlWtU6jqrgEPqz7FzI1QlFHYJ94/AfKO+IvwFbkmZwt/4/ztmqiW7ucaS1WZ+DVaiN2rjwCa6KBq/oYZi0qsQHD9CZNFvYWc8oboc3rvLuw20kZCJKHyDycKvZHA05ug8=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;20:mqEYYZFuZGOg9+/gMsnDb1bDqBA6In2+nYPNS7bIahwJYY5W/putBjCiUqvHZL3R3ss3LZo1wkiv3s32MBRi6Gq42Xym9BiOVa8Vorw3n2bD27mihBGwkJG7PGwJNTf3XTwOLyBuIIRsPGIBdI7LvMI7qXPxoMreFkUgUtrC7Cm9FcwVaJzH3peANqi2UiNkpXx3cZnA1XkU55eBP5P0eRx3XmzyWMicLlXfYGiu98xFEHwkFeXt9LhMnB/Ju1e7kCzmPF3ahlsjigP6fSXnctGCEq+6JkPjSBHd+Wi7K8Jw3d3qmeQ80Q2X+BMJu1Sn2rZ5rpLptZu6eF2dmMhYJ9ULdxx68NzD3rRdEXot+EvP0Y9j5lSSoIN7uNsY/N1zhsx7E/KAjJzv1Wo8berqWVcHKzwcxYzeCiNgs6luG3Yk5SWPb0cBUpxlSNCS+vpiSVISIkW5SdsucGxBBHNqeSG+Z3I0Wwj5XGvujCth+iMeJ5xWysPQpmQWi6SRsaGt;4:I8ftu6noBFU/Y0T94WGBQGbLnGKR+/HW+061SivRZZzKTMkWzuGbQ/1LqDlOMJmBcEE8FWnR9QvVGmQLHVuda6qP7ByP4O1BxhMyvX/SY6PJJDjVPwU5Mh+ozeGiYXiwbyL5vZZFdTZn3FznHCf68BgvS3TfF2jdqnaif4AbLGtm+7vWe06MKMASAXrI+FRBRvBBFSsOfTXzOBMj8YqVCqdU+7dvaJIG8vGQUZYM1TtcUURRxbJ0M6SLNjAHWDoCV7X9t912M2Xt0UvFAzF90ZrTeCsgia1xVtH9JuQVCyZLcujpKj6tYtA08ia2Sh0k
X-Microsoft-Antispam-PRVS: <HE1PR05MB470066CF9956619966E25A78AD960@HE1PR05MB4700.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB4700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4700;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(189003)(199004)(48376002)(97736004)(478600001)(16586007)(68736007)(50466002)(8936002)(5660300001)(11346002)(956004)(316002)(58126008)(476003)(446003)(25786009)(86362001)(486006)(7416002)(386003)(26005)(305945005)(229853002)(6246003)(6486002)(66066001)(7736002)(6666003)(4326008)(81156014)(76176011)(51416003)(106356001)(53936002)(39060400002)(52116002)(2906002)(7696005)(6916009)(16526019)(9686003)(3846002)(8676002)(6116002)(81166006)(47776003)(6512007)(107886003)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4700;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4700;23:bBuV48qLyX9wRZzj49HONlIUHbmmf6fJKVVOYARlM?=
 =?us-ascii?Q?9rTGOT/yObAnODxc+8ZNIV2pCSBdZzTj38LxxwK31HxN63d/xGGCDjKY05fP?=
 =?us-ascii?Q?kPYTaBZ4hm++t2eLNt0rnu94xKznJrPfprC3T02KOmyzJftXUdfxQPZnNBHC?=
 =?us-ascii?Q?99vx7cTw8yUsQEOUiqEr930auiEAtUhsjqeteU3d1pqu4+8eyYUJvj99+C2P?=
 =?us-ascii?Q?9wbSZI52cOJdqv5EFfUls30MHQNGux7t4uHUTCXR5YJ4HevjBsN0gAZlFYcm?=
 =?us-ascii?Q?VWbSpAAUlVcWH6mytWdNpdefXpFrST9c9A7rrRy8vImrblR+o1T1CoMmSlfl?=
 =?us-ascii?Q?U685cYrzsylE72V4b3ZWcNbkcNkSUyG51jkRxMMUTdy1MtedVzz2ELHIqtsF?=
 =?us-ascii?Q?K87r6+TEAr4rb0p6cdon0F/IW4RLNu3/7O86bRJY8sYQO0jtUOK+ReQ/lX0e?=
 =?us-ascii?Q?AO4CcJCwdXm8M2PQcduts3G3FaKFUNBXh9/mPqXqqePVsz3XmE3LVO2DCBiN?=
 =?us-ascii?Q?fuINg6giNcYIkngQMOI0t+w3hActxntbNG/S6LxjWwTWv0IvOnoSgjOPYj8H?=
 =?us-ascii?Q?cJ4gdCGlb/YaQFWCv+4SyQCMLASfZe1M1rUZzBMY7zhFUATgLHe6XoiojX47?=
 =?us-ascii?Q?v0KDIt6i0G08HEMBLtPM3IJkgmeJZim01cjX2mrrYOWkRfaS7SUkmA4xJU81?=
 =?us-ascii?Q?inZuV+fRIMCjBDI4eTjVfqB7Kasz/2IZoZf/dq+o6+ZVf6ZeZ9xs2+iOZcmd?=
 =?us-ascii?Q?AVq3zHg5hPevJ+YuWo/x4xKpn0Wsexp9G42159+uUVNJNuSrIj8d9Ti6yn5v?=
 =?us-ascii?Q?z/25Y3GCN9swRJ0kOUQAYYiAgQ989Lmk8gI6NUQCY0lFJAUO0FZiUJHob1hK?=
 =?us-ascii?Q?cU+pMYtfpRTAg3dTa/hLNxzr36eD+u12hQ03ioFQsDCBdBBumMrvaegxKwGI?=
 =?us-ascii?Q?jWgA0LpzgQ+JT6GaB2C50/wAEPNFkeXNCuCsI/N0VhH3nLHnjE217RRg+B/8?=
 =?us-ascii?Q?F22FrK2b6xkWWEw36rsv62HnIbEtI5Qz4plJdC8ksAbiDcIBnn7AycojKf6k?=
 =?us-ascii?Q?Z8er9Eu7PlOgkTARLFOjADWoq2+lXGxuMdIJlP66wimjPADCbsjRmbeoA+xG?=
 =?us-ascii?Q?A4r//uCKfzKCaqpXHp2k/AzS38o5mqbyUHz3cCjrbBYP+X1axHiW4evS4ltY?=
 =?us-ascii?Q?hhbBsRaUAI2/INMX3CE80laZO0m3jVaY2iG98nT573hTlFzGX/Mu5o0dmtVC?=
 =?us-ascii?Q?VkvQZv0JMa2KiHvCWE=3D?=
X-Microsoft-Antispam-Message-Info: l8naqKkW+968JHtj0oGE1+ikYjYdTylCQL5hyCObKn3KF4N0zTsYXssZvBr84ZKXqrqlZ3SVFb0yF+7dlrf+nCUVV4kDdpq1SYALRr2LCrEpeyUhtKd5YJxDiaWF+yB/RW11eo3Q2Z/Pmzp9EOQIJs9jzWHu8DbM7l2AOtgjOkJu/Y587V0V5Z0Y+mSgnFY2
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;6:+9krUBWGEwUNb0O/P6Cqi/GhzjjSJM2nYtYfk2b1J4HK728OTo0AWjmI3ZV3S2+2p7KexUZ2Om0o2QG9InlJGPa4nlnQMBH2oH4qE6iD/lYXu70sOWSWQGKfUcOQkDePYCpDEVm+klme7lJEyTmgIFgeMaY5oOUaWguxcA3ZZybGDn5gOg6iTuGFAG/gSHMMPz13ecSvwmJWUn3b/O5BGVZn9+G7D+TwFg1IW7CYDAr/eoocr8Xf8jlp1dMKF0z4mWXDYE37KPeMlre+R/Mf+WfjiRAevy83Gmhayxi9NA+HbjvaWDv+yJ0hGpSqM6ywhinbHJ2SZcUPvcGVwJ02BgLjoGydzNT3Yubiul7sjAPI75X7B+Gv+o2jgRq7Agp79e9Zf2245nAqVezXhJrwX18O4XVVlrZucwI1rC14Vv+L1qSjKx10UI7sSkMvoYuLveqQ7kWi6DKIhLb0s1H/Ig==;5:XCVNkFZKyAxRSR/7xHx8VZmtVzZf/ZmauS/2bX7WeNk/wB+E9KH92jzhl9gjLUQpFTx/R5sMzO4HVIaXixFSVTGyz3MzB2yM7HGZt6sgntDIWiKZ7jTTXcA9QuI+3oBdEtkb1p921OO064viGjPnFwCC/5JLzSHl5Q/MwX2LuKY=;24:D5Go/uxmA4VTSOBwnVMfcItG2C/Q4ETnG0/EIi3ftB8rqCQb043t04Xo4ymZ1iiU7FjD8p8LFhBHQ9day10IgUADev+3Sqzefm8U0Uk2h+w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;7:w4i2WV+mo/Z5uMh1xhHeKsWrRSEmtwT+JoYNhXnPoEylSvUzIDAbI8/jji1RFg22nlctXZxlM/j4dIOL9i8Iygj54b2wbupoauRWashK3/lhTWix0qenrZshSbOaAPwaa/KzLu9WUWXEJbnFWJ29lNTRzOkMsC+863h8Jlw7KJav6A2DehB0+i2MQKYRkuyhMQrOPNMqD3J4wut7O/b2rIQCk3bK18tiW56XTky0kEqCF1cgYYnia8oQF2pLhAuv
X-MS-Office365-Filtering-Correlation-Id: c715dca1-9548-44c2-e37a-08d5be8169b3
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 18:42:14.8123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c715dca1-9548-44c2-e37a-08d5be8169b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 19 May 2018 at 21:52, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> On Mon, May 14, 2018 at 05:27:10PM +0300, Vlad Buslov wrote:
>> Return from action init function with reference to action taken,
>> even when overwriting existing action.
>
> Isn't this patch necessary before patch 7, to not break things up?
> AFAICU after patchset 7 it assumes the action init function is already
> behaving like this.

I have re-split these patches for V2.
