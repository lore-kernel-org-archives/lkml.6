Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELv9y2ZiZMzZGUQSJ9Q0uym/eCvl4PwKDH5iQLS0DfJTvvl7d+Y3PwpAkcDYML/gU3ZUu0yb
ARC-Seal: i=1; a=rsa-sha256; t=1520261038; cv=none;
        d=google.com; s=arc-20160816;
        b=0BKcrYrXDoq4tNrRqHKkXaXHZ1IiYdQkMCFWKD3pULLTm6cw0Q36nZTLLRDJ2nWflj
         OppWYDOALvJDC/C0eTAnS5LqGknaT97DsM9H6NGus25WjYgMsiH5VCsUvg0oohYsyI8M
         ClZMOYEq8AmsVHIYiOuvHg33IlzxnPAwhd/OtTKNrcUp7yy8iFYZ7RYRYX4+sPO5o460
         Kcv1TXC+tiNPruBnNyBvoKK4yOa4jnTgYq2Uqna42pQzkW0rFz9dQS8EmZHSjiMvIihp
         4Aesy2GTxRd/n33gK5T5AiCmeUlv4X81xDko4dp8CMdv3cz59oIFa5c3Wk8v6xpB7WEE
         Nfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=la+HdAC2enIU2MvQi+FayoGan2W9o/coAiFMnagrwNk=;
        b=Td8Bvir7axRDfz0ILqOqXEivKaqlLUuyl0cm1lMcJQH5aKrGpyKYjblk9RZG80RYVz
         XztQnFlJNCAcoveR/IOuIg0ynI859gTPHNXg1bsUHEviWEFSdCfPFTwnR2Ny1hso6bCO
         EPnWkSaLDNXHbdx6/utjlTipU85DHb5DJvYNGdodOn8+wk7eluh+jaXIDks9z/mBkNCF
         YAMsyMikvCIgZokEMhbZvm+g9TPWz/IRJGn7lKWSIeY1DkMIQ/PCM7aDkhTbfAZhLHjI
         +rNyuK59SoYg3N2PU/ZhvukVeW87F9jRGhAlOFN7p9z20C9vwFOT2n5jQPFqgl7+3vty
         +nUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 ALKML <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
 Alexey Klimov <klimov.linux@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 13/20] firmware: arm_scmi: refactor in preparation to
 support per-protocol channels
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-14-git-send-email-sudeep.holla@arm.com>
 <20180305153549.00000f39@huawei.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <1e824524-5ed3-dfbc-b2fb-6a15631b44cd@arm.com>
Date: Mon, 5 Mar 2018 14:43:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305153549.00000f39@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209592530957527?=
X-GMAIL-MSGID: =?utf-8?q?1594109237949320320?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/03/18 14:35, Jonathan Cameron wrote:
> On Fri, 23 Feb 2018 16:23:43 +0000
> Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>> In order to support per-protocol channels if available, we need to
>> factor out all the mailbox channel information(Tx/Rx payload and
>> channel handle) out of the main SCMI instance information structure.
>>
>> This patch refactors the existing channel information into a separate
>> chan_info structure.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> A little odd to present a series to mainline that does a fairly important
> refactor mid way through.  Why not push this down to the start and always support
> the separate chan_info structure?
> 

Since the development started long back and this was added later, I
preferred to keep functionality working and didn't want to push change
down in the stack.

-- 
Regards,
Sudeep
