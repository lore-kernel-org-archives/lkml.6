Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD4CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305AA2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMGx3j+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305AA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeIEKkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:40:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44073 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeIEKkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:40:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so2894893pff.11;
        Tue, 04 Sep 2018 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uva6WvTCO0peCxOukIV1wV5tNn0mHsrP8l7C0Uv665Q=;
        b=fMGx3j+fHmbNiCYYf0bCE0CsLNOR+Hdy7VIohe5KgvE3TuE9s2ybym5BuPMqx3PYJ4
         Dc+lWIo4kTNnalodstwsBghMJFQUhoKmjDayWzTflwQ/Jutm4UzhOMSPBnwXr6TByev+
         9xjyRgmFD4EtAVBR9DOQL/fHpDRaU0oEjYnNNHAExXkrP8qe8ri8xQYCT58Xvur7qDM1
         KGBECHcJeZOUzXS64OMr0kW8wMKbYvcpM1RMpnDsNuZLacjtUn8Ef1owCfkQqk3hfT+z
         i3sU5kCOaXDCSd3sRy0aJphN35r+4qqVwzhuBu5vdTuJP+wvzi6yxznMEZ9vSda3vMDu
         GyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uva6WvTCO0peCxOukIV1wV5tNn0mHsrP8l7C0Uv665Q=;
        b=mTYyJJn6MWxi8xkr4dPv6qWEwNLzTqU5E1oTHFsHyrnJuTi4xSZ0nQ06Csy5ALaDoc
         A6qRUiPoezvVV/+RogkmWZ0Pe8i++QVFj/i+1wNWpXT+p+D2PnxL6DRDafdHDhCOB6QD
         egomwWNdHfnwizUOZFx/tshjxRta2f4W7c/8S2A8Ki5uLuSiBKNnTdxaZoQqItA9HQLX
         OyQH4Ydqe+tsXoqn0HvlMKj0+JaFaE47mmfdbAk/fR5mrQ7/NsdlkfG6nO+KgtuePZgF
         w32hZTBpjvITenbat1BqlZRuP7Dij2e7eRsA4GC/mm9bSXdx3zgV2Q+eX+Vq9bJe96Xf
         AhZw==
X-Gm-Message-State: APzg51AqWo+pwfvrea0Os8w+tyAqgzJGeZkCfqLElaP6khL/fNUyYrUF
        23VWdRA40n1kt5bLfao2Pt4=
X-Google-Smtp-Source: ANB0VdYGofHun52QHt/JYHrtxBLzyEI65Tz5t/o+ACt1HUB4GvhUd80T+52IYGgaYU/kT1dxWqwoug==
X-Received: by 2002:a63:9712:: with SMTP id n18-v6mr33887600pge.92.1536127897380;
        Tue, 04 Sep 2018 23:11:37 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:bcd1])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1231335pfj.72.2018.09.04.23.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 23:11:36 -0700 (PDT)
Date:   Tue, 4 Sep 2018 23:11:33 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Taeung Song <treeze.taeung@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] libbpf: Remove the duplicate checking of
 function storage
Message-ID: <20180905061132.m7kp5og6jopojajj@ast-mbp.dhcp.thefacebook.com>
References: <20180902233007.3003-1-treeze.taeung@gmail.com>
 <20180904110745.3ab4dc3e@cakuba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904110745.3ab4dc3e@cakuba>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:07:45AM +0200, Jakub Kicinski wrote:
> On Mon,  3 Sep 2018 08:30:07 +0900, Taeung Song wrote:
> > After the commit eac7d84519a3 ("tools: libbpf: don't return '.text'
> > as a program for multi-function programs"), bpf_program__next()
> > in bpf_object__for_each_program skips the function storage such as .text,
> > so eliminate the duplicate checking.
> > 
> > Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> 
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Applied, Thanks

