Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeFANv3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:51:29 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:44259 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeFANv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:51:26 -0400
X-Originating-IP: 208.88.110.46
Date: Fri, 1 Jun 2018 09:51:21 -0400
From: Hugo Lefeuvre <hle@owl.eu.com>
To: valdis.kletnieks@vt.edu
Cc: devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] staging: pi433: add rw semaphore fixing concurrency
 issues
Message-ID: <20180601135121.GA11084@hle-laptop.local>
References: <20180601125037.GA2339@hle-laptop.local>
 <255415.1527859942@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <255415.1527859942@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valdis,

> > @@ -805,9 +809,11 @@ pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
> >  	if (bytes_received > 0) {
> >  		retval = copy_to_user(buf, device->rx_buffer, bytes_received);
> >  		if (retval)
> > +			up_read(&instance->instance_sem);
> >  			return -EFAULT;
> >  	}
> >
> > +	up_read(&instance->instance_sem);
> >  	return bytes_received;
> >  }
> 
> This doesn't do what you think.

Oh right, no curly braces, didn't notice it. Thanks !

Otherwise, do you think the usage of rw semaphore is appropriate in this
case ?

Regards,
 Hugo

-- 
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA
