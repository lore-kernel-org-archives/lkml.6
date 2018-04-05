Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AIpwx4+xPzNq6MqQ6KzoUGdgUC/A2fV5FjjZjxdqd9hIvWxwb64Npb5Ol7LOvEmrD4YvwSp/IAkQ
ARC-Seal: i=1; a=rsa-sha256; t=1522903702; cv=none;
        d=google.com; s=arc-20160816;
        b=NY4iAVF2JkYf3sCnBr1PzU2uDx3CBsOTm9w5KHHN3812l8Fpy5YEMj0yN+vqVPyqQQ
         pXX7PVv2cALmhbH/1nqn24VXxRFLhg9hKh97iR4oibgeEFmS0EHWXi1IO9wT+C+2aumd
         /2SihjATHRiX1dla74IVqmXBwD0BrparPD8bmUxoCbe6/1GAa+NoRAE96JXzhBRAp+OV
         HkrcBhC5P3A8ZtmZY5YoxA7yb1ZtZEDjwgS3tAb4gCDxWKxw4P1EwBAC0y4gJfWrFskx
         GlAviQWSuo8WmQNliytL+2YTfKqp/vMmZf6OY3xW9KfmPvJvEcC3sjo+o4nuFOHtpFUI
         RHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=+zzY6g5eY/iZsQtI3n1KsPNFZgFCMQxyRZmKY/5/Oig=;
        b=nPY8piwK6s0gNGSnb3jVSXOPfnyZaFRpkb+wPG5ph5TRTXP+LJJ76EjLx5gfSOxtJ4
         8+YkVdrxcQoqqQAJbpNE8iaCUfQNvO1PjiUvMVtphWppK7pIouDTvbLhpMDzcmR8LhCB
         l1TJUHAD7qZF0xcydbjgck1JlZV6VkROwVH2zFRUfCJhe3Vs3fQF9b1oJAOvIm6qLWS8
         t15Wki529O+cugxJwI4sZnA6roerTbwR0SAtzuQfNVXf6/nQqeIO2xCKlbslrL8aybe2
         2u3dx5ATxw7UYghzgawcaccCUb51+x+vhacAb5SBucuoJhNbjPjUu6Yn9NPSbdZx7cpi
         OIUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 103.22.144.67 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 103.22.144.67 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, akpm@linux-foundation.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Horia =?utf-8?Q?Geant=C4=83?=
 <horia.geanta@nxp.com>
Subject: Re: [PATCH v15 0/9] Add io{read|write}64 to io-64-atomic headers
In-Reply-To: <515f5c92-ac02-6e09-830e-46ea4d462652@deltatee.com>
References: <20180327230834.5931-1-logang@deltatee.com> <87r2nvmf3b.fsf@concordia.ellerman.id.au> <515f5c92-ac02-6e09-830e-46ea4d462652@deltatee.com>
Date: Thu, 05 Apr 2018 14:48:18 +1000
Message-ID: <876056cl7x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596134127286634027?=
X-GMAIL-MSGID: =?utf-8?q?1596880272518545688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Logan Gunthorpe <logang@deltatee.com> writes:
> On 4/4/2018 4:38 AM, Michael Ellerman wrote:
...
>> eg. It looks like I could take the two powerpc patches on their own for
>> 4.17, and then the rest could go via other trees?
>
> Yup! If you can take the powerpc patches I can keep trying to get the 
> rest in. They are largely independent and shouldn't really change 
> anything without the following patches.

OK, I'll take those then.

>> Is patch 1 stand alone?
>
> Essentially, yes, but patch 5 depends on it seeing it's changing the 
> same area and is trying to avoid creating the same kbuild warnings that 
> patch 1 suppresses.
>
>> The other option is to ask Andrew Morton to take it, as he often carries
>> these cross-tree type series.
>
> Thanks for the tip! I'll copy him when I repost it after the merge window.

Cool. If you want him to take it you should probably explicitly say so
when you repost.

cheers
