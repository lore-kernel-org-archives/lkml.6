Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeDTUXW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:23:22 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:44993 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeDTUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:23:19 -0400
X-Google-Smtp-Source: AIpwx49D1A0ZIpll8/ezyw0B/c29rQNoiJokU0RkNE105oS/v0JGU7x85oDUTdLQ/h6gYZfJrR923Gh/wNN5fxj/4b0=
MIME-Version: 1.0
In-Reply-To: <13DBFC76-4849-4DDA-AC44-B2C1257912E7@linaro.org>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5j+dh1zm32iBjRVh0s+3gLJYgjwt+z1aBJmrK2Cr8XPWnA@mail.gmail.com>
 <CAGXu5jLhnWnUiscP9B=kTEFNyRw9jgFn7Zr5FxhZrO20553+1Q@mail.gmail.com>
 <CAGXu5jKuZwicyyXH2gB3vp-OjtS+MkG+hqxV1cq1jaG9vAAO=g@mail.gmail.com>
 <CAGXu5jLQuzpjFcfjpT=MvgOxBizFNMjnfmY+E7eCHkDAV5swHg@mail.gmail.com>
 <CAGXu5jJTMqbXia7TmN2yEW11SM+XC3pkMt=bb+xBrY7-OOf=tw@mail.gmail.com>
 <CAGXu5j+xX3kDDS_sPY44hPVb=8isMX-evYzPx3ur=rge1rL5JQ@mail.gmail.com>
 <CAGXu5jJmvKcANUSsCz3fjGSv-tv1hceNd3rOpT4WTfYRb65RRA@mail.gmail.com>
 <8473f909-2123-0cfc-43b1-beba0b1aef9b@kernel.dk> <CAGXu5jL9miO3OXpjAxm9t8v=f_f5StB=Tk=aV8BVRdEj-Y-PDA@mail.gmail.com>
 <CAGXu5jKVPQi0cdTbe5Y1DNHdiJ6-kEFRBTNv7znuqT9w5eifGg@mail.gmail.com>
 <07f263ff-cea6-ac3c-944b-0f36fee8ba25@kernel.dk> <CAGXu5j+kHipvoyFWjGp8M6+83zbd6yHOzwxQ-2LNBQbD5-jS9w@mail.gmail.com>
 <8b32e079-d4e6-3fea-a89d-ff856e4e13b1@kernel.dk> <0fbf2b13-8bae-c7c5-d930-ebaafdc72202@kernel.dk>
 <011EF7D1-B095-4B8D-AD2A-993048932C49@linaro.org> <c30400f9-50e6-b5cf-d06b-a5e971e98546@kernel.dk>
 <13DBFC76-4849-4DDA-AC44-B2C1257912E7@linaro.org>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 20 Apr 2018 13:23:17 -0700
X-Google-Sender-Auth: cgl7n54rU4t0lYVck5Q7XFFQZ2k
Message-ID: <CAGXu5j+8WUgr1y=JYhCkUqUWE0SJ+ymkM9DPEQwY8UoqPmoPSw@mail.gmail.com>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 2:32 AM, Paolo Valente <paolo.valente@linaro.org> wrote:
> I'm missing something here.  When the request gets completed in the
> first place, the hook bfq_finish_requeue_request gets called, and that
> hook clears both ->elv.priv elements (as the request has a non-null
> elv.icq).  So, when bfq gets the same request again, those elements
> must be NULL.  What am I getting wrong?
>
> I have some more concern on this point, but I'll stick to this for the
> moment, to not create more confusion.

I don't know the "how", I only found the "what". :) If you want, grab
the reproducer VM linked to earlier in this thread; it'll hit the
problem within about 30 seconds of running the reproducer.

-Kees

-- 
Kees Cook
Pixel Security
