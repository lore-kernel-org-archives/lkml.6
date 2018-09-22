Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EBFECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D5F21523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 08:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xZbmpRXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D5F21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeIVODp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 10:03:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46794 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 10:03:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so14011808ljj.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQB2gosLX8oDnCIIvPjmdmMwEnxM6Nwus1miMlxx9eM=;
        b=xZbmpRXnPDTIIIQjaPxmJ58k8n9ZdRCNgjB7uzh1HuHkBK/enqVlbNPnqLTWd5yJuv
         Ruz0U6jHSzTMhUUTpNNqHrJ5dXnBrIQoAPSi2eKEjIQipdrRYmnw6l9kHcuZCSrOwWbR
         sbXfi1gxKVaivbnQblZ+iNmeRpTJQjUaS2Jqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQB2gosLX8oDnCIIvPjmdmMwEnxM6Nwus1miMlxx9eM=;
        b=Kr7uNe+LgjAFKnDzimAv4OK0aQ8fVnAJdCbfkLd+Rc5iAFtg3rjtRXZ5X6f4ZGmpLD
         XFjkxG4QX/umiBQG8szlXgrGeHn9CeJFVjX/w0UBH4iyneZPqpo+Egb2B+Up3UWviJ0r
         jv+bW7SyQuXajTLT0wSOSekeMAJyhZwcGwdx1slo+NdwxZoiNxcEgXm9CuCnzgQBjTKV
         jQ20Ra8I95qzjQvyHB79078LnqZAsFmdRltDzY/aFGyFKotE8Gewp1nzCHOWqok0u94f
         Sw/skrmSHjvwnPf1/m9a2MI6LKk/EZRx+tj6xbmWw5NfKWvH0hTNEBBGe7X2HaobgOz+
         9dbA==
X-Gm-Message-State: ABuFfogESsnh7sldEAamVsbxH9vgVZPJaisjb+ygLAocDwAdxJR9BzfR
        xAvxWJ8taee4xni8RzuvXiys0rtuWG1mHA/BWq1gpg==
X-Google-Smtp-Source: ACcGV60pe7m5a6UNgGTmZ9Mph8JkNo69m1S4ZF0yIVmmsjQfcEzXjHSF0ihFprmXt+Ln8UJrHZK9snH59DHrCVnbtp0=
X-Received: by 2002:a2e:8098:: with SMTP id i24-v6mr4648892ljg.36.1537603862482;
 Sat, 22 Sep 2018 01:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180921223153.114728-1-joel@joelfernandes.org> <20180922011428.GU4222@linux.ibm.com>
In-Reply-To: <20180922011428.GU4222@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 22 Sep 2018 04:10:51 -0400
Message-ID: <CAEXW_YTgSFr5r3Qkr0+0_wxKGQV1KKP_8X8uQKAnHmhvem8XtA@mail.gmail.com>
Subject: Re: [PATCH RFC] Documentation: RCU: Clarify comment about fanout
To:     paulmck@linux.ibm.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 9:14 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Fri, Sep 21, 2018 at 06:31:53PM -0400, Joel Fernandes (Google) wrote:
> > RCU Data-Structures document describes a trick to test RCU with small
> > number of CPUs but with a larger tree. It wasn't immediately clear how
> > the document arrived at 16 CPUs which also requires setting the
> > FANOUT_LEAF to 2 instead of the default of 16. Clarify that.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Good catch, applied, thank you!  You know, those two Kconfig options
> are so closely linked in my mind that I doubt if I would ever have
> noticed this issue.  So good show!

Thanks!

> I of course could not resist doing a bit of editing.  Could you please
> check the following to make sure that I didn't mess something up?

Yes, the edit looks good and improved the changes ;-)

I have a few more as well, I'll send them out soon.

thanks!

 - Joel


>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 9870c5b0f7b41a7b6085c20c22b320681800dabc
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Fri Sep 21 18:31:53 2018 -0400
>
>     doc: Clarify RCU data-structure comment about rcu_tree fanout
>
>     RCU Data-Structures document describes a trick to test RCU with small
>     number of CPUs but with a taller tree. It wasn't immediately clear how
>     the document arrived at 16 CPUs which also requires setting the
>     FANOUT_LEAF to 2 instead of the default of 16.  This commit therefore
>     provides the needed clarification.
>
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>
> diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
> index 1d2051c0c3fc..476b1ac38e4c 100644
> --- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
> +++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
> @@ -127,9 +127,11 @@ CPUs, RCU would configure the <tt>rcu_node</tt> tree as follows:
>  </p><p>RCU currently permits up to a four-level tree, which on a 64-bit system
>  accommodates up to 4,194,304 CPUs, though only a mere 524,288 CPUs for
>  32-bit systems.
> -On the other hand, you can set <tt>CONFIG_RCU_FANOUT</tt> to be
> -as small as 2 if you wish, which would permit only 16 CPUs, which
> -is useful for testing.
> +On the other hand, you can set both <tt>CONFIG_RCU_FANOUT</tt> and
> +<tt>CONFIG_RCU_FANOUT_LEAF</tt> to be as small as 2, which would result
> +in a 16-CPU test using a 4-level tree.
> +This can be useful for testing large-system capabilities on small test
> +machines.
>
>  </p><p>This multi-level combining tree allows us to get most of the
>  performance and scalability
>
