Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F77C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1148920844
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1148920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeH2LIq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:08:46 -0400
Received: from ozlabs.org ([203.11.71.1]:49949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeH2LIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:08:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 420cKT0BSfz9s3Z;
        Wed, 29 Aug 2018 17:13:17 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id DACDAEE791E; Wed, 29 Aug 2018 17:13:16 +1000 (AEST)
Message-ID: <3c36e64e64742e79b72faf1f52a3c1fb2b3d1983.camel@neuling.org>
Subject: Re: [PATCH v7 1/2] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
From:   Michael Neuling <mikey@neuling.org>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 Aug 2018 17:13:16 +1000
In-Reply-To: <61048333bca549ffa275bf32eeb1a2480340a7e0.camel@neuling.org>
References: <1534743704-4760-1-git-send-email-ego@linux.vnet.ibm.com>
         <1534743704-4760-2-git-send-email-ego@linux.vnet.ibm.com>
         <61048333bca549ffa275bf32eeb1a2480340a7e0.camel@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 17:04 +1000, Michael Neuling wrote:
> > +What: 		/sys/devices/system/cpu/cpu[0-9]+/small_core_siblings
> 
> Shouldn't we put this in the topology/ subdir with with the other items like
> it?

Also, please follow the same format as *_sibilings files topology/ where they
are just a mask (this patch currently has it as a comma separated list).

Mikey
