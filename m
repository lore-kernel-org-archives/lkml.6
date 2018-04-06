Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeDFMJj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:09:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:45549 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbeDFMJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:09:37 -0400
Date: Fri, 6 Apr 2018 14:09:34 +0200
From: David Disseldorp <ddiss@suse.de>
To: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
Cc: nab@linux-iscsi.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] target:separate tx/rx cmd_puds
Message-ID: <20180406140934.2dfafd45@suse.de>
In-Reply-To: <20180405131212.3f26339d@suse.de>
References: <1521625963-657195-1-git-send-email-zhangzhuoyu@cmss.chinamobile.com>
        <20180405131212.3f26339d@suse.de>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2018 13:12:12 +0200, David Disseldorp wrote:

> > -CONFIGFS_ATTR_RO(target_stat_tgt_port_, in_cmds);
> > +CONFIGFS_ATTR_RO(target_stat_tgt_port_, tx_cmds);
> > +CONFIGFS_ATTR_RO(target_stat_tgt_port_, rx_cmds);  
> 
> I don't think the in_cmds metric should be deleted here. It could be
> calculated on the fly via tx_cmds + rx_cmds + nodata_cmds.

@Zhang Zhuoyu: How about something like the following?
https://git.samba.org/?p=ddiss/linux.git;a=commitdiff;h=73723ccf433424721830797d70cfb88d4596e0fc

...this keeps the in_cmds metric, and renames tx/rx_cmds read/write_cmds
respectively. read/write_cmds is still a bit ambiguous, as it refers to
the command data direction rather than SCSI READ/WRITE CDBs, but IMO
it's clearer, and more consistent with the read/write_mbytes metrics.

Cheers, David
