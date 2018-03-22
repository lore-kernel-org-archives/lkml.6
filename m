Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AG47ELv+IBaRGrKLZcBpIzBzcEQinNkJzzZyaqe6Ycxwpn61gfZykczBFu+q7c9l1nOJz0r/uEpB
ARC-Seal: i=1; a=rsa-sha256; t=1521752252; cv=none;
        d=google.com; s=arc-20160816;
        b=gxs7PP7A+Mz+jWsohfVTUAAKnNAsxmVyO2pBMh8Pj+yBndgyFYxMJGGncZ5RUVlovv
         KLi5lv+7h76XufSP4PMEJaxeJ2ZLr2wgXm4K4i8ZUYCaGC2Ym8wA4YfevRSp0aXgJLrN
         H+BfXvR9x8a4shNIMNvHdKCdFobCiiaKZY1rhbc3sLP/XvbrlDH+J0fZP0fz727AzIMv
         9o8RviC7TJyTxIyAnRGZ5SBrVNaZXQn8xPtQ9GoZzh5yb0KxPbtFWqrIALRrm+gOR3dl
         cqZdhDug6E+YOdnATwm0szI91r6twNqLillMbUkOkig8VMuVFsqihUbPy8qwwAUZncB3
         HcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+iTo3lV84MfrpWaxuEHr/Y7H4ZJpPvUGgSmUsb/Wr68=;
        b=vC7YtgBvulCd1UNSeLh7y2S9wpQDNoLLtSetZN+lp/bwSl8MLy+l7IV43TdtOKpwnk
         RJbDKRSYD7SjuGAiQiibuJMH6UkAy+BK1OmqTiGscv7BnOrkX9aPINhjnHjzL7ik7LTH
         mmyR03um1Do7pwwf3YY/i35V43cJI3zMYkd4TFoB1rd/NDWjTfR7koJxihicNYGaKjQQ
         PUB9EtFDqZXny3ib4LfmREKPbSeCG/vlSwo/FPeQA1x3Xwm5GHuI3X9/VWCps/UZHzK0
         EmO42IR2GVt117+ZPwoA4hLSYctibgZibebOB5Kv/NBJRUmhDlqMDZpuGTgyEDnID5XU
         sy+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Thu, 22 Mar 2018 13:57:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
 vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
 fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
 jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
 davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
 gregkh@linuxfoundation.org, deepa.kernel@gmail.com, mhocko@suse.com,
 hughd@google.com, kstewart@linuxfoundation.org, pombredanne@nexb.com,
 steve.capper@arm.com, punit.agrawal@arm.com, paul.burton@mips.com,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com, keescook@chromium.org,
 bhsharma@redhat.com, riel@redhat.com, nitin.m.gupta@oracle.com,
 kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, jack@suse.cz,
 ross.zwisler@linux.intel.com, jglisse@redhat.com, willy@infradead.org,
 aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-Id: <20180322135729.dbfd3575819c92c0f88c5c21@linux-foundation.org>
In-Reply-To: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1595672889943983906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Mar 2018 19:36:36 +0300 Ilya Smith <blackzert@gmail.com> wrote:

> Current implementation doesn't randomize address returned by mmap.
> All the entropy ends with choosing mmap_base_addr at the process
> creation. After that mmap build very predictable layout of address
> space. It allows to bypass ASLR in many cases.

Perhaps some more effort on the problem description would help.  *Are*
people predicting layouts at present?  What problems does this cause? 
How are they doing this and are there other approaches to solving the
problem?

Mainly: what value does this patchset have to our users?  This reader
is unable to determine that from the information which you have
provided.  Full details, please.
