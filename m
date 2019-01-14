Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABC1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28378206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lyYVrL/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfANQ43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:56:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39275 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfANQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:56:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so10602070pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vkwq3id0aiSy/vb74DJe2hbNKxSIPAis3Qrod7DHZQ0=;
        b=lyYVrL/nMjGWRQq1IqKhH+RRcKq8y5UvOTovpShB7RyKJ1o/hirWuzf8BxwnhT2zQi
         7EyWO35lPb4/GgfXYa/yJHyQDnI9LlTtuHqAX1q5Xo+dDw4wKCVV3l89VW0+fgdWeC87
         6DRFrxDXOTg3rFvzzhSygiBSR8tgjQVt/GW4EduO1mZHoIXgx1SnBx/p0v97Oj26ELtZ
         TppihwXBI01kMHpDzE1ktz9G3+HttV+YO6jb2/5zUMy37cezMu6tjL5GdOfx6FERFZjt
         lw0S/adX13551B41ywIVH5MeG+0qJ9tmpLmROCbBUm6GsJeUK7t5jMx8UvzrQ2fysNVX
         B4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vkwq3id0aiSy/vb74DJe2hbNKxSIPAis3Qrod7DHZQ0=;
        b=rinCrufXNjUlB9dt7K8fcTSAu4G7ZcwjjS8X159FkePOoNvAcOow3urEsC6i841wZU
         dfCKnR/7gOvuV4QZz04U9paMuxBfAY84OsAaXsdYRAYtGgXkf7lyjSOpbpsxV2HWTSd4
         cpPclbvHXUEPj+IM6rv3UCg00PHQx44iDY0S/IlD5PHaqcy74qBAqTV2PM6Xj17nWVja
         k/hixTuMybaqNfqsPNktqgWLu12j4QoF0CgZeaeOpz+3T5UvwHrTD5kWfSlDEf0V07jq
         7EBVSV8vdVQigUvJ0p0NC8K3QyqCq6aIYShXEHQ6b5QEXUjZdCPev4zC7CmWy97K/F5N
         JDrw==
X-Gm-Message-State: AJcUukd0/oVRh8CxcePtXNt5hCaRqoyZkfOUvnIGiDlQh+YV0Bsd5qyD
        zcT3U7+UJdAx0CpWdh9OIyqsCg==
X-Google-Smtp-Source: ALg8bN6+3wKpyeAAmIcTMEhwbnGD9psTt39TSnaZ/LOOmkvbnlvqFowv2nBJwQX7Ju+E/MtwyQzljw==
X-Received: by 2002:a62:7792:: with SMTP id s140mr26138218pfc.26.1547484987383;
        Mon, 14 Jan 2019 08:56:27 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x186sm2147168pfb.59.2019.01.14.08.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:56:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gj5XB-0006jE-Q4; Mon, 14 Jan 2019 09:56:21 -0700
Date:   Mon, 14 Jan 2019 09:56:21 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] docs-rst: infiniband: Convert user verbs doc to rst
Message-ID: <20190114165621.GD22910@ziepe.ca>
References: <1547456451-7102-1-git-send-email-joeln@il.ibm.com>
 <1547456451-7102-2-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547456451-7102-2-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:00:49AM +0200, Joel Nider wrote:
> Replace the existing Documentation/infiniband/user_verbs.txt with
> Documentation/infiniband/user_verbs.rst. No substantial changes to
> the content - just some minor reformatting to have the rendering
> come out nicely.
> This is in preparation for updating the content in a subsequent
> patch.
> 
> Signed-off-by: Joel Nider <joeln@il.ibm.com>
> ---
>  Documentation/infiniband/user_verbs.rst | 70 +++++++++++++++++++++++++++++++++
>  Documentation/infiniband/user_verbs.txt | 69 --------------------------------
>  2 files changed, 70 insertions(+), 69 deletions(-)
>  create mode 100644 Documentation/infiniband/user_verbs.rst
>  delete mode 100644 Documentation/infiniband/user_verbs.txt

Thanks for getting this going Joe, I've been mulling over writing more
docs for this area for a while now.

Jonathan/linux-doc: Can you Ack at least the build system parts of
this please? I can take it through the rdma tree, unless you prefer
otherwise?

Cheers,
Jason
