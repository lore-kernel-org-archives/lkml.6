Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B82C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1702489F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1702489F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeGBU2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:28:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGBU2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:28:32 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BB6FC5C;
        Mon,  2 Jul 2018 20:28:31 +0000 (UTC)
Date:   Mon, 2 Jul 2018 13:28:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     mhocko@kernel.org, n-horiguchi@ah.jp.nec.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@techadventures.net, osalvador@suse.de,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        willy@infradead.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, dan.j.williams@intel.com, ying.huang@intel.com
Subject: Re: [PATCH v3] x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved
Message-Id: <20180702132830.9ee21727cae72a5d52e3052d@linux-foundation.org>
In-Reply-To: <CAGM2reZ6PTYw3NivSCO5WMCrYGJH_-piz8TtYgpwLWT=SnBGYA@mail.gmail.com>
References: <20180607100256.GA9129@hori1.linux.bs1.fc.nec.co.jp>
        <20180613054107.GA5329@hori1.linux.bs1.fc.nec.co.jp>
        <20180613090700.GG13364@dhcp22.suse.cz>
        <20180614051618.GB17860@hori1.linux.bs1.fc.nec.co.jp>
        <20180614053859.GA9863@techadventures.net>
        <20180614063454.GA32419@hori1.linux.bs1.fc.nec.co.jp>
        <20180614213033.GA19374@techadventures.net>
        <20180615010927.GC1196@hori1.linux.bs1.fc.nec.co.jp>
        <20180615072947.GB23273@hori1.linux.bs1.fc.nec.co.jp>
        <20180615084142.GE24039@dhcp22.suse.cz>
        <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain>
        <20180618163616.52645949a8e4a0f73819fd62@linux-foundation.org>
        <CAGM2reZ6PTYw3NivSCO5WMCrYGJH_-piz8TtYgpwLWT=SnBGYA@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 16:05:04 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> > So I expect this patch needs a cc:stable, which I'll add.
> >
> > The optimiation patch seems less important and I'd like to hold that
> > off for 4.19-rc1?
> 
> Hi Andrew,
> 
> Should I resend the optimization patch [1] once 4.18 is released, or
> will you include it, and I do not need to do anything?
> 
> [1] http://lkml.kernel.org/r/20180615155733.1175-1-pasha.tatashin@oracle.com
> 

http://ozlabs.org/~akpm/mmots/broken-out/mm-skip-invalid-pages-block-at-a-time-in-zero_resv_unresv.patch
has been in -mm since Jun 18, so all is well.
