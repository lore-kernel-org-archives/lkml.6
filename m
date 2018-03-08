Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AG47ELvCzwqxIytaP6gvYju0KU7TWPXeG5HkY0lU9hrA+cWOHDZRV0ouusJgwZfyGR6+2B/Btknw
ARC-Seal: i=1; a=rsa-sha256; t=1520539391; cv=none;
        d=google.com; s=arc-20160816;
        b=W6lt3IrUKyiq3GBVcB+mLRFUEDKi2IOexXtfioMirTvsCGgLIOBe+Dbt01maTlTb7G
         0/xSCK4c++YRNTgCHyA9w2KoezivBLAIWFBhH1+7vGE4hCwjI1lwBrVkDC7BoBUpmplq
         Z0SLZmcZnYmIqpFpgaIm1CaU8WCJ58dQ3Hjl5jOXYyu0JKZSE7clHDaRSPC19UQ+fTGg
         8WQ5xwn3f0pkN5gYRvB0iDmnehBvn3O/U5S5YPWV/7066nvluqmVYc7876N2JaNUZ5pz
         P7V6tnCPaVNeciRC9VOm3FZSPWoNKWN8Zgfig0MWlkiwUkhokemg9A262lVOEyGNqZ/q
         LA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=2bmZZ18SZsJOu450dJq3oSEzKT5N4s4lQO+mTjsow2c=;
        b=s+ZMaHK4fvzhhKM+RQO0g24DimSFsWeFUE1DuPjQIhbmfxZ2hr0eaMf90OFLW0UcEF
         A2KHQ2Js4FhYP6eFutxFy/EeQLe2cy1tvGSHnz/aUrq0BOEUuHUlwvyidc8RJM0E0UD7
         TRMz00pprtd/EAWuxCdgRO9IwvJwubm3EJEPNcjIalm89mObKJtdbNpzjzKqvx3pztBu
         ur6xQ5gk5ihqFtPVcwXwdUOHqBgs573HOQYc4lG5tebDJiXxci3LkJXM65puwbqKYYLo
         SHq7XbbqURm3eBdpKFpJ6Q1/f9/XteC3KMW1tK2srQVs+5Sssp5MSj7lJGT/buOiujrG
         G+fQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Thu, 08 Mar 2018 15:03:09 -0500 (EST)
Message-Id: <20180308.150309.1043571795208899259.davem@davemloft.net>
To: dvyukov@google.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 syzkaller@googlegroups.com
Subject: Re: LKML admins (syzbot emails are not delivered)
From: David Miller <davem@davemloft.net>
In-Reply-To: <CACT4Y+Z2-Z6GN0SDb5jySJkCrTRxf9qvdzuyM_OoruCTB9EoqQ@mail.gmail.com>
References: <CACT4Y+Z_DV6sgQ7FodoxBj8MdVkcij3bS0P1pp9GOMDS4-f92A@mail.gmail.com>
	<20180104112028.GA7583@kroah.com>
	<CACT4Y+Z2-Z6GN0SDb5jySJkCrTRxf9qvdzuyM_OoruCTB9EoqQ@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588652385455174541?=
X-GMAIL-MSGID: =?utf-8?q?1594401112735585906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 1 Mar 2018 17:22:54 +0100

> The problem strikes back.
> Again people complain that a email does not appear on LKML:
> https://www.spinics.net/lists/kernel/msg2735905.html
> Though, it appeared on syzkaller-bugs group:
> https://groups.google.com/d/msg/syzkaller-bugs/OkwLGoS6UQA/hHAtCdnNBgAJ
> https://groups.google.com/forum/message/raw?msg=syzkaller-bugs/OkwLGoS6UQA/hHAtCdnNBgAJ
> syzbot now receives and logs bounce notifications, but there were none...

The problem is that the name 'kernelci.orgbot' has a special character
in it, namely "."

And when such special characters occur in email headers, the string
in question must be surrounded by double quotes.

People have to do this when they use my name "David S. Miller" as
well, for example.

So I think if you put double quotes around kernelci.orgbot when it
is provided in email headers, the problem will go away.

Please also make sure that multiple From: headers are not being
generated or anything like that.

Thanks.
