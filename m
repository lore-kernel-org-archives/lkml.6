Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A5F04C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59423208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq6Ori3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59423208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934740AbeFMHmB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:42:01 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35100 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934619AbeFMHl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:41:58 -0400
Received: by mail-pl0-f65.google.com with SMTP id k1-v6so1042982plt.2;
        Wed, 13 Jun 2018 00:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e138+4iD8NOSnaVY2UiunQ7aCcai/kumxNbsfOT/iHU=;
        b=oq6Ori3eviHpuDx7iHfUiAyNXSu2ocLcn9d5jyvywLrIqNh3LCjIjLFRmD7qNQGFCn
         0v8NzwunyYyz0hBtArD3l3J7HzYrspYndVFqq/ArY2KjMNlUX7/z0BceiBU+8jfuUZrH
         u2AfV3yFhamBN8wr4jqsk987gU+VAskEeMott4u8jcvVi0AorLU/BLrCC3XBJC0Kq5Ua
         D2bx6zj7Dl3k5PVHGAArvJya2EHA1n7gV7tC9gjDsG4aqke8rzt9rsZGcgvLxzeOH8q8
         AB8Y47XVEj844ADB2TiMXhrCREKyJk95aBoUhzj3hjzPKQi+Y+dGey8irE81vE9U7gLU
         hvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e138+4iD8NOSnaVY2UiunQ7aCcai/kumxNbsfOT/iHU=;
        b=B4vaHNTwhIkpalKUYE5embCvmgQ1GCD7cP+cy83x/2rtMAoypmr3YRh0Q38vhkpb53
         VYzeEsAHsY6G0pnmwzFrXuc/9HfgaIOuVkumIvzpklcbFbKA/xBbr2s/m8nRSyV0gB0K
         IXgKqMjSF00Xmc/icSVpJQY0EPMk1O1BWEMol5D4vLsQ68J2kXtbzCPW3PWHyJyd1QRL
         9qV/fHr7LoKFpAY11UmFBN7koUWQyTzfO5Der3Qe4HswuflIAO8n8dLA8zK2Q341wzr4
         Vbf2KCO6fA5Z/8ETAdCBpx/3Pl/5GNnijcqUXLfVs8q3T+5QD4lltOz9VuiAkbhZ4nOz
         TmgA==
X-Gm-Message-State: APt69E0QF+aTHsU1fGUi64krW3DYZ22uv83xIBaFcScLXLlyFZXlBEGl
        +OTzI0uNu+x/tHuya1OwvdI=
X-Google-Smtp-Source: ADUXVKIgpFUPsmky2NqPafwUHVnNnY70GOzMpnvaZteONZ5bxZaI/r7Sy0SInqoGtmfAH9WN62hYfw==
X-Received: by 2002:a17:902:345:: with SMTP id 63-v6mr1630440pld.328.1528875717775;
        Wed, 13 Jun 2018 00:41:57 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
        by smtp.gmail.com with ESMTPSA id i7-v6sm5430609pfa.34.2018.06.13.00.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 00:41:56 -0700 (PDT)
Date:   Wed, 13 Jun 2018 17:41:41 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI
 watchdog operations
Message-ID: <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
In-Reply-To: <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 17:57:32 -0700
Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> Instead of exposing individual functions for the operations of the NMI
> watchdog, define a common interface that can be used across multiple
> implementations.
> 
> The struct nmi_watchdog_ops is defined for such operations. These initial
> definitions include the enable, disable, start, stop, and cleanup
> operations.
> 
> Only a single NMI watchdog can be used in the system. The operations of
> this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> variable is set to point the operations of the first NMI watchdog that
> initializes successfully. Even though at this moment, the only available
> NMI watchdog is the perf-based hardlockup detector. More implementations
> can be added in the future.

Cool, this looks pretty nice at a quick glance. sparc and powerpc at
least have their own NMI watchdogs, it would be good to have those
converted as well.

Is hpet a cross platform thing, or just x86? We should avoid
proliferation of files under kernel/ I think, so with these watchdog
driver structs then maybe implementations could go in drivers/ or
arch/

Thanks,
Nick
