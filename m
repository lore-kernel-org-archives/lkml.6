Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeDQUeK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 16:34:10 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:3236 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDQUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 16:34:08 -0400
Date: Tue, 17 Apr 2018 14:34:05 -0600
From: Randy Wright <rwright@hpe.com>
To: joeyli <jlee@suse.com>, dyoung@redhat.com
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] efi: Fix the size not consistent issue when unmapping
 memory map
Message-ID: <20180417203405.GA4574@rfwz>
Reply-To: rwright@hpe.com
References: <20180413062716.8040-1-jlee@suse.com>
 <20180416025734.GA26685@dhcp-128-65.nay.redhat.com>
 <20180416030904.GB26685@dhcp-128-65.nay.redhat.com>
 <20180416063738.GH16023@linux-l9pv.suse>
 <20180417003522.GA2741@rfwz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417003522.GA2741@rfwz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 06:35:22PM -0600, Randy Wright wrote:

> ... I will plan to run the same test tomorrow on
> a build of the SuSE 4.4.120-94.17 kernel, on which I had also reported
> the original bug.

I carried out the test on the older kernel today. I found the version of
arch/x86/kernel/kexec-bzimage64.c in the SuSE kernel version
4.4.120-94.17 was sufficiently different from the newer version that one
chunk of the patch under discussion was rejected.  Specifically, the
'struct kexec_buf kbuf' is not found in that older SuSE version of
kexec-bzimage64.c.   But I made the same modification to the
calculation of variable params_misc_sz in the older source, ran the same
test, and there were no longer any warnings from early_ioremap.c.

-- 
Randy Wright            Hewlett Packard Enterprise
Phone: (970) 898-0998   Mail: rwright@hpe.com
