Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /4KrKhbVGVsLVQAAmS7hNA
	; Fri, 08 Jun 2018 01:00:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8B9466074D; Fri,  8 Jun 2018 01:00:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="en6B6tRM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0D21F606DD;
	Fri,  8 Jun 2018 01:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D21F606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbeFHBAC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:00:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeFHA74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cGo64+aYU0ET3IX9k6ZFGvrPUwXgZXTkpobwYKE2Z58=; b=en6B6tRMmecShKgyvcV9ecYqcM
        dgnMeAUBUUeAhj5avfNYtBXjk8sSy0TxgeZSPgjdWAiisBsUaHNehdsPRkPxlvSXbLizGL4BFVAv/
        CIzYzLFdMC03h7k+C8vw2qGzEVs/k6wp7E8WsZ+JxA5r6MmAg8IEXlEfokpyP2emFnSUFRtf5U8rT
        SMIXY0NRplDoA5vtKGcbFSZQwKOmUa1UMgjabuZweQzDhz8jCTRD5XrPJNuHfWgMyFhfrLjCf44eK
        d4tMsXcArNTRKBOqdGGWvm9KSBW5Tip1sN4felSMBJQpavK22buuufI6GI0g1rF+4X/1YghUEv5YZ
        jH5SUcfQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fR5kt-00048U-5W; Fri, 08 Jun 2018 00:59:51 +0000
Subject: Re: mmotm 2018-06-07-16-59 uploaded (fs/fat/ and fs/dax/)
To: akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20180607235947.xWQtg%akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d9fbe5c-7865-dfd1-ce7a-7b2ceaa000fa@infradead.org>
Date: Thu, 7 Jun 2018 17:59:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607235947.xWQtg%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 04:59 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-06-07-16-59 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 

(on i386:)

../fs/fat/inode.c: In function '__fat_get_block':
../fs/fat/inode.c:162:3: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'sector_t' [-Wformat=]
   fat_fs_error(sb,
   ^


../fs/dax.c: In function 'dax_load_hole':
../fs/dax.c:1031:2: error: 'entry2' undeclared (first use in this function)
  entry2 = dax_insert_mapping_entry(mapping, vmf, entry, pfn,
  ^


Easy fixes... :)
-- 
~Randy
