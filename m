Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E4C2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tq3imsKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E4C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeIGFA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:00:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35344 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIGFA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:00:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2-v6so4771612plo.2;
        Thu, 06 Sep 2018 17:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tL74StsZJkQ5WyuX0U0YMaIuDr2w7zeWNFvlIW+D+E=;
        b=tq3imsKPdg+Mpir2X7co712IbusDAepwT82xGgrfayhvQ7dNGf7e06O+Kp6CKjzia0
         8ab+R2DZhRtTzl7sWxGNwGWihGsKtYc0XM0/GQxBg1bHOR2/liFqWWfQ3wbuk8lOqoAk
         Sab7LXDBELCowYlU7+dxInsPKbcJrwB+TAMwPbzFLI2ZTF4MJbK+b0XmVYq8lpbapfEA
         1AWhOZdoMmo5P5tAykkJsMbO3teEkwiLrh/A8G/KxDA9D5UWSfI21DQyyAMwjcuQX/8S
         dsFGepaowZCk2xN1KB9dHGTQGhsgjGQOEFioBG0KWmC9h8EuCPujXg9wmHPMTfzXcJSP
         bmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tL74StsZJkQ5WyuX0U0YMaIuDr2w7zeWNFvlIW+D+E=;
        b=q5PWA3eDtzARIvoBYfwONXtJW725eFtNDZCDl0OUGoC5e8yOyNb+1Z+fQHDuO63Ogm
         YBmEDYViFbREVrWklJaBumijCogxKbMboWVj3pocwtkaw+9Mgi5U6jMdYfKbLoD0rBEK
         Gv94AmCz63xE6B9YQXFrDtfrykuLGDHOSCRTQdgIIi7ssl4fkmrEr5DFo8/XFhhZn5Ug
         ah97+5yOF1cZcnX4qYvHylAkfLa4xClf9YZJT1yym4bZO8iMZEigAGukwcF0+AjMwav5
         LbdySk4fgp5W2ggWN1kN0lrH3+3u1KG+AVKp5ziO/6BFDfnBRKp1cCotTvHcKgUMTqyj
         lQbA==
X-Gm-Message-State: APzg51BUdfmST9bT7awmwh6vobz+Jj5EE6ilI0UueRtFWeQjkr5pAyE1
        LNjKVsIGoMujxXxQmKwDnKKwYL+3
X-Google-Smtp-Source: ANB0VdZ+ri2/UCXJRX/TnYYnHoMB5cPy1RnjAJiyslwWq7+Lh81cx/OX2IdU8N8X6XOD3A/nrEHDBw==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21-v6mr5336962pls.284.1536279746396;
        Thu, 06 Sep 2018 17:22:26 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:42d0])
        by smtp.gmail.com with ESMTPSA id 3-v6sm13685760pfq.10.2018.09.06.17.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 17:22:25 -0700 (PDT)
Date:   Thu, 6 Sep 2018 17:22:24 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20180907002223.tpizglyhrwn26oox@ast-mbp.dhcp.thefacebook.com>
References: <20180907101923.4d2a85c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907101923.4d2a85c6@canb.auug.org.au>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:19:23AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bpf-next tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ERROR: ".xsk_reuseq_swap" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
> ERROR: ".xsk_reuseq_free" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
> ERROR: ".xsk_reuseq_prepare" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined
> 
> Caused by commit
> 
>   9654bd10da60 ("i40e: clean zero-copy XDP Rx ring on shutdown/reset")
> 
> CONFIG_XDP_SOCKETS is not set for this build.
> 
> I have used the version of the bfp-next tree from next-20180906 for today.

merge conflict and build error...
Bjorn, I'm thinking to toss the patches out of bpf-next and reapply
cleaned up version of the patches...
what do you think?

