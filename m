Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7406EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A0B22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gDW8EfK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A0B22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeKNFUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:20:05 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41822 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeKNFUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:20:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so21502208qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 11:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qpl4BdAze40FzD7k4SFOau9fQIiJToq5aiIxGv+8WDc=;
        b=gDW8EfK3TMEoYVW5Lnnpr7FTDD0FNQHOn/q70EPCW1nTp1uKZf1rAojQi23qF+gBv2
         5Q9aoyv7p4zdC0lwPUKtC5ZaczdRDp+qzfaxvxyV/eF6togzoG23lBI9SNmNT9vkezqa
         DG60Ak7OF5hyHp+XbfHevTzy78QGcq6y0C54sMKtqlH3VhH+lH1ZY2QPRnl3K4Xnqe9s
         0iJ3mTNLmr3Pn2PiVYiZX58rY+VLcCGMjGlc/wc69Hj6MK16gLx5zz0XzM4O78FMFloI
         772z0t/sW9uZcMAnNfNdtn33RWDtoBpcseKVF5BSkR/qlc6IAJ/v8KQ3BzigKiv8K/xk
         fwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qpl4BdAze40FzD7k4SFOau9fQIiJToq5aiIxGv+8WDc=;
        b=Xst7G6N3149Kx+lbXWIPgqczIj1VaxRKJxJa85Oqko6vUxLT5FX7iDCp4w9+HjRmYg
         337FKVYT+XOJIjh1iHqy8TPKsP/eWajD5YAmpxmiWuKtgR+CDeXFxBkqner1jkN4F7hX
         cRBLZF/ZIgjQ+MpPLxLvzZ8A/gwzkazkJdsOwGoTEgh/cNE7iFafOLlOjl3ZuYndHJIS
         xUr+CH5n9LMa+W0SVw3Ay9EF8SyXoTY4JrIwP3uaL8HliAbfdPka6Cm5gFMbyQx6tC43
         u+0bLH8gg1uy4073W8WY4EHdwaD2pUdE7FSSOAvK70ZvE9kOGH7byOepS+MMuQ2yW16n
         hBQA==
X-Gm-Message-State: AGRZ1gIvAksIJNYX+FaBCsra4+IDZaw2hR9JH1knrikpJzRl6Y5pWFcg
        3glC3qY0m3pKCddC9bdSQXmh2A==
X-Google-Smtp-Source: AJdET5dJTYAPLafInJ8u9K7fJcKrbOpEwJJzT/9GvUw52xO+3f04n1eGWfhvwgncWqx2SGWC/C4TSQ==
X-Received: by 2002:a37:5ac4:: with SMTP id o187mr5991141qkb.282.1542136834505;
        Tue, 13 Nov 2018 11:20:34 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id n8sm12477590qtk.91.2018.11.13.11.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 11:20:33 -0800 (PST)
Date:   Tue, 13 Nov 2018 19:20:31 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] l1tf: drop the swap storage limit restriction when
 l1tf=off
Message-ID: <20181113192031.7fq5gkal62ygu6tr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181113184910.26697-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113184910.26697-1-mhocko@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-13 19:49:10, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Swap storage is restricted to max_swapfile_size (~16TB on x86_64)
> whenever the system is deemed affected by L1TF vulnerability. Even
> though the limit is quite high for most deployments it seems to be
> too restrictive for deployments which are willing to live with the
> mitigation disabled.
> 
> We have a customer to deploy 8x 6,4TB PCIe/NVMe SSD swap devices
> which is clearly out of the limit.
> 
> Drop the swap restriction when l1tf=off is specified. It also doesn't
> make much sense to warn about too much memory for the l1tf mitigation
> when it is forcefully disabled by the administrator.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
