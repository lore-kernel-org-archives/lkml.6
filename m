Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA7FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3DA20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzIcoe0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3DA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeJBNhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:37:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52364 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJBNhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:37:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so1025118wmw.2;
        Mon, 01 Oct 2018 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NsudmGgl9KkY4yvHI4pOMwykhxIfBPcwuEQH6q+dJUM=;
        b=kzIcoe0ZU8tpQQQZswjGlsPlRbatyWpUpLjTx8xvv5q6VQ7l/NueSD7wqcMTdrZYV/
         ykdIiDQHK2oPzN7mj96DVD3q6rhrH3o5gy3Pqb31LeLVPsHjHBYHDPIksgO4ahdRFvUy
         BRQTAqN6QrplDtdiMZE2DgEkSd4fq0h8jVpDjAJ+WBvd/ZLQ1BwZmoTIHjY9NGs7riBH
         pnocz3YRlI4MgVNV9VgIMMjmWgzVfzBZJayXEHOHb9KSS1bivKw/0q4zqKMEkENVSH/w
         xpndllLO7KSfXGiDM6gW1A2n5U3flNYA6TpfdqRy8t2wfDpA5k7sYbvcyjxJe4jrVMtP
         PyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NsudmGgl9KkY4yvHI4pOMwykhxIfBPcwuEQH6q+dJUM=;
        b=jBkBF6tr7ukuzaR8Y+IFYfAxBHlWrmiobmWpi7A3XgI4mFoZltrYR0tSay5dFH+EgD
         Vv6GbHnLtkJLW8mt63EdpVEjuZRaA56KAma1IgzK+vwNKSL5xKj/65P3ggLSFdn+V2JM
         aZ7Rc+nB3UDPTS87fck/8pk/pfF6gx8ZhfBqBObnLHQ6VovZkkLmSoMWX42XT0inoaLY
         psDFQGbWxlyg0+sNv8fO7oPWrMNTlR8vQ3XNDb5KH6x8fbxMJ1hQT1qGEv2y3UeoUht4
         yrPhqWJJaZQedkjcOhmu5pTJMH1fXAvZ/8+8jMz19uGisYQNjKESnIJJDodikS88JlGW
         yuXQ==
X-Gm-Message-State: ABuFfojfDze8ecwHCAGGLGtBH8L5MzbsOicUkBrM7jdfTK8ogt2pwB5r
        HeXkosk5gj1QVLn5XF48UzM=
X-Google-Smtp-Source: ACcGV62WXX1NEv/AoWPjNwNnq/iRDseh6VyGeot1mtO/Ouv9/Wb4shrfMNF91NB2OkvrFhY9CKuT8w==
X-Received: by 2002:a1c:1a88:: with SMTP id a130-v6mr869197wma.142.1538463324134;
        Mon, 01 Oct 2018 23:55:24 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id m12sm7932286wrx.75.2018.10.01.23.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 23:55:23 -0700 (PDT)
Date:   Mon, 1 Oct 2018 23:55:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Boaz Harrosh <ooo@electrozaur.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
Message-ID: <20181002065522.GA27010@flashbox>
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b12992-3570-4646-374b-82cbd7276839@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 06:16:32PM -0700, Bart Van Assche wrote:
> On 9/30/18 1:54 PM, Nathan Chancellor wrote:
> > diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
> > index 48e8a165e136..6b6fdcafa6cc 100644
> > --- a/include/scsi/osd_types.h
> > +++ b/include/scsi/osd_types.h
> > @@ -28,7 +28,7 @@ struct osd_obj_id {
> >   	osd_id id;
> >   };
> > -static const struct __weak osd_obj_id osd_root_object = {0, 0};
> > +static const struct osd_obj_id osd_root_object = {0, 0};
> 

Hi Bart,

> Structure definitions should occur in .c files instead of in header files
> especially if the header file is included from multiple source files. Please
> consider moving the definition of osd_root_object into a .c file.
> Additionally, zero initializers should be left out to minimize the size of
> object files.
> 

I'm perfectly happy to make this change in a v2 if necessary.

> Boaz, the most recent osd patch that is neither trivial nor treewide
> refactoring is six years old (51976a8c85ce ("[SCSI] osd_uld: Add osdname &
> systemid sysfs at scsi_osd class"). That suggests that nobody is using this
> driver anymore. Can this driver be removed from the kernel tree?
> 

However, this is certainly a better option if possible.

> Thanks,
> 
> Bart.

Thanks for the comments!
Nathan
