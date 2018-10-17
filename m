Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97397C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1F2214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mskXCJNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1F2214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJQMmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:42:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38967 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeJQMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:42:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so11907799pgv.6;
        Tue, 16 Oct 2018 21:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GHeqtJM0vuZRRzvMM8i1rH6oMLiZVbiuWqXSi6x+XCI=;
        b=mskXCJNUbC8/OKxFq4FuB8UINCp8XmHjo2CPX8MXV+eyJeaD9qwOB+NtDVjqxGMfg8
         RccxD+Vx6Xvw/F8DwOOXApsUzWr5E+HSd1Y+YGD+rbPwrrGjH+B0POokD580mz4vImEf
         0F3EUHd1JCI2ew5UvNQLqduFONRrF5r9+ha65sHlAjfv+a9qflCRw8S+Ffc+OJyOZAKW
         8OIyR9jkBN/oALN1HeNq7CyjVLhYF87iigvDZwFHnjJUyNrKvKHhAVtETKaLNdzcChdl
         Iem+4t4rTcX/iLjegD6c7p5ux1K3hRNjwhiE8dvAPZ21LUQkw3x65KXM2aQXMzxXr5+s
         hWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GHeqtJM0vuZRRzvMM8i1rH6oMLiZVbiuWqXSi6x+XCI=;
        b=cRghaZ8aSNeVEX1vwiPTkljus8odLFxh21bict5ycfd1HFT82ZWH2cEqm8kZmlOTvz
         qDdJXGPZaMb9az2yrhEBv3TcjVHw4XLXyCqD6o+6Eb5y4JUujjJBekBcLtvsPWhbRMrL
         lMKuWVTbfvhcvrRSwfU2F6b6IAU0pdJQpWP+l9IcXyi70wqXfS7ZfVyNvxpO5yTzzA4e
         5i0AfBwlrG/4CR7HvTRWFGLJi+fZV4YBUqHyeh0aOWEwPF82S+VPQa45O5x3Rr2RYjmj
         NtQCQNWaSSDMhG+P9dDgPXaDlewBAp4TEg9g3KEub2iPXm4ivq5j+ObOEHof+Bq6ytEe
         cdfQ==
X-Gm-Message-State: ABuFfogDrJrsB+uavQarBR4YSB7B5Rr2PH3IJhTb6g23a04sDYQJogmH
        sbWhzwXl6Qvq2utNzeCOOaiJ8BPk
X-Google-Smtp-Source: ACcGV62tkBdYXx6pvlfj9h3CK7QA0Tb9rTOfszh7VdzWd690sU3TeNTGxyzhqS53ovg8A3HhQNAB7Q==
X-Received: by 2002:a63:680a:: with SMTP id d10-v6mr22780694pgc.7.1539751728341;
        Tue, 16 Oct 2018 21:48:48 -0700 (PDT)
Received: from localhost ([110.70.53.52])
        by smtp.gmail.com with ESMTPSA id m11-v6sm18090891pgn.39.2018.10.16.21.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 21:48:46 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:48:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Message-ID: <20181017044843.GD1068@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/16/18 14:04), Sergey Senozhatsky wrote:
> 
> Fix this by setting oops_in_progress before console_flush_on_panic(),
> so re-entrant console drivers will trylock the port->lock instead of
> spinning on it forever.
> 

Just a small note:
    Regardless of what's going to happen to the series, this patch
    deserves attention.

	-ss
