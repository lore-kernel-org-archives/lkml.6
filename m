Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E0C13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A945F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNJzEmHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A945F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeG3MAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:00:05 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37609 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeG3MAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:00:03 -0400
Received: by mail-it0-f67.google.com with SMTP id h20-v6so16082896itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s98cEbqjck5ZS5q001Lr4VnobCe12eb1wWoPFiXxR1A=;
        b=vNJzEmHteDbo257iV4fH769nCcciAr96oxT7a/FmQAp/YqhUOxvqDSorNRvBhoaXk7
         d1xFMeJjb5ImX18SZt0LqLhkDs7/C2JzUzZSKYQDBUts1/YJzJTXIjnDXcv2eHDhCjHO
         bfxxZanCYaY1RLmV6NxWphMlpLs33hhpcj8I6GYLqorz9n39kIhtns9S2RjyhG3AW0fQ
         sk1TnVh3OePNJCAFSvKBA6E7bWry9uZBCcnrVfK+POBLKZ6HuSDwycxfhO/W64tA1A/4
         gLtXgJLdtFeM/CP3Wc0lDqrA+Vf4hkfAYqYjbuX+OJrkzztJSNtSi6DNtvjKv0XdeMTp
         RT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s98cEbqjck5ZS5q001Lr4VnobCe12eb1wWoPFiXxR1A=;
        b=Q8ZYvk+47xn0LHDdjXqkbACac9ksmkZlaoj0RMw+Yt3dQF4UA3Ww7p+ApkAoMtwYj5
         +c5VRYTQijK72VpSdezjwf/Kyy8M0O50MSbAp7QLiifOYt/9nW77R4wYCiJOGhDOVWsW
         JuaEg65way0ZGOjD648n2J/RHuQ8gI4mHg7wey9QtipRBluQ/G6lgOVEDK2ZyHC3Unhr
         RW11eHFOa2XdpG4Pjsks0cbsRZdu52TfFKYywlRnQukka52nGcEx0W52xTyoHEeDXgRN
         /VphpMp4INeOWQw8Ome2sktM3xUOB5LeiyaF/oAHc/WUN24gbNqO0gPiMYU16QfN537n
         dUtw==
X-Gm-Message-State: AOUpUlEchx2THqcO7rgm9GOYwB0ij4tfEM1IpTP7APJzKvvzcQDTNTfD
        wcmvzXT7V9IMx2n2AUHd2zEo7hIpsu3doKcGBkBj+g==
X-Google-Smtp-Source: AAOMgpfEcIGdyrYB/xHBboFC9E4ca20RdBWPOgKquh7+ffcbWkha5rUy3wo2drwPSTQLcT2sYEiE3XxcnURQzck72YM=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr15900521jab.87.1532946343914;
 Mon, 30 Jul 2018 03:25:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 03:25:43
 -0700 (PDT)
In-Reply-To: <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com> <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 30 Jul 2018 03:25:43 -0700
Message-ID: <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2) command
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 3:04 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> Hmm, I don't think such UAPI as above is future-proof. In case we would want
> a similar mechanism in future for other maps, we would need a whole new bpf
> command or reuse BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES as a workaround though
> the underlying map may not even be a map-to-map. Additionally, we don't have
> any map object at hand in the above, so we couldn't make any finer grained
> decisions either. Something like below would be more suitable and leaves room
> for extending this further in future.

YAGNI. Your proposed mechanism doesn't add anything under the current
implementation. It's also not clear how a map-specific synchronization
command is supposed to work in cases where we swap multiple map
references. Do we synchronize_rcu multiple times? Why would we impose
that inefficiency just for the sake of some non-specific future
extensibility? Add some kind of batching layer? The current approach
works for the anticipated use cases.

While my preference is not to talk about map-to-maps at all in the
user API and instead spec the thing as talking about map references in
general, I'd rather have something that talks about
references-to-maps-acquired-from-maps than this interface.
