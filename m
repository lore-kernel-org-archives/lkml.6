Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbeEAVqH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:46:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEAVqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:46:06 -0400
Date: Tue, 1 May 2018 14:46:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Dave Anderson <anderson@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] proc/kcore: Don't bounds check against address 0
Message-Id: <20180501144604.1cf872e7938bffc01a26349f@linux-foundation.org>
In-Reply-To: <20180501201143.15121-1-labbott@redhat.com>
References: <1039518799.26129578.1525185916272.JavaMail.zimbra@redhat.com>
        <20180501201143.15121-1-labbott@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 May 2018 13:11:43 -0700 Laura Abbott <labbott@redhat.com> wrote:

> The existing kcore code checks for bad addresses against
> __va(0) with the assumption that this is the lowest address
> on the system. This may not hold true on some systems (e.g.
> arm64) and produce overflows and crashes. Switch to using
> other functions to validate the address range.
> 
> Tested-by: Dave Anderson <anderson@redhat.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> I took your previous comments as a tested by, please let me know if that
> was wrong. This should probably just go through -mm. I don't think this
> is necessary for stable but I can request it later if necessary.

I'm surprised.  "overflows and crashes" sounds rather serious??
