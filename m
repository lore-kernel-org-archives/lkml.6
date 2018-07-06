Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA25C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8596322BE8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="nay5RNq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8596322BE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932374AbeGFVDM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:03:12 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37903 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbeGFVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:03:09 -0400
Received: by mail-qk0-f195.google.com with SMTP id y4-v6so6997812qka.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=khxAGRxjktZf0vgHsenENbjCDhwJBsTgp1pd0jCOXqQ=;
        b=nay5RNq7nd85QB7X3SY+L/51EB5O8Uq//CaqOxeqrZDHmJRbZjnb6Br0ubemjWz9aZ
         CYbkOAAtGYhIbaFeOG+TDFIiBqVNIflaBCNoJ9oGcoOU3XDaQlztdx9eqZ8kE3fvG7fC
         mdTcn7R7JmUSTONOyrhQCSkAmQ1/ipwO4g+cTBMQTxQ9pVwnjX3bkqzntLwVRTTh4yk8
         6YHv/B8gT0VXhpi6EuAYPKJJ6FS8BPw6pDDcMH95+mLH8rXEYgLVoQkMmjybihUYRD0Z
         VSfScuQfT3cw075Y30drFGVp/UDY4EUtTz6RGYTZNtN842FUXosx7/zgryV4isXEfKPm
         3yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=khxAGRxjktZf0vgHsenENbjCDhwJBsTgp1pd0jCOXqQ=;
        b=Q7pUOQwDQybGNWiz4QQGMcyweKcAn0FnobSKLt6rKrtBE8KxLHHk5gLlmtPhhiN0KB
         BR1h0nRKNvC4pvBSmGwAgxCasRrTWw2Im4aR5/5pSwB77AflpEKXnxGidAfFeFeuTkuf
         rR2gPqggp6a8noLFf3MlbA9Bop7P90e/SEQHu4rYVOzdjOQIcPgayN2iWeF4CvsQdV8v
         F4ySCgdQ0hRA3P7eiGh9wjNl/4hycbgtBAB4VwcYnRk77mCOUvnTx8DxXKzaN4/kRIlp
         D5cJk8Tq3MpYLGAyDSPsjH8oXaGmfsTzCr7N50VRp6S6iZfmDxPjb3K+THadG4YIaOP0
         psAg==
X-Gm-Message-State: APt69E3YdgxEQjuRj0Kx6WtBNJx8cTNrrZBTcFF0rRxH36Mqn3YDcYwl
        2sk8Cvspa2FrYSLOPacR2K8OCQ==
X-Google-Smtp-Source: AAOMgpdRRrgAWMJRXvYSNNAunLGRjsp7y7U6usk05PdzWCOjaenxPA3o/q0baSnJttJylTH9ESoOag==
X-Received: by 2002:ae9:ed8f:: with SMTP id c137-v6mr9909382qkg.276.1530910988836;
        Fri, 06 Jul 2018 14:03:08 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id g8-v6sm3679406qth.77.2018.07.06.14.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:03:08 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:03:04 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: introduce cgroup tree command
Message-ID: <20180706140304.6de698a9@cakuba.netronome.com>
In-Reply-To: <20180706182542.GA27167@castle.DHCP.thefacebook.com>
References: <20180706010521.23097-1-guro@fb.com>
        <20180705190116.7737d66d@cakuba.netronome.com>
        <20180706182542.GA27167@castle.DHCP.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 11:25:45 -0700, Roman Gushchin wrote:
> > Looks very useful!  Minor nits/questions below.  I think the reverse
> > mapping could also be interesting - similar to how -f flag shows where
> > program is pinned, we could add a flag which in 
> > 
> > # bpftool prog show/list
> > 
> > adds info about cgroups where the program is attached?  Obviously as a
> > future extension.  
> 
> Well, it would be convenient, but it's not always possible.
> A program can be attached to a dying cgroup (a cgroup which was deleted
> by a user, but still has some associated resources, e.g. pagecache).

Ack, the bpffs and cgroupfs searches are best effort by definition.
Thanks for addressing the other comments!
