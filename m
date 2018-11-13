Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39134C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67FD22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd15B7c/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67FD22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeKMOhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:37:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33843 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeKMOhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:37:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so4830716pgg.1;
        Mon, 12 Nov 2018 20:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njG/QffyFH2IJeSZ4WMkJ4KQHGpsy1NDRpskpBkvbw0=;
        b=hd15B7c/0tj/3NRzDjAXPQq2Wm5bUSXcM++yr+9ELPefitcPCjCdDw1vkk9m3oswjp
         dpuIe4axSP2N8mzNvklfBGgHYkEmsYLO8a6q5cvmqIejiLf/CG+scBCZolmx9j6Zhdyz
         Lr2vrQzCZ5hYf0LBO+zrBd+Z1QO8xXti3HRPV5qm0yT29Sk5dfR1dpvyBalHL4cb1G41
         JXSOEuLq1plUmgWNT198JjQ4YK/YnyTOBCHJMF7Kff2/2nFurUnNGzSDeQ3j8DZ6YJCQ
         lRySK85dgwXtabxXDyaGpRPzE6l/Kkuguzo4oNiXZ4CJE6gT3TXngT1PKtVAN5qUVOZG
         ybqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njG/QffyFH2IJeSZ4WMkJ4KQHGpsy1NDRpskpBkvbw0=;
        b=qRiGFryntU64XNmyBoLBvJbWsxOYOyiwDmaZgoJPlKmeMz2Jwi9zBKRDpWv6JwJdjt
         c9TnJlFOZPKHpTk3AXd+QwphCUVWnFS5yFgH7Z1BRILbFA1Cz96Ur4SRjKJn/kvnWIcD
         GH3az1Pj+A2PEXsp35O+JJPp1Hrf7uHHJW/wJnXcRIPZHyR9Y+yGioeQrZ/+ksTAW/yS
         Ho9QRX248vjtpMvekRGQUO2giQ4+tt+q6MwddF01yEM3KVTvousUPh5PY0h916whOdYA
         UAKGSiwUbsg2isyL0QeSxWGLxcEzVM7C7zaQXMH7gfpqJe8FZcgH+yyhXoOFoc4yhwuD
         75jw==
X-Gm-Message-State: AGRZ1gIEI+qMfhwiI0pPkm5ZZqRz4mWLqp8GBYTRz+7zg8bRqyiBlQLy
        7W1f+DTnuF13B72r/ihjvVI=
X-Google-Smtp-Source: AJdET5cXcEbfsB7/0XBKYmfRPs4L3kwqAhekk3YHW50BPu09RVLPqTeSUJb3ECw9N0OluFx3yTwThg==
X-Received: by 2002:a62:c299:: with SMTP id w25-v6mr3762870pfk.205.1542084092575;
        Mon, 12 Nov 2018 20:41:32 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id t78-v6sm34623220pfk.59.2018.11.12.20.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 20:41:32 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:41:24 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add mutex lock to shunt nodes
Message-ID: <20181113044122.GA26327@Asurada-Nvidia.nvidia.com>
References: <20181113042324.852-1-nicoleotsuka@gmail.com>
 <20181113043122.GA11205@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113043122.GA11205@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:31:22PM -0800, Guenter Roeck wrote:
> On Mon, Nov 12, 2018 at 08:23:24PM -0800, Nicolin Chen wrote:
> > The shunt resistor values are used to calculate shunt voltages
> > and currents. As a part of sysfs nodes, it would be better to
> > get protected with the same mutex too as other sysfs ABI nodes,
> > although this is not very critical because the mutex was added
> > to mainly protect register access.
> > 
> > So this patch adds the mutex lock to protect the shunt node.
> > 
> 
> I am missing something here. I don't see the point of this mutex.
> It just reads a variable and reports the result. When setting,
> it just writes a value. Protecting the conversion of the passed
> value with a mutex is pointless. Protecting writing the value
> against reading it is just as pointless.

The penalty here is that the resistor value would be mismatched
between here and the ongoing calculation when a race happens to
the sysfs accesses. But I feel it might not be really that hurt
to allow it happen.

Let's just drop it then: the mutex was used to protect register
read/writes any way.

Thanks
Nicolin
