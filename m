Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbeDIPym (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:54:42 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:50454 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDIPyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:54:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 861AB335ECA
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Apr 2018 17:54:33 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Christoph Hellwig <hch@lst.de>
Cc: Kees Cook <keescook@chromium.org>, David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
        paolo.valente@linaro.org
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <20180409093520.GB10405@lst.de>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com>
 <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com>
 <2679696.GDoj5zcZOu@natalenko.name> <20180409093520.GB10405@lst.de>
Message-ID: <20ba00cdfd1428aff13b7ea4cb42b03c@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1523289274;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=qKYGAfhths+YLACd1NnLdG9gJEPf/L+5kUpE9ZQy2Ig=;
        b=fafQLpEF98uZq15Ed21Jk5lVMNRHFiU0WsYlPtfBl59Gj6R1uE8uW3NDaS8rOb/jIg+ceK
        WduEcG2Rouc0EaJJPx7wT95236oBaCd+6r8SM8xKk0nO+d/A9xmR0pjZ4q4kk9QS2sOKMy
        OJ25QFIADALiJCLrxPluVap/JAeb0ug=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1523289274; a=rsa-sha256;
        cv=none;
        b=G03H+6UjdUzeHHqH1lAcgLY132PylisQi52+iXHxorx8XF06jNfb+I71+h8e7GCUs8GLoFB4aJMjNPT/M07xTYpHbaw6uwAujW5HpTt8cx/prRfc0jhYnHV2lnz/zbsUUyiL4v9hmXCPQhEJimSFO0XhzeD8J+K2IXnJB9LpGtM=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

09.04.2018 11:35, Christoph Hellwig wrote:
> I really can't make sense of that report.

Sorry, I have nothing to add there so far, I just see the symptom of 
something going wrong in the ioctl code path that is invoked by 
smartctl, but I have no idea what's the minimal environment to reproduce 
it. I'll try to collect more info.

> And I'm also curious why
> you think 17cb960f29c2 should change anything for that code path.

Maybe, I've just mis-read that code.

Regards,
   Oleksandr
