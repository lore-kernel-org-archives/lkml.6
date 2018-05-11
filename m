Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeEOUPt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:15:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44536 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeEOUPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:15:47 -0400
X-Google-Smtp-Source: AB8JxZoQZ06J+fcWIy+8nCFwtKgGufOhjJL35ZIGmQtRJO8fnndLoL9iycca2JX1Eb0Zyrkt9E+pKQ==
Date: Fri, 11 May 2018 10:43:37 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Alexander Potapenko <glider@google.com>
Cc: dave.hansen@linux.intel.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mka@chromium.org, dvyukov@google.com,
        md@google.com
Subject: Re: [PATCH v3] x86/boot/64/clang: Use fixup_pointer() to access
 '__supported_pte_mask'
Message-ID: <20180511074337.3fa5htarfcsbeeqy@kshutemo-mobl1>
References: <20180509091822.191810-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509091822.191810-1-glider@google.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 11:18:22AM +0200, Alexander Potapenko wrote:
> Clang builds with defconfig started crashing after commit fb43d6cb91ef
> ("x86/mm: Do not auto-massage page protections")
> This was caused by introducing a new global access in __startup_64().
> 
> Code in __startup_64() can be relocated during execution, but the compiler
> doesn't have to generate PC-relative relocations when accessing globals
> from that function. Clang actually does not generate them, which leads
> to boot-time crashes. To work around this problem, every global pointer
> must be adjusted using fixup_pointer().
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Fixes: fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
