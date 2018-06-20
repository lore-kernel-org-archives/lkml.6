Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE65C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A9920693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xDyHqBE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A9920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbeFTBYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:24:22 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34198 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753316AbeFTBYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:24:20 -0400
Received: by mail-oi0-f67.google.com with SMTP id i205-v6so1561958oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qrpZnblF2eHzVdn2Nztszu8BEzPzaYfYt73sXsjrhuQ=;
        b=xDyHqBE79byCBXuuPAkHTlAoL4uOIfZ8WLsUMDk0y44z1wOBViwGZwcvf2gTctWE3S
         EEIU30JxGb+HlTG045q0WLKPx+rgCtGAYdaBBfT8CciGFozHZqt4a3y3MhZTv2q1CsC+
         3MpaadWYKPQqPrnYMcmYw0ax0M5Gwtgw870AS0ey1hE6r2STbSd4Kg+0AQS+Qouob73Q
         EDpLTmW89UwibzKX26dsh8X8BoE9C5Zl/E5LdPXy8hPf6P7ecONFxqS0hinh8qO5Drwo
         afw8Jf3TQ29WXrDatptyg5eZ3xzDWvNWz/9U3UhIbZNgeLnm93d4xlWEcbosOPoPxr53
         dipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qrpZnblF2eHzVdn2Nztszu8BEzPzaYfYt73sXsjrhuQ=;
        b=Kmyfv6Z1SgRUcRkWiORdOAXZh39KIMQflw6RbUpHBgg8nRyGNerv5gxjAxkUGSJRp3
         dowa3EoOt5QfZCyP6f3iEw+5HniovG75gcuYcQ+9OSkJMjIcLTQ+VECadYAeQCg+C4hi
         puifcQIaChOxP67J9l6Dwt4RPA47UUeYUX14tJs0cVM3SkAUbqZf+F0zurdaQjHuXAm2
         4VJ/u9wRSDoXP5Ky33IAWDMMs9rN7R8TBKoo29lV0a4yPJ7pROvo0BVjJCi8cygbfRyD
         kaisdiYoBWYl4P7H5wPduO8wxnjAPW0WVtBcdqfjz/KvqUpihVbSLDmeeqAylBBm4zim
         Lmnw==
X-Gm-Message-State: APt69E2lSqVypWPZVNdOI0qOehpVlHzkcQKDCzv9291DBeHcU4P/VVTA
        ucuwotEtgnSez5N+D5dYYi4Iqry0FUnuGq1VEq51xg==
X-Google-Smtp-Source: ADUXVKJpVgBmpVYLHumGYS4v7YqVm/D/1qWzjIsaNCzD/pF6yriHfRXzdDCmzeJ0SeEoNaK8LX37uoiimvXFzTlBqow=
X-Received: by 2002:aca:51cb:: with SMTP id f194-v6mr11491207oib.110.1529457860344;
 Tue, 19 Jun 2018 18:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 18:24:19
 -0700 (PDT)
In-Reply-To: <70001987-3938-d33e-11e0-de5b19ca3bdf@nvidia.com>
References: <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com> <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com> <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com> <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <0e6053b3-b78c-c8be-4fab-e8555810c732@nvidia.com> <20180619082949.wzoe42wpxsahuitu@quack2.suse.cz>
 <20180619090255.GA25522@bombadil.infradead.org> <20180619104142.lpilc6esz7w3a54i@quack2.suse.cz>
 <70001987-3938-d33e-11e0-de5b19ca3bdf@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Jun 2018 18:24:19 -0700
Message-ID: <CAPcyv4iGKYRpbv-KK3KUrm8Ab485DwX05y4uGH2ZZ8GNYh8Q_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <john.hubbard@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:11 AM, John Hubbard <jhubbard@nvidia.com> wrote:
> On 06/19/2018 03:41 AM, Jan Kara wrote:
>> On Tue 19-06-18 02:02:55, Matthew Wilcox wrote:
>>> On Tue, Jun 19, 2018 at 10:29:49AM +0200, Jan Kara wrote:
[..]
>> And then there's the aspect that both these approaches are a bit too
>> heavyweight for some get_user_pages_fast() users (e.g. direct IO) - Al Viro
>> had an idea to use page lock for that path but e.g. fs/direct-io.c would have
>> problems due to lock ordering constraints (filesystem ->get_block would
>> suddently get called with the page lock held). But we can probably leave
>> performance optimizations for phase two.
>
>
> So I assume that phase one would be to apply this approach only to
> get_user_pages_longterm. (Please let me know if that's wrong.)

I think that's wrong, because get_user_pages_longterm() is only a
filesystem-dax avoidance mechanism, it's not trying to address all the
problems that Jan is talking about. I don't see any viable half-step
solutions.
