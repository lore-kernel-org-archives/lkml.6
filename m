Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A7ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC202150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uk6W5kA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC202150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeJQXkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:40:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34940 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeJQXkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:40:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id 22-v6so21470998oiz.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M2Gp6gH80q43/tis0ptqhRINfH7JLOnQD2dCmFrdWQI=;
        b=uk6W5kA3p3oUFI/6kzMIVNAJOh/JDlNUk8R0N7krrq2PfgQH+osftkDMWsZXg02vGw
         sMNUa/II4hRzZpraf8rd10+7x6GJOJogDSh8RyvhgS+qHKnVWNu1bjWYDOL1eFuotS6O
         uippIMMD+0Pedk1Y4lFbezZs/kY6CfkVPVzIQA5blHOSqATxuOmRURUPBYjz23oGjGGa
         f1Lg8RmFcVU+ZOcy01MvkI6yHypUKKBvsFv/xeiqLHkSHkGccK/piDo6EtzefNsot76z
         JrgyaAkbxc3p8z43+Oa36A8OLKDJVK2Q50ToF7qOE3HOim0ffVfYDTY7sDxff8QW8W3+
         90Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M2Gp6gH80q43/tis0ptqhRINfH7JLOnQD2dCmFrdWQI=;
        b=muFadE4cp/J3n1KsiGrXMcoq44/itq+FedtAKAH+9Mt0d3Ycd/c/jHbi/M/SC5dkYQ
         OMpNuZTbb8F68diGgiTg1oNlmFiy6bg+NOHvhzR0JqmyX+gNGE59vCmiE833TxkbDBha
         Vu99+H6X/FzMzkxeOBzI9oxJSfVgLLnpe/9XdD7hYl1579PybtjmjpB9/sohDwdQg+rI
         jduNtmSFeqLh18jUNcGa+4OSdR7hjl9Y+9MWpHs/snpawZb8t7fk9psV/7FrHeH8dGxV
         zUSBNFVCjGkLWdNEs1pF1/erb54XN+uqwbouybZRk7LGjfziXVkSfkl9Qu7yEsAmUnK0
         9ggw==
X-Gm-Message-State: ABuFfojdQTAxejQkJQs6muUWFbXp3c/UTdri0G2p7QzNMaPoQp7kzQLm
        E3RwivOBfynb5oU7Ge9d8KFj/PYDKqi9Uu39BEVRZw==
X-Google-Smtp-Source: ACcGV61MsUqWv2ejYRihgJn2u0rzwYtAkhtFUZAY1bKL3vrQcLOcrF9ngRbtek/EebFgj/zAnLGcJcCLVc3Uj3130aM=
X-Received: by 2002:aca:d451:: with SMTP id l78-v6mr15236818oig.52.1539791041764;
 Wed, 17 Oct 2018 08:44:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:56d8:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 08:44:01
 -0700 (PDT)
In-Reply-To: <20181017120829.GA19731@infradead.org>
References: <20181009222042.9781-1-joel@joelfernandes.org> <20181017095155.GA354@infradead.org>
 <20181017103958.GB230639@joelaf.mtv.corp.google.com> <20181017120829.GA19731@infradead.org>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 17 Oct 2018 08:44:01 -0700
Message-ID: <CAKOZuesr_8vrob-XfEpGmyeKFEhWWXZo4BEC0PixfjT2ibaRZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Add an F_SEAL_FS_WRITE seal to memfd
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 5:08 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Oct 17, 2018 at 03:39:58AM -0700, Joel Fernandes wrote:
>> > > This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
>> > > To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
>> > > prevents any future mmap and write syscalls from succeeding while
>> > > keeping the existing mmap active. The following program shows the seal
>> > > working in action:
>> >
>> > Where does the FS come from?  I'd rather expect this to be implemented
>> > as a 'force' style flag that applies the seal even if the otherwise
>> > required precondition is not met.
>>
>> The "FS" was meant to convey that the seal is preventing writes at the VFS
>> layer itself, for example vfs_write checks FMODE_WRITE and does not proceed,
>> it instead returns an error if the flag is not set. I could not find a better
>> name for it, I could call it F_SEAL_VFS_WRITE if you prefer?
>
> I don't think there is anything VFS or FS about that - at best that
> is an implementation detail.
>
> Either do something like the force flag I suggested in the last mail,
> or give it a name that matches the intention, e.g F_SEAL_FUTURE_WRITE.

+1

>> > This seems to lack any synchronization for f_mode.
>>
>> The f_mode is set when the struct file is first created and then memfd sets
>> additional flags in memfd_create. Then later we are changing it here at the
>> time of setting the seal. I donot see any possiblity of a race since it is
>> impossible to set the seal before memfd_create returns. Could you provide
>> more details about what kind of synchronization is needed and what is the
>> race condition scenario you were thinking off?
>
> Even if no one changes these specific flags we still need a lock due
> to rmw cycles on the field.  For example fadvise can set or clear
> FMODE_RANDOM.  It seems to use file->f_lock for synchronization.

Compare-and-exchange will suffice, right?
