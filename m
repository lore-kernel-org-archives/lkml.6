Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525281918; cv=none;
        d=google.com; s=arc-20160816;
        b=fIGB7YEwdEObjLguimU4u01KAFIYpBuHJjqssE1ullAvFDX9EAYqw1UbeavQAUdwNq
         /EMCQy7Xo7wpu71bCz5cPUsTtnv5ORj7jPsqsSSRx7qAvY0ADcF/YQxCpcIRYz7doWqb
         xMCzC4vS01XQYCmgfpn/MwTNUCms+TUFClbdhtXvYEjcKrfgk03LGM0HNObCfXLujmtB
         6o+yRGYWJAhNy8BmGCq/+l0ZmJL9qk4n8J23UfnJNJcR9H7fNirvMvfaeicMt9KufU88
         xglmSGKUT1sOErYV6lWyfEeS7OXAUtCLfZaj1XvUMhEI2QWFrSTEdJNzrzLmKtC77Uj2
         gMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=iy/QIicasq+EO8o2dAfPPMdQcTfRaxi+FJzYj6CZJfE=;
        b=O9YK+oC6QTZQjZ3YHhMOM7cdbBw+iTaaEE7DOeNWIb8ArwpdmVSpgzGMtci9hszO+C
         AmStKj/ihaCafBBtS6QAuGV0B1cCBOt6xMo2alzBJP/+efGTPG1G/fV1w23mMv1kkv+f
         D+oa5swcUGhpJF9+olqi7Q4kNs+g12c6I9jmbzrC926xe3cyZD+XscYcOfr64owzjo6w
         H2Jh09Qq4aYSdc4oT7J94o/G59SgckaDS8dGTRC+F/fupVja4t/PYqsG3Rl9KLmgzR5J
         dRBJTn05clYpWMZevuku07hsnp6fPjbheRRGS2sbVAK0EM3VA0p1mOT9BK0yjMlmVZKn
         HwyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vG26IieN;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vG26IieN;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZro+x4E6etcw1aZ5rFdnvE4dKyQmOHUddiV9UPnUQubVgGNeekDC28ddc2Wg5AkujCNYkO0sCo7f/+KWZpJ2M8=
MIME-Version: 1.0
In-Reply-To: <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
References: <cover.1524077494.git.andreyknvl@google.com> <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com> <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, 2 May 2018 19:25:17 +0200
Message-ID: <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
	James Morse <james.morse@arm.com>, Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Lee Smith <Lee.Smith@arm.com>,
	Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111199483906995?=
X-GMAIL-MSGID: =?utf-8?q?1599374013086776867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 5:36 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> On Wed, May 02, 2018 at 02:38:42PM +0000, Andrey Konovalov wrote:
>> > Does having a tagged address here makes any difference? I couldn't hit a
>> > failure with my simple tests (LD_PRELOAD a library that randomly adds
>> > tags to pointers returned by malloc).
>>
>> I think you're right, follow_page_mask is only called from
>> __get_user_pages, which already untagged the address. I'll remove
>> untagging here.
>
> It also called from follow_page(). Have you covered all its callers?

Oh, missed that, will take a look.

Thinking about that, would it make sense to add untagging to find_vma
(and others) instead of trying to cover all find_vma callers?
