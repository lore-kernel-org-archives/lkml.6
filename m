Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A7C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C812620836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtQRlwwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C812620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbeFTQLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:11:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39043 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754085AbeFTQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:11:38 -0400
Received: by mail-lf0-f65.google.com with SMTP id t2-v6so149473lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FezQaT2WjnN4UJEQr1DEDLkBcIfT9Kw2aSSuu5zu/0s=;
        b=FtQRlwwH3psv7sqP3zeCTcXOF1kSIPQwqDUol8FUNgdqWqyG47WFhXM2uY2T9PBGGl
         9HUYvbtIVBvt3JFnR7rBxNzWYBR4triokKS+UFG31m8mqyFFgvJ0ERztk6grhYxU+1ys
         uaoOlVw/9P7f6PD830e0bQOcohFfZE6Isg84mQ8ASOfE5Z6qNJLugIaJuHSi+EVYPhXB
         Mg0MsHXOE4PqSBNzhIOGpcPLqIkefJfF68cuNP3nfSjFgfvi9nuqEiiQGCfIkM9qVqmk
         M2GsMXUcQo6P9XKVSjMEtb94faIZlKHiCSPONhz8kw4eIZD8GFoa7RyhEU1V/nEzGyp4
         QZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FezQaT2WjnN4UJEQr1DEDLkBcIfT9Kw2aSSuu5zu/0s=;
        b=A9NI1eLi0SkyMUXeNLRtnQIHKcsLs4tJaE3uyiuUJwXpBj+uKMyHASlTWj4NkiFUig
         NY7WzCpAAURjgNyu5+RUW2Rf3JHhzSgGpxcIouPVTBq1VMHAurU5yfKhQutxXjGTUads
         NBoz3rSW3421quSQwIni4PcwiKW+eN2w9LtyNRAzXHJjiFMjwwL8s3aYFVu9MEclYRIs
         maDc17JUP2xLDNbTvjeTbLtC3yPxc2mu4RgLGTSyzb++8SDZDQTftDNbfxqztLVKWeva
         C0WMxy0iy02kTbZGEtVWZ8afVWmVQad/nEdGI7Fw5Dj9GmO/PxhNAHS+vLbDzWai2sQU
         vNAQ==
X-Gm-Message-State: APt69E33wDEvVvVg/RAGgiiozNiiPEVJ/nOUxq1C02ze6dSkWoabeg8P
        IvhG66Dm8Hu2h4voe6H3enmtafvd5qAUy+U/2LE=
X-Google-Smtp-Source: ADUXVKLqWPrvZ6+Rnr1aBM3xdn60ViTS9lByGYGeW9iZP9XDUEESAgERxb5Tlbd6MNRYBm9l8QJCSOGlPbJVIVhn1Yw=
X-Received: by 2002:a19:110:: with SMTP id 16-v6mr2768947lfb.10.1529511096765;
 Wed, 20 Jun 2018 09:11:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:44ec:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 09:11:36
 -0700 (PDT)
In-Reply-To: <20180620155658.GU3593@linux.vnet.ibm.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <20180620145058.GP3593@linux.vnet.ibm.com> <20180620114335.7a314642@gandalf.local.home>
 <20180620155658.GU3593@linux.vnet.ibm.com>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Thu, 21 Jun 2018 01:11:36 +0900
Message-ID: <CANrsvRMW_LF1W3-OerHbXm1nqPBLGhQYP6ZsTMapGnfiT7-W3w@mail.gmail.com>
Subject: Re: [RFC 1/2] rcu: Do prepare and cleanup idle depending on in_nmi()
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:56 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Wed, Jun 20, 2018 at 11:43:35AM -0400, Steven Rostedt wrote:
>> On Wed, 20 Jun 2018 07:50:58 -0700
>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>>
>> > On Wed, Jun 20, 2018 at 05:47:19PM +0900, Byungchul Park wrote:
>> > > Get rid of dependency on ->dynticks_nmi_nesting.
>> > >
>> > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>> > > ---
>> > >  kernel/rcu/tree.c | 22 ++++++++++------------
>> > >  1 file changed, 10 insertions(+), 12 deletions(-)
>> > >
>> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> > > index deb2508..59ae94e 100644
>> > > --- a/kernel/rcu/tree.c
>> > > +++ b/kernel/rcu/tree.c
>> > > @@ -797,6 +797,11 @@ void rcu_nmi_exit(void)
>> > >           return;
>> > >   }
>> > >
>> > > + if (!in_nmi()) {
>> >
>> > Is in_nmi() sufficiently reliable for use here?  In the past, there have
>> > been tracepoints that invoked these functions between the time that the
>> > handlers were entered and the time that software updated the state so that
>> > the various handler-check functions (such as in_nmi()) would return true.
>> >
>> > Steve, has there been any change in this situation?
>>
>> There shouldn't be any "trace events", but what we had to deal with was
>> function tracing. And in the near future, we will be getting "function
>> based events" that will allow you to create an event in any function.
>>
>> That said, even the function tracer shouldn't be called from the time
>> the NMI triggers to "in_nmi()" is set. Because there's some function
>> tracer callbacks that should not be executed from an NMI, and I use
>> in_nmi() to determine if they get called or not.
>
> OK, so in theory this change is safe from a tracing perspective.  But
> it does add conditionals to a fastpath.
>
> Byungchul, is there any reason to make this change other than preparation
> for your second patch?

Sorry again I didn't explain it fully in advance. The only reason is to
prepare for the 2nd. It was harder to read the patch when I made them
into one. But I can make them into one if you don't think so.

>
>                                                         Thanx, Paul
>


-- 
Thanks,
Byungchul
