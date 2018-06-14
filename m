Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 72128C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C44208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgUnRBRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C44208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964851AbeFNQ5h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:57:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46986 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935116AbeFNQ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:57:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so3856841pld.13;
        Thu, 14 Jun 2018 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=91/6gktMjhUA/YhHsm3iJbEEH+CU6WOjU7EUMhzjCGQ=;
        b=rgUnRBRXPUdI00vmMQxBXgBXa2laqRDMwxa/dc9mBJ/OLD6pJ6N7n3e4hj6YnYFRE/
         4wmC6yrOSK/9jzE4Szo3ZLHBUKhUzkF3TQS1LXB8UWvwy4WuJOUtIzq66Efqanzr5ex7
         4XMtSEPxBYSowRacARGhc6UX7f164x7tVwkwqWNVzKJlopivq99iN46dP65KJ+a2SBS9
         Nie37Se5RSmVjgGnc7sUbBckxSXf3CB2Fj160rhy+9cgG2NfOmL60SxKMPL4Faugvvxj
         4zQY5q6+Xj9Q0BjXbxV5rUUW654bZ1EEMHUgxiTky4os5Jm5KBz24oow0t284OlRZSLS
         37lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=91/6gktMjhUA/YhHsm3iJbEEH+CU6WOjU7EUMhzjCGQ=;
        b=SrvmjTDNAtFfRD+7R+CI63GTj65SN8HrhiYGOurO214TVzvIpQ/3Bx20D9dRqlG5Bl
         5XSXxhMB1Nz38vZQAE0D0yhE52Zn/9maxf0JOLbipCWQ7KYrlIwyhcwpye7fWZBkNUX7
         k38M2synlmKFKnOwAoT4C4ZpejXpwf7BwiDPOLY9VcvqOXIpNuhnFE0Q/NDF1oW4jTST
         l0OFKGrbLGOGGciszuFAwXcLjgFUZxtOGppzVU5rmYT5R4T4QB694wc/qUQ8MiQo+XDY
         ReLtnbK7pIwdHby4PFN+DGWnBTi38up5ex9o5NVIwvCpYEfhxNLEhsicmU4Mr4qAnef8
         44ZA==
X-Gm-Message-State: APt69E29zXKgm39hFjgHuBnV39L8zMaNpU1OaerXsHZbGFsSqj0+Us4L
        k1CsX1pgvFifSvokSrK9EEmGEWeeW2XR5V1V02U=
X-Google-Smtp-Source: ADUXVKI2Hx6U46RdHqKHkuhEV3lad8Pdg6+lOqCVVBy/Kh1fGcXBWrsJSHEi+x6eA3lbZN19l3Xhu9qWWOAnV5rSP64=
X-Received: by 2002:a17:902:2983:: with SMTP id h3-v6mr3898673plb.232.1528995453421;
 Thu, 14 Jun 2018 09:57:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:284f:0:0:0:0 with HTTP; Thu, 14 Jun 2018 09:57:12
 -0700 (PDT)
In-Reply-To: <20180614070108.GD18426@mtr-leonro.mtl.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
 <20180614053446.GB18426@mtr-leonro.mtl.com> <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
 <20180614070108.GD18426@mtr-leonro.mtl.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 14 Jun 2018 09:57:12 -0700
Message-ID: <CAM_iQpUkAsNFSK4F7AtKsgtk91H4Wu3nBdeWjb2r60yWuO6Q3g@mail.gmail.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
To:     Leon Romanovsky <leon@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 12:01 AM, Leon Romanovsky <leon@kernel.org> wrote:
> On Wed, Jun 13, 2018 at 11:21:54PM -0700, Cong Wang wrote:
>> On Wed, Jun 13, 2018 at 10:34 PM, Leon Romanovsky <leon@kernel.org> wrote:
>> >
>> > Hi Cong,
>> >
>> > If the compiler optimizes the first line (mutex_lock) as you wrote,
>> > it will reuse "f" for the second line (mutex_unlock) too.
>>
>> Nope, check the assembly if you don't trust me, at least
>> my compiler always fetches ctx->file without this patch.
>>
>> I can show you the assembly code tomorrow (too late to
>> access my dev machine now).
>
> I trust you, so don't need to check it however wanted to emphasize
> that your solution is compiler specific and not universally true.

So are you saying even with my patch compiler could still re-fetch
ctx->file? I doubt...


>
>>
>>
>> >
>> > You need to ensure that ucma_modify_id() doesn't run in parallel to
>> > anything that uses "ctx->file" directly and indirectly.
>> >
>>
>> Talk is easy, show me the code. :) I knew there is probably
>> some other race with this code even after my patch, possibly with
>> ->close() for example, but for this specific unlock warning, this patch
>> is sufficient. I can't solve all the races in one patch.
>
> We do prefer complete solution once the problem is fully understood.
>

The unlock imbalance problem is fully understood and is clearly shown
in my changelog.

My patch never intends to solve any other problem except this one.


> It looks like you are one step away from final patch. It will be conversion
> of mutex to be rwlock and separating between read (almost in all places)
> and write (in ucma_migrate_id) paths.
>

Excuse me. How does this even solve the imbalance problem?

f = ctx->file;
                        ucma_lock_files(f, new_file); // write sem
                        ctx->file = new_file
                        ucma_lock_files(f, new_file); // write sem
down_read(&f->rw); // still the old file, nothing change
f = ctx->file; // new file
up_read(&f->rw); // still imbalance
