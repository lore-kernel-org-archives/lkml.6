Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D395BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DAC20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDaAZhxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DAC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeLLGGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:06:22 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:42590 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeLLGGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:06:22 -0500
Received: by mail-pg1-f171.google.com with SMTP id d72so7821461pga.9;
        Tue, 11 Dec 2018 22:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x6tN0yT304LL38AhQvcgGoUROWlm9Cb4VIxs4JaTZs8=;
        b=CDaAZhxOShwynVkJF2fI1tw0s+ZvArVrBUJCzNTsFWFBM7//PwCE/g2vCgKOt660h3
         ase66W6M5dZhtZligIrm0QsQIm/0KAVWERFSbKG3EhPG8SyoNsxJkKnzFO/v83laoz7k
         b+4pl/s/hmx4z74l2G8kFpWyikpW4fHWs5i6xoVxQGW94lMJ+StcjzX3ZWC3WwV7XzP/
         yU12h6Y2v5GljBQ3v/TI92WkynXho+sUmHHBNFGWeEUnOkllsAxA54ihgog7kWKPx7hL
         szmJzOhZxNcbNHp1oTHkgQGSKkM0GoAcBfzXhHVqF656pWpcAE8w5kStldqhjysAxI8p
         5AZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x6tN0yT304LL38AhQvcgGoUROWlm9Cb4VIxs4JaTZs8=;
        b=KGZkIoii3P8ZA/FXnT952PJTDN62hk7q9DYWUV4pvNCyqZ/PZ8Y3wd5rAzEovQEhCN
         dkianCNbjK+xQhHg2rdBy8vLna7kPFatKFnwkz8xQjeF6xKJjem5k1iaVOnkOlfWxnY9
         9XNObMjI9ah93t9pmSgWaOobkmpEwkw6DkM1XSGENFX3BlfYwYbZ7i+5mj39MjpFbjKM
         bncQls8Pu7ylbU2ffGxis32HFFW3cGBwNkCgz72HPRy0Z3NKDHWuqeFGfxy0e58W/oqn
         8WAfbtHCSeAASlGWbjJeADyMINUjrsYcazyrc1TcXHhXDCabKSTWKu5ghQlxIUWh+HgX
         zMnw==
X-Gm-Message-State: AA+aEWZl24JxaqrbF0sQt7XTVqPA2OrzbteBena2MOBGCuzIRCMmkSpI
        Qy0JTck1Red+lt+c/2fWg6Y=
X-Google-Smtp-Source: AFSGD/WkEbxeep96PPY87C4h7M5wRqqWaNnG+n2mXG4WCxMQTnOgiFK2HSpkwV8xwXVyxumYR6zeTw==
X-Received: by 2002:a63:fb46:: with SMTP id w6mr17390683pgj.321.1544594781313;
        Tue, 11 Dec 2018 22:06:21 -0800 (PST)
Received: from localhost ([211.246.69.141])
        by smtp.gmail.com with ESMTPSA id a18sm21406287pgj.30.2018.12.11.22.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 22:06:19 -0800 (PST)
Date:   Wed, 12 Dec 2018 15:06:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Message-ID: <20181212060616.GH431@jagdpanzerIV>
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
 <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
 <20181101014821.GB502@jagdpanzerIV>
 <20181101080808.n73lrlnjd65nk4qf@pathway.suse.cz>
 <20181122131202.nkcurdt5k6jrhowa@pathway.suse.cz>
 <CAJmjG2-_8T6uJP54-+gUG7Aq7kNqkAKAEXbzzV9JVKyZFRh4GQ@mail.gmail.com>
 <20181212052308.GG431@jagdpanzerIV>
 <CAJmjG28oiU0unnfx_KO18F3oeMvsKHsJCuKbLiC-_ib7cDjG0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmjG28oiU0unnfx_KO18F3oeMvsKHsJCuKbLiC-_ib7cDjG0g@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/11/18 21:59), Daniel Wang wrote:
> No worries. I will follow up. You would recommend that all four
> patches in this set to be backported though, right?

Just the last one, which makes consoles re-entrant

	panic: avoid deadlocks in re-entrant console drivers

Because only this one was applied so far. The reset got stuck.

	-ss
