Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFF9C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887E420848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NnAo5Lrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887E420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJZItG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:49:06 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:43209 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJZItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:49:06 -0400
Received: by mail-lf1-f52.google.com with SMTP id u18so1017095lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1m2UZPoHArO+m0FL9W1+E/FL5oroOzFRfVRJmKancKA=;
        b=NnAo5LrdGQzdZyB8YZz5u2czTSqr/eOj/v/oyWqCJSdE3g15fBjsVDB9XUvp7CR/Ll
         cWo7esaPqkdWqzSSwgpmAcLEx/jPB3YqRkf+X0c1RsGoS91V7hvmpxt7aSlPN1kRLuSt
         xJZCwRTPOm4L4oVVGniu4ZQfh8nI1KL7wKZ4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m2UZPoHArO+m0FL9W1+E/FL5oroOzFRfVRJmKancKA=;
        b=MjoFzE7Hjd0QA4GPVFjbh2l/rcEua+1zZSBN/OzJVTTsK9yw3dHwxzQaQZqeuNbuZV
         h6w3hrY+icwH9W+NJXjYFAi8mUUMdbhtY8cEEDE2/SPKYaF32xkC88Ro05CXZbZIfrrC
         GLAoMFq6BdxZDoq4Ip03CNLsaTBSHjL2UJnlx516cigWVUyg/GU5w6xcT2n+nPWU7bD6
         CyviQUHLL/x3O1joMtlARHAhr0Tf4aYaNe0hlPBHsvRigOIpN2c19i5sCzcMhzWJdx7I
         ecpVQZfZT/DqWB3WVmKChZStEP5qX3Ch7+YebInLWoh0vNH8FrWAGEeLWQeO6jMXwwis
         BnZA==
X-Gm-Message-State: AGRZ1gJt5+pWrqbKEps5T4Y3NiyicS+xemxlbugMSbxx8+pQcl5xNott
        jMgQHLEh3CdJsFNq6o8jw02jp9y8pl7W/Q==
X-Google-Smtp-Source: AJdET5e2euF8VnK/bpwJWrqsWPYZEriouyY7MN+0vDF7lrHNL+f0JY0PGjnZq+zRDGe7/OpM4idfhQ==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr724584lfb.121.1540512859315;
        Thu, 25 Oct 2018 17:14:19 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x6-v6sm1356726lji.36.2018.10.25.17.14.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:14:18 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id u21-v6so9886272lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:14:18 -0700 (PDT)
X-Received: by 2002:a2e:9dc4:: with SMTP id x4-v6mr871662ljj.133.1540512857876;
 Thu, 25 Oct 2018 17:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181024134825.yx3mnbmvydrnlvhm@pathway.suse.cz>
In-Reply-To: <20181024134825.yx3mnbmvydrnlvhm@pathway.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 17:14:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjvs5qsewiz-jvJ-tTTRUWfiUuJzFEU-PUD_pLr_GqHg@mail.gmail.com>
Message-ID: <CAHk-=wgjvs5qsewiz-jvJ-tTTRUWfiUuJzFEU-PUD_pLr_GqHg@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 4.20
To:     pmladek@suse.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 6:48 AM Petr Mladek <pmladek@suse.com> wrote:
>
> please pull the latest printk changes [...]

Pulled,

                   Linus
