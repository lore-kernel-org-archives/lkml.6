Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964951AbeBMNry (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:47:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:41551 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964832AbeBMNrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:47:53 -0500
Message-ID: <1518529671.3592.9.camel@suse.de>
Subject: Re: [PATCH 1/1] nvme: implement log page low/high offset and dwords
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Matias =?ISO-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>, hch@lst.de,
        keith.busch@intel.com
Cc: javier@cnexlabs.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Date: Tue, 13 Feb 2018 14:47:51 +0100
In-Reply-To: <20180213124916.28653-2-mb@lightnvm.io>
References: <20180213124916.28653-1-mb@lightnvm.io>
         <20180213124916.28653-2-mb@lightnvm.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-13 at 13:49 +0100, Matias Bjørling wrote:
> +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +			    u8 log_page, void *log,
> +			    size_t size, size_t offset)
> +{
> +	struct nvme_command c = { };
> +	unsigned long dwlen = (size / 4) - 1;

Consulting my long gone maths knowledge suggests the parantheses aren't
really needed here.

-- 
Johannes Thumshirn                                          Storage
jthu
mshirn@suse.de                                +49 911 74053 689
SUSE
LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane
Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38
9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
