Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA02DECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFF82082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6EFay2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFF82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeJYCDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:03:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38490 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYCDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:03:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id k11-v6so5556334lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZNMS/0SElteE5DMFcl4q7SK1zlZywytc9UeqPEkCgKQ=;
        b=Q6EFay2T/llcRGgWur1HYqHpHBx57rO9WOq2xQKetpk6saWVoFR6WfM+Y1lu5Ce8gG
         E1aJc422BYtX4opykHBat60BXHu6Ui8oIeFOzs6DWQk3XQeODd/sppWt2u5LHMIVnKl8
         bCyRo/Buv5GAoj9MgsOxjPkje1pnMaGl4Vfq3i0qeV+GfJEsiSuQoJf9zgOznW5yJ8VA
         AJMgNxXVL7if4ciHDK94oPKLrLw8zFl+55tT7DOdw3aGg0/vSqCAvLlPhZYICj0dgiW6
         PIXlnlvL2MLP3/AsB8jFebY2afNCtCpW7OnguBqlc5uAGWgJGCD3uZrT0Z8R9w4VazIu
         aevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZNMS/0SElteE5DMFcl4q7SK1zlZywytc9UeqPEkCgKQ=;
        b=qe3YKygbIrp05YCL5IMsBu2z5eTPTF6kG9Ilm5pGW/oDY5RFAGEZ9W3Ft2vgqUGBgg
         mAGdmEhawMcYZdih3pHpmFMwsNCHi2MslR/3jyp0uPhBhIzhUEz3CGJP5+T3Q9N29l/q
         483YsWeopNjYttAT/J3Vn4aGsxzw1n0evtWI5W63Qh3xO9Utq6KXilP7NZyjFFQ9n2CF
         K3wIZMyfVhzYy2Nzb8ufYv3OAputHGnXBx7V4SzWk9hO06Z73veX+i0V/gtb8tpUtDdA
         lLxZfjZNLzqIP7fleSh8895Lkquhk9S6fB7rKe+fo8v+3OCygep7LKMPfLVrtwsrbl9r
         JpVA==
X-Gm-Message-State: AGRZ1gIEZGyZJ9uYdW0M2Cm/emXJoF+rM0vbMovxBF9aWYvo4Ugc7sPk
        FClto0FvOcAh1yrtNOu2I2E=
X-Google-Smtp-Source: AJdET5d+kMYByne0kt6PZlWRCMdNnXuiPHSH/5Fi8ViVmMpC23Lt2B4OGAFaIqVN7GGk3DFZfO4vBw==
X-Received: by 2002:a2e:810e:: with SMTP id d14-v6mr2451781ljg.170.1540402467144;
        Wed, 24 Oct 2018 10:34:27 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id n16-v6sm753840lji.28.2018.10.24.10.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 10:34:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 24 Oct 2018 19:34:18 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        maco@android.com
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181024173418.2bxkdjbcyzfkgfeu@pc636>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181022125142.GD18839@dhcp22.suse.cz>
 <20181022165253.uphv3xzqivh44o3d@pc636>
 <20181023072306.GN18839@dhcp22.suse.cz>
 <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
 <20181023152640.GD20085@bombadil.infradead.org>
 <20181023170532.GW18839@dhcp22.suse.cz>
 <98842edb-d462-96b1-311f-27c6ebfc108a@kernel.org>
 <20181023193044.GA139403@joelaf.mtv.corp.google.com>
 <20181024062252.GA18839@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024062252.GA18839@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, Oct 24, 2018 at 08:22:52AM +0200, Michal Hocko wrote:
> On Tue 23-10-18 12:30:44, Joel Fernandes wrote:
> > On Tue, Oct 23, 2018 at 11:13:36AM -0600, Shuah Khan wrote:
> > > On 10/23/2018 11:05 AM, Michal Hocko wrote:
> > > > On Tue 23-10-18 08:26:40, Matthew Wilcox wrote:
> > > >> On Tue, Oct 23, 2018 at 09:02:56AM -0600, Shuah Khan wrote:
> > > > [...]
> > > >>> The way it can be handled is by adding a test module under lib. test_kmod,
> > > >>> test_sysctl, test_user_copy etc.
> > > >>
> > > >> The problem is that said module can only invoke functions which are
> > > >> exported using EXPORT_SYMBOL.  And there's a cost to exporting them,
> > > >> which I don't think we're willing to pay, purely to get test coverage.
> > > > 
> > > > Yes, I think we do not want to export internal functionality which might
> > > > be still interesting for the testing coverage. Maybe we want something
> > > > like EXPORT_SYMBOL_KSELFTEST which would allow to link within the
> > > > kselftest machinery but it wouldn't allow the same for general modules
> > > > and will not give any API promisses.
> > > > 
> > > 
> > > I like this proposal. I think we will open up lot of test opportunities with
> > > this approach.
> > > 
> > > Maybe we can use this stress test as a pilot and see where it takes us.
> > 
> > I am a bit worried that such an EXPORT_SYMBOL_KSELFTEST mechanism can be abused by
> > out-of-tree module writers to call internal functionality.
> > 
> > How would you prevent that?
> 
> There is no way to prevent non-exported symbols abuse by 3rd party
> AFAIK. EXPORT_SYMBOL_* is not there to prohibid abuse. It is a mere
> signal of what is, well, an exported API.
> -- 
> Michal Hocko
> SUSE Labs

Can we just use kallsyms_lookup_name()?

<snip>
static void *((*__my_vmalloc_node_range)(unsigned long size,
    unsigned long align,unsigned long start, unsigned long end,
    gfp_t gfp_mask,pgprot_t prot, unsigned long vm_flags,
    int node, const void *caller));

__my_vmalloc_node_range = (void *) kallsyms_lookup_name("__vmalloc_node_range");
<snip>

--
Vlad Rezki
