Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95931C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E62E20881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKBDECGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E62E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbeLBXUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:20:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42923 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLBXUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:20:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so647705plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 15:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zsgLcjT0H6YdHMbSaD+Z6evg7HeQs0ZjtklR7yBmM5M=;
        b=sKBDECGoicfmE+Gci/tgIB6UowiQ/Wt5wVeJpkBd1JK3ya5raTwsIrTWoUoE6xpVZK
         Yy3CYoXEgkNKrbXMcDs5UORUpliUVPcBOXWSicPqjGoG0QkkkB/IZI8JUqFLiZd8Zd9L
         JMa6iYFb9zV/5VuUFZirbXjeyizKF/NbSTi33gpDv4DTdmwLx7B2SiZFpjngW5FCjziw
         IiHfyq2FbTXYQovW/wdm6gPFUbsZwLQW1amjLw8azvX4bWSBjRelY9i+XLcOrU/HK7Ri
         AJyvzDLvwbkppJezR9pBXBH+ZBIOHFMWztwLdLAyr03TI4CLaKqopugv93Pf91XqA6wq
         dyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zsgLcjT0H6YdHMbSaD+Z6evg7HeQs0ZjtklR7yBmM5M=;
        b=RQLFBqelntL+WBoL7FBgWguNZaia7zR8RGORUbIfP0MQqYQpspu4pPZ4BvL92WPwSy
         Ymx+3JIqRNuIo/6M6marn73tZ2PWrCs8ODD13rrhQfeDWWd/OMjWfKTU3ITcOfOFyE3D
         c5UXXEobrRvSTZQqmgEtHv01KXEmWIBqoA4AGn2QWq3tY1gljVhRISzj988f3ufUD1lU
         X+fbZnGE/16cUngc3GJM+6BnPa7Qb3PuN9PpPiX13WL0aoiqAbNTjnUFdEXkFwFImoCK
         PSLRCng3KQ0mD3L5ETW9BmiJLiAIyQC1n7CqTNm/WiD0dv27a4sW6CHsg1v30reeNjKn
         FddQ==
X-Gm-Message-State: AA+aEWZKyZZnthIsCk9STMo4ishkbUR9eTgPGzEXGoQ0XqfTmN8r34wB
        gD5WC4Pjuz8IOaj/xxHzMIYQvFX8xlE=
X-Google-Smtp-Source: AFSGD/XcjES1J6CeZkwP4fqiR3XT9Re5DEsY0uAc/sENXA8XpS2cBpcpO2tuC82ptRXlNMzyC5jgyw==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr13644101plk.206.1543792829126;
        Sun, 02 Dec 2018 15:20:29 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id g70sm18562179pfg.98.2018.12.02.15.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 15:20:27 -0800 (PST)
Date:   Mon, 3 Dec 2018 08:20:23 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 0/7] zram idle page writeback
Message-ID: <20181202232023.GB21560@google.com>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181130043656.GC605@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130043656.GC605@jagdpanzerIV>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:36:56PM +0900, Sergey Senozhatsky wrote:
> On (11/27/18 14:54), Minchan Kim wrote:
> > Inherently, swap device has many idle pages which are rare touched since
> > it was allocated. It is never problem if we use storage device as swap.
> > However, it's just waste for zram-swap.
> > 
> > This patchset supports zram idle page writeback feature.
> > 
> > * Admin can define what is idle page "no access since X time ago"
> > * Admin can define when zram should writeback them
> > * Admin can define when zram should stop writeback to prevent wearout
> > 
> > Detail is on each patch's description.
> > 
> > Below first two patches are -stable material so it could go first
> > separately with others in this series.
> 
> I had some time to look at the patches
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> Will give it some testing later; next week maybe.

Thanks Sergey!
