Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10637C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD9220861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX/GzxTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD9220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393493AbeKWSLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:11:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36456 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbeKWSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:11:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so11312388wrr.3;
        Thu, 22 Nov 2018 23:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wC5ZqndZQIxNUggB3kL/Xa14uyqtAP7NRLqGuJMPh/U=;
        b=ZX/GzxTfL8jPQm1hFB+I93oi7CY4NaDOfbbv2dB11cZrLq9BmwA1HKMMLtUF0TDDSX
         nP1Se6KDoE47B4q7WlasRa7W7vUxfUoKiKsF9ScBxsv8tinZiy0nLcIQ9PKAnRpCddws
         WpNs0t4D4UAVqINMfcSl3rsnFYxyNnwlASxf/MSCSun04yQylv51ah+QDa9HXics1XmP
         9cmHBWMKzpGm4SlRMzHop5cTVqmmfzn4fxajm9yY8mVXcxrQl/wmUGfpAH9LlgUQ6mkU
         eAGDRJ9Ha8aU+V0XRseaegqn7hh5mPFRjr9mnQg6d7RdcEkQFyv8nYfaYDEPxsF0vLZI
         HufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wC5ZqndZQIxNUggB3kL/Xa14uyqtAP7NRLqGuJMPh/U=;
        b=WibSay21qhssy89Fj5Rt1iORdm+EXmFS9TYIszU+xyL1O9sIE2lyYaI2gyCgLS7PNM
         xVLtefdQMt9LC/HkZKwiqWPdf0jl6N5wf3Idp/53PeC+Dx5iYRbnqDos+2qWbTBJMTw/
         XihJWWryg9RB4FIGWQM79EETe2YQ+fEvquihjQ6ieyFi4/QpOLczZdI1r+8pp5FauOsg
         fETTXvCqIn2zJiSLNmFHknCyQOw2XYgFYApOvrjhphfMzCrsPofRzWfQNxyfmL6WiB+p
         Ntq43yjVwxJnBDLPIP5hNxsERACiYogMZTqJvBqaQSoa+BCCaPGRIygaxdDpw89uGZn+
         oRxw==
X-Gm-Message-State: AA+aEWZa0Bo2LOyB0H82YoYoayxNBDjrZkVTu5JEOTKu89VxqxV0vZoS
        7Y/INnMdZFhFxo1MTr9+Npc=
X-Google-Smtp-Source: AFSGD/VbjYRhr+uCybNwHRMQoxXusILHHTUjWyQsm+/VDfAjUySw+uSXTqbyPoW5O0Kj2P5N+giXBA==
X-Received: by 2002:adf:e509:: with SMTP id j9mr13255140wrm.76.1542958123064;
        Thu, 22 Nov 2018 23:28:43 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w18sm14536391wru.54.2018.11.22.23.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 23:28:42 -0800 (PST)
Date:   Fri, 23 Nov 2018 08:28:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 01/13] x86/resctrl: Rename and move rdt files to new
 directory
Message-ID: <20181123072839.GA51597@gmail.com>
References: <20181121202811.4492-1-babu.moger@amd.com>
 <20181121202811.4492-2-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121202811.4492-2-babu.moger@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Moger, Babu <Babu.Moger@amd.com> wrote:

> New generation of AMD processors start supporting RDT(or QOS)
> features. Together these features will be called as RESCTRL.
> With more than one vendors supporting these features, it seems
> more appropriate to rename these files.
> 
> Create a new directory with the name 'resctrl' and move all the
> intel_rdt files to the new directory. This way all the resctrl
> related code resides inside one directory.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  .../x86/include/asm/{intel_rdt_sched.h => resctrl_sched.h} | 0
>  arch/x86/kernel/cpu/Makefile                               | 5 +----
>  arch/x86/kernel/cpu/resctrl/Makefile                       | 7 +++++++
>  arch/x86/kernel/cpu/{intel_rdt.c => resctrl/core.c}        | 4 ++--
>  .../cpu/{intel_rdt_ctrlmondata.c => resctrl/ctrlmondata.c} | 2 +-
>  arch/x86/kernel/cpu/{intel_rdt.h => resctrl/internal.h}    | 6 +++---
>  .../kernel/cpu/{intel_rdt_monitor.c => resctrl/monitor.c}  | 2 +-
>  .../cpu/{intel_rdt_pseudo_lock.c => resctrl/pseudo_lock.c} | 6 +++---
>  .../pseudo_lock_event.h}                                   | 2 +-
>  .../cpu/{intel_rdt_rdtgroup.c => resctrl/rdtgroup.c}       | 4 ++--
>  arch/x86/kernel/process_32.c                               | 2 +-
>  arch/x86/kernel/process_64.c                               | 2 +-
>  12 files changed, 23 insertions(+), 19 deletions(-)
>  rename arch/x86/include/asm/{intel_rdt_sched.h => resctrl_sched.h} (100%)
>  create mode 100644 arch/x86/kernel/cpu/resctrl/Makefile
>  rename arch/x86/kernel/cpu/{intel_rdt.c => resctrl/core.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c => resctrl/ctrlmondata.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt.h => resctrl/internal.h} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_monitor.c => resctrl/monitor.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c => resctrl/pseudo_lock.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h => resctrl/pseudo_lock_event.h} (95%)
>  rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c => resctrl/rdtgroup.c} (99%)

Ugh, violent NAK on this unreadable directory naming: 'resctrl' is an 
ugly double/triple abbreviation that nobody recognizes for what it is to 
begin with, and even the long form 'resource control' is an overly 
generic naming - *everything* the kernel does is in essence 'resource 
control' ...

So please find some better name and standardize the namespace around it. 
A couple of suggestions:

 -    'Hardware Quality of Service', i.e. HW_QOS, hw_qos
 - or 'CPU bandwidth control',       i.e. CPU_BW, cpu_bw
 - or 'Hardware Bandwidth Control',  i.e. HW_BW,  hw_bw

etc.

Thanks,

	ngo
