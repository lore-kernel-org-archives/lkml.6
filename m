Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52E9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B20620664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Xcclj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B20620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeJ2VZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:25:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36281 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbeJ2VZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:25:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so8499773wrw.3;
        Mon, 29 Oct 2018 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NmX/AYJu1E1rPxyWRdoDW8b6kN4gWKLjWo3ELhWYNn0=;
        b=K4Xcclj5SGQt3BFEaU44Jgx1gNuVA6APFY+kBMOz2JVFIF6Sw2B0lko/RGQB/xaGwC
         YFjFQShV0uO/TpcEiIx6Orxue22+oscOWDszTYUkrf0JIB1pWSicvlBfeV8Jlgy6DhbR
         rDVQCUqijy3wcGvc6NC+7Uwumsb6nvAMSNfyAOxQCVTHmxAOtn2NHp/6TclRJe53hmXO
         PMlhbtsYtz6bya+VCYrOXIhBiF5FKfMIix4FVSRThPrpCaFX4tvpb0IHZYY4RoxZ+wo8
         199e8p305VVa3C/8SegN9KQVpIv0xeDZiPcq5AO+09u1Vdy/Aw/96A+1m9mF9voD8UHm
         tQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NmX/AYJu1E1rPxyWRdoDW8b6kN4gWKLjWo3ELhWYNn0=;
        b=YAMHrCVzJrVzoDWTQdKYwMJnQigX0Pi/+hqZhIryGPSrBubGTKL7byrenZ/m47JddY
         Vl0wW7mknXSY6IgVOpBmydkCGYkFswdLYx0r+McgpfB6L9fQ3qnzmin9mSIU1b7uwDiK
         gc4Anfb5ck9Tgwv4p9TKB17s8DfEjzlYci4neYNuOQqjpQ1jTi/2oOuPrS5KbsJjuL5h
         1H0fkKqRX1ntPqsREPJzLb5dvjgjPNXx0WoNkvtpz/VGQ0pK8q6eEYiRb6suvxWj/53S
         6QcBJMaEycz5U7LaFBkzodPMId4um5sZr3SKz0eYP+3Audr+KZHfTKtub6RdoO4MRn+6
         cE6Q==
X-Gm-Message-State: AGRZ1gJOaSIErubSFyxTD3s2uUE8++9yfn8vcPRuNWM+kRJQquxp1vAK
        8crCAzLShXiC+earoOD4xZo=
X-Google-Smtp-Source: AJdET5cgJAPpeZ3KN37nYAemXacqZFuVwblmRF5Hxi1lwRY19f/L8A76BDLYd41RNieaKfAQRqaQ6A==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr14728725wrx.310.1540816619632;
        Mon, 29 Oct 2018 05:36:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 125-v6sm2847016wmy.32.2018.10.29.05.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 05:36:59 -0700 (PDT)
Date:   Mon, 29 Oct 2018 13:36:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: fix spelling mistake, EACCESS -> EACCES
Message-ID: <20181029123656.GB57235@gmail.com>
References: <20181026175839.4565-1-colin.king@canonical.com>
 <20181029122854.GB20813@kernel.org>
 <20181029123357.GA21857@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029123357.GA21857@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Oct 29, 2018 at 09:28:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Oct 26, 2018 at 06:58:39PM +0100, Colin King escreveu:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Trivial fix to a spelling mistake of the error access name EACCESS,
> > > rename to EACCES
> > 
> > Thanks, applied.
> > 
> > And I also took the chance to fix another spelling mistake, on this same
> > line:
> > 
> > -        *  -EACCESS    -- @event is for this PMU, @event is valid, but no privilidges
> > +        *  -EACCES     -- @event is for this PMU, @event is valid, but no privilidges
> >                                                                                  ^
> >                                                                                  ^
> >                                                                                  ^
> >                                                                                  ^
> 
> But I see Ingo has already merged your patch, lets fix that one later
> then :-)

I zapped my commit, please let's merge your upgraded version.

BTW., while at it, could we also try a header refresh now that a lot of 
the merge window changes to headers are behind us, this is from the 
perf/urgent build (f0718d792b8a)"

Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/kvm.h' differs from latest version at 'arch/powerpc/include/uapi/asm/kvm.h'
diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/kvm.h' differs from latest version at 'arch/s390/include/uapi/asm/kvm.h'
diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm/kvm.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/unistd.h' differs from latest version at 'arch/arm64/include/uapi/asm/unistd.h'
diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/mman.h' differs from latest version at 'include/uapi/linux/mman.h'
diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h

?

Thanks!

	Ingo
