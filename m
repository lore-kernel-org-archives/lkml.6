Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6821AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F143820839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGw0vHKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F143820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeIKO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:27:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40513 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeIKO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:27:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so25003419wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 02:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1njNPne0Rl28S91VcycHBzGbWXnYOUQMXUJBEVmGpfM=;
        b=KGw0vHKpdWPY1b/Y5Ymc4hkZk5Dgmo2welewj8LRbT/9+Da9PLv4B6WK+vfsxvPJCV
         wRmKSqHcJG+EDfwHWIkdxLbEddpx92c/ioOxwalCRRlfOHDPslVJW6ofBZu1X3eshifQ
         sfuZ0Jn3fhag8xnS+8TpkAWSqepUGBoDP1sYoozGTq/C1IZhPfl0IM25xOFbKelfY1fE
         7lNzQRTT6EuduGmN9YnYlcxdKcYPNRzhuB8Y3jVrSiYzU+TUvvKvQYPlPzNsbtlv+iku
         /qGQXrjIWzWV2GVR+3UoXcTRXPYDmYNmGGdiIXq3TH4NqgCTWXX+PaQy0MVjIBzGiIok
         JFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1njNPne0Rl28S91VcycHBzGbWXnYOUQMXUJBEVmGpfM=;
        b=OiD9AQOdm9OEVI9pWLm+EJGkB25eaq73C7pbjnuhENDouyEBxExTao3mqFPEHe9mFp
         cgvdW/T4ddvqlLvNMIp5b9nxavyggbmDSkAkuRvC3YKTzsbOTyMiFeFFBsNuLiDDVwPL
         TKXmRcppCekHNzJYGKEQ2PjClZE6F4Pzl03+vzkRToi1h/HDIC2RZ0Bqfp3aSsOYNZIZ
         bqqMhH/BaJzHM1S5pvezoDdsd5OOlxWF88sNbIQYdO0xOeQJSUZqWEPks82Fa0mWsiNH
         zDc1CWNSHWJTDNVv/7wYsl5Z5eiw7Hae4WBAt0NhKjG6JQWDrWKGI6O7Sk7lUtpG9bK5
         Mz0A==
X-Gm-Message-State: APzg51BAKj+jJI5GYp2KbehdCL+BR3PgFOVUnLpns1lkChfaXWtkc7Ze
        PDwBYg7Y8eh3kMAGjseS3L8=
X-Google-Smtp-Source: ANB0VdYbeukGy7vWfkkxjy+xf6AM6+cWaKNxwOFncATjjWMopH8gU1tBA9mEq9X/x513cSWSbkgiAw==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr747086wmd.36.1536658112337;
        Tue, 11 Sep 2018 02:28:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l7-v6sm22615940wrt.67.2018.09.11.02.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 02:28:31 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:28:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/3] x86/mm/KASLR: Calculate the actual size of
 vmemmap region
Message-ID: <20180911092829.GA9079@gmail.com>
References: <20180909124946.17988-1-bhe@redhat.com>
 <20180909124946.17988-2-bhe@redhat.com>
 <20180910061151.GA85199@gmail.com>
 <20180911073057.GW1740@192.168.1.3>
 <20180911075946.GA97454@gmail.com>
 <20180911081811.GY1740@192.168.1.3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911081811.GY1740@192.168.1.3>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> On 09/11/18 at 09:59am, Ingo Molnar wrote:
> > 
> > * Baoquan He <bhe@redhat.com> wrote:
> > 
> > >  /*
> > > + * Memory regions randomized by KASLR (except modules that use a separate
> > > + * logic earlier during boot). Currently they are the physical memory
> > > + * mapping, vmalloc and vmemmap regions, are ordered based on virtual
> > > + * addresses. The order is kept after randomization.
> > > + *
> > > + * @base: points to various global variables used by the MM to get the
> > > + * virtual base address of the above regions, which base addresses can
> > > + * thus be modified by the very early KASLR code to dynamically shape
> > > + * the virtual memory layout of these kernel memory regions on a per
> > > + * bootup basis.
> > > + *
> > > + * @size_tb: size in TB of each memory region. Thereinto, the size of
> > > + * the physical memory mapping region is variable, calculated according
> > > + * to the actual size of system RAM in order to save more space for
> > > + * randomization. The rest are fixed values related to paging mode.
> > >   */
> > >  static __initdata struct kaslr_memory_region {
> > >  	unsigned long *base;
> > 
> > LGTM mostly, except the @size_tb field, see my comments further below.
> > 
> > Here's an edited version:
> > 
> > /*
> >  * 'struct kasl_memory_region' entries represent continuous chunks of
> >  * kernel virtual memory regions, to be randomized by KASLR.
> >  *
> >  * ( The exception is the module space virtual memory window which
> >  *   uses separate logic earlier during bootup. )
> >  *
> >  * Currently there are three such regions: the physical memory mapping,
> >  * vmalloc and vmemmap regions.
> >  *
> >  * The array below has the entries ordered based on virtual addresses.
> >  * The order is kept after randomization, i.e. the randomized
> >  * virtual addresses of these regions are still ascending.
> >  *
> >  * Here are the fields:
> >  *
> >  * @base: points to a global variable used by the MM to get the
> >  * virtual base address of any of the above regions. This allows the
> >  * early KASLR code to modify these base addresses early during bootup,
> >  * on a per bootup basis, without the MM code even being aware of whether
> >  * it got changed and to what value.
> >  *
> >  * When KASLR is active then the MM code makes sure that for each region
> >  * there's such a single, dynamic, global base address 'unsigned long'
> >  * variable available for the KASLR code to point to and modify directly:
> 
> >  *
> >  *       { &page_offset_base, 0 },
> >  *       { &vmalloc_base,     0 },
> >  *       { &vmemmap_base,     1 },
> >  *
> >  * @size_tb: size in TB of each memory region. Thereinto, the size of
> >  * the physical memory mapping region is variable, calculated according
> >  * to the actual size of system RAM in order to save more space for
> >  * randomization. The rest are fixed values related to paging mode.
> >  */
> > 
> > The role of @size_tb is still murky to me. What is it telling us?
> > Maximum virtual memory range to randomize into? Why does this depend
> > on system RAM at all - aren't these all virtual addresses in a 64-bit
> > (well, 48-bit or 56-bit) address ranges?
> 
> * @size_tb: size in TB of each memory region. Thereinto, the size of
> * the physical memory mapping region is variable, calculated according
> * to the actual size of system RAM. Since most of systems own RAM memory
> * which is much less than 64 TB which is reserved for mapping the maximum
> * physical memory in 4-level paging mode, not to mention 5-level. The
> * left space can be saved to enhance randomness.
> * 
> How about this?

Yeah, so proper context is still missing, this paragraph appears to assume from the reader a 
whole lot of prior knowledge, and this is one of the top comments in kaslr.c so there's nowhere 
else to go read about the background.

For example what is the range of randomization of each region? Assuming the static, 
non-randomized description in Documentation/x86/x86_64/mm.txt is correct, in what way does 
KASLR modify that layout?

All of this is very opaque and not explained very well anywhere that I could find. We need to 
generate a proper description ASAP.

> And please forgive my poor english.

No problem, I can prettify it afterwards, but the information is not there yet to prettify. :)

Thanks,

	Ingo
