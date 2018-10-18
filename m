Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D66C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9BB2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fCKKfyDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9BB2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeJRWZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:25:26 -0400
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:4656
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726924AbeJRWZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb+eq//linUSBeU2myJ4COrvUN8TQQaPG9gZqhvgoaI=;
 b=fCKKfyDZ4Qk6oFzWBoy0K6DveEUKa3vl2qY6RQvebevdcI/msp65akNNLGDAVBzhgr0W2YH+pgNOwkxu4UqgA5bWbpVGv8aUtEohZCVxFKGPyPhQwxwLGfG9VUej5oKUy2t1st21oGTfZazP6LcSZvxK1qo5DMzfRpxPwiiVWmU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mark.Rutland@arm.com; 
Received: from lakrids.cambridge.arm.com (217.140.106.54) by
 DB7PR08MB2986.eurprd08.prod.outlook.com (2603:10a6:5:1c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.21; Thu, 18 Oct 2018 14:24:01 +0000
Date:   Thu, 18 Oct 2018 15:23:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nickhu <nickhu@andestech.com>
Cc:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, deanbo422@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, arnd@arndb.de, sboyd@codeaurora.org,
        geert@linux-m68k.org, zong@andestech.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de,
        kstewart@linuxfoundation.org, devicetree@vger.kernel.org,
        green.hu@gmail.com
Subject: Re: [PATCH 1/5] nds32: Perf porting
Message-ID: <20181018142359.xzsxwghjgb7lmzwk@lakrids.cambridge.arm.com>
References: <cover.1539745993.git.nickhu@andestech.com>
 <ab5f07d5b518ef2374f2c1ebd15d81dfa17b2c9a.1539745993.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab5f07d5b518ef2374f2c1ebd15d81dfa17b2c9a.1539745993.git.nickhu@andestech.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0373.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::25) To DB7PR08MB2986.eurprd08.prod.outlook.com
 (2603:10a6:5:1c::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2262484f-9752-486e-6a0c-08d635055a1e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB2986;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB2986;3:BuqhXTj9VVJNI7VQ/OjPHdpIWWMzdsfindEPGX16frt4nEDtCw/ElAAD1va2K2e4NptSJ9wRXVtm3hE8aT/9QUGulc4ySHeYaSzSLO4u6LUT+i/GNXyFn2+UUlbTHTGfZZplQoIiiQ5WFglTS4aJze7tBhDA6QWEqBcUO8plr54r+jb7OxEAGP6mhIXNF4PdK2JgDi8Z+qVbd12niyByeW6yYKAMAtkPT8lr+ESbkHHQpIE/zez99KZq1cyirWDy;25:y4K+xiAcvsDPbihRtqBGfQ2QE5SjCWAnohkm7QYY5YTzxbSiRtXwJKe2OEV62t0V75muw7O2BlC9kHf6t6qtP2aXzwHKwisRlyedafsii24yb0g/fFQsun7L+lf1/XJ7kFMDwTxEa2pBq45zObF4Zy6MQBVW1fFJwEGPZ9pT2RJxcoCPk8Y7aHWIwI8eX77e7+BZbDDxDXdnntHzFRonJ93ekJXwgKN3toy+SMdpFeRYoPNI15PELgHlqoTnjvPzSaGJUl0VJUh0cFO49binD0aGEhl46dgN5RjXp/QvaXsnFiLr4NKkQnPg8xjcKJCE45fJ1ld3jEGKDikAY3iBRA==;31:v2i+FQR6dJcJZS5sanYxuFhKpDy+w5ryd+JHe25YnfMVtP3vRAjMO+Bpcpfe4xF0PjpNdbdOTjSL3aRy1jrZT0EaZusMOd6wFcV1faPvhjJa81Apdl+q2eHnGNGkwT7iRnsP+2HX4sVOnJxJc3BBLx057ZikxOkslyblhQ47N+8dMUqVz344zL1YsrICsvAZqu+RaPDEXeter4LO5wGuYefJhrld+rg4WzEJTaByueQ=
X-MS-TrafficTypeDiagnostic: DB7PR08MB2986:
Content-Transfer-Encoding: quoted-printable
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB2986;20:nCpE/igt27jJMbS69q2HpwJuq+2gCRAWEGDdE7a3G+B4R9gEALhIS4RAkpR9Palkp5j9hEKkei3KJncciphNhIvPGF9bqZpdy+FAfloSyM0/4nsI1sRuNe+UdS7p9gkaMzV8KwtDmZj0FY8+qPs+K10vAbAPM93paqWf31YbUCPiUblz35NLMjF+PzTmHSBjsQ/cuXl7+W6eKXhqIImm4HEoZrg+GDm1bmwZqkdepxLAUl/oGRlKLytF0vvsnM+W6aEFdEtXUXzoo5xDYR811ZmUuO1t4GUm441zKrbPg0Zpyha39qpuUxjxGMSjXjuflM33Ip6YTseE+teAN37lidX6Bh1mbYUXOPYB4oyUgyceBsVwx3eCdmbeyHFtPUUKFyL7VtAfEyhUStCoyI1SEVjwlG8cQ6w2NsCg4+8nakQHvn59O/Ji/mRGaSlHxEmnMuBF8d767a1PtnPcbudmN+ByyH4l71xMbXRV/XVhUUZfviBZSbTWG3x8pwpsnX/v;4:Ht4gVXR8NcOxKygV7wiy2dWT7L2qALonZDmISVLDQDNC64OWJrb5FTLU7W4E36o6ZXZE/QUf192tvH8Njvu2sbGz44FvVuWxmWI1hsCJ9RLSOgVwEpwubbKhyxL9UKnOaeMdM28MBQ/ozNQWeET9hU2UlOP9Xh87zfsn2ThMf4KNNuLEbi52AMEKh4fdzDhMlTX2Aep9sRrw7WwmuWf0g7Cr6mDXUmlH5Xmu6wUmBWklv+kiy5SWW77sAjxjDqlI7UBGgOPSlGzbkKO8YuWgWA==
X-Microsoft-Antispam-PRVS: <DB7PR08MB2986631AA68482B906DB38B884F80@DB7PR08MB2986.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB2986;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB2986;
X-Forefront-PRVS: 08296C9B35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(40434004)(6246003)(25786009)(26005)(8676002)(478600001)(16526019)(186003)(72206003)(2906002)(6916009)(5660300001)(4326008)(105586002)(23726003)(68736007)(81156014)(106356001)(81166006)(6116002)(8936002)(8746002)(3846002)(39060400002)(486006)(44832011)(229853002)(476003)(5024004)(956004)(446003)(14444005)(1076002)(76176011)(97736004)(86362001)(66066001)(58126008)(50466002)(11346002)(47776003)(53936002)(4744004)(7696005)(55016002)(7416002)(386003)(7736002)(305945005)(316002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB2986;H:lakrids.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB2986;23:cvslUIbuEVhiGLXogKFuPb5GmyNa/qSQpLNzWmmHT?=
 =?us-ascii?Q?m+H0w0ANz96sr2Z9cgDqCf0HkW9GncNowkucG2+OOBCerpdkaEjyTZ/SWqZP?=
 =?us-ascii?Q?s0Gj5HG+KjfyDxlB+siYprVe61jY8s5QseKvODvlWDQGVExC7kLBkjhHKePB?=
 =?us-ascii?Q?8dejNx1QDlWV6LJARUdeyaYr/4X/06VV+2DozLhRvVaCu+Q8aMsYuihxgpIX?=
 =?us-ascii?Q?/Q8jtrRg2/m3D1UBlCLxsk5nilJK1KaIMFYhFn+JZhuCC+neMT3jnD7S5g+4?=
 =?us-ascii?Q?Wo+D4GYlEl7I5uheJyNkTRl4uyWWlq2Zd1SW6PmlfrFy9znDGlqz/MfVPAgA?=
 =?us-ascii?Q?f5iJ5dghLEft2uRG734qN0D5S6zhmtR/Tj7Mbe2464Rs7s/6QMHYbOcNSVHM?=
 =?us-ascii?Q?wuS2onNYxUc81BxAt3YNE/Bt8Mb/JrFg3+F6pR83wZk83mEIBEU/0wPbxhSD?=
 =?us-ascii?Q?DuexLUSY1TP8VFb7fydvDPrRD4CbGJ5zwlcydGI14/ldLoJzLuukIupaeiZi?=
 =?us-ascii?Q?NyUrhgmLuJeOybAMFZYYuaaY2KogTmTLSnpaybYRSvt2RSXBzW96eNFHPqND?=
 =?us-ascii?Q?KBdOC3fDI/N+bDrvA2bYifsajG8sYIHVITeWzQ9hUZE9pP3xHq1RID3mrNiA?=
 =?us-ascii?Q?dUIejjyANTzByVrQmJy4f3nE/TuABCcGt2CnOUdtPmGvl2oDFp7ulvGGvcVx?=
 =?us-ascii?Q?ouKE+kVMq/Stfm8rVS7aGrvWujIV5jsVFpQcRQRlArNjsW8FL6S5Zptj+MOe?=
 =?us-ascii?Q?Vlc4D/Xm69Dwc/9mAC6j1n0beQGbsY03UFhaj9aFRx5v5vDUtcKGv8uXaQ3a?=
 =?us-ascii?Q?AbHJBa5tjqknQtUdlCVHSVUrQyrYHjqNwSzl56XPMD/wktmS+ORsJt5cyGlU?=
 =?us-ascii?Q?m5l2xJzLAPtW5mwQcSG0tey8AjgwuLuMtfvfieJT8EY0A06Lzghf/eXm6mi4?=
 =?us-ascii?Q?F+W5pBjO+lazyQd5wCftX2uRMfrrYPROglRhY1sYU18520R8ghQpLG93vP6J?=
 =?us-ascii?Q?Yx7HZVr/iS9IEIyPkM5guWwNCLd7mS3hrq92wuKeOdSVZYhiABllbxmR75Cc?=
 =?us-ascii?Q?P+hYEkNra0o3BpCnanK3Pu/i8oakeAzU82+ML+r6dm7tMb1y0kKpOwGWc69R?=
 =?us-ascii?Q?9BTGU7fP0eG9MQEfCOelDash+yz4Q6JjxkXS8OsXMCnd9f27skyjSKfgDoZ/?=
 =?us-ascii?Q?KNSZki5masDz9rzQ7DwIYZNaLYZGTsIH4ZttQNCmlcSCJuJhZQ1OQ6wpbQ2U?=
 =?us-ascii?Q?bAv30o1XedfR9yDvmTtKuJY2PZio75r3d9wySmzMtPr/n3dHNSmQ8EGS6THV?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: LJPE+RaQBKu1FXka9tj8vcz92eUBsL/lBfSOVj8U7lD+QVYwqCqav8RV/8zkemOlt6H4GrFw7fGwnrQbcDdVbCT9dJdULgGt08wW1OcyNq1A/v3bEuiFWZOw6HuB48R6R+AFgtvbY5gFdt7fMZYa5Ts+GYb3VN9TWtKucrgEwSc3oB/v7yjsynvG8lP3tKWFL7OFIfNDe/P4H/NpGmIWi14BJLsPjclt9Io1XEpDEEApRbiGJdXqrYKOgpLi2i0jIxAomWVl1uxe+b5Z5smKYwyltP8z6qvkDXeAar2upTO9IR7KTEa133LJgD52vTE3Bsl0Nqi2rJV/YqEVq/S8xiqM9CTjdF04nW7axkdpVsc=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB2986;6:z7eSE8oYAqYNPOTWC7gf8NHhuA8WYiFoNNR+YANFxc4zYtPZFZNPN+iQPjJTFpEgIvnN9sask+BBlMMdkDSYJjDwBeomubJ1yKIU20bKdxPIwvyY3YShqJh/MJfLoLz9+s6UElBOFmtpUVgwZ+GKkXRv72J/rJrQFG09eN0LtTeKEnzrfmfbTYtLDAg86FXlIpJE4Y0CPBO6kKR6ua0pT8xnUC8pjPWLaxTAeY4kFmulM82yL6ol+NO0XoqDI/qYPzcUm0gy6ajw08j9EAMiD9OvNK7LkHn2Dy5pymnVMM5Tzaeti9s0nGq8GIT0IySMs3HSYITMo9MrLMOuvvxdL60HVOayt4frtFyFuv5j5E9MSMulysFsov/QNzbzOowawBgNL+GIsf85E/IlGvY33IMwhppMuwHOtHXeWBDE3+biVJObUhD4jNOTzogDthL1YBIxVkhc+ugQZgN0J+34Sw==;5:UgFLSXvU8fo/B22uLtFJktukABDgQpKS9vYKV9vUggM7ce5dYw8rkAHLZnzg2EKJBJfQ8GcX+alUohqQkQGVXzZQPX3NpwQ7Rm0OtHddRGJznW4z6wBfDdl2SFtc4sbTGnMXSDzcn9bwU1pwyXp/xTtApukZ8yxUEWJfKIZ8394=;7:ncxblynQSgpgVA//hZvnP/nhxnB/6K/XzkVTfbQbwNvppa6CWIFhrgHPCJTkzSFYh6QLPFd4eJc0RPbboWl+3vMECnlxxSLlhjBTF80WGLEOYila/SLTQeyCPQGOpJ8sc5LOdFIsioF5F9Zcp0dBUnaisIKl1LPTbTc6BjsPRPrvCZB+inM35QGQxjRYFU/BVmJLjZB/VgGN+IqvvHRAIY/6IEr96CXF7p/Tb1Doe4pRRWfoal+1fGfvzS/wgKwW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2018 14:24:01.8961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2262484f-9752-486e-6a0c-08d635055a1e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On Thu, Oct 18, 2018 at 04:43:13PM +0800, Nickhu wrote:
> +#define PFM_CTL_OVF(idx)             PFM_CTL_mskOVF ## idx
> +#define PFM_CTL_EN(idx)                      PFM_CTL_mskEN ## idx
> +#define PFM_CTL_OFFSEL(idx)          PFM_CTL_offSEL ## idx
> +#define PFM_CTL_IE(idx)                      PFM_CTL_mskIE ## idx
> +#define PFM_CTL_KS(idx)                      PFM_CTL_mskKS ## idx
> +#define PFM_CTL_KU(idx)                      PFM_CTL_mskKU ## idx
> +#define PFM_CTL_SEL(idx)             PFM_CTL_mskSEL ## idx
> +
> +#define macro_expansion(macro_name, var, idx) do { \
> +     switch (idx) { \
> +     case 0:\
> +             var =3D macro_name ## 0; \
> +             break; \
> +     case 1:\
> +             var =3D macro_name ## 1; \
> +             break; \
> +     case 2:\
> +             var =3D macro_name ## 2; \
> +             break; \
> +     default:\
> +             pr_err("mask index=3D%d not in the range at %s,line %d\n", =
\
> +                     idx, __FILE__, __LINE__); \
> +             break; \
> +     } \
> +} while (0)

This macro makes things very difficult to understand, especially since
in-context it's not clear what's happening to var.

Can you restructure your defintions so you can have things like:

/* valid for 0,1,2 */
#define
#define PFM_CTL_OVF(idx)        BIT(6 + (idx))

... and avoid this macro entirely?

> +
> +enum { PFMC0, PFMC1, PFMC2, MAX_COUNTERS };
> +
> +/*
> + * Perf Events' indices
> + */
> +#define NDS32_IDX_CYCLE_COUNTER                      0
> +#define NDS32_IDX_COUNTER0                   1
> +#define NDS32_IDX_COUNTER_LAST(cpu_pmu) \
> +     (NDS32_IDX_CYCLE_COUNTER + (cpu_pmu)->num_events - 1)
> +
> +#define NDS32_MAX_COUNTERS                   32
> +#define NDS32_COUNTER_MASK                   (NDS32_MAX_COUNTERS - 1)

Huh? You only seem to have three above (ignoring the fixed-purpose cycle
counter).

These definitions aren't used anywhere, regadless.

> +
> +/*
> + * struct nds32_pmu_platdata - NDS32 PMU platform data
> + *
> + * @handle_irq: an optional handler which will be called from the
> + *   interrupt and passed the address of the low level handler,
> + *   and can be used to implement any platform specific handling
> + *   before or after calling it.

Will you actually need this? We got rid of it in the arm_pmu framework.

> + * @runtime_resume: an optional handler which will be called by the
> + *   runtime PM framework following a call to pm_runtime_get().
> + *   Note that if pm_runtime_get() is called more than once in
> + *   succession this handler will only be called once.
> + * @runtime_suspend: an optional handler which will be called by the
> + *   runtime PM framework following a call to pm_runtime_put().
> + *   Note that if pm_runtime_get() is called more than once in
> + *   succession this handler will only be called following the
> + *   final call to pm_runtime_put() that actually disables the
> + *   hardware.
> + */
> +struct nds32_pmu_platdata {
> +     irqreturn_t (*handle_irq)(int irq, void *dev,
> +                               irq_handler_t pmu_handler);
> +     int (*runtime_resume)(struct device *dev);
> +     int (*runtime_suspend)(struct device *dev);
> +};
> +
> +/* The events for a given PMU register set. */
> +struct pmu_hw_events {
> +     /*
> +      * The events that are active on the PMU for the given index.
> +      */
> +     struct perf_event **events;
> +
> +     /*
> +      * A 1 bit for an index indicates that the counter is being used fo=
r
> +      * an event. A 0 means that the counter can be used.
> +      */
> +     unsigned long *used_mask;
> +
> +     /*
> +      * Hardware lock to serialize accesses to PMU registers. Needed for=
 the
> +      * read/modify/write sequences.
> +      */
> +     raw_spinlock_t pmu_lock;
> +};

It looks like this is derived from the really early arm_pmu code, when
we were trying to be far more flexible than was necessary. This can be
simplified significantly.

e.g. since you know up-front the max number of counters, this can be:

struct pmu_hw_events {
        struct perf_event *events[MAX_COUNTERS];
        unsigned long mask[BITS_TO_LONGS(MAX_COUNTERS)];
        raw_spinlock_t pmu_lock;
};

... and you can avoid having to dynamically allocate each field
separately.

I'm not sure the pmu_lock is even necessary in the asbence of NMI.

> +
> +struct nds32_pmu {
> +     struct pmu pmu;
> +     cpumask_t active_irqs;
> +     cpumask_t supported_cpus;

Do you intend to support heterogeneous systems (e.g big.LITTLE)?

If not, you don't need the supported_cpus mask.

> +     char *name;
> +      irqreturn_t (*handle_irq)(int irq_num, void *dev);
> +     void (*enable)(struct perf_event *event);
> +     void (*disable)(struct perf_event *event);
> +     int (*get_event_idx)(struct pmu_hw_events *hw_events,
> +                          struct perf_event *event);
> +     int (*set_event_filter)(struct hw_perf_event *evt,
> +                             struct perf_event_attr *attr);
> +     u32 (*read_counter)(struct perf_event *event);
> +     void (*write_counter)(struct perf_event *event, u32 val);
> +     void (*start)(struct nds32_pmu *nds32_pmu);
> +     void (*stop)(struct nds32_pmu *nds32_pmu);
> +     void (*reset)(void *data);
> +     int (*request_irq)(struct nds32_pmu *nds32_pmu, irq_handler_t handl=
er);
> +     void (*free_irq)(struct nds32_pmu *nds32_pmu);
> +     int (*map_event)(struct perf_event *event);
> +     int num_events;
> +     atomic_t active_events;
> +     struct mutex reserve_mutex;     /* mutex */

I don't think you need the reserve_mutex; for arm_pmu that was a
holdover form when there were multiple frameworks competing to mange the
PMU, and now there's only perf.

> +     u64 max_period;

It looks like this is always 0xffffffff, so you don't need a variable
for that.

[...]

> +/* Get converted event counter index */
> +#define GET_CONVERTED_EVENT_IDX(event, idx) do { \
> +     if ((event) > SPAV3_0_SEL_BASE && event < SPAV3_0_SEL_LAST) { \
> +             idx =3D 0; \
> +     } else if ((event) > SPAV3_1_SEL_BASE && event < SPAV3_1_SEL_LAST) =
{ \
> +             idx =3D 1; \
> +     } else if ((event) > SPAV3_2_SEL_BASE && event < SPAV3_2_SEL_LAST) =
{ \
> +             idx =3D 2; \
> +     } else { \
> +             pr_err("GET_CONVERTED_EVENT_IDX PFM counter range error\n")=
; \
> +             return -EPERM; \
> +     } \
> +} while (0)

This would be cleaner as a static inline.

> +
> +/* Get converted hardware event number */
> +#define GET_CONVERTED_EVENT_HW_NUM(event) do { \
> +     if ((event) =3D=3D 0) { \
> +             /*do nothing*/    \
> +     } else if ((event) > SPAV3_0_SEL_BASE && event < SPAV3_0_SEL_LAST) =
{ \
> +             (event) -=3D PFM_OFFSET_MAGIC_0; \
> +     } else if ((event) > SPAV3_1_SEL_BASE && event < SPAV3_1_SEL_LAST) =
{ \
> +             (event) -=3D PFM_OFFSET_MAGIC_1; \
> +     } else if ((event) > SPAV3_2_SEL_BASE && event < SPAV3_2_SEL_LAST) =
{ \
> +             (event) -=3D PFM_OFFSET_MAGIC_2; \
> +     } else { \
> +             pr_err(\
> +             "GET_CONVERTED_EVENT_HW_NUM PFM counter range error\n"); \
> +     } \
> +} while (0)

