Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B13DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC9C21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkQCprVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC9C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeHTIgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 04:36:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41891 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeHTIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 04:36:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so3200985wrb.8;
        Sun, 19 Aug 2018 22:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrcP9y/3N1ewyu43d79AwiK0NrSLmjCF/iuu+VT+yUw=;
        b=TkQCprVkx83MAMzGTRN2R9Mpf5jCe1HCYl67/Cxdpc0fyDUk741jPwt4DDKDALvMQS
         iHP81jt7EAbBOykg6bPMjHljxYVn62q0yVcJgIJyXJp0Ze1SlWJ8CEfonzAUBt5kVK1T
         KbqAjIhWcQ9cFcEgxe77xuWQp6yXYAofxCxNGPzmB/eMOztYqGZBp8JnzTF3TLEZJby7
         E4TiRG8ukeDSCRh805yI/q3jkpCnETGBCBA2EGDlhby1xb2kg1HY3KM8OQn3HiayFiQv
         Bu3Y+StbsMkBmxrf0pa4ea7Vl1Iknypso/cyruMBWdg5/A03XQupaEDChyLNInETfsRY
         aptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrcP9y/3N1ewyu43d79AwiK0NrSLmjCF/iuu+VT+yUw=;
        b=Rzh6CWSqUZ7umg3JWbYi+2oUpuut8vNsr7PGrBHqGfH3HOpDLSF3tyxXo9phMmyy7Q
         mJcHrb6z8zbTqjJuO9PZXNAQnbaFls+l4bQpzrpRiDkMCY+oKEqy/XJ8OEVrrp5L9C0a
         rFGdb3QafF/JUF5yDfk+YGL/lQz4o5ahgvTZ8117keZr7MOpoX/+4zo3bsUk50TJ193I
         82kdEfi5JZGPkZ6J3FdnpQ84HPtXORakcMHdwSQE+jNajigmik0mdTR+yyCBXXvQqoXi
         4m72jpJ+iVF5j1XMzx4QeNaEZuyQd490eTJieGwqFcd6qWzXrU/vPEe+mZsILd0HLynk
         euWA==
X-Gm-Message-State: AOUpUlHU/C0za/BoMHBCLwH9Od96NLZltseJD5NR6ijm9DGZtL/Ah2VM
        ozBMrTPMyN/7Q1Xsw7L/EF2DOGoFAw2B8yqiZ2A=
X-Google-Smtp-Source: AA+uWPzk62e8m407dm2q/tv8VDmonnQKnFjU1YIIofP1FWAw4nHI1Rs+sg/sAyaPi+ZgCg9PooJVQgskR43baBcZFt0=
X-Received: by 2002:a5d:6345:: with SMTP id b5-v6mr27474488wrw.266.1534742550274;
 Sun, 19 Aug 2018 22:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_YEyxKOimMrGk+5Db8DpNfqQL84-2xLXbe53jiY_FoPrQ@mail.gmail.com>
In-Reply-To: <CAP8WD_YEyxKOimMrGk+5Db8DpNfqQL84-2xLXbe53jiY_FoPrQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 19 Aug 2018 22:22:18 -0700
Message-ID: <CAADnVQJjqLY3iFy2y5mb+oMR=VHS8HS_KXa0wm1HO3v0ayvrkw@mail.gmail.com>
Subject: Re: Allocation failure with subsequent kernel crash
To:     whiteheadm@acm.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 10:17 AM tedheadster <tedheadster@gmail.com> wrote:
>
> I have been trying to bisect this crash but I have not found a
> reliable reproducer. My best guess is that it was introduced after the
> 4.14 release.
>
> This is a 32 bit kernel. It is odd in that it first generates a memory
> allocation failure, and then quickly crashes with a succeeding bug.
>
> I'm including the netdev group since there is a lot of BPF stacktrace.

I don't remember vzalloc issues that was fixed in this area.
4.14 kernel is quite old. Since then syzbot found few mem
related bugs that were fixed.
please try to reproduce on the latest tree.
