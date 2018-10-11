Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1811C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CFA20659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2qAiVQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CFA20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeJKVVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:21:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45134 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeJKVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:21:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id e10-v6so9854426qtq.12;
        Thu, 11 Oct 2018 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AHAHlQi25M+c6q7IMVDEmbVnhALQVuAichmsKty7Sd4=;
        b=K2qAiVQ2M7/0F76wlEFLJRrAdYq54Ps37drhzwIma66fRIiSZapKQn386Pl/4hl7tW
         GL6GxJ1M11jDYz0jRB5kXgjgTV8uFqS5kPKWaJdks86ih0kv7WSdR7kK2PDmoEcCbkLI
         Gp9QxTL9SjoTupgoyR6LmHhEBHxg6KDJmBwpBWt8vHTGOa/MvTYD99yXaLkm+j4ocggb
         OFdM3+bqWOO7Be10+/Go3HV5dHEZmz1m5c/QVMoKruqN5ZV3wdgVWxKkEhYb/oMN3ban
         Ql0ddkCW3WSmUUZfj7HrLtst+KitLQP0vB3J7QPGthMNnXrL7S6zM+4SDjpm6WuAWuhX
         dArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AHAHlQi25M+c6q7IMVDEmbVnhALQVuAichmsKty7Sd4=;
        b=tcjChSkAtWcRLOeEL4BiFP7CEo0cOk8kjiPiBNgRRuqxqvrGG2zz9W81ccr1eelnie
         1P7Gj/dvky4xTTsSOZyzOt94gG2wsTtryKRG0DDJvlFNp3NE4DL9K4cDE1THR5OJKGNq
         1QelNidHAIHoY6HpTOIUaopeUYIHxDBz8/QoIYunzcDlMO6RQgRpMok1sjZNPoPnLNGa
         L5v/uB5ytZuN6C9e9JT3lIVc77xDWzLk+jglcrNZqyZqA+ftikJGCZ41/ktXr/w054MR
         PB+bQQpi49ZGcHyeR5J1m8Bf1WvUvvB4gIRgEEm6gy88mDzw7KHh6I8m05geQAUK77dD
         EpEQ==
X-Gm-Message-State: ABuFfoi82WIDoSSoijOajyIeHTxy4qThWjKa2xuLFi4jyoEgOqly9czF
        gCSnRmnbHo0/ikjgy6c3zNMjuug3gqST0N8+OQM=
X-Google-Smtp-Source: ACcGV62cezxh16rbJ+Dnvx/z0db94KDAxvbhnR3avcuw8stNd2S+Ye08xlsWKdL5cyYqj9k4u7iUYTCj8IPOxmu5Uiw=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr1568028qtl.343.1539266067908;
 Thu, 11 Oct 2018 06:54:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd8b:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 06:54:27
 -0700 (PDT)
In-Reply-To: <20181011103750.GA29735@kroah.com>
References: <20180824172053.20fa197294f51496dcec5605@kernel.org>
 <20180824204756.e787765461975cd1e27502dc@kernel.org> <20180824224211.2934d7c0@canb.auug.org.au>
 <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org> <20180828072333.36af4d5d@canb.auug.org.au>
 <20180828094341.d20d8fbcb9dca310d44df951@kernel.org> <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
 <20181011114809.5590ecb3@canb.auug.org.au> <d5b166d6-461c-f382-e3d2-8993b845bd5a@linux.ibm.com>
 <20181011205849.6f6645fa@canb.auug.org.au> <20181011103750.GA29735@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 15:54:27 +0200
X-Google-Sender-Auth: rWvyzATHuKqZxnvFJ9vcBv8KCqo
Message-ID: <CAK8P3a3DTbcSgOEqt-zAsX9DpVSOmS6apYXXkRHK2FKc5mvW2Q@mail.gmail.com>
Subject: Re: linux-next: build warnings from the build of Linus' tree
To:     Greg KH <gregkh@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18, Greg KH <gregkh@linux-foundation.org> wrote:
> On Thu, Oct 11, 2018 at 08:58:49PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> On Thu, 11 Oct 2018 09:44:36 +0200 Peter Oberparleiter
>> <oberpar@linux.ibm.com> wrote:
>> >
>> > On 11.10.2018 02:48, Stephen Rothwell wrote:
>> > > OK, I have been carrying this "quick fix" patch in linux-next since
>> > > September 7.  Is anyone going to pick this up and send it to
>> > > Greg/Linus, please?
>> >
>> > Sorry about that - I posted a modified fix at
>> >
>> >   https://lkml.org/lkml/2018/9/13/367
>> >
>> > but didn't get a response. I guess I should have reposted sooner. But
>> > before I do that:
>> >
>> > Arnd: Is this something that you can pick up or should I include
>> > someone
>> > else?
>>
>> It would be nice if it could go in before the v4.19 release because the
>> commit that exposed the warnings went into v4.19-rc1.
>
> I agree.  If someone could at least review/ack it, that would be great.

I've added it to my randconfig test tree and spent the day building
random configurations with this (after reverting the version that Stephen
had in linux-next). The patches both look reasonable to me and the
build warnings did not come back in any obscure configuration, so

Tested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
