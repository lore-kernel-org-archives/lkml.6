Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeBUKCP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:02:15 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35738 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932631AbeBUKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:02:14 -0500
X-Google-Smtp-Source: AH8x225mDITwHTqhhDWXYamugjEK+SM9phqchC9gLdJ+Wtw2zX+573S7BGZXwxk8sqTp3Njxi+J9mw==
Date: Wed, 21 Feb 2018 15:32:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
Message-ID: <20180221100209.GP28462@vireshk-i7>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7>
 <874lmasxxx.fsf@concordia.ellerman.id.au>
 <20180221055450.GO28462@vireshk-i7>
 <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-18, 10:27, Rafael J. Wysocki wrote:
> To be precise, ->init() should fail as that's where the table is
> created.  The registration fails as a result then.
> 
> But what if the bug is that ->init() doesn't fail when it should?
> 
> I guess the core could double check the frequency table after ->init()
> if ->target_index is not NULL.
> 
> The overall point here is that if you get a negative index in
> ->fast_switch(), that's way too late anyway and we should be able to
> catch that error much earlier.

I don't want to end up doing double checking as some of it is already
done at init, but let me check on what can be done.

-- 
viresh
