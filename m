Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932912AbeCJMvR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 07:51:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:41598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932130AbeCJMvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 07:51:16 -0500
Date: Sat, 10 Mar 2018 13:51:13 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Alex Hung <alex.hung@canonical.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2] firmware: dmi_scan: add DMI_OEM_STRING support to
 dmi_matches
Message-ID: <20180310135113.61683f08@endymion>
In-Reply-To: <CAJ=jqubM2P8=pJQ8cofD3C67hiTOEoB4J99suAdS3YY30eZy-g@mail.gmail.com>
References: <1519800494-32107-1-git-send-email-alex.hung@canonical.com>
        <20180309143315.354ad0be@endymion>
        <CAJ=jqubM2P8=pJQ8cofD3C67hiTOEoB4J99suAdS3YY30eZy-g@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018 10:56:07 -0800, Alex Hung wrote:
> On Fri, Mar 9, 2018 at 5:33 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > However it doesn't make sense to commit this change unless there will
> > be at least one user of it. What is the status of the piece of code
> > which was supposed to use this new feature?  
> 
> The original use of DMI on _OSI is no needed anymore - the OEM _OSI
> string will always enabled; however, this patch is still needed
> because DMI_OEM_STRING are more suitable for many DMI quirks,
> especially for Dell systems, and many, if not all, DMI quirks for Dell
> systems with DMI_PRODUCT_NAME can be (and should be) replaced by
> DMI_OEM_STRING because 1) OEM string contains system id, 2) multiple
> product names can be used for the same system id and 3) the number DMI
> quirks can be reduced.
> 
> For example, the DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M") in
> commit 1f59ab2783aed04f131 can be replaced by
> DMI_MATCH_EXACT(DMI_OEM_STRING, "1[0669]")
> 
> I will start sending DMI quirks with DMI_OEM_STRING myself and perhaps
> sending a clean up patch to replace DMI_PRODUCT_NAME by DMI_OEM_STRING
> for the Dell systems I have access to. With this patch in place first,
> I am able to convince others to use DMI_OEM_STRING because there will
> fewer risks to spend time in vain.

Fair enough. I've fixed the blank line issue and queued your patch for
kernel v4.17, thanks for your contribution.

-- 
Jean Delvare
SUSE L3 Support
