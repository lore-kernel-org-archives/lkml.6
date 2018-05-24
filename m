Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935689AbeEXHdK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:33:10 -0400
Received: from mail-eopbgr40133.outbound.protection.outlook.com ([40.107.4.133]:45235
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935580AbeEXHdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:33:08 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-i2c@vger.kernel.org,
        Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: Re: Problem: lockdep warning with nested instances of i2c-mux
Date: Thu, 24 May 2018 09:32:53 +0200
Message-Id: <20180524073255.22495-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0174.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::22) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:n8GBv+gMW+lMLnFRYSM5qDiuMLUt0T2UxfRwMMFbkxrvn/5SzDbPIztygw9zBgR93Jb/07yjPQ3TKrDbjfNPPRhmU6NEEGOoH7Df9POPopF9HDEtXohgRIkwOGm7c1LAHgKWRiQuYfAtx7QWOVxPliF7fjvxpdUpSCk2elErYTLcQHLQ9rmWGNk1Bb0qQy6lmI7P3gnI7aOZqcafKMBFex2fvhM5kJcbHCSKAGU9XvHynw+wJaUpGtM11M6vQCn/;25:dLD5lHYRU0RIZzk3SWDV6I6rX3h5Vl9O+pYKudEg/DG6hFedAo9+ne92WRsCHpiXOdUV0wHTYr4w3fHvvmSz7hdCYz3Rg9AhJocX5A0GvV2fo+I+TDryF5BLc3AhLGIrbtGlovbROu381s7i9R7Sk3HVU31YmQltwITcdWZFAj1TrdkDFcIcwaSCFieHL3Jd8ztew0twEGmOf9qRVXaftOqX9SAi8r3fFm8zFh02+/BRfRToZJ2fgYaanKNdBwhTCqTDDV4raqC2N7dygY0/ktmzqNvwPSshKKiyl3NRET/m45Oi9U2pFy9KFfJgfe5uLoclkHnjvH8/tHFk15RJqA==;31:jmo3rJHGBr8GNWaDU3eAVW4JY3TzcB3O7QF9G9MfDnxldhdRSG21A5ws8ov0Q20n2G+uBMOPT1Ie9+v2vhij9Al56Ka5Jqep0fhqYh3ojZi44kk3ICTye8dHYfTsVSSrZOAjJZoPxwF3DSxo00GvvQdlS5ATRBCUR8krnCLH3NZ4U1cFipyBuQrop3ns9LvcOQw1eS7cvbkZvU+tsWAgpSzABgUQXLYRQ8JibBG2ILI=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776777C4AEE7B6CA8825336BC6A0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:QrZhcGCLPYaCPT26CNZSRasPiXbZk97KNyPXvGCxKTcphAGdam66DovS1DeJdvcXuB8n9yb0FPkt7Ibq3FQWG/cqNXjyZif7bSRQ5na2NxTvI0BZFNByWeykiRluLwz4Q+02EF1VNYTNv3dvFjnT0hb64N8KQfR+HvVJP5DISxYlJfwJaOKzHl9BGmTQvPcCR72hMGC5eYBLozIRbGhAEeb4GURvOkfXxlBcaZ+p0fhwmQ/E/289qLoq6C5xp+mzD+cxBQqtNfNacRvKVn+ArA==
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(366004)(376002)(39380400002)(396003)(51914003)(199004)(189003)(377424004)(36756003)(2361001)(50226002)(5660300001)(2616005)(956004)(446003)(7416002)(476003)(25786009)(8936002)(16526019)(186003)(486006)(53546011)(6506007)(386003)(478600001)(66066001)(59450400001)(6666003)(47776003)(26005)(6916009)(74482002)(2351001)(51416003)(76176011)(52116002)(86362001)(68736007)(229853002)(106356001)(105586002)(1076002)(4326008)(7736002)(2906002)(6486002)(48376002)(3846002)(305945005)(6116002)(81166006)(11346002)(6246003)(8676002)(81156014)(316002)(53936002)(97736004)(50466002)(16586007)(54906003)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2776;23:Iw8L44pg9NEcV5exqRPxvE+HMBhvq8oSizRzTi5?=
 =?us-ascii?Q?TLAMp4rjmMAzyyYJ505hFvV0Bs5WICySHwkd5mS5DUTNLEvl6wm66/3DnGNg?=
 =?us-ascii?Q?8/+Eh9VAuULM/P98sRKkBo0/e4g/IoxQgnmIyZ+riQIrPFi0q81vVBHh8YeN?=
 =?us-ascii?Q?pnXI04+AeuJqB3ZwohqxxjtA4W+VEQbw3EcIUatyOlztJ+w1EHh03AbQmA5J?=
 =?us-ascii?Q?AlScGbU05FH0mumWP+6G4eycn82M4iPUPXKioxIMaRkrwo6P+Y0h70q+2LCx?=
 =?us-ascii?Q?Oc8yu1tXDKP2hzckHZnJ8dtK+MXJAoEl9YewSr5OJJiGPb3E926kIsSsyw0f?=
 =?us-ascii?Q?tuYefgjAj2/mkH+40miHjNdqXQkYtLTiG+iGdooMSvTy2wqSRFWFVf8+2VTq?=
 =?us-ascii?Q?Ly3OCZ2n3iH9NzvC1mdR9s06tOFUeSRpWMCjOUL7r/wJJaOx5TezeitoQ1jE?=
 =?us-ascii?Q?BxzRGawDvLunohaQMTd1xb7OzAFPXygnjLkBLPWgGZx9Cr8qp6KO7j16ItDD?=
 =?us-ascii?Q?T9gJ2MrRa30cYqTQNcsUQS8Fj1MzWU7Pbj70G4QxtAmCwf1W7aNk0w9miq7O?=
 =?us-ascii?Q?Mj4HWfP62X1HtYJWRGvxPvriNVzew4wIwE0RE7yRfha/VAsudbPuTQ08qyxl?=
 =?us-ascii?Q?EJGbUlM5LqSKR1hsZxsGMyXw3Au94VZHmBIxgsZ+IX+VEKlrVaYdZwWpKjCR?=
 =?us-ascii?Q?OsTVIBaT+w5Rk7DktL9cXfH1glFuSR3OodZvZ2nbY4BWoWilCWMSSB29rspD?=
 =?us-ascii?Q?SSIhKoyIqstttemsJkjiMh57LG9z2fIK2v27+vbzkptpPXzgTgRAK4OVMhKm?=
 =?us-ascii?Q?zsJpcsoxpvmjQBNCV+aRe05lkoGFBWX1D5/38NBJwUMSoC8x2PHhA/XyH/MA?=
 =?us-ascii?Q?1qnJLlGKA4XxhX2PrHEYi8rWV9EDFbr7MaKXpG7e2WJ2kkbdeL5YsLDIChuY?=
 =?us-ascii?Q?1m3zhFORGzpcWTjMVA04EOGz8rRfoUATHSaAOZq1McDfr14WzTCAf4cbdEis?=
 =?us-ascii?Q?8evZgx/xvrAAusxDY7jDF1Oy/t4yLz8ra1tflhhUIUNYs/zr+V/4s0ixufHX?=
 =?us-ascii?Q?iE6xowBVrOEvvpBtMmNaOgUDLdLBLFk+6538LLbISKqb2rQgSkb4YF18h5bs?=
 =?us-ascii?Q?Rz7V363xac6g1lJg5FQHznR3bJvibWCPCuLTpkTOimUrzGNtzcLQmTvSHh1P?=
 =?us-ascii?Q?zJmunebwXfDYYRRbtxHEBkTnQHeNUukEXKSvdjT/1oSJGWDkM6EZ3GOVRhAH?=
 =?us-ascii?Q?YjY03I1HFpG1OyXHgXTWVBjD0zNRNTRUHmG7mQScSFnaAO80MoxJlPt8zU8m?=
 =?us-ascii?Q?v0GkPTqPmqI+KHNlkQwtfBNF3G7Wc01eswNG49N7IPbB9y9EJeUy6WmJE1xu?=
 =?us-ascii?Q?IVVaDGvWcrwmdFFL1m2WwW7nG5YC2vLrCQuAktY98Bvl0eEJRWW0E6N8xDYB?=
 =?us-ascii?Q?TknMOMqcsYmWN5ouj9x1/VdqB+Utsm24856he5aDsEuPKTxJNNyzg?=