Likewise, a static inline would be cleaner.

[...]

> +/* Set at runtime when we know what CPU type we are. */
> +static struct nds32_pmu *cpu_pmu;
> +
> +static DEFINE_PER_CPU(struct perf_event * [MAX_COUNTERS], hw_events);
> +static DEFINE_PER_CPU(unsigned long[BITS_TO_LONGS(MAX_COUNTERS)], used_m=
ask);
> +static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);

As before, I think you can fold the first wo fields into pmu_hw_events,
then you only need one DEFINE_PER_CPU() here.

[...]

> +static irqreturn_t nds32_pmu_handle_irq(int irq_num, void *dev)
> +{
> +     u32 pfm;
> +     struct perf_sample_data data;
> +     struct nds32_pmu *cpu_pmu =3D (struct nds32_pmu *)dev;
> +     struct pmu_hw_events *cpuc =3D cpu_pmu->get_hw_events();
> +     struct pt_regs *regs;
> +     int idx;
> +     /*
> +      * Get and reset the IRQ flags
> +      */
> +     pfm =3D nds32_pfm_getreset_flags();
> +
> +     /*
> +      * Did an overflow occur?
> +      */
> +     if (!nds32_pfm_has_overflowed(pfm))
> +             return IRQ_NONE;
> +
> +     /*
> +      * Handle the counter(s) overflow(s)
> +      */
> +     regs =3D get_irq_regs();
> +
> +     for (idx =3D 0; idx < cpu_pmu->num_events; ++idx) {
> +             struct perf_event *event =3D cpuc->events[idx];
> +             struct hw_perf_event *hwc;
> +
> +             /* Ignore if we don't have an event. */
> +             if (!event)
> +                     continue;
> +
> +             /*
> +              * We have a single interrupt for all counters. Check that
> +              * each counter has overflowed before we process it.
> +              */
> +             if (!nds32_pfm_counter_has_overflowed(pfm, idx))
> +                     continue;
> +
> +             hwc =3D &event->hw;
> +             nds32_pmu_event_update(event);
> +             perf_sample_data_init(&data, 0, hwc->last_period);
> +             if (!nds32_pmu_event_set_period(event))
> +                     continue;
> +
> +             if (perf_event_overflow(event, &data, regs))
> +                     cpu_pmu->disable(event);
> +     }
> +
> +     /*
> +      * Handle the pending perf events.
> +      *
> +      * Note: this call *must* be run with interrupts disabled. For
> +      * platforms that can have the PMU interrupts raised as an NMI, thi=
s
> +      * will not work.
> +      */
> +     irq_work_run();
> +
> +     return IRQ_HANDLED;
> +}

