Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8205C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C55B25355
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="KTY5qZSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C55B25355
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeFXWpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 18:45:51 -0400
Received: from mail-eopbgr710061.outbound.protection.outlook.com ([40.107.71.61]:51870
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752394AbeFXWps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 18:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfFq0Vdi+rLncc1cAlyfGH1nUSp1wsKo9rNMisfYF4A=;
 b=KTY5qZSK2SxzEBm5IM01oyzr9ZbGc/Y5Kqk/IrcE+JXnWdNFZn0QH5Th1wKACobEtVqZbstiVCbZgQT+kBibIct0hsgPNyLMoXy3QUjPB4AvsqWOfk63A6hKsEyx4Pc18hSiJ/iOddEwj2xbpafRF9MEn/Q9JIcFEOZ7avYp5O4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (50.233.148.156) by
 SN6PR07MB4381.namprd07.prod.outlook.com (2603:10b6:805:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Sun, 24 Jun 2018 22:45:44 +0000
Date:   Mon, 25 Jun 2018 01:45:22 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 2/2] bitmap: sync tools with new bitmap allocation API
Message-ID: <20180624224522.GA23998@yury-thinkpad>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
 <20180623073502.16321-2-ynorov@caviumnetworks.com>
 <20180624213103.GA166241@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624213103.GA166241@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: HE1PR06CA0127.eurprd06.prod.outlook.com
 (2603:10a6:7:16::14) To SN6PR07MB4381.namprd07.prod.outlook.com
 (2603:10b6:805:58::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfa29cfb-5c55-4d17-a3ca-08d5da24394c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4381;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;3:TBMds5DahkYzXxS0DARGT/FS9HUKcXJEEdbOYAdBHf4r+s6H2tvYU/41RemOZOvAT8iqOWScyj+syfleXuV4XefwSjONUW52wbROmcT64IpEL0CQ9kY3Fw6CqbEz3q0nyR1hAM3ESTTfLutYgbhcFPq9eIbtNzFVYpJ1PDQhWcXkDPQgXF+PPyMTERlvWo+7jD5J4EPBg446bb1T5TEP7rf+UxhdyQeIGJdMAFa39r1L6cEVWgt/WNfgUnUMflOh;25:MzPJ2OspzL46DUybpej8w6QXjj9Nk8HVAAQlT2haCeqsfjsDom1IiXHA9NrFiy61kpFGyPjljXEfw7OIqD2KMTymt+dcHcbdVzGQgAJIdb8tnDlNvyLsNHskvhGs8kbgP56sV601ZMb6qGQj7DbjrMSiROVSHk7O6Wm/rEDIY2xTwQWfYk7sQAVz889kJh9NE5TjT5yk4cVhvZOjNt3qVpnSRfoFH54tRc0XIhmSMkbeucofxBWfaJPOprOy2vuRrH/Y0hBlHC90rrJjn3gleGhFgKg+oSSAmMZlc50rZJEXZIQWV5Cea5+uSvVRdkEHaYqxvsT6qCOTBYOyHZ4pZg==;31:1CBMvaxxuX3NlUxA0TyylS2zd9gPeYnKXX4oG3U8osNln1/EkMzPMVyuqVdWsEHAIgXmL2XyMik05VzoDpmC+XIpcaALsIt46cS5gIriPM9/RdjvFvNTBzUlOyux1pDJBvPZqGZHNomYI1xBmmBVWIs3WInI0LFkQqVeBIuD4eZy4t9rjOpni3POGX6F6jv4ohj7d/dY1kyW6ur+P9izkJnz0cJlKbUW/XSK3OvsGrs=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4381:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;20:5XBtYB+X5Yo1KGxAKgev6l3La+IlpIQM9+ej6BoEesHKyg0bL+sDY8rmLZSEXZci99YO9Bs8xOAi0V4UAtJwxBl54E4nru3YOKBKI1DD9iPgM05gl73iDnrz7zk5XEzXYtZges+AVwoPci5Gyhh8E48fD5Z+bbJtlBzKgO4GA54juJVHm02yMxFy7sob1CVEtICnDCx4/sqTsqGGNrV21Ctxi0ejD1r94QAgMoDxHHf32xFyuUtCTbwFrecFUCec5BL0rld9uiUvTw1QjigZX4HhRzgeoWGb6UlJa4iwd/SVmnoKc6BjmVMjCgONlzKFQe10qpWKxcuZnQVUeCVzYeXiMevI8ATxB2uvbC6uTwkZEgNt66u0wRq+dNGPHld5lX4SXJ51v3qnn+9FTg7AjuwP9x8fJhR+bss5JdZQ1R/eaVOlSI+hSzP3Gmf+ZSnsj3EdG3MhwVVvz/5f3imDTSmrg5Ka5dImeer1+Wc8ng7hAGpPKzpk89Rbhds8zFH6OI9Z4417Z2pzOTJQHOu+4Y4F7Y2Znja7KqwqsjS4kEfQbK628LafGeZF/XDrEvVq7D5lr1n6cTou5M+Bg5KqhdvRYbBGwssculsOD5YmdSg=;4:xQFwGw0MRmKnJP370MeoFUdVdzL7cTf5wLMv1R/O491S8k8iD6E2Y0tRGdI01MNQzkW3kY0udxvqVPJJhQN0c7QV+MxHjL17RvQYVzQH6E7aw2c2h02RLtZlj7yRSJU2EBDTcM9fddbkrlXAtEYaHEi4lnruHlRmNCMS1ojyHZrjqOlOxfPSYAErCuoOJL4gaPrQeUOPK4eZZtNrVyeg2RivK9u3LIwir91nZZNWqGtqXhMH1xSzerfF77Pfy4JIjX6JGsybqTpRqtyoo4Pemg==
X-Microsoft-Antispam-PRVS: <SN6PR07MB4381B167F271A3F3C78E6FAFE34B0@SN6PR07MB4381.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4381;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4381;
X-Forefront-PRVS: 0713BC207F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(199004)(189003)(8936002)(7736002)(47776003)(33716001)(3846002)(66066001)(8676002)(81156014)(81166006)(23726003)(305945005)(316002)(52116002)(6496006)(6486002)(33896004)(58126008)(50466002)(16586007)(54906003)(386003)(26005)(476003)(956004)(186003)(16526019)(486006)(42882007)(1076002)(2906002)(11346002)(446003)(6116002)(53936002)(5660300001)(6916009)(7416002)(105586002)(6666003)(106356001)(97736004)(25786009)(229853002)(76176011)(39060400002)(68736007)(33656002)(966005)(478600001)(72206003)(9686003)(6306002)(6246003)(76506005)(4326008)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4381;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4381;23:LZKkAQAHDoSl3OMApLwkK61u1M6TImk72pWIVrpQR?=
 =?us-ascii?Q?z7UOtN0wIVwQfd5KhYqKldTj1sdXTWxVyRxAx73Chiifc5xJuGGqONJDS800?=
 =?us-ascii?Q?zGZddw7CUqEnywAmhru7FOTp3wOqO6tL75BHHXWqhxOIokPksxG19fk69uc4?=
 =?us-ascii?Q?VDesdLZONFrtCn9Iz1+A09csfT68PPSlAmoq0fi3Ry7XpEb/QPT6GjO20D82?=
 =?us-ascii?Q?vXvaRBg1M+Aiu3qBriih3nBpAeDdit6dOOtq30Hqy0EhEW0BZfiR9N1a8z/Q?=
 =?us-ascii?Q?Aav2j8ClT5E5/g0IalPVpmtLrVFp/e7I0neslUoViIVdPx9fnb0WHzP26ajL?=
 =?us-ascii?Q?aFbnIHxEIPNx217fViQU5pea9hhvgwuupdZhRK2BUCChCH6/RWMzsH00086L?=
 =?us-ascii?Q?F3R438z++9G+wCG7ZlbiMDtmvTlypXH6eYIVS0djLyF8xqBt2lxTjQjC5G0K?=
 =?us-ascii?Q?RSrzZd9Jt0+Kdqx/SSY1lLc4O0P8MDG5CNjAZ7JDPIkfQCXX6wKDzdR/BlJD?=
 =?us-ascii?Q?533iSvaNx1u9d04RnapFRrbH/ukMCRkYa/4cXddCqkZZvYzl0btX3j5EScIc?=
 =?us-ascii?Q?dUO8NuRBFCv0HDlJGUqXcSO/HCVqd2CVs0u/FcIqi/4Cc5FD8x9H6Ke2J/rl?=
 =?us-ascii?Q?AAfXx08k+HULkIi2SQx544iVq7DUm10Wb1kTgO/CQTGsxdCJ2SK8EebuukTC?=
 =?us-ascii?Q?NEIXJzieqXxFFHFGQesQMdIp/5m4tr79lLe2n2/E+YhR9Bh3SYI1RbyrKo6T?=
 =?us-ascii?Q?G7ZLx53dnvjqPjfWD0m8g6Tx0U8V66EmhRs3K4XC2oZqdI4L/pfc3jq9uI/u?=
 =?us-ascii?Q?oGEBmtZVEpQ9ysfhl23eYaLKfXKj72NTBQrcimDedf9y8oJFdRRmtIgcz6Bt?=
 =?us-ascii?Q?2Z/a1zGcDl+r8a+L2CN3pHqMzfBXhJX0RvThwj8sVOjsjS0qQ54BVN/Nvt9W?=
 =?us-ascii?Q?yWvPFDVPn15l0iCIVvlidcuN/QkpC+kh3cG+v2fyxGkAwcOk8KKHYZXuBx3V?=
 =?us-ascii?Q?IWYNZFPcKoKBS4bv2CWiCZy5eQMmFAUKTu29RzXVKf9kaHwd/OoBz0o9qFBH?=
 =?us-ascii?Q?dM9jDa7he052JX+PvNKgqnwKBd8AyBd1+aGQsQ4t36h7X2YKGLNoHE8tPKLy?=
 =?us-ascii?Q?JBPFv/mwI6FSOV1sZuMAKF/BMyTIekCxp3NyWvFGNT/IB/QF/VFKm0pQu2BQ?=
 =?us-ascii?Q?fKO+2M0NTlgLLJ3fY5XijZx3zqaXUirypZVH7NeA+8+7om70XgOS4M1ZIJjv?=
 =?us-ascii?Q?w0DGTTt5JT5nXKbQTALHRYYNLDpM9tru9cwwIp0vojyM+B8U6lxh0lVMsfwo?=
 =?us-ascii?Q?45ygpA84LMabefkGXpK0n2hrU8ZSuaQGiMS8xKJ6E167BBKcSYBMGZ7sftIH?=
 =?us-ascii?Q?SU7lBTtLhxxmreGQvlQtCP2AarID+qXHEoe6WCdiDNAddFMlFHw7c4AcWd7t?=
 =?us-ascii?Q?00Evy8yNVf9TmFRCAoZ70DN8FRMv7s=3D?=
X-Microsoft-Antispam-Message-Info: 3J5Fu8+Qz7uLwuKM1akIAkdj1AEhPyqbQrkl3GlxBrVFxS/5XjMy2gXGBaDUc+JNzPQOt50DLASAU8UXGP+8XqfnhEyoy9JV0HPaFlia7hZhkF0QkeRtorLyx9Ka+C8pZkCtQvGpb17V3XkAFSA/9HK7H35AQR+RmqJFsVs1zv5MDJ0ou24yaMrPwGtQLFQjPto6+smHaTUtzy5cIF7rAU5jlTij/cT6uUoYX+lrugHWEhVkoXdqB81H/tEW56KWo9O6OhOSXfHpAseVzzJ9SUik7SxLXFgYNq97Iq9mN0xvdGCtL1kURPCknPuTbAo/+DxP50+DTc7+Evlz8AvRdf818UlXTAU4q2fDaQiMVN0=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;6:86QmM/AJhNCxbINJgyYvxOKGOwyNf1wyzGLCm7T45RCvIjScjnFxyp2vPQ343mnA8ClFLL3v3Z36+a6RoGDD23Ud9mfKb3Mw3MN2knxjiXvtwE2rUvJQIzP8kDeQ2+0OKmZUIXNcPWgZVSgcI0LwpmRvVj/4Z3adondIpsoB9uRo7N1IgvSnfFGSG3W1Wo2b47TGFtV7OshbzcfGM0xa7I3ZWVDJ7YjgtrjCVWHy2u5a2ujD2ZtC3Vcpmd6Ge6njuFwKPXv3RhqRFuK7ho2uxfgHRbTgWoKOqUvbWvq7zZnBGkP0IK8r/trBDLQ+sZm3bLHBQ09jbamzfsIRZH3jA3ZKS78WgjbvmQ9VbsZZhgCTVXnUQA/epofjhfexY5IVHUu8+Dk+Uq4XkZqqjA8Uzf/cJhTjT4otfaX0kksBPR/YvkqRHYbHg6BzllJZCQzBoT6oprsbCt5gtff3520iSQ==;5:UdQUGUOHbudO8ybg9ydovWJ+sAQefMJQ5kyC5kYHORBL2Lb7VOb4d9SNQMtF8XLQoXxnp+QoYB7ncA0D/g/TRZQjgn4EHu0B5zVsfS04S4+x4P/pBx33VBoaWi+ibINues0dOfhcYVhebd171e/H9hgEEABwOUfpNk8Qttokb80=;24:/GWOPBTln67Djer7iKlW+5q1HINKm2dNRvomG85pu+d8dfBezp0F7O3YoTehqF1d5x89MDjh4sT3cioVDCtlO1OcDLj0R7ZmmaLaZIwuMM8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;7:TWUpUXOejYnfBxkXmXod7m/QXvNvSXa+IjbJxfuxO4Jkp7MTBju4aj/oORIF6ppYygIVCV9MDpWpD0KkR4ZCKEYfp0aqZXd2fLgrRnomIylUtgZde1+Ta4l8HOxA4o8u5k2LB38de+NHCcyXtUToR2F+kNInB6NzCEbcbTbx/tfjMsTa4Fd/uhl+GQNZ7ktcg8JXXRgNUL8o2OiGnSUHGtC5lPR/GtsA9iySkJ+FNWW8+GB4S/jX8kpXRrvzxDm5
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2018 22:45:44.2103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa29cfb-5c55-4d17-a3ca-08d5da24394c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 02:31:03PM -0700, Dmitry Torokhov wrote:
> External Email
> 
> On Sat, Jun 23, 2018 at 10:35:02AM +0300, Yury Norov wrote:
> > On top of next-20180622 and Andy Shevchenko series:
> > https://lkml.org/lkml/2018/6/18/841
> >
> > The series mentioned above introduces helpers for bitmap allocation.
> > tools/ has its own bitmap_alloc() which differs from bitmap_alloc()
> > proposed in new kernel API, and is equivalent to bitmap_zalloc().
> > In this series tools is switched to new API.
> >
> > This is RFC because I didn't find counterpart free() call to some
> > bitmap_zalloc()'s. So I didn't convert them to bitmap_free(). Could
> > someone point me out? The functions are:
> > setup_nodes();
> > do_read_bitmap(); // Free is called, but only in fail path.
> 
> Yes, because if we succeed we effectively return allocated bitmap to the
> caller. You'd need to trace upwards and see how it all gets cleaned up.
> But given that this is userspace and is not expected to be long-lived,
> maybe nobody bothered freeing memory and we instead rely on the kernel
> to clean it all up when process terminates.
> 
> Thanks.
> 
> > memory_node__read();
> >
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > ---
> >  tools/include/linux/bitmap.h | 19 +++++++++++++++----
> >  tools/perf/builtin-c2c.c     | 10 +++++-----
> >  tools/perf/tests/bitmap.c    |  4 ++--
> >  tools/perf/tests/mem2node.c  |  4 ++--
> >  tools/perf/util/header.c     |  6 +++---
> >  5 files changed, 27 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> > index 48c208437bbd..b9b85b94c937 100644
> > --- a/tools/include/linux/bitmap.h
> > +++ b/tools/include/linux/bitmap.h
> > @@ -98,12 +98,23 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
> >  }
> >
> >  /**
> > - * bitmap_alloc - Allocate bitmap
> > - * @nbits: Number of bits
> > + * Allocation and deallocation of bitmap.
> >   */
> > -static inline unsigned long *bitmap_alloc(int nbits)
> > +static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
> 
> This makes absolutely no sense for userspace API. What gfp_t even means
> here?
> 
> If you want to introduce bitmap_zalloc and bitmap_free it is fine but
> adding dummy parameters to match kernel API exactly is a folly.

Identical API makes easier porting the code from kernel to tools.
Refer for example declaration of kmalloc in:
tools/testing/radix-tree/linux.c
tools/testing/scatterlist/linux/mm.h
tools/virtio/linux/kernel.h
tools/virtio/ringtest/ptr_ring.c

Yury
