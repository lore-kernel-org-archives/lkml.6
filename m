Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A4FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFE62073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTBm6Ljn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFE62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeH3SRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:17:11 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:45231 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbeH3SRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:17:10 -0400
Received: by mail-pf1-f176.google.com with SMTP id i26-v6so3930332pfo.12;
        Thu, 30 Aug 2018 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zurj3wZUUdvWmLzrXQJDu57Ik/qb9GDh/+UW5PIu2QQ=;
        b=oTBm6Ljn1dFfokD++mhPANd3O6PaHiOTIW4DSVGAx8qrkpvXZX5HtxnDx3TLubV7rZ
         wqKPuc73wWPtQN6G8SftIWfEss76Hc2T80LmnD9MgNarNTm0+ZvXjrJZbByENpQJurN0
         BbUMeRRywA9NhW0NzDkuj850zQx8kdgAZSkmZJZY6aQ6j9xTyh/xdtMaIT3zE8d0TGJe
         0soXV5YLUZ1km27qkbqXSjTDarVyBFOJmb1sGPKxAa1e38ya+uyt1eWJHfL22tXfkhip
         EsrpUwXZQUXTStmQwq9JBiN7WJhiUKKsfIkru6Quw43/cCWwYWvCYhrAOq8R3e15tJGF
         Z1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zurj3wZUUdvWmLzrXQJDu57Ik/qb9GDh/+UW5PIu2QQ=;
        b=ATXaUVF5ACKoUeW1cnrFf6+IpsPv5sZS0DaFV8LTloAt1RgcmMA+VFiegnlOpsrRLG
         oK1oXNg/hFyhnj1CuPTi2ld0v2s4lcF9YFDhTsAg14o9ynVzov9L9uSzwlbsOGTxRPlP
         YclOqYWjWMyRzqsn+uDcebEcqfUiOgp03eLIIhvs/4/9hH93oEjSvxfk88wFBBZpDrMh
         DDfO4so0C68CSvt8jdr+JbkP6NDNyFmwr8ZPpTwsLdHOQ887MtuItPlB6myFRu58FFXu
         iunDFUkSOleXX7CXQdQq7NBtFS37xv3tY2JyXo2f7ikScW8CDBbLM7mRgTMhaY1bINEm
         pQEw==
X-Gm-Message-State: APzg51D0S91YhTSHJVYGR951TxYnTJ0hS4tdV6BuFG7Zw84hLG8BdHHK
        sEgNCOZSEgpcDWSK2/pYld4=
X-Google-Smtp-Source: ANB0VdYpb3LFKzsQcXlE6p1vRB5GTlbvCQoCYd9YkO4JvLX7jp6i+56Egh3fTHUYWv0eR1Ycv8QuLQ==
X-Received: by 2002:aa7:8713:: with SMTP id b19-v6mr10715469pfo.151.1535638489928;
        Thu, 30 Aug 2018 07:14:49 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id q26-v6sm24972519pfj.127.2018.08.30.07.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 07:14:49 -0700 (PDT)
Date:   Fri, 31 Aug 2018 00:14:46 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/hmm: fix race between hmm_mirror_unregister() and
 mmu_notifier callback
Message-ID: <20180830141446.GB28695@350D>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-4-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824192549.30844-4-jglisse@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:25:45PM -0400, jglisse@redhat.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> In hmm_mirror_unregister(), mm->hmm is set to NULL and then
> mmu_notifier_unregister_no_release() is called. That creates a small
> window where mmu_notifier can call mmu_notifier_ops with mm->hmm equal
> to NULL. Fix this by first unregistering mmu notifier callbacks and
> then setting mm->hmm to NULL.
> 
> Similarly in hmm_register(), set mm->hmm before registering mmu_notifier
> callbacks so callback functions always see mm->hmm set.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
