Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbeCFLXF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:23:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:36368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753578AbeCFLXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:23:04 -0500
Subject: Re: [PATCH v3 5/8] scsi: hisi_sas: increase timer expire of internal
 abort task
To: John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        Xiaofei Tan <tanxiaofei@huawei.com>
References: <1520261330-204596-1-git-send-email-john.garry@huawei.com>
 <1520261330-204596-6-git-send-email-john.garry@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3983d075-af2e-5c69-2708-51db8a6b79cb@suse.de>
Date: Tue, 6 Mar 2018 12:23:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520261330-204596-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 03:48 PM, John Garry wrote:
> From: Xiaofei Tan <tanxiaofei@huawei.com>
> 
> The current 110ms expiry time is not long enough for the internal
> abort task.
> 
> The reason is that the internal abort task could be blocked in HW
> if the HW is retrying to set up link. The internal abort task will
> be executed only when the retry process finished.
> 
Hmm. That sounds weird.
I would have expected that a link retrain will force a device reset,
after which no tasks should be active on the target.
Consequently the succeeding abort task will be a no-op.
Care to clarify?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
