Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KlpxOtKrGVs9MgAAmS7hNA
	; Thu, 07 Jun 2018 22:04:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D4C0F6063F; Thu,  7 Jun 2018 22:04:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3XFwavH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 635D360452;
	Thu,  7 Jun 2018 22:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 635D360452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeFGWEA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:04:00 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35938 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeFGWD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:03:58 -0400
Received: by mail-ot0-f196.google.com with SMTP id c15-v6so3538532otl.3;
        Thu, 07 Jun 2018 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LHwiXGTDOH7nVeZGDgYlZpmSyJin1x2ftVwUJU2VzVg=;
        b=q3XFwavHeM6SJYSXvPL3UHVuY97vTLNFEMRNEV0sXVs6ENomnjGxEHgYOgWltnmqbK
         dC/pxq/OVUu9Q9wTei3ywAxVeODQE0Pt9a22e3Jr4LpRnpd2bcfdV8uxrdlsXrzVYKcR
         7q3+KiRQu3cQSFhdK6OJvQE/MEN3RJw85prAE9x7MSautljg0iYpaQuc0oSokSvRT1f4
         1IqAkxGBm7iiAsfZvUTUWRvTrIs2mDUGzyP/8WfszIy3MY8zkheLqeCb8hUznq9KtAiz
         y+3uHg9E/qltXf0OwdNVEf031a6levHt19ESImzJCA4/U9xrWmvuJD/o1xXhwohhBShi
         RcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LHwiXGTDOH7nVeZGDgYlZpmSyJin1x2ftVwUJU2VzVg=;
        b=BAx3wzmio49/CfrnNvB0TeCZteIX1S0CqzmG/9V+b6QUwn7cALiUKsmcF945b7yqoU
         J6hjHd6XGjastEXnc2nFYc8qhuCFMnXp9wpTr9zMLreN0HV6hQYJC36R7xeGvNY7hEw7
         jGLnkwUej8WL/7k9MCaIf1Ls41nHmk3e4J8jWuoZnZ3oiq3lbiWk6QxlXI/S5jXxyoOm
         IB0Jqpx4qoUqFyVpfXOOF2ixgtm9tjmkFXlRZTyhuogxzL0pQBpqSLurqy5C/OqV8R2C
         3oIZr7lLNbEzWSgAXVMQg9lWjFHwVuWtlHD59MqyDcEhowb7lvAC7Yp92CejG8G5xjIE
         XIiQ==
X-Gm-Message-State: APt69E1fwe2tM/dKuz9bem9P1dVm1RZ5tSPnL24+9c2/tY1TcYrRRBr+
        +7Yy/ZF//52w3ySq4VMM/ajfcTyQVa1jvAcAG/k=
X-Google-Smtp-Source: ADUXVKJfeU5EuGLm/7AfID5ohBIuBJWshdSAf43jy7EKKHvmZsmEOuUHlAU8Q8Zp231QnH3YZ1GrKrb/15Xn4ycBJYM=
X-Received: by 2002:a9d:322f:: with SMTP id t47-v6mr2314232otc.7.1528409037712;
 Thu, 07 Jun 2018 15:03:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 15:03:56 -0700 (PDT)
In-Reply-To: <CALCETrVRH8LeYoo7V1VBPqg4WS0Enxtizt=T7dPvgoeWfJrdzA@mail.gmail.com>
References: <20180607143855.3681-1-yu-cheng.yu@intel.com> <20180607143855.3681-6-yu-cheng.yu@intel.com>
 <CALCETrVRH8LeYoo7V1VBPqg4WS0Enxtizt=T7dPvgoeWfJrdzA@mail.gmail.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Thu, 7 Jun 2018 15:03:56 -0700
Message-ID: <CAMe9rOp9YtNnTzsDPFXukK6ps7VNa2MU6o0GwnoES5Ma_AC65A@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86: Insert endbr32/endbr64 to vDSO
To: Andy Lutomirski <luto@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 1:50 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Jun 7, 2018 at 7:42 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> From: "H.J. Lu" <hjl.tools@gmail.com>
>>
>> When Intel indirect branch tracking is enabled, functions in vDSO which
>> may be called indirectly should have endbr32 or endbr64 as the first
>> instruction.  We try to compile vDSO with -fcf-protection=branch -mibt
>> if possible.  Otherwise, we insert endbr32 or endbr64 by hand to assembly
>> codes generated by the compiler.
>
> Wow, that's... a genuine abomination.  Do we really need to support
> CET on kernels built with old toolchains?
>

Yes.  GCC 7 should be able to build CET kernel.


-- 
H.J.
