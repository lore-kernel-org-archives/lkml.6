Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3A5C1C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C35208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpS6NmMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C35208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935872AbeFNBmB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:42:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42349 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935633AbeFNBl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:41:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so2354096pfn.9;
        Wed, 13 Jun 2018 18:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cpk6oqvgwK0nRz40w1tOTdIMmkMLCrimVcLOb6zI28g=;
        b=CpS6NmMzmEt+WU+7UkpLa3cb1xSDP6BE+bQdheEsmvnGNRXGabfMApUvgH1ck9MkEJ
         8238R/w+6/+EWDXbl/dMVhzQIrkuQXJGa41kdMbfJtW61ddDJZKsG2ffKU+bgdAKoSts
         QXH8i6p1m5HQprI8xOtcj9boFWXOG6LNiC8BKb0LCrKURFJSOf6HbCHtkUyDM+s6yL/g
         tgkOusmSoLni5W7N5ZEhTVL0Jrvf8oWOjDiiqxoTxGX0fEJruIPXfaBWgRhSI4pR+c6F
         Du4ZtdCjwD/hJ5h2Y3tTtyyYSblIH4snQcs65roqZR6lIGlQ5FYFseOIojPDnmX4zAca
         /WIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cpk6oqvgwK0nRz40w1tOTdIMmkMLCrimVcLOb6zI28g=;
        b=U0ViwFgJjXa5y/iDBvNpliys5qn8YsBmv+gGVGaaxCFjUS2g51PNz04gGbqEodyXxe
         hY6ifNzYLwriEzbk1wJIwEiGxsPPiBBysr6rB7dcGNI/oyfGl41nwO8nTDYAAp7+nkeJ
         sQYJVyM45pFeqWOKkpAmE3yyQ0iy6fu5tsOV3JxZZFR9NADrybnqZfVkaM127hiK+8p3
         0IwOac+E0BIzF4iY4DZyZOm+FcE5o+btV5FC70NUQ6JgX2/3Xric8BAiMnnJf6wQNpQv
         IgrU8tOr/+Ee9jECPvDXS6S4VAm0QDkd4cK/dcZkvfVSBnEzfigg1Iszwq5zqDMT53Rt
         e/UQ==
X-Gm-Message-State: APt69E3Bo/m9hCyJ/0xtQcQgslQl4D0HBrn/gJ16z+XFujpt7G/PiIAK
        IuoKmsDMRGBC1ZLmQCnwUu0=
X-Google-Smtp-Source: ADUXVKLjQaqPlDTjyyvI8hXDIuqXRptBPIqttRmU+TpHQDhH5QbnqY2fsxXfH0CEoMt8785sfGW1kQ==
X-Received: by 2002:a62:2394:: with SMTP id q20-v6mr7289618pfj.1.1528940519069;
        Wed, 13 Jun 2018 18:41:59 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
        by smtp.gmail.com with ESMTPSA id k12-v6sm4485559pgo.31.2018.06.13.18.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 18:41:58 -0700 (PDT)
Date:   Thu, 14 Jun 2018 11:41:44 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 14/23] watchdog/hardlockup: Decouple the hardlockup
 detector from perf
Message-ID: <20180614114144.05891a04@roar.ozlabs.ibm.com>
In-Reply-To: <20180614011901.GA22652@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <1528851463-21140-15-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <20180613084324.GU12258@hirez.programming.kicks-ass.net>
        <20180614011901.GA22652@voyager>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 18:19:01 -0700
Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> On Wed, Jun 13, 2018 at 10:43:24AM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 12, 2018 at 05:57:34PM -0700, Ricardo Neri wrote:  
> > > The current default implementation of the hardlockup detector assumes that
> > > it is implemented using perf events.  
> > 
> > The sparc and powerpc things are very much not using perf.  
> 
> Isn't it true that the current hardlockup detector
> (under kernel/watchdog_hld.c) is based on perf?

arch/powerpc/kernel/watchdog.c is a powerpc implementation that uses
the kernel/watchdog_hld.c framework.

> As far as I understand,
> this hardlockup detector is constructed using perf events for architectures
> that don't provide an NMI watchdog. Perhaps I can be more specific and say
> that this synthetized detector is based on perf.

The perf detector is like that, but we want NMI watchdogs to share
the watchdog_hld code as much as possible even for arch specific NMI
watchdogs, so that kernel and user interfaces and behaviour are
consistent.

Other arch watchdogs like sparc are a little older so they are not
using HLD. You don't have to change those for your series, but it
would be good to bring them into the fold if possible at some time.
IIRC sparc was slightly non-trivial because it has some differences
in sysctl or cmdline APIs that we don't want to break.

But powerpc at least needs to be updated if you change hld apis.

Thanks,
Nick
