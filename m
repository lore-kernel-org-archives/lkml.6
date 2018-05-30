Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeE3OhR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:37:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeE3OhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:16 -0400
Message-Id: <20180530142236.667774973@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 00/11] select_idle_sibling rework
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is all still very preliminary and could all still go up in flames (it has
only seen hackbench so far). This is mostly the same code I posted yesterday,
but hopefully in a more readable form.

This fixes the SIS_PROP as per the outline here:

  https://lkml.kernel.org/r/20180425153600.GA4043@hirez.programming.kicks-ass.net

and Rohit's suggestion of folding the iteration loops.

For testing I would suggest to ignore the last 3 patches, those are purely
cleanups once the first lot is found to actually work as advertised.
