Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812D9C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2271627A7F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0glbShTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2271627A7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935111AbeF2DrT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 23:47:19 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37747 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934308AbeF2DrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 23:47:17 -0400
Received: by mail-qt0-f194.google.com with SMTP id a18-v6so6748162qtj.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=LrcnF1mHoV+fdexFhgp/xpWWEpgM+Sd68gtaSSz3MKk=;
        b=0glbShTGrpyOXuUcV52EdxxbvEHJZk0S793J6TuX6dq+mTfPSYQfV3mPAm9QpdZZcu
         pYHrcXOPEpzIHL3elLC/AN+p6mK8NkdorBmOHAl5NBVld5ZqXiQJd68ZrI+lJwBI5ebc
         g7buWgAEFPIBdPdm9JzrA2yxZEPmRoykYdmDO83Wnzp/5tABhmSFvtrl8iW7wHd1G0nj
         aTk4bq7T7OWJqzTTxqKz420B/1rb/fbq6BXHmVYG0YGUH1Zh6VULlgD5fgxrIlrZqfB9
         299+qEvIFFA37LrGe8ntZg+jcTeHkMljVm9JaqUpxGdPIyEOFUHDuU7SwRWpa6fa/V7D
         Hrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=LrcnF1mHoV+fdexFhgp/xpWWEpgM+Sd68gtaSSz3MKk=;
        b=WXuXEouJd40jyfm0mlpIsowlLhRmk8J+j01mfX+DDbDEIvrrgXpfDo27ZEy0EeT/Wb
         Jrflu9aT1l/btBQW3kj7sxgIfXt/8kFjJnVvtIkbtYHs/Ujp46owbCAuFnrsx2mMUTGk
         KF0BZwqwVqkO1vRnfiqMGJ0rEAGMy/JFKOjL8rgIc1jt5RrPUSKv7IYW2/LBwZ0UrI8B
         KbZwAdhRWGaoG4XUzG6QVtrfPq58erzEIu37JXXj6M24arT8lhcRTbdzN7bhbAzWRfgb
         w5mFqq/w6qdo2bYiCwK1Wrxn1vkZNew1oCOIvBep1hnxvIhjXSnfom+k+gvDuirYt26p
         smhw==
X-Gm-Message-State: APt69E3CzzprbGIfu2AoNSoH7aKjAwqaVf+aikZEhM5n847Dr3okBhoZ
        6R1erk27hwMvu8sHvbVC+6JPew==
X-Google-Smtp-Source: AAOMgpeZ3VAdpnlRF+JGApKXWMlauQb1NEG1YjFp4teaFYXoapTbHHNjy2ZtBo+vClxEnYlaIe1cLg==
X-Received: by 2002:ac8:2cd1:: with SMTP id 17-v6mr3454731qtx.360.1530244036856;
        Thu, 28 Jun 2018 20:47:16 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id o31-v6sm5596147qte.16.2018.06.28.20.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 20:47:16 -0700 (PDT)
Date:   Thu, 28 Jun 2018 20:47:12 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <tj@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 10/14] bpftool: add support for CGROUP_STORAGE
 maps
Message-ID: <20180628204712.35f7b4c1@cakuba.netronome.com>
In-Reply-To: <20180628164719.28215-11-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
        <20180628164719.28215-11-guro@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 09:47:15 -0700, Roman Gushchin wrote:
> Add BPF_MAP_TYPE_CGROUP_STORAGE maps to the list
> of maps types which bpftool recognizes.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
