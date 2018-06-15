Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC620C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77969208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSAltVm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77969208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966391AbeFOTsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:48:43 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37443 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965768AbeFOTsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:48:41 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so16254819lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7iX6gnIOvgG6lg0e2OT7l5TvsqVROT2ECIC6EdAqETI=;
        b=lSAltVm7e3ehwpJGdLpghijGBo08fHn69ItPZWoKnpN0OG6PTIXbkQ7yAafJ3MiW32
         9B9ff4WfYENF+7xgKIMZUuq/hdKlIChqqC00kb1b2Hu3PyiHZ+SQY/g1YevtYDnbt0Zf
         v1GNz74uGyOnoTQV/EOYZqZTOA04pZvOQaQCb1K3GguVEYdEGHxTelLb67L4tBR+uvVE
         TJwURRr7IbBoSlnw/RRJ+oK+j5AzLo3ope1CvDGMapOjqF6SIycZ2froJDQbxUaMIYVw
         xxKnAfuwFBEEy49OC4Xre/DXKTaPOB/a3WTiEBV78W2hd+8f6LZkw/9mKFfH/f6I+imM
         4rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7iX6gnIOvgG6lg0e2OT7l5TvsqVROT2ECIC6EdAqETI=;
        b=nWBS42y8coNhrxbY5DnM7+TCgMR85CT5kwKRIyjqa8uMJqOwV2qJTzz/SVBU0kTGNP
         4yuZy6ZFVALeyBwZUBleFPYnN/N6Z04UVySe8PbF5SiEj+x09QZgRelMwi0B8ccyNwIB
         heohRxAUOq/s1i6LXmmwRqN78WNtjyLbnQ6wUgcEk/WxzKOaszP+82qim2GHYZZQXpzQ
         wYx2bIq8nRo8bP3qFAkDmIke7hMd+hfJjtUdLxb/q/675mowmYwzd1yeV/EeMXeDZrHY
         NoFfCvvOO6SXLdWdfFDleM1HedSqWPnD9Y+ZIEXrkkE/27NO9AhCzUOyxvXlFnAyNGcz
         N0Cw==
X-Gm-Message-State: APt69E2ubRXtpvQ214XyTt5x7NVGQnP08E4pFNLQd8otCKcIQihdHm51
        D0pNd/TejUe+W6uv6F+J7as=
X-Google-Smtp-Source: ADUXVKItar4cZ9IwWbsTe2Ucaaxomhslg4bUPtbQ7tB/9f93WFTWH7RQtJwN12cRAj0QhHKY1fCLjg==
X-Received: by 2002:a2e:200f:: with SMTP id g15-v6mr2137176ljg.63.1529092120282;
        Fri, 15 Jun 2018 12:48:40 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id 74-v6sm432369lfp.32.2018.06.15.12.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:48:39 -0700 (PDT)
Date:   Fri, 15 Jun 2018 22:48:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 3/8] NTB: Fix the default port and peer numbers for
 legacy drivers
Message-ID: <20180615194848.GA22880@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-4-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:08:13PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> When the commit adding ntb_default_port_number() and
> ntb_default_peer_port_number()  entered the kernel there was no
> users of it so it was impossible to tell what the API needed.
> 
> When a user finally landed a year later (ntb_pingpong) there were
> more NTB topologies were created and no consideration was considered
> to how other drivers had changed.
> 
> Now that there is a user it can be fixed to provide a sensible default
> for the legacy drivers that do not implement ntb_{peer_}port_number().
> Seeing ntb_pingpong doesn't check error codes returning EINVAL was also
> not sensible.
> 
> Patches for ntb_pingpong and ntb_perf follow (which are broken
> otherwise) to support hardware that doesn't have port numbers. This is
> important not only to not break support with existing drivers but for
> the cross link topology which, due to its perfect symmetry, cannot
> assign unique port numbers to each side.
> 
> Fixes: 1e5301196a88 ("NTB: Add indexed ports NTB API")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

As a part of the multi-port NTB API the port-index interface was freshly
introduced. The main idea was to somehow address local/peer domains within one
NTB device, since from now there can be more than one peer domain to send
message to or to set MWs up with. For this we invented the two-spaces interface
which mapped in general non-linear ports space to the locally linear ports
indexes space, and vise-versa. That mapping was implemented by new callbacks:
ntb_port*()/ntb_peer_port*().

Even though it perfectly fitted the IDT NTB functions, the Intel/AMD devices
didn't have explicit ports numbering. Instead we decided to assign the numbers
by using the topology type. So the Primary and B2B US sides got port
NTB_PORT_PRI_USD, Secondary and B2B DS sides got port NTB_PORT_SEC_DSD.
In order to make it being default for all pure two-ports devices like
Intel/AMD the new methods ntb_default_port_number() and
ntb_default_peer_port_number() were developed and utilized in the
ntb_port*()/ntb_peer_port*() API functions (see ntb.h header file).

So to speak the main purpose of the default methods is to assign some unique
port number to the NTB devices based on the topology at current implementation.
Please note, that it is essential for the NTB API to have each port uniquely
enumerated within one device. This is the way the multi-port NTB API has been
designed in the first place. That was the reason we altered the Intel/AMD and
IDT drivers about two years ago.

Based on this I redeveloped the ntb_tool/ntb_perf/ntb_pingpong drivers.
Needless to say that I was sure all the NTB devices followed the API convention
regarding the port numbers. Since the Switchtec driver doesn't provide the
explicit port-index API callbacks, the NTB API internals uses the default
methods, which as you can see don't know anything about SWITCH and CROSSLINK
topologies. That's why the methods return -EINVAL so the test drivers don't
work properly.

Concerning the fix of the discovered issues and fixes introduced by this
patchset. I'd suggest to add the ports-index callbacks to the Switchtec
driver, which identify local and peer ports. After this the current version
of all the test drivers shall perfectly work.

As far as I can see the PFX family switches documentation operates with the
definitions like Ports/Partitions (similar to the IDT switches) as well as
the switchtec management driver. It might be a clue to the switch functionality,
which can be used to find something similar to the ports numbering.

Regards,
-Sergey

> ---
>  drivers/ntb/ntb.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 93f24440d11d..d955a92a095a 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -225,10 +225,8 @@ int ntb_default_port_number(struct ntb_dev *ntb)
>  	case NTB_TOPO_B2B_DSD:
>  		return NTB_PORT_SEC_DSD;
>  	default:
> -		break;
> +		return 0;
>  	}
> -
> -	return -EINVAL;
>  }
>  EXPORT_SYMBOL(ntb_default_port_number);
>  
> @@ -251,10 +249,8 @@ int ntb_default_peer_port_number(struct ntb_dev *ntb, int pidx)
>  	case NTB_TOPO_B2B_DSD:
>  		return NTB_PORT_PRI_USD;
>  	default:
> -		break;
> +		return 0;
>  	}
> -
> -	return -EINVAL;
>  }
>  EXPORT_SYMBOL(ntb_default_peer_port_number);
>  
> @@ -326,4 +322,3 @@ static void __exit ntb_driver_exit(void)
>  	bus_unregister(&ntb_bus);
>  }
>  module_exit(ntb_driver_exit);
> -
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-4-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
