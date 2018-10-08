Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55290C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256DA2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256DA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJHQXL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:23:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeJHQXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:23:10 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A0A17109E;
        Mon,  8 Oct 2018 09:12:27 +0000 (UTC)
Received: from localhost (ovpn-200-21.brq.redhat.com [10.40.200.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9D78201B147;
        Mon,  8 Oct 2018 09:11:56 +0000 (UTC)
Date:   Mon, 8 Oct 2018 11:11:54 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        acme@kernel.org, bjorn.topel@intel.com,
        jakub.kicinski@netronome.com, tgraf@suug.ch, wangnan0@huawei.com,
        colin.king@canonical.com, kraig@google.com, daniel.diaz@linaro.org,
        eric@regit.org, hekuang@huawei.com, jeremy@jcline.org,
        jolsa@kernel.org, joe@ovn.org, yamada.masahiro@socionext.com,
        mic@digikod.net, namhyung@kernel.org, ppenkov@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, brouer@redhat.com
Subject: Re: [PATCH bpf-next] libbpf: relicense libbpf as LGPL-2.1 OR
 BSD-2-Clause
Message-ID: <20181008111154.170c56dd@redhat.com>
In-Reply-To: <7a8a3ccd-d78f-8e3d-4759-34297e8e5357@iogearbox.net>
References: <20181005212416.2525992-1-ast@kernel.org>
        <7a8a3ccd-d78f-8e3d-4759-34297e8e5357@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 08 Oct 2018 09:12:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 10:15:10 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> On 10/05/2018 11:24 PM, Alexei Starovoitov wrote:
> > libbpf is maturing as a library and gaining features that no other bpf libraries support
> > (BPF Type Format, bpf to bpf calls, etc)
> > Many Apache2 licensed projects (like bcc, bpftrace, gobpf, cilium, etc)
> > would like to use libbpf, but cannot do this yet, since Apache Foundation explicitly
> > states that LGPL is incompatible with Apache2.
> > Hence let's relicense libbpf as dual license LGPL-2.1 or BSD-2-Clause,
> > since BSD-2 is compatible with Apache2.
> > Dual LGPL or Apache2 is invalid combination.
> > Fix license mistake in Makefile as well.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > Acked-by: Andrey Ignatov <rdna@fb.com>
> > Acked-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Acked-by: Björn Töpel <bjorn.topel@intel.com>
> > Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> > Acked-by: David Beckett <david.beckett@netronome.com>
> > Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Acked-by: Joe Stringer <joe@ovn.org>
> > Acked-by: John Fastabend <john.fastabend@gmail.com>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > Acked-by: Quentin Monnet <quentin.monnet@netronome.com>
> > Acked-by: Thomas Graf <tgraf@suug.ch>
> > Acked-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Wang Nan <wangnan0@huawei.com>
> > Acked-by: Yonghong Song <yhs@fb.com>  
> 
> Applied to bpf-next, thanks!

For the public record:
 Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I do know, this ack will not reach the git-log, but given I have code
in the lib, I want to show that I support and ack this re-license.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
