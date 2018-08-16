Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A632CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DEA2148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20150623.gappssmtp.com header.i=@waldekranz-com.20150623.gappssmtp.com header.b="rkWfcDn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DEA2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390598AbeHPMp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:45:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44502 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390567AbeHPMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:45:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so3148180ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QrIreBWahnaGYpLIhPt+QkS9c/2WucQokh1MB6y83ts=;
        b=rkWfcDn7J5yJCksVrXeKMVa8rJB2qRcdkVo5Tyhhhr0IVzvrHnVJhIjo8cCxB9YnJK
         fMiH201YON2uU+KBn1mwLfeG6egQm5Ujf2nVKPCuaPNPqI1isWRbhAxiJs/SpOZvtklr
         Yk4heDUyKMmeTlCnefDDc2jrZZWS5lFHSG1fHDCSI1jz3wsQfQu0I82TflSiYZPJA7nj
         Ru3T7xnjS+TGU6fRBod4PkFSnPKVjlgBCUlu4cweg/WCz1xsOA8FTNGUfDflve/lmzkC
         9J8WgyKk2d3QLNn28bQhlSHYU5P+N/0lJ0YpbsM73+0sJO5oYmPJKOgP2Mzp24PNeTY9
         BbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QrIreBWahnaGYpLIhPt+QkS9c/2WucQokh1MB6y83ts=;
        b=KXKwtYSRsv9+8d0nMW3gQ/YX1VVO0hyXk/0b7yQvicbYCF31EG3+t2IagLJ50sdNL+
         zw4hUgJizbPd2A4HuONmnYDAqW63H+PJ3T7OjsQm3h7+FVJTLO/m0oZAJ1IIEiK1F5M3
         6u6NcaC/e7P1hi3Z91kyur+K39Yt2fj3ZiVaCqU+JHo47YsBhiugoQATZFIL6Tx+fpVv
         R3ZDhz9ZxvL5V5BTtvUykrWlHz0R5cDBuricKOnIJrpUKtmKz6rnvZDLkS0QGimMVRc9
         ByIUTj1VsGN2GitB/0n3noQu2VJd02BsIC3WGgHtGGBUT8qdSRm7YYJVZBQ6zbdGBYTh
         eLhA==
X-Gm-Message-State: AOUpUlE5eMYGVfsydElGvx0CvstWNZjq7Kbzi2WZsLyRtLps51kk+5Tg
        Ybxrq/EQ2V4a1ma44pRG6P/JKg==
X-Google-Smtp-Source: AA+uWPyG6g5VL6Toq72214bsxjhI6hM+CGfPo4296xilJr6Tt7/WTpzDv5OzpdnjBQHRG9yItaENuQ==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr20225815ljf.102.1534412882568;
        Thu, 16 Aug 2018 02:48:02 -0700 (PDT)
Received: from gmail.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id n6-v6sm4933424lfi.24.2018.08.16.02.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 02:48:01 -0700 (PDT)
Date:   Thu, 16 Aug 2018 11:48:00 +0200
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: phy: add tracepoints
Message-ID: <20180816094800.GA3136@gmail.com>
References: <20180816093418.2621-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816093418.2621-1-tobias@waldekranz.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:34:15AM +0200, Tobias Waldekranz wrote:
> Two tracepoints for now:
> 
>    * `phy_interrupt` Pretty self-explanatory.
> 
>    * `phy_state_change` Whenever the PHY's state machine is run, trace
>      the old and the new state.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  drivers/net/phy/phy.c      |  4 +++
>  include/trace/events/phy.h | 68 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 include/trace/events/phy.h
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 9aabfa1a455a..8d22926f3962 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -38,6 +38,9 @@
>  
>  #include <asm/irq.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/phy.h>
> +
>  #define PHY_STATE_STR(_state)			\
>  	case PHY_##_state:			\
>  		return __stringify(_state);	\
> @@ -1039,6 +1042,7 @@ void phy_state_machine(struct work_struct *work)
>  	if (err < 0)
>  		phy_error(phydev);
>  
> +        trace_phy_state_change(phydev, old_state);
>  	if (old_state != phydev->state)
>  		phydev_dbg(phydev, "PHY state change %s -> %s\n",
>  			   phy_state_to_str(old_state),
> diff --git a/include/trace/events/phy.h b/include/trace/events/phy.h
> new file mode 100644
> index 000000000000..7ba6c0dda47e
> --- /dev/null
> +++ b/include/trace/events/phy.h
> @@ -0,0 +1,68 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM phy
> +
> +#if !defined(_TRACE_PHY_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PHY_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(phy_interrupt,
> +	    TP_PROTO(int irq, struct phy_device *phydev),
> +	    TP_ARGS(irq, phydev),
> +	    TP_STRUCT__entry(
> +		    __field(int, irq)
> +		    __field(int, addr)
> +		    __field(int, state)
> +		    __array(char, ifname, IFNAMSIZ)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->irq = irq;
> +		    __entry->addr = phydev->mdio.addr;
> +		    __entry->state = phydev->state;
> +		    if (phydev->attached_dev)
> +			    memcpy(__entry->ifname,
> +				   netdev_name(phydev->attached_dev),
> +				   IFNAMSIZ);
> +		    else
> +			    memset(__entry->ifname, 0, IFNAMSIZ);
> +		    ),
> +	    TP_printk("phy-%d-irq irq=%d ifname=%16s state=%d",
> +		      __entry->addr,
> +		      __entry->irq,
> +		      __entry->ifname,
> +		      __entry->state
> +		    )
> +	);
> +
> +TRACE_EVENT(phy_state_change,
> +	    TP_PROTO(struct phy_device *phydev, enum phy_state old_state),
> +	    TP_ARGS(phydev, old_state),
> +	    TP_STRUCT__entry(
> +		    __field(int, addr)
> +		    __field(int, state)
> +		    __field(int, old_state)
> +		    __array(char, ifname, IFNAMSIZ)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->addr = phydev->mdio.addr;
> +		    __entry->state = phydev->state;
> +		    __entry->old_state = old_state;
> +		    if (phydev->attached_dev)
> +			    memcpy(__entry->ifname,
> +				   netdev_name(phydev->attached_dev),
> +				   IFNAMSIZ);
> +		    else
> +			    memset(__entry->ifname, 0, IFNAMSIZ);
> +		    ),
> +	    TP_printk("phy-%d-change ifname=%16s old_state=%d state=%d",
> +		      __entry->addr,
> +		      __entry->ifname,
> +		      __entry->old_state,
> +		      __entry->state
> +		    )
> +	);
> +
> +#endif /* _TRACE_PHY_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> -- 
> 2.17.1
> 

This was sent in error. A v2 will follow. I had not used
get_maintainers.pl before, sorry about the noise!

-- 
Thanks
 - wkz
