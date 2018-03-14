Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeCNEk5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 00:40:57 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:40503 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753245AbeCNEk4 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 14 Mar 2018 00:40:56 -0400
Date: Wed, 14 Mar 2018 12:40:45 +0800
From: joeyli <jlee@suse.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Howells <dhowells@redhat.com>, linux-fs@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] MODSIGN: print appropriate status message when
 getting UEFI certificates list
Message-ID: <20180314044045.GC19718@linux-l9pv.suse>
References: <20180313103559.13032-1-jlee@suse.com>
 <20180313103559.13032-3-jlee@suse.com>
 <1520961470.5360.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520961470.5360.18.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for your review.

On Tue, Mar 13, 2018 at 10:17:50AM -0700, James Bottomley wrote:
> On Tue, 2018-03-13 at 18:35 +0800, Lee, Chun-Yi wrote:
> > When getting certificates list from UEFI variable, the original error
> > message shows the state number from UEFI firmware. It's hard to be
> > read by human. This patch changed the error message to show the
> > appropriate string.
> > 
> > The message will be showed as:
> > 
> > [    0.788529] MODSIGN: Couldn't get UEFI MokListRT: EFI_NOT_FOUND
> > [    0.788537] MODSIGN: Couldn't get UEFI MokListXRT: EFI_NOT_FOUND
> 
> I keep saying this, but these error messages need to be gated on the
> presence of shim for the non-shim secure boot case.  You can't assume
> the shim variables are there because they won't be in the case of a
> fully owned system.

I will change the message to pr_debug.

Thanks a lot!
Joey Lee 
