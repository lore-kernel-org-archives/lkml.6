Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755213AbeDCKAW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:00:22 -0400
Received: from mail-he1eur01hn0236.outbound.protection.outlook.com ([104.47.0.236]:59808
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755172AbeDCKAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:00:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Tue, 3 Apr 2018 13:00:04 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: x86: hyperv: PV TLB flush for Windows guests
Message-ID: <20180403100003.GE2874@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20180402161059.8488-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402161059.8488-1-vkuznets@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0058.eurprd09.prod.outlook.com
 (2603:10a6:7:15::47) To VI1PR0801MB1981.eurprd08.prod.outlook.com
 (2603:10a6:800:8a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59f5ae08-b9a4-4ca0-377c-08d59949af68
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1981;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;3:wEwfVXkislfI2WYjQw376ntSIIbh0xbikLL34Q0ffq8ufzN9rKbwWkG8GLxjmday6lqJNcoVHoVBCsdmOEvjihx1UHXv2RiaVwx+8VDCl7RrrE2y+NH1F1K6WRoteC5kwDFvi6Xk399jTdq1f9sCPe5tOz4inYUZ92w2KYpOwZNAEsdRPQIZH+ZnMVFwRu8C8fipiF90hKpfgvS7Ihpe86UnQ6YMpmN7WQx4gHZiXNaRLFgjlMNSUQQU4AhXHCa1;25:9999uJKcA2fSBWBYgrkDUE2eMpWsXYUf4V8EElpvs/tik0fro+/cRld8IVaS/aAlbxEoeJUA74L3sYm9rWedUyEb38jyRxeR+6zaw2aueYXsgaYRLxapfUVMPNBjP711wjQs3ylX497VxnU0ljwI49yMEjKb0oceUO/uK0G1LVy5pw0Cpc2chqzSlFQoXIBFE4aQZoEy9H5A13eivCWAM3mDZ22rOmst85VLhYyOxtcbFb3+geuajMlEc1q5+5GJcAZwPp3612RgVmbIddF0Ayz8Qr8BLSkre0a+Yd4puUSLZhqupc+OmWLZCQpdijAqb4mWPLr986cyxMToOiug5A==;31:qahXeLU9mwRkIo711VpoeuxMAfxbsXi9pkk3KTJsw8cKMiGqxGXAIXWmX6jBHc6YgBoaLWQuhx/NOdrikSyXEqZrU11F1HkCR6N68rW81/sVJBQ43ssVVKg/rAsiCSX8ERJncJocgCJhAQlC2jYYPdQV0RCr93K6XAPpUoMlHm0BPFkImmNP0YxV1D9At0L1UeDXnczMGlSvnFEBdtAIbodNhts3eRGT9HmaF85yNp4=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1981:|VI1PR0801MB1981:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;20:TgCAkP2G/0FSSvd2wWqWYuWK5dSTr8cfiK9rCfurGKgMix4K2bjypYQRpQQLsbXnJp4ix+fvWeu/OaN430JxKDOkD9v4k5/8/8GMP4xj95hgMmOwywhttJZL03glJjKC2ZxX/6kkFMLVxRzChKdfhXS03vHII9EkVoxkCerXKtOV7kEYDuAA2iPrHxAuyjGfc9+YD2c+4Jxibk6V85Rp9V1YWmj3chnv4TTF9+YWsFTGri4vrWT97Ypfb85suFV0HuLBIuBskPk9W33XsRlKSnCiSKZan0vSeRcx3e3Cgv7YJoK3Qklc63CkXpdt961deq5EVzCsFpaKdzvz/a4IdIZhYd7u9T3BRya9UbcJtlxLXCoj+KrUwvawx8+00AhMxDCh0CYNJ2Hd6HHm6qVsYqPFrZgtNDZ8FTHvD+lAMJEsWmmqDP8nxKCsrD0AVLHidNdwq5onfmizAgm7qum0ESsl2LwGWd7dPxZljDUOcVdkDE+c6RVELlnXSeriTfeA;4:vVw3VdJfPbaQ8zglPhV4NoFyfn/T1dzBU/caefRIs5IvL+h70QKQuOupywchtQv3rcPkmID1slsGYKcms2VbUNdb0TIXok0bCeIxElAp26w/Ywbu/K8qQ+XhuJBpMalGcdIliYxt9/wsmL+qLMendJi0E4tLUBSuvkELeln5RALJLD6ROf3siEayxGKCT2ok1WFSBOsMDsTcj/WxwLuk2YafDtG2+/eXkg/nqSHkiKetRygl1meGBkSy4LbX0TyVmgOGELBZ4Sfm+geLZ06zdl8fN2k33GhR/4WNfVC3ccWtu2K0GXhhmHKOGqns66OA
X-Microsoft-Antispam-PRVS: <VI1PR0801MB198139295EA7566D63E43D0DC9A50@VI1PR0801MB1981.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0801MB1981;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1981;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(346002)(39850400004)(39380400002)(376002)(366004)(396003)(189003)(199004)(25786009)(6246003)(476003)(486005)(486005)(53936002)(97736004)(7736002)(446003)(305945005)(66066001)(2906002)(9686003)(68736007)(4326008)(956004)(55016002)(8666007)(86362001)(47776003)(478600001)(50466002)(81156014)(229853002)(81166006)(1076002)(6636002)(76176011)(36756003)(55236004)(16586007)(5660300001)(6506007)(8676002)(3846002)(6116002)(26005)(69596002)(105586002)(6666003)(386003)(7696005)(316002)(186003)(7416002)(11346002)(59450400001)(16526019)(58126008)(52116002)(33656002)(106356001)(53416004)(8936002)(23726003)(110136005)(54906003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR0801MB1981;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1981;23:lIvWKsKP/DnUbopBiCe3+nzW7QkZ1dfFUlXp3Uo?=
 =?us-ascii?Q?yRXAiZvVDKiu++B5lU6covP8z4Nn9YnCW0CLV+Ab0OpFzPtIow+D2AwCCCqx?=
 =?us-ascii?Q?7Vh1wyap9bGB+HFOmcxLmahS8iy3Ma7TVLiEVNhbO04j+yrRP+QpKKmucBg8?=
 =?us-ascii?Q?9vqh8AfV3ioTog3PJmYBxA1eYpsTMx3+QGbx0DFHUgKC/UXH1TQm0PYrWwv+?=
 =?us-ascii?Q?clHVj2wVK1L0x3D1nCBW3D4VKXgQ8S7XF2X47No8y6n4xRPLnpptXWFfR4nm?=
 =?us-ascii?Q?9nlCULWjaOtEtV4dIZuXMJxn3DFgyz3h51PRW8sKqQzyfMpwMVwqnG3rhNvg?=
 =?us-ascii?Q?6VIDXGwtbyhXCk4jjVcwS8DtFnq71D/EPGS2l15sUoaIFNe6K58W/jKp1KTD?=
 =?us-ascii?Q?0KruCfxjTAcXda/cLQaWhthEThOu4paTF4d7ZuZV5xSYV4AelLjj1g0KJ5s3?=
 =?us-ascii?Q?cLk9Krss2Vw0RAGoWTzncSv2F3wjLOW7HKk+em6TLmZOloiwfbEBuD5qii0V?=
 =?us-ascii?Q?WioFzE7PRaQ9V4IItekT1g6TtOknrlICGKHUlrW+5nQkjx5JOcY94xiPsIUH?=
 =?us-ascii?Q?KJt+Xx7g+KgraMQVPvihw1BgGfxmN+VBiRoriSut0I10w6fpVbeYxjnOACI+?=
 =?us-ascii?Q?uiM1r9lSDe9O7XBdWuVgF5jqKoVfbA9FFM6X+soUbwNQEWM9IeoUKCfF2+AL?=
 =?us-ascii?Q?ipe+gRnn3AqA4qDwvQpMj3KDC5F5Ef/FTEs1o7Vhbu0JZg15xCpcoNoWzbhL?=
 =?us-ascii?Q?ctauLdywbsHhheFntsFS1HrNXumsMl95wdMtXCQEWEGCZt5xs20qnlOpx98G?=
 =?us-ascii?Q?N6oxxxQUfFxYg+sBkY5cbPDboNBco8MgkawR8eCKlMJ6UnelaKwUKtZIJGkO?=
 =?us-ascii?Q?PZCaPREsziqDRS0ecntXhRud70y7pDCWvQkY+RzMum+oo8S3f4vcnRQX9Eog?=
 =?us-ascii?Q?bULD2O6q+M52hN/3827IZ2+x9u2npEn4p5wTtklTxvEk/MRP97dsqQzKXn3F?=
 =?us-ascii?Q?lThMBUgFOgQXRLNIU1wfOhcliAHmMoTh0O03it066b9F2CAjJIt9RpoBqk1G?=
 =?us-ascii?Q?00comr9NNQSQnVdX96Z6kEcjWnTT/en8QJLiEjGa7DSOf1yYYS2Dq/07j8Hp?=
 =?us-ascii?Q?e8plwzC6ZzHHwS8CgqHEq5NaQvLBI+gkfZ+5oY5MAqN2f3LWEcHT3DoVHp5e?=
 =?us-ascii?Q?WRnjroQpFabSJT5Hdd9bKmG0/RAIfg1oNEl6TzAgqY2I+swOmwZllLqb+vQu?=
 =?us-ascii?Q?CMo+RaPF+6Rl5co6Pjocx5jSldCbEav370LGjr7mlh3CGs66Z1e7w3qzRoO9?=
 =?us-ascii?Q?iyZ4NhBoSiF/D3rKp2fCXsvJdrrZgh0csvBmnVBTwfoE5ZYCHiEQUq8bQU/p?=
 =?us-ascii?Q?Trj5tyBbVm28XaZ3e5gFnod3yneVziydFE3z6M7t4v44/I0OYLUkIYjCKG9v?=
 =?us-ascii?Q?S9bAHtAOt8nXP0mhxHbOilJC/QIrJT6XBnKcdimfNRBrI88TVW0J8EOtTb/7?=
 =?us-ascii?Q?4oTYgu+g9vNxlQg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;23:SivjaYLD2P/qkj6lUoglMHodtKxSDkquheymsYnuYMnyPC4nbSqXEbqLdolzxdVML+MbZEmwDYnSUdd0TPvcXs3CxbRaXrMdvTcBI1iDfE0ozwqPHad4cGgHzSHajdMAuEtQirEnBnu/IwBqsxuAUw==;6:ay9l/Seq5qPcpUKrGwvYsCXW9ncdz3H4ired6wJDjq+AHtj4QFqdC9GwjGpi+cWtPppk8Npl6v5BhuEIyIri11Jn+998R1ptNiqisdtMfaDRq9UKZMw1MAj5zuvb455DNs3drk0jZNvf1HhKktC13D9PyC1/tNorojiKl6FNjjRYVNDLtdRoS5M2Bm4hey5nQTtfMQGhT4hgxJw5RIaC+VGXgrEVGfHka2I3+rnW6xLdaa97A9zCuQ1v3Zk1LKXbZCLLgJPJAWSmo4QBCZxT1TFr4pgA6GTsDIdF2XZ+Q1uxk0506s2oSkDUjq/I0d/+rQ54Ad9SFibSGIp8DEG1jeVLffks1JRqW0rBR1ExJ3i/UuM1CPwuPaQRpZYFJWR+ALPGyU86CLjY5WxKAwlN91d3Tq9i+qjlTB0hbayRB8k8JBDk1z5AqbWIA06IRDp8FktQcOdlUJqT6rG6z9q9OJw2po8EU9b8ITXJFSoXfxFGHd4vGPX0EQQAo1XG0fsm;5:qlDhgWYCmlcbZqxsSiLuEa9VgAwuUrKbyLRfHUwdAY/J3IEEvPElfTqHYKo8Hrg+GhBktMx0TPDiP0/fCpSQ+rHCOezr0HFUkQ6102/L6L8sAuyW0XxtjNTJK50w5Dm00E6vPMYBPrCNmDmi4JB6OiabJ2k5FCNOvWflGr4GNAI=
X-Microsoft-Antispam-Message-Info: yHSQjW2LiOb6Q6GdLo2aBgvlnOD9XQlzlkByn9/zMh3J7sCogYyjMESp9nRt1lSxvaBfD8XKZxX8Dt0CCUxgnC13xcZ1JitBP4epTH7C2d8xCO5R2ET7YPCJyprDUPbRACT0FEaVkI2Rpziz+o/+gjGMFueqMKP+17uqFWI27wTUtUGoj5SOGEEwIlj6ZOHL+PrDSQbb08e37281gI+hFvLabHBw83OC9rdS5Zkh/cbRpKsw8hGiBRqqvRlUcrIaPI/hfUoAjOnHbRyW5VTkJYQjVSdO8TTW0JG9WgA5S9ylEdSOWjtu/ZFg/25rpCSl2Kk2XIuSTfChXviN2G6+OWF3fK/1Zvfoh2urHokWH5GC2DeN2vcvE4IuUSwtujec
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;7:sodHbnZV++Y+NnJ8jRlI7nIODMSnLz9KhFoXYHzXgvk05rlHrNHEzHatyGJz45Z8QW5N/XKVdQ453f7Wk4xLl65th49MLdPc37c2HddzJ19PDevxOGrtVa84ecpBWhrmcs1Iqm1SatWxfe582n4gTP9uUWTM0sdCE+qgiZ7TSfy+ExFAHG19tL/GibOvhXV/FKuwMk4w+jObMAZ9ZnzDSqodm7BgMFxrLFb0vrsEZqifm40d7WwlVl5UJEuiyVIm;20:01Qc/bFq+30O3vHGoUjQOXa8zDVjJUbvI+JHaagbr+B8+RTj6/iKcUNL3voE8f3GY0RKWr0T0SBuiaLcItWgNXcc/QwEBK4WYO/r1QDdV4y7wI3yO04SmIDc0SusqWlGQ5A8HRCd+RuWI2IVzV9BtZykJcphr3DJZoPwwin5IF4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 10:00:08.6673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f5ae08-b9a4-4ca0-377c-08d59949af68
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1981
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 06:10:54PM +0200, Vitaly Kuznetsov wrote:
> This is both a new feature and a bugfix.
> 
> Bugfix description: 
> 
> It was found that Windows 2016 guests on KVM crash when they have > 64
> vCPUs, non-flat topology (>1 core/thread per socket; in case it has >64
> sockets Windows just ignores vCPUs above 64) and Hyper-V enlightenments
> (any) are enabled. The most common error reported is "PAGE FAULT IN
> NONPAGED AREA" but I saw different messages. Apparently, Windows doesn't
> expect to run on a Hyper-V server without PV TLB flush support as there's
> no such Hyper-V servers out there (it's only WS2016 supporting > 64 vCPUs
> AFAIR).
> 
> Adding PV TLB flush support to KVM helps, Windows 2016 guests now boot 
> normally (I tried '-smp 128,sockets=64,cores=1,threads=2' and 
> '-smp 128,sockets=8,cores=16,threads=1' but other topologies should work
> too).
> 
> Feature description:
> 
> PV TLB flush helps a lot when running overcommited. KVM gained support for
> it recently but it is only available for Linux guests. Windows guests use
> emulated Hyper-V interface and PV TLB flush needs to be added there.
> 
> I tested WS2016 guest with 128 vCPUs running on a 12 pCPU server. The test
> was running 64 threads doing 100 mmap()/munmap() for 16384 pages with a
> tiny random nanosleep in between (I used Cygwin. It would be great if
> someone could point me to a good Windows-native TLB trashing test).
> 
> The results are:
> Before:
> real    0m44.362s
> user    0m1.796s
> sys     6m43.218s
> 
> After:
> real    0m24.425s
> user    0m1.811s
> sys     0m40.625s
> 
> When running without overcommit (single 12 vCPU guest on 12 pCPU server) the
> results of the same test are very close:
> Before:
> real    0m21.237s
> user    0m1.531s
> sys     0m19.984s
> 
> After:
> real    0m21.082s
> user    0m1.546s
> sys     0m20.030s

I vaguely remember Denis Plotnikov (cc-d) did a similar attempt a couple
of years ago.  IIRC the outcome was that win2012r2 (back then) guests
started to also use this mechanism for local tlb flushes via self-IPI,
which led to noticable degradation on certain workloads.

Denis do you have any details to share?

Thanks,
Roman.
