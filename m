Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7ACC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509BC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="txnWwhbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509BC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJXX3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:29:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35596 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJXX3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:29:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id v68-v6so3496180qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jStwo6WLQ1qKFH+n6UnzhTtzYHHqiefUGPudeKO1OU=;
        b=txnWwhbzDOHa2eaUxgFLUfeSezrS5VXz2IvGkztsUDxFskTWKMLgQSeGC9emnivYCo
         PwOqHQ2UXaDEDqELuYZ35uB82oCtp2y3V9CWv6h6uycfgtLloULPjHB/CERJzwxw+Yii
         AL52tU/HYXrgfEmHrjrscxCLaXFEP2gGMkN3yGnHElh+rEkK0mmbbrYUJ9R2iEGvHFro
         2tSvcFPLXmRx3gy8CoYcJsNMvTXvcw/kLjr4GY4U9PqcF4V2ZzlnqtsYKeX08UFWyWKl
         mCaycH5NhTY1MFBtt1RNB8r4HUgHgvAA8PS3pZIRrO7zy1l/SPs/EbnskCnWEOhtdPEk
         lq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jStwo6WLQ1qKFH+n6UnzhTtzYHHqiefUGPudeKO1OU=;
        b=jDK3dDQgFjv3qGsVaoqGxdZvWLu/CW7ELSPm0WKqsNhuZHhmTGmzqJ7YErLCfCXdd6
         +gPHVnoCJSCgzRjKWR977qNrVcTIPP+kRBqc8h0zgfvX7olHB6imh3bMECXM+rcW2gEY
         /QfsLSoXnnRaeEJWSkpaXYpaXarUY4x358PQBXPAAB2aK5Q1nr5skKgLqYlyEInVpeR/
         q/OPK8/d3offrE0h7hX0wlX4eVVSvbN0V8mFEku45cUX+pcm9pr5ZgOKLwQ4GhFE7nzb
         kwyvWs0bwbmsLuBo3Mq8ioijEcZxYLq+DLGeYolNp9gtCw/XQzF71t7x09VGGMku5F4/
         CPrw==
X-Gm-Message-State: AGRZ1gLtps8RBxyEevYoT0JIgmqUK+VWKVhe0NHcHQSyQqOAfSMnVNrX
        fmRE77ujL7KqWGwl1hChEVb9DA==
X-Google-Smtp-Source: AJdET5cPuY0/vXqqWMu/xV13t7536/TmRzi4DnvnDK/VuwMZZNw/dB5NeW+sj3rPf5WNVueVAGLqCw==
X-Received: by 2002:ac8:dcd:: with SMTP id t13-v6mr1775207qti.291.1540393245148;
        Wed, 24 Oct 2018 08:00:45 -0700 (PDT)
Received: from cisco ([192.241.255.151])
        by smtp.gmail.com with ESMTPSA id l186-v6sm2659945qkf.60.2018.10.24.08.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 08:00:38 -0700 (PDT)
Date:   Wed, 24 Oct 2018 16:00:29 +0100
From:   Tycho Andersen <tycho@tycho.ws>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     "Stecklina, Julian" <jsteckli@amazon.de>,
        "juerg.haefliger@hpe.com" <juerg.haefliger@hpe.com>,
        "deepa.srinivasan@oracle.com" <deepa.srinivasan@oracle.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "pradeep.vincent@oracle.com" <pradeep.vincent@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "liran.alon@oracle.com" <liran.alon@oracle.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "keescook@google.com" <keescook@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "tyhicks@canonical.com" <tyhicks@canonical.com>,
        "john.haxby@oracle.com" <john.haxby@oracle.com>,
        "jcm@redhat.com" <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Message-ID: <20181024150029.GB9019@cisco>
References: <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
 <ciirm8zhwyiqh4.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <5efc291c-b0ed-577e-02d1-285d080c293d@oracle.com>
 <ciirm8va743105.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <7221975d-6b67-effa-2747-06c22c041e78@oracle.com>
 <1537800341.9745.20.camel@amazon.de>
 <063f5efc-afb2-471f-eb4b-79bf90db22dd@oracle.com>
 <6cc985bb-6aed-4fb7-0ef2-43aad2717095@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc985bb-6aed-4fb7-0ef2-43aad2717095@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 04:30:42PM +0530, Khalid Aziz wrote:
> On 10/15/2018 01:37 PM, Khalid Aziz wrote:
> > On 09/24/2018 08:45 AM, Stecklina, Julian wrote:
> > > I didn't test the version with TLB flushes, because it's clear that the
> > > overhead is so bad that no one wants to use this.
> > 
> > I don't think we can ignore the vulnerability caused by not flushing
> > stale TLB entries. On a mostly idle system, TLB entries hang around long
> > enough to make it fairly easy to exploit this. I was able to use the
> > additional test in lkdtm module added by this patch series to
> > successfully read pages unmapped from physmap by just waiting for system
> > to become idle. A rogue program can simply monitor system load and mount
> > its attack using ret2dir exploit when system is mostly idle. This brings
> > us back to the prohibitive cost of TLB flushes. If we are unmapping a
> > page from physmap every time the page is allocated to userspace, we are
> > forced to incur the cost of TLB flushes in some way. Work Tycho was
> > doing to implement Dave's suggestion can help here. Once Tycho has
> > something working, I can measure overhead on my test machine. Tycho, I
> > can help with your implementation if you need.
> 
> I looked at Tycho's last patch with batch update from
> <https://lkml.org/lkml/2017/11/9/951>. I ported it on top of Julian's
> patches and got it working well enough to gather performance numbers. Here
> is what I see for system times on a machine with dual Xeon E5-2630 and 256GB
> of memory when running "make -j30 all" on 4.18.6 kernel (percentages are
> relative to base 4.19-rc8 kernel without xpfo):
> 
> 
> Base 4.19-rc8				913.84s
> 4.19-rc8 + xpfo, no TLB flush		1027.985s (+12.5%)
> 4.19-rc8 + batch update, no TLB flush	970.39s (+6.2%)
> 4.19-rc8 + xpfo, TLB flush		8458.449s (+825.6%)
> 4.19-rc8 + batch update, TLB flush	4665.659s (+410.6%)
> 
> Batch update is significant improvement but we are starting so far behind
> baseline, it is still a huge slow down.

There's some other stuff that Dave suggested that I didn't do; in
particular coalesce xpfo bits instead of setting things once per page
when mappings are shared, etc.

Perhaps that will help more?

I'm still stuck working on something else for now, but I hope to be
able to participate more on this Soon (TM). Thanks for the testing!

Tycho
