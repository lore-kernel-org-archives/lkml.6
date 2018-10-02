Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F8AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DE32083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DE32083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeJBVnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:43:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:34772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727113AbeJBVnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:43:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70DA6AF6E;
        Tue,  2 Oct 2018 14:59:31 +0000 (UTC)
Date:   Tue, 2 Oct 2018 16:59:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
Message-ID: <20181002145922.GZ18290@dhcp22.suse.cz>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
 <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
 <df95f828-1963-d8b9-ab58-6d29d2d152d2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df95f828-1963-d8b9-ab58-6d29d2d152d2@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-10-18 09:51:40, Michael Bringmann wrote:
[...]
> When the device-tree affinity attributes have changed for memory,
> the 'nid' affinity calculated points to a different node for the
> memory block than the one used to install it, previously on the
> source system.  The newly calculated 'nid' affinity may not yet
> be initialized on the target system.  The current memory tracking
> mechanisms do not record the node to which a memory block was
> associated when it was added.  Nathan is looking at adding this
> feature to the new implementation of LMBs, but it is not there
> yet, and won't be present in earlier kernels without backporting a
> significant number of changes.

Then the patch you have proposed here just papers over a real issue, no?
IIUC then you simply do not remove the memory if you lose the race.
-- 
Michal Hocko
SUSE Labs
