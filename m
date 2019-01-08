Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31971C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F028E2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfAHJMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:12:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHJMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:12:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D65C89AE6;
        Tue,  8 Jan 2019 09:12:00 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B095C21E;
        Tue,  8 Jan 2019 09:11:55 +0000 (UTC)
Date:   Tue, 8 Jan 2019 17:11:52 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH V2] x86/kexec: fix a kexec_file_load failure
Message-ID: <20190108091152.GA715@dhcp-128-65.nay.redhat.com>
References: <20181228011247.GA9999@dhcp-128-65.nay.redhat.com>
 <20190108052440.GA17983@MiWiFi-R3L-srv>
 <20190108084657.GA32321@dhcp-128-65.nay.redhat.com>
 <20190108085157.GB17983@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108085157.GB17983@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 08 Jan 2019 09:12:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/19 at 04:51pm, Baoquan He wrote:
> On 01/08/19 at 04:46pm, Dave Young wrote:
> > > Wondering why this place doesn't need the initialization assignment.
> > > Isn't it to assign in all places before kexec_add_buffer() calling?
> > 
> > C designated initializers will make sure to initialize it as zero.
> > We set KEXEC_BUF_MEM_UNKNOWN as 0 so it just works.
> 
> Got it, it works, thanks. People may need check code to find out
> KEXEC_BUF_MEM_UNKNOWN is 0, then realize this fact.

Agreed,  it is not very clear now. It's better to improve it with some explict
initial value since we have the macro.  But since this is a regression
I suggest to fix the bug first, I can send a patch later for the
improvement. 

Thanks!
> 
> Other than this, it looks good to me, ack it.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks
> Baoquan