You'll want to stop all counters over the IRQ handler to ensure that
groups are consistent.

[...]

> +static int device_pmu_init(struct nds32_pmu *cpu_pmu)
> +{
> +     nds32_pmu_init(cpu_pmu);
> +     /*
> +      * This name should be devive-specific name, whatever you like :)
> +      * I think "PMU" will be a good generic name.
> +      */
> +     cpu_pmu->name =3D "atcpmu";

This looks like it should have a more complete version string, e.g. with
"spav3" in it.

[...]

> +static int
> +validate_event(struct pmu *pmu, struct pmu_hw_events *hw_events,
> +            struct perf_event *event)
> +{
> +     struct nds32_pmu *nds32_pmu =3D to_nds32_pmu(event->pmu);
> +     //struct pmu *leader_pmu =3D event->group_leader->pmu;

Code which is commented out should be deleted.

[...]

> +static int cpu_pmu_request_irq(struct nds32_pmu *cpu_pmu, irq_handler_t =
handler)
> +{
> +     int i, err, irq, irqs;
> +     struct platform_device *pmu_device =3D cpu_pmu->plat_device;
> +
> +     if (!pmu_device)
> +             return -ENODEV;
> +
> +     irqs =3D min(pmu_device->num_resources, num_possible_cpus());
> +     if (irqs < 1) {
> +             pr_err("no irqs for PMUs defined\n");
> +             return -ENODEV;
> +     }
> +
> +     for (i =3D 0; i < irqs; ++i) {
> +             err =3D 0;
> +             irq =3D platform_get_irq(pmu_device, i);
> +             if (irq < 0)
> +                     continue;
> +
> +             /*
> +              * If we have a single PMU interrupt that we can't shift,
> +              * assume that we're running on a uniprocessor machine and
> +              * continue. Otherwise, continue without this interrupt.
> +              */
> +             if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
> +                     pr_warning
> +                         ("unable to set irq affinity (irq=3D%d, cpu=3D%=
u)\n",
> +                          irq, i);
> +                     continue;
> +             }
> +
> +             err =3D request_irq(irq, handler, IRQF_NOBALANCING, "nds32-=
pfm",
> +                               cpu_pmu);
> +             if (err) {
> +                     pr_err("unable to request IRQ%d for NDS PMU counter=
s\n",
> +                            irq);
> +                     return err;
> +             }
> +
> +             cpumask_set_cpu(i, &cpu_pmu->active_irqs);
> +     }
> +
> +     return 0;
> +}

Is nds32 SMP?

If not, this should be simplifed to expect one CPU alone.

If so, this needs to clarify which IRQ maps to which CPU with an
explicit property in the DT, as we do for arm with interrupt-affinity.

Thanks,
Mark.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
