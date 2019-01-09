Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5400C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3AE206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfAIMJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:09:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730403AbfAIMJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:09:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7606389AD7;
        Wed,  9 Jan 2019 12:09:37 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.40.205.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 342305D76A;
        Wed,  9 Jan 2019 12:09:33 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <Babu.Moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?utf-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        David Duncan <davdunc@amazon.com>
Subject: Re: [PATCH] x86/intel_rdt: use rdmsr_safe() to workaround AWS host issue
In-Reply-To: <20190109113915.GB15665@zn.tnic>
References: <20181220134046.7916-1-vkuznets@redhat.com> <20181220161722.GD31403@zn.tnic> <51dcb13a-4751-47f5-1e01-f6731a2c6f3c@intel.com> <20521afe-09af-7acf-6f32-3f6e9a971091@intel.com> <20190109113915.GB15665@zn.tnic>
Date:   Wed, 09 Jan 2019 13:09:31 +0100
Message-ID: <87bm4qoww4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Jan 2019 12:09:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> So, assuming RDT is not going to be supported in a guest

Hm, why is that? In theory, hypervisors can pass through or emulate the
required MSRs...

-- 
Vitaly
