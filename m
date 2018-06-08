Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aezyNB5SGluUfQAAmS7hNA
	; Fri, 08 Jun 2018 09:53:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BAA76607E4; Fri,  8 Jun 2018 09:53:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsVyTYPg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 47A9D60290;
	Fri,  8 Jun 2018 09:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47A9D60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeFHJxc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:53:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46086 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbeFHJx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:53:29 -0400
Received: by mail-lf0-f67.google.com with SMTP id j13-v6so19132922lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YqjHqMOHn6Id/npyL3LA9x6cRtuVLVcGMfO/vigX/c=;
        b=nsVyTYPgkiV8aKFjXhM0R6frayirAAyydJp9E0aj08To+e2qzWlmhTWDka0Z20ltc8
         qWvVWCtf3PLiGINlWgpoDx3pu2wflDh+ZfipQMKYjx+ZppmS7IbKldwxxJflQsHE0huf
         3yNrY/seHKwVBdWrcqrMi25nnnn9pcQsFzi6b1nW7Gc+wUZ2i6sfdO3q/5SpkwUnMCrp
         U8f2kxbTZKGO0xN0buzvp8RgPKzfrFrzulAH/kK4TinLkto4v3IbpxEVc3YfsnX8e2Ri
         p7nsnBitGgoYF46IBPIZl1UOalxQ9vgDznLutY3Okat5w8wnPKkxVo+e7dAi9jiUXU/X
         CimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YqjHqMOHn6Id/npyL3LA9x6cRtuVLVcGMfO/vigX/c=;
        b=oauwa/xtXYfnCvgWSz9SY/T+GEz9/1+H89iSX/Q6Nt7p6btClkCXNCTliqQzPRDtwR
         TpJd3woSJaFgCFSn90Q40lct+4C8sf7aMb+bxQsmpMDEpZOeGpG/jDavjjq1gNbgvXRG
         8ZEdCYpXpZUfAOK6A8MI4m8phRh8S/8gwbrNl7BvnLF884gCODDcSMLxyfvDCMQlH705
         tjrARztacrtV+cl5eSOgINsCYgYMyKho0/k1vD3d+mdI083MpKB1tX3zjDU2KFj7MDBQ
         lP1ic+z3AgQ2lSswJqEYZ14o/E+Wmex4dP25lL335H3pQ/UYAwgU26OyZUHKcnsFvDuX
         G5CQ==
X-Gm-Message-State: APt69E2fw0a0Yu+F/mTXRP5TeocdJNIllNBIb3/bhocFUvJov2arMevo
        F5aePM9kx8XgZEwiGG+Prnqaq/4qobe5tlnCuwQ=
X-Google-Smtp-Source: ADUXVKIzVnKOUhNDSpnjJsyTTjZ6RKYItcwnFWhCR/ff6BnmC7+2PcThJErKH5QB5Cs/wFPQavdhqB+y+muU55dZ4s0=
X-Received: by 2002:a19:e544:: with SMTP id c65-v6mr3641201lfh.134.1528451607891;
 Fri, 08 Jun 2018 02:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com> <20180603124941.GA29497@rapoport-lnx>
 <CAHCio2ifo3SNH9E3GX2=q1a=MNiNnoCu+2a++yX5_xMBheya5g@mail.gmail.com>
 <CAHCio2in8NXZRanE9MS0VsSZxKaSvTy96TF59hODoNCxuQTz5A@mail.gmail.com> <20180604045812.GA15196@rapoport-lnx>
In-Reply-To: <20180604045812.GA15196@rapoport-lnx>
From: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date: Fri, 8 Jun 2018 17:53:14 +0800
Message-ID: <CAHCio2gj-DoOek0RN718TCLZsOpNPd6Ua88HPijdqezuySDjaw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Refactor part of the oom report in dump_header
To: rppt@linux.vnet.ibm.com
Cc: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike
> My question was why do you call to alloc_constrained in the dump_header()
> function rather than pass the constraint that was detected a bit earlier to
> that function?

dump_header will be called by three functions: oom_kill_process,
check_panic_on_oom, out_of_memory.
We can get the constraint from the last two
functions(check_panic_on_oom, out_of_memory), but I need to
pass a new parameter(constraint) for oom_kill_process.

Thanks
