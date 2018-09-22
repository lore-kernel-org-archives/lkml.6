Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73792ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB9D21569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="DSsyCNVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB9D21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbeIVGAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:00:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41770 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeIVGAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:00:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id t39-v6so3486373qtc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=fv9LuU7OvqkibppjQzeB+G+nvWZEOLtJkPf+O93TBi0=;
        b=DSsyCNVEfx1TCFeThMQEAfzhIHhnhLE1DuCa+AO+F1RrAoUEZDz2OoHcgQnGTHNi6L
         C1lvmQR0RzaSmo0DuotYUMX7ktpK6pUlLgZjhLEJQZ75jwrSbWIV1CKTowXCB6CsvtZr
         VqZKGZySuvjWtAEDVVJDOfI+Zxz4LiIi0izAed7Kaoc8iH3ZeepudaD6Q/YuvMYoJIkk
         GiDo8+Y4MJC2FZwGDLNXMtYG0e47orZXf/WKgwo/Homw9qaVbSl20ihs68+38n5Jdg58
         lCp1+E1FXOVqmzrQM8adcK2wyUViRMNu22PAKauqbjKnc4MArpNdqmADoW4gvgpwXBUo
         Mh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fv9LuU7OvqkibppjQzeB+G+nvWZEOLtJkPf+O93TBi0=;
        b=mM3ONcSMh6oV3FF2hIDu7z8DbNyV+aNCjR/mV1ZxoYfTMpMOJzEvYB+qKySkKFuK28
         p55sJfjJB5JEyl28myJAwc/xRQAmeJ7f7K8EChALrQov8jjMMLQ2dVwMAgQ83PSjBxp+
         EbeRkVDA4wJTmgXrFOmnT6ru5ayGrUV5SI3XeNEc23XJW6rn/ShIEQMNUk/jFPyfSIir
         nhXw/OsJG2qF9t2IZ4oRE4Uk+YhdnFXxG3jKCWWC63r1zwdRqWFGKOerdSC4HDna0ILj
         QEfsSrpVUCX6eDMaBI8rMu4V5o/0EJSgwpjwggSfJ+kfYNZJwWwvPqWS0eM7PU64OIKs
         OU4Q==
X-Gm-Message-State: APzg51A5inJYkzCNq6PdLc6DcV/kVkHaHoJ8hNstDVVSxsT1er6hK25V
        yMlua56j452qJfNEerDWAbZzZtqTz4Q=
X-Google-Smtp-Source: ACcGV63lbhavWDYFkqDNVWbnMV6SIJSguCQ9YbW7tlgODcIgyz6Wo12s3HEKmmNA7hzMItvz8QEiMA==
X-Received: by 2002:ac8:764c:: with SMTP id i12-v6mr78400qtr.250.1537574972414;
        Fri, 21 Sep 2018 17:09:32 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id l5-v6sm14787605qte.20.2018.09.21.17.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 17:09:32 -0700 (PDT)
Date:   Fri, 21 Sep 2018 17:09:29 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] bpftool: add support for
 BPF_MAP_TYPE_REUSEPORT_SOCKARRAY maps
Message-ID: <20180921170929.2d278d65@cakuba.netronome.com>
In-Reply-To: <20180921224700.10524-1-guro@fb.com>
References: <20180921224700.10524-1-guro@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 22:47:20 +0000, Roman Gushchin wrote:
> Add BPF_MAP_TYPE_REUSEPORT_SOCKARRAY map type to the list
> of maps types which bpftool recognizes.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Yonghong Song <yhs@fb.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
