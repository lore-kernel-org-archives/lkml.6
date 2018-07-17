Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A194D20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBPrtIy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A194D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeGQIKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:10:51 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37025 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeGQIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:10:51 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so276494oib.4;
        Tue, 17 Jul 2018 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=T5RPij0Y+VjP7XqC/RqfqK86H23P1Qncx4wyGvZuSlo=;
        b=aBPrtIy6uvadKueEe4hR/zHm1HWpN8diDW6/+1nqVqYZrg+tjCmlFVOpVt5w/iW5sa
         39v+sEqQhUs93CZ8NUOhnCliKX5QzfHNBIoKuukANnp4jrkWvNHJGHUqO+nzY7G2KTwh
         Od+8nzxelGl2t/C9LLpb6nYqBSqUVO71T1SXMXDT9SPfXGl220+SDmWP/EuqlYYysabG
         B1fPJyAserOmzC9Bz7YX3y5N/RWbW9tO9fhyW8qVkljy73QT3NOwOOtoSv0dOWnJUBvO
         TWsfKyhZxE84BqjxPvSmXN9k2FnsW5nhzNqYmlCCrIeK0jnfsjaMockcjdLvgmZFyE3H
         A9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=T5RPij0Y+VjP7XqC/RqfqK86H23P1Qncx4wyGvZuSlo=;
        b=IYrWPn5IIw1P7NXZFwBlLjZQ+HeBQ7SuN3imNGSl9SjpaE0VP1LWTogig8VcNnqy75
         rh+lLPLIUl6AKfJ2gmXuIvlqWRk7IsjrSBArrcHUakXN8Mx+gPibPfMNBW9LQ1PH6/dh
         CHmPAGaaVSfsaRXb0b/TdXVOkxjCFthkwSsI4kWW218hZ0rJBqcta1E5dbWb95K47IPY
         8foKx3FGXpLwtOCSKffoitwuDnhFug4dZAzerSitXYg+3kb5EcVNEeTT54d8S/iHKPoi
         FVQZJ47Oy3DuDfSyA7SDEMLlTGuFZGTw9N8Ms5TBurhcfE1kmP5jsvIDKTIZPmZ50/2D
         dXFA==
X-Gm-Message-State: AOUpUlG9gTeiz91FDnfABNFPBhkcOvyhfb6+YhhfZs+8Oq5ZAQqK9ERf
        DC8dl069rppwcHpWiVAR0xAY4XTDeayWnfNZBV4=
X-Google-Smtp-Source: AAOMgpc+xEOyU8OWC+Zh3FBuftvRK1nRRNrDZRVNIIt6yNAZ9lG8jfznd1pR1+JVlf6I95cYfFeTcVjrGK0Jtg7Hn+8=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr558319oie.174.1531813175184;
 Tue, 17 Jul 2018 00:39:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 00:39:34
 -0700 (PDT)
In-Reply-To: <20180717071641.GA5411@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com> <20180716235936.11268-2-lyude@redhat.com>
 <20180717071641.GA5411@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 09:39:34 +0200
X-Google-Sender-Auth: GGWNj5A62DmdL2oWoDJ94eL_5H4
Message-ID: <CAJZ5v0gq3mt=CcYQLkNLzqZub26QxSM8cajAgUzNWsO-z3PW9g@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback recursion
 in suspend/resume paths
To:     Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 9:16 AM, Lukas Wunner <lukas@wunner.de> wrote:
> [cc += linux-pm]
>
> Hi Lyude,
>
> First of all, thanks a lot for looking into this.
>
> On Mon, Jul 16, 2018 at 07:59:25PM -0400, Lyude Paul wrote:
>> In order to fix all of the spots that need to have runtime PM get/puts()
>> added, we need to ensure that it's possible for us to call
>> pm_runtime_get/put() in any context, regardless of how deep, since
>> almost all of the spots that are currently missing refs can potentially
>> get called in the runtime suspend/resume path. Otherwise, we'll try to
>> resume the GPU as we're trying to resume the GPU (and vice-versa) and
>> cause the kernel to deadlock.
>>
>> With this, it should be safe to call the pm runtime functions in any
>> context in nouveau with one condition: any point in the driver that
>> calls pm_runtime_get*() cannot hold any locks owned by nouveau that
>> would be acquired anywhere inside nouveau_pmops_runtime_resume().
>> This includes modesetting locks, i2c bus locks, etc.
> [snip]
>> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
>> @@ -835,6 +835,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>>               return -EBUSY;
>>       }
>>
>> +     dev->power.disable_depth++;

This is effectively equivalent to __pm_runtime_disable(dev, false)
except for the locking (which is necessary).

>> +
>
> I'm not sure if that variable is actually private to the PM core.
> Grepping through the tree I only find a single occurrence where it's
> accessed outside the PM core and that's in amdgpu.  So this looks
> a little fishy TBH.  It may make sense to cc such patches to linux-pm
> to get Rafael & other folks involved with the PM core to comment.

You are right, power.disable_depth is internal to the PM core.
Accessing it (and updating it in particular) directly from drivers is
not a good idea.

> Also, the disable_depth variable only exists if the kernel was
> compiled with CONFIG_PM enabled, but I can't find a "depends on PM"
> or something like that in nouveau's Kconfig.  Actually, if PM is
> not selected, all the nouveau_pmops_*() functions should be #ifdef'ed
> away, but oddly there's no #ifdef CONFIG_PM anywhere in nouveau_drm.c.
>
> Anywayn, if I understand the commit message correctly, you're hitting a
> pm_runtime_get_sync() in a code path that itself is called during a
> pm_runtime_get_sync().  Could you include stack traces in the commit
> message?  My gut feeling is that this patch masks a deeper issue,
> e.g. if the runtime_resume code path does in fact directly poll outputs,
> that would seem wrong.  Runtime resume should merely make the card
> accessible, i.e. reinstate power if necessary, put into PCI_D0,
> restore registers, etc.  Output polling should be scheduled
> asynchronously.

Right.

Thanks,
Rafael
