Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C534C223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C534C223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbeKNBXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:23:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:54132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732028AbeKNBXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:23:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95ADBB056;
        Tue, 13 Nov 2018 15:24:59 +0000 (UTC)
Date:   Tue, 13 Nov 2018 16:24:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yongkai Wu <nic.wuyk@gmail.com>
Cc:     mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetl.c: keep the page mapping info when
 free_huge_page() hit the VM_BUG_ON_PAGE
Message-ID: <20181113152459.GR15120@dhcp22.suse.cz>
References: <CAJtqMcZp5AVva2yOM4gJET8Gd_j_BGJDLTkcqRdJynVCiRRFxQ@mail.gmail.com>
 <20181113130433.GB16182@dhcp22.suse.cz>
 <CAJtqMcY98hARD-_FmGYt875Tr6qmMP+42O7OWXNny6rD8ag91A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJtqMcY98hARD-_FmGYt875Tr6qmMP+42O7OWXNny6rD8ag91A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please do not top-post]

On Tue 13-11-18 23:12:24, Yongkai Wu wrote:
> Dear Maintainer,
> Actually i met a VM_BUG_ON_PAGE issue in centos7.4 some days ago.When the
> issue first happen,
> i just can know that it happen in free_huge_page() when doing soft offline
> huge page.
> But because page->mapping is set to null,i can not get any further
> information how the issue happen.
> 
> So i modified the code as the patch show,and apply the new code to our
> produce line and wait some time,
> then the issue come again.And this time i can know the whole file path
> which trigger the issue by using
> crash tool to get the inode、dentry and so on,that help me to find a way to
> reproduce the issue quite easily
> and finally found the root cause and solve it.

OK, thanks for the clarification. Please repost without
the patch being clobbered by your email client and feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

A note about your experience in the changelog would be useful IMHO.
-- 
Michal Hocko
SUSE Labs
