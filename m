Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A11C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2DD20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2DD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754514AbeFTPfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:35:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754468AbeFTPfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:35:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 840AA4022414;
        Wed, 20 Jun 2018 15:35:31 +0000 (UTC)
Received: from treble (ovpn-124-105.rdu2.redhat.com [10.10.124.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDF9A111E40F;
        Wed, 20 Jun 2018 15:35:30 +0000 (UTC)
Date:   Wed, 20 Jun 2018 10:35:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Xi Ruoyao <ryxi@stu.xidian.edu.cn>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kbuild: fix mismatched if/endif pairs
Message-ID: <20180620153528.jbevuhgj3rgvcbte@treble>
References: <180617191612798b1a5d7a74c59e7905c31fd3f36f5d@stu.xidian.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <180617191612798b1a5d7a74c59e7905c31fd3f36f5d@stu.xidian.edu.cn>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 20 Jun 2018 15:35:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 20 Jun 2018 15:35:31 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 06:16:07PM +0800, Xi Ruoyao wrote:
> In scripts/Makefile.build, there are two mismatched if/endif pairs.
> They stop the generation of orc unwind table if CONFIG_FTRACE_MCOUNT_RECORD
> is not set.  dmesg complains:
> 
> WARNING: WARNING: Bad or missing .orc_unwind table.  Disabling unwinder.
> 
> This comment moves an endif to match the if/endif pairs.
> 
> Signed-off-by: Xi Ruoyao <ryxi@stu.xidian.edu.cn>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
