Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBFPCD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:02:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:63888 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeBFPB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:01:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,469,1511856000";
   d="scan'208";a="199038204"
Date: Tue, 6 Feb 2018 08:05:52 -0700
From: Keith Busch <keith.busch@intel.com>
To: sbates@raithlin.com
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Fix incorrect use of CMB size to calculate
 q_depth
Message-ID: <20180206150552.GD31110@localhost.localdomain>
References: <1517869943-3655-1-git-send-email-sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517869943-3655-1-git-send-email-sbates@raithlin.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 03:32:23PM -0700, sbates@raithlin.com wrote:
>  
> -	if (dev->cmb && (dev->cmbsz & NVME_CMBSZ_SQS)) {
> +	if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {

Is this a prep patch for something coming later? dev->cmb is already
NULL if use_cmb_sqes is false.
