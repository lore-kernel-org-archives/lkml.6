Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525356597; cv=none;
        d=google.com; s=arc-20160816;
        b=W/Kq2q3l+1T5KLxWtOUTliBbGN0aWDu1CBnISpJVOzKhaJ+h72FSj/j6i60dryx11i
         ELxnJHfD9nYNXK15LVCaYeLy9miQfiO+TzalK5Ilzu54ipcZBKEuBWSNbCJxwih7DcKu
         XXIm2ssAAZtfk/Iv4N6VgYpmaOpYdSgIkAKX+0+B78QONFMlw9hPta1Vk5ZjW3VQ8EoT
         XwGN183wnvQ2RgmOX38s97Huxq2dgby0ffDJzBbAqfjkVk7w8Uj7Xpn+5dI2K8ZWe5AQ
         GruyH+/ncscsgPZhVsqy3DSqfy4wg3x0s2i4r2vsuaDtAfWU6QsnwtrpUPiys5XVz/0J
         BHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yqJ71wV2HjeeJu2Y3Q1e4lnjLxv8/IV3XsUOimBvs3I=;
        b=egUVYDtTPQF2Kcg21kJ76Us8xYSvmJ7uZv8cyofUzNDb+AZ4S8f6AGhnT3hBb/Xw/v
         14rOGt2bTBTIz7MGL1Hff31Gkirp+qY/CuHkzvRK5MM5LbXd1l2A8PMhV+Jjz/gP/sl0
         0JX0WuB62BanyWabJ8OyXWq1UWLHE3KWtI/j9VJ1AdNdapdEC6mDsXLrKl1UzMgxJN9/
         QNoc7k09ZbifUFozTvNhA3xM6DTFk+2PfKt72A+84mj2MFm4sfcyj+9UuC68RI60UODD
         S0kSazWNPYiJ1qSmikQZde1yxpeywho8XKCSXsJw4ug7e7jxGEl6UeYilCxGfC3Fq4aj
         gWQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aC48c8mj;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aC48c8mj;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZrpXFcmnDxs5FR8h9tg3MlqFgfh2qRVgql1o/VHeZh8BNhiPXnnp6J8IflQaBSMIlh3jjeIEtI7ICUR4PFjbTY=
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
References: <cover.1524077494.git.andreyknvl@google.com> <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
 <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com> <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 3 May 2018 16:09:56 +0200
Message-ID: <CAAeHK+zh0LSpq2VFJeHrV7AETnL1b9R+yex3iPMg5SetbEyxwg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1599452319675721732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 7:25 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Wed, May 2, 2018 at 5:36 PM, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
>> On Wed, May 02, 2018 at 02:38:42PM +0000, Andrey Konovalov wrote:
>>> > Does having a tagged address here makes any difference? I couldn't hit a
>>> > failure with my simple tests (LD_PRELOAD a library that randomly adds
>>> > tags to pointers returned by malloc).
>>>
>>> I think you're right, follow_page_mask is only called from
>>> __get_user_pages, which already untagged the address. I'll remove
>>> untagging here.
>>
>> It also called from follow_page(). Have you covered all its callers?
>
> Oh, missed that, will take a look.

I wasn't able to find anything that calls follow_page with pointers
passed from userspace except for the memory subsystem syscalls, and we
deliberately don't add untagging in those.
