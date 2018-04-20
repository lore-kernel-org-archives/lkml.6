Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeDTVMQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:12:16 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44695 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753330AbeDTVMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:12:13 -0400
X-Google-Smtp-Source: AIpwx4+ihWXstP19LVTscDgsyQAnILXisP5E/nszSPJoj8xYvnj5MYbtX0RJmmcwWflCsUHExMNZQw==
Date: Fri, 20 Apr 2018 14:12:10 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Kshitiz Gupta <kshitiz.gupta@ni.com>
Cc: jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] igb: adjust SYSTIM register using TIMADJ
 register
Message-ID: <20180420211210.43oyqmqoho6gdnfh@localhost>
References: <1524254196-21705-1-git-send-email-kshitiz.gupta@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524254196-21705-1-git-send-email-kshitiz.gupta@ni.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 02:56:36PM -0500, Kshitiz Gupta wrote:
> Currently the driver adjusts time by reading the current time and then
> modifying it before writing to SYSTIM register. This can introduce
> inaccuracies in SYSTIM. With a PREEMPT_RT kernel, spinlocks may be
> interrupted, which in the existing implementation may lead to increased
> time between the read and the write.
> 
> Alternatively as per section 7.8.3.2 in the i210 data sheet, this
> operation can be done more accurately by using the TIMADJ registers,
> but this should only be used for adjustments less than one 8th of the
> sync interval. Once this register is written, the software can poll on
> TSICR.TADJ to make sure that adjustment operation is completed.

I doubt the utility of this.  The first jump is typically to correct a
large offset of seconds, minutes, or even months.  After that, the
servo corrects any remaining error.

It would help if you would show us a clearly improved servo response
with this change applied.

Thanks,
Richard
