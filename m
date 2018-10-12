Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C129521473
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2R5bNB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C129521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeJLOBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 10:01:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35212 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJLOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 10:01:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8-v6so5425984plb.2;
        Thu, 11 Oct 2018 23:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NW0P/xv6WbCKZRs26NWuRZb/FSfHIe70y5TEiToPU7U=;
        b=C2R5bNB3CMw1vwaAjdYg+iad3leGvOcOrMtrjsoMhlKXyw2/PFSXNeQ5ZnWaIU02Mc
         nGzJDJaUch/V7DuFmI+Fkc24VyjNL55remDeR6BeHHlpZWIBxA+U7L8DBgW8AVRv6C/I
         dvOD0qc+zTL6eZ9hr3075Xns1AgPt10bN0ZbJiHvS7a2Yd4yVMH71VEFcQXioxn4u6XG
         atLL1LylqEr7uShhtYOvQZW3xH0h/aHtAXQnaS7UnbtJzcl+jlBlNlLMmiN/k/PhmamD
         UVZUG1ExOxEU+CZbuARFg005LO1WaXrlvJj13fo7ujLsk8n0wFOQJLK6oMIHQkYLyny3
         lF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NW0P/xv6WbCKZRs26NWuRZb/FSfHIe70y5TEiToPU7U=;
        b=Rg8YWyXax1yAFmmxY3lAoK8Q9TE9szJKhjUTT5SoH/dR9JerFPeEjgYIcRah3Ioe5o
         9SSaVph8wcaaRIxnp9cP1Pavv8PxTNTLxaDpJxhqjwiWNGRNTJzHJi37SLJFrE9IRpBm
         ob6Og3OxOohySaPoTkad+WYH/3GtKrHjvq+zsS9FvTLh8BI8jt/WdbFmUTjn5xt1FNdt
         8PUyjVz6CeH/HgMzdv0TeAOriPHcvFVXqzllvsauEHC4VPAHJFXkP8VjqN9RU+eUA7tc
         LTIUp966mM4zx6dJP99ziXJRhHwiN1H1uZPcHgRLtz5FiRWwh7ul9ct6PrkXUcz4BpxK
         Vghw==
X-Gm-Message-State: ABuFfohHp0S5Zpg4AByVzBmWuT5QwjyYtOo436VW5nOphSuYdsSzztYN
        FAsG/Yhn6FN+hq2gb3FiWQI=
X-Google-Smtp-Source: ACcGV61b4OCjG1S8dkcnUFljhqymsg9hcYwYgBdNlmdrf3WUutLMO8QTgiTOa/Vf03iJ4Enb0Os6dQ==
X-Received: by 2002:a17:902:b198:: with SMTP id s24-v6mr4438748plr.70.1539325839873;
        Thu, 11 Oct 2018 23:30:39 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id r76-v6sm543089pgr.11.2018.10.11.23.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 23:30:38 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:30:34 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/6] mm: get_user_pages: consolidate error handling
Message-ID: <20181012063034.GI8537@350D>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012060014.10242-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:00:09PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> An upcoming patch requires a way to operate on each page that
> any of the get_user_pages_*() variants returns.
> 
> In preparation for that, consolidate the error handling for
> __get_user_pages(). This provides a single location (the "out:" label)
> for operating on the collected set of pages that are about to be returned.
> 
> As long every use of the "ret" variable is being edited, rename
> "ret" --> "err", so that its name matches its true role.
> This also gets rid of two shadowed variable declarations, as a
> tiny beneficial a side effect.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Looks good, might not be needed but
Reviewed-by: Balbir Singh <bsingharora@gmail.com>

