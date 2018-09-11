Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363B020645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363B020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIKUZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:25:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbeIKUZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:25:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EB1281A8073;
        Tue, 11 Sep 2018 15:25:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 327B32156889;
        Tue, 11 Sep 2018 15:25:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 11 Sep 2018 17:25:34 +0200 (CEST)
Date:   Tue, 11 Sep 2018 17:25:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_arg_page() && ptr_size accounting
Message-ID: <20180911152531.GA9450@redhat.com>
References: <20180910122907.GA23963@redhat.com>
 <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <CAGXu5jJ+aiJWL0G0Zpq2Df4ADEmpSBZHSTaUkzJiNbgg+B6x2Q@mail.gmail.com>
 <20180910172109.GB27005@redhat.com>
 <CAGXu5jL_a5B6w39Vb3S07-Epu4JGPTB5N6A75ERVOryvNeA7ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL_a5B6w39Vb3S07-Epu4JGPTB5N6A75ERVOryvNeA7ZA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 11 Sep 2018 15:25:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 11 Sep 2018 15:25:35 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Kees Cook wrote:
>
> On Mon, Sep 10, 2018 at 10:21 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Could you explain what this patch actually prevents from? Especially
> > now that we have stack_guard_gap?
>
> One of the many Stack Clash abuses was that it was possible to jump
> over the stack gap with outrageous environment variables that got
> expanded in stupid ways by, IIRC, glibc or the dynamic linker. The
> point here was to be defensive in the face of future weaknesses, and
> try to be robust in the face of crazy execs but workable under normal
> (but large) execs.

IOW, unlimited arg size makes many interesting attacks possible.

This is clear, I was confused because I thought this patch fixes some
particular problem not explained in the changelog.

Thanks,

Oleg.

