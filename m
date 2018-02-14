Return-Path: <kernel-hardening-return-11787-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2254h6ThsrGHyA2OW/2JIAm31FJ7d4575ibDgxaL4EIZyRm7TG6gk7Xbu5zCHKw33JRoWfFd
ARC-Seal: i=1; a=rsa-sha256; t=1518639610; cv=none;
        d=google.com; s=arc-20160816;
        b=z1WMRQvR4wAaiFCJZ4HzPKL7Q/UozKlrJpN3EZeNsj6FP2ktALxuRd2hDBMfEr/KI9
         X2cjgFaKRVIL+3Z8wcpOjD5eRRJG65XODOJ8DLh5gWcyXi2HLanr13YDiON/qlLlEl3W
         og9dhPzsQeq2IfU9Egg9KZK/JAvx89NoqtsD604C02FSIwD44FJ69vr7yNF5sYQm5gAK
         GAghFjePE8qkEA660tVYwbyQ8V9smJpPPB74YdZc6s3/JbdgXqOkrnSqU0bTNu1+qn/6
         Pij1yQjZPneeHM5feYsJJ0ZXW8guNKysUfApA/Jso5hj++tBJQ36Cx/J0OdTeNTXN3Vn
         dd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=WsuBLNzNc067A2n3/Q8RoTS6LnvBPyrcizL2V86MwiQ=;
        b=xhH1kJH0fqQ5LN5Ye5K0GUMPN/63B72/z9+gd2AhTLyi4o4qrz3SjKEjZkGWNeF2n4
         Uttuw4ICR47j7+tS5LNeGKGlp+RtTXbLQDFN+C+E+Elbv++RPB9/RvnpIAbtJ+qSaBUS
         coSowp8afT3koJwPmI7s6tNfXLCWgWJFtW9X+aTwRguzf060sfL/egAX23x3AcDGn2W0
         OBM9uRvQmApNRUFBMANX6KJNadh6Iv9Fxl0SkrTYAwdXEmGQeK/v+sStx6/akBLSw/D2
         icXL4MJeTHD7WqiGwTwKLeDl//PjEHRbgQMt5Bq0cfrLKsLBLs4uJvK/Q3Ctp96fZgNR
         UasQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11787-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11787-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11787-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11787-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3871:4321:4385:4605:5007:7576:7688:7903:9010:10004:10400:10848:11232:11658:11914:12043:12296:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21611:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: scale29_55b4f837c8561
X-Filterd-Recvd-Size: 1837
Message-ID: <1518639587.3678.25.camel@perches.com>
Subject: Re: [PATCH v2 3/8] Convert virtio_console to kvzalloc_struct
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org, Kees Cook
	 <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Date: Wed, 14 Feb 2018 12:19:47 -0800
In-Reply-To: <20180214201154.10186-4-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
	 <20180214201154.10186-4-willy@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408604560950999?=
X-GMAIL-MSGID: =?utf-8?q?1592409047757153700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 12:11 -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  drivers/char/virtio_console.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 468f06134012..e0816cc2c6bd 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -433,8 +433,7 @@ static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
>  	 * Allocate buffer and the sg list. The sg list array is allocated
>  	 * directly after the port_buffer struct.
>  	 */
> -	buf = kmalloc(sizeof(*buf) + sizeof(struct scatterlist) * pages,
> -		      GFP_KERNEL);
> +	buf = kvzalloc_struct(buf, sg, pages, GFP_KERNEL);
>  	if (!buf)
>  		goto fail;

kvfree?
