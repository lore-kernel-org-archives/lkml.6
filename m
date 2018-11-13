Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EA6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDB921780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="n2y7Xk/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDB921780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeKNEmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:42:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33468 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKNEmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:42:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id r27so8453228eda.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMgU2mrUOl6W0y+gO2IQGJshIxW0po9kMDDBu99G6Os=;
        b=n2y7Xk/rt7R91cWAsGwzsiFVQgDrKD7XICNUBh+/h4DPm3Ib2EsrTdFWI4X/HM5Nke
         LnsgrZ8a53MJ8V9GpIjKn6Qw1wRrrf2CnMoXYLT51apXtEVljrqsVcTgextFum4gJwYz
         RdHmaBYXJMkW20JeH5hE1dBhMrhNEYqcg+SnaE+eUnH1kW8veldUMsWZ34mmoteQsNKk
         VkqTkF4fYo3eryzr9QfCMT5MRsK5u/iIqgqkZUXoe9abV1UubdOIOeZH0PKacTF60Lc6
         wD/XI4ASqtnOYJ9jlDBFzbMospvYvrEHT+hSvbneTmx6/ZlEwQlcIC2TJ3vswZ/gl3k2
         +P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMgU2mrUOl6W0y+gO2IQGJshIxW0po9kMDDBu99G6Os=;
        b=afmeAOAozfwzmBcL6EAl1EZfQaozFx5bcqKA/uy3ahggy1fJNu+UuQ8V5LHC2W+vwn
         kINIUh8j9W8KPG1Fge8G8+If/iAo3CZeY3YAh/oFKjzAEmzwWMXCUDK/TjiozOot2Tnt
         1UmxaUvECWo+6tyJ752VcaflJ4UPyhWPF0ayzSUY/jUOXuxiOYBnpkFsyDFIohjTNepP
         184hrjDZtt1PWB3A9V+VL5EnIqoV2qAHhqEdbsv7LaKqe71NT7u9LyQetGJOWYXfps2p
         Jt6zYjmEj3GOBRdO550tElTGSlxzAyuXxIgUSBOmxAMDrx14DSbz77fnXHseYer3byGl
         NGfA==
X-Gm-Message-State: AGRZ1gKYiCunnuB/kUrqmixA9R1MxNAW8sXlgcQ+j9K35aGZlxlPVqvL
        TnZlBo1sc/LBF2EeoUwbzelMwvFRuBj7Iu9VAbiRzg==
X-Google-Smtp-Source: AJdET5d7L+wjvZGZGVjdq7skc5N8wU8niTLvruAI5CwJHmWG0zY9ZZTMnlKh7eS2TxdUdl3CSHn7SA76C1dWK4yEqlY=
X-Received: by 2002:a17:906:c44a:: with SMTP id ck10-v6mr13665059ejb.25.1542134579948;
 Tue, 13 Nov 2018 10:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20181112231344.7161-1-timofey.titovets@synesis.ru>
 <20181113022516.45u6b536vtdjgvrf@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi744_8NA30V0aWCpFi_=WSaA+18h3njOTQG0SFUVdXi8bg@mail.gmail.com>
In-Reply-To: <CAGqmi744_8NA30V0aWCpFi_=WSaA+18h3njOTQG0SFUVdXi8bg@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 13 Nov 2018 10:42:47 -0800
Message-ID: <CA+CK2bB0C-PCdaHS7YiLf5iZWn1bATg2y32ogL1FSw7LY9E7SQ@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     Timofey Titovets <timofey.titovets@synesis.ru>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it really necessary to have an extra thread in ksm just to add vma's
> > for scanning? Can we do it right from the scanner thread? Also, may be
> > it is better to add vma's at their creation time when KSM_MODE_ALWAYS is
> > enabled?
> >
> > Thank you,
> > Pasha
>
> Oh, thats a long story, and my english to bad for describe all things,
> even that hard to find linux-mm conversation several years ago about that.
>
> Anyway, so:
> In V2 - i use scanner thread to add VMA, but i think scanner do that
> with too high rate.
> i.e. walk on task list, and get new task every 20ms, to wait write semaphore,
> to get VMA...
> To high rate for task list scanner, i think it's overkill.
>
> About add VMA from creation time,
> UKSM add ksm_enter() hooks to mm subsystem, i port that to KSM.
> But some mm people say what they not like add KSM hooks to other subsystems.
> And want ksm do that internally by some way.
>
> Frankly speaking i didn't have enough knowledge and skills to do that
> another way in past time.
> They also suggest me look to THP for that logic, but i can't find how
> THP do that without hooks, and
> where THP truly scan memory.
>
> So, after all of that i implemented this in that way.
> In first iteration as part of ksm scan thread, and in second, by
> separate thread.
> Because that allow to add VMA in fully independent way.

It still feels as a wrong direction. A new thread that adds random
VMA's to scan, and no way to optimize the queue fairness for example.
It should really be done at creation time, when VMA is created it
should be added to KSM scanning queue, or KSM main scanner thread
should go through VMA list in a coherent order.

The design of having a separate thread is bad. I plan in the future to
add thread per node support to KSM, and this one odd thread won't
break things, to which queue should this thread add VMA if there are
multiple queues?

Thank you,
Pasha