X-Microsoft-Antispam-Message-Info: dDOHNQqCsaFbPGZLoiDI6E4ir9IdHfQB6Zz3p78gDXERxlk449d7frX1ersyVPZSGJiOXVZZf+R6cAXjzpNCyIcpyp8SWPjnOVatF/ju8CV0rNXlO9c+m8IWEs+JaHm6pl9jneHnV/AwKKS+wNwu6oMjCvrGJuRw4TiTV3oTykXEb0yR+8cpnbuTooWkKcHb
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:nN7vjYQcQsOyyw6cJTTxom9JON4LZL85dyGZAuqVQ0tOdCNgnZd0KLcS9zHgF+pudr51RX41JAr42Sk8y7XcYLQT3oQCYWYSONhBpR2d9+LvqP6olBUPZfZ9tIcZrQg6wBwwU7B+Krzt1PfNa9hOgpcdpdji8wIdP5cWPA7lzutyYWiN8Iyhe/vkTLV9RhZg3TABwQHiZjKRNhwInrZCTBkUo/MZwhyOPgja87g/4eOnUy/XTzIPLA12YRP4A6l+LkNrpRStDjZ+Vxk2a9sq8YrV/ATrL/kw2BazFME0jLX5ME5+olRIVS4lCpU1dl62tONTI4rLCZhn/r8JA67dA4xBgiDsnH/lUIBQLXH8whlyQcZRPYNlmyg9WULy9USxL65+q1ZnS0UES2FX3yJs6ODJe8zgKhs/YaEHoQb/jDE6zvXFAxNaIc5WoIbA460F+E81qmthftRY0TLd0qHPvQ==;5:J5otqvRiyzQeOknOXuk+H/zhpzTYz844tAWabZ8DcbxaQtInpIHgvnP6qo2DQ1RrSfJcNHm8aWmLr/KjUQLEUwRg7u6Fx9h2msAvGi8tFRC13uIu+0UGLkXG/JbwLgE27AOeaDmbIXpB/3mEqvqSbt5fjHmATkSDwY1F9ZkKVpI=;24:kv/W68TQLyqS+BdWYwou4VtCUr1iBsxHItKGoER2AMov8nupReQu7DUcU9Oxs/HxGFiNLrtMTLzVpDQ3/kTbKPcTD6vrUc+NmZi5Xgp0C8o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:+CjDUUpYR1wijMKmABN/yhmpXOn2eyU5ZkXTe9SWczxizMHtsQa3I4FLnkqRG/aqECVwnmmLcuiJVNOKNP9dp5sFu1AKrUvI5kLci9Z7XR0gxSyddtENNfP40cY5xUVwLLydcx/XUbgKgOEHDVQgmPWt051m+rnstDCmGM4VGZORFIHbk6lSt1O6fEJiC266GbNz8PsA7bZnfxU/GEWm7ZVz9/dj1UxMaZJly4uLBdEVynTDFuESduf9CIXwoUxc
X-MS-Office365-Filtering-Correlation-Id: 79546dbc-ee91-4553-5cc2-08d5c14896b1
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 07:33:04.2805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79546dbc-ee91-4553-5cc2-08d5c14896b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-24 04:25, John Sperbeck wrote:
> If an i2c topology has instances of nested muxes, then a lockdep splat
> is produced when when i2c_parent_lock_bus() is called.  Here is an
> example:
> 
> ============================================
> WARNING: possible recursive locking detected
> --------------------------------------------
> insmod/68159 is trying to acquire lock:
>   (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
> 
> but task is already holding lock:
>   (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(i2c_register_adapter#2);
>    lock(i2c_register_adapter#2);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 1 lock held by insmod/68159:
>   #0:  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50
> [i2c_mux]
> 
> stack backtrace:
> CPU: 13 PID: 68159 Comm: insmod Tainted: G           O
> Call Trace:
>   dump_stack+0x67/0x98
>   __lock_acquire+0x162e/0x1780
>   lock_acquire+0xba/0x200
>   rt_mutex_lock+0x44/0x60
>   i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
>   i2c_parent_lock_bus+0x3e/0x50 [i2c_mux]
>   i2c_smbus_xfer+0xf0/0x700
>   i2c_smbus_read_byte+0x42/0x70
>   my2c_init+0xa2/0x1000 [my2c]
>   do_one_initcall+0x51/0x192
>   do_init_module+0x62/0x216
>   load_module+0x20f9/0x2b50
>   SYSC_init_module+0x19a/0x1c0
>   SyS_init_module+0xe/0x10
>   do_syscall_64+0x6c/0x1a0
>   entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> 
> The warning makes sense from the lockdep detector's point-of-view because
> we are locking two instances of a single lock class.  Normally, this would
> be addressed by using 'nested' variants of locks.  But rt_mutex doesn't
> expose an API for that, and it's not clear how i2c-mux can know what level
> of nesting it's at anyway.

Yes, when I modified the i2c-mux locking a couple of years ago, I also
noted the absense, and even tried to implement it, but eventually gave
up. However, that was before lockdep could even track rt_mutexes. Now
it looks easy, and I will follow up with a couple of patches (only
compile-tested, please test).

> In short, I don't have an easy patch to suggest.  But I'm not very
> familiar with the i2c code, and maybe I'm overlooking something that
> would help?
> 
> I have code for a module that emulates a chain of an i2c adapter, two
> muxes, and a slave device to show the problem.  On my system, with a
> kernel compiled with lockdep enabled, loading the module produces the
> splat.  I can post it, if the issue isn't clear from my description.

Not needed, the issue is known, I just wasn't aware that lockdep had
grown knowledge of rt-mutexes.

Thanks for the report!

Cheers,
Peter

Peter Rosin (2):
  rtmutex: allow specifying a subclass for nested locking
  i2c: mux: annotate the nested rt_mutex usage

 drivers/i2c/i2c-core-base.c |  2 +-
 drivers/i2c/i2c-mux.c       |  4 ++--
 include/linux/rtmutex.h     |  6 ++++++
 kernel/locking/rtmutex.c    | 29 +++++++++++++++++++++++++----
 4 files changed, 34 insertions(+), 7 deletions(-)

-- 
2.11.0
