Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5FAC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDD2273D2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDD2273D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965822AbeF1NIJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:08:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38274 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964854AbeF1NIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:08:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so5466229wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 06:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pTAd3Wifb2BTH9k7e9mrDEK3qwXFVKZqKh06WYoypd8=;
        b=k2GnUgBaR2XFzh0s90gE3BKoZS8C2MuYT+Tco5ADMKEYzwflCn90HGsC4VNrGylToC
         xaB2/MGgvIhLx8BTtOM7bDLaVi1JIiK1fv4CwsIeG7hHgu24ykyuKJNAoyzvT99MScSv
         W2Plvmx16Y2WwEFG0JNEzXP/L9JX0nMMK/uz7WDYKCLyttzIj9oulapUWJRFpNCbQqre
         KeUmsVt/YDbRuJ2yvmg7ri/vyePUQVIw/7xpSC9FUdymK1PKpNgf4UqFufhRnXxVi5Nu
         mZDDum62uWm7FY+O4NiWNBDpl+ITH0UAaIKB+O9GXDk2wtTDTltBqM0LzhsqMtRjRg39
         ytPg==
X-Gm-Message-State: APt69E2AGMlnaawoob9kSYBrhjseqs+klUE9u0AwNvbtY79foK6wYR0H
        5FYDxIydKvOfA6vsHozs8a0=
X-Google-Smtp-Source: AAOMgpehHrvhR6wJ+b12H9b1aQgq4frFVtDY7jFdPmNUJ5mOeNlR86O6nl5X6TFbuiORMQmuZ0Qsvg==
X-Received: by 2002:adf:81c5:: with SMTP id 63-v6mr5821027wra.88.1530191286530;
        Thu, 28 Jun 2018 06:08:06 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id k17-v6sm7717428wrp.19.2018.06.28.06.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 06:08:05 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id A2C3D123918; Thu, 28 Jun 2018 15:08:04 +0200 (CEST)
Date:   Thu, 28 Jun 2018 15:08:04 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v6 3/5] mm/sparse: Add a new parameter 'data_unit_size'
 for alloc_usemap_and_memmap
Message-ID: <20180628130804.GA13985@techadventures.net>
References: <20180628062857.29658-1-bhe@redhat.com>
 <20180628062857.29658-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628062857.29658-4-bhe@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 02:28:55PM +0800, Baoquan He wrote:
> alloc_usemap_and_memmap() is passing in a "void *" that points to
> usemap_map or memmap_map. In next patch we will change both of the
> map allocation from taking 'NR_MEM_SECTIONS' as the length to taking
> 'nr_present_sections' as the length. After that, the passed in 'void*'
> needs to update as things get consumed. But, it knows only the
> quantity of objects consumed and not the type.  This effectively
> tells it enough about the type to let it update the pointer as
> objects are consumed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
