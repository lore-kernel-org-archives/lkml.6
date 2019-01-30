Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1CAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DFE2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548870748;
	bh=sD8siXqM5tlYWDJh5dxcrpR1LJk+ghZuC/q9VZH86YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lkCxLI+WZ8wPD8suTuxTENIb0t/VDqhIp+tyivqwqDp3qRK3r72B/jJerIJRJ2j0K
	 NFLJhQlVGoHyVBFhRLCooH3ozE4InH0cOq9ygmvUoHSmpXALBU8tkCraQuLGmLIcF3
	 nhtyRk08vxputXpkiE+G+H+9CRsyORXyKyYKrGx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfA3Rw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:52:26 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42367 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfA3Rw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:52:26 -0500
Received: by mail-yb1-f195.google.com with SMTP id l20so155944ybl.9;
        Wed, 30 Jan 2019 09:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nqKoowBhVNotvsktwsU7UZYX3ZVWVurI0845PhIUGvE=;
        b=dOHMTovASZbHyzLMlsR1yiUz4PRvp4/poseV7ogwNMHv3/be5mx/yokv2EEwmfpd7T
         FK/vMQcx4rU01+ILFFvVnmT19udKPJH0GBaWw3rzZ/59IhlxxwYzXEjCGPx8j4W0slD5
         8mjqVJfR0n0h5oQFJ8Bj6WXWQd8hUGp1Pslh3smiu/WkeKL2wL8B4c5hxR30r+V9KW61
         kO99vj4we+fQpeuEG3HgawSzwpSgLCBWejrCgd9CsRY1nniS3gTUf6b1YaunN5R0cS88
         +9Gud7dyuD1S4gO7Z1GHVUnIdEahBP1feMONom808xwfS7aH2Rws+RibtI316+umNGgI
         NpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nqKoowBhVNotvsktwsU7UZYX3ZVWVurI0845PhIUGvE=;
        b=ZjgQaS6zWXLFxMl6NpmNRYja7RejiKSa6dGT0/IVeoLxotwl1ES+RLU/LbB3WQN2Ls
         m2AFfodUBLC+S69wYOcunkxNJKN8LjRDXZoH179PgddO3+mDF8h8ySswCfk8zeWuSGtS
         B7H2SCnKMFXhg2SA7BiPWoc/fsZDrPbd4004aUFE1NgIVDTRkeuNaNvH3dR4nCOyR9jZ
         j37nR7s5U6+LiHx/e4umKmabf7Xs353ANobH/sceH5LDiumHDuYgKVKKgkow/ISXYKhW
         HtTRBVp3Jkl91NBgROIQi12U0nJBp+RDzVsvvE6tJ5iq+/IP6dG0N3lWc3UA12ufZGwD
         pWvw==
X-Gm-Message-State: AJcUukfqxoKLr4PUSxUUUt1BLDHwYyVTVu8ZwVytGj3O9HVN57Gm40iS
        c3NDd2JKbeG7m0DaNhNL9vA=
X-Google-Smtp-Source: ALg8bN628JXeckvdJGB6xWOnV6HxuTUUu+k4Hb31FKkRaVS5OQhGSk9ocEMHOqrY6prvD44HHm13xA==
X-Received: by 2002:a5b:98b:: with SMTP id c11mr22918439ybq.141.1548870745339;
        Wed, 30 Jan 2019 09:52:25 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:e55d])
        by smtp.gmail.com with ESMTPSA id s35sm3839343ywa.19.2019.01.30.09.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 09:52:24 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:52:22 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190130175222.GA50184@devbig004.ftw2.facebook.com>
References: <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
 <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz>
 <20190129145240.GX50184@devbig004.ftw2.facebook.com>
 <20190130165058.GA18811@dhcp22.suse.cz>
 <20190130170658.GY50184@devbig004.ftw2.facebook.com>
 <20190130174117.GC18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130174117.GC18811@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:41:17PM +0100, Michal Hocko wrote:
> But we are discussing the file name effectively. I do not see a long
> term maintenance burden. Confusing? Probably yes but that is were the

Cost on user side.

> documentation would be helpful.

which is an a lot worse option with way higher total cost.

If you aren't against making it a mount option (and you shouldn't),
I think that'd be the best use of time for both of us.

Thanks.

-- 
tejun
