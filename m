Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeDTUlc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:41:32 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:30830 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeDTUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:41:29 -0400
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1524256894; a=rsa-sha256;
        cv=none;
        b=rPUIty3A75NIzfp2Iv+ws64G44wv1rdE0PDlhKy73lpE45EEJKnQF3KKlbOSFWUp5oLmJAUTGrOtSr/WSn032hyzDCJabMLv3TDMvu8KN4CM6RWAYWSgiWA7NFVcfJvAKX6/mhN8GTHNBAUSY1o219T/VRljpnKj/8TrA/2iZmY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1524256894;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hWjI3S9t3sYswaxbHZ4cifP/qZAdfjrGnsjwNCLR6w=;
        b=YHTJb2m05xfrO9aJOQyvVDc0DbLlD6aTOtyq1EQz8wH10GuU5SoZbyX+061ct+pNkSbQ+q
        +xWf2XRoTfVeAUXPzC8mGpAwmrMpr3PEPc3Rw4Zq04J/JBxwrMpgPP4/p2Vtd8Vr5IMony
        lD5zHmdgliqDpOTRekRGxyteEx8BS68=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 18D213416D7
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Apr 2018 22:41:33 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, keescook@google.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <CAGXu5j+8WUgr1y=JYhCkUqUWE0SJ+ymkM9DPEQwY8UoqPmoPSw@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5j+dh1zm32iBjRVh0s+3gLJYgjwt+z1aBJmrK2Cr8XPWnA@mail.gmail.com>
 <CAGXu5jLhnWnUiscP9B=kTEFNyRw9jgFn7Zr5FxhZrO20553+1Q@mail.gmail.com>
 <CAGXu5jKuZwicyyXH2gB3vp-OjtS+MkG+hqxV1cq1jaG9vAAO=g@mail.gmail.com>
 <CAGXu5jLQuzpjFcfjpT=MvgOxBizFNMjnfmY+E7eCHkDAV5swHg@mail.gmail.com>
 <CAGXu5jJTMqbXia7TmN2yEW11SM+XC3pkMt=bb+xBrY7-OOf=tw@mail.gmail.com>
 <CAGXu5j+xX3kDDS_sPY44hPVb=8isMX-evYzPx3ur=rge1rL5JQ@mail.gmail.com>
 <CAGXu5jJmvKcANUSsCz3fjGSv-tv1hceNd3rOpT4WTfYRb65RRA@mail.gmail.com>
 <8473f909-2123-0cfc-43b1-beba0b1aef9b@kernel.dk>
 <CAGXu5jL9miO3OXpjAxm9t8v=f_f5StB=Tk=aV8BVRdEj-Y-PDA@mail.gmail.com>
 <CAGXu5jKVPQi0cdTbe5Y1DNHdiJ6-kEFRBTNv7znuqT9w5eifGg@mail.gmail.com>
 <07f263ff-cea6-ac3c-944b-0f36fee8ba25@kernel.dk>
 <CAGXu5j+kHipvoyFWjGp8M6+83zbd6yHOzwxQ-2LNBQbD5-jS9w@mail.gmail.com>
 <8b32e079-d4e6-3fea-a89d-ff856e4e13b1@kernel.dk>
 <0fbf2b13-8bae-c7c5-d930-ebaafdc72202@kernel.dk>
 <011EF7D1-B095-4B8D-AD2A-993048932C49@linaro.org>
 <c30400f9-50e6-b5cf-d06b-a5e971e98546@kernel.dk>
 <13DBFC76-4849-4DDA-AC44-B2C1257912E7@linaro.org>
 <CAGXu5j+8WUgr1y=JYhCkUqUWE0SJ+ymkM9DPEQwY8UoqPmoPSw@mail.gmail.com>
Message-ID: <bd69860bb48eedc4908e055ff869c5a5@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 20.04.2018 22:23, Kees Cook wrote:
> I don't know the "how", I only found the "what". :) If you want, grab
> the reproducer VM linked to earlier in this thread; it'll hit the
> problem within about 30 seconds of running the reproducer.

Just to avoid a possible confusion I should note that I've removed the 
reproducer from my server, but I can re-upload it if needed.

-- 
   Oleksandr Natalenko (post-factum)
