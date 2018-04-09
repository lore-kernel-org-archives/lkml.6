Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AIpwx495UOUfFzcGPBJOjm9osvcaNiUk9fwZ0mob2bgn9Y7iUxpq/QRR/5YruwF++HNZ2oolzUfe
ARC-Seal: i=1; a=rsa-sha256; t=1523267742; cv=none;
        d=google.com; s=arc-20160816;
        b=l14u8yTVJUSurnH/G0uzkKcA4gHCjlDbcX0C/qj9UoIq9yg2CtwpBfNxYA8wI8qM6T
         2emUwch6dqUpP92nckcUR4U4diSnZpmrNbweB63nXotv54oH3hLfpr9DfI1uxe0QJGEh
         5LZdTMWTYPZ4B7QTiw8TXOgmsaMz2S8X9yJvEXMb1/ztAgEz67LCEy5g/7oH4zUB+RON
         UJiTThzTmDMxe0OM0gCc8B5DX2jGScCz+ZnN0O8zUqtJ155ZQl8QdUnwBjT6Z6A7RHCU
         WsIVx5Wh3iwR0hkuBHXAlbbqz3mo8FhssmwHZu9k0nRNjrXBEY1PBMe/d34wqGP4UnZE
         Rvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=BWGBlpmfPeAG0HRX1waXlMnBFV2dxlLh/NNW0vhjpmo=;
        b=p+k7+aDypWUzO0RSzSOydIXUrCPqxFjvfcnZBYb0nlXMzKdW/oHv1dk8bYg8Oxa0f4
         uOVduZ+m/gxOE2vu6ZWjPt7RpRdvkBiRKI/+GdUElOoqYL17eFlIGeMpGuxf0VKWVE/Z
         kWDqeXDxcA1ubUYzM4YKevxI6ZCWM888iyMGvRRNsEwCvIVM83bvj9JdYJpZ1c3m0VyL
         2MO8HXXfhFPuoW6kj8UASK2t9qEIsEOC5+LfBhPdkoxbEeYEu/sAQhVW/BbWGShBw1we
         1uKz9iKqPuGqAX0WYaxL8Q9kxZ/sXM4hKCA8J+h77KkX+yLs9vrCaNJYud/sT/SrV9H3
         5Qgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Mon, 9 Apr 2018 10:55:34 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: 20180408150840.GA16019@kroah.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	will.deacon@arm.com, dan.rue@linaro.org
Subject: Re: Linux 4.9.93
Message-ID: <20180409095534.z442itrto2qtc3yc@lakrids.cambridge.arm.com>
References: <20180409180534.1768583293d0abe207168c5a@essential.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409180534.1768583293d0abe207168c5a@essential.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597258846269332204?=
X-GMAIL-MSGID: =?utf-8?q?1597261997062423303?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 06:05:34PM +0900, Jean-Baptiste Theou wrote:
> Hi,

Hi,

> After this patchset, a kernel built with CFI fails. Disabling
> UNMAP_KERNEL_AT_EL0 fix the issue obviously.
> 
> Wondering if there is one of the test suite used on the review
> patchset that covers the CFI usecase.

IIUC, you're saying that after my v4.9.y meltdown backport, your own
backport of an out-of-tree patchset does not function.

There's no support for CFI in upsteam (at least as of v4.16), nor in
v4.9.93. I have no idea as to how KPTI interacts with an out-of-tree
patchset, so could you elaborate on the issue?

I've not seen any CFI patches on the linux-arm-kernel mailing list, so
it's not clear to me how this interacts with KPTI.

Which patches do you have applied that implement CFI? Which compiler are
you using?

[...]

> [    0.282196] kernel BUG at kernel/cfi.c:32!

This file doesn't exit in v4.9.93...

> [    0.282230] CPU: 2 PID: 25 Comm: migration/2 Not tainted 4.9.93-perf+ #39

... and here I see you have local changes applied.

It would be best if you tried to get CFI supported upstream before
trying to backport it. That would be best discussed on the
linux-arm-kernel mailing list.

Thanks,
Mark.
