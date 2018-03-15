Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeCOPqg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:46:36 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38697 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbeCOPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:46:34 -0400
X-Google-Smtp-Source: AG47ELv0Du2jsHmNtqh4pHboLXJSNsWp2xR7iXoqfv8nnzaxn9dt1mFFLTrWz+MCFUWT4aPx0G303oANbdmCHgxjNIw=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803150943130.1525@nanos.tec.linutronix.de>
References: <CAK8P3a1PGEk2WDQU8i7H64Cw4dmYaJ-6vPLzW_2o23PTgm74JA@mail.gmail.com>
 <20180314220452.3453973-1-arnd@arndb.de> <alpine.DEB.2.21.1803150943130.1525@nanos.tec.linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 16:46:32 +0100
X-Google-Sender-Auth: L9OPwTgs19C6tdYvfiXfTrriZ8c
Message-ID: <CAK8P3a3hXBZqubqehcTzn037aa-KVAeg82gY630oN3Btnkvdcw@mail.gmail.com>
Subject: Re: [PATCH] [v2] y2038: introduce struct __kernel_old_timeval
To: Thomas Gleixner <tglx@linutronix.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>, Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 9:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 14 Mar 2018, Arnd Bergmann wrote:
>>
>>  /*
>> + * legacy timeval structure, only embedded in structures that
>> + * traditionally used 'timeval' to pass time intervals (not absolute
>> + * times). Do not add new users. If user space fails to compile
>> + * here, this is probably because it is not y2038 safe and needs to
>> + * be changed to use another interface.
>> + */
>> +struct __kernel_old_timeval {
>> +     __kernel_long_t tv_sec;                 /* seconds */
>> +     __kernel_long_t tv_usec;                /* microseconds */
>
> Please don't use these horrible tail comments. If you want to document the
> obvious, then please use proper kernel doc.

I just removed them now, the only reason they were there is to keep
the style in sync with the rest of the file, but it's also just a lot of
duplication.

      Arnd
