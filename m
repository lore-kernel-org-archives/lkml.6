Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933613AbeBMHrp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:47:45 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43106 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933463AbeBMHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:47:43 -0500
X-Google-Smtp-Source: AH8x2275qzKYcjHwa3WW9YLWxxYgKodBqEunuCv0u9x57VP9dB2Ehb4+C8DKWl/WibMDP57Q7JeH0g==
Date: Tue, 13 Feb 2018 08:47:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
Message-ID: <20180213074738.nrohmtchyr6fddhm@gmail.com>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
 <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw@amazon.co.uk> wrote:

> +extern enum spectre_v2_mitigation spectre_v2_enabled;

This needs to be exported if the KVM module wants to use it.

> +static inline bool spectre_v2_ibrs_all(void)
> +{
> +	return spectre_v2_enabled == SPECTRE_V2_IBRS_ALL;
> +}

> +     if (vmx->spec_ctrl && !spectre_v2_ibrs_all())

> +	if (!spectre_v2_ibrs_all) {

erm, that's a function, not a flag ...

Thanks,

	Ingo
