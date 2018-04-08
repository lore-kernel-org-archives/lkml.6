Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeDHEGq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 00:06:46 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:59905 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeDHEGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 00:06:44 -0400
X-RM-TRANSID: 2eec5ac99320406-a67dd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
X-RM-TRANSID: 2ee45ac9931ff04-55a8a
From: "Zhang Zhuoyu" <zhangzhuoyu@cmss.chinamobile.com>
To: "'David Disseldorp'" <ddiss@suse.de>
Cc: <nab@linux-iscsi.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1521625963-657195-1-git-send-email-zhangzhuoyu@cmss.chinamobile.com>       <20180405131212.3f26339d@suse.de> <20180406140934.2dfafd45@suse.de>
In-Reply-To: <20180406140934.2dfafd45@suse.de>
Subject: RE: [PATCH 1/1] target:separate tx/rx cmd_puds
Date: Sun, 8 Apr 2018 11:57:18 +0800
Message-ID: <000001d3ceed$b0d9c870$128d5950$@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJQLVfv6VWhVBGUZpT/0j4dCNIE4wKSJYTnAkM35SKi1tODUA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: David Disseldorp [mailto:ddiss@suse.de]
> Sent: Friday, April 6, 2018 8:10 PM
> To: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
> Cc: nab@linux-iscsi.org; linux-scsi@vger.kernel.org; target-
> devel@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/1] target:separate tx/rx cmd_puds
> 
> On Thu, 5 Apr 2018 13:12:12 +0200, David Disseldorp wrote:
> 
> > > -CONFIGFS_ATTR_RO(target_stat_tgt_port_, in_cmds);
> > > +CONFIGFS_ATTR_RO(target_stat_tgt_port_, tx_cmds);
> > > +CONFIGFS_ATTR_RO(target_stat_tgt_port_, rx_cmds);
> >
> > I don't think the in_cmds metric should be deleted here. It could be
> > calculated on the fly via tx_cmds + rx_cmds + nodata_cmds.
> 
> @Zhang Zhuoyu: How about something like the following?
> https://git.samba.org/?p=ddiss/linux.git;a=commitdiff;h=73723ccf433424721
> 830797d70cfb88d4596e0fc
> 

Mmm... This patch is much better. 
Looks good to me.

Zhuoyu

> ...this keeps the in_cmds metric, and renames tx/rx_cmds read/write_cmds
> respectively. read/write_cmds is still a bit ambiguous, as it refers to
the
> command data direction rather than SCSI READ/WRITE CDBs, but IMO it's
> clearer, and more consistent with the read/write_mbytes metrics.
> 
> Cheers, David
