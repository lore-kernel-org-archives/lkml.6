Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34205C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029612087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029612087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJHP0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:26:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:58786 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeJHP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:26:03 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1g9Qh5-0006E9-FJ; Mon, 08 Oct 2018 10:15:11 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g9Qh5-000Tkx-8e; Mon, 08 Oct 2018 10:15:11 +0200
Subject: Re: [PATCH bpf-next] libbpf: relicense libbpf as LGPL-2.1 OR
 BSD-2-Clause
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     acme@kernel.org, bjorn.topel@intel.com,
        jakub.kicinski@netronome.com, tgraf@suug.ch, wangnan0@huawei.com,
        colin.king@canonical.com, kraig@google.com, daniel.diaz@linaro.org,
        eric@regit.org, hekuang@huawei.com, jeremy@jcline.org,
        brouer@redhat.com, jolsa@kernel.org, joe@ovn.org,
        yamada.masahiro@socionext.com, mic@digikod.net,
        namhyung@kernel.org, ppenkov@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20181005212416.2525992-1-ast@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7a8a3ccd-d78f-8e3d-4759-34297e8e5357@iogearbox.net>
Date:   Mon, 8 Oct 2018 10:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181005212416.2525992-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/25017/Mon Oct  8 06:49:45 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2018 11:24 PM, Alexei Starovoitov wrote:
> libbpf is maturing as a library and gaining features that no other bpf libraries support
> (BPF Type Format, bpf to bpf calls, etc)
> Many Apache2 licensed projects (like bcc, bpftrace, gobpf, cilium, etc)
> would like to use libbpf, but cannot do this yet, since Apache Foundation explicitly
> states that LGPL is incompatible with Apache2.
> Hence let's relicense libbpf as dual license LGPL-2.1 or BSD-2-Clause,
> since BSD-2 is compatible with Apache2.
> Dual LGPL or Apache2 is invalid combination.
> Fix license mistake in Makefile as well.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrey Ignatov <rdna@fb.com>
> Acked-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Acked-by: Björn Töpel <bjorn.topel@intel.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: David Beckett <david.beckett@netronome.com>
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Acked-by: Joe Stringer <joe@ovn.org>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Acked-by: Quentin Monnet <quentin.monnet@netronome.com>
> Acked-by: Thomas Graf <tgraf@suug.ch>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Wang Nan <wangnan0@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>

Applied to bpf-next, thanks!
