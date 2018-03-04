Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AG47ELvQEldSoXH3dXtnqsGPz6BPMh40s+rNOUy1MnCAQDpVqySNGyAja3QYGCO7vvjbJogrV/6p
ARC-Seal: i=1; a=rsa-sha256; t=1520196845; cv=none;
        d=google.com; s=arc-20160816;
        b=KhX+RZpiiXFPVldrNQ8FY+xLv0yzgmd6jUe4f1I6nGpO9mPsQSIYKK6Phwm+sLni0C
         HKLz4v/+ymtnDOKR2nJZMWiH98yMttI+7s1DzhtRTsW1pbQGbcJOwJEoLSkYpPwF9Mcj
         rTtHQUBEQTbqkyRPzM0mUlUsU6T2CX4Ew3v003Cf+ju2nDIrDZ3DDFn4Wzgzmh+eNFuH
         dsVGABbVto7reQgc+rmJbZ2nSCQC9IYOUej+rReXQreC3vZYsC96Tbua/np/FkTz6obJ
         OjWLeNjzfhGp6+kvl6cY4tvlkd64E88b7EPvwsEaz9ciM+T33RGS9v4XQxSpKQwVU8IE
         F9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=RomIOm44uyDcnfJbJ65oCeIyquItc7IXRID7c6lB/bA=;
        b=iH7lQDttXkvpUMk3nuwesVe54jRX7p0OOtbIi4CMMJHOOh/4GRh7L8cGMNJxdhKWL1
         OMpiqn3bhuJFpCpZi4PG/+HekpS4/mcySRrtrH3mlEH9fc9JFOZJmw/1w1gljIwWN6Cz
         JHHLzW6djarLcEe3Zi79aD4lBpPXLS7VgLX3uDUcOFCHqXgWvRNiJgG1iMszOYEROc9R
         /JXfGBxtc4r3IWnuT/jXtIarPdKAXNAM34iCFoP0t0pGaH7AAA/xDPHwy+msQ5Uklt/L
         1xthyNnsTvPu2yuLayaotTJHNowcLdpL2FP2PLFCMoxa3/J8ew6B16P4rpj8RhlPxaKY
         F8qQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.47,425,1515452400";
   d="scan'208";a="316328578"
Date: Sun, 4 Mar 2018 21:54:04 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org,
    devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
    outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH v2] staging: Replace printk() with
 appropriate net_*macro_ratelimited()
In-Reply-To: <20180304204910.GA4840@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803042153160.2182@hadrien>
References: <20180304204910.GA4840@seema-Inspiron-15-3567>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594041647864597387?=
X-GMAIL-MSGID: =?utf-8?q?1594041927421491798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Mon, 5 Mar 2018, Arushi Singhal wrote:

> Replace printk having a log level with the appropriate
> net_*macro_ratelimited.

Why did you choose this function?

> It's better to use actual device name as a prefix in error messages.

What does this message relate to.

> Indentation is also changed, to fix the  checkpatch issue.

It would be better to no exceed 80 characters than to follow the
suggestion abotu the argument being to the right of the (.

julia


> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> *In previous version printk was changed to pr_*macro(), which is used
> in kernel instead of calling printk() directly. And for drivers,
> dev_*macro() or net_*macro_ratelimited() should be used for calling
> printk() directly.
>
>  drivers/staging/ipx/af_ipx.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/ipx/af_ipx.c b/drivers/staging/ipx/af_ipx.c
> index d21a9d1..9a96962 100644
> --- a/drivers/staging/ipx/af_ipx.c
> +++ b/drivers/staging/ipx/af_ipx.c
> @@ -744,13 +744,13 @@ static void ipxitf_discover_netnum(struct ipx_interface *intrfc,
>  			intrfc->if_netnum = cb->ipx_source_net;
>  			ipxitf_add_local_route(intrfc);
>  		} else {
> -			printk(KERN_WARNING "IPX: Network number collision "
> -				"%lx\n        %s %s and %s %s\n",
> -				(unsigned long) ntohl(cb->ipx_source_net),
> -				ipx_device_name(i),
> -				ipx_frame_name(i->if_dlink_type),
> -				ipx_device_name(intrfc),
> -				ipx_frame_name(intrfc->if_dlink_type));
> +			net_warn_ratelimited("IPX: Network number collision "
> +					     "%lx\n        %s %s and %s %s\n",
> +					     (unsigned long) ntohl(cb->ipx_source_net),
> +					     ipx_device_name(i),
> +					     ipx_frame_name(i->if_dlink_type),
> +					     ipx_device_name(intrfc),
> +					     ipx_frame_name(intrfc->if_dlink_type));
>  			ipxitf_put(i);
>  		}
>  	}
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180304204910.GA4840%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>
