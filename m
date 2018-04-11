Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx4/HW/anBaEDaJMHVxiWuWk0MXvOqWAuC6DR5NfWlvXnn15VpBIz8toIkqBx6ZxguXy3uyoJ
ARC-Seal: i=1; a=rsa-sha256; t=1523458415; cv=none;
        d=google.com; s=arc-20160816;
        b=Ww6XOFLRThnNa7nlEll1nechXQR/MprtZcVV1qMwKL0mMP0BWSo7aXzBeIZuSGxKgP
         Fmv1cV9o/L++Y/Dh1zvli/TLdVUo6RNGdCpBvWq7GsU7EmM5/FdruA8p+ehmGY7MOUrt
         pzk9cpTMbAm5Ivu8WzXW1qUtfOiMuI14MCzmQKeq51I9t1ZCHY65bxcm/dKgjhJqlinW
         t9XeYkZVuvmfQoS+/xA/MHb8JR4WKMY2D6pr4z/4CBvxcJZPq1OH5ML+cFvamL/+gigY
         aUw50UysiRE4vSLQdTxnuN02EXy/wsBxJ5/QTZnvryszBjfaKmHrQCguQPBGLDIaWFY2
         hYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=o4P7epCiuVfM2pYzhpT1yUg6N7GGdsoyf4DxMHxPPIQ=;
        b=TWg60l6lQAVmcIGx/EX2BkpK7ozfw1NSPoAe1pDcazOahyGDqbfufODIFtrwh4T18G
         ro7i5GnUdSVDV0XTcj/WXcSw54gqMIkZEpRaN7+LBP2FdDZ+/HVOytcFf8MHUd8z9Yjf
         5yKrEZH2IZJQXzy1i6k2kYuS/Ac1DPbg55SeTuddKFV4Txgw+GyGj4cWHAepqMM7Rt24
         aguvuBaGeLxqbYZt9FtlmlY3vk3xOigiyt1BVaJt4kVIb7MrS8/kX13ydX1/F0UxaHgh
         FbdTerYxuor+eZ45kW6nYQrIvTO5edtx7vlk9qiPO7QYCkLQFtdcksjDX0qXJN22qWN2
         sDIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.164 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.164 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3309:3622:3867:3874:4321:5007:7875:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: fall98_3c2c2b2b03e56
X-Filterd-Recvd-Size: 1421
Message-ID: <1f68b6810e9129e3d88127ab999cbc826293cda4.camel@perches.com>
Subject: Re: [PATCH v3] isofs compress: Remove VLA usage
From: Joe Perches <joe@perches.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>, Kyle Spiers <ksspiers@google.com>,
 Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, David Howells
 <dhowells@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Wed, 11 Apr 2018 07:53:32 -0700
In-Reply-To: <20180411063946.GP30522@ZenIV.linux.org.uk>
References: <20180410234532.185426-1-ksspiers@google.com>
	 <20180411003331.GM30522@ZenIV.linux.org.uk>
	 <CAGXu5jJBqiXZzvRaoXRVuxFckaFJq+LfM227t2uXF3vhwE7WPg@mail.gmail.com>
	 <15d2961566261c1b9428402930fd3f994c7f472d.camel@perches.com>
	 <20180411063946.GP30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597404821961766971?=
X-GMAIL-MSGID: =?utf-8?q?1597461931703722629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-11 at 07:39 +0100, Al Viro wrote:
> Shit happens...
> 
> Al, fully expecting to discover having made something spectacularly bonehead
> 2 minutes after sending a patch out - happens often enough.

I've done that.  Again, no worries.
