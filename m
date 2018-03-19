Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521429323; cv=none;
        d=google.com; s=arc-20160816;
        b=QW4k43ocGO0nUzTtNNP9YZOtTOpiIi1hdi2Ndf9IR1RirL4X8lqH2e+7xzYNtZ4cIE
         fh9PjZGJ4fuZuZ5I1yLI+zUhJB+aG6RrBGoZLH07kdGHUB5DgVVum+RZyJLWmMgx0lTk
         EZbk2ouCBr6ctnTzg+iJurVdo03mS9jRRO1L5rGqETGqrz4jFJs0p20+H6GWuIYOtw02
         9OCNKGb52twjy4BlppF1wlN5a4OISglRieTTCROgZoi5Q52hYcDxZr/KsB9eZPjCi3E0
         6OO/4YMfMfitx6UX8CJVRk8stJ91TvXan5hKbkiHNaZYfPqrHmW7TvNqf6LGWCIRE7dG
         c1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=v+zz8PAA0c2fKFWLuYEovUuimPmMTFo8lCHpgREKZ3o=;
        b=s64Aim6DZHFgBTBU3HRl3svS/rkTZ+0bDhCp7gfIIw2eIH8MVKC0ecRrjxID2eBQde
         LeQpnslvR9WntDFMssqPl3vfo7Xzfgs8csd9BX+Vvu8EBBAYCExEJ42EFiaw7m+BalvR
         3p0v9S3GtcK2zHUdEqqobxIpnY//VF3lFILn7KGEn+1gV2yTtdgpbXD5o556PaxhFJGP
         uz1pE5BvGIFjMYb8BAavB/7a5Zpbsk6keA2nviJsa7baUALIiBZvRsAI3nhZHvyoIoTu
         OaQGbEiDMbMse2PiGql+ggGA+gHMFEuxL+rv/M5eDmnUjijI2vRYQ4AjdsQn1yEsuTlf
         PLvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=pJSKOoyo;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=pJSKOoyo;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELvayhA+xiph4ST279zd/Z5CtzIYcrZmKhS/cT+u2c9XzILhfydAJtuXsPLtHMvz8EAIgQTEJ7MfKg9nOH9YYB8=
MIME-Version: 1.0
References: <20180316182512.118361-1-wvw@google.com> <CAGXk5yoVMd9B=nvob7s=niCAQ9oHAX84eupF9Eet_dAk7WTStg@mail.gmail.com>
 <87zi34zt85.fsf@yhuang-dev.intel.com>
In-Reply-To: <87zi34zt85.fsf@yhuang-dev.intel.com>
From: Wei Wang <wvw@google.com>
Date: Mon, 19 Mar 2018 03:15:11 +0000
Message-ID: <CAGXk5yrKw4edZs1pvrL5t67C1YASiOcZPsF3VDHmJ+nNQBVSqw@mail.gmail.com>
Subject: Re: [PATCH] mm: add config for readahead window
To: Huang Ying <ying.huang@intel.com>
Cc: gregkh@linuxfoundation.org, Todd Poynor <toddpoynor@google.com>,
	Wei Wang <wei.vince.wang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jan Kara <jack@suse.cz>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Sherry Cheung <SCheung@nvidia.com>, "Oliver O'Halloran" <oohall@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>, Dennis Zhou <dennisz@fb.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595334273575877888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 7:37 PM Huang, Ying <ying.huang@intel.com> wrote:

> Wei Wang <wvw@google.com> writes:

> > Android devices boot time benefits by bigger readahead window setting
from
> > init. This patch will make readahead window a config so early boot can
> > benefit by it as well.

> Can you change the source code of init to call ioctl(BLKRASET) early?

> Best Regards,
> Huang, Ying

Yes, I am sure we can work this out by not touching it in mainline kernel.
One reason to bring it up again is that we found some SoC vendor has always
set a different value than default (128) in their kernel tree.

Thanks,
Wei Wang
