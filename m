Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4FDC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA6425BB2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUaeJijA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA6425BB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934477AbeFYOoN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:44:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46814 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934266AbeFYOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:44:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id q14-v6so2394039pgt.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wAxkockyx9gMPQLmB6/Vm3NmsK9KNWvbEYu/V1et7Oo=;
        b=nUaeJijAAg3Qej/WljMkZ5Yj9bfQtVsQKABb4VHL6GzfRX9PWx5o2ca8V/FUDniMRO
         wAkSDz2zxd1rPHi6UfPLWd+iPl7F60zX6wdLaznh0EklLCG505RA9ixw4R+j9zk7Mw7e
         vpy9IQy0N3rnr2AZkJubmoQ9C5l0fjG8baHpqfrqwtPNKyQHcEJl8QslEWwNnt4r5SVC
         aoKezaSL/k6D5aR/eHnkwm6F1gBlVrq4ZTRUmr9u9gYaF9yp1PpgRpFbqpGURRoY5fdx
         ZoX33fICMJnB91PAO3eiYjCod6EfIP1NNrnbNJUcnvnV5op7O6MS/Co2qFlugJguyfkJ
         uyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wAxkockyx9gMPQLmB6/Vm3NmsK9KNWvbEYu/V1et7Oo=;
        b=BJj+lH2PQUb2WMF7YHm4PmgSz+w2OxbRbn3vYIf6YAxqMsjpKWiYFuaH3HWdMn5/RP
         /JxZAqwIwVFMLbMaYVBxObgWTzDc2cWA/mI0U6jTJ8SZ9omAGyDuWQij+jz0CMSb/IAG
         /BLx3bDAlzYvbjh+6OTqauentsc10BUuJF1fm5cRPOzRArZq5vORgR1zWLSaV2Yypv4I
         eW/r02+5JLeGC1vlvInN0jHLzltXMOS8gGo27WwNmwI/vMJ0zlF0DaA1Rk24WZIURnEO
         nb13YQnxVXMi44s6IHvByw5sZO5CeOPZRJtAx++u7xbySzQTtNwDXbBJrCRc+9VVUKda
         p51g==
X-Gm-Message-State: APt69E1Ln6Crv1BwIisTdjjCB6C3PeOKSDeXM/wRQCMB1CJtIcPfqDQH
        UNnb9Xu3FrbEzTtwsABcm0iRm7/E
X-Google-Smtp-Source: ADUXVKLPGgF/7xXhLvy9DtpU4RADj/9U+HHKvq3VTtJ4W+ir+9uKnVvpsmrcMbBLrBAHR9chaUUwYw==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr6212688pgq.382.1529937850790;
        Mon, 25 Jun 2018 07:44:10 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id d65-v6sm24809051pfj.20.2018.06.25.07.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 07:44:09 -0700 (PDT)
Date:   Mon, 25 Jun 2018 23:44:07 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Namit Gupta <gupta.namit@samsung.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        pankaj.m@samsung.com, a.sahrawat@samsung.com,
        himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180625144407.GB443@tigerII.localdomain>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
 <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
 <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
 <20180625103704.49811ec1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625103704.49811ec1@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/18 10:37), Steven Rostedt wrote:
> 
> Is IMHO rather ugly.

Either way works for me. So I'll leave it to you and Petr to decide :)

> And the original patch has one more advantage. If buf and clear are
> both NULL/zero, we don't take any locks.

But we never use syslog_print_all(buf = NULL, clear = false). It's either
NULL/true [move forward clear idx, do not copy to user], or !NULL/use defined
value [copy to user, move or don't move clear idx forward]

	-ss
