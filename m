Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEA7C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E170B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgwhH+mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E170B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeKUKZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:25:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39631 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUKY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:24:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so2628907pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 15:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qntHmQ/yJYzTdj612JJehQf+6zEZyf2EtTRHLKQu1dk=;
        b=KgwhH+mzmKw1mIk7O9eBve0WXNTtq/kN2QMdchxTXro/8IbUlDla7kMN4aI7NV9npo
         UmNPiHDF3ROROEyCEkHndpa9t/puPUJRW+OkDgiWRQ2bhaq4ekigcrNC/3++fCf++MeK
         +mhxp+XvHgGoQYkR1NVkhoADqUdAq8TuvOJqjwcNOWpI/QtHjcmHx0dcfMQVZZoonUqm
         0A13us+/C7CBZoGNQsdpBrB2wJAlhqituaQawbdPruu4sy9FwC8N56wpRamMJaNCs0GJ
         dIXvVTu1QYUB5aJ6Ybs01BnZ0lhO6ilfFWhehpnqZ5sMmPNFFwNGEVbYgojOPGgE2Y36
         OLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qntHmQ/yJYzTdj612JJehQf+6zEZyf2EtTRHLKQu1dk=;
        b=LZMiyh0sgdq7Vg7+/AZg6YLwfLxJzNUqboVINDmDN1F3adgl8dllu3BEuYNXnL71YN
         Da9QHgyjGKN+oScEURko0/rrDODSo/i5oJ4S/1Tv+tuQHofsccbgsfZ95CfBb+XPZezm
         iij3D3IMHyqpaolr4HwRs1NWbKEECAr6v/6FnvACvHurX+woDhrxo5HQS38Zjc4hrcrD
         7GJPa/wlGAM/OGDJ29B1KW4T8Zlq94v5aD5bpu4wwZaaXdOtxhpT6O5s3ngL06eisWBO
         uW4NBuU/jSWBUJ+JBx9JD1qhv5JRlakjTgylUhRLa5gGYBO0VCE5AwJKug6D9CcNAAKG
         HbDQ==
X-Gm-Message-State: AA+aEWaTycUBhHhzjd4MVKvGLJ4wVyteLZCzV97bL5zfGdZE0Ybs5de9
        1sAp7KjbZ1rx/YH8vfq11HBWdQ==
X-Google-Smtp-Source: AFSGD/X13eRuxHvwWCKDDIiZa6HJDlEIsYs44/XMnqfnZgFrdAaj/dRkpGoF7ESTZoJrTdgR/dtzEg==
X-Received: by 2002:a17:902:162:: with SMTP id 89-v6mr4344459plb.293.1542757992419;
        Tue, 20 Nov 2018 15:53:12 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 78sm32330260pft.184.2018.11.20.15.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 15:53:11 -0800 (PST)
Date:   Tue, 20 Nov 2018 15:53:10 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Stefan Priebe <s.priebe@profihost.ag>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.4 131/160] mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20181120074447.GZ22247@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1811201551250.89573@chino.kir.corp.google.com>
References: <20181119162630.031306128@linuxfoundation.org> <20181119162643.032920932@linuxfoundation.org> <alpine.DEB.2.21.1811191410520.150313@chino.kir.corp.google.com> <20181120074447.GZ22247@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Michal Hocko wrote:

> On Mon 19-11-18 14:16:24, David Rientjes wrote:
> > On Mon, 19 Nov 2018, Greg Kroah-Hartman wrote:
> > 
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > 
> > As I noted when this patch was originally proposed and when I nacked it[*] 
> > because it causes a 13.9% increase in remote memory access latency and up 
> > to 40% increase in remote memory allocation latency on much of our 
> > software stack that uses MADV_HUGEPAGE after mremapping the text segment 
> > to memory backed by hugepages, I don't think this is stable material.
> 
> There was a wider consensus that this is the most minimal fix for users
> who see a regression introduced by 5265047ac301 ("mm, thp: really
> limit transparent hugepage allocation to local node"). As it has been
> discussed extensively there is no universal win but we should always opt
> for the safer side which this patch is accomplishing. The changelog goes
> in length explaining them along with numbers. I am not happy that your
> particular workload is suffering but this area certainly requires much
> more changes to satisfy wider range of users.
> 
> > The 4.4 kernel is almost three years old and this changes the NUMA 
> > locality of any user of MADV_HUGEPAGE.
> 
> Yes and we have seen bug reports as we adopted this older kernel only
> now.

I think the responsible thing to do would be allow users to remain on 
their stable kernel that they know works, whether that's 4.4 or any of the 
others this is proposed for, and downgrade from any current kernel release 
that causes their workloads to have such severe regressions once they try 
a kernel with this commit.
