Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40775C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2EA2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2EA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJWMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:25:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:53992 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeJWMZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:25:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 21:04:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,414,1534834800"; 
   d="scan'208";a="102452794"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga002.jf.intel.com with ESMTP; 22 Oct 2018 21:03:56 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8D24F301004; Mon, 22 Oct 2018 21:03:56 -0700 (PDT)
Date:   Mon, 22 Oct 2018 21:03:56 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
Message-ID: <20181023040356.GA6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <1775744.0RuD2nMEIt@agathebauer>
 <87o9bmrsli.fsf@linux.intel.com>
 <2679413.U8bCfAhSQu@agathebauer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2679413.U8bCfAhSQu@agathebauer>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So what if my libm wasn't compiled with -fasynchronous-unwind-tables? We 

It's default (64bit since always and 32bit now too) Unless someone disabled it.

However libm might be partially written in assembler and hand written assembler
often has problems with unwind tables because the programmer has to get them
correct explicitely.

-Andi
