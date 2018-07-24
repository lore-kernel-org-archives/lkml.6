Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402F9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63BE20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gj+TiVA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63BE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbeGXShR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:37:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54615 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:37:17 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so4847489itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vR8TxOUmFhxI13Z1gepTTt+9axp43EF1ZaADoFmhfZE=;
        b=Gj+TiVA6M6FvrDgFkpCg+AvX1AjVnh1DBgZxKPO0Tl/rEieDTboOSPpZ458kiiy4Ci
         ZNbCQc/6g+z7zzHbY6OBklbZuuDVr6aG2IrNWSLrlL+KG6IrvCnq2Ymskcxey5tUGKPJ
         q41t5Ws/Ym9vuxVxIgwP8CL6l3yzpYPxVYZfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vR8TxOUmFhxI13Z1gepTTt+9axp43EF1ZaADoFmhfZE=;
        b=fyW3+fOW+AdLoC/lb3s9fU/Wr0NRG5qq1aUVFIf51T4P1ybw8BFU0tL4J1yBzJu+JA
         WCVzpMijdEm5QDukQm5ZxeXk9EQwygF9vInnb7Y9jsLSgPg3masHgJofp+RgmAqwVmm9
         +kvBeebPi4L16qSyB2SMefIaC3lyrSagAMD25BVN9twbpytBTiAHBeNNcrHPyqJeaSDA
         Lw/Z+RAWP5eVc3z95pvkJ2/GI3C3NA6kwcqrI8H7RHhZ+pRaWYve+dLewZlMxKtkkxq+
         014RqDdMpvZ27LqqhLer/QrZVeVLbEhyaXjUnb8nSRswHcwFurhsFfdM0NeVi+WancO1
         ed5g==
X-Gm-Message-State: AOUpUlHTGFxJEw9GyetTz6GOQvGPhX37E8FCy5L+YeyllbcPv6bp4MsG
        9nNVlUpL5LOumZhIMqqGbdsuA9v4hhzH/sWCDjY=
X-Google-Smtp-Source: AAOMgpf1pV57NPyXyir6+Cmgj6hpKl/XM7OkzUpH0YANx+YK6zubneCg1au4YJPnArhWo1dKR0RAtY9d/4YaINOqlkg=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr3461432itb.16.1532453385605;
 Tue, 24 Jul 2018 10:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <bug-200447-5873-b2kAsSyE1X@https.bugzilla.kernel.org/>
 <CA+55aFyOaEGc_wjRuAxYZH7D4zi4xUQTqUwMmUzxFJQ__2pXuQ@mail.gmail.com>
 <87h8l9p7bg.fsf@xmission.com> <20180709104158.GA23796@redhat.com>
 <87sh4so5jv.fsf@xmission.com> <20180709145726.GA26149@redhat.com>
 <877em4nxo0.fsf@xmission.com> <CA+55aFwq90_KeRUesktap7L_4Hp3gatKZ28RYw1jXBYeOqUoeA@mail.gmail.com>
 <87lgakm4ol.fsf@xmission.com> <CA+55aFz1XFvOgJySKVNQD9VS4hys0J7rozxqd3s5ND0z80tfVw@mail.gmail.com>
 <20180710134639.GA2453@redhat.com> <CA+55aFxcjSYAj-CZFEuDwiwZyMg+prV_jeP_Vuh06RJA0BboSw@mail.gmail.com>
 <877em2jxyr.fsf_-_@xmission.com> <87efft5ncd.fsf_-_@xmission.com>
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 10:29:34 -0700
Message-ID: <CA+55aFxKMAi=AyQoe-2HBmyyPxFi9bme2F9VSF7uvROZCq+VFQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] PIDTYPE_TGID removal of fork restarts
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 8:23 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please take a look and verify that I have caught everything.  I think I
> have but if not please let me know.

Looks mostly ok, except for the completely broken cleanup of the
"multiprocess" list.

               Linus
