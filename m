Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD884C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984AB20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="QHg+1Glv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984AB20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441461AbeKXHHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:07:23 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39073 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeKXHHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:07:23 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so19445976itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ztVUjuR029DPuq6x1COYKxRhgpBTvFYUQJdXiWMSsY=;
        b=QHg+1Glvk7KVsuJp7mdds9RnOMm9MUE5lHaigz6dVIESzE+lM0ulpzN3RurgPx8/ii
         oltlMRx9XnrOFFyipqW1iqq/3+l34wHxJO68tYHKDe0K6Frvg7OJRLQaH+bVOaBu3qeG
         2TAkwyR4ial7zcNN7GOeFafLky+ns+WP6SCDLsqNIw30P0RDH+uSbot5WHNOp6CEtyA8
         vDBb+VRd89QGXGkVklJ7euvqXEkxuiq6cEwlEK/GSJsQP1Bxfq0Y10/FyXafr6gbOoRY
         eFPPJVr/cDdevfu/HtrkDV4AHnJzUtCnCiCkNjZC52JaHoJ/rS9Fd+K2qMhfJ0QHdXGz
         7AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ztVUjuR029DPuq6x1COYKxRhgpBTvFYUQJdXiWMSsY=;
        b=k+VhrPN++3hlOvo4ksVg8Da3LB0Jpw2FXqgGQBZdmTgLuClMCQh95CJzY6argqB+4g
         4PGNvLzNQcc4dRJHs0ttcBblrKU4BW1v9/mgQ0gyzXZicKgNwqvmkL+4Y5D0FOlawZsy
         Erm5+14b08J/niqVzDGzkte/ViWbI/zyyljDOB0KGMr/r4hXmYHQbzX9avOafDVSNkVk
         9ayBvOX5YGmRd+ku9H9Az91mQ+w2G7ojuhvYHT3focT9VUyY59t7KKAhlPMWHXceaRMQ
         2bAsYo7JFVxq9VLFc5gdlbB7+sCqVvzapSBrLdC8SHxhisTM6wi8ZJ3wgCw2+en8cM77
         8mUw==
X-Gm-Message-State: AA+aEWY1FwdZrZQxf981Qngg6pQ6BUqRX1uJ0PVcXOidnL/IG+Rs8ZmQ
        xScmn8Z0xQE8MyiGG0HqzOSaPg==
X-Google-Smtp-Source: AFSGD/UkBVJ3JEn5YKF8mCs+WCVZSToi4u1J1uWhCaeiE3Kvlovi9/SWVeDugs5UiSApLzwO239kkQ==
X-Received: by 2002:a24:76d0:: with SMTP id z199mr3048319itb.165.1543004496721;
        Fri, 23 Nov 2018 12:21:36 -0800 (PST)
Received: from [192.168.5.201] (96-67-187-70-static.hfc.comcastbusiness.net. [96.67.187.70])
        by smtp.googlemail.com with ESMTPSA id s13sm6521238ioj.71.2018.11.23.12.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 12:21:35 -0800 (PST)
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, james.w.mcmechan@gmail.com
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <7f2b0288-a173-e2bb-70ee-d552610bfc1e@landley.net>
Date:   Fri, 23 Nov 2018 14:21:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122154942.18262-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 9:49 AM, Roberto Sassu wrote:
> Although rootfs (tmpfs) supports xattrs, they are not set due to the
> limitation of the cpio format. A new format called 'newcx' was proposed to
> overcome this limitation.

I got email about that format the day before you posted this, by the way.

> However, it looks like that adding a new format is not simple: 15 kernel
> patches; user space tools must support the new format; mistakes made in the
> past should be avoided; it is unclear whether the kernel should switch from
> cpio to tar.

The kernel _can't_ switch from cpio to tar without breaking backwards
compatability, it could only add tar as a second format it supported (remember
cpio images can be sideloaded so a new rootfs can be used with an existing
initramfs, plus existing build systems generate them and would still need to if
they wanted to keep supporting older kernels), and then once you've got two
formats somebody will propose zip support, and let's just not go there please.

The changes to the userspace tools are trivial (I say that as the maintainer of
toybox, which has a cpio). The argument was about things like 64 bit timestamps
(y2038 problem), nanosecond support, sparse files, etc. And I think the argument
had largely died down?

Keep in mind the squashfs guy spent 5 years trying to get his filesystem merged
(https://lwn.net/Articles/563578/), I spent several years trying to get my perl
removal patch merged (and only work up the enthusiasm to resubmit
http://lists.busybox.net/pipermail/buildroot/2015-March/123385.html
https://patchwork.kernel.org/patch/9193529/ https://lkml.org/lkml/2017/9/13/651
about once a year because dealing with linux-kernel is just no fun for hobbyists
anymore).

> The aim of this patch is to provide the same functionality without
> introducing a new format. The value of xattrs is placed in regular files
> having the same file name as the files xattrs are added to, plus a
> separator and the xattr name (<filename>.xattr-<xattr name>).

I think you're solving the wrong problem, but that's just my opinion.

Rob
