Return-Path: <v.narang@samsung.com>
X-Google-Smtp-Source: AIpwx48IAx2kklPj/sIwxgArKtCBFmUFYz/bx3L63kMWarqNFm7bHJzIQQ0xS661nEZeRNnlKnyz
ARC-Seal: i=1; a=rsa-sha256; t=1522077676; cv=none;
        d=google.com; s=arc-20160816;
        b=tbme4TtEFkOmhxunn5ciEGusCRPBVszv2BohEWkbAaQQRj2qqi6LI8FsGf2f5WS6k6
         5mEL0XtPKevH/8eVSMS667lpPk+wXuVu7Jv5vUzhDDgxTX+26Ngc5Crjz5qTmXXLublp
         jiPloUJvcCPSAE/tKUS2b4wnhrGdz9XfGwSr89KVGqUJ+beKwI5/ZhPQ1Q9ttyLyq+1d
         VvdV+j3eg4Rs0gXreaQSF/llwLT/dZKSX+APczNGlGXr3Qc1qsp22ROB2y5J/8pYK5U7
         sKSL7WpmyRKUO/Zr9RQ/TL2mCqwHvpSksaa/KMDdIMxARBq7FlQ1MtivJT7J63LGYW5y
         dk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:content-transfer-encoding:date
         :message-id:in-reply-to:cc:to:from:sender:reply-to:subject
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=AJRZ9eST6gSttUUZVcVcIwR37oZaFYvVQlFIdQOEmt0=;
        b=DKwyPXvBoz5bQMx6of6L8kfMgMc7xIiu1TZ/BhmHEMBK4wtlgxSb9uU1IzF6ybquwP
         MDJuirICMiy0QgLNXzebjLkruVzP3Gyt05hUiAHwipPatB5+IBcv2S/GLZPGUIgCX8T1
         eSxpj7pNvDog6o56WlxZKH1LdfIthqkIFWk2PBc63fWt+OTyeEHes08r/5lHZz5/Uw01
         hSoei+SvlQrofqe5QAZul68ZeNjAzf2paXjRGap1DQc+g4R6Bnq5i3F41HeSQQqcjNBf
         ZiLpnt0DwUZrQ9+o7+JMYcGZLDvVGfwBJT845aeaZ0jlRdiItZYYhGp9eD/w9qFKzPgQ
         xLUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=K44aQi6J;
       spf=pass (google.com: domain of v.narang@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=v.narang@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=K44aQi6J;
       spf=pass (google.com: domain of v.narang@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=v.narang@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180326152114epoutp02147adee49e175730f9c0cbe2a4a94884~fgZSo-p3P3273332733epoutp02_
X-AuditID: b6c32a49-71dff70000000fee-d2-5ab90fe9fb9f
Mime-Version: 1.0
Subject: RE: Re: [PATCH v2] mm/page_owner: ignore everything below the IRQ
 entry point
Reply-To: v.narang@samsung.com
Sender: Vaneet Narang <v.narang@samsung.com>
From: Vaneet Narang <v.narang@samsung.com>
To: Dmitry Vyukov <dvyukov@google.com>, Maninder Singh
	<maninder1.s@samsung.com>
CC: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko
	<glider@google.com>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas
	Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton
	<akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Stephen
	Rothwell <sfr@canb.auug.org.au>, Michal Hocko <mhocko@suse.com>,
	"vinmenon@codeaurora.org" <vinmenon@codeaurora.org>, "gomonovych@gmail.com"
	<gomonovych@gmail.com>, Ayush Mittal <ayush.m@samsung.com>, LKML
	<linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
	Linux-MM <linux-mm@kvack.org>, AMIT SAHRAWAT <a.sahrawat@samsung.com>,
	PANKAJ MISHRA <pankaj.m@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CACT4Y+Yfx+fTHyQ=d3T68bwfgQQsmqd+e72V67kaAHajo536JA@mail.gmail.com>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180326141717epcms5p4064a0fd4f594b2ff434f9b05cd1ea5ad@epcms5p4>
Date: Mon, 26 Mar 2018 19:47:17 +0530
X-CMS-MailID: 20180326141717epcms5p4064a0fd4f594b2ff434f9b05cd1ea5ad
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180326141717epcms5p4064a0fd4f594b2ff434f9b05cd1ea5ad
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkl+LIzCtJLcpLzFFi42LZdlhTXfcl/84og/NL2Cwu7k61mLN+DZvF
	l0nv2C2u/N7PbjHhYRu7RfvHvcwWhx++ZbVoXryezWLFs/tMFj1zmhgtLu+aw2Zxb81/VovD
	89tYLO73OVjce7OVyeL/73OsFlv3XmW32LxpKrPF7MY+Rov1Ww+wO4h4NN64weZxua+XyWPn
	rLvsHgs2lXrsmXiSzWPTp0nsHu/OnWP3ODHjN4vH/rlr2D2W7zTx6NuyitFj/ZarLB5nFhxh
	9/i8Sc7j9f5DjAH8Uak2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZK
	Lj4Bum6ZOUBfKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslaINDY30DA3M9YyMjPRMTGOt
	jEyBShJSM3a+usBYcIS1YtrrXcwNjDtZuhg5OSQETCT+fD3C1sXIxSEksJtR4vSsT+xdjBwc
	vAKCEn93CIPUCAtESNz5NYsZxBYSkJM4fmM3I0RcR+LEvDWMIOVsAloSH1vCQcIiAkESG3b/
	YwEZySzwiVXi0sYzjBC7eCVmtD+F2istsX35VrA4p0CgxOTjE6FqRCX+NMDUiEq8PzYfKi4i
	0XrvLDOELSjx4OduqLiMxPev/awgyyQEuhkl3k3ezQLhTGGUaHgD020ucf7kfLBuXgFfiU1g
	HZwcLAKqErP3fYea6iLRfPAFmM0sIC+x/e0cZpDPmAU0Jdbv0ocokZWYemodE4RtK3Fq+RI2
	iHI+id7fT5hgntwxD8ZWkjh3cCcbhC0h8aRzJtQqD4m3jzcxTWBUmoUI6llIFs9CWLyAkXkV
	o2RqQXFuemqxaYFhXmq5XnFibnFpXrpecn7uJkZw8tfy3ME465zPIUYBDkYlHt4ZHDujhFgT
	y4orcw8xSnAwK4nw8s3fESXEm5JYWZValB9fVJqTWnyI0RQYBBOZpUST84GZKa8k3tDE0sDE
	zMzc0MDA0kRJnNcx0CVKSCA9sSQ1OzW1ILUIpo+Jg1OqgbH422JH1ejZn7o+XA0vcrtnlnKv
	L63u9anEfqbVv+MlN5mw2S1/kvL78otfutOL5n+apBFZWdz+SkxD6rZtTPHbyQeCF4XIBavy
	BD/RnNeY3BDywtNzv1nelgC+H8JJX53k5UuuB6hUyQdv2LRFhqHj77enc24srblWZM2z4pFz
	ULng2ZN5wUosxRmJhlrMRcWJABz3lagUBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41
X-RootMTR: 20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41
References: <CACT4Y+Yfx+fTHyQ=d3T68bwfgQQsmqd+e72V67kaAHajo536JA@mail.gmail.com>
	<1522058304-35934-1-git-send-email-maninder1.s@samsung.com>
	<CGME20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41@epcms5p4>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595993933133123096?=
X-GMAIL-MSGID: =?utf-8?q?1596014121223200331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dmitry,

>Every user of stack_depot should filter out irq frames, without that
>stack_depot will run out of memory sooner or later. so this is a
>change in the right direction.
> 
>Do we need to define empty version of in_irqentry_text? Shouldn't only
>filter_irq_stacks be used by kernel code?

We thought about this but since we were adding both the APIs filter_irq_stacks & in_irqentry_text 
in header file so we thought of defining empty definition for both as both the APIs are accessible
to the module who is going to include header file.

If you think empty definition of in_irqentry_text() is not requited then we will modify & resend the
patch.

Thanks & Regards,
Vaneet Narang
