Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419ABC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F55205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vfopxU8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F55205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeJaNUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:20:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38648 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbeJaNUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:20:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id q186-v6so193718ljb.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 21:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OG4wLbERc5d7Nc2NuZ+OQ/qy5mzqS4VpPOjTR+eJy/I=;
        b=vfopxU8CEqRagLOXs+1c+Oh/cvAfomj6pQH/WcLDMhSypuHRcDu+Wm5Mf/AeLdtpBD
         oY1MpGc6qnBZEoOeNU3CF5iXgMTfQRJS9aJbLKcn1opIQJjPH52MZDPTK+j66hnNikJs
         6yiDoOQe4dzePgWdFhrbbcyXHB1kBj4yttEa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OG4wLbERc5d7Nc2NuZ+OQ/qy5mzqS4VpPOjTR+eJy/I=;
        b=dlf8djO3copsYn8ItjcligHiY7Ze41OQNjXz+HJiPPFuFh7SoNdZJ/zZADSsaLxUwU
         eylKHjJFmhhxtt0vbF4vjc9gLjKq8f6xkyEORx35yvWdZi04uSRSJkXsg0ZvhDrdZ0Pa
         QmGz/1sF8I/DTeznWseH2OSBCGnD3Q80Yq3QBZ3btXs9ZCEu7kSj5tAqQ90AsbxOYjrK
         /04d3/jsP+KujU4kFxAwFdkQkr+K3jtDdZWXiBi6aTSwfWf2Ok8rP2aJsydmMNByM8pt
         h9+Lnak/w+mNO8NihKfUFoHmyb8gj01q+dSrSeA12gHLwuayMMjdB3Hb/AGmrMSz/E1i
         1ezQ==
X-Gm-Message-State: AGRZ1gJ4CmWOV//yt502gDUgO5KcCc6NMgWR6A0U2dYJcNHxPgsiAmwn
        e4IBcRHnF/d64PS4a7R1jWIy4iQ5NTc8Fehu/a3QJEay
X-Google-Smtp-Source: AJdET5d59az3c9paoVCBBM/URcV2Mcft7DVO07Gu6bUxTHvmbihBEpzPVmRhkSxEEumCbl/OaU0IDDawq+DAyCuJ/bg=
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr751516ljc.120.1540959841660;
 Tue, 30 Oct 2018 21:24:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:650a:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 21:24:00
 -0700 (PDT)
In-Reply-To: <20181031025655.yz7lfhswk7igb3ty@yavin>
References: <20181029221037.87724-1-dancol@google.com> <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin> <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin> <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com>
 <CAPP7u0VQqDvFr=-52+Tmv_K=vT730wG7w9VQqJggsXTPFvaUBQ@mail.gmail.com> <20181031025655.yz7lfhswk7igb3ty@yavin>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 30 Oct 2018 21:24:00 -0700
Message-ID: <CAEXW_YQxWcQGZHrwhwsyu7GCk+WSap=tb0-asTsG8sTFmjE--g@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        Daniel Colascione <dancol@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 7:56 PM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-10-31, Christian Brauner <christian.brauner@canonical.com> wrote:
>> > I think Aleksa's larger point is that it's useful to treat processes
>> > as other file-descriptor-named, poll-able, wait-able resources.
>> > Consistency is important. A process is just another system resource,
>> > and like any other system resource, you should be open to hold a file
>> > descriptor to it and do things to that process via that file
>> > descriptor. The precise form of this process-handle FD is up for
>> > debate. The existing /proc/$PID directory FD is a good candidate for a
>> > process handle FD, since it does almost all of what's needed. But
>> > regardless of what form a process handle FD takes, we need it. I don't
>> > see a case for continuing to treat processes in a non-unixy,
>> > non-file-descriptor-based manner.
>>
>> That's what I'm proposing in the API for which I'm gathering feedback.
>> I have presented parts of this in various discussions at LSS Europe last week
>> and will be at LPC.
>> We don't want to rush an API like this though. It was tried before in
>> other forms
>> and these proposals didn't make it.
>
> :+1: on a well thought-out and generic proposal. As we've discussed
> elsewhere, this is an issue that really would be great to (finally)
> solve.

Excited to see this and please count me in for discussions around this. thanks.

 - Joel
