Return-Path: <k.marinushkin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524595844; cv=none;
        d=google.com; s=arc-20160816;
        b=BrJdx54FFE5LI7a2RYDFJPtuwNT7izzvlXK+iGAMmIOZasrR0u0oZKQnFRV1Nk0WGU
         bE6mx8pviTNlo6cl9nRqfWbDngIzz1RTBPSOJwSauoih8dxrJPQdfhZnidgz27nEy61K
         GG4hvyNWYaWljSv0oeRg+5sRe/3nPYf2IT7b69jrMQujNGInEjLKg+BVCpg6eiWY2syG
         hsAzK+9Nt07mBD8R16KOnbLkVzbUpiIdAAk0G5C7AQ0cVAqZD74jWs9Ar6K/azBEybZ5
         x5oKS+Drbe8XQd+BGg8qLWU8gM5mU1ccEblDSG+CBCy1VItVBeCw0ea16TKk+9WcFBtS
         jOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=srt9B0RWVdn6RXEfOtZ78DArrte5v05Ehhm1DHmSPeo=;
        b=rjKMYtgA4Cj8Ip8jGgP5C8pPMbYUBcshzevHUw5bc4ITlFqybHD4/fIOjkBDAh8fkm
         66T1p7zdpdUS6ygwyk9h1qKGeCybcuxaGVn24+NEH48Dhs3sj8lBdhJmumI5C6F2zdVN
         pesqvqofzrVeL+vpQ7rhzlKRhlDvd+8g4Wdp2GO+XqEHE65JvYkQkxTXJozCWHIlcmns
         tcnozYq01KywbTk5cXop+zBssWb0atzS7ENzmOq1v69DJK94BPOFW/csQ5qsKTurIHys
         8bUHYt0WCH+9yGbxi3pHU3ChhpiCUkJIE7Ty4DAurp8TRsbq8bmSngfM1R5g4xXMnn6Y
         1iKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PCrLlRfj;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PCrLlRfj;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZopJXw6Z/pO91UI1mtTB2Vxv5DvPAom4im9sVlOYHxx4dSscS9U1f+pq26mqjDK4rs4QAb9tA==
Subject: Re: [RESEND PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 devel@driverdev.osuosl.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180424071618.GB17825@kroah.com>
 <20180424074459.7215-1-k.marinushkin@gmail.com>
 <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
 <CAHp75Vd=_7g4N6b2Mkw1dLOao6gFsQuhzO7-9d=1kjyX0kgMAQ@mail.gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <2c7fc106-4c57-5e55-4f45-8fcf03a40dda@gmail.com>
Date: Tue, 24 Apr 2018 20:51:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd=_7g4N6b2Mkw1dLOao6gFsQuhzO7-9d=1kjyX0kgMAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968190615569586?=
X-GMAIL-MSGID: =?utf-8?q?1598654612006172102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/24/18 20:35, Andy Shevchenko wrote:
> On Tue, Apr 24, 2018 at 9:27 PM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>
>> @Andy
>>
>>> AFAIR I gave you a tag and you again missed it.
>>> Before sending anything just check twice if all prerequisites are fulfilled.
>> I think you mix it up. This is a new patch, you didn't review it before.
> Ah, okay, send new version as a separate thread and if I have time I
> would review it.
>

Thank you!
But it will be in the same thread. From my understanding, keeping the thread
when sending new versions of a patch helps to keep tracking of the conversation
