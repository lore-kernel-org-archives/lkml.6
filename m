Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064CEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A120521758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqdXZViJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A120521758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeHNCDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:03:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34242 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNCDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:03:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so8230561pgv.1;
        Mon, 13 Aug 2018 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RM563o6Hx84A95xvuO+qAsVrNZfo0NVHUPDxOl7TDcU=;
        b=sqdXZViJJtPIOR2ey1IAe/I65LtlNlif7397bxvukw5fLDLS0dilZ13XyTHufvid72
         9NOY+K/9plC4cNUEfRYSB0KDVX5iWn/QOFo7gjyTKhsYEHaQUxTeqTiYQV0Es+0iYXCG
         fmsMap4cdL9BU+wzz2e5MlKxBlYzcKltXn5VHZvyiMAsWXX7Gmv6TiGumbqqxIEUsgdF
         XtGgSqLGyRxfBAnywa//dkQ53ZUPwiaCUMB4/bgqPAYlr573buKX8TB0riNTb39gG+Gj
         SFLPDu9hsAXnZ+arX0Y6cR/wDaXwM0NkMxi7W02U7O5wydM3euCUQE0tUB7qsbMHyrQL
         3vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RM563o6Hx84A95xvuO+qAsVrNZfo0NVHUPDxOl7TDcU=;
        b=lEJNOjHEelQUS+FdhUBr2TSE4UXrvmU0vj+U7u7R9X9ESTdHnJiKnvWXXQ4qiMeu1B
         lzq/eeKHAGGuctn0QLV1n5VC8UaXkU1KC5Ywh5CW3N9/TQpBGKPo/FUCL9xBz7jnS5YY
         GKWybrvHcuvdoUOJdY4ItMj+B3hg9kbrv8f7ehrSv3zYhjKImRANxg2YYWfRaRwrK6UR
         SSPy9VqLikKF6IQedPtnUUMfHGGO3XLOUh5VUUAEllR1IBG5AHAcNO4IqUo2ZLREZlGE
         D/p68AWEI7YAS586lE0/2ZaIykggyZAiPnux1aGs47/JBWei355ATtaD/w0VhXZiPT7K
         X8fA==
X-Gm-Message-State: AOUpUlG5q3vzSpu8Xj6iacTay+k35o1xsmTww9PW5TBXqP1dgNiNln8Q
        P3ksMPZEoCFZSI3vZTHohVE=
X-Google-Smtp-Source: AA+uWPzV22QzR800EHqY8jPyFlGW97YdsMz6mjIwhdmeSm8n178tW0fm46wzCJpZrnnD9v5znkWg4g==
X-Received: by 2002:a63:144b:: with SMTP id 11-v6mr19195348pgu.219.1534202338509;
        Mon, 13 Aug 2018 16:18:58 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id 1-v6sm42142159pfm.145.2018.08.13.16.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 16:18:57 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:18:54 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        AL Yu-Chen Cho <acho@suse.com>
Subject: Re: [Question] bluetooth/{bnep,cmtp,hidp}: memory barriers
Message-ID: <20180813231854.GA173912@ban.mtv.corp.google.com>
References: <20180730031030.GA9430@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730031030.GA9430@andrea>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 05:10:30AM +0200, Andrea Parri wrote:
> Hi,

Hi!

> I'm currently puzzled by the the three calls to smp_mb__before_atomic()
> in bnep_session(), cmtp_session() and hidp_session_run() respectively:

For the curious: I believe Jeffy Chen added all of those.

> On the one hand, these barriers provide no guarantee on the subsequent
> atomic_read(s->terminate) (as the comments preceding the barriers seem
> to suggest), because atomic_read() is not a read-modify-write.

I'll admit, I didn't notice that piece of the documentation when
reviewing this the first time:

Documentation/atomic_t.txt
<quote>
The barriers:

  smp_mb__{before,after}_atomic()

only apply to the RMW ops and can be used to augment/upgrade the ordering
inherent to the used atomic op.
</quote>

> On the other hand, I'm currently unable to say *why such an "mb" would
> be required: not being too familiar with this code, I figured I should
> ask before sending a patch.  ;-)

I can't fully speak for Jeffy, but I expect based on the initial
development of his patches like this one

commit 5da8e47d849d3d37b14129f038782a095b9ad049
Author: Jeffy Chen <jeffy.chen@rock-chips.com>
Date:   Tue Jun 27 17:34:44 2017 +0800

    Bluetooth: hidp: fix possible might sleep error in hidp_session_thread

that *some* kind of barrier was stuck in there simply as a response to
comments like this, that were going away:

-                *
-                * Note: set_current_state() performs any necessary
-                * memory-barriers for us.
                 */
-               set_current_state(TASK_INTERRUPTIBLE);

+               /* Ensure session->terminate is updated */
+               smp_mb__before_atomic();


It was probably an attempt to fill in the gap for the
set_current_state() (and comment) which was being removed. I believe
Jeffy originally added more barriers in other places, but I convinced
him not to.

I have to say, I'm not really up-to-speed on the use of manual barriers
in Linux (it's much preferable when they're wrapped into higher-level
data structures already), but I believe the main intention here is to
ensure that any change to 'terminate' that happened during the previous
"wait_woken()" would be visible to our atomic_read().

Looking into wait_woken(), I'm feeling like none of these additional
barriers are necessary at all. I believe wait_woken() handles the
visibility issues we care about (that if we were woken for termination,
we'll see the terminating condition).

That's my two cents, even if it's only worth about two cents.

HTH,
Brian
