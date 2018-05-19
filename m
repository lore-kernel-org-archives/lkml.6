Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750851AbeESG0s (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 02:26:48 -0400
Received: from mail-eopbgr10119.outbound.protection.outlook.com ([40.107.1.119]:16208
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750743AbeESG0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 02:26:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Sat, 19 May 2018 09:26:36 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-ID: <20180519062635.GA6352@rkaganip.lan>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
References: <20180518175025.GD6361@bombadil.infradead.org>
 <20180518153138.459c78a83c6bada41b4b187d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518153138.459c78a83c6bada41b4b187d@linux-foundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2a02:2168:e1c:be00::cb2]
X-ClientProxiedBy: AM5P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::35) To AM5PR0801MB1972.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1972;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1972;3:nRRVw2+4ETmxcxBLzjpFMMIbU5rSR0OtkLrxvZlhIHRs0kdwhf2i2DdCy+n/4xlA2EnMF8t4pyweUKkM7/eO0iPNA92VLlSf2t3c2kq6m/x3hzvv7gsbaMDECdfcP8sIL1Yi6LGcbVmSaGrxHUGZ/b3Oaw5fa6nNGAIwwpdpwwslQ94qgpIfUnmmySKyV7S1uOU8/p4uQH6O/GA0oRHhdAk6pEWyZ+dgfcbTXQfsr/6necOp2r1eZjb8Z/gmwyWm;25:DC6HJD01Y2ZH8cl6N0ATdN5RedhnHmwZOywU2aq6j5FoMZkuVXub/zjDznUOUoCw3ZyKQQob8JlVFT6WXLBd2sA1xmRNh/PVJaAt+7/BzxUuKVzUlv7zEZak1gZu/tHeUNQkZ8jUkzWOjDYlU0/GQW2jZO56WWOURFxeMSfloHBJTx5sZJT8KrLj0Y6kUrDw2/LnqHculsyfufnur6dwHRO7yfSoZLB7H9V4le3sWULQiSUM+JhexI5fF/Kp0TfwOphvMoKlSmLDXG6eETZICG0L36+VjHjBJ8igsGCQ4WpUfVYV48pUWWEytMFKkoIYsBtuJQ/wqImDaP28I7sURg==;31:pDWM/q6tWcKyEX5hjEGR+g/KkdJ4nlpdTNZisBrtae+dvZM4L+8WXQiPVQDBvqkDJZftgst7RkJmgFOIeN+iQYq0qy/++14j817nxk8aOVS6FofQoptlofl15gLGd6VtemGpK/CkNDovtbaFHMcwS9tSACjk05jF4fjf4raaXWD5MB2DsPgv3ZsIxjUqtjFxnRDvJc95AbVU4K3yWqr50mUN9BV6My86PsmxGTpgtEc=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1972:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1972;20:UHUw1nTXdUB2j1BkExe3XyBuqRrl3X9fqVPPyfVSh7QrrClQc3Agn64c9oVTG6NHu/03PW2R4QDqwEae5OhSLMXrG+9Uh8UZC4EBLbs2PNyeCkTNHkbEBo2xWTnmdAE/a5xPP1SsUZCp4JjgadLhL0X0k+A1BoAr9ZCDNTlHm/xRAq/wBG+Pz342yqcRks8GrG95dhf5LEgwlkQCHErKh9OHNKFsDI/jnB4Sikzh5k34FokEVDWytHWTEaj5ZjedaeidUKZfpEjFRKk0JcyXbkQnIFTEWxTYGyPwbImNuX7NNTWiJurUxt3xyONdTFKDZU2ty0YVCgXKI2MghW7YOnlfWi0Mkyclus7m1zKzP0wolHVgZ/PK2DNDaEXi91m3Bb5qIEE6O/2GpuOHoa3YYbyLDBW8cPl0JyEaAyZ4nLughGY+PVhXJXzRQtKJ6MvFF1SoJ6IF3qWJiWYrG0nJHpClPkxuiEeUkD138tPaM1uKpYHalV+9oiIZwUPbu5+l;4:zIwDpYwLNd/HfQdgaYH4NqLPyKrloawgOyZ3BbZ57As/wYnnusS/ODFNe0xaNZT2KtviZbzyNoqvQJ+CfY/riz9YZS+wFuCPZVig8dG9e957dDl0BaAHBsnxLKT8zapaH3xKifdVF6DlrX3Re3KSTLVOBn4E9KIgCq6ke669hNkDJKlyvof4AHnylKdkFtgwrt7G0IdpKhA2swRk6zn8frs1t1JaNrk78qjHX2xFJ0Q0nodmN9jeQ0oj9P8kcdwo9qcEzvsc7OCmo0FH7p2OIOFC/BBK1wMHpmg01gDN/d9HT2TiJtvckkIQEOGNlasWzEawUyyoPnzv8Cmq8sPHZ9/Q8KuKzWYgv1mnIazmExo=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB197292AB804A3C211590B6D0C9970@AM5PR0801MB1972.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1972;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1972;
X-Forefront-PRVS: 0677FFABBF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(396003)(39850400004)(376002)(189003)(199004)(54534003)(229853002)(76176011)(23726003)(386003)(6116002)(6506007)(6666003)(6916009)(97736004)(7696005)(105586002)(68736007)(59450400001)(106356001)(2906002)(46003)(5660300001)(47776003)(21086003)(1076002)(8676002)(81166006)(81156014)(8936002)(486006)(476003)(446003)(25786009)(52396003)(52116002)(16586007)(86362001)(58126008)(316002)(575784001)(16526019)(478600001)(45080400002)(33656002)(11346002)(7736002)(36756003)(53936002)(186003)(55016002)(6246003)(9686003)(69596002)(4326008)(305945005)(50466002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1972;H:rkaganip.lan;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1972;23:Higw9fgPAsc2+pebKPyHzjXxkf+3vuVITI/CA5u?=
 =?us-ascii?Q?OylxN+lIWKaked9YpXNystQnGenu3Lhi7d3OrxmfORKJcN/3UKP1iRthqra8?=
 =?us-ascii?Q?6z3v6I74D/exTZs1uE3gwpWuDDZTq2XLVbSxYsJTAI3KPI2HWrr7DNgXR6gP?=
 =?us-ascii?Q?LjDy93pQq4XedqegdsEqND+JPfUQYotHSurt9eYvn1EXrGVORIDegivUEiWS?=
 =?us-ascii?Q?Rf0GhQz72lUf3SdWW+ILIhnHAY0pswKKPJhWC1oVKoTkkqOzwJ/DXAOSU3ah?=
 =?us-ascii?Q?r/xTP1YjC9+U4xHS1/PwoQ1XCW9Dlr8PM0axL4OdFKyPf2M1vIGAqCkv4fJQ?=
 =?us-ascii?Q?BB2T4YRQITeDySwUP19uecdM7pa/vPKujtrr4clMWXEtJxUeV+fVgSHmlU2s?=
 =?us-ascii?Q?++D1j2bgn6mAJu68Vcz93GH9hVv4G6NSPHRG4GcGXgODlGniCokCrcrv3JTl?=
 =?us-ascii?Q?85VWWlLDJURDpuU0XLF0WVYGfYLrtCnxNAfi3MM3pptN3w04HgbWTv8C4Zck?=
 =?us-ascii?Q?HqvXyYXEwhJpFHD0I7X5qpW81nBg+PSU5lYljKBQnqy2pc9H11z870oCXZ61?=
 =?us-ascii?Q?NqwyA/FE4O4QLImBtgeCpfH9JpJqnSe5GmmNDCwv3oF38HaHvfBGajZYAzAX?=
 =?us-ascii?Q?mTefLI0OJ0VACk0aipuARtINZ7MJBHvFQhu8A61xD5QzDbLU8RxwMXYF3B+o?=
 =?us-ascii?Q?MK7WCS8Gplb+lydN04dIJufxYXwa1zr91Kq5quG5qOLd7IDXE5EvEKij3eeD?=
 =?us-ascii?Q?XHKhPtcx64vn0gN9ImwPJP7MaAxDHsmlh3ghHDnCE/p3oCqKHZ8QV/BenPWg?=
 =?us-ascii?Q?0sW2td40wj+3QxcU7LePeN2j5xs4ipSclFr+WNacXwCfWsZ5VXR2lwBdUJos?=
 =?us-ascii?Q?8sFfADjmR+rwRh3Nzv+UrP5PkEkY+2JX9W1hWZTjAFz50P6qbtKhwyQTp/mP?=
 =?us-ascii?Q?opTdECpT0ts9M6KUrJJjGiNQX3JdcoD9ufYe7EI6YAQvRb3nGq/CQWsk964H?=
 =?us-ascii?Q?ys626lcjp+ZtA/1mhAXdxjEja2RBe3z+b1AWBJlP0gcaBG9q4rHQtXLp0d/T?=
 =?us-ascii?Q?f7Cujpc3dwbXJCFlm9isG59bZo1jsLclVWSbA7Zbu/YxmV+bgR9DDTAwA1ur?=
 =?us-ascii?Q?hwcd7Gg7IVH/bJhWOiJE/hcNP2s1yDaxYlhDAcH53gA/sO80diYTOa1/zLcn?=
 =?us-ascii?Q?HDjPj+MUZ9MzeBnj4UL654R2j7s7jjOZA1obF5gbhgxaLPwGG4JQCbhhD5ll?=
 =?us-ascii?Q?Y28l6MjRAsrNfDBd0S4jOMytN8cjJqXp2BLtfuCcJOXsGzlYdY6ZvnqsiBzc?=
 =?us-ascii?Q?AK0lBSiZ86YnFFJi5zY8tmC94N1ujQ1hGJ1F3gnX2jGol3bhwxLRrE/l3xe0?=
 =?us-ascii?Q?IPBDtq6gCCFMkHOa2o6Ee23xR9v8=3D?=
X-Microsoft-Antispam-Message-Info: DsKXG/4+QEQkJtrFkeUpCM1RgBkuAEakR8xp/Dzmr1lgUjzvdLdgtfxgl/lk4hbPoCWo+fF+zQD6sX7cfSpJVr4iJ0WIl7Uv3PZSQWhOeSTO0ZQMJ8+oYnISo+jM7VfmChOVgJYRErnbvC2cKhLCiJVnYugDg7inScYNDYnyGBfsLA0ZxOV3JiNU3t6z52K3
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1972;6:wT8HhvUltEDV3/GmQcjcEHLHiuYzpDOAASsuICHIvdliJuRYF366rqwzMZjkbMx91M2gj8bvdKiCzTzvRkRpiRIf+XxfRB0KFNwbaJN243RfxZVuEjyRZc+/oK6N+DpxeAKoj/H4k1MiN0+kZ0NtVb2GJ4eD5D/yDa+NdtHBWGV+qnRKjQ4mpoEjLkdaNml2x3/hFbxEWljHttbI1tSsAur7JO6gGXy8/K7IMAUs/lYnJRm4UNmVfT5NTZCTMOEYuzCKPU85hnPggGq3WUWSgFoJi9Gdk7S+Fq6ukjyaJgIow8S1TAo5/wLVgFfPi+Uj1ZSpuOJo9l2FNFsoZYdhXj9HVoN09Rc/8FBqxoax6GeffXhvthLre+lcasfjeYQ+9xI6Ge3zsKTLCV3IbjTTMutZyR0Rxuk4ooqM9yfvujD5ItcaxBzOR0ip0MibOLsyrYfrXvTgPv4zQwEy+ltNCw==;5:bgUriFq0IpZ/HSJcMKo85dJDN3i6npARVC24NdoS4EcR3sHsUGORwzCrXpdVdak6rJqQ5phpP7/ANbqKqXp6xmvY21MTL2IhRJKpRq2OdAObDVttcSmKmEyFeAKF4+VyeYxSoTnaf+WBABDdyNXFr/DbZGq+aNrabHBVghKc7Sk=;24:R1MHr5Ftxfrn5utIPYtHL8JX+wMXoV6akTeLfWIuArakYs+oO6VVmESbZ7WGmmR7vjW0chwXYB/K7yYDbjx737My7F98PXNalad9uJLEIpg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1972;7:VxVX+VpKSxqYoAGNCKcSbF+vEckjNKnQ29kUaJwHcxR8rKTffqMxQfPerLsbo51OIyPYZASadoD4/YjvE+qpIv8JOkj9uYfxskY5Z0Lw5KqaLhxT4OQoxCsHFrk/gv0pv+YieyjLAw451xlFMHfNDr9IFSQ/CMi406w27iRbWxDVFr/ELFqU0jntmMLRRfSFYjD4p+KyG3qHdiarn2gdBz+XoNrpXpdei6cApj7bpbhD4A0kJXSpXWJ7uc6lePkh;20:0C6mXSouJp3EIiUg4fZg5IxzqT2h2m5CMvS4jVBxQ45sx8TmBumBr9WiLkDzI8JkTUElhT8p1R/SSmsC4RGKbsIGqjP/DvC2XgIl4//Hd4zRmlrzjxmPt9KQOVqQkIkrZv3CQBXJF0N+zRAEeGJebTkjKpLg+9Ulc+LHcYtmghY=
X-MS-Office365-Filtering-Correlation-Id: c427d1eb-492e-4918-b520-08d5bd517b17
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2018 06:26:39.4992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c427d1eb-492e-4918-b520-08d5bd517b17
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1972
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:31:38PM -0700, Andrew Morton wrote:
> On Fri, 18 May 2018 10:50:25 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > If the radix tree underlying the IDR happens to be full and we attempt
> > to remove an id which is larger than any id in the IDR, we will call
> > __radix_tree_delete() with an uninitialised 'slot' pointer, at which
> > point anything could happen.  This was easiest to hit with a single entry
> > at id 0 and attempting to remove a non-0 id, but it could have happened
> > with 64 entries and attempting to remove an id >= 64.
> > 
> > Fixes: 0a835c4f090a ("Reimplement IDR and IDA using the radix tree")
> > Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> > Debugged-by: Roman Kagan <rkagan@virtuozzo.com>
> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Neither of the changelogs I'm seeing attempt to describe the end-user
> impact of the bug.  People like to know that so they can decide which
> kernel version(s) need patching, so please always remember it.

That's my fault, Matthew may not have seen the original discussion among
the KVM folks.

> Looknig at the sysbot report, the impact is at least "privileged user
> can trigger a WARN", but I assume there could be worse,

Unfortunately it is worse: the syzcaller test boils down to opening
/dev/kvm, creating an eventfd, and calling a couple of KVM ioctls.  None
of this requires superuser.  And the result is dereferencing an
uninitialized pointer which is likely a crash.

> as-yet-undiscovered impacts.  So I'm thinking a cc:stable is needed,
> yes?

Well the specific path caught by syzbot is via KVM_HYPERV_EVENTD ioctl
which is new in 4.17.  But I guess there are other user-triggerable
paths, so cc:stable is probably justified.

Thanks,
Roman.
