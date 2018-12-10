Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5D92086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5D92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeLJNSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:18:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:27199 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeLJNSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:18:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 05:18:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,338,1539673200"; 
   d="scan'208";a="109180030"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2018 05:18:44 -0800
Subject: Re: [PATCH] perf auxtrace: Alter addr_filter__entire_dso() to work if
 there are no symbols
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20181127084634.12469-1-adrian.hunter@intel.com>
 <20181127124226.GC15747@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <67587a92-200c-ac7a-67bd-20df06cdd41b@intel.com>
Date:   Mon, 10 Dec 2018 15:17:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181127124226.GC15747@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/18 2:42 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 27, 2018 at 10:46:34AM +0200, Adrian Hunter escreveu:
>> addr_filter__entire_dso() uses the first and last symbols from a dso,
>> and so does not work when there are no symbols.  Alter it to filter the
>> whole file instead.
> 
> I'm splitting this patch into a first prep one that renames and exports
> the static function dso__data_file_size() and a second that does what
> this commig log message states.
> 
> The reason is that sometimes we find out that the main part of the patch
> is wrong and we then decide to revert the patch, only to realize that
> the exported function is by that time already used elsewhere.

Thanks for looking at this, but did it get lost?  I don't see it in your tree.
