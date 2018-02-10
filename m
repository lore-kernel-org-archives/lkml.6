Return-Path: <sergeev917@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518265655; cv=none;
        d=google.com; s=arc-20160816;
        b=Ib+xGafs39eMJQ4Fy4WaC7zdC/s7mEFkAne4X9ne1jwVrxTHtg1yPS5FWR4deqGpDk
         14dJTyL0JCSYAj6XM3asCHIzSMhiqjHSdMzM9cUprjzCc7L6EZ6fH2LjByR418ya4V/x
         F61FlKExdAnS9oivizlvRjNBLUwVyFqyfc5YiH7XuB9Nc2sUGjZabzjQG/gEj/le/p3k
         gWLIqtKkT0vVLLH1TmT/9kDBsuKDiMtumur3MpBXZaCQifSyDVCVFokG/6PAkCs8V9Wi
         F6RUNHJdvbHREXu4p5LoUu1ohAI3Ri2LDMqyb8H44olA5tfvkuClpfCLovuf30TbXBYi
         SQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=r4cxxptrvNKvAuJ9f9TpsWXYh5RLulrCZ6WImo4VXPc=;
        b=0qgAQ6NPfL7h460rYcZfwsmATOT0+0syRr+9c8uR9AYqbOFQAYgVc7NCKiZlrYqxGY
         Hszt4p10pZ/eOEJf52D6WiwMwAd97x0g78gdb9ifHOw3ZipnY5+7iyKAzqkJR/WN40mh
         AWci/Gc9mVjddVDC87yKT4uRPrC/IemSp8eTW1ltejTK20vhblIDJDIwl8N9S2CZF258
         IQKjeVk0DTIU0R/Is1245vexxb1tWz2EeG6Rt8flFzCyCRsP3BzSiNtzUSOFSSLLPW5l
         f0LnrvQ/onjtN5HloQLFugHKO2LrAANpKbPxKs0h+bdJ0seh1y7UzAwlx0oajWSfB6Uh
         rWXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZOEwB1OX;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZOEwB1OX;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2242pHQMezw1q1BCgRFZphsrq2/Wld9pxbYPdVlrAycESa2mczShe31B+dP9KBD4oHy1jO9O6w==
Date: Sat, 10 Feb 2018 15:31:23 +0300
From: Alexander Sergeyev <sergeev917@gmail.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Kyle Huey <me@kylehuey.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: update spectre v2 microcodes blacklist
Message-ID: <20180210123123.GA19396@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: mtt
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592016927852230730?=
X-GMAIL-MSGID: =?utf-8?q?1592016927852230730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

Intel released an updated microcode revision guidance [1] (8 Feb). The link is 
available in press-release [2], but it's quite easy to miss.

Some microcode revisions that were blacklisted before are now tested and 
pronounced production-ready:

> Lines with “***” were previously recommended to discontinue use. 
> Subsequent testing by Intel has determined that these were unaffected 
> by the stability issues and have been re-released without 
> modification.

I didn't fully match the updated revision guidance and spectre_bad_microcodes[] 
in arch/x86/kernel/cpu/intel.c, but at least microcode 0xc2 for intel skylakes 
should not be blacklisted anymore.

The update is also revelant to a recent blacklist backport to 4.9-stable:
https://patchwork.kernel.org/patch/10209021/

[1] https://newsroom.intel.com/wp-content/uploads/sites/11/2018/02/microcode-update-guidance.pdf
[2] https://newsroom.intel.com/news/security-issue-update-progress-continues-firmware-updates/
