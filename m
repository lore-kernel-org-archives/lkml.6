Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id x9vjN3YPG1vvdwAAmS7hNA
	; Fri, 08 Jun 2018 23:21:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C7B606089E; Fri,  8 Jun 2018 23:21:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ag0pBAQS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 51F95601C3;
	Fri,  8 Jun 2018 23:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51F95601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeFHXVY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:21:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45001 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbeFHXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:21:22 -0400
Received: by mail-wr0-f195.google.com with SMTP id x4-v6so6681238wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 16:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o9xKjsV5V8B0oh956TxUyw/FD0NR/0OPw5t9j5Ryiiw=;
        b=ag0pBAQSm5E6qzHT7OXCmieCzachkNSa+2pypN5BlRfAZMzKbYpvp0wyGeSI5cZ3T3
         eS3j9xAbzAGJYQ/pNjQvADosHJ8MQo8+3UFhevS54nJmyvdnS8ZPIDd9CT4ha9pTDHin
         CwePZqdyXty8TWUVjM3ijS8c2JML78ZtMx9OoU3WcrN0+lS2drJiRfoT5bX4Lg45erUK
         PIh7toQDOBlwqy5TU3zIX22DVvlhbw5ghPebrtWpzNhfXD53ZrkrQ9rf29wiy5TXxYQG
         u6R6TDoUwXd2GQQgHLWA9/L/5O1Tkym4a42bSnTHXjNkFD2ct5p+pwV75g384fKH5jAK
         uiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9xKjsV5V8B0oh956TxUyw/FD0NR/0OPw5t9j5Ryiiw=;
        b=ipUMcEPHOLpc6G8Llt1F7gMhkl1yvS2zLV6UKR3fmiOmHSmNtPMry14/QiV69ICR3J
         aYZsKaGsxwZ2lGydcAnBQoQWYccqvi5m4NpWDY/90WPY+k9nuhWNRFq/ji0BuY1WoM+l
         80c5e9M92P4k40XHN3Vtia35NlG7jHeuHYG3wbyq5cP7p6bq6wX9zTXDBvTXHGsOAmuk
         1b6IEXbXgVqR14qdWteNorwhyfA/MfRzPhadOT+zu+SlwslXEs7bNB+bEi6dKeGunHUJ
         ZW77nIa0f8+NLwY8BIt9PZEzr8UfkPgho/cmMMe03ULsGB2kP0MIQImYZSozXTELpdnC
         ECyw==
X-Gm-Message-State: APt69E3SBaYux8fAwyxAvBlXmPDj6Kqyx1HUmc66FfWGKj2Wh/5WLQmS
        oaxBOGYnrdQUAbi5LIj0Zt3JVw==
X-Google-Smtp-Source: ADUXVKLwSKNgtsxBnqE+aa+DN6y+dEGLsJprIhYoZtIlv+mFKX8wZFMmtZ4FEkbtp/2HpsHluuUMlQ==
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr6176654wrd.67.1528500081554;
        Fri, 08 Jun 2018 16:21:21 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id q81-v6sm4505325wmd.14.2018.06.08.16.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 16:21:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fRQh3-0000CT-Ql; Fri, 08 Jun 2018 17:21:17 -0600
Date: Fri, 8 Jun 2018 17:21:17 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Raed Salem <raeds@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Fix memory leak in mlx5_ib_create_flow
Message-ID: <20180608232117.GF12577@ziepe.ca>
References: <20180607191915.GA9092@embeddedor.com>
 <20180608230835.GA24392@ziepe.ca>
 <809fbf8a-e37d-2e92-cecb-37653e38290c@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809fbf8a-e37d-2e92-cecb-37653e38290c@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:11:49PM -0500, Gustavo A. R. Silva wrote:
> 
> >>  	mutex_lock(&dev->flow_db->lock);
> >>@@ -3640,6 +3646,9 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
> >>  	kfree(ucmd);
> >>  	kfree(handler);
> >>  	return ERR_PTR(err);
> >>+free_ucmd:
> >>+	kfree(ucmd);
> >>+	return ERR_PTR(err);
> >>  }
> >
> >This hunk is a bit wonky, can we do this instead? handle never needs
> >to be freed.
> >
> >destroy_ft:
> >	put_flow_table(dev, ft_prio, false);
> >	if (ft_prio_tx)
> >		put_flow_table(dev, ft_prio_tx, false);
> >unlock:
> >	mutex_unlock(&dev->flow_db->lock);
> >	kfree(dst);
> >free_ucmd:
> >	kfree(ucmd);
> >	return ERR_PTR(err);
> >}
> >
> >
> 
> Sure thing. I'll send v2 shortly.

I made the adjustment for you, if it is wrong let me know..

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc&id=2cc82dd58712888758c2d2b405d012f2cd580dd7

Jason
