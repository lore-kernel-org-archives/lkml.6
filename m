Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx4/3sSvZLfGSQHqJ9/Onbqj4Nq41Bce4oBJHzHn/eTn5uOkaE82P4zLg8uqIo0i6pg6+dn9S
ARC-Seal: i=1; a=rsa-sha256; t=1523048665; cv=none;
        d=google.com; s=arc-20160816;
        b=nOagJV//XEsQaYmyLXW0fiaAsFylAG1zLLp1MOHwprwmIEctok3j0bPdbANK0Mvund
         FnRf8v0DQfrIwlUZH+a3AXMoEqo5Fy7k9zHn036FWLC0QG6r38ERDHm664LdAMGoOJly
         vmBIeDHp3WeByLqSuH1QgIJ9Vn+E2dwMhBKqKwCs5LFvsVcfyyMq+tOCjj7QBOvS2VDW
         yOYW7mV1Laq/ys+OaQDJf/XKBCu6hFc2itfWxKrYCBho7uu14w/zrPr6StGrti5QfuFw
         yJLuXtrpSlVEqWVOvsY/pVGkQxR3lksZhrX7DWyg7ALJ3/3S3XJKCMRPRzQzdtdaoxuZ
         do+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=IgkqNerrJmbgc2HnJw++UZUbGX6HHOpqm3XvuIHewrA=;
        b=BEa4pmSmLqJid0+g32AQ6/Mvaa7YY2EmL+NX4Tr8kOSAn+0xOLwCoDNSxZKKefltz7
         vlWuNq/5Qr3jjVTJn/BQJbJqVpXrC9lzY8A4Ls8K8AqD1MANbxnnqf4Dwd1bM6MruRfV
         feGdwHmb+EMrzanaAWQ7P9whYHYdb0amrauhiQuiWpRG63FirxYOHCvn64MbfkoaVV4F
         WnznWmOk2bqckW5IKCTVH9boWDL8bPMM7SDsBROzqWxvZAGiwQhY8hdeth9EzxbW2L96
         deBPaT0wgzHS9bbgTjDA7dGuyQCJqqP2clDQlBvZPjBmbZiUg5asna8LE0vh2gqI1Hn3
         5wzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.93 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.93 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:9025:9389:10004:10400:10848:11026:11232:11658:11914:12043:12296:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21063:21080:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: walk10_607cc9f798206
X-Filterd-Recvd-Size: 2498
Message-ID: <1523048661.6127.38.camel@perches.com>
Subject: Re: [PATCH v2] isofs compress: Remove VLA usage
From: Joe Perches <joe@perches.com>
To: Kyle Spiers <ksspiers@google.com>, jack@suse.cz
Cc: arnd@arndb.de, dhowells@redhat.com, viro@zeniv.linux.org.uk,
 gregkh@linuxfoundation.org, keescook@chromium.org,
 linux-kernel@vger.kernel.org
Date: Fri, 06 Apr 2018 14:04:21 -0700
In-Reply-To: <20180405181720.9659-1-ksspiers@google.com>
References: <20180405181720.9659-1-ksspiers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596931173009580849?=
X-GMAIL-MSGID: =?utf-8?q?1597032277224572907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-04-05 at 11:17 -0700, Kyle Spiers wrote:
> As part of the effort to remove VLAs from the kernel[1], this changes
> the allocation of the bhs and pages arrays from being on the stack to being
> kcalloc()ed. This also allows for the removal of the explicit zeroing
> of bhs.
> 
> https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kyle Spiers <ksspiers@google.com>
> ---
>  fs/isofs/compress.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 9bb2fe35799d..4eba16bf173c 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -20,6 +20,7 @@
>  #include <linux/init.h>
>  #include <linux/bio.h>
>  
> +#include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/zlib.h>
>  
> @@ -59,7 +60,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  				>> bufshift;
>  	int haveblocks;
>  	blkcnt_t blocknum;
> -	struct buffer_head *bhs[needblocks + 1];
> +	struct buffer_head **bhs;
>  	int curbh, curpage;
>  
>  	if (block_size > deflateBound(1UL << zisofs_block_shift)) {
> @@ -80,7 +81,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  
>  	/* Because zlib is not thread-safe, do all the I/O at the top. */
>  	blocknum = block_start >> bufshift;
> -	memset(bhs, 0, (needblocks + 1) * sizeof(struct buffer_head *));
> +	bhs = kcalloc(needblocks + 1, sizeof(*bhs), GFP_KERNEL);
> +	if (!bhs)
> +		return -ENOMEM;

This direct return appears incorrect.

It seems it should be:

	if (!bhs) {
		*errp = -ENOMEM;
		return 0;
	}
