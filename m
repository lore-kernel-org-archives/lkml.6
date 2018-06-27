Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B2BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7957D23F8A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7957D23F8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754283AbeF0L7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:59:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753246AbeF0L7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:59:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 95EF4AC06;
        Wed, 27 Jun 2018 11:59:28 +0000 (UTC)
Date:   Wed, 27 Jun 2018 13:59:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180627115927.GQ32348@dhcp22.suse.cz>
References: <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
 <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
 <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <20180626134757.GY28965@dhcp22.suse.cz>
 <20180626164825.fz4m2lv6hydbdrds@quack2.suse.cz>
 <20180627113221.GO32348@dhcp22.suse.cz>
 <20180627115349.cu2k3ainqqdrrepz@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627115349.cu2k3ainqqdrrepz@quack2.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-06-18 13:53:49, Jan Kara wrote:
> On Wed 27-06-18 13:32:21, Michal Hocko wrote:
[...]
> > Appart from that, do we really care about 32b here? Big DIO, IB users
> > seem to be 64b only AFAIU.
> 
> IMO it is a bad habit to leave unpriviledged-user-triggerable oops in the
> kernel even for uncommon platforms...

Absolutely agreed! I didn't mean to keep the blow up for 32b. I just
wanted to say that we can stay with a simple solution for 32b. I thought
the g-u-p-longterm has plugged the most obvious breakage already. But
maybe I just misunderstood.
-- 
Michal Hocko
SUSE Labs
