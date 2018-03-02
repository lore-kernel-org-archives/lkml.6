Return-Path: <kernel-hardening-return-12067-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtMb33SzxlIYhPRmlDtaEp6LsGVkL2ZDGw4ghX8g+aHc8rtGf29ZXifm/xuQShHYcIlmgie
ARC-Seal: i=1; a=rsa-sha256; t=1519949651; cv=none;
        d=google.com; s=arc-20160816;
        b=NBjAON5bOAtgiyBRlwX6Oll2+Hh8M/bBTnYVXcC7jbHJH9+c1hmDnPZS7hsJfJoAKE
         pAsSSUWNTj6EfqwcX7AolQYVS/jNW6OTJL8wfuGRDFOXwx7Bzvp9BW2dVzpDH83eSfqK
         Ao441KtO6lqNhzpktPacodjDD4KsB88pVqsc8Z+bTboM7SCa6MirRe8H2JDNqBpHksDz
         UlJSdbDIwk7HrHQSBDZ9Ty3yooLJz+BKIaZ/4Nr+kSfZubMclA5AqORMCUql+y7zUgjZ
         Wk143bdWaKoHhwQkrxAziLllBxG1BEza7sHHXK2b9GIAF9RN9OM89yiOgjBiG+4h0tKf
         G0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=/Rmj6axvMG+GEvSSw4uq2b506/W9pk+oUmIw3rvCDsM=;
        b=xrmiHW7fVyf389yKGSPVniFW17pN5Ta2YdbA5ZSe0d/fswpjgXVyMmAcX/B2EWvZoH
         WwFF9mC50nnu6otkLBW/TDouAsXKvUU3oOx8kSMWlMuv1OxpVsUSxy5GA1buCvSQGCzu
         pYjKcrZzGdyw7yV3besSbgWQU7G9vAss0GVdwjhCZOa3bfZdT4Es8/Vz2xu0xEgtiz3j
         VSGXM7DcipxYD2ohtKtAOvbVLNrGVHpygzb9txFuS4B6QyJyV0rsRCRwF2fFB4GXgPIo
         54IHSYHunvsv0rr5BAsG3gWsvSI5Z+wk4cm7RnY4N3hK4iRuj0yadeEYcqEr5Ze+HWwO
         cK6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=mkDaDWEr;
       spf=pass (google.com: domain of kernel-hardening-return-12067-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12067-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=mkDaDWEr;
       spf=pass (google.com: domain of kernel-hardening-return-12067-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12067-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 1 Mar 2018 17:13:49 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] leaking_addresses: check if file name contains
 address
Message-ID: <20180302001349.buaus74hx3xjoaqs@cisco>
References: <1519941800-27710-1-git-send-email-me@tobin.cc>
 <1519941800-27710-3-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519941800-27710-3-git-send-email-me@tobin.cc>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593774558815330695?=
X-GMAIL-MSGID: =?utf-8?q?1593782725944105764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 09:03:20AM +1100, Tobin C. Harding wrote:
> Sometimes files may be created by using output from printk.  As the scan
> traverses the directory tree we should parse each path name and check if
> it is leaking an address.
> 
> Add check for leaking address on each path name.
> 
> Suggested-by: Tycho Andersen <tycho@tycho.ws>

Acked-by: Tycho Andersen <tycho@tycho.ws>

> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  scripts/leaking_addresses.pl | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
> index 65a65aa64d26..a550c9bc34f5 100755
> --- a/scripts/leaking_addresses.pl
> +++ b/scripts/leaking_addresses.pl
> @@ -463,6 +463,16 @@ sub parse_file
>  	close $fh;
>  }
>  
> +# Checks if the actual path name is leaking a kernel address.
> +sub check_path_for_leaks
> +{
> +	my ($path) = @_;
> +
> +	if (may_leak_address($path)) {
> +		printf("Path name may contain address: $path\n");
> +	}
> +}
> +
>  # Recursively walk directory tree.
>  sub walk
>  {
> @@ -484,6 +494,8 @@ sub walk
>  
>  			next if (skip($path));
>  
> +			check_path_for_leaks($path);
> +
>  			if (-d $path) {
>  				push @dirs, $path;
>  				next;
> -- 
> 2.7.4
> 
