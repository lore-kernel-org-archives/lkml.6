Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeDKKUO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:20:14 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50520 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeDKKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:20:10 -0400
X-Google-Smtp-Source: AIpwx495/zkYWTc5z1KxVDT4TdSo6CPqh9ZSHN5adkIdiYwHZADV6j3X0um9TfI8LVO36HHlArsO5w==
Date: Wed, 11 Apr 2018 12:20:08 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-sparse@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] sparse: add -Wpointer-arith flag to toggle
 sizeof(void) warnings
Message-ID: <20180411102007.i6nkdh6pff5ycmu6@ltop.local>
References: <20180410224624.psyo7vsy4qjplh3j@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410224624.psyo7vsy4qjplh3j@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 12:46:24PM -1000, Joey Pabalinas wrote:
> Recent changes to the min()/max() macros in include/linux/kernel.h
> have added a lot of noise when compiling the kernel with Sparse checking
> enabled. This mostly is due to the *huge* increase in the number of
> sizeof(void) warnings, a larger number of which can safely be ignored.
> 
> Add the -Wpointer-arith flag to enable/disable these warnings (along
> with the warning when applying sizeof to function types as well as
> warning about pointer arithmetic on these types exactly like the
> GCC -Wpointer-arith flag) on demand; the warning itself has been disabled
> by default to reduce the large influx of noise which was inadvertently
> added by commit 3c8ba0d61d04ced9f8 (kernel.h: Retain constant expression
> output for max()/min()).
> 
> Update the manpage to document the new flag and add a validation case
> for sizeof(void).
> 
> CC: Kees Cook <keescook@chromium.org>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> CC: Al Viro <viro@ZenIV.linux.org.uk>
> CC: Christopher Li <sparse@chrisli.org>
> CC: Joey Pabalinas <joeypabalinas@gmail.com>
> CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks,
Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
