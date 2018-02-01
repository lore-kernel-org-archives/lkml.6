Return-Path: <ivid.suvarna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517509339; cv=none;
        d=google.com; s=arc-20160816;
        b=rDg28T4RNnM9slop3YA3Zbnz50SJlmny7oIMyEC2y6U528D/dnGEAflARz9jIZPNN2
         wOj+PK0WWco14MSXd38XI/xtfssFid29D+RhNSxrKiXrcqqJa5gOjHTFJCc60KxTkp6i
         G3oQov+fQLo17EsJH00Y6AIjYSKoRZ1Wm7VnXxGccDu5Rynw0jVagVgzmATHrOEXQioS
         UGvzqnkxY8jsiRHKNjssRBnDATkBmA9S7SV4wotB6iosPv9DLWh2QLHMwrgZAatZUMHS
         +A4t8knuU5oT8164xplQaoFDS+5jcHfBYRVyRPjSkCDAZlDkwyAfGEFAkv3rsGY9rD3B
         L2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=fo0QK/l29fN5EYTWuvsl3QTiJAI5h+dSPtiCo9MCk7E=;
        b=j4yk/P5G6tiYMhU/qJ6R0C82fk+1LHlzsLgguxMNb0avyF2WPNRDexgofpE0fPxA3n
         Bby3BVG8Dv0B3bwORMtkpWuMaMu1y5+5fVqtct1VJhwsNqP9Qk2rb12XbahsimCKsNJx
         srD14TiOxO/aLTq1o+FtuXz0Ksn5oBT3LmKmX/oClN+N6ihwQnRqZmOl3a79zDoO/8vO
         Rxrjczdzn5u4hBXFhi7TRYV/crfyoTef95ditUzvbrtYlRRVn23fSXbp3Y18jJY8bLQv
         cZXlgElaD15gA+XVgvYF8xBuYGYt4JSmtOiP7a83F9kCV1LS3FslgWPsu4x5JRkI4hGp
         68aA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KKoT/tBY;
       spf=pass (google.com: domain of ivid.suvarna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ivid.suvarna@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KKoT/tBY;
       spf=pass (google.com: domain of ivid.suvarna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ivid.suvarna@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227Zv2UqTPSnfUUOAhKa6nTBYC5cPQf0vUaHSQQi/vY8TtMHpgXbt5R/zj9tb3tg0+kVIN4KlU1paptFnQ+uR7o=
MIME-Version: 1.0
From: Ivid Suvarna <ivid.suvarna@gmail.com>
Date: Thu, 1 Feb 2018 23:52:18 +0530
Message-ID: <CABXF_AB8Z1J+s=mqkn012XqZC6xYEhZQ8QUQj=EZ1QAiTnAXyA@mail.gmail.com>
Subject: [usb-serial] Support for console read from usb serial driver
To: USB list <linux-usb@vger.kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>,
	Peter Chen <Peter.Chen@nxp.com>, Alan Stern <stern@rowland.harvard.edu>,
	Mathias Nyman <mathias.nyman@intel.com>, Bin Liu <b-liu@ti.com>, Felipe Balbi <balbi@kernel.org>,
	gregkh@linuxfoundation.org
Cc: Kernel development list <linux-kernel@vger.kernel.org>, kernelnewbies@kernelnewbies.org,
	"ivid.suvarna" <ivid.suvarna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223872832442357?=
X-GMAIL-MSGID: =?utf-8?q?1591223872832442357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

I was going through usb serial driver console related source code
(drivers/usb/serial/console.c) in linux kernel and came across
"usb_console_write" function and was wondering if any usb serial
convertor drivers were using this function? If so any pointers on how
it is being used?

Also can we implement something like "usb_console_read" which can be
useful for interactive debugging like in kgdb. I saw kgdb using
something like "poll_get_char and poll_put_char". I found them in most
of serial drivers like 8250 and so on.

I am using pl2303 usb to serial convertor for getting a serial
console. Is there any way to implement something like usb_console_read
in usb serial drivers? Can you guys give me some pointers on this.

Thanks,
IVID
