Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92024ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC9220671
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbZAeze5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC9220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbeIUAaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:30:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35263 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeIUAaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:30:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so9360881ljg.2;
        Thu, 20 Sep 2018 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ulDKblaPWWY8DPb+24wHflg2KDWL8q/0jFvyU7lySk=;
        b=JbZAeze5NNz+INoVjfgrubrPDO5vb7l7Z5vn1HyoraJAvH24WuNwGb9qOrQ54gUKR1
         2HKk6tcaXJczuC/QQAGd1b8O/biu7XAStt2F7EJQB455as17ev1lmKzTRWUlq2Y1zKO6
         ieJgI0dNbzmwnxTkxTSORLvWB0ZUL5+bYetZpvMx/oUmoiUFiiWPdjTQaLIYRW29Hd1I
         JfXm3+jkIJmv/Buz2sgwUpiQcGzkktxHcWDujw/1r+BPCzrtS/ieWtdZP8G9aTXp807F
         YwBIataGLBbpn21BuFPjKkPOV+pMX69HkK19HFIonGgOT4Q9uVwKMKluYEPNuRXazyQT
         shkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ulDKblaPWWY8DPb+24wHflg2KDWL8q/0jFvyU7lySk=;
        b=maSyPC8Sb7v8Gs9Ir0oIfiXUzsU3PBQuAE7vLkAsTQigmeXRU/zWjy5I75asNWGlbD
         znVYYqTXNE2+sqRASGUz9PPO+qD4CeCLQQhnHZATTp8ywGl5DqSJiyRvYPbSlHMWR3mJ
         eRX9sCu83qtjUwKU1F91VzKAfxUiuqHPjssmE/+TjsbkdCEZl/hiMVI/ArW2qMuTw4oP
         GKoFU4zNijkrk/kHRgbaHu4yK0AQ3yu80kagl5w68WW+8NEQ9q8Qddx0CVF4JCr767Ia
         e6PkELfP+uuIho4HBFGJTUiqPXPS+GhHz5ZFF9nBHh8FfCQ/TWa2xbl97x/OmMYbCGE9
         WkZw==
X-Gm-Message-State: APzg51CVAeUiPc7ajad4Slnl/aOLr6kW1bo+0JBM6skftgIlOFMDVIx0
        4lwUd5tKA6ZoRLQUDbA9yxU=
X-Google-Smtp-Source: ANB0VdbdvVLLayRkk6SzKP5Qmnk+sudG0R8vvEZmj6h+L3UtpTpDN9zc5eR79emJ0faTzX4QF/Z7mA==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9-v6mr19987321ljk.133.1537469112123;
        Thu, 20 Sep 2018 11:45:12 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id q73-v6sm1871066lfi.86.2018.09.20.11.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 11:45:10 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 309F1460674; Thu, 20 Sep 2018 21:45:10 +0300 (MSK)
Date:   Thu, 20 Sep 2018 21:45:10 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC 02/20] timens: Add timens_offsets
Message-ID: <20180920184510.GC20786@uranus>
References: <20180919205037.9574-1-dima@arista.com>
 <20180919205037.9574-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919205037.9574-3-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 09:50:19PM +0100, Dmitry Safonov wrote:
> From: Andrei Vagin <avagin@openvz.org>
> 
> Introduce offsets for time namespace. They will contain adjustment
> needed to convert clocks to/from host's.
> 
> Allocate one page for each time namespace that will be premapped into
> userspace with vvar pages.

Is not it too much?! The whole page per each clone(new-time-ns) call.
Moreover everytime it is get explicitly zeroifyed. Don't get me wrong,
maybe I miss something obvious, but additional 4K per process, guys :)
