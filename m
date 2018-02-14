Return-Path: <kernel-hardening-return-11790-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226WngPaA4uTpLFBRWRhfmBPB5k2Mcya/sUfg0TtM1z5rzimQPpRfFlZhKWrhtHaVm9WHkCr
ARC-Seal: i=1; a=rsa-sha256; t=1518641173; cv=none;
        d=google.com; s=arc-20160816;
        b=L03lpG35ottUtZ/wvkCkBpX5+5ZeT32qYIlv+UvjTSOaXzqPy0XCBGuWV0lAoQGGeE
         mvrPftR/cSvjookzK49Ov1EdPSnkc9TQxv//NYEACWTHanMlI+O3kAuyIHiulwqzpB9A
         0u8lSQKkiL9RMundDz20gOQYrf+kUA9PR1guKUJmNPMPu5IwD/+BpB9m77uLDCxyeRnA
         wh5p/5VwFZePDX4CE5ZIR+AMwvH17+FqLfS9vIOOVCCtt51bIY+U7C2mrPGMsBBKEInM
         OnJVDxpE/zBhfYB8/w1BPyQa/7qGq/PTQ44N3PeYpsi27R/E76kgsSugjrA8EgziEIvi
         i6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=XNtrlc1i3d68ojKtNk1PurmxmAfBLbDLawM1Bo1pus4=;
        b=Ly79hKSDkGXLJSbAvyhSG4E7XYZoGWCRI8Dq+FHHjKo3Ozvxwv9VXd8dPLp/E2pUzd
         wrjEzeX0gxyMyTDqXWBKY91/0AE45B2gpzzgwVl5GinumsykAYDkNggGsij489DkFexq
         WFcnpPVJkqGH6Xkj1HVWe8Vn4YgCBoXsu1VCpHwoPfjksclaZl3nOVVqj9QaNif0JZuD
         ViRL7kGWIB/7gNNLx3VLctInQWci2jbROWz9zQNUPue05mkwEYfUsriwrs3c706GKX1w
         0BINrDU6dDCcrfxhhZUEeEoVtDS3E92ZwrtoyDXg1bN3V8iVlQozhbst2UxXkpv9Owln
         W01g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11790-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11790-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11790-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11790-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7576:7688:7808:7903:9108:10004:10400:10848:11026:11232:11658:11914:12296:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21611:21627:21740:30029:30034:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: dolls32_16557fd6d3500
X-Filterd-Recvd-Size: 2158
Message-ID: <1518641152.3678.28.camel@perches.com>
Subject: Re: [PATCH v2 2/8] mm: Add kvmalloc_ab_c and kvzalloc_struct
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org, Kees Cook
	 <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Date: Wed, 14 Feb 2018 12:45:52 -0800
In-Reply-To: <20180214201154.10186-3-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
	 <20180214201154.10186-3-willy@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408583578566616?=
X-GMAIL-MSGID: =?utf-8?q?1592410687104833632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 12:11 -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> We have kvmalloc_array in order to safely allocate an array with a
> number of elements specified by userspace (avoiding arithmetic overflow
> leading to a buffer overrun).  But it's fairly common to have a header
> in front of that array (eg specifying the length of the array), so we
> need a helper function for that situation.
> 
> kvmalloc_ab_c() is the workhorse that does the calculation, but in spite
> of our best efforts to name the arguments, it's really hard to remember
> which order to put the arguments in.  kvzalloc_struct() eliminates that
> effort; you tell it about the struct you're allocating, and it puts the
> arguments in the right order for you (and checks that the arguments
> you've given are at least plausible).
> 
> For comparison between the three schemes:
> 
> 	sev = kvzalloc(sizeof(*sev) + sizeof(struct v4l2_kevent) * elems,
> 			GFP_KERNEL);
> 	sev = kvzalloc_ab_c(elems, sizeof(struct v4l2_kevent), sizeof(*sev),
> 			GFP_KERNEL);
> 	sev = kvzalloc_struct(sev, events, elems, GFP_KERNEL);

Perhaps kv[zm]alloc_buf_and_array is better naming.
