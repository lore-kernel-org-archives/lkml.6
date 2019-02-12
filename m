Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44345C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E201222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByE+ik3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfBLTTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:19:25 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:42077 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfBLTTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:19:25 -0500
Received: by mail-qk1-f182.google.com with SMTP id y140so9404314qkb.9;
        Tue, 12 Feb 2019 11:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5kwXFcR2Bp/e9+qrSDBdBsegMhifi0I1gMYQmjpXrpQ=;
        b=ByE+ik3GcZLof5aZTA+Ij0cOcY3g2FtL+oP8Jw9llINkY44+C7Ys6FG71zCUN45Q3b
         vawSf4eC7voH2Umq381v6M0Biba6yTMUVRDjcxJIdJPQpTER2G1/7aFKyowHgLKj7XdY
         +fHEJtKEZqwzaGQ3oYzHO9Mri1TFHVtRzZF1GTjXXXmyX+79qTik9F6OHVPqKeeSxRKr
         kGiGQ5mtoaq77zR+Lc18J0cXAM6aKMXoZL1JSNalga8i38vdD8CiHOcA+mLsg+vHweH9
         TCVKGdnZgNbAtECu5nrtRRo4a9uCPoR3d8I+xIQH3Rv++3dlOrwW7czqecFBaEk9BNQ5
         BTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5kwXFcR2Bp/e9+qrSDBdBsegMhifi0I1gMYQmjpXrpQ=;
        b=KgdtwsUW1CLcwCxMpgOnta1YTl7YiRpaIAgL6kZbSRQs58PwN+mJ2bNDWKSwgOMtVl
         j2+vd1f9Az5UoLmMFSwJX8wZwyPm3MF3pS1APro94C/iRWTnhAy22fUWFiZ3ykHJAZD5
         20GF9QsH22M7a6cT2OZkXX/EL1JU/DfMp+3br5RN2eihODfy5Nof/ANjrHXI0R8kdY8c
         49KM+FyWGIKdjALHqWFuLN4Ar4iBePWe7GXbl/i6x/Ul6aV4LgXxYwjsqCA3SrUpdqy2
         7rPJumVuoK2y62rCRt05ZaxkTGz5FMVpDBYMc3O+95ZaXsLGXy64zJzg+WUyUDUpohyL
         pdsg==
X-Gm-Message-State: AHQUAua8bwLyXak4JdncN3+y8UXFwAtMpiScF5pCufcLC0NcI1WT9Ir9
        VSoaixcjli8K46mACjWuC/0=
X-Google-Smtp-Source: AHgI3Ib0f15Y8+obEiRu4dCSc/ymnHXXOcJ4ZXd2NtmnLOqyImCW2u+C5dZFras5PbRFqiGfNUSflA==
X-Received: by 2002:ae9:e8c4:: with SMTP id a187mr3708971qkg.150.1549999163829;
        Tue, 12 Feb 2019 11:19:23 -0800 (PST)
Received: from localhost.localdomain ([168.194.160.109])
        by smtp.gmail.com with ESMTPSA id 81sm931063qkg.75.2019.02.12.11.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 11:19:22 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 7FDD0180C61; Tue, 12 Feb 2019 17:19:20 -0200 (-02)
Date:   Tue, 12 Feb 2019 17:19:20 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     syzbot <syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Subject: Re: KASAN: use-after-free Read in sctp_outq_tail
Message-ID: <20190212191920.GI10665@localhost.localdomain>
References: <0000000000002015db0581b71858@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002015db0581b71858@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:04:27AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d4104460aec1 Add linux-next specific files for 20190211
> git tree:       linux-next

I can't find this commit. How can I know for sure which commits are in?
Recent patches are involved with this code, but not sure what was
included on the test.

  Marcelo
