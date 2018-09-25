Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DAEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F248A20896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F248A20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeIYX7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:59:42 -0400
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:37317 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbeIYX7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:59:41 -0400
X-EEMSG-check-008: 217593058|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Sep 2018 17:50:59 +0000
X-IronPort-AV: E=Sophos;i="5.54,303,1534809600"; 
   d="scan'208";a="16207305"
IronPort-PHdr: =?us-ascii?q?9a23=3AQRvbnRy9xgEJhe/XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0ukTL/ad9pjvdHbS+e9qxAeQG9mDtLQc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYQhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98NqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym1WtkCtsx/DAMb3sGYvNLmTZnLj/YL?=
 =?us-ascii?q?l99lZWyBAvwtBH+5JUFrYBLer8Wk/rqtPYARw5MwyvzubjCdV90J4eWG2BAq?=
 =?us-ascii?q?+eLaPSt0KH6fgzI+mNY48VvizxK/8/5/7hlXU5g0MSfbG13ZsLb3C1Bu5pI1?=
 =?us-ascii?q?+HYXXymdoOC2EKsRckTOztiV2NTCRfaGq1X6I5/js7Ep6pDZ/fRoCxh7yMxD?=
 =?us-ascii?q?u7Hp5UZmBBEVCBCm3nd4OZVPcWbyKSI9JuniYYWrimTo8rzQuuuxPiy7p7Mu?=
 =?us-ascii?q?rU/TUVtZf529dp4O3ejgs99TppAMSH1GGNTnx7knkUSD8x2aB1uVZ9xUub0a?=
 =?us-ascii?q?hkn/xYEsRe6O5XXQckK5Hcy/d3BM3oWgLAYNeGVkymTci4DjEvVN4xxMQOY1?=
 =?us-ascii?q?t6G9W5ihDPxS2qA6Ual7aTHpw77rrc32TtJ8Z603vG0Kghj187QspALGGmhb?=
 =?us-ascii?q?Bw9xLVB4HXl0WUjLiqdasC0y7X7muDznSBvFteUAFuVaXJR3cfZlHZrd7h/E?=
 =?us-ascii?q?PNU6euCag7MgtG0cOCLqpKatv0jVRJXfvjI8rRbH6sm2eqBBaI2rONYJPve2?=
 =?us-ascii?q?UawSrdFUwEnB4I8HaYOggxGD2hr3jdDDNwD1LvZV3j8e1kpHO8VE80wBmAb1?=
 =?us-ascii?q?d92Lqt5h4VmfucRusI3rIEpighrTt1E0i7393NDNqAvA9hfKRYYdwj+1pH2m?=
 =?us-ascii?q?fZuBZ8PpykNaxtmlkecwEk93/pgilwDIoIo8gjqnximBhuLqSX+E1dMT6UwM?=
 =?us-ascii?q?a0crLNJ2bx/DiraqjLyl/ZzdCa87sO7/J+rE/s+EmgDFQv23xh38NS0nfa7Z?=
 =?us-ascii?q?LPSEIOUpD2SW4+8RRgoLDWJCI64sec0HRnNoG9tDPY3NMlQuAiz0WOZdBaZZ?=
 =?us-ascii?q?iYGRfyHstSPM2nLOgnihD9dR4fFPxD/64zecW9fr2J37D9b7Uopy6vkWkSuN?=
 =?us-ascii?q?M16UmL7ScpD7eSh5s=3D?=
X-IPAS-Result: =?us-ascii?q?A2ApAAADdapb/wHyM5BbDgwBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?VOBYiqBZIQclEJQAQEGgQgtiGiIH4VHgXo2AYRAAoNmITYWAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjUkAYJfAQUjDwEFQRALDgoCAiYCAlcGAQwIAQGCXj+BdQ2kJYEuhHeFI?=
 =?us-ascii?q?oELiW8XeYEHgRIngmuHf4JXApx/CYdxiDIGF48sK5YnBSyBVSsIAhgIIQ+DK?=
 =?us-ascii?q?IM2AQeMW1YjgSsBAY0WAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 25 Sep 2018 17:50:57 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8PHorPT026129;
        Tue, 25 Sep 2018 13:50:54 -0400
Subject: Re: leaking path in android binder: set_nice
To:     Tong Zhang <ztong@vt.edu>, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
References: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d38229cb-eb38-19fa-f5d6-30e6389ade3b@tycho.nsa.gov>
Date:   Tue, 25 Sep 2018 13:52:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 01:27 PM, Tong Zhang wrote:
> Kernel Version: 4.18.5
> 
> Problem Description:
> 
> When setting nice value, it is checked by LSM function security_task_setnice().
> see kernel/sched/core.c:3972 SYSCALL_DEFINE1(nice, int, increment)
> 
> We discovered a leaking path in android binder which allows using binder’s interface to change
> a process’s nice value. This path is leaked from being monitored by LSM.
> see drivers/android/binder.c:1107 binder_set_nice.

Not sure you want to invoke the LSM hook (or at least the same hook) 
when binder is performing priority inheritance.  There is a difference 
between a userspace process switching its own priority and the kernel 
binder driver performing it.  IIUC, the can_nice() check is more about 
honoring RLIMIT_NICE than anything else.



