Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D0DECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116D5206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK6twWL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116D5206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeIRJsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 05:48:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39892 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRJsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 05:48:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so342611pff.6;
        Mon, 17 Sep 2018 21:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tdb8BaFLjnJKnep7iQRDeNe3brGvkSme9uGugiTMsyU=;
        b=HK6twWL04sqHeB2s44D00uDR4wRnx3LuHd5x9If9Q3WyS1JEyYIDwSaMYWBGYdVSG2
         s1b7t4X5tj7p+6OMDT4yE/506yzm9fLCGA6UYQner0lKL1VOWDzOL+lPDqhntQIAwt7f
         VqweTnkq6ppTlfJVYRXQ3EngK64KX3bOdhRIOiyUeP513g1Kar2S1b0zWA5BF5dCzUvh
         bTCipi4rfCZZSVHfYzSO6EokDpRcaO3cvj9yXcg0O6phI+4b3+L0tdoBAClOER51/csi
         0MTmq73kcfnUvqm8eDMjbLG3mDPVh1bSpSWTUvMOL8gBpX/APFKPhGgcYPlvKqEaxhGj
         kINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tdb8BaFLjnJKnep7iQRDeNe3brGvkSme9uGugiTMsyU=;
        b=rdeMoE1xG/FnKwwvpYZXTEMNbjaqQkogpAiqmvhvvtd35+u3vI3hMxLTOGidEQ8yIS
         K1M4ssJ7GjnhDG3FD1kDaoWBonSQZL7aG4U0ow03rhXNmydtC+9gfj0dj/g8f3HhjwOg
         xpmK60lVZpmEVqwdriRh8LRh+YWRJLt/MWyedSjm9C/iseXodZbuTg8XVyeIoCtuRn2t
         +Ndw6Vco00rkYeZI6xM13LIlofs2eCmMqvKpSRd8KKO/NzpVpqf4Nh6phG7TGuGSkGGL
         L2H3N1702diStO7qxY42wUabSF7mfeIjIgUtengv5TQpMf65nutQCKjT8GAhv88yWreG
         m7Fg==
X-Gm-Message-State: APzg51AOExB3BNO/6E1MjCg+cBYXcIdtofKGCgUgxUbKby4vcoV0h+kF
        NkJjkHPzq1oLI3ZO9pjAJuA=
X-Google-Smtp-Source: ANB0VdZDdMtpoXP5B/MfOIbUZnlyIVp1VRxk7MxlX2/A5AW+iPJR7sDd+VSPPgoNkruGzpRLAYECbw==
X-Received: by 2002:a63:4306:: with SMTP id q6-v6mr26490912pga.181.1537244282981;
        Mon, 17 Sep 2018 21:18:02 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::1:da33])
        by smtp.gmail.com with ESMTPSA id l84-v6sm28767487pfg.3.2018.09.17.21.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 21:18:02 -0700 (PDT)
Date:   Mon, 17 Sep 2018 21:18:00 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC/fix] Re: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180918041758.rruwsw52jxpxh6bk@ast-mbp>
References: <20180910172903.GB15516@kernel.org>
 <20180911122218.0d2eb3f9@cakuba>
 <20180911121543.GB22689@kernel.org>
 <20180911212451.hvnyfwyvcs4yojqy@ast-mbp>
 <20180913183240.GF30969@kernel.org>
 <20180913185629.su22fnimluoezntg@ast-mbp>
 <20180917151636.GA21790@kernel.org>
 <20180918005256.7uutwda4s3ofoxpd@ast-mbp>
 <20180917193952.6709fd1b@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917193952.6709fd1b@cakuba.netronome.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:39:52PM -0700, Jakub Kicinski wrote:
> On Mon, 17 Sep 2018 17:52:59 -0700, Alexei Starovoitov wrote:
> > LGPL-2.1 in the above?
> 
> Could we possibly make it dual licensed LGPL + BSD?

that's a separate discussion. let's not mix it up with this fix.

> > The rest looks good to me.
> > Should we take it via bpf-next tree?
> > If you feel there is an urgency to fix musl build, we can take it via
> > bpf tree too.
> >
> > Jakub, thoughts? you've been messing with strerror last..
> 
> Sorry for the mess, I didn't know libc compat is such a pain.
> 
> I kind of knowingly ignored the existing str_error_r(), as it didn't
> seem excessively clean.  Yet, two months later I have no better
> ideas..  We could as well switch back to the XSI version, which we used
> before I needed access to reallocarray() (I mean change the str_error()
> to be a plain XSI wrapper).
> 
> Perhaps placing the new helper in libbpf_errno.c file would make
> sense?  The only reason for this separate file to exist is in fact to
> make use of XSI-compliant strerror_r().

that's a good idea. libbpf_errno.c sounds more appropriate to me as well.

> Also, I need to go relicense tools/include/tools/libc_compat.h ASAP
> too :S

argh. an oversight. pls send the patch.

