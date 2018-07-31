Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290EDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16C720894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="PGyvR5mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16C720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbeGaCEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:04:16 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40685 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732099AbeGaCEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:04:16 -0400
Received: by mail-qt0-f195.google.com with SMTP id h4-v6so14158568qtj.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 17:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=lML/9e5DPmfPBOELuLbRd8D4Yfl+H3yeH4FSFKo0z6I=;
        b=PGyvR5mjq/R1seCYScxKmdWcgBhVrqQvy6PFPpdCvEnUtkhLBfZB+GogzalXTl7ZeZ
         90VYOTvD1NUOsHMAHjcV+yKVR0Or37TSZTXmvXj/l3474BWFgZHxPAo6Jnrceoupd7db
         XF8ZS/+eMLGhS4curGQFYEVnlNhYH/r/S9weLfTtODOWpySm7Wr8gw9YM3WJZdHqbGDp
         Z3P8ngqHVJ7w+R1wVGgSW2LyNCHHgOwxbCAWd2ZYBmkEv4twPigcP8/qmsHW0qECuXA6
         oSoipRgaqhmo4hah3KtLH8kn4BlNlwHl+OufJeqLarWfdFViV6P5/V193+UCwrTxsa4T
         haVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=lML/9e5DPmfPBOELuLbRd8D4Yfl+H3yeH4FSFKo0z6I=;
        b=UrtkRqseZ6oHT1HBroFn8Tdc1cordF3HS83IHbjl9PPgLIwvqt+tIVZaCVYCju+mvC
         Auzr66dX21AgQTaUEfEc2Tehr5q8vzzkDIyVJociAxZQvibdwtB+NnE0ZzZS578kspZ9
         lajQMr+uZNtr4zZ/kh2OZdgON29EmirpcpUZI0XA+uYYM0tRRMZRclnoE606tKYsk5oz
         jqmWyrDLbFlAx6CGSLxsseQQMlS3fWSDfD4zJ901XB3hlYPPCZ0aBnF6EGdJrD3A6J/l
         nj+VLepmWcfL1oYT4+olbTJZpukEw2DbenEslWYN4TLYuKh+u1b/H7yWnqSSCbyPY8Yu
         nJhQ==
X-Gm-Message-State: AOUpUlFnFm/rHhDFiXxgK93e5fWzUxEXvPfykkFMGzO0OQKoNlxlWPAy
        DisiPoV103EtDeCSEApJp12T2g==
X-Google-Smtp-Source: AAOMgpcsHs+f21tswuhxNYca2gPfn4B5v8+/0ppaT0fvq8bY0VvnrLkRub9MDN2GrSLNdXMAvyhiAA==
X-Received: by 2002:aed:25a2:: with SMTP id x31-v6mr18637171qtc.228.1532996805528;
        Mon, 30 Jul 2018 17:26:45 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u8-v6sm10201585qtc.76.2018.07.30.17.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 17:26:45 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:26:41 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2)
 command
Message-ID: <20180730172641.7d516231@cakuba.netronome.com>
In-Reply-To: <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
        <20180729205835.34850-1-dancol@google.com>
        <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
        <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 03:25:43 -0700, Daniel Colascione wrote:
> On Mon, Jul 30, 2018 at 3:04 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> > Hmm, I don't think such UAPI as above is future-proof. In case we would want
> > a similar mechanism in future for other maps, we would need a whole new bpf
> > command or reuse BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES as a workaround though
> > the underlying map may not even be a map-to-map. Additionally, we don't have
> > any map object at hand in the above, so we couldn't make any finer grained
> > decisions either. Something like below would be more suitable and leaves room
> > for extending this further in future.  
> 
> YAGNI.  Your proposed mechanism doesn't add anything under the current
> implementation. 

FWIW in case of HW offload targeting a particular map may allow users
to avoid a potentially slow sync with all the devices on the system.

> It's also not clear how a map-specific synchronization
> command is supposed to work in cases where we swap multiple map
> references. Do we synchronize_rcu multiple times? Why would we impose
> that inefficiency just for the sake of some non-specific future
> extensibility? Add some kind of batching layer? The current approach
> works for the anticipated use cases.
> 
> While my preference is not to talk about map-to-maps at all in the
> user API and instead spec the thing as talking about map references in
> general, I'd rather have something that talks about
> references-to-maps-acquired-from-maps than this interface.
