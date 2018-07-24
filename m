Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031A0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF18E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cnqo0noi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF18E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeGXRDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:03:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53290 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388398AbeGXRDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:03:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180724155627euoutp02a3768936431c65ae3bf7fa833e6fd254~EWSSyNPqD0350503505euoutp02j;
        Tue, 24 Jul 2018 15:56:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180724155627euoutp02a3768936431c65ae3bf7fa833e6fd254~EWSSyNPqD0350503505euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532447787;
        bh=QMwN1UQPuD6nu3jbmw0FhT++33h26T2YYVYyVwAmCLU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=cnqo0noi2nkQJZ+YxRGgjxK8vUh5p/W3nqQ7GvvAEH3ZgcE4SRbQ6OVvv+IUYWIi9
         fPV33oL7fYhsNAhxncambH/WHnNwqbP7H3+ZOSo25XqHLH6BXb9JdFS1J2L7K/Wkau
         LaM2NS6KZheu36wZ6R1M8iB88cbGaKmLv8ILb4KE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724155627eucas1p190e1d79687e94e767c963704d8892ae6~EWSSeK0_S0997409974eucas1p1R;
        Tue, 24 Jul 2018 15:56:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EE.A8.61560.A2C475B5; Tue, 24
        Jul 2018 16:56:26 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724155626eucas1p2732ac0bd322282a068b2ee659d2e248a~EWSR0ai1e0499504995eucas1p2b;
        Tue, 24 Jul 2018 15:56:26 +0000 (GMT)
X-AuditID: cbfec7f5-207ff7000002f078-54-5b574c2a2db6
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AF.5A.04178.A2C475B5; Tue, 24
        Jul 2018 16:56:26 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync3.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD00DYBOA2OC80@eusync3.samsung.com>; Tue, 24 Jul
        2018 16:56:26 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omapfb: Mark expected switch fall-throughs
Date:   Tue, 24 Jul 2018 17:56:25 +0200
Message-id: <5148330.xZP60O7hy1@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180709220436.GA10751@embeddedor.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7djPc7paPuHRBs8P6Fpc+fqezWLrHlWL
        E30fWC0u75rDZjF7ST+LA6vHuoOqHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJVx5k9mwT+m
        ilunHjI3MG5n6mLk5JAQMJF48WcLSxcjF4eQwApGia/XfzBDOJ+BnKNLWWGqVk/ayQJiCwks
        Y5S48roaoug3o8TsPefARrEJWElMbF/FCGKLCBhJzJ7RDdbMLFAjcfT1LnYQW1jAXqLz0yWw
        GhYBVYm/SzvB4rwCmhK7Zz1iBrFFBbwktuxrB5vJCbR48rPfbBA1ghI/Jt9jgZgpL7Fv/1So
        +ToSZ4+tYwQ5SEJgCpvEvUPTmCGudpG4u/o8lC0s8er4FnYIW0ais+MgE0TDdEaJN7+WskA4
        6xkl1pw5Bg0Za4nDxy9CreCTmLRtOtAkDqA4r0RHmxCE6SHx/EgMJFTaGSVeN+tMYJSZheTW
        WUhunYXk1gWMzKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECI/z0v+NfdzDu+5N0iFGA
        g1GJh/eDXXi0EGtiWXFl7iFGCQ5mJRHeRaJAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxxGnVR
        QgLpiSWp2ampBalFMFkmDk6pBsaT3xT/3lzcaXj8/EtrLebgY/tWXIvSqOxVDdx9Jn/qgmvJ
        Dz58cbuUrduzKFv8jei3+du+/N8qe/+B3q3XuzatWDjzVFB/tmBp0JTrP/bJsgqcyP3tl3mW
        5e1Z8SPT/3LyihouWh6+Sr5lttKu+9Uu0rxve2o2dzXEfDh8xfd0jN91e9dNq5asUWIpzkg0
        1GIuKk4EAMSie1LsAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsVy+t/xq7paPuHRBp2NghZXvr5ns9i6R9Xi
        RN8HVovLu+awWcxe0s/iwOqx7qCqx/3u40wenzfJBTBHcdmkpOZklqUW6dslcGWc+ZNZ8I+p
        4taph8wNjNuZuhg5OSQETCRWT9rJ0sXIxSEksIRR4syxS4wQzl9GiW9XD7GCVLEJWElMbF/F
        CGKLCBhJzJ7RDRZnFqiRaGq9wg5iCwvYS3R+ugRWwyKgKvF3aSdYnFdAU2L3rEfMILaogJfE
        ln3tYJs5gTZPfvabDWJZJ6PE87ttbBANghI/Jt9jgVggL7Fv/1SoZVoS63ceZ5rAyD8LSdks
        JGWzkJQtYGRexSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERig24793LyD8dLG4EOMAhyMSjy8
        Ho7h0UKsiWXFlbmHGCU4mJVEeBeJAoV4UxIrq1KL8uOLSnNSiw8xSnOwKInznjeojBISSE8s
        Sc1OTS1ILYLJMnFwSjUwht1OEHl757Zi87S15teWmm3ImLB96u7e1fdL1gQwTz0tvfBPUaWG
        WnjOj+cLd7r89S67tWvzfWEL+enqYee19x3KORV0bukENcHuwAb9xJY966a5Zn+LUfg7d/X0
        jP1dMXWyfPc2vHeIvz01Tfbwna01r8wNOhefKrjj+HHig4rdxw+eiz8mmazEUpyRaKjFXFSc
        CAClNiakTAIAAA==
X-CMS-MailID: 20180724155626eucas1p2732ac0bd322282a068b2ee659d2e248a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180709220440epcas1p4327d007d1f871a8bf3767d1f88a7be7f
References: <CGME20180709220440epcas1p4327d007d1f871a8bf3767d1f88a7be7f@epcas1p4.samsung.com>
        <20180709220436.GA10751@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 09, 2018 05:04:36 PM Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

