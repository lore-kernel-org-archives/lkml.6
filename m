Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60D3C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8098C2156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="FXxHo9MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8098C2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391686AbeIVGCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:02:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41963 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeIVGCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:02:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id t39-v6so3489602qtc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0984RIY0Al4Htf5boVt6F4f7H0iJckgvtVwmVzjHiMc=;
        b=FXxHo9MY1UlLqTTqc3QXhhw+RtXRShm6BwnDYDmiV3WdeVnfg0EEzLA4UBCcO9lXL0
         9XcLs9NT+GYiuDRJRgytqnWMkEslWqvwR7Knr97UGI88zwCCTOMtEGbV9v1scLQvcpfq
         AShkgrpb3iPHqy/yjz4jBFFeXmzH1bAzpnTwVnM7j41SCAVFtARNDO3lQ6JrXO3vsWej
         zemob7wTNCH4KlPPkx10YJp/nGonLR1LEm24EVwaPV9cCt4PyPZgJ5I3s0pdY+dblJYg
         tmkROqYrB5E6YYq1klU7WPxL0DnH2fdB2G6U1tqmV9veApg/7lg6nyAxVZ+8Upxi/Uf2
         yERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0984RIY0Al4Htf5boVt6F4f7H0iJckgvtVwmVzjHiMc=;
        b=Ddw6ersxc+Da5Xo9StNpxTKDsmAFOlWfY7s5FyWXdPE6iQb8mS4n4AO+cb22nThf28
         gqL2Rltr9SJQO08qoh16leGAXIKbzv49w9FOri4OPfZhP+WJf8r0OuQOj+Z7Mxr24bvW
         mM8Tu9ttx9Ma5Oza0zAYKsh16WmWZh5HnL7I2OEISd5aOZuKZm37ibPicVyBeG9B+jF7
         mumWaYtmhdA5FMlZbVE9/NX3XdMIF3kBoi0BYfRCoJ5+5pVC2eL3gYaeuCMjEQ3dE+Fu
         3YBqVyU5izQm2ZewZ7NiqDdxS723jTa6xl8I1WeRNDXxXb1Y1/iPkZVoc+QnRHHmBU1a
         TBIA==
X-Gm-Message-State: APzg51C5XZOpxZUbMrwkyTiMeQaWd5BYW8EN3X7lUVd79dOFHPnFmFkB
        8/Kjw5w02oCLygJr/T10dcPBzA==
X-Google-Smtp-Source: ANB0VdYrurcy8S8i4lLZAhyhKjQoCP1udSt0SCamscqDzV2DjpdR9qDgl61rdjtnEX+yDQKLhQQrfQ==
X-Received: by 2002:ac8:6989:: with SMTP id o9-v6mr87770qtq.244.1537575088441;
        Fri, 21 Sep 2018 17:11:28 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 39-v6sm10323015qku.18.2018.09.21.17.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 17:11:28 -0700 (PDT)
Date:   Fri, 21 Sep 2018 17:11:25 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next 6/9] bpftool: add support for
 PERCPU_CGROUP_STORAGE maps
Message-ID: <20180921171125.7d663add@cakuba.netronome.com>
In-Reply-To: <20180921171353.11050-6-guro@fb.com>
References: <20180921171353.11050-1-guro@fb.com>
        <20180921171353.11050-6-guro@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 17:14:12 +0000, Roman Gushchin wrote:
> This commit adds support for BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> map type.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
