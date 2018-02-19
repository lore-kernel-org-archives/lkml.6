Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeBSREU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:04:20 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:52245 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeBSRET (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Mon, 19 Feb 2018 12:04:19 -0500
Message-Id: <5A8B119F02000078001A9412@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 19 Feb 2018 10:04:15 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Juergen Gross" <jgross@suse.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "lkml" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: fix {pmd,pud}_{set,clear}_flags()
References: <5A8AF1BB02000078001A91C3@suse.com>
 <44911e30-7d7a-14fd-1a70-ae3d92bfc771@suse.com>
In-Reply-To: <44911e30-7d7a-14fd-1a70-ae3d92bfc771@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 19.02.18 at 17:23, <jgross@suse.com> wrote:
> On 19/02/18 15:48, Jan Beulich wrote:
>> Just like pte_{set,clear}_flags() their PMD and PUD counterparts should
>> not do any address translation. This was outright wrong under Xen
>> (causing a dead boot with no useful output on "suitable" systems), and
>> produced needlessly more complicated code (even if just slightly) when
>> paravirt was enabled.
>> 
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> Cc: stable@vger.kernel.org 
> 
> While the changes look alright I'm really curious which kind of failure
> you are seeing, especially considering how long those functions haven't
> been changed (since more than 6 years).

It's the new use of pmd_set_flags() in 2cc42bac1c ("x86-64/Xen:
eliminate W+X mappings"), and due to the (very odd afaic) identity
map handling the issue is invisible on most systems/setups.

Jan
