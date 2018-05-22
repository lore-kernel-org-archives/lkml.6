Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeEVQqL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:46:11 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:46064 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751196AbeEVQqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:46:06 -0400
Date: Tue, 22 May 2018 16:46:05 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Dave Hansen <dave.hansen@linux.intel.com>
cc: Boaz Harrosh <boazh@netapp.com>, Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@redhat.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
In-Reply-To: <50cbc27f-0014-0185-048d-25640f744b5b@linux.intel.com>
Message-ID: <0100016388be5738-df8f9d12-7011-4e4e-ba5b-33973e5da794-000000@email.amazonses.com>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com> <20180514191551.GA27939@bombadil.infradead.org> <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com> <20180515004137.GA5168@bombadil.infradead.org> <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <010001637399f796-3ffe3ed2-2fb1-4d43-84f0-6a65b6320d66-000000@email.amazonses.com> <5aea6aa0-88cc-be7a-7012-7845499ced2c@netapp.com> <50cbc27f-0014-0185-048d-25640f744b5b@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.22-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018, Dave Hansen wrote:

> On 05/22/2018 09:05 AM, Boaz Harrosh wrote:
> > How can we implement "Private memory"?
>
> Per-cpu page tables would do it.

We already have that for percpu subsystem. See alloc_percpu()
