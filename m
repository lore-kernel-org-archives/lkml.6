Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F8FC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A4E218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548343589;
	bh=RAVPF7k8ET3FvZZPo+8OAFQs6/P1bn+R68cQ2w3zA1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HWcUxem7HCjgcrkqT+JDiCW0rUcEZp3awQSUK3zFPlU+0j/54jrOcfVOH3MBwcnwH
	 ICe/i0nOZxrqYDe7Sk8wfUxySnx4qYAcjxj1y+CQi3WRzmIXXEe1s8F8m2LmopCioF
	 agjIJOUNvBq8d06J4gjIsTaHv/OS3P0xcviBDnXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfAXP01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:26:27 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41559 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbfAXP00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:26:26 -0500
Received: by mail-yb1-f194.google.com with SMTP id y63so2502010ybc.8;
        Thu, 24 Jan 2019 07:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0FVwBJEbGSCpbztzTtTWXO0usmZDa4dlEKlgDqHqCvA=;
        b=B8AqbH/hEr7vFeOCysJs7BMVx3i84OMajQGOlflkd98UzHDo0h0ijKJXNfYwVy/+rX
         Sk+Vt6Dr5Y34f+gGZc/qAst6tHczDauakCVy22pKxBWFPjnRi98SE+HtVUrHJd55h52K
         0MYyAKhMTfDpiE0TA8a+yMIS9z5W3XZvjehss3rxSDOa7bcsV/4+OEbzUtbRbGcVECRS
         KkbsuU7HI4rfxZHi6XMwtb7ZSiBJxYmU8OavhKWqCZrasgWtKk2+Jn3WXKUMV+De1AF/
         5MaGD7gCkbvlm0ZeGhPqUZRSewl4Zxu8Ot0PweRe1VZYsFW4t01Vm5qkGSPvqUUrMw3Z
         ucZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0FVwBJEbGSCpbztzTtTWXO0usmZDa4dlEKlgDqHqCvA=;
        b=Y3KgFPKzi36Nf7qrXSFjuTw0CYRxhxp0Wz2XzwPySQiCmVI4o2rQ9RC7SfWLWUFufg
         W39k6LxbMZhU5k8RKCdUjjhx+08vhj1DyH0LeP9DCkVLKM7srCnseloo6/bgTKbqNDgv
         kFU7yYQc624+JjYPZXhAlMb9ZzmVE6NPymabUwjzhleQFpcvt2eiUholSZ58ZGZ2di/S
         sHETMYzhAmaYa/VCgUAXUJ6OzmITXHAhRqX5Lx9c1Jv1utS4Vi4enu8A+sckWJdWV2Mi
         5+Ba+U5Hlhv3eAzEvPpq0Z2PNHxup2h/bXTkVuQH+OKuOR4jDdMjpNr+VrY4N6hQzcFc
         akXg==
X-Gm-Message-State: AJcUukf7NM0ry7tTU8ud+UYmsAvfAfrN9EHMNf7yIxlaRmG1+uY6ED97
        Hk4DEnhpAlxiv9KSwcVt+Ag=
X-Google-Smtp-Source: ALg8bN5RIixGhsIJ0wAcoHbOMQ2cwooi2Ogb+KCPOXMW5eLsfCi5Mbh+Fnly54u97IggKlN9liVXUw==
X-Received: by 2002:a25:8145:: with SMTP id j5mr5725088ybm.472.1548343585841;
        Thu, 24 Jan 2019 07:26:25 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:a8a7])
        by smtp.gmail.com with ESMTPSA id z2sm8461867ywe.32.2019.01.24.07.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 07:26:24 -0800 (PST)
Date:   Thu, 24 Jan 2019 07:26:23 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v6 0/7] freezer for cgroup v2
Message-ID: <20190124152623.GH50184@devbig004.ftw2.facebook.com>
References: <20181222000307.28231-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222000307.28231-1-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 04:03:00PM -0800, Roman Gushchin wrote:
> This patchset implements freezer for cgroup v2.
> 
> It provides similar functionality as v1 freezer, but the interface
> conforms to the cgroup v2 interface design principles, and it
> provides a better user experience: tasks can be killed, ptrace works,
> there is no separate controller, which has to be enabled, etc.
> 
> Patches (1), (2) and (3) are some preparational work, patch (4) contains
> the implementation, patch (5) is a small cgroup kselftest fix,
> patch (6) covers freezer adds 6 new kselftests to cover the freezer
> functionality. Patch (7) adds corresponding docs.
> 
> v6->v5:
>   - reverted to clear TIF_SIGPENDING with additional checks before schedule(),
>   as proposed by Oleg Nesterov
>   - made cgroup v2 freezer working with the system freezer (by using
>   freezable_schedule())
>   - make freezer working with SIGSTOPped and PTRACEd tasks
>   - added tests to cover freezing a cgroup with SIGSTOPped and PTRACEd tasks

Oleg, ping?

Thanks.

-- 
tejun
