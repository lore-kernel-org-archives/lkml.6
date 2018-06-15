Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E0637C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947AC208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947AC208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936286AbeFOOKL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:10:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932360AbeFOOKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:10:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3FD4FADD3;
        Fri, 15 Jun 2018 14:10:09 +0000 (UTC)
Date:   Fri, 15 Jun 2018 16:10:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Oscar Salvador <osalvador@techadventures.net>,
        Oscar Salvador <osalvador@suse.de>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v3] x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved
Message-ID: <20180615141008.GJ24039@dhcp22.suse.cz>
References: <20180613054107.GA5329@hori1.linux.bs1.fc.nec.co.jp>
 <20180613090700.GG13364@dhcp22.suse.cz>
 <20180614051618.GB17860@hori1.linux.bs1.fc.nec.co.jp>
 <20180614053859.GA9863@techadventures.net>
 <20180614063454.GA32419@hori1.linux.bs1.fc.nec.co.jp>
 <20180614213033.GA19374@techadventures.net>
 <20180615010927.GC1196@hori1.linux.bs1.fc.nec.co.jp>
 <20180615072947.GB23273@hori1.linux.bs1.fc.nec.co.jp>
 <20180615084142.GE24039@dhcp22.suse.cz>
 <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-06-18 10:00:00, Pavel Tatashin wrote:
[...]
> But, I think the 2nd patch with the optimization above should go along this
> this fix.

Yes, ideally with some numbers.
-- 
Michal Hocko
SUSE Labs
