Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72240C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E3420C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="ln/e3g5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E3420C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeHQCWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 22:22:48 -0400
Received: from mail-eopbgr690071.outbound.protection.outlook.com ([40.107.69.71]:59472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbeHQCWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 22:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MK+kXmDbbe5m5Y/6Bbu+NxXAw6Dcelfu0tJQwy8RS8=;
 b=ln/e3g5ikNjRxsxQWZHokrZdqczOWO8Ox4ZBKWIf7wEep6Jj45Dl46ZSgGfIlbLI/CDB9zfOWTjM72+NiH79N+PZ0OOFOkByuwKY1mTWajSIUTGtPC5YkkAimExjZ/Tkr0bmihMbak1Omr0eJZjR2h4P3NYE5W+lpJrvpkafw2M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (80.122.1.10) by
 SN6PR07MB4384.namprd07.prod.outlook.com (2603:10b6:805:58::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Thu, 16 Aug 2018 23:21:41 +0000
Date:   Fri, 17 Aug 2018 02:21:25 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, lkp@lists.01.org,
        akpm@linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] linux/bitmap.h: (buildbot-only) check if we have any
 compile-time zero-size bitmaps
Message-ID: <20180816232125.GA6119@yury-thinkpad>
References: <20180815085539.27485-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815085539.27485-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [80.122.1.10]
X-ClientProxiedBy: HE1PR0301CA0011.eurprd03.prod.outlook.com
 (2603:10a6:3:76::21) To SN6PR07MB4384.namprd07.prod.outlook.com
 (2603:10b6:805:58::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a24fde6-ba44-4aca-7e77-08d603cf064f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4384;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;3:SyEYQpo2XFxma5uzSsWz0iQC3LWRbrbTga9PX9c3cZv+aWNR9u7t3sUsirV5dz+/FYNrX7LKvfFWca+kyGpoUtUwzUzbRzJuGZPPIwbTlF2eo3L5eeyX4E0RdZSkIDr3b/VNk3Stabb9XQxOkM3+kFKndmlm0Yg5IC/2KxIHKmFTSCl/1ksFXrYdKMSXLSoT902MP/l+EwlVzY8pPTvjYjDN2EVSYznjwvy+W/C8xwJ8MjZINcpWGPjsd3sLfeh6;25:gPKMF4SxoG/D/WWWY3d52SrzhpzIQqs3081dSTECFCuFvtYWo4KNl1s2fqvmHCAgKccm1xS5DiWIHJ26w5s+lLv9hyt/FcOIHLp+6c8pJJsVUgLY/Miwta0RBAl143r7SWTxLM/cawlTjFZZMtR2WUw7yJuFizDQ+ZGMLW3Gmp9Bpukd7Hw+zc9nL6qcDCUKFa6vR4vnpjVF6KTK2eXpwQGRH9dAI/AW3uE3UAErrBHMKyeHZ0ZsGhCQ8kKhK0drGDUMfRKiy2DiFy12lgloupAq82KpdNZ8JgMQ+uQJg078RhSC6w6hBPhiF/Aj2rQs7cY9e1bWF80SitCZz+vlxw==;31:j+XUKMJdiMiG6aGs0DHQyNO1WpjpVravcz7n7vn9OZIKDeWFoIFmlbQAoeCtBWMCy07p0SBPwSfja6LkojHWV/4VswibXBtFC3GKy/wLdd3KkvDZKz/ZA0ZjQJH+FS2Uh73z9w/IhqG2oq5evNrsK3Z8weTnc+utZ31tpwNZLtz9aMEpfH995a0xXtZWOAWW9WlfzzvCb8lboBp27nXmBWv4hQ97TxDKYBC3XgYrXlk=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4384:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;20:Eu4G4DT2ldB1YXLU6LY4Hpe+tUAx0WT1lzIsqVucVoMgipBYQFYnBnryVktMXdyEJioK35tprgDJOMOWneSMi6GoiDy6SoqgUks8cTA/sYX3Bx5fEaIfc/+o1Rk94AHHVBwt/yNUCyejp4u1CsBtcJrnEdBN+bLWqCZZqSYGnXV0upS+nDE8Ll/PypFYrHFmun82jBUUksMCnYPXl+7lIohpSztvx+BNhQhEPPTQ8yffJIkFZRAkY5099uqB9N8j7ya7RmJ7QZYNrsf5xaaCYWPGY9cLTC/xKOermI+Tv0E+Qfq1bs9lVolLtO0rODnOuLF7JxR59NBeLkdnRr+40GppthYD9COh+cq490GgGI9oUGFa7N0fnEb4JEkemkbmwX4HAlixPYUuNYHkhMcZwfcKuM+RUzD4pecVxCBDzeZVBRvQOxFv2oOHRrbzTkv/muq5F05QOpEzHVLbO7kPydo7UHqyyNl0wP4ELaynnStQKGQFHJ5ZaYhhA7siD+R5LphzWLkn9CPtcC5lhregGsMP7GeDXKZRC4OxLrzy+IUcfY2rH110eqtnA/0CKb7YXYP4NLxjKaOzDJRg9yN8cGPD74WpGoAfsVkicqtXliI=;4:PIpu7NayqN7XGtWJTy4z3EhLuMnGHAuxKSyGNDYCJUmQM6qcUcrdSsUrXRjmYo2tQ3m5C7KUzAPsNj2ErEHVMdBJhinx7Dmw5nh6qmiIZXEpH4iMxmoKvyJ7LYzlcZx1vsuRJE2qU2XkZehgf4bKWiUD8low/GITe5CrMrXT9wbxeo0tx+t2oIIO/f0RR9IFgxAaxdfPrLx8suLeIYOWDr/MkW30jNj583BflRSIEtQBDaJabzLcaQE6fCuBuDssTUR+JvsGuDHaQS1wq3FapA==
X-Microsoft-Antispam-PRVS: <SN6PR07MB43842CB90E20FA7E25AF4971E33E0@SN6PR07MB4384.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:SN6PR07MB4384;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4384;
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(26005)(229853002)(7736002)(53936002)(76506005)(6916009)(1076002)(105586002)(305945005)(6666003)(106356001)(66066001)(47776003)(42882007)(33896004)(476003)(386003)(52116002)(76176011)(446003)(6496006)(8676002)(81156014)(486006)(16526019)(6486002)(16586007)(14444005)(81166006)(316002)(58126008)(9686003)(956004)(11346002)(186003)(6246003)(97736004)(33656002)(72206003)(478600001)(25786009)(68736007)(39060400002)(8936002)(3846002)(23726003)(50466002)(6116002)(2906002)(33716001)(5660300001)(4326008)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4384;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4384;23:OC82kSHfboDmZQ5dEz0TVnmZHR8dPNOBIW78Fdfr6?=
 =?us-ascii?Q?OYdhRCiv1YFSYIZVCJH4fKRHjWLSfxNUYsPwZRMC3pAUBQR9TCwpEyD/TBeu?=
 =?us-ascii?Q?zO9s+80M2aFwMm4Lptb3Gg80QIpycXlLnkDQegER0LjEVi2HJYTbycVMtbXj?=
 =?us-ascii?Q?OaDHyyvH3V/szcwqpxkzO901dPd3PIuX6wFG6C+ijkwk0zW0vkZ4puHwMt1q?=
 =?us-ascii?Q?BnTyHr9rUif+RSa+IdVILg23hKIenWpEhPNDIC6/3v4MhQce2dShbNC62oSD?=
 =?us-ascii?Q?s7s7sriAUbnN7sW//4Q0PleMm8KpWVzwLYXZGunYYqFQdY+/HgGuiKsB4jG0?=
 =?us-ascii?Q?qYKY1ab9OD9AOVTFiCVD+z2zD61pkOt68o3bf3nOrK9HhpQ9wAe/8HFQIiIG?=
 =?us-ascii?Q?Pl9ru0v2p7LD0+YPBcc9Iupo5J6DE9RYQIipq2m9I+Rj/DEiwCTgyEAKdzvG?=
 =?us-ascii?Q?Xse52UICWBeo+spWdqxqq2eTPYRAzL+VyV9+12+U8/pVfjKk3vZwgEV56oWC?=
 =?us-ascii?Q?xxQ5uM8f8a3sU57EqA7r73nwFRxLbzWPlSUXuTU3cgQail8IhJur8g5YqUi2?=
 =?us-ascii?Q?byzMXxEqFaiQC7QQnmp/gCJpCFstuVWPQo034UUS4I0La7g9JmhysZIac1mr?=
 =?us-ascii?Q?qq1mqJxZtMPLOkMIWGs7YqPWUjw7T/ZDfL0lg/B9nV1OexwMTS6b7G2yxCQE?=
 =?us-ascii?Q?Bd8IX/SVnMav72pR2Ao6S4Wv8g6jUcYw477EX7nWryi8GExTZED2DN2jqfv8?=
 =?us-ascii?Q?mj94I5uaSeuIEPMtbvg2hMedcsvq6+DcyebsXrymfYZLHjFTiC2vgI7Citc+?=
 =?us-ascii?Q?O7fMZ9znEWBUNfjaDg1vIS2utPUVR6kmIZpO6FybPvS/eMFvUVUC+qhm1ooj?=
 =?us-ascii?Q?JAjt+KHWq4Xedm3b6nH9RW5NKuweCieozQk4HRvfCYKZXuAqrevo12zPriIL?=
 =?us-ascii?Q?Kx7SXtWhHRuc5bCYR7CU3g+lhn8Mq8QuYFxk2gauHMdnVNSz9ipD60l8iVDg?=
 =?us-ascii?Q?N0SPi4qTnrlPbYJ36Xblv5GbPIVBWw6fpYzJEA4X+3fGVLj14yskyqut2Urf?=
 =?us-ascii?Q?MlejCk1ok4POq1aRhXDxpxKLOKvtWVnW5gMhlfrIgWmbqkGKYedLxOzhbiwS?=
 =?us-ascii?Q?NVx2FPtPp4I/OVItPzCNPcPqbLolQPR4azYm3rfnwLRhCu4sUQsKfA7xAa+r?=
 =?us-ascii?Q?r4tSnMURaPIBxorXegNl2VRP8zV7670bPO727RFDeuuGpO+V8AnzeA1KGy8u?=
 =?us-ascii?Q?qggNiHj3d6iFZOI8OxJOYmWHatImdrFV18d5ibm194eqQ+rsLkFSLmVqeobL?=
 =?us-ascii?Q?WgAIf9qRBbK4COXkF09z23VoEhXu86OZKkSR0VOok9+ASYYWB68bPJMlCRUQ?=
 =?us-ascii?Q?a/vA/4lt07djPwUmRipxOm77S4=3D?=
X-Microsoft-Antispam-Message-Info: RB2TVYBDEGqOEZJ3Rp9Q118IPbG9mLJqqKUBLXp2ydJsIKqvBycj1WxnT6LPLopoP/OVidYnhxg0g/BGG4nruXOhaFLtEahsvNnFEan2krvwTXjzAQ/PwOBKC6aoPH0Nkw/f2fHwQD/lz/29R9zZ4Li9qsxUSZIFzKRVRkBH6MPe5XU8Qcw/UbKrodtrFGJakNABFR6v4XdtTuN4LR6MmZvm9XT3vqsYyXt58K89g5O+zQfowdJq8ft0wHXflXLy7il1gG3chDMtP0gGkZjvY2JcwIG4Wwg02xdKjKF4OWbD6NhbpxNC1BUfvA1sIDPukmC63Gen4UR0ihRaP+6ZxnaMkSjTPKGVNK9bKXvbdBc=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;6:JNHu1UlAXmUSW44sLPNjZrO6OwfaLZXcfGUfL96yOs6A/9EeKGgx7pw4gP8oVw5c7stQpSVvMp2YSRF7am5h4rF8+D0fhjtXyXvpopomvt8MFvvQ0QudIHGxXRQdRSd9VFUzSmnut3AYkzqZRVo5S9sxZIWoXMg86FjbBY7+yRFSjTqncd5VmLdDU+xw3/KsdqnxzqA+hmqVuXBvyoSo6OCINiByQB11kXUxn6r7M3Pc2vPrYLpaUFeBOnduq7vxcd2OAarms6ogpSOsvN5MCVnynaC1NtNnfBJDtZt2T+js2lUcKEzGON1sDIeBW9sHKowJTALjJXoL9N19bJYX8FERLGTLCqP09E0dVnlA/CioBW8F4ju7XJMUSyFStJDZFvZtfNuQEglMtQKgfeQKa+Kk+9FSsD15vGSmDAzsE08RIWqvpkuIob1+9hOtN+KzeMf4vkcKUptWFUOxPI0yDw==;5:0SsCPd+puOHV9K58+OBkbvF5t9GPQTsry4ZCeb6tDiu2wO325gpK3BOh0MnrwPyKRe91551rBp3PWGAKJoK1MyV97x7GngFs6kcl3n2l2T2i1ukbi38pDbX312s/myWYnL2g85McVJo66LEGoTc+tVs8Wha22QdRrpLszywqu/I=;7:LNhzdnNIrTrodC2W3dwDaeEvzAgJKYuA4t/usDvR9QazMn52h0B2jIeGj1Nax8DAZDwtFReO53QZGG/FU+pwl6BSO7zsxc9MuHMc09PWBXJcnH9qdVQpe6AoEo2jzh6hhs1VF8hF7ISnoJ82ZDihQNLrPwwdPvjXufT+hOOl/O9GGCw1eVSS9sUIXTDKq1ViEKHnTG+hSjSSDX5i5IruBLERbPX2bMStGdfxcZQcMVylWrrzDXy4mJ7LuwhRlYGV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 23:21:41.3646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a24fde6-ba44-4aca-7e77-08d603cf064f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Wed, Aug 15, 2018 at 10:55:39AM +0200, Rasmus Villemoes wrote:
> Most of the inline bitmap functions are buggy if passed a compile-time
> constant nbits==0.

I think it's bad wording. Functions are OK. The problem is in users.
Also, run-time nbits==0 is buggy as well. On the other hand, we have a rule
in include/linux/bitmap.h:
  * Note that nbits should be always a compile time evaluable constant.
  * Otherwise many inlines will generate horrible code.
So runtime-defined nbits is bad thing by itself.

> The convention is that the caller only guarantees
> BITS_TO_LONGS(nbits) words can be accessed, which for nbits==0 is of
> course 0. However, all the small_const_nbits() cases proceed to
> dereferencing the passed src or dst pointers unconditionally.
> 
> Of course, nobody passes a literal 0 as nbits, but it could come about
> from some odd CONFIG_ combination, or because the compiler is smart
> enough to reduce some expression to 0, or... In any case, this patch is
> just for the build-bots to chew on for various .config and arches to see
> if we have any.
> 
> Since most (if not all, I'll check) of the out-of-line implementations
> handle nbits==0 correctly, I'll probably just unconditionally add the
> nbits>0 clause to small_const_nbits() to force the ool versions to be
> used if any compile-time zero-size bitmap should turn up.
> 
> Not-really-signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/bitmap.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 1ee46f492267..a5879cb45687 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -196,8 +196,10 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> 
> +int const_zero_size_bitmaps_are_buggy(void);

It introduces undefined symbol and uses it in pretty unusual way. I think
it worth to add comment about it.

>  #define small_const_nbits(nbits) \
> -       (__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
> +       (__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && \
> +        ((nbits) > 0 || const_zero_size_bitmaps_are_buggy()))

Some functions in bitmap API has signed type for nbits. (This is wrong
by itself. I think I'll write patch for it.) So in fact you check here
that nbits is not negative as well. Would it be better name like
const_nonpositive_size_bitmaps_are_buggy?

Yury

> 
>  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
>  {
> --
> 2.16.4
