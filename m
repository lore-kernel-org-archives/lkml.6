Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753009AbeBSQXH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:23:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:53910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752670AbeBSQXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:23:06 -0500
Subject: Re: [PATCH] x86: fix {pmd,pud}_{set,clear}_flags()
To: Jan Beulich <JBeulich@suse.com>, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <5A8AF1BB02000078001A91C3@suse.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <44911e30-7d7a-14fd-1a70-ae3d92bfc771@suse.com>
Date: Mon, 19 Feb 2018 17:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A8AF1BB02000078001A91C3@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/18 15:48, Jan Beulich wrote:
> Just like pte_{set,clear}_flags() their PMD and PUD counterparts should
> not do any address translation. This was outright wrong under Xen
> (causing a dead boot with no useful output on "suitable" systems), and
> produced needlessly more complicated code (even if just slightly) when
> paravirt was enabled.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: stable@vger.kernel.org 

While the changes look alright I'm really curious which kind of failure
you are seeing, especially considering how long those functions haven't
been changed (since more than 6 years).


Juergen
