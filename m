Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41806C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8E320833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fR9FiIxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8E320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeIKSbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:31:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36757 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeIKSbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:31:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so19257644edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U2Nles02vh1w6gDMUV777ZN+CNqTB72XeCufts8A4rc=;
        b=fR9FiIxJlMHHnbxAXxfgRn4gv9m4Z/c6XC5lLqLxYI26m1RsMhTT/1hIU5CXhIZW9c
         uQFJStrrfNA/Ia70/E0mWF3uk7DWm7PAbu0YHmKUlPGz6du4egNSAVRXF2ttEHSWabyq
         y0TjZfpsrlcwy125a//DqQT4LbbzfBheNLqsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U2Nles02vh1w6gDMUV777ZN+CNqTB72XeCufts8A4rc=;
        b=kqP0H4bTQCG0QQgLG7suuwi4iIkiBaxS/q9aI1DFXknTEMgAQ+yN1kBbjYYbUJefpD
         BUCwvPZmuwaYMOEMLXaCkcAZ/lzeKVlRL+gmPNtG3nJUXqJGcAsO/q8hKb/Dtk4OfAw2
         Subw3LIK5/MQnfxKavYWqepE4kT/Np/32tEQNpoTyBpgC2zMmPzG8jU1uuCjC7a4vPWc
         9KjT41bWcqD+utrjGKlDRyKNpu74Lvmt2ohcQ+20gFw1o7Kkz/5VRjqFsxsW+SPRO1vW
         vTbFaEAUCDYepoBcZeQqUaLl1lM2NxuLDp3Zjkij0xkPYBYS+WegVDKEuO+j3i86JOiU
         GMpQ==
X-Gm-Message-State: APzg51AIiZJK7xe7Fy1Vj+a0VcUFJG2HV11jNSzkOYryekEwzO2uxxCr
        zTtPYlz8wJdMFukCbWWCvywCYmS3la61tA==
X-Google-Smtp-Source: ANB0VdZZ0xBg4Vxiyok6alvUQrS4U0pCRXJ3ybGhkUxfhmvIGgX8e5fOfCTErAA7yuM23Usq5HqttQ==
X-Received: by 2002:a50:adaa:: with SMTP id a39-v6mr28108924edd.194.1536672719352;
        Tue, 11 Sep 2018 06:31:59 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id d56-v6sm9764408edb.7.2018.09.11.06.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 06:31:58 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:31:51 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20180911133151.GA29426@andrea>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-4-quentin.perret@arm.com>
 <20180829100435.GP2960@e110439-lin>
 <20180829132811.iacfltcos6kfgp7e@queper01-lin>
 <20180911093456.GA27352@andrea>
 <20180911123248.mjcaxrycfdelypo2@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911123248.mjcaxrycfdelypo2@queper01-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:32:50PM +0100, Quentin Perret wrote:
> Hi Andrea,
> 
> On Tuesday 11 Sep 2018 at 11:34:56 (+0200), Andrea Parri wrote:
> > FYI, the directory "tools/memory-model/" provides an "automated
> > memory-barriers.txt": in short, you encode your "memory ordering
> > questions" into "litmus tests" to be passed to the tool/simulator;
> > the tool will then answer with "Yes/No" (plus other information).
> > 
> > Some preparation is required to set up and learn how to use the
> > LKMM tools, but once there, I expect them to be more "efficient"
> > than reading memory-barriers.txt... ;-)
> 
> Thanks for pointing this out, I'll have a look.
> 
> > Please don't hesitate
> > to contact me/the LKMM maintainers if you need help with this.
> 
> And thanks for that too.
> 
> > You'd need some info in order to write down a _well-formed litmus
> > test, e.g., matching barrier/synchronization and interested memory
> > accesses on the reader side (IAC, the replacement "store-release
> > -> store-once+smp_wmb" discussed above is suspicious...).
> 
> Regarding the disccusion above, I was actually planning on removing the
> smp_wmb entirely and rely on WRITE_ONCE + mutex_{un}lock here. Do you
> see something obviously wrong with that ?

As said in IRC: nothing I can currently see.


> 
> I guess the LKMM tools should give me the yes/no answer I want, but if
> that's a no, I'd also like to understand why ... :-)

That answer would be a little bit more involved ... ;-)  The file
Documentation/explanation.txt within the above mentioned directory
could be a good starting point; skimming through litmus-tests/ and
Documentation/recipes.txt could also provide some hints.

  Andrea


> 
> Thanks,
> Quentin
