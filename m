Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeFANl7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:41:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:55427 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeFANl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:41:56 -0400
Date: Fri, 1 Jun 2018 15:41:54 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Alex Richman <alex.r@gblabs.co.uk>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: mlock() confusing 1 half of system RAM limit
Message-ID: <20180601134154.GD15278@dhcp22.suse.cz>
References: <c43ad840-dcab-b86f-bf15-ffb26b66d37b@gblabs.co.uk>
 <20180601114425.GA15686@dhcp22.suse.cz>
 <3e33edd7-89dd-1c09-77df-a2ae23c208f1@gblabs.co.uk>
 <20180601130524.GB15278@dhcp22.suse.cz>
 <1ae5c450-1ffe-cf15-e878-b40f30c0acc3@gblabs.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ae5c450-1ffe-cf15-e878-b40f30c0acc3@gblabs.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-06-18 14:24:23, Alex Richman wrote:
> Ah, that's it.  Increased the limit on the mount and it works fine now.

Well, it is hidden very well. It is not until the page fault time (or
get_user_pages aka __mm_populate) when the operation fails and remasks
ENOSPC -> VM_FAULT_SIGBUS -> EFAULT -> ENOMEM on the way.
-- 
Michal Hocko
SUSE Labs
