Return-Path: <ying.huang@intel.com>
X-Google-Smtp-Source: AG47ELs+SZfzJPE2kbkneZAEIZs5rRiM1QhyuRV3p/+9TqJAD5JSMqbGPRMnAMPx6hZp04eqdMeW
ARC-Seal: i=1; a=rsa-sha256; t=1521427022; cv=none;
        d=google.com; s=arc-20160816;
        b=S0T7U0INqGNQsPtQHl1hDn0a0/u9ihQg6Fq3/084KKmoe5X6CMquZJu/SiGGd2DR9G
         OLN5rjmayJMX1v8EfKx9ChxFteVC9/kmzFwlDp62JJR4Nt72W0On5rKjeDx9KK1Y8uJJ
         x34+IfjoU87On9Ko7s0qi/5RjOwMFO9xNuG1Ar1RmBxXqwE4Cdy5pJ0cCAquRsv28H5e
         bEKsIz7dYfXGYWhN3clUFtpFy4rI4WD5oPzsUMZLof0e+IHhI1c1boVp+Iodmljr56li
         zfRuHWTg1IgkQ+RZBTQwi1XncyO5EGWL6h8BfumLs8MhydCMwD3LMinWisH/+KNBmGkF
         WGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:arc-authentication-results;
        bh=/H2VpWrj4N/ZUcdTD/sgdTOnKRE75QWKHq4i1qsC3BE=;
        b=VOZOV5rTeIbhkWhzWcup+ENW29r0IbbfAZ1+QG72NQtLrnPvTDDvc5TYdk8edO63Rt
         e+tV4ePLKMA/dYRXNPtG2y5SaZD+iAlK1ytTNrHqbF1n30f5doRkLm0cm375IARxorqR
         NfB0k0e2y93Sgprrprk7QlBuaG2SrFtKNXJuNYv46fIe1QKz9iQKgWXWzx4qRboC8amf
         Dh3S14smDCP/hbrUs2rl1loF6xx6fHlp+1Ztin2BLpUGrTF62N47L+4FRR+r21Ufh62Y
         /WeLdZFtNgQib5zOE7FfTxAuZQ8a5b4yIZnJtV3TPrX+MUMm4fsRMCjDwyr55PzUp4rI
         ztJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ying.huang@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=ying.huang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ying.huang@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=ying.huang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,328,1517904000";
   d="scan'208";a="25596026"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Wei Wang <wvw@google.com>
Cc: <gregkh@linuxfoundation.org>,  Todd Poynor <toddpoynor@google.com>,
  "Wei Wang" <wei.vince.wang@gmail.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dan Williams <dan.j.williams@intel.com>,
  Michal Hocko <mhocko@suse.com>,  "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>,  Jan Kara <jack@suse.cz>,
  =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,  "Hugh Dickins"
 <hughd@google.com>,  Matthew Wilcox <willy@infradead.org>,  "Ingo Molnar"
 <mingo@kernel.org>,  Sherry Cheung <SCheung@nvidia.com>,  "Oliver
 O'Halloran" <oohall@gmail.com>,  Andrey Ryabinin
 <aryabinin@virtuozzo.com>,  Dennis Zhou <dennisz@fb.com>,  "Pavel
 Tatashin" <pasha.tatashin@oracle.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: add config for readahead window
References: <20180316182512.118361-1-wvw@google.com>
	<CAGXk5yoVMd9B=nvob7s=niCAQ9oHAX84eupF9Eet_dAk7WTStg@mail.gmail.com>
Date: Mon, 19 Mar 2018 10:36:58 +0800
In-Reply-To: <CAGXk5yoVMd9B=nvob7s=niCAQ9oHAX84eupF9Eet_dAk7WTStg@mail.gmail.com>
	(Wei Wang's message of "Fri, 16 Mar 2018 18:49:08 +0000")
Message-ID: <87zi34zt85.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595331862119084015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Wei Wang <wvw@google.com> writes:

> Android devices boot time benefits by bigger readahead window setting from
> init. This patch will make readahead window a config so early boot can
> benefit by it as well.

Can you change the source code of init to call ioctl(BLKRASET) early?

Best Regards,
Huang, Ying
