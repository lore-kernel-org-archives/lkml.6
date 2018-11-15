Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663A4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F63C223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F63C223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeKOS7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:59:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:43992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728519AbeKOS7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:59:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBDBCAE78;
        Thu, 15 Nov 2018 08:52:28 +0000 (UTC)
Date:   Thu, 15 Nov 2018 09:52:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yongkai Wu <nic.wuyk@gmail.com>
Cc:     mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetl.c: keep the page mapping info when
 free_huge_page() hit the VM_BUG_ON_PAGE
Message-ID: <20181115085227.GG23831@dhcp22.suse.cz>
References: <CAJtqMcZp5AVva2yOM4gJET8Gd_j_BGJDLTkcqRdJynVCiRRFxQ@mail.gmail.com>
 <20181113130433.GB16182@dhcp22.suse.cz>
 <CAJtqMcY98hARD-_FmGYt875Tr6qmMP+42O7OWXNny6rD8ag91A@mail.gmail.com>
 <dc39308b-1b9e-0cce-471c-64f94f631f97@oracle.com>
 <CAJtqMcYzA6c1pTrWPcPETsJchOjpJS8iXVhDAJyWuVGCA4gKuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJtqMcYzA6c1pTrWPcPETsJchOjpJS8iXVhDAJyWuVGCA4gKuA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 16:30:32, Yongkai Wu wrote:
[...]

Thanks for the clarification. It can be helpful for somebody trying to
debug a similar issue in the future.

> But i can not find a similar bug fix report or commit log.

What about 6bc9b56433b7 ("mm: fix race on soft-offlining free huge pages") ?

-- 
Michal Hocko
SUSE Labs
