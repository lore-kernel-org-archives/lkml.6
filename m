Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0721C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0B020820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcRg1IaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0B020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408697AbeKWTYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:24:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37160 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393776AbeKWTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:24:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so11484857wru.4;
        Fri, 23 Nov 2018 00:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ZSYLab7HY9XRC3GBGk1/q+DxHiRagL9mfUqeZT0uzM=;
        b=hcRg1IaV0Z9lOZ9xCNh6/H2i0W8qaeykFNPnOzCKqsjSm4v7ycQVNsQMuDszZaUT5y
         XfxFy3mijO9FxtD+XfaWYH+H54x3tCgDahsHKMyIdzRlxI4gP9Wc6G4K8354T4duoOWg
         XJHszepvlsI1Bp33MY0EofFQD3HSEIl9U+7hLqcEGTE1KmMnA/SDr5kf8sM48FjIvFRF
         eP2j9B9a4TYZF9lbYgZ8SsEQBpfeht1OmxpV5ipShivGezDUUWsRG1eeGTXPWpt0c87U
         szPtP2+UvTlQoQW9l4nNkmbAroADuodklG+0j3g9ar8y8xYeilG+Aliaf94IMXdbtcNt
         AbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ZSYLab7HY9XRC3GBGk1/q+DxHiRagL9mfUqeZT0uzM=;
        b=rG/OPP0HF1ykrl2VxvIvYaKyAX+2n4ylKg+nBUIRqdUS59KDOAk5OhdBw/t5tJK+BJ
         PRCEc0Q8w4Qx/W+kBegIhset4dTmDYM7Kr6d+VlkXBrq3mBEym1SRXeKuAUuw+mDf0Ym
         SSah15sl7rD2NCeJKwirc6l9mUpGKMc3Mc+c+YlWb3ToTWA3ZJt5Bk60ZZUE9KMYYEIu
         W4XJr0RZqV4+hCKCZFrClf6a6skFLS1XzFTZg+wYhd2r4Veknb0OAG7Vvxw0l/O/RKMT
         IaIjjhrD+Iv4ZfMqvEPpf2mMsFcKiWThLydjBnJVEj4K5vwt7amBak5eostU3snlZCC9
         zhEA==
X-Gm-Message-State: AA+aEWapz+sz8ovccw94qJptaB9/SYwpHc9LGpMf8mP3lraKeNNp9YbH
        yDbiiOkcpeqqAJknKO3E4JM=
X-Google-Smtp-Source: AFSGD/WNmCB7Fv+KnIYTSI5yYP4Z8KgpPkIz5o3V8aSizK9J1ojie+ZqhQYmHNrZomqvrxaBJrqgYw==
X-Received: by 2002:adf:bb44:: with SMTP id x4mr13407472wrg.24.1542962481093;
        Fri, 23 Nov 2018 00:41:21 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c13sm17717467wrb.38.2018.11.23.00.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 00:41:20 -0800 (PST)
Date:   Fri, 23 Nov 2018 09:41:17 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
Message-ID: <20181123084117.GA130228@gmail.com>
References: <20181121202811.4492-1-babu.moger@amd.com>
 <20181121202811.4492-2-babu.moger@amd.com>
 <20181123072839.GA51597@gmail.com>
 <20181123082258.GA30697@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123082258.GA30697@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Nov 23, 2018 at 08:28:39AM +0100, Ingo Molnar wrote:
> > Ugh, violent NAK on this unreadable directory naming: 'resctrl' is an 
> > ugly double/triple abbreviation that nobody recognizes for what it is to 
> > begin with, and even the long form 'resource control' is an overly 
> > generic naming - *everything* the kernel does is in essence 'resource 
> > control' ...
> 
> Well, the fs this thing uses is called "resctrl".
> 
> Documentation/x86/resctrl_ui.txt:1075:the resctrl will still mount but cannot create CTRL_MON directories.
> Documentation/x86/resctrl_ui.txt:1082:# mount -t resctrl resctrl /sys/fs/resctrl
> Documentation/x86/resctrl_ui.txt:1083:# cd /sys/fs/resctrl
> 
> Are you saying that the fs should be renamed now too?

Sigh, probably not. I only noticed this naming snafu with the renaming 
commit. The high level name was always RDT-ish - which while an acronym 
is at least is a familiar high level name now with no obvious generic 
namespace collision, while 'resctrl' less so.

> How are those *abbreviations* better? "hw_bw" is especially cryptic and 
> the others are no better.

Those were suggestions - but I'd be fine with 'resource_control':

> "resctrl" to mean "resource control" is much better IMO.

Then at least make the directory name resource_control/, which is only 
marginally longer and a lot more readable.

We really don't have to fit directly names into the 8 character DOS limit 
anymore. ;-)

> [...] And it is different from the "other" resource controlling the 
> kernel does because it is under arch/x86/kernel/cpu/ which tells you it 
> is a *CPU* resource control.

Yeah, so this is not obvious from the filesystem name, nor does it excuse 
the pointless abbreviation.

High level names matter.

Also, the Kconfig space, when it gets extended with the AMD bits, should 
probably follow the same nomenclature: CONFIG_X86_CPU_RESOURCE_CONTROL=y 
or such.

	Ingo
