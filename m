Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeDYMxP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:53:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752224AbeDYMxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:53:11 -0400
Subject: Re: [PATCH] x86: Do not reserve a crash kernel region if booted on
 Xen PV
To: Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, Jean Delvare <jdelvare@suse.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180425120835.23cef60c@ezekiel.suse.cz>
From: Juergen Gross <jgross@suse.com>
Message-ID: <a41a685e-7953-0b63-4c85-7af8e346bd02@suse.com>
Date: Wed, 25 Apr 2018 14:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425120835.23cef60c@ezekiel.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/18 12:08, Petr Tesarik wrote:
> Xen PV domains cannot shut down and start a crash kernel. Instead,
> the crashing kernel makes a SCHEDOP_shutdown hypercall with the
> reason code SHUTDOWN_crash, cf. xen_crash_shutdown() machine op in
> arch/x86/xen/enlighten_pv.c.
> 
> A crash kernel reservation is merely a waste of RAM in this case. It
> may also confuse users of kexec_load(2) and/or kexec_file_load(2).
> When flags include KEXEC_ON_CRASH or KEXEC_FILE_ON_CRASH,
> respectively, these syscalls return success, which is technically
> correct, but the crash kexec image will never be actually used.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
