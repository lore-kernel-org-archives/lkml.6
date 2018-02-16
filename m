Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033827AbeBPOLW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:11:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033729AbeBPOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:11:20 -0500
Date: Fri, 16 Feb 2018 06:11:10 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/xen: Allow XEN_PV and XEN_PVH to be enabled with
 X86_5LEVEL
Message-ID: <20180216141110.GA10501@bombadil.infradead.org>
References: <20180216114948.68868-1-kirill.shutemov@linux.intel.com>
 <20180216114948.68868-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216114948.68868-2-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 02:49:46PM +0300, Kirill A. Shutemov wrote:
> @@ -38,12 +38,12 @@
>   *
>   */
>  
> +#define l4_index(x)	(((x) >> 39) & 511)
>  #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))

Shouldn't that be
+#define p4d_index(x)	(((x) >> P4D_SHIFT) & (PTRS_PER_P4D-1))
