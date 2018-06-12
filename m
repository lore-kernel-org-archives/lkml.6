Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 155FDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6678208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="W8/459Cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6678208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dev.mellanox.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754317AbeFLIuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:50:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33016 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754288AbeFLIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:50:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so23177711wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rGvQK5YRGAyByZ8L7eAApjSv/A3t2HTz+QF3YvQpfEg=;
        b=W8/459CpNvwDR7TQk4uzZTfOO+RSlR/paGoYoKEQPA0LUt/7SqfzXyrDC2bxPieAEf
         CrKHnwJDuqnxGpXlGxWG+DVyQfQIUNczABMgI0rEJlURKbGTnevRLO79SRWEe0i2fUv4
         sDXwWjPTxqeiwD/yA1LD5FVsSFb1J9q87KPR53M0G9JKkCmmz/mwsDUvMSYqk2T4/3UZ
         GZPU2vIGI0WzzB3ihMAFEMJtKIy1h2QG+CFwcQARxSeNoi8daaREYx6ov/TLG2O89A/T
         nQelHFHKuN94ZvIeFJgHU2kZFK//qnYAePwrrsi+uBlwofVITLP+BGFKf875bDnbAxU7
         WjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rGvQK5YRGAyByZ8L7eAApjSv/A3t2HTz+QF3YvQpfEg=;
        b=YHoLK1b/wiOTPS9o2/aAgm5lmqY+tJtQSMdFBK5xiMxFwNPuvN0bwCBdEKzqrlsfz8
         M0Z2ncHG19BIxejwwEYE2btNlAi7WWhqZgfATIfd9mQ9UcdNo9/OfQ+tT2fPKgz1v8Zd
         f38juyssDVJB0a7YRSi23vsyk/1u0fMn5aaEooJDJYZh0ZLcbF2CJHWzfanpleIpUPlC
         DrjMuxJx+KKTWNUIW0CYLfEQ3esrRIl2CO8FTtnX4yXsGMUlDzan15i+3ycS9QCF41ZX
         WxFe2CzyVM09AnpWt/xhPgrqoKG073satf+MU95m4ODpKPWQnFPm1pPOmWhNvVz7sQ0+
         MQHA==
X-Gm-Message-State: APt69E1LkSXpeZYM6lPYvMiEhk6J5kB3c7oG1w/+HB8f2HSi5/L7L2j9
        orCpbc53THfgn5FXEQPt2sq9xw==
X-Google-Smtp-Source: ADUXVKJPU1bXf2zZq7EutFd3qKbt9B1xPpd0Sxm6xns0+/Y7l0c9/bMdEpP9ZjgezYRbGScGY2IAXA==
X-Received: by 2002:adf:8854:: with SMTP id e20-v6mr2094293wre.30.1528793450375;
        Tue, 12 Jun 2018 01:50:50 -0700 (PDT)
Received: from localhost ([141.226.165.75])
        by smtp.gmail.com with ESMTPSA id p5-v6sm504640wre.83.2018.06.12.01.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 01:50:49 -0700 (PDT)
Date:   Tue, 12 Jun 2018 11:50:46 +0300
From:   jackm <jackm@dev.mellanox.co.il>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180612115046.00007213@dev.mellanox.co.il>
In-Reply-To: <20180608174218.32455-3-willy@infradead.org>
References: <20180608174218.32455-1-willy@infradead.org>
        <20180608174218.32455-3-willy@infradead.org>
Organization: Mellanox
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Jun 2018 10:42:18 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> +		rcu_read_lock();
> +		mad_agent = idr_find(&ib_mad_clients, hi_tid);
> +		if (mad_agent
> && !atomic_inc_not_zero(&mad_agent->refcount))
> +			mad_agent = NULL;
> +		rcu_read_unlock();

Hi Matthew,

I don't see the flow which can explain using atomic_inc_not_zero() here.

The refcount will go to zero only when unregister_mad_agent() is
called (code below, see asterisks):
        idr_lock(&ib_mad_clients);
 ***    idr_remove(&ib_mad_clients, mad_agent_priv->agent.hi_tid);
        idr_unlock(&ib_mad_clients);

        flush_workqueue(port_priv->wq);
        ib_cancel_rmpp_recvs(mad_agent_priv);

 ***    deref_mad_agent(mad_agent_priv);
		[JPM] The call to idr_find in the interrupt context
		would need to occur here for the refcount to have a
		possibility of being zero.
		Shouldn't idr_find in the interrupt context fail, since
		idr_remove has already been invoked?
	wait_for_completion(&mad_agent_priv->comp);

The refcount will be able to go to zero only after deref_mad_agent is
called above.  Before this, however, idr_remove() has been called --
so, if my understanding is correct, the idr_find call in
find_mad_agent() should not succeed since the refcount can get to zero
only AFTER the idr_remove call.

Could you please explain the flow which can result in idr_find
succeeding (in the interrupt context) after idr_remove has been invoked
(in the process context)?  Will idr_find succeed even after
idr_remove, and only fail after kfree_rcu is invoked as well? (or,
maybe after some garbage-collection delay?)

Thx!

-Jack
