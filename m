Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7627C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A2921829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9l1hy+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A2921829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbeHMTKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:10:32 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39951 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:10:32 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so18000868qtj.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uC8monHxjKqVjpXWcdlPRgoEs2V7pkwvVylPOwryAYM=;
        b=S9l1hy+Z2e5Q2m4c7sfs/sMuJNbg3zVC02Hn/cikLvB5p0ukrrI2lXVhM/vNaoE0hC
         Cm5veF2CpnFpSWrb7Db5Qh0Cec3NAdz0Q21unE+eIkwSnTHDKuN69R0rWvq40dDKm5is
         85oYpaJJDFdny/gmUYb+FUjmQRdXTe6XrwaLiY9M5Kr2X6wP15vIfNTk+e+AVkEcTX/0
         OR4YFQ9TXeYR6/tRZ8cFtSxQFq4oITJntTHiJ9GyJtp+ZjG95dfPgOvWPNu2yNxA5W53
         qkwlsgWdPAux9pH4JcehFM7p/GH2rHYeBHr+PGpVzs8thAxLjyUrIePJK6N0RvkU2pTq
         IMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uC8monHxjKqVjpXWcdlPRgoEs2V7pkwvVylPOwryAYM=;
        b=pIiuMQuT7Voi5sQns/HDNVq35QPPu3k4dPR4OSuc7qcbQ8zYETh81c1TN3wT4S61VO
         aZMbAQ+kSir2SVpe5eNgTmRdtMQOTIe4tBkWCMK+Wmd8xUEtw2oC/x5KcHZtE+JQG2Dn
         T8BaLrn2g8+0hpujpDm2D9P4adRUY0mQUHNVzCCU/qw5wdQxyc+bUhM2nJSgJTN8iJlw
         EZA6WaIbtaGRP1YjbaX05WIvZuwD5nHG6al3RGq6dYHEjjfTs2mmaftVgVHHwtM8GESs
         PigXK9kPmAkOwoUaSUG82kYsktNBomvbSkAIE2mGei5ZDLgMAyqrortVbRXCWnAg+dK4
         ikbQ==
X-Gm-Message-State: AOUpUlEsYuJ5wmvuA1IKcM8IMwsSRS5Ghr480l/M+QV6AM6dLElRJFKk
        0EBbRM4hRWplw0k3/5nlTYNWxzAAvqdm6LiRYq4=
X-Google-Smtp-Source: AA+uWPynQU823Uc7kPp0ZqGRtEa3NhsmMyN6W4urnaKAHvdBPdlAeg4bfEkpUru3kudcrNhCnAsLZHtBmn/FEsLfGac=
X-Received: by 2002:aed:3688:: with SMTP id f8-v6mr17954184qtb.276.1534177656589;
 Mon, 13 Aug 2018 09:27:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 09:27:36
 -0700 (PDT)
In-Reply-To: <20180813084922.GB44470@linux.vnet.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-6-ravi.bangoria@linux.ibm.com> <CAPhsuW5g1dOnceA=kqfpC+rR6EguJaR+wPwY9nSWLbGSSj5XjQ@mail.gmail.com>
 <66f84261-aa3e-4692-a124-09537fda4312@linux.ibm.com> <20180813084922.GB44470@linux.vnet.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 13 Aug 2018 09:27:36 -0700
Message-ID: <CAPhsuW4Vo0Py9EmiAx64v1ExwH49NuPaXYWr9Hmm6mLFewbHog@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] trace_uprobe/sdt: Prevent multiple reference
 counter for same uprobe
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
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

On Mon, Aug 13, 2018 at 1:49 AM, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-13 13:49:44]:
>
>> Hi Song,
>>
>> On 08/11/2018 01:42 PM, Song Liu wrote:
>> > Do we really need this given we already have PATCH 4/6?
>> > uprobe_regsiter() can be called
>> > out of trace_uprobe, this patch won't catch all conflicts anyway.
>>
>> Right but it, at least, catch all conflicts happening via trace_uprobe.
>>
>> I don't mind in removing this patch but I would like to get an opinion of
>> Oleg/Srikar/Steven/Masami.
>>
>
> I would suggest to keep it, atleast it can ctah conflicts happening via
> trace_uprobe.
>

Yeah, that makes sense.

Reviewed-by: Song Liu <songliubraving@fb.com>
