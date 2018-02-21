Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x2270UbXEaPz+W1n3o9K0rDI6n9uMnlYY2pxFSoHXMcTg1Ui/runOkZLWTUo2gJ2HdwE/f7fp
ARC-Seal: i=1; a=rsa-sha256; t=1519221852; cv=none;
        d=google.com; s=arc-20160816;
        b=S1MuF7mriaOOuAkCqOAkXVuXXKMNSsnTN5dZQ9cy2CNlSAP2JV6OTGRIAHGVjaRvSY
         KkoM0Zxy6wjpiYomcEhH9xGaUajMBE90PDlqaNjzt8SKvMByqJUChLp79x/UFVPAwZnV
         ZIZao/PALbNbk8shDhpuhRcu3kBaeCwgQPrlSWmrCwcuZdf/4ZY8Fu6KCjrXW5OASxOK
         6e29VefkcwJSbC0VlzLjCCopW+PiNQNHBmbHvVTsOgy/Js8ELXisaaT5OGMcfiumGYru
         dmdwfKEQ9pstzHXQ1df9X9fxyU5m3uSuzXq41RzHQ2JS9fku86WkWZTl5tQbUDoWmA/i
         Bajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=Nj7hAGHi9LFi8B6/SFkeBTDVmn9xvhbSXnKugjmHqrk=;
        b=n0GbZgVU8YYP1t7oGdfOFUgCKwG7QPo2JoBciO/OHx8fTHa0YL5dRUPWESYf88SuXL
         hUoJ/6I7BTGt1kfUOOcgluDwRkrppA6TEQM0N6ekBCl0dZK7ghK+IYSrASTjjHJyEAYP
         nmUWYHvgDJ0JjQaWRyOWNffRUdvUWBxWg4/8MN//dANrn3DYKUpHdm+KuPfOvc3DueuZ
         +MwfxfP7tSuhtd4YVEuBwuyOsYJ8TdaOXmenV+OvoRniFX+EM77TFq3NaXl2Tau7AAv7
         i7dwMndGdrv7ZkcD1xK6wzYjaIirQbfiKmp3sxCl0XheE08VbfgcS6E32D4u8tgS51yh
         BlZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="28759338"
Message-ID: <1519221841.10722.37.camel@linux.intel.com>
Subject: Re: [PATCH v2 20/21] mk68/mac: Switch to use %ptR
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alessandro Zummo
 <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Mark Salyzyn
 <salyzyn@android.com>
Date: Wed, 21 Feb 2018 16:04:01 +0200
In-Reply-To: <CAMuHMdV9Ho3yh8e8z3N1awPj1ZjQu=7LtMetAY5TX=AVuXCVOQ@mail.gmail.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
	 <20180220214400.66749-21-andriy.shevchenko@linux.intel.com>
	 <CAMuHMdV9Ho3yh8e8z3N1awPj1ZjQu=7LtMetAY5TX=AVuXCVOQ@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957919041334939?=
X-GMAIL-MSGID: =?utf-8?q?1593019573124503747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-21 at 10:38 +0100, Geert Uytterhoeven wrote:

> > +       select PRINTK_PEXT_TIMEDATE
> 
> Yeah, now you have to track whatever code uses the new %p extension...

I don't like this. People had an opinion that 750+ bytes is way too much
for tiny kernel configuration.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
