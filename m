Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE6FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AD620837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Odgfe4VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AD620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeICBJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 21:09:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32886 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeICBJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 21:09:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so7764554pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u+OBcL5rMV/K8y0qLFCjWMA+1PU4ot9UR0N5Vb5LiMU=;
        b=Odgfe4VVcmU4AWmy1q3d0RL37Ot+lc4YixWjPjxJmDEMfMJLC3FoU6ZHtp2VOA5nAC
         UFx+DwwXqULPj9fdbFfMpccfqe2JUtRycjtZS8i+slF0LeWki9/GFED8SyInOZiYMTiQ
         ezYaKjEL6Rd7CTGemOogIR7QOlS1FlhhxK1Y0GOg6eU6qYPPhesYp5ll+uRzwR5RZFI/
         x2tovgmOvhjTth/FX8q/CoaGW5h7LgWvg2+E7K0atn9h7xxyiT+Y+QwH9Dn+Gus4icSK
         yB1hZqtuuhyOsYZnJBqdY/Y8VkemRMhQgos+kdtpovbcVMG3pXvgLBXzBJ5IlhhJwK25
         YUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u+OBcL5rMV/K8y0qLFCjWMA+1PU4ot9UR0N5Vb5LiMU=;
        b=kykBV0486f8khXyFE1oNRX68aPVEVmmNqlfRuiL/Qt6fjNFti5rumX3aR5fzpz8zTy
         ZYDAZGljhR+T8P7hrayDAMyjX7N4HjsrOgNqb6TSkNLNMIpiDRPg80TJ9sXPlv+UaBcU
         3Ci33mBnFOPcrKLFXwY4c3HSpKrh/CR5Tc71Qt9O+F/D/lVGxt7gNM+FKVy47EjnBk7K
         h4am37NxABL6Xm/czjf+w3TtYGhVg0fa7FXIFMpaHOf5ZjscGtRdNPADYGHlQP7rq0Nc
         zEj4qfM/z6l+Vh9BDZ743bhydQ0ev/E9KuulkeZk+OqEKRSiY7VQ9yFfh18Ax2wIqJw4
         CHqg==
X-Gm-Message-State: APzg51C43rdi2ViqDoY6yzyCpRL2fNLa+UN1A1z2TsRlFd4bSHfMcxwV
        ie7Enh9uR4tyVuGrtLKP4+UWQg==
X-Google-Smtp-Source: ANB0VdZ8oeW2+XnP94FZPK3QVm/HiAB7xSJyrYWdW4Yb6tBqh4hZH/5V7ze7gIdJmyZ2h+onOpF01w==
X-Received: by 2002:a62:e511:: with SMTP id n17-v6mr25972432pff.210.1535921569023;
        Sun, 02 Sep 2018 13:52:49 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id 6-v6sm27549035pfs.58.2018.09.02.13.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 13:52:47 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E10A3300D89; Sun,  2 Sep 2018 23:52:42 +0300 (+03)
Date:   Sun, 2 Sep 2018 23:52:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/KASLR: Adjust the vmemmap size according to
 paging mode
Message-ID: <20180902205242.kcpt6wsatacahswp@kshutemo-mobl1>
References: <20180829021754.21850-1-bhe@redhat.com>
 <20180829021754.21850-2-bhe@redhat.com>
 <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
 <20180830152512.GE14702@192.168.1.2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830152512.GE14702@192.168.1.2>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:25:12PM +0800, Baoquan He wrote:
> Hi Kirill,
> 
> I made a new version according to your suggestion, just a little
> different, I didn't make 1TB as default, just calculate with the actual
> size, then align up to 1TB boundary.  Just found kcore is printing more
> entries than before, I thought it's caused by my code, later got it was
> touchde by other people.
> 
> Any comment about this? I can change accordingly.

Looks good to me.

But there's corner case when struct page is unreasonably large and
vmemmap_size will be way to large. We probably have to report an error if
we cannot fit vmemmap properly into virtual memory layout.

-- 
 Kirill A. Shutemov
