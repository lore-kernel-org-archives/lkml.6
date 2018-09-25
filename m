Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8054EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2955F214DC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md71q13N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2955F214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIZAnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:43:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45607 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZAnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:43:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id m80-v6so10381117lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vtF2WnPfMp0rvBJ/agfJKfz0EM6aVYZy58VMrDEw1mY=;
        b=md71q13NyKCl5XXzv1XMn/yqhoCc1ZsnGr9vQkAK+k1ahnklJn9CFnpnjL8K/Npblf
         QKV3t27CrboM95OGmDGFry1igvoDN55Kg3NsYw+lwsndG1C2UKcn4JIsXTONM/r7uBBS
         hyb5LZnqFKhtPyDCjAYJateSR0LITjW4VczbQ21/F7bpQRwgpS02GPQtBi+SI2IJwOCJ
         LYI09MdbsmZuKZ+MVV6UlvclnVdhtrGNpgCn8qpqiGQz3knhblI29pPcGVHKjwEYZQGy
         h50Z2GNma+dFjMSDjV3bJgTdu2iKCeF8QNZxHSoz2EfgxYf99j4L5rtu7KADcjfgCxTb
         QPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vtF2WnPfMp0rvBJ/agfJKfz0EM6aVYZy58VMrDEw1mY=;
        b=lZ/n15iFvFW44z0S9MhQd/QBcWm+ND89hYoon6F+p5We/pdGuBG46K1Bf9mIOeUc6m
         sSHl3H9qsOF367xBNntEz9pPsxX+xmes//4vyVvW+km3jgUd64tUNfxRp57XP1YN5OGc
         l/mWZ9AL6lrKP3DDgOa70vlQaOc8euG1NSIZKMeEciozH7zZd2xutxDBx7ojs9UDL2Ke
         CIuLCo3ZwPlgor8fA5GxT4Egslv0LEk3dcDv5YUFsc/tG3Ecyvr9LyUktMJjU1GwdQ5M
         aoSbgnNjpC5zTcd6YsweddoFP15NSn69zjIgA7qsRkCybfJxc8Qzcz+5q4az2eH1YyiU
         hihg==
X-Gm-Message-State: ABuFfoi/f7jD4U8I6iHdvhhlZ7bFwcVa0PnHk/T1Id5fh1scTUEMVLyO
        SNk/BXKP1u7x+WrApFhxSsU=
X-Google-Smtp-Source: ACcGV62asRCNWecAl4Wb4gLKOEDDkuldbvtD6k1Rt2rL22XamhnnPA6vV2592Yn3P+rpmaSMQUCuqw==
X-Received: by 2002:a19:6544:: with SMTP id c4-v6mr1779140lfj.31.1537900468707;
        Tue, 25 Sep 2018 11:34:28 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id c30-v6sm551108lfj.28.2018.09.25.11.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:34:27 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 6F48046067E; Tue, 25 Sep 2018 21:34:27 +0300 (MSK)
Date:   Tue, 25 Sep 2018 21:34:27 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tong Zhang <ztong@vt.edu>, tglx@linutronix.de,
        akpm@linux-foundation.org, linux@dominikbrodowski.net,
        ebiederm@xmission.com, keescook@chromium.org, Dave.Martin@arm.com,
        wolffhardt.schwabe@fau.de, yang.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org, wenbo.s@samsung.com
Subject: Re: different capability from different namespace required for
 prctl_set_mm_exe_file
Message-ID: <20180925183427.GH15710@uranus>
References: <990D0DB4-35C7-4B7B-A938-2B984CD97E78@vt.edu>
 <20180925173745.GA20508@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925173745.GA20508@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:37:45PM +0200, Greg KH wrote:
> On Tue, Sep 25, 2018 at 01:26:55PM -0400, Tong Zhang wrote:
> > Kernel Version: 4.18.5
> > 
> > Problem Description:
> > 
> > We discovered inconsistent check when using prctl_set_mm_exe_file(), which is used to setup exe file link.
> > 
> > It is required to have capable(CAP_SYS_RESOURCE) in prctl_set_mm().
> > while ns_capable(CAP_SYS_ADMIN) in prctl_set_mm_map().
> > 
> > There are two differences:
> > 1)requiring capability from: user namespace, init namespace.
> > 2)capability bit required is different
> 
> Can you submit a patch showing what you think is the correct fix here?

It is done this way on purpose. The prctl_set_mm_map is a complex call
which carries a bunch of parameters and allowed if you're inside user-ns admin,
in turn prctl_set_mm allows to modify settings one by one. So no, it is not
an error but rather call specifics.
