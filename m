Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014FFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1309224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="RG5TDmfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1309224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeKMFTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:19:21 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55788 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:19:21 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so5154493itg.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gO9kZ/RcbfPPpFGJDhchCr3tmKyBwqby0MPifK87gqs=;
        b=RG5TDmfOxUEnYzhdoVr1s03oys+KhRMqHCzUsqxJzgO44z7FKsM6+2K24BSO7/ayDj
         DdIW/2B+DR78R9vvDz6eCAInjaePowvSx0clDgz9sFib5uMVeTQr4HywKkrIRXCEocSQ
         jloxqpjlXeppgBgyYDH1N/OZELk6+4KUFdIpk9H3Z5B56sWD1W6HYBukotGiL4ZcqBy6
         YLYqMSUH4HZFwa3ooPInyg3kXChtm4GDEWJ87RMv2TGCcj/TaSk4SsV0HCvxBDtKuO/e
         mNCNsgPeIHpP+RCB6lpLf7x1idKbO6DRVBA5ha4Lr44g1yvpZ7T2USKZdzURaj+x/lnb
         xOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gO9kZ/RcbfPPpFGJDhchCr3tmKyBwqby0MPifK87gqs=;
        b=uFKkGycOXFYthoifQCcVJ1rmQKLiQRKxlWCRYLhPeWj0E8V2AD4XmQopELO7v9NTqE
         v6npcl0v3jhX5Qo24URu3baLHdPgSWapqcSM+SWHjQ9H6N8qs6bD11WK0khx+gydEgSj
         jGX3/Q9qIIQDXQ/pmzYL5NR9Ax+myZMiHfIa2kcPGrBOyfFczwtAASdJAKp5sz5FDErH
         UX8i1DhI/xAOFc4pnZtjI8pSh3nK830nJfvbxU+yg2djWC2WbDHO0oucxliFdSMy48zm
         c+rwF4j/sIX+5xDc2ZiZLyxea0d1XanlVVpW3vDCiCqgraEQ+j0VdKVlvYdvePz+Ydps
         QGiA==
X-Gm-Message-State: AGRZ1gLy4xbK2bUJ8wvW46tCJLJ7/+a98yQ6ZjPtOQEQqDSMFLorrtCe
        F6L5nsl6ZDgXoBQDHJc7ZPN1uw==
X-Google-Smtp-Source: AJdET5chLFfCe5Ub7EX7YTJBVttGPrSu53upkuwdvuWxec/XEdXgR/8s9yZtwBp8+9P/3L+7/HQgkQ==
X-Received: by 2002:a24:2ecf:: with SMTP id i198-v6mr870862ita.74.1542050685004;
        Mon, 12 Nov 2018 11:24:45 -0800 (PST)
Received: from cisco (75-166-182-157.hlrn.qwest.net. [75.166.182.157])
        by smtp.gmail.com with ESMTPSA id q131-v6sm5068218itb.5.2018.11.12.11.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 11:24:44 -0800 (PST)
Date:   Mon, 12 Nov 2018 12:24:43 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: siginfo pid not populated from ptrace?
Message-ID: <20181112192443.GL3645@cisco>
References: <20181112171144.GI3645@cisco>
 <87efbqi1xa.fsf@xmission.com>
 <20181112185538.GK3645@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112185538.GK3645@cisco>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:55:38AM -0700, Tycho Andersen wrote:
> I haven't manage to reproduce it on stock v4.20-rc2, unfortunately.

Ok, now I have,

seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1493) == info._sifields._kill.si_pid (0)
global.syscall_restart: Test failed at step #22

That line number should match up with v4.20-rc2, but it's in a
different point in the test than the first failure I reported.

Tycho
