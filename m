Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeFAWqV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 18:46:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:57371 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeFAWqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 18:46:19 -0400
Date: Sat, 2 Jun 2018 00:46:17 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v4 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
Message-ID: <20180601224617.GU4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
 <20180601182107.GO4511@wotan.suse.de>
 <1527892795.13403.26.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1527892795.13403.26.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:39:55PM -0400, Mimi Zohar wrote:
> On Fri, 2018-06-01 at 20:21 +0200, Luis R. Rodriguez wrote:
> > On Tue, May 29, 2018 at 02:01:57PM -0400, Mimi Zohar wrote:
> > > Luis, is the security_kernel_post_read_file LSM hook in
> > > firmware_loading_store() still needed after this patch?  Should it be
> > > calling security_kernel_load_data() instead?
> > 
> > That's up to Kees to decide as he added that hook, and knows
> > what LSMs may be doing with it. From my perspective it is confusing
> > to have that hook there so I think it could be removed now.
> > 
> > Kees?
> 
> Commit 6593d92 ("firmware_class: perform new LSM checks") references
> two methods of loading firmware -  filesystem-found firmware and
> demand-loaded blobs.  I assume this call in firmware_loading_store()
> is the demand-loaded blobs.  Does that method still exist?  Is it
> still being used?

Yeah its the stupid sysfs interface. So likely loadpin needs porting
as you IMA as you did.

  Luis
