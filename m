Return-Path: <kernel-hardening-return-11735-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226OPfjN1twUzb73aYYqeouGE/Mf/dWioG+zaBgyNshmTFY2M9qLF3mUDudDq8WnT6eO/Ny5
ARC-Seal: i=1; a=rsa-sha256; t=1518478375; cv=none;
        d=google.com; s=arc-20160816;
        b=VuTqctw3WfFtxYGAHZNi7LQmiBucG6MPQxyobM2HZPyOGGi0+xi2u8Gv98aT4peyVA
         tU3SE2R+UMrGKVrb0SlSmxNFKN4Dt7OoKwZ3CE1XGcUgnnbj2XGxRMq9zSk2q7x4Id/7
         RpJSEvdRQKzQc4FzSO6hTguiycly5+8sdSd6Zg0stjy1bJuGDktAu6i6k/WGsq9a4SVM
         kVDQQbylnwuTk6f5aeAYvGQyEnvSizkd+K4lgSDPlOH2FfOWsD4NjfbTe+wuZTqDq/+m
         yOWIIb6RodhxkXKq9orhlHsvlMl7ElIQv68b0Cf/Qc1Xb241m3MMs35UXbJ4W6bwIV1U
         ZOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=8OnABoiHv6LiXvb+w/3Pbpd0iJKYnMts/QISXjIeZao=;
        b=eBMO5S+aVgM6tyIRvHVqIZhamyb8RHXmrFqoUw9H8+rX0IcQgXgaHWKNujUYvkMLQf
         0xvCjW100BBd0JPJiNfCT7ga0F6Lp5ldRjas/XvlDLqaN4QmdrZrBAbUYcunXVakeK9I
         K9MIQWuhQc67Cngmmau0aFAbjwU7eZFnXQOQQYD6Fe67xjDuCAfS4Mnr8TvY+NlCULP7
         KQp5xh1SxHvPsF337AiRlrZiz6RGPKAM1RQfWvpthdH9Ay6SwlefeT4Q3vOj7ohAj6pW
         KRjoSsOtO9F6TJN9eq/foPA/CEdidbYn/0nS24vRvC+GaGwX/B1aHTb5CI1mZFCKaiGr
         om2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=h3FVF6iN;
       dkim=pass header.i=@chromium.org header.s=google header.b=OWjhRV/p;
       spf=pass (google.com: domain of kernel-hardening-return-11735-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11735-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=h3FVF6iN;
       dkim=pass header.i=@chromium.org header.s=google header.b=OWjhRV/p;
       spf=pass (google.com: domain of kernel-hardening-return-11735-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11735-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180212165301.17933-1-igor.stoppa@huawei.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 15:32:36 -0800
X-Google-Sender-Auth: 4-p1cmLItotEnJMYqaA5QHeMMGg
Message-ID: <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
To: Igor Stoppa <igor.stoppa@huawei.com>, Dave Chinner <dchinner@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1592239980738880264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> This patch-set introduces the possibility of protecting memory that has
> been allocated dynamically.
>
> The memory is managed in pools: when a memory pool is turned into R/O,
> all the memory that is part of it, will become R/O.
>
> A R/O pool can be destroyed, to recover its memory, but it cannot be
> turned back into R/W mode.
>
> This is intentional. This feature is meant for data that doesn't need
> further modifications after initialization.

This series came up in discussions with Dave Chinner (and Matthew
Wilcox, already part of the discussion, and others) at LCA. I wonder
if XFS would make a good initial user of this, as it could allocate
all the function pointers and other const information about a
superblock in pmalloc(), keeping it separate from the R/W portions?
Could other filesystems do similar things?

Do you have other immediate users in mind for pmalloc? Adding those to
the series could really help both define the API and clarify the
usage.

-Kees

>
> However the data might need to be released, for example as part of module
> unloading.
> To do this, the memory must first be freed, then the pool can be destroyed.
>
> An example is provided, in the form of self-testing.
>
> Changes since v15:
> [http://www.openwall.com/lists/kernel-hardening/2018/02/11/4]
>
> - Fixed remaining broken comments
> - Fixed remaining broken "Returns" instead of "Return:" in kernel-doc
> - Converted "Return:" values to lists
> - Fixed SPDX license statements
>
> Igor Stoppa (6):
>   genalloc: track beginning of allocations
>   genalloc: selftest
>   struct page: add field for vm_struct
>   Protectable Memory
>   Pmalloc: self-test
>   Documentation for Pmalloc
>
>  Documentation/core-api/index.rst   |   1 +
>  Documentation/core-api/pmalloc.rst | 114 +++++++
>  include/linux/genalloc-selftest.h  |  26 ++
>  include/linux/genalloc.h           |   7 +-
>  include/linux/mm_types.h           |   1 +
>  include/linux/pmalloc.h            | 242 ++++++++++++++
>  include/linux/vmalloc.h            |   1 +
>  init/main.c                        |   2 +
>  lib/Kconfig                        |  15 +
>  lib/Makefile                       |   1 +
>  lib/genalloc-selftest.c            | 400 ++++++++++++++++++++++
>  lib/genalloc.c                     | 658 +++++++++++++++++++++++++++----------
>  mm/Kconfig                         |  15 +
>  mm/Makefile                        |   2 +
>  mm/pmalloc-selftest.c              |  64 ++++
>  mm/pmalloc-selftest.h              |  24 ++
>  mm/pmalloc.c                       | 501 ++++++++++++++++++++++++++++
>  mm/usercopy.c                      |  33 ++
>  mm/vmalloc.c                       |  18 +-
>  19 files changed, 1950 insertions(+), 175 deletions(-)
>  create mode 100644 Documentation/core-api/pmalloc.rst
>  create mode 100644 include/linux/genalloc-selftest.h
>  create mode 100644 include/linux/pmalloc.h
>  create mode 100644 lib/genalloc-selftest.c
>  create mode 100644 mm/pmalloc-selftest.c
>  create mode 100644 mm/pmalloc-selftest.h
>  create mode 100644 mm/pmalloc.c
>
> --
> 2.14.1
>



-- 
Kees Cook
Pixel Security
