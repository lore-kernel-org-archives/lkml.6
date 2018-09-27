Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022EDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CE5216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqJQsyc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CE5216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeI0WAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:00:43 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:46176 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0WAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:00:42 -0400
Received: by mail-lj1-f169.google.com with SMTP id 203-v6so2832826ljj.13;
        Thu, 27 Sep 2018 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dY9AZ8kgNICC4EbQrU+CNF2GgaaLz77sxR5KiuTaTeA=;
        b=pqJQsyc1B7E65SX98fMb4Yvlaa6EnVbE9sMQ8p2Q5WhkHqhRMliDTTEgoLY6URGs2J
         mxnMeD8kTSZXkZ0RV0bHz+kBGKacCGPHrBAY22KN7/j2S1E3tbyH09vpA9Wx04ljWoDg
         MFyyypJ6xvOlup/VjoA6f5vik5Bxzi1F+BW0bANg3K/VJFReJ++yVLIxHb61j6wdmLfo
         NlZlccrdAFo7G3JKnYh2ayUZT05oDAFp6UgodHLPQNSJ6Xar2UAgXdKQL1PchPx+VR1g
         jenApiD5REeWYj+UiebKAzJKpXRGMs+fDzhAMs/0T6w3ilvCeGJNdvDvJhjtZ7Cbct6W
         toCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dY9AZ8kgNICC4EbQrU+CNF2GgaaLz77sxR5KiuTaTeA=;
        b=KI6XemXUJNz70u27frkJNObn09qjm9I2Z+QiFBAsMKTiCrKmkybvaK8J00aSCP7B4g
         et4ZclgdgThdr7G8esy6VSD2Z6RE8cOOAdjTNIQf82+ZTDpSLPyUqyTir7yIQiOlciq7
         4SaoFayOul1UIKnTOehT4P/sB2dIgtDvxivmO6OptZggU0NHXRBw1ip4egslxthmMERg
         ZjAA3e6Zd8Q16njeqv3/3HYTcSECpby2qNhgsLY8yU44S/P26mMGc2s/YQxYTHbF+Luu
         pY9SKpzb2IFD82DJRiWYynXGgEkdLNgyorONejU04ADizyzrUo6bL4DXP7CZLEH8aujB
         6FjA==
X-Gm-Message-State: ABuFfoiNWVi+u9tqUrX5nIg+dOdSnHCqDKYXrFzF/S/uIaIFifxskOG7
        KCU52Y9X8ZrZBCyj9hhRGiM=
X-Google-Smtp-Source: ACcGV60l8D206FbwpATVmuDvCAiM6br8nEc9esDCnRQLgrQAEKKRQbjgzQY9Qjl4OerS4ZS4i5Heqg==
X-Received: by 2002:a2e:8e93:: with SMTP id z19-v6mr7026871ljk.86.1538062910289;
        Thu, 27 Sep 2018 08:41:50 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id r79-v6sm483491ljb.84.2018.09.27.08.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:41:49 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id BE3B54605C9; Thu, 27 Sep 2018 18:41:48 +0300 (MSK)
Date:   Thu, 27 Sep 2018 18:41:48 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, avagin@virtuozzo.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next] BUG triggered in ptraceme
Message-ID: <20180927154148.GQ15710@uranus>
References: <20180919070737.GB17524@uranus.lan>
 <20180919071056.GC17524@uranus.lan>
 <CAG48ez0d0mO3yN10ApgJuwt9DTDj6x+j_wtjz6qM35nGtxnUdw@mail.gmail.com>
 <20180919161301.GF17524@uranus.lan>
 <CAG48ez0bKkv1rM-NDMNJMVO94_T92VAe_ABbGud1aOh_7UxaOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0bKkv1rM-NDMNJMVO94_T92VAe_ABbGud1aOh_7UxaOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 05:35:10PM +0200, Jann Horn wrote:
...
> >
> > Lets wait for fs people opinions.
> 
> No reply yet - I guess I should just fix up the traceme case for now.
Yes please.
