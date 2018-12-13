Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F718C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14742080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5/pxAW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14742080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeLMFil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:38:41 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:35134 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMFik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:38:40 -0500
Received: by mail-pl1-f176.google.com with SMTP id p8so504966plo.2;
        Wed, 12 Dec 2018 21:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iFjqhMle0F456IwnNhwbJveNjVhpNpNoLbO1EhKs+7s=;
        b=N5/pxAW2gdlOPnzHCwamRxhUV7Dccw0FOc8rM/4kLAzfnCgov5wCCmVNbVEY/3ZXwM
         8iknvph6L3bbsKHaT5/xCnQT6JIsX6eHGYjA28T/G/iZRqRvtVnTpdPqZxQ28YBHoSXX
         tcAkm1KUBpQbXi95JZ5dZK631eV4QiXWSzv5Wbzu6c3jqZP8JFI1Vh7SlLbzNtEa4wKF
         H60cy+ycz5igoXzl92c28/gXDvruaJSBWlUUal6QCMsQ+yCnq/+2bQ23d3I+cH0W4ZuC
         0FdMfzbRsDT3m0SABR8ctsfJVmpfNmjvpUs6Vt+KeHPe8TyOk75cd2EkHE/rvfUM/8ND
         puMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iFjqhMle0F456IwnNhwbJveNjVhpNpNoLbO1EhKs+7s=;
        b=O5beMuU4CUK4gQr+NmbywT1zGpOi2aWrGxck620oA1CRh1KO4c1s5O0yvYqOWM5qnM
         Z8REjWzNcf8PpFOZ6RC8U25aDJeiRMRSM2GBIsRxIK0lLzjYpkL4TaidkCP602T0OSsT
         e65koFHzDjIhmnNcbfr9Ux7urNKsVbC+cThbUV0+FZ3x0UzDiJSBw+gO76eXIpkgHoir
         fiua6W9UeDECI7K4vwhJERL2+JW0TW7H70JrsoxDhIEPXCT8ySagV4W7/9TAMr48YauB
         Nota+nDJjT7nXz0DkQ/U52kvd3j3cuKflSqinQEeucKWDNwW16dSH+D/UjtrXCxumg+j
         ppUw==
X-Gm-Message-State: AA+aEWbU+F+d/qLndO/mBCN6e8qgUpJKuzPKbc54pgu6dtgX2xv+4hWG
        uvUzzCnMLpCmSyM8pXLWJ8s=
X-Google-Smtp-Source: AFSGD/WmdCk5OxfqUPKAbnHbohFwc8HQcl4wLxcE3iUSl1up6skURHD3/8/EpyEkQyWjjK/4tDTEpw==
X-Received: by 2002:a17:902:2a0a:: with SMTP id i10mr22011811plb.323.1544679519204;
        Wed, 12 Dec 2018 21:38:39 -0800 (PST)
Received: from localhost ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id 85sm1025757pfw.17.2018.12.12.21.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 21:38:38 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:38:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, Jiri Slaby <jslaby@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>, lkp@01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <20181213053834.GH4860@jagdpanzerIV>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV>
 <20181212090751.GU5289@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212090751.GU5289@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 10:07), Peter Zijlstra wrote:
> > +	uart_port_lock(state, flags);
> > +	xmit_buf = state->xmit.buf;
> > +	state->xmit.buf = NULL;
> > +	uart_port_unlock(uport, flags);
> > +
> >  	/*
> >  	 * Free the transmit buffer page.
> >  	 */
> > -	uart_port_lock(state, flags);
> > -	if (state->xmit.buf) {
> > -		free_page((unsigned long)state->xmit.buf);
> > -		state->xmit.buf = NULL;
> > -	}
> > -	uart_port_unlock(uport, flags);
> > +	if (xmit_buf)
> > +		free_page((unsigned long)xmit_buf);
> >  }
> 
> That looks sensible anyhow. One should strive to not do alloc or free
> under locks as much as possible anyway.

Right, good point.

	-ss
