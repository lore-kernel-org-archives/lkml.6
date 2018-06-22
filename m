Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06550C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA41224756
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wMJwMTmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA41224756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934304AbeFVSnT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:43:19 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36528 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933878AbeFVSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:43:17 -0400
Received: by mail-qk0-f194.google.com with SMTP id a195-v6so4219681qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ShXiIq1mAjJYmhmzaV+lwY3yZ5U/ERDdTKcq2HTcRCc=;
        b=wMJwMTmELZJDcFfi0JJjlOfZZ4iRQTu0T/rQuKq+fSATAMEzy9aziqCCROJv1J8Q4b
         E2D6jmNnVf6BnWFrQRp3jpK0YdGiPD8YZ2KzgJ8onXPDIJa+3T7oC2b2+2/CVsPYRlB1
         4WSSH5BMwLkLbPbOwuzt+UfLri8KRVpkCLhhW4NgUzHgVmcODFd88UHfB2R6WKKLiTMd
         aK+G/r34oIaAxvnZ82A3nybElnxA68HVi1P2lstRxRL/3jwD5JbyTeeS7eFvfZXCmTmh
         uq3GzWHa9SlKTsa+dceWs+mgbi7G/wBXT/3WhOdhtxsbzYDOGzyfDAqGV0fATHqdPfPZ
         m7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ShXiIq1mAjJYmhmzaV+lwY3yZ5U/ERDdTKcq2HTcRCc=;
        b=Y4sxh3rYro4A6tmulzU2gyq3VlbuE6M5f0La7qi6y3LMqsZpNvTBgFLD3QPO6QkT5q
         1xGSh9IrjfdRi/fJQBitbKYuMnwOh2FshCBKtzVabeWFPDQUuiR7uuwDWtR4Z1DSU8tz
         RopsruCy1CE/dNn7+gsaAE3JWSQtbw1OF4e/OdMYuZ7ayanNb7YyJGY7TihsOfdlCd0K
         Vee9CBoykM2dKrocJ1aGUEos6HBxG80EhcAMMrOtrb/Jt1WKsNCtNRtw6J4mKwl2xXyc
         z13GINaBYrmrMV03E3/cGyPT+DKv2oXRmV1AudtbP8YaRf1otnqbOTxq4dgbbn4uAZ4T
         MicA==
X-Gm-Message-State: APt69E39gXCvslCcIJeBaJ73HrpfSstvYDoAXeLwD532tr+S7suTCBP5
        9M5uK3waTaivV2I/JMnj39ybhQ==
X-Google-Smtp-Source: AAOMgpd+6xajQY9h0ho330Y3dTpC92ZsrUG4M1NlF5ZhC7RmhvZLFy1X8RGgC8XoyzwXVbOMTekpIQ==
X-Received: by 2002:a37:3755:: with SMTP id e82-v6mr2474862qka.131.1529692996987;
        Fri, 22 Jun 2018 11:43:16 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id 31-v6sm6898732qtq.80.2018.06.22.11.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:43:16 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:43:12 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622114312.1698418f@cakuba.netronome.com>
In-Reply-To: <20180622111751.GB3050@w1t1fb>
References: <20180620203051.223156973@fb.com>
        <20180620203703.101156292@fb.com>
        <20180621145935.41ff8974@cakuba.netronome.com>
        <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
        <20180621160719.2cfb4b58@cakuba.netronome.com>
        <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
        <20180621172523.6cd00ed1@cakuba.netronome.com>
        <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
        <20180622111751.GB3050@w1t1fb>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 12:17:52 +0100, Okash Khawaja wrote:
> > > > > > > The name XYZ_struct may not be the best, perhaps you can come up with a
> > > > > > > better one?  
> > > > > > > 
> > > > > > > Does that make sense?  Am I missing what you're doing here?
> > > > > > > 
> > > > > > > One process note - please make sure you run checkpatch.pl --strict on
> > > > > > > bpftool patches before posting.
> > > > > > > 
> > > > > > > Thanks for working on this!      
> > >   
> 
> Hi,
> 
> While I agree on the point of backward compatibility, I think printing
> two overlapping pieces of information side-by-side will make the
> interface less clear. Having separate outputs for the two will keep the
> interface clear and readable.
> 
> Is there a major downside to adding a new flag for BTF output?

plain output and JSON should be more or less equivalent, just formatted
differently.  If we hide the BTF-ed JSON under some flag most users
will just run bpftool -jp map dump id X, see BTF is not there and move
on, without ever looking into the man page to discover there is a magic
switch...
