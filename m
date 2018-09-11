Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE0C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA67120839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA67120839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeIKULR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:11:17 -0400
Received: from foss.arm.com ([217.140.101.70]:45082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbeIKULQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:11:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C04CDED1;
        Tue, 11 Sep 2018 08:11:32 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 904003F614;
        Tue, 11 Sep 2018 08:11:32 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 211AD1AE3231; Tue, 11 Sep 2018 16:11:49 +0100 (BST)
Date:   Tue, 11 Sep 2018 16:11:49 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: Re: [PATCH 0/6] Tracing register accesses with pstore and dynamic
 debug
Message-ID: <20180911151148.GI2651@arm.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
> This patch series adds Event tracing support to pstore and is continuation
> to the RFC patch introduced to add a new tracing facility for register
> accesses called Register Trace Buffer(RTB). Since we decided to not introduce
> a separate framework to trace register accesses and use existing framework
> like tracepoints, I have moved from RFC. Details of the RFC in link below:
> 
> Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan@codeaurora.org/

The arm64 backend bits look fine to be, but they're mixed up with core
changes that I haven't looked at closely.

Will
