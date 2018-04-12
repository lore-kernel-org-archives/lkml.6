Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeDLTEl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:04:41 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:46526 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeDLTEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:04:39 -0400
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1523559876; a=rsa-sha256;
        cv=none;
        b=WYNvwEUxbF8UxSKlcLdJXZhUABsZ+4ElYr3KFElmZyRLRqJZnXWjja8HYElMA+wj5qGWqY10JcUrzSgWat1Ej9jq5R7Z28nUJ84l7to5j4Tm2gxch8WITw73gdW6HDZpbnErJ7BvZLxqKv6eDEhxgg1Waxjo02d1Xj//+WolZSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1523559876;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6uh1DBLEIt8SIdBPtxSpsIV6kEUfSaykDn2XUUTNOP8=;
        b=W3KKYEpq2TxCVkjJjdiCmMVwmjGNkd5GcU6BU9/t16kBzfSgv0qjbfDMXAvhCzGyFlCwml
        THOWKkpMGUL8T9fCmkAO6cPNFVQlkONMcK90BwhXqiogN9PGj31MVmQRUkDfxHHJRLcRGM
        qDamOksy5QmJ91SKHy6NCU+LDb7up+4=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 20AE13371E5
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
        paolo.valente@linaro.org
Subject: Re: usercopy whitelist woe in scsi_sense_cache
Date: Thu, 12 Apr 2018 21:04:35 +0200
Message-ID: <2864697.7uzmEJovl2@natalenko.name>
In-Reply-To: <CAGXu5j+_UH0h9qeYCKKjhC7jw-mi_=fg4ASHi2=pCF9xGTpA4Q@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5j+-PNYxSc3v+QtQLK0S3wdtFthFSxNM_69kFDnPQX0Gaw@mail.gmail.com> <CAGXu5j+_UH0h9qeYCKKjhC7jw-mi_=fg4ASHi2=pCF9xGTpA4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3CJ4lM6006733

Hi.

On čtvrtek 12. dubna 2018 20:44:37 CEST Kees Cook wrote:
> My first bisect attempt gave me commit 5448aca41cd5 ("null_blk: wire
> up timeouts"), which seems insane given that null_blk isn't even built
> in the .config. I managed to get the testing automated now for a "git
> bisect run ...", so I'm restarting again to hopefully get a better
> answer. Normally the Oops happens in the first minute of running. I've
> set the timeout to 10 minutes for a "good" run...

Apparently, you do this on Linus' tree, right? If so, I won't compile it here 
then.

Thanks for taking care of this.

Regards,
  Oleksandr
