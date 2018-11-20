Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFE0C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B5A20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="oIg8ANg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B5A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbeKUAgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:36:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43949 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKUAgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:36:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so1042593pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fOgWAi0O2tc9zB8aSd5VFAaRe8eYerzgVbt612r4NZ8=;
        b=oIg8ANg7wQ/exYQkot06N8fRBsE2Ju++kbCxrDg/BSChoG5rt9BMuJwIyUJj917Eft
         XoHCYZXrsbdK1WtFNdxarLV5fq8CizUM3rPgFkYCmDXrKdmvfGigHJ2ziqyCVPl+1eFJ
         RYhz+jBcxyBQrclGgwSdFRobj6nzLfHG6Ex+Mly1pZ4tIAmNoErfOI5VwVMpXIstdiuK
         8qvXr93EU6luYB7XqBCZN48JRD/cG5/ckm1vm5xR/HENr13VWdZ5UEN0EtIWH8h6zqV5
         d4zZe7HTzVW5g76QO6wDpPZC3xiHTC4AsyrCAsxVKKg7XdObfBX5W18uzL+9oRpW1MCY
         aXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fOgWAi0O2tc9zB8aSd5VFAaRe8eYerzgVbt612r4NZ8=;
        b=l0BMtdcfUHX0POk8nH6vE0o7Q03qDLwI+21bX+yPGth23OjZVLk3wt514ywiwNw5Fk
         BfdRNCW4fJl5VRUW/L5/UDE/WTTRbE2DfraK3r0Rw7zbkcYLLTv/g1wdPhxZMlhzwQLP
         +I6XA88XqK0z7lguU+sAceQx/mb6qj3otrxqatOtJTBwAxYOyI3DpMZxWxqeba7t22SF
         40aYAAudhEUNe7ciZcyjmoqqS/xyo9cb5Tjwo5Rcjji3N1jZnlilPdseBUgsg/Vkgp8i
         SGro46c4ISkN41op8SFLlhqUJkz7/cOEUbQyZP/f0g3ARQhC+ukj804GarA+ihgBWRYo
         rrHA==
X-Gm-Message-State: AA+aEWaahxXoqFq+UP3khvHG4XQz+AemFMvaQrJPc+VdOs7Ol/rSWsbc
        M1kbMlFJhlfVv/siuWFwp5Sn9w==
X-Google-Smtp-Source: AFSGD/WSlZUjWgxK/mJ/VVJixGqMe8p7r/f8oXuREhDktsYhhKxUheKyVQZRAHkl/rerdsk6hVU5PA==
X-Received: by 2002:a63:de04:: with SMTP id f4mr2008851pgg.292.1542722841869;
        Tue, 20 Nov 2018 06:07:21 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id d6sm30886589pgc.89.2018.11.20.06.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 06:07:20 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 64EBE302653; Tue, 20 Nov 2018 17:07:15 +0300 (+03)
Date:   Tue, 20 Nov 2018 17:07:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
Message-ID: <20181120140715.mouc7okin3ht5krr@kshutemo-mobl1>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-4-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120134323.13007-4-mhocko@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:43:23PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> filemap_map_pages takes a speculative reference to each page in the
> range before it tries to lock that page. While this is correct it
> also can influence page migration which will bail out when seeing
> an elevated reference count. The faultaround code would bail on
> seeing a locked page so we can pro-actively check the PageLocked
> bit before page_cache_get_speculative and prevent from pointless
> reference count churn.

Looks fine to me.

But please drop a line of comment in the code. As is it might be confusing
for a reader.

-- 
 Kirill A. Shutemov
