Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5317AC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4BB240BC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="JtfWzV+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4BB240BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753927AbeGFCCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:02:02 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:43618 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753634AbeGFCCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:02:01 -0400
Received: by mail-qt0-f171.google.com with SMTP id f18-v6so8811168qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=I5dNfsQMimSoFScRX8QsDaB1T4++gB20PBlCmdLq2ew=;
        b=JtfWzV+QlMpSl9AShKnWu+ick7Wx/6onj+Qocams7EIKQn1c5+Y1SzlzmGtG5GrHfB
         AxHXVx+KY+bYZa7fwLkisinFNfQFtrYsfxiZ58wk6YSzyAe6qW844bmlQ8J/q7yiPb8K
         zYtg7A/DmfuXR2XdgzYXnqvDZZLj3dUf+ICinEWhF7O8oyGhWVIFmFsaeDCzBgT7uORc
         hnDY2DR9/9EZv3cT6M3eezUn9xsC0i5KC5zgji6yU5ZSJBgdnecSAkPknWTeHnua7z40
         zTaF83jUNl6nOq/CAV30hw/yH8BHFsWgnyGS8uts5sg0uPSe/rO92pO3rn7fWGn1hOLr
         axTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=I5dNfsQMimSoFScRX8QsDaB1T4++gB20PBlCmdLq2ew=;
        b=uIm+nSHAZJNQm3AEx1FO5O79bp9DXmzTMpEl0eheq1ZYJn0NBnWsULonnAKoOme4p3
         9uNFq5Xmdf46xOBzUlBP5qCDY3x/0TKp08jjNtFAKvDUMPWKaCRighFCDYNbbF/UCzIA
         cPlfRAxGVR0BXVyCpQqoJfT0vTpXZKoYfbppAHubgC4bWghcaQVFqesRlZQNQUv958Ly
         +v8apgy3pvpSBSuUGXXMdLjFJkT0JxKC9NUzujoi84G2sCOnXSYBKaezT2j14kMnTLGj
         ou25D7lJ6oeSpiJJ/GvXYFqcenf1UnX4Cwy6vhacq13c68PCPoFvs/AlcbH9JBlMJnqt
         ZIUg==
X-Gm-Message-State: APt69E2ua13hJIBbFjwyfYRFdB9qyHx2PDgJnkPLcOsfoUMD98pr9EcX
        q99MJQM32DCLMB8waIQDpDpi1w==
X-Google-Smtp-Source: AAOMgpeCFd0qpAZG7/UV6eXdMqgRpgOToFTK0cQJxL9+ky3cyXozVWEKC9/q1o19a4RCUp18yeZceA==
X-Received: by 2002:a0c:af04:: with SMTP id i4-v6mr7209852qvc.125.1530842520483;
        Thu, 05 Jul 2018 19:02:00 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id s39-v6sm5829585qts.42.2018.07.05.19.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 19:02:00 -0700 (PDT)
Date:   Thu, 5 Jul 2018 19:01:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] bpftool: document cgroup tree command
Message-ID: <20180705190157.17c5f5ad@cakuba.netronome.com>
In-Reply-To: <20180706010521.23097-2-guro@fb.com>
References: <20180706010521.23097-1-guro@fb.com>
        <20180706010521.23097-2-guro@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018 18:05:21 -0700, Roman Gushchin wrote:
> Describe cgroup tree command in the corresponding bpftool man page.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
