Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeDJUGy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:06:54 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:37891 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeDJUGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:06:53 -0400
X-Google-Smtp-Source: AIpwx4+RTvXXxKlhFW8Xjr0ARGQR4lCgrnFHO/aIuz3HM+7Ccds0v+A9iQuA+wqT29H+u1eCYZnKew==
Date: Tue, 10 Apr 2018 23:06:51 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180410200651.GF2041@uranus.lan>
References: <20180410090917.GZ21835@dhcp22.suse.cz>
 <20180410094047.GB2041@uranus.lan>
 <20180410104215.GB21835@dhcp22.suse.cz>
 <20180410110242.GC2041@uranus.lan>
 <20180410111001.GD21835@dhcp22.suse.cz>
 <20180410122804.GD2041@uranus.lan>
 <097488c7-ab18-367b-c435-7c26d149c619@linux.alibaba.com>
 <8c19f1fb-7baf-fef3-032d-4e93cfc63932@linux.alibaba.com>
 <20180410191742.GE2041@uranus.lan>
 <e868b50d-88a3-a649-d998-b7f2bb2c40aa@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e868b50d-88a3-a649-d998-b7f2bb2c40aa@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 12:33:35PM -0700, Yang Shi wrote:
...
> 
> The race condition is just valid when protecting start_brk, brk, start_data
> and end_data with the new lock, but keep using mmap_sem in brk path.
> 
> So, we should just need make a little tweak to have mmap_sem protect
> start_brk, brk, start_data and end_data, then have the new lock protect
> others so that we still can remove mmap_sem in proc as the patch is aimed to
> do.

+1. Sounds like a plan.
