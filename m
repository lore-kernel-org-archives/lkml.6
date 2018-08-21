Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09046C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBB32147C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0mDhMce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBB32147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHVA5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:57:22 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43111 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVA5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:57:22 -0400
Received: by mail-qt0-f196.google.com with SMTP id f18-v6so22059992qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WqxfbKjEBaLL6fAjAohQg3BTd5TiG1XOL+M9/BzqUig=;
        b=c0mDhMcewZ7VGVAOsalJz5rHSZDqxrOu+EozcNJoeAhLMPbadczkXk3f1GUAC3Wvr7
         gNAummTWMHhb4iODIfYu9F8mzbq41gJ6FqJnakQe25IUa0UgueW2LuWDBO2XBmV7Dyuv
         c2VTpW67iGW3IDfkJCljQY1kCOhbV5fZmbMMRwjfLCjg8c73tf2GxzZYzpykKpSFPykd
         8eeWV3t2hT/jeI0Zqswwa6uTSJXPvL1hg/UHJs8ksbLKuALk7B0zr6wu63d27D5VTuBj
         IgfIS45Nho4+aKoEcj/yge5myYhl8LRb9ObNDBrsJC5Gybr+DK2hU/s6auUZN8HNbBM3
         p9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WqxfbKjEBaLL6fAjAohQg3BTd5TiG1XOL+M9/BzqUig=;
        b=TKxig0UperLpo6TA+3Btn3x3B1zHfQiBJ/gzc1FFLu0SrcH9GyCsqgAWxl7FU8ylyt
         /QtO1tCPqCz8L9GJbTrG4V3jL++xqLtd/szqwV1SwgFa/YKAsJ81nz0V46PpUbJi2scY
         ChugqyD1+odCpIzJvy/+0IRAI3PTdi/n3t0QqdThlBfTTcFIXwTqGerku9RIZXn5J6+Z
         tHijZRyBcof6mBCkuzDIG0gtjjVRI1qc9W0JXKPX4gBmJWQW6zqawgC73IfObfCyO3D8
         42e40h4fHSIszxziA4iRe0pan6gCPI/L+6FT0FctNTAckF3674Cpg9v74BGC1YQpcpQx
         +gyg==
X-Gm-Message-State: AOUpUlFXezK1Teqoos5IqObpIdXe6rtN6j7xbzUR+RfCcp+uJWsgrJ9L
        Pd8jNFtLjFnRTrw3UllisStmhLPXBIyp5SSJu3w=
X-Google-Smtp-Source: AA+uWPx3eGkkorwWKlitGv3fsYWpdik4xBSnuQUChlDZZjGaxBHgUAotryU2QvMkvw2iRoDbnV3ZJkKZfwN0xfCRx00=
X-Received: by 2002:ac8:84a:: with SMTP id x10-v6mr50530692qth.90.1534887329837;
 Tue, 21 Aug 2018 14:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 14:35:29
 -0700 (PDT)
In-Reply-To: <CAPhsuW4QbT+0wHYW-A7G8z-Xp=8M+0w1Efmc1006PbqNTfOSxg@mail.gmail.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-3-ravi.bangoria@linux.ibm.com> <CAPhsuW4QbT+0wHYW-A7G8z-Xp=8M+0w1Efmc1006PbqNTfOSxg@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 21 Aug 2018 14:35:29 -0700
Message-ID: <CAPhsuW5DBOuYjYsUyWRZimeRKJhmA=RNM-rpcRhsfXwWfVG6qw@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 10:54 PM, Song Liu <liu.song.a23@gmail.com> wrote:
> On Sun, Aug 19, 2018 at 9:42 PM, Ravi Bangoria
> <ravi.bangoria@linux.ibm.com> wrote:
>> We assume to have only one reference counter for one uprobe.
>> Don't allow user to register multiple uprobes having same
>> inode+offset but different reference counter.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>
> Reviewed-by: Song Liu <songliubraving@fb.com>

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

>
>> ---
>>  kernel/events/uprobes.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 35065febcb6c..ecee371a59c7 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -679,6 +679,16 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>>         return u;
>>  }
>>
>> +static void
>> +ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
>> +{
>> +       pr_warn("ref_ctr_offset mismatch. inode: 0x%lx offset: 0x%llx "
>> +               "ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
>> +               uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
>> +               (unsigned long long) cur_uprobe->ref_ctr_offset,
>> +               (unsigned long long) uprobe->ref_ctr_offset);
>> +}
>> +
>>  static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>>                                    loff_t ref_ctr_offset)
>>  {
>> @@ -698,6 +708,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>>         cur_uprobe = insert_uprobe(uprobe);
>>         /* a uprobe exists for this inode:offset combination */
>>         if (cur_uprobe) {
>> +               if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
>> +                       ref_ctr_mismatch_warn(cur_uprobe, uprobe);
>> +                       put_uprobe(cur_uprobe);
>> +                       kfree(uprobe);
>> +                       return ERR_PTR(-EINVAL);
>> +               }
>>                 kfree(uprobe);
>>                 uprobe = cur_uprobe;
>>         }
>> @@ -1112,6 +1128,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>>         uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>>         if (!uprobe)
>>                 return -ENOMEM;
>> +       if (IS_ERR(uprobe))
>> +               return PTR_ERR(uprobe);
>> +
>>         /*
>>          * We can race with uprobe_unregister()->delete_uprobe().
>>          * Check uprobe_is_active() and retry if it is false.
>> --
>> 2.14.4
>>
