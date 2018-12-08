Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 07:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7A621104
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 07:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0uE8XnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7A621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeLHHHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 02:07:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40996 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLHHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 02:07:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so5718344wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 23:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bJXpQ6/tY78A76YIpx1xclmZs77GaNTaxMxQLUrdPWw=;
        b=P0uE8XnQArYP78Rlknqdozh6kJilrFV+2GplIUboJM/or16TenWNn4ZCk6lvCcz5l/
         +DmkxZWtbr68EMjCq5hadSvoTIHukRfB6JpeIpSM9JYQQOrWVRUpLDEdaKDZ1naF56UT
         T5pOfAKiACcnC8LzSUbUXtMjzHGeDjDV2y9dZpTKcOZDxKNxbaURdFShfOTMofk08DDR
         2hn9LWm6IPYpUIyh0BtBeheIovqi8g2fobVw3tBUw6Ym+SOsIwH3gLUohXbJAakfw9n2
         J+OSwRD/MHSwNYdTt73IZ/gpaIKGLjzmwoZeU8BuSg0Ys359kT4203s1jout5EuMONnH
         2LHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJXpQ6/tY78A76YIpx1xclmZs77GaNTaxMxQLUrdPWw=;
        b=D9nyx7SkG2tSZsls+/IsDU8TpHLifxDo6t9zbxI3F8Rrjm1f2N5SnoK4itKy1UcwQt
         Rfev5PEea+hQ0RjCPCW+BCEd79UjVVeF8zjlU8+mri5LKU3qbc9oQRaVpICjBaTJMz7U
         B0/grKQo4gtVheQhDExqFsb5IdQ37HtQZ/TYctA3s89aWRGOrI2+Ha2NJa1olvApZ5gv
         WbNcw5jKErBU9WVGm+s5DHk7Qd+8kxGrccmdhKqtR0w9w6Y3Z7IBX1SLjDiVC2cPtA1z
         o9dX1C8PDp/WK/j6CDXRIlmZjThyUdpNZrcCFK4UHNe0NlV/XFww6XmuHg3RcbTnxV+P
         mSaQ==
X-Gm-Message-State: AA+aEWbEv9BLA9u8qkjGakVNeSC1giDItZ69rIn3d4tZQApzaYhmwnr/
        AYVqpYSqGtUClj2IHIy+ZUAcwbKZfw==
X-Google-Smtp-Source: AFSGD/XtacPUh8KlpgBM77UEqrA7/bLmme1eYjQkviBndOw3QUcNm/DJLNCS6RUnUzjiXOC/fx93Iw==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr3728278wrq.5.1544252840014;
        Fri, 07 Dec 2018 23:07:20 -0800 (PST)
Received: from localhost (host34-126-dynamic.27-79-r.retail.telecomitalia.it. [79.27.126.34])
        by smtp.gmail.com with ESMTPSA id g129sm5432736wmf.39.2018.12.07.23.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 23:07:19 -0800 (PST)
Date:   Sat, 8 Dec 2018 08:07:18 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: x86_64: blacklist non-attachable interrupt
 functions
Message-ID: <20181208070718.GA2237@Dell>
References: <20181206095648.GA8249@Dell>
 <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
 <20181208010120.c3eda9042912068aecc68317@kernel.org>
 <20181207170026.GA1379@Dell>
 <20181208124210.7f46eb88544e2e3899713052@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208124210.7f46eb88544e2e3899713052@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 12:42:10PM +0900, Masami Hiramatsu wrote:
> On Fri, 7 Dec 2018 18:00:26 +0100
> Andrea Righi <righi.andrea@gmail.com> wrote:
> 
> > On Sat, Dec 08, 2018 at 01:01:20AM +0900, Masami Hiramatsu wrote:
> > > Hi Andrea and Ingo,
> > > 
> > > Here is the patch what I meant. I just ran it on qemu-x86, and seemed working.
> > > After introducing this patch, I will start adding arch_populate_kprobe_blacklist()
> > > to some arches.
> > > 
> > > Thank you,
> > > 
> > > [RFC] kprobes: x86/kprobes: Blacklist symbols in arch-defined prohibited area
> > > 
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Blacklist symbols in arch-defined probe-prohibited areas.
> > > With this change, user can see all symbols which are prohibited
> > > to probe in debugfs.
> > > 
> > > All archtectures which have custom prohibit areas should define
> > > its own arch_populate_kprobe_blacklist() function, but unless that,
> > > all symbols marked __kprobes are blacklisted.
> > > 
> > > Reported-by: Andrea Righi <righi.andrea@gmail.com>
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > 
> > [snip]
> > 
> > > +int kprobe_add_ksym_blacklist(unsigned long entry)
> > > +{
> > > +	struct kprobe_blacklist_entry *ent;
> > > +	unsigned long offset = 0, size = 0;
> > > +
> > > +	if (!kernel_text_address(entry) ||
> > > +	    !kallsyms_lookup_size_offset(entry, &size, &offset))
> > > +		return -EINVAL;
> > > +
> > > +	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
> > > +	if (!ent)
> > > +		return -ENOMEM;
> > > +	ent->start_addr = entry - offset;
> > > +	ent->end_addr = entry - offset + size;
> > 
> > Do we need to take offset into account? The code before wasn't using it.
> 
> Yes, if we hit an alias symbol (zero-size), we forcibly increment address
> and retry it. In that case, offset will be 1.
> 
> > 
> > > +	INIT_LIST_HEAD(&ent->list);
> > > +	list_add_tail(&ent->list, &kprobe_blacklist);
> > > +
> > > +	return (int)size;
> > > +}
> > > +
> > > +/* Add functions in arch defined probe-prohibited area */
> > > +int __weak arch_populate_kprobe_blacklist(void)
> > > +{
> > > +	unsigned long entry;
> > > +	int ret = 0;
> > > +
> > > +	for (entry = (unsigned long)__kprobes_text_start;
> > > +	     entry < (unsigned long)__kprobes_text_end;
> > > +	     entry += ret) {
> > > +		ret = kprobe_add_ksym_blacklist(entry);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +		if (ret == 0)	/* In case of alias symbol */
> > > +			ret = 1;
> 
> Here, we incremented.
> 
> Thank you,

Makes sense, thanks for the clarification.

-Andrea
