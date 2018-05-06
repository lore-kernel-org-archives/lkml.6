Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeEFGT7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:19:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750983AbeEFGT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:19:58 -0400
Date: Sun, 6 May 2018 14:19:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3 2/3] resource: add walk_system_ram_res_rev()
Message-ID: <20180506061951.GF30581@MiWiFi-R3L-srv>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-3-bhe@redhat.com>
 <20180419100745.GC3896@pd.tnic>
 <20180426085649.GC18395@localhost.localdomain>
 <20180426110905.GH15043@pd.tnic>
 <20180426132204.GF19030@localhost.localdomain>
 <20180504101631.GB9377@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504101631.GB9377@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/18 at 12:16pm, Borislav Petkov wrote:
> On Thu, Apr 26, 2018 at 09:22:04PM +0800, Baoquan He wrote:
> > I noticed maintainers merged patches with this Message-ID, could you
> > tell how to get this Message-ID?
> 
> https://en.wikipedia.org/wiki/Message-ID
thx.
> 
> > This is not a thing that one is top down, the other is bottom up. For
> > us, they might be so different on details of code, for customers, they
> > just think them as a same thing. They may say I just get a new machine,
> > and still do kexec loading, why these top-down, bottom-up things come
> > up.
> 
> So if I read the above correctly, it doesn't matter whether top-down or
> bottom-up.

Well, kexec_file loading is added because kernel signature verification
has to be done in kernel space, it's implemented by porting code of user
space utility kexc-tools to kernel. In essence both the kexec loading
and kexec_file loading are the same, they are all used to load kernel
for the furture kexec/kdump jumping. Now they have different kernel
loading position, could you tell how you get the conclusion that it
doesn't matter? And what's your theory basis?

And KASLR also changes kernel's position, I don't think users have to
know all these details to exclude unnecessary noise. 

> 
> > And this is not causing code churn. You can see that by replacing
> > pointer operation with list_head, code in kernel/resource.c related to
> > child list iteration is much easier to read,
> 
> Now *this* is starting to sound like some reason "why". If it is better
> readability, then say so in the commit message.

Yes, I can add it to log in next post. While the main reason I made
this is for the top down searching of system RAM in kexec_file
loading. 
