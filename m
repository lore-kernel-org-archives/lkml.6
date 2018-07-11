Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C28520C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1OH8qLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C28520C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbeGKQvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:51:15 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39924 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733026AbeGKQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:51:14 -0400
Received: by mail-yb0-f196.google.com with SMTP id k127-v6so10259671ybk.6;
        Wed, 11 Jul 2018 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xlzPiX053faaHGVKKsV0zVOVgdPUmGIBb4zhwzhQMdw=;
        b=F1OH8qLnpZiZl8xYYaSkmsjg/ufeOqlCvTeqdGXzwh2U7cY/YfFA4eehrQ8y1MuMO1
         hyu/0PMgcS9B8d+V95g5SnHkdAcjwaFvvMxKe+INibg2PrSL1wFmkF7vwjRzBp4VH9+Z
         dZ6f/8pW7DRQCFeCsobmU0XtKfb8/BF+l7iSGfX+Jbe6o4ULL/VEBhtlGHC9IlxQcLcE
         JcdfYkKkHn4ol5FDDpTOiNmrkXuPavIZEii5Yl4WHBfrwn1jCWGAICuquLakzRaFOkrX
         ebN1LOT5I56/8vmDYNPSXZ2zx3Y8FW76iK38xmV9Lf6W+/Ro+7cFTLh0aMEEgn2seN8I
         i2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xlzPiX053faaHGVKKsV0zVOVgdPUmGIBb4zhwzhQMdw=;
        b=DnMYBruVyCFtgvRu9+2Ij6xpIyQs/Ey5VwnGCTxCTAaF7nn3ZVSBwzL10cD+zRR7NA
         bGDHPsGNPFq9DtXGmNFLrMW0NIdifsZCPYAGahrFs4VBFvpQHbTNixgmSTmM2R7tLMjh
         j+pyVFpQ1NxLyARHytsSn8sjAfkca9Q5ELCj+uEPEII8hBBKum7Z4o/xskzBsZhlh86L
         oVdOQfcQqlPPogn6NdwsMZ91Kx1BSllGdOc9SmqZYh3ZkxTLUn8ffmM6X/ZtVWDADV0G
         0HdwzLNDg6wcIyCh69rK2GbCJZUQtpJIJ25cw0reFthdbo5cMB0wA+E5rADvMt0Kukh4
         s9AQ==
X-Gm-Message-State: APt69E3mKqd+kkjsg3kYIC3yLQD2//ZcpsHRf88Syh0kyY8zS6568YIO
        HmvU8+mY8GfIEuJd8bMAvuY=
X-Google-Smtp-Source: AAOMgpf+53nlEm04qq8ZejbCGNSixoGTmrVqbsS/VijXMLs0q5OywVdEz7D+Bc0t2aAqNLc9GuhqVw==
X-Received: by 2002:a25:14c4:: with SMTP id 187-v6mr16407644ybu.16.1531327564102;
        Wed, 11 Jul 2018 09:46:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:7350])
        by smtp.gmail.com with ESMTPSA id x69-v6sm9039225ywx.105.2018.07.11.09.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 09:46:03 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:46:01 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 03/12] cgroup: use for_each_if
Message-ID: <20180711164601.GE72677@devbig577.frc2.facebook.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709083650.23549-3-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:36:41AM +0200, Daniel Vetter wrote:
> Avoids the need to invert the condition instead of the open-coded
> version.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route as you see fit.

Thanks.

-- 
tejun
