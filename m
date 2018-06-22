Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A475C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C128824933
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="NMZwEc1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C128824933
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeFVVuA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:50:00 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:42211 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933127AbeFVVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:49:57 -0400
Received: by mail-qt0-f179.google.com with SMTP id y31-v6so7251911qty.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ov3RvJ9RSSo2XNE/Bz+MrTOuwmXOjoa17Kv0nsVTfvM=;
        b=NMZwEc1Jw4SRi/xFm8P8Hun+hItRz+flXDQNz9MlXuqOge1QaXH4UETiDKsH3PjWTi
         5oJjxeFN33Gku3AahVfUj9JuxNGjSwM+HuyGmwdgXStG6Ex5BTYSQkwa1Gw4LdZK0Eg8
         kq4Y8rUMV8X52v3CF/60Cl9/tc9TPhF5FkHfKLdYBjvGC/M52X23sMLKY2lXJl/iCm0l
         Hrq1bIwlmunVqYXCkUW0p8thSK27UHj6UFNIWiv8YhVCDE1mHm3qWbJX1D5Q+l1Cnonf
         C1CS36eKfQEYa+7Z8ZfVdDXI3BymwYZ5JmxATUAeHkAigYQ4eYJvmWaR51N1+sgF87ja
         yvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ov3RvJ9RSSo2XNE/Bz+MrTOuwmXOjoa17Kv0nsVTfvM=;
        b=OazU8wwyDp7kMW3Ej6QgPhfnKFVibSUQHFK4v2J2NjZWIUrO2/z9iiMn49O9nDHVVQ
         /JrmeG+Sy56J+CW+b3rLHRgV+N6dFFJVQVlQ/R+l5SaC863yB1Q8zbs69VC4XyuCGiLf
         jJUjPAaSBIXsr4EQJ5bqh9BTqiRrNg4kmQgFg/T1QN7OgWYdeCefxKP6fSranJVHFSCr
         XTgtAKVxjv31hAEDiqzBzacOOfwabRqwPm3QoprmZgT+gM//YkVMOvKA0dPAnAlfT5is
         2mquf+n2A7qXKI52FUJCFyulQb2eMB7g5PbRIucAeWoeiemZIUMhqUPqdJE8pWnlDLM3
         jkKw==
X-Gm-Message-State: APt69E0zcY3DymX2RxUaBb7xhphedVcGNqfs9N1kuWCfoJ6CEH0dByFc
        eUI8ThYGiCDBPgLpngqv55X00A==
X-Google-Smtp-Source: AAOMgpdZxho5fwzusOnTRxY9vtmJpS2Oy3R76WNQwydY9+hdvW4eVB2ltN21DNwFjxIfXOJPierMtw==
X-Received: by 2002:a0c:8992:: with SMTP id 18-v6mr3089318qvr.61.1529704197183;
        Fri, 22 Jun 2018 14:49:57 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id z135-v6sm6671831qkz.82.2018.06.22.14.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 14:49:56 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:49:52 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622144952.353d50c0@cakuba.netronome.com>
In-Reply-To: <20180622142743.2b890d0f@cakuba.netronome.com>
References: <20180620203051.223156973@fb.com>
        <20180620203703.101156292@fb.com>
        <20180621145935.41ff8974@cakuba.netronome.com>
        <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
        <20180621160719.2cfb4b58@cakuba.netronome.com>
        <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
        <20180621172523.6cd00ed1@cakuba.netronome.com>
        <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
        <20180622114032.162b2a76@cakuba.netronome.com>
        <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
        <20180622142743.2b890d0f@cakuba.netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 14:27:43 -0700, Jakub Kicinski wrote:
> BTF in JSON is very useful, and will help people who writes simple
> orchestration/scripts based on bpftool *a* *lot*.  I really appreciate
> this addition to bpftool and will start using it myself as soon as it
> lands.  I'm not sure why the reluctance to slightly change the output
> format?

Ohh, maybe that's the misunderstanding, you only implemented JSON so
you wanted it to be as readable and clean as possible.  Hence the hex
output and cutting out the old cruft!  That perspective makes sense!
But I think we should keep JSON for machines (but including BTF
formatted values) and let's make the plain text output nice and clean,
agreed.
