Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB0ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BEE21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhjC1vBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BEE21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeJQXag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:30:36 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:39574 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeJQXag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:30:36 -0400
Received: by mail-pl1-f169.google.com with SMTP id e67-v6so3889828plb.6;
        Wed, 17 Oct 2018 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QBRxG95r8ZrcYQnbvom0ck3HkqSUVTuSdsWpCvsF4t4=;
        b=GhjC1vBBZGFzKw4DQsaJ/PotEPUTG93x7tiizOmV3p+RhRFx0Lwo+h0/ycC33R9TiC
         I1O1Q5eG5Tq8x55nnvtXkgTHLlNEg0jSd/2dXu77eVdY5104dB/svcyeTWh+q+X0uvZR
         BBOpVdc25HU8RgGO3GgSK75RV6xesd/qS40CGYG8R0GalZSXsKnwgN0zHE1Vncmc5iFQ
         LK1wGc34Th6Y7l6xo6KymHJE5cofiPwJMEfgw8usT/SSV8gkvTxR+WXw/vVfsVH3Whcw
         cL+SVSp7jWHZ4K6B9tot65JpmjJyWVFDq0ys3QlIz2/8FnzvTZdA3mxHuEas7tMLkeG4
         CBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBRxG95r8ZrcYQnbvom0ck3HkqSUVTuSdsWpCvsF4t4=;
        b=SdO2vwQDaXi+mbHyxjgITKWMVIGf9mH0i0q6Tiv8YzepbiYRtKSMIKmBCb1XMnocdV
         UL17PCawGZv89edSB3CagmPTcP05tpXkODinnddvvdDCV2C4WOc/v0YPcatfrz/Lz8Ym
         Uc6idUMNVpT0DSFPg8Fa8X9SuGPzyMk8GGsmYLPyHBx+795RyHemfhn6KOgh30LU5qFA
         mtWqdOKQu7uqE29WvvU+0Gm8F6mpOGv/Unlo2IBQOJmmLWbaO6ONOHV4pM0FRauNnS9c
         ss72SNH+eDnAj+p2BjSCyaAbCQZmQz8VZ26zcA95sP1b8GWfqfpLPnxLcPMeDqy3/hOA
         dwrw==
X-Gm-Message-State: ABuFfog8WoiTIKxlVMBH7Nc99kahZJkWh/+D00/uWPRp9bHlskXbEMvD
        gpugD//3b4NSRddSy7iKiww=
X-Google-Smtp-Source: ACcGV60gUaiTTCKOibj2CfIHg7xlVPMrAB1Evy45v/YzEZINRjtE4fwT+44IPVegF/ph2GfxcolZDQ==
X-Received: by 2002:a17:902:e185:: with SMTP id cd5-v6mr25518845plb.224.1539790461756;
        Wed, 17 Oct 2018 08:34:21 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id p24-v6sm24042142pgm.70.2018.10.17.08.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:34:20 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 18 Oct 2018 00:34:08 +0900
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.21 04/16] mm: Introduce vm_map_user_ram,
 vm_unmap_user_ram
Message-ID: <20181017153408.GB426@tigerII.localdomain>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
 <20181010191936.7495-5-mathieu.desnoyers@efficios.com>
 <20181016143016.10da89bd@gandalf.local.home>
 <20181017002722.GA1068@jagdpanzerIV>
 <1051015468.759.1539788401096.JavaMail.zimbra@efficios.com>
 <2060193272.771.1539788641739.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2060193272.771.1539788641739.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/17/18 11:04), Mathieu Desnoyers wrote:
> >> 
> >>> 	if (WARN_ON(x))
> >>> 		return;
> >> 
> >> Given that this somewhat MM-related, I'd may be say VM_WARN_ON().
> 
> I notice that VM_WARN_ON() casts the result of WARN_ON() to (void), so it
> cannot be used in a if () statement.
> 
> VM_WARN_ON() will only warn if CONFIG_DEBUG_VM is set.
> 
> Is it really what we want ?

Oh, indeed... Sorry, I forgot that they cast WANR_ON() return to void.
Let's do what Steven suggested.

	-ss
