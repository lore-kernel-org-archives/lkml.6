Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB54C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3EE20861
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjF+sFmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3EE20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lab.ntt.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeICGbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:31:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43364 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeICGbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:31:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6-v6so7889587plv.10;
        Sun, 02 Sep 2018 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:message-id:to:cc:subject:from:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSX+pTaCSyP3Wnp4IRwBcUSmlRinWn3ytHgI9N+Ydms=;
        b=hjF+sFmWU5pNhvMZYIbQPVHpaFpNua17D7Efl4p4ebp/GRr46sT0hWBKsciHWOsgLz
         /4sGd1k/LvMsgHr/PHoORay2WuBuB1mrgr1aClrJk69lQpWLlN7bFa9os/aOShk/0hA6
         Q+rsuQjd8g/eD1nHM/yHJ6doQi7Ez1+DTGyvviQobAJIoayoj133RAnyBFt89E9T07gx
         HnLKpaSpVybRW30S8J7/1uqSnPS4oKga+Y6JXU+HJz74sqOF7jOpo2UMnZojLobFtdUT
         C2Ymmf90ZYfjMMeUEfN381DHTFKrkfTjOq4QCKBwZnolMRFiKkXXIXAlE+wXwWz8qR2y
         GYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:to:cc:subject:from
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NSX+pTaCSyP3Wnp4IRwBcUSmlRinWn3ytHgI9N+Ydms=;
        b=IyMrON+9kDlxbVXnfrHkpCFVo74PiKyfH74xpROdu8AaBK0a8aTBAri4iLLMtEV4h2
         7HvvVKg1AN4XHmlyYfQ74Ts31xXfKA07M/FbRWuJMWu9B9T7TF5yeOThwibgEn7iJikX
         rJQGmQstXfZHe5lLB2nBPbIoAtYcSTWkELbeIbsbf2lr2vdNXU1sx/PNqGCk4oQEyody
         Nyi7Gi/rAwLKFClqx7grFFjFR+oYbi6EVZXc57YeihfZZyYOwskQF+AUnL/ALypdF1So
         4hdsu/giD9Ci+tNhwCq6KJo+BAebUVuyoxfVmlMZ5+egl2VXZ7FcgZS5xv7hHaE7GHgx
         oQGw==
X-Gm-Message-State: APzg51D9XhXuP/FEf1c4BZmQY9bJZgjYbx+/3iArr7iLbfql/SfxKOBj
        4jkM2NdnrFO5nmEnB0RZcfE=
X-Google-Smtp-Source: ANB0Vdbv1YhBIMZtw8wKCyfg6viDBK4ls7J9jAO7POvdNxvA3ngag6tzTprQy2ES5TB3Gxve8pxykA==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32-v6mr26494624plf.286.1535940797686;
        Sun, 02 Sep 2018 19:13:17 -0700 (PDT)
Received: from localhost (40.68.239.49.rev.vmobile.jp. [49.239.68.40])
        by smtp.gmail.com with ESMTPSA id q62-v6sm25478275pfi.185.2018.09.02.19.13.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Sep 2018 19:13:16 -0700 (PDT)
Date:   Mon, 03 Sep 2018 11:13:10 +0900 (JST)
Message-Id: <20180903.111310.853324894545237861.konishi.ryusuke@lab.ntt.co.jp>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        tytso@mit.edu, adilger.kernel@dilger.ca, axboe@kernel.dk,
        darrick.wong@oracle.com, ebiggers@google.com, pombredanne@nexb.com,
        agruenba@redhat.com, gregkh@linuxfoundation.org,
        kemi.wang@intel.com, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: Convert return type int to vm_fault_t
From:   Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
In-Reply-To: <20180830163352.5a96cc721ce069bed95fdbe8@linux-foundation.org>
References: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
        <20180830163352.5a96cc721ce069bed95fdbe8@linux-foundation.org>
X-Mailer: Mew version 6.6 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

On Thu, 30 Aug 2018 16:33:52 -0700, Andrew Morton wrote:
> On Thu, 30 Aug 2018 22:55:47 +0530 Souptick Joarder wrote:
> 
>> Return type for fault handlers  in ext4 and nilfs are
>> changed to use vm_fault_t.
>> 
>> Return type of block_page_mkwrite() is changed from
>> int to vm_fault_t. The function signature of
>> block_page_mkwrite() is changed to add one new parameter
>> int *err. This will provide a way for caller functions
>> to get error value along with return value and use it
>> further.
>> 
>> Return type of block_page_mkwrite_return() is also changed
>> to use new vm_fault_t type.
>> --- a/fs/nilfs2/file.c
>> +++ b/fs/nilfs2/file.c
>> @@ -51,13 +51,14 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>>  	return err;
>>  }
>>  
>> -static int nilfs_page_mkwrite(struct vm_fault *vmf)
>> +static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
> 
> nilfs_page_mkwrite() already has return type vm_fault_t in Linus's
> kernel, due to the now-merged
> fs-nilfs2-adding-new-return-type-vm_fault_t.patch.  Looks like a simple
> fix.

In the first patch in this thread, this return type change was
excluded correctly for nilfs_page_mkwrite() though the changelog was
inaccurate in that sense.

Please confirm your base point of the revised patch.

Regards,
Ryusuke Konishi


> 
> I'm beginning to feel vm_fault_t exhaustion.  Please remind me what
> benefit we're going to get out of all this churn?
> 
>> 
>> ...
>>
