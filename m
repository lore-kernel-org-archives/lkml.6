Return-Path: <himanshujha199640@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520375138; cv=none;
        d=google.com; s=arc-20160816;
        b=zh8sqVOfYseay5iQ9gpHXVis6Ui3xj2ILN+Jtl80veHocW66kBMxJD7H4/09Xkpmet
         hP9Jd1pVEgGH85c44xaYYEci1m9F1GH9YK3965VtzAK0acea+urmHZ6v8e/xkcPMQ5OL
         QwboVA93BSE8kpK0aNlmS0TWbNAwTRzRsCV1MNqmlspRi/XjDUH37RZxKo+aex+mEHcb
         nQR4VsVxBGr5v3QokC1mBVGzVgyiYMUXcPlX/exJixBJgC+neNsLyr91vjpgpccxOZVL
         YdmhZaZvoBP0/JKsO+/B8JBNakQZgwgLPT1qJHyNWjoULt8kW3yKPCIMOQ7h8To/0zIN
         mt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=zRH4bHnDL1yquOy/JScC3hVj47Rha0KPmCdsyMPhRYU=;
        b=btwno+PEJwk6odzVk1hWXI9w6Z/TAkE8Vf2/qlR4+m/vg9r8NqFmLKUi+F6Vdc626L
         0oHKHkfoDeZmudEIqraIQJNfpAhPlQzaZTeoMdunqiji8ey7r8LsQKMRreS9HJsU79Wo
         vsradUBeAIygjH8SmDVFk58/i0//E+ljfD4+LEaNVRJORvtNuEBHlGiCi/IRjk6YU4M1
         hmY9gSrUw5JtgufmJzay3RU9mb2XS1wjLIZs9zD7uJuYop+Xg5XvkEsDZ04Vle+Mt6VU
         dgazZ4Znahk9AJ2PfYWFvZDzJ682jXK6t5PspvPXdngp9ihQYwdV25TnvcjJNzOSjWOy
         DSdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dNZjd2c5;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dNZjd2c5;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtUQXy/4q3fWlJlVj68Xoi6fghiTCy0/hdewaH4T7oeNMH0UZsEx7jpOx6hM7UB3WiufoVP8Q==
Date: Wed, 7 Mar 2018 03:55:30 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 03/11] Staging: iio: accel: Remove unnecessary comments
Message-ID: <20180306222530.GA2604@himanshu-Vostro-3559>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-4-git-send-email-himanshujha199640@gmail.com>
 <1520371619.4202.11.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520371619.4202.11.camel@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594083197569075239?=
X-GMAIL-MSGID: =?utf-8?q?1594228880708729824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Shreeya,

> I was just going through your patch for giving myself 
> a habit of reading patches.

Great!

> I see here that there are many comments which are necessary
> have also been removed.
> Jonathan told that some of the names do not explain
> much about the how registers are related to the orientation.
> So it is necessary for some comments to be there here.
> 
> I saw your next patch too, in which you are changing some of the
> names for betterment, but again, that doesn't cover everything which
> was told by Jonathan.
> 
> Here is the link to the patch where Jonathan had given detailed 
> description
> 
> Just sharing this information so in case if Jonathan agrees with
> this then he will not have to explain it all again :)
> 
> https://lkml.org/lkml/2018/3/3/104

Well, the naming of macros is debatable as Jonathan pointed out[1] and
the unusual/odd naming pointed to you was for rotation registers

#define ADIS16209_ROT_OUT_REG		0x10

I renamed the unusual/odd naming macros for eg
#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT

to

#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT

as it didn't look like a failure bit address for which I consulted Jonathan to which
he agreed. Also, *DIAG_STAT* seems like a good name since these status registers
are serving the purpose of diagnosing the device behavior. Again, GLOB_CMD stands
for Global Command register for controlling the deivce operation such as
Fatory Reset, Software Reset, etc.

See, it is difficult to point the perfect names than the suitable ones!
And let's just leave these *bikeshedding* ;-)

-- 
Thanks
Himanshu Jha
