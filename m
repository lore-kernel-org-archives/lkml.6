Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A10C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE50C214FB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="eogiuJsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE50C214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbeGGStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 14:49:53 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40001 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeGGStv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 14:49:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so10872402pfe.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=xBZg5rZZbkXVN36bSCMxVpvwaHuxcyLiELriYG8DvWM=;
        b=eogiuJsYRHRfbVFMc1wlAA4SGve7jrPuHoVo7AFaBZsVC+/8oTSNAZ1AJFYJagcS4L
         UqTYNbgbaokmR+ZdNxby/R8wbTF3bmfGgcHojoL2RDOem0mXIvnnt98hxGKSHBLLiX/c
         ANS2NbMFjiKJnDxKmkeCdY3wbVk2tVRQ2av5tE8zigQhpEg+julSJnl1uK5/hGfHuwUq
         YoQ1tjkecbyDxKBBSnCjR7OJj2OO+6uev28jiKWOZ0llD9j9U7z5w0n1kkDNkerCQ+Ui
         zl51sgF0KwwFlEzJuGjacaebM+0C6xgPOptRWajLXlQjkwiq5IwHLIAWvkorvvN748zz
         Xu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=xBZg5rZZbkXVN36bSCMxVpvwaHuxcyLiELriYG8DvWM=;
        b=KYCTJj5SOQ+6IhpfhEhKsbpsaCuXRBz8V0Hc1u/ZFDzUgujUnBp+SvdGtsXe1aevlA
         xwIuWcLlINzodAGgEJho3iSH+APw6IespzUH6oG9yK662YED1G6mfvnKQjJP1OsrW1Rp
         WmQymIcFGN7V0ls0qYmrpBrX4GnQfs4otX+MmsF13KOzn2axze75yUq/GR8R2rCdL0Kv
         ayKjDa6p8HCpCJopW6tYV6FTsCX/Ujpv/rSM4O65XN/yg5e/2DIU8pmO/CyROTfZfaTs
         qT6ynJfilewOL9Fq+T81Rs9VWGaFq/mJzYpItpitR7cxKMuLKyt7FXbhFO2bff4E1tT8
         BL1A==
X-Gm-Message-State: APt69E22w4HV67cmoFE11Fzb68OYfRsTyPGOKnWxxeNkxalYcmRfV9KA
        O9xGt1wL3f/TnjpFd6hmj90EDg==
X-Google-Smtp-Source: AAOMgpdkjDjAFub8yJP7dUuNtm8C2NHiVS+knvCOAPjmmPRKZCRzWuAmZuE90oEGhY/uyKQkFpwmZQ==
X-Received: by 2002:a63:b74a:: with SMTP id w10-v6mr13357911pgt.266.1530989390538;
        Sat, 07 Jul 2018 11:49:50 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-231-89-118.hsd1.ca.comcast.net. [73.231.89.118])
        by smtp.gmail.com with ESMTPSA id 87-v6sm12208278pfn.103.2018.07.07.11.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 11:49:50 -0700 (PDT)
Date:   Sat, 7 Jul 2018 11:49:46 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: btf: add btf print functionality
Message-ID: <20180707114946.2b4d65e6@cakuba.netronome.com>
In-Reply-To: <20180707133057.GA1697@w1t1fb>
References: <20180702183913.669030439@fb.com>
        <20180702191324.570616684@fb.com>
        <20180702220659.6baa77ba@cakuba.netronome.com>
        <20180703214559.GA4448@w1t1fb>
        <20180703152331.151d1c4b@cakuba.netronome.com>
        <20180703153843.7a3425af@cakuba.netronome.com>
        <20180703233350.aa33jyzrc6hmaelq@kafai-mbp.dhcp.thefacebook.com>
        <20180707133057.GA1697@w1t1fb>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jul 2018 14:30:58 +0100, Okash Khawaja wrote:
> On Tue, Jul 03, 2018 at 04:33:50PM -0700, Martin KaFai Lau wrote:
> > On Tue, Jul 03, 2018 at 03:38:43PM -0700, Jakub Kicinski wrote:  
> > > On Tue, 3 Jul 2018 15:23:31 -0700, Jakub Kicinski wrote:  
> > > > > > > +			else
> > > > > > > +				jsonw_printf(jw, "%hhd", *((char *)data));      
> > > > > > 
> > > > > > ... I think you need to always print a string, and express it as
> > > > > > \u00%02hhx for non-printable.      
> > > > > Okay that makes sense    
> > > > 
> > > > Yeah, IDK, char can be used as a byte as well as a string.  In eBPF
> > > > it may actually be more likely to just be used as a raw byte buffer...  
> > > 
> > > Actually, what is the definition/purpose of BTF_INT_CHAR?  There seems
> > > to be no BTF_INT_SHORT and BTF_INT_SIGNED can simply be of size 8...
> > > Is normal int only used for bitfields of size 8 and BTF_INT_CHAR for
> > > char variables?
> > > 
> > > The kernel seems to be rejecting combinations of those flags, is
> > > unsigned char going to not be marked as char then?  
> > BTF_INT_ENOCODING (CHAR/SIGNED/BOOL) is for formatting (e.g. pretty
> > print).  It is mainly how CTF is using it also.  Hence, BTF_INT_ENCODINGs
> > is not a 1:1 mapping to C integer types.
> > The size of an interger is described by BTF_INT_BITS instead.  
> >   
> > >   
> > > > Either way I think it may be nice to keep it consistent, at least for
> > > > the JSON output could we do either always ints or always characters?  
> > >  
> 
> for !isprint() case, will "\x%02hhx" make more sense?

According to (quick look over) the JSON standard \x%02hhx is not a
valid escape sequence, everything has to be Unicode, so \u00%02hhx.
JSON validators online agree seem to reject \x as well.
