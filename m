Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id skDYCtI9HlsiTwAAmS7hNA
	; Mon, 11 Jun 2018 09:16:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 95DB460792; Mon, 11 Jun 2018 09:16:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cCtjfrnK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CF0E6600D0;
	Mon, 11 Jun 2018 09:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF0E6600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbeFKJQA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:16:00 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38604 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbeFKJP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:15:56 -0400
Received: by mail-oi0-f66.google.com with SMTP id d5-v6so17233680oib.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f0GG80AfT0/C/udW73VTn9TtgNFFvRIKIDcV48HAF4w=;
        b=cCtjfrnKB37EZOXSmMYORhmHfh80asSXpaLMfhn3SGI5llqh/XuJCY7Vn9gR4JC+Cb
         jznLrJyV71zfUpCrAYxQmM16j24cHorzyEMq9bORZ3qg+2CbgGyB5yjUDO5wda1BK5b4
         K+VqiSDW9Ffj6Lk1+ETPegskBG3KLyHRVHR5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f0GG80AfT0/C/udW73VTn9TtgNFFvRIKIDcV48HAF4w=;
        b=j/qBUjY0EpaV3GAgw8eQPjjBCvJ1lgkrOmIAGLNrHjDEgx9j3ZziLIWaSh5tIRsSYu
         ygraH1+vegC5PeuSVjTxstwJMvmfsaa45ej1QhyWzrQg/EenPEYFPsznXD7OBZ2SJAlg
         unOFTCUnDcnjPOxDr+Dhj4UJG1AgcLGJay8nRqu8KaJoHZHpyoAPbnE7Xi2GzBreTnar
         BnW5zYLk9GwbL0oLeKyRNPFVFetf/FEl5JT0XFiHSlT53rHNm/jXZoM2ETB5t3VZtV2g
         PZ0uKdqSXEP9KrUHkieq2ECLqiXvdFZT6Dat0MULyjgWiwuZzQGiUgtQIzb4TLL6puqp
         PHGg==
X-Gm-Message-State: APt69E3RZwJjgYViHpSAbOonhEzDwqmYTUIuIIt16G0iZKPcXNPuNJ5p
        iYocJHmR+MhwFOnh9HMFyF82yjKNZljrmfRFzwEmjQ==
X-Google-Smtp-Source: ADUXVKIePq6NWegzyYRr5hBysCIwR/HQqDWkMjekkZhLEkuIh0Txo35omIDs6AVBy2wRrI1aLPKfyeAFRTDMMR+VukM=
X-Received: by 2002:aca:5c46:: with SMTP id q67-v6mr3196433oib.17.1528708555982;
 Mon, 11 Jun 2018 02:15:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 02:15:55
 -0700 (PDT)
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180610060159.GS30522@ZenIV.linux.org.uk>
References: <20180529144143.16378-1-mszeredi@redhat.com> <20180529144143.16378-10-mszeredi@redhat.com>
 <20180610054902.GQ30522@ZenIV.linux.org.uk> <20180610060159.GS30522@ZenIV.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Jun 2018 11:15:55 +0200
Message-ID: <CAJfpegt5guR3zJeATw4-N41Ad2n9pcB5mQoLmSLOfocnEoodVg@mail.gmail.com>
Subject: Re: [PATCH 09/11] vfs: factor out inode_insert5()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 8:02 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, Jun 10, 2018 at 06:49:10AM +0100, Al Viro wrote:
>> On Tue, May 29, 2018 at 04:41:41PM +0200, Miklos Szeredi wrote:
>> > From: Miklos Szeredi <miklos@szeredi.hu>
>> >
>> > Split out common helper for race free insertion of an already allocated
>> > inode into the cache.  Use this from iget5_locked() and
>> > insert_inode_locked4().  Make iget5_locked() use new_inode()/iput() instead
>> > of alloc_inode()/destroy_inode() directly.
>>
>> ... thus hitting the sucker with ->evict_inode(), in condition that is quite
>> likely to be unfit to be seen by that.
>>
>> NAK.
>
> To clarify: objection here is against the switch to new_inode/iput.  The rest is
> sane.  What makes new_inode() better here, anyway?

Umm, got to look into this.  The patch has already been pulled by
Linus, but I hope it's salvageable.

Thanks,
Miklos
