Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523915293; cv=none;
        d=google.com; s=arc-20160816;
        b=M3qBHWs3gkR1i/ptZr0AoA7K+m7cSzgnfMoNYSLDzCoXBLZp07baNZl8qphrKir0nI
         6yCU3IGLN8jHpRA4GSzjoZdUfKIorU8XRVN7e8vgh36uZkfgy1W/5baFQVrhYMU0GR69
         SqpbUyYw/oJFJ3hRkT6LTaVECROr57o4Rw2DCD1PknELKNXJO7G4nD+6tobfgj70Up/r
         A/Dw++CfRTbVHy+7OeH5CJWDuRcuYKUAc4Dn6LXmXbJXjV6WPPP2NedMPrbwQUxjWgPZ
         7F7Gz2uDIUeURyyw46yiDaTRYhUS9fee7JXm4Cl7zgMNsUnHF11+2gNEdEN9UjUbHSFr
         fq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=5F5KExpWO7nKZF1iHi8+j3VkysEEKaeWGvkZ2bqZ1Ko=;
        b=SnWkfwigaIt7fiZtADzwSPU3eO/94gwLGBsYVc6zyBqw+6AMteLa3Z86+P8sCVSfY5
         f7wntR+3GkYbpbADqz0xpzSn8kBmY+yLBJxV7H/Oc5AwYK4U3988rgcLyKm9FZudigme
         h/iX1jzSFHE7gwDH9aN3FLnEAHmYpKV/YgIw9Z17ty6+7BG5uuzAl5id8ZH+hWOi5o3O
         H+Syg45zY2ByT5kobfIKxlF3TW+yg6nuPMcmYv608nmI4j7iTETRZWS+YHfMiEBem9oe
         Lehr9IPYoEOcST0SXHxJPIfKRgkGWLjNceX4q/1BHgqxQqXNh2Tcoo/DejOWN8tPQmYj
         M9JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LvKyRchE;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LvKyRchE;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx48COioAFbmtii4zykw8NHq6CweFFZ7NzeGR9JwN61Gprplaxe5Z9irX8ZShTd6i8xyAZC8FVw==
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 16 Apr 2018 14:48:10 -0700
From: Tejun Heo <tj@kernel.org>
To: Gaurav Kohli <gkohli@codeaurora.org>
Cc: gregkh@linuxfoundation.org, nborisov@suse.com,
	akpm@linux-foundation.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu_counter: Remove debug_object_free call twice
Message-ID: <20180416214810.GF1911913@devbig577.frc2.facebook.com>
References: <1523612103-15071-1-git-send-email-gkohli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523612103-15071-1-git-send-email-gkohli@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597623102391720322?=
X-GMAIL-MSGID: =?utf-8?q?1597941002489313593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 03:05:03PM +0530, Gaurav Kohli wrote:
> During percpu_counter destroy, debug_object_free is calling
> twice which may create race. So removing once instance of call
> from debug_percpu_counter_deactivate.

I don't quite follow.  Can you please elaborate how it can be called
twice?

Thanks.

-- 
tejun
