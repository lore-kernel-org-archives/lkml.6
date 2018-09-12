Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1058C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DAD20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVe6mqDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DAD20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeILOev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:34:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35931 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeILOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:34:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id v26-v6so1028093ljj.3;
        Wed, 12 Sep 2018 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KLB3khADlyP1siS2rz9dz4kgqScpnDvvcUx3pFZNCek=;
        b=eVe6mqDArrNAYHZ+4gLmgv/h9SZ7bzh0TPf90cw09+dgqpS3r082BoN4I7tERtiP/Z
         0TpdvB3hP48nvdw0ehYC+KL4cOI3MIwj3oM0liJDuwhjZIVSAQ8Xu74rC8ouA9REDYGH
         NOlMazMuEUWh7t1Fh7X/ofJcEFKGseZBsayhwoa32AhrhD3CryQVbba12i9STXktIbGr
         9IXJkoG/CJBOCIl7GCqFld2/jbll5dU6F7Z3RZzmmo9kHkT8IWlI4Jp7XGweq6fNtid3
         Mvb+Ojp6UP/fz+7OCUbWG0SjehBxnMTpCh/bd36z26OFqKuCHOA7kX7nHCdJOYapjqdH
         lB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KLB3khADlyP1siS2rz9dz4kgqScpnDvvcUx3pFZNCek=;
        b=pERSu7WWq3yAnMPxkVKzCa24YIrRG7bfJfBPP8xoXuV2BYsXpXf1wmuiEsvCIR6AkP
         KipL8PSGQb14tuafOeBpIia7cy0dvIPWiCyiIOIPOOK9zB7UAkrV4NCb3A5b2BKl2Oi7
         G6T72IOzCFI8kn/IywnGeSt8kk+0oMXscPeFDDtflBKQ9t9mLgpjK9Mc9Vg8C3cYecD6
         pqRKVRokCoGrYFdmuvGb/1c2JKtMByseYES3y/lnHH4lBb8e9ILgAeWWtCCQ+JhR1otm
         PI033uue2mix+yCL8I/OTGYmmBFw4LYax3PavXrNjPzaYUFkWgKvhcCXhSAsWtZqgU1Z
         kD0w==
X-Gm-Message-State: APzg51ACFjra9QUY9sI1tLBQ5kd9in23Z/8MGnVSTPNm6k54dxd2D/g1
        g5AoYL8hD1U2tKJI4YeQVTg=
X-Google-Smtp-Source: ANB0Vda4+4CcJ4KNwde29j80zmZ6w6J75R5VB46J5bWbqvsR/Kt7aWCNNrMPZ2+s1xNMcZHQfMyRig==
X-Received: by 2002:a2e:934d:: with SMTP id m13-v6mr718939ljh.45.1536744667205;
        Wed, 12 Sep 2018 02:31:07 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t18-v6sm88851lje.95.2018.09.12.02.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 02:31:06 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g01US-0002Sd-6n; Wed, 12 Sep 2018 11:31:16 +0200
Date:   Wed, 12 Sep 2018 11:31:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] tty_port: Fix function name and brief desc
Message-ID: <20180912093116.GC1089@localhost>
References: <20180912075044.8695-1-me@tobin.cc>
 <20180912075044.8695-3-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912075044.8695-3-me@tobin.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:50:43PM +1000, Tobin C. Harding wrote:
> File contains kernel-doc function comments that are not in the correct
> style.
> 
>  - Add '()' to function names
>  - Capitalise brief description and append a full stop.

Cleaning up these comments may not be a bad idea, but I have my doubts
about this particular item. Many descriptions aren't full sentences and
still won't be even if you capitalise and slap a full stop there, for
example:

> - *	tty_port_hangup		-	hangup helper
> + * tty_port_hangup() - Hangup helper.
	
There's no requirement to use full sentences, and the old kernel-doc
nano doc uses incomplete ones, as do most (?) kernel-doc comments
throughout the kernel.

I'd just drop this part of the patch. 

>  - Use correct spacing for function name / brief description as per the
>    kernel docs (Documentation/doc-guide/kernel-doc.rst)
> 
> 	/**
> 	 * function_name() - Brief description of function.
> 	 * @arg1: Describe the first argument.
> 
>  - Fix spacing for kernel-doc function comments (no tab space after '*').
> 
> These changes all touch the same lines so do them in a single patch.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Thanks,
Johan
