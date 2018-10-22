Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63717C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF6920651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF6920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeJVWRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:17:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:50867 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbeJVWRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:17:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 06:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,412,1534834800"; 
   d="scan'208";a="83456209"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2018 06:58:17 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9EAD0301004; Mon, 22 Oct 2018 06:58:17 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Milian Wolff <mail@milianw.de>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
References: <2335309.gnWok9HYb4@agathebauer> <3129539.p6j0Z5hDSJ@agathebauer>
        <1775744.0RuD2nMEIt@agathebauer>
Date:   Mon, 22 Oct 2018 06:58:17 -0700
In-Reply-To: <1775744.0RuD2nMEIt@agathebauer> (Milian Wolff's message of "Mon,
        22 Oct 2018 13:17:42 +0200")
Message-ID: <87o9bmrsli.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:
>
> After more digging, it turns out that I've apparently chased a red herring. 
> I'm running archlinux which isn't shipping debug symbols for libm.

64bit executables normally have unwind information even when stripped.
Unless someone forcefully stripped those too.

You can checkout with objdump --sections.

-Andi
