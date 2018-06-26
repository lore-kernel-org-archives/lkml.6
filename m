Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BC6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2B42405A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2B42405A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934011AbeFZKDk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:03:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:45396 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932544AbeFZKDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:03:38 -0400
Received: from [62.203.87.61] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fXkox-0008B6-Ul; Tue, 26 Jun 2018 12:03:36 +0200
Subject: Re: [PATCH v4] bpf: attach type BPF_LIRC_MODE2 should not depend on
 CONFIG_CGROUP_BPF
To:     Sean Young <sean@mess.org>, Y Song <ys114321@gmail.com>,
        Matthias Reichl <hias@horus.com>, linux-media@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
References: <20180618171216.gearpr755pm3wot7@gofer.mess.org>
 <201806190203.kfm0Xhda%fengguang.wu@intel.com>
 <20180618230423.nk2ey2755p2zkqmv@gofer.mess.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <57baf751-cd2a-dedf-05bc-9ac3b4e050be@iogearbox.net>
Date:   Tue, 26 Jun 2018 12:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180618230423.nk2ey2755p2zkqmv@gofer.mess.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24697/Tue Jun 26 06:38:09 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 01:04 AM, Sean Young wrote:
> If the kernel is compiled with CONFIG_CGROUP_BPF not enabled, it is not
> possible to attach, detach or query IR BPF programs to /dev/lircN devices,
> making them impossible to use. For embedded devices, it should be possible
> to use IR decoding without cgroups or CONFIG_CGROUP_BPF enabled.
> 
> This change requires some refactoring, since bpf_prog_{attach,detach,query}
> functions are now always compiled, but their code paths for cgroups need
> moving out. Rather than a #ifdef CONFIG_CGROUP_BPF in kernel/bpf/syscall.c,
> moving them to kernel/bpf/cgroup.c and kernel/bpf/sockmap.c does not
> require #ifdefs since that is already conditionally compiled.
> 
> Signed-off-by: Sean Young <sean@mess.org>

Applied to bpf, thanks Sean!
