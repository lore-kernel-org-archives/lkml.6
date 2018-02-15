Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164012AbeBOVlx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:41:53 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:46597 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163784AbeBOVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:41:52 -0500
X-Google-Smtp-Source: AH8x2257t8H7+7mMVe3hppM8t27ojPqGvKLezgxIYYg6P49Mm9zGb2IxulKyXMTZfFiMpOH+bFoN3w==
Date: Thu, 15 Feb 2018 13:41:48 -0800
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Christoph Lameter <cl@linux.com>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] percpu: allow select gfp to be passed to underlying
 allocators
Message-ID: <20180215214148.GV695913@devbig577.frc2.facebook.com>
References: <cover.1518668149.git.dennisszhou@gmail.com>
 <a166972c727e3a1235a7ad17b9df94ca407a1548.1518668149.git.dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a166972c727e3a1235a7ad17b9df94ca407a1548.1518668149.git.dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 15, 2018 at 10:08:16AM -0600, Dennis Zhou wrote:
> +/* the whitelisted flags that can be passed to the backing allocators */
> +#define gfp_percpu_mask(gfp) (((gfp) & (__GFP_NORETRY | __GFP_NOWARN)) | \
> +			      GFP_KERNEL)

Isn't there just one place where gfp comes in from outside?  If so,
this looks like a bit of overkill.  Can't we just filter there?

Thanks.

-- 
tejun
