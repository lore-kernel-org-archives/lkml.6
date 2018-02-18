Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeBRNde (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:33:34 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:43870 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeBRNdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:33:32 -0500
X-Google-Smtp-Source: AH8x226NTggpEBnzSCP6Go25RK/NV7WG/YwbqkIH8POMezkxdJPuPphyq4lurynclvpgBRujEELMoA==
Date: Sun, 18 Feb 2018 05:33:28 -0800
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Christoph Lameter <cl@linux.com>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] percpu: allow select gfp to be passed to
 underlying allocators
Message-ID: <20180218133328.GH695913@devbig577.frc2.facebook.com>
References: <cover.1518668149.git.dennisszhou@gmail.com>
 <a166972c727e3a1235a7ad17b9df94ca407a1548.1518668149.git.dennisszhou@gmail.com>
 <20180216180958.GB81034@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216180958.GB81034@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:09:58PM -0600, Dennis Zhou wrote:
> The prior patch added support for passing gfp flags through to the
> underlying allocators. This patch allows users to pass along gfp flags
> (currently only __GFP_NORETRY and __GFP_NOWARN) to the underlying
> allocators. This should allow users to decide if they are ok with
> failing allocations recovering in a more graceful way.
> 
> Additionally, gfp passing was done as additional flags in the previous
> patch. Instead, change this to caller passed semantics. GFP_KERNEL is
> also removed as the default flag. It continues to be used for internally
> caused underlying percpu allocations.
> 
> V2:
> Removed gfp_percpu_mask in favor of doing it inline.
> Removed GFP_KERNEL as a default flag for __alloc_percpu_gfp.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>

Applied 1-3 to percpu/for-4.16-fixes.

Thanks, Dennis.

-- 
tejun
