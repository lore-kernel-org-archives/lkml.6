Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbeEHOU6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:20:58 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:33761 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeEHOUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:20:55 -0400
X-Google-Smtp-Source: AB8JxZqBMvPzO/qphLIsONclkXAmBP8bS9/4FqIpTUMUxW6V+Cx8j3N91mEsRK96aQC5J1kNMUi79g==
Date: Tue, 8 May 2018 07:20:52 -0700
From: Tejun Heo <tj@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-pmp: Fix a possible data race in
 sata_pmp_handle_link_fail
Message-ID: <20180508142052.GK2368884@devbig577.frc2.facebook.com>
References: <20180508082140.14038-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508082140.14038-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 04:21:40PM +0800, Jia-Ju Bai wrote:
> The write operation to "link->flags" is protected by
> the lock on line 898, but the read operation to
> this data on line 892 is not protected by the lock.
> Thus, there may exist a data race for "link->flags".
> 
> To fix this data race, the read operation to "link->flags" 
> should be also protected by the lock.

Same as the previous patch.

Thanks.

-- 
tejun
