Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9842DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C954208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vCFELTjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C954208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeI0GrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:47:01 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38511 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeI0GrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:47:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id u197-v6so714170oif.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 17:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKh94bqcmcxXXBPvJjz7tWa5BYY14UvwOBt/In0bPQc=;
        b=vCFELTjF1lvBAVcGUNe4szIkDJOBsPpzQtIu73sT8237W2W3vcZ/f/9g7CzymiFfeE
         ZaNg0kxgzzfBr3/RA4SNIFe7KXSOqrhfoTt6IzMowWnGAxFIDL0Q1YZPRfXXy1GnxpIK
         eMGzqJ+xUO9t8QUwWd+6Un+GOQoxgkOiWR5uAiXTXFVOJALhGHjLQNST6hQ8iIojFWdZ
         Dra9mS19mblZM/RiqtjvOIs3wfp8qqK8vLiBUOh26jStfTlXzbfEn4uxD1GXGoHM5Umd
         8u4LBK7uadtBHENIB7ZXzFfd0GzNEOJK42975VxIrT/uPeqSYQ+bBdtGLeDfNSy8emw6
         posQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKh94bqcmcxXXBPvJjz7tWa5BYY14UvwOBt/In0bPQc=;
        b=SVr+fjzdto2Cvyh5g7Wxl7EPQC+cRj8OcM7Hoyp7YoLZ/+k3CPsb9DspaldNg9RioY
         Z68XSmuSrkMFxt3jRlXJI/WH8nUEIO1lj9GZzTGY0UdTi9XctGT/OvA19fRPOPf8fQTu
         oy4IK31Vv4m4EA9dyxdRXmbe/Z63/XwHNEGrAlI9/JYcjT+ff3u4LWDdpjvJi7aQGbOl
         3J2//exgmVwTus07A5O+HNhKFoDCV31xurWB28u3SLJmQw1BNbUGlCT/w1LOBV7Tz9y5
         a1STbIP55rqzwEejPHtOBtd07alqdyjgSLWf75kyPVqdsp9eeb+FnWT4lFG50pZT987Y
         8bdg==
X-Gm-Message-State: ABuFfoiFizAEs48sMd8M5Y98NiAhMDnDV44xQ5s10/uWZe5doIX8yeuU
        +cYHWxyE3UCRTw2p3Te555aecJwKf5WoyI7ymzIvsA==
X-Google-Smtp-Source: ACcGV63ML3L9R5OtfelQlho+XweDC3LkTh5D19BqC+uSILgkEaWHRp/kNNwNRQds3XCw03THhhoD0irrQFVTqw2vlHc=
X-Received: by 2002:aca:b02:: with SMTP id 2-v6mr1919169oil.305.1538008288792;
 Wed, 26 Sep 2018 17:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180926214433.13512.30289.stgit@localhost.localdomain> <20180926215143.13512.56522.stgit@localhost.localdomain>
In-Reply-To: <20180926215143.13512.56522.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Sep 2018 17:31:16 -0700
Message-ID: <CAPcyv4iJOYiM+rHsM4GPifKNJ=X+AtV2MgWTn+f7u0VBzXb2og@mail.gmail.com>
Subject: Re: [RFC workqueue/driver-core PATCH 2/5] async: Add support for
 queueing on specific NUMA node
To:     alexander.h.duyck@linux.intel.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        jiangshanlai@gmail.com, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 2:51 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This patch introduces four new variants of the async_schedule_ functions
> that allow scheduling on a specific NUMA node.
>
> The first two functions are async_schedule_near and
> async_schedule_near_domain which end up mapping to async_schedule and
> async_schedule_domain but provide NUMA node specific functionality. They
> replace the original functions which were moved to inline function
> definitions that call the new functions while passing NUMA_NO_NODE.
>
> The second two functions are async_schedule_dev and
> async_schedule_dev_domain which provide NUMA specific functionality when
> passing a device as the data member and that device has a NUMA node other
> than NUMA_NO_NODE.
>
> The main motivation behind this is to address the need to be able to
> schedule device specific init work on specific NUMA nodes in order to
> improve performance of memory initialization.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
[..]
>  /**
> - * async_schedule - schedule a function for asynchronous execution
> + * async_schedule_near - schedule a function for asynchronous execution
>   * @func: function to execute asynchronously
>   * @data: data pointer to pass to the function
> + * @node: NUMA node that we want to schedule this on or close to
>   *
>   * Returns an async_cookie_t that may be used for checkpointing later.
>   * Note: This function may be called from atomic or non-atomic contexts.
>   */
> -async_cookie_t async_schedule(async_func_t func, void *data)
> +async_cookie_t async_schedule_near(async_func_t func, void *data, int node)
>  {
> -       return __async_schedule(func, data, &async_dfl_domain);
> +       return async_schedule_near_domain(func, data, node, &async_dfl_domain);
>  }
> -EXPORT_SYMBOL_GPL(async_schedule);
> +EXPORT_SYMBOL_GPL(async_schedule_near);

Looks good to me. The _near() suffix makes it clear that we're doing a
best effort hint to the work placement compared to the strict
expectations of _on routines.

>
>  /**
> - * async_schedule_domain - schedule a function for asynchronous execution within a certain domain
> + * async_schedule_dev_domain - schedule a function for asynchronous execution within a certain domain
>   * @func: function to execute asynchronously
> - * @data: data pointer to pass to the function
> + * @dev: device that we are scheduling this work for
>   * @domain: the domain
>   *
> - * Returns an async_cookie_t that may be used for checkpointing later.
> - * @domain may be used in the async_synchronize_*_domain() functions to
> - * wait within a certain synchronization domain rather than globally.  A
> - * synchronization domain is specified via @domain.  Note: This function
> - * may be called from atomic or non-atomic contexts.
> + * Device specific version of async_schedule_near_domain that provides some
> + * NUMA awareness based on the device node.
> + */
> +async_cookie_t async_schedule_dev_domain(async_func_t func, struct device *dev,
> +                                        struct async_domain *domain)
> +{
> +       return async_schedule_near_domain(func, dev, dev_to_node(dev), domain);
> +}
> +EXPORT_SYMBOL_GPL(async_schedule_dev_domain);

This seems unnecessary and restrictive. Callers may want to pass
something other than dev as the parameter to the async function, and
dev_to_node() is not on onerous burden to place on callers.
