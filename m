Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EEDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9E220827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9E220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbeKGDPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:15:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42660 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389573AbeKGDPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:15:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so6128548pgq.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1X++K30qlocAaocdfUugyzmpdC+vrNZ6Xh46RqadmCM=;
        b=cJVeTFkSHcqistFCtlDmYQ+vPwzGfeTA+s/CEcHOoUJbwZUL2j5Av1u9p6UqlqB88O
         GeiMrADVKmeosob5MuLYl57N7wtjjQNdbsIPBk0uvKuXZ8cyiZPEMccOL3bNahCuPkce
         qp7xcvsHcWMQnNsAm/Mercn4IzdLG4Tgzkj/m82Kf2wnEQklsks4SoYF9dHlLzC+vlOL
         wKPSMloC4TuNYFXeBK44f5qHs9HwHY6/fbRkSJ3eZZu7kQhjVHxkfyG4SCscgp8v4RBu
         euWg9z0CKT/nRGXJXy2ToMbMHOmbme04GVITV6akHR+leqAjP3C/NawpwgiIqpgcpR9O
         JCqw==
X-Gm-Message-State: AGRZ1gLUyaLiTGYHN54G/feBw1LlHOrUw51K4PcA1soF69nF+guykHyf
        IuNLoPjQFLshEi4PdB+eMy4=
X-Google-Smtp-Source: AJdET5cSYCQXO+1Xw/c8qiUWT4SetcKkrKLJJCEHOSI04vLNkzOvGNfzw0vV8MSKA9GaVACnUfJkgw==
X-Received: by 2002:a62:995c:: with SMTP id d89-v6mr26898974pfe.11.1541526523366;
        Tue, 06 Nov 2018 09:48:43 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g3-v6sm31281642pgr.40.2018.11.06.09.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 09:48:42 -0800 (PST)
Message-ID: <1541526521.196084.184.camel@acm.org>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, guro@fb.com,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-mm <linux-mm@kvack.org>
Date:   Tue, 06 Nov 2018 09:48:41 -0800
In-Reply-To: <CAKgT0UekDV4euPHs-wrZixGN1ryhZBq_42XdK6BapYke_xomJg@mail.gmail.com>
References: <20181105204000.129023-1-bvanassche@acm.org>
         <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
         <1541454489.196084.157.camel@acm.org>
         <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
         <1541457654.196084.159.camel@acm.org>
         <CAKgT0Udci4Ai4OD20NSRuDckE_G4RHma3Bg6H1Um6N9Se_zPew@mail.gmail.com>
         <1541462466.196084.163.camel@acm.org>
         <CAKgT0Ue59US_f-cZtoA=yVbFJ03ca5OMce2opUdQcsvgd8LWMw@mail.gmail.com>
         <1541464370.196084.166.camel@acm.org>
         <CAKgT0UekDV4euPHs-wrZixGN1ryhZBq_42XdK6BapYke_xomJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 09:20 -0800, Alexander Duyck wrote:
+AD4 On Mon, Nov 5, 2018 at 4:32 PM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 On Mon, 2018-11-05 at 16:11 -0800, Alexander Duyck wrote:
+AD4 +AD4 +AD4 If we really don't care then why even bother with the switch statement
+AD4 +AD4 +AD4 anyway? It seems like you could just do one ternary operator and be
+AD4 +AD4 +AD4 done with it. Basically all you need is:
+AD4 +AD4 +AD4 return (defined(CONFIG+AF8-ZONE+AF8-DMA) +ACYAJg (flags +ACY +AF8AXw-GFP+AF8-DMA)) ? KMALLOC+AF8-DMA :
+AD4 +AD4 +AD4         (flags +ACY +AF8AXw-GFP+AF8-RECLAIMABLE) ? KMALLOC+AF8-RECLAIM : 0+ADs
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Why bother with all the extra complexity of the switch statement?
+AD4 +AD4 
+AD4 +AD4 I don't think that defined() can be used in a C expression. Hence the
+AD4 +AD4 IS+AF8-ENABLED() macro. If you fix that, leave out four superfluous parentheses,
+AD4 +AD4 test your patch, post that patch and cc me then I will add my Reviewed-by.
+AD4 
+AD4 Actually the defined macro is used multiple spots in if statements
+AD4 throughout the kernel.

The only 'if (defined(' matches I found in the kernel tree that are not
preprocessor statements occur in Perl code. Maybe I overlooked something?

+AD4 The reason for IS+AF8-ENABLED is to address the fact that we can be
+AD4 dealing with macros that indicate if they are built in or a module
+AD4 since those end up being two different defines depending on if you
+AD4 select 'y' or 'm'.

From Documentation/process/coding-style.rst:

Within code, where possible, use the IS+AF8-ENABLED macro to convert a Kconfig
symbol into a C boolean expression, and use it in a normal C conditional:

.. code-block:: c

	if (IS+AF8-ENABLED(CONFIG+AF8-SOMETHING)) +AHs
		...
	+AH0

Bart.
