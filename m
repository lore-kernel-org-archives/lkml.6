Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D533C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4071F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQVT+vAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4071F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbeKVIsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:48:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37657 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKVIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:48:05 -0500
Received: by mail-io1-f67.google.com with SMTP id a3so5226915ioc.4;
        Wed, 21 Nov 2018 14:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8UGeUladCYKzq0FcT9XuJ5u5dRUG3xqSMTDU6lXiDQ=;
        b=nQVT+vAmQQlKhpQe9JreBSYMaN2mzmKsf2cjUcK7VgGqY7Q/RJfv54U0nTBV9QW4DK
         SWFD+G1PHS+AXoxe1A0e+ZlaVWMrWbCCezRXFAIxPSHgGJ8EBIVkhS4V8WA5ro8f0hM6
         1PhMotFQ/ev1Tdes+mezjOG9Bvv9iDXGaWhJwG7e44h5Mh2iGFn0M3XR5iv5b+VEsRrQ
         5w8nh4DWL+v7hLA2GNTgZNLcX8DPAICXlznqTZEvzKs2jWn5iSgVOtbBhtnXM/jpSbrL
         YO2BpQsBQE2bBjqaO+L7pX2c9QLqXJDH/PQcRWXJqpq4T1UAyCIKLokdMSpJfObVsr5T
         1Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8UGeUladCYKzq0FcT9XuJ5u5dRUG3xqSMTDU6lXiDQ=;
        b=dtT27Ew3Dsi0cJiBRD7JBZg3F3IsKzGKWbYQS+o3KLwjKErNyN6kTttVhsVFkkcah2
         m08307ITgqojR6MuTAxDMNrn5P8KS5K12i07JRApgU9M4PSUTiBPfIcx5NfZumzbVyuw
         2IFcDq1lgtSJ1qnOz+39ul1ZfVRfPV5nEVvuRJpYIIQhR5r8laVg9Yy1MLvstFRhQlVz
         Grlv0HLVnz1qg4cs8Hb0ivkmonndtqrDf9ZupYPRCC1vqpuM6Huqu5S8VXh2iiljc5cc
         xK06+1h0uaPtKXTWCdgl3hVr9aNfIVN9L+G1P+qta6tqkx6Ox1Sa6mwMGCinHLR47vLh
         z0fw==
X-Gm-Message-State: AA+aEWb7+hFFkorXRBZodDqSb894sLSivs1Vo9u2jHMN5wGsxc1iXW2d
        2QXWb9MYncJtZdvj3aiXAm4=
X-Google-Smtp-Source: AFSGD/UObcBjCupYeGlKlsqMCLMnGOe0SZytT+Q5WhsY3uCpz80NOXjTp+iUdU6+EFrV4TZT8tDLiw==
X-Received: by 2002:a6b:1846:: with SMTP id 67-v6mr5921452ioy.263.1542838311487;
        Wed, 21 Nov 2018 14:11:51 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:180::1:6a9])
        by smtp.gmail.com with ESMTPSA id h137-v6sm847841itb.39.2018.11.21.14.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 14:11:50 -0800 (PST)
Date:   Wed, 21 Nov 2018 14:11:47 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, acme@kernel.org,
        peterz@infradead.org, kernel-team@fb.com
Subject: Re: [PATCH perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Message-ID: <20181121221145.2cxph7zv27x7lbg6@ast-mbp>
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181121195502.3259930-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121195502.3259930-6-songliubraving@fb.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:55:02AM -0800, Song Liu wrote:
> This patch enables perf-record to listen to bpf_event and generate
> bpf_prog_info_event for bpf programs loaded and unloaded during
> perf-record run.
> 
> To minimize latency between bpf_event and following bpf calls, separate
> mmap with watermark of 1 is created to process these vip events. Then
> a separate dummy event is attached to the special mmap. A separate thread
> is used to only poll bpf events.
> 
> By default, perf-record will listen to bpf_event. Option no-bpf-event is
> added in case the user would opt out.

I think only default perf-record for sampling should include it.
perf record -e for tracepoints, kprobes and anything else should imply no-bpf-event.

