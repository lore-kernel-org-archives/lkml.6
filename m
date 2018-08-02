Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68231C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4AC208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4AC208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeHBJw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:52:57 -0400
Received: from www62.your-server.de ([213.133.104.62]:42839 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeHBJw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:52:57 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fl8ZO-0004Bd-Qc; Thu, 02 Aug 2018 10:02:50 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fl8ZO-000EtS-Lc; Thu, 02 Aug 2018 10:02:50 +0200
Subject: Re: [RFC bpf-next 3/3] docs: Split filter.txt into separate
 documents.
To:     "Tobin C. Harding" <me@tobin.cc>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jay Schulist <jschlst@samba.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180802062848.14332-1-me@tobin.cc>
 <20180802062848.14332-4-me@tobin.cc>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <514b4a99-5ebd-9bb5-f6f3-99fe1b19c25d@iogearbox.net>
Date:   Thu, 2 Aug 2018 10:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180802062848.14332-4-me@tobin.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24804/Thu Aug  2 02:43:46 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 08:28 AM, Tobin C. Harding wrote:
> In preparation for conversion of Documentation/networking/filter.txt it was
> noticed that the document contains a lot of information.  The document may be
> more accessible if it was split up.  Some parts pertain to everyone, let's put
> these bits in core-api/.  The more hard core bits about eBPF internals could be
> put with the other BPF docs in Documentation/bpf/.  There is a small bit of
> information on testing and miscellaneous matters that are useful for everyone
> (everyone does testing, right) so lets keep that info at the bottom of both new
> documents.  (This includes the original authors.)
> 
> Split Documentation/networking/filter.txt into Documentation/bpf/eBPF.rst and
> Documentation/core-api/bpf.rst
> 
> Cc: Jay Schulist <jschlst@samba.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc; Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  Documentation/networking/filter.txt | 1480 ---------------------------
>  1 file changed, 1480 deletions(-)
>  delete mode 100644 Documentation/networking/filter.txt

Missing git add given the new files are not present here?

Overall I agree it would be good if we move all the content over into
Documentation/bpf/ eventually, but would be useful to see a full diff.
