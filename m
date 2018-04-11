Return-Path: <dja@axtens.net>
ARC-Seal: i=1; a=rsa-sha256; t=1523462954; cv=none;
        d=google.com; s=arc-20160816;
        b=UPcXuULZhkOxmo/+YfRLN5p+adUPnnXbUqgO0gczNeQSKa3mQ9Eq8XemNx7DGpM1XD
         nG5FZQd+fwurXQ6dLy4mGVaCaIToa+GVogjnTc5OnznQeSVj0h0LpKYkErfR1LnBV6WE
         s0JASF/689wQBZWGNlujq/gotai8GyV5gVZ0bJ36cMns3+CQv7If9Y+HVPM4YfTVq/OP
         pXZYVpyy9RMYaZf/QuMKcq6b9gTDEh3gya2zzFF9Od1hLRwqifsGglcM74XabwBJmdw2
         rai1zgR/JhEfR6PBLA4v2Amt2fVQKf71ND0qF86+FDMNfYifHIGZZFc0jw9HQNg13Fbs
         XQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=zmMnCcObljAred+zFJzfE3rKCa5hkUM3so7uwFVjCUg=;
        b=s9rGWY7/w/emmU5X4iy7hM2FLq4X5IfyW4uqQw2vGzswKuK3ejTEzDQt42sGQXVI09
         WPYOH6q0hWMAOHCF9FVmsxs7c7hHvqGYvuYbGVKnh/klXNpePlsjYIG9ZA931xQrox9B
         NiBP3cAO8RLVY6y1bmHsFbxfJW0vMN8SfViQ/7ERmmYWl1FahDGl+g+DrPJJuepY3nt4
         SU0RgnHLjn19JG1+Ng7OGng34ffOmsFV/0Un7lrTEpp6DtOF7E7MlCpJlhwJs32zzClN
         pG7OQM858DMWKq0sUemJ2dvs2nP2QjjTdcSDlm17Qh1Vp5N+Z5rtafaaqg2SJjBSQCAm
         jvHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axtens.net header.s=google header.b=lZn+5Rs4;
       spf=pass (google.com: domain of dja@axtens.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=dja@axtens.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axtens.net header.s=google header.b=lZn+5Rs4;
       spf=pass (google.com: domain of dja@axtens.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=dja@axtens.net
X-Google-Smtp-Source: AIpwx48Wck6jCJik9skp5s8XGubYrCHu78VImOsj/4zRJV/ougDgUvBKrPImuIkPlvd9CnSVHgsqwQ==
From: Daniel Axtens <dja@axtens.net>
To: Mikulas Patocka <mpatocka@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Neuling <mikey@neuling.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tty crash in Linux 4.6
In-Reply-To: <alpine.LRH.2.02.1803270818150.30055@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1605161555430.8188@file01.intranet.prod.int.rdu2.redhat.com> <573A5996.3080305@hurleysoftware.com> <573B3F84.5050201@hurleysoftware.com> <573B5E4C.8030808@hurleysoftware.com> <alpine.LRH.2.02.1607071855150.19053@file01.intranet.prod.int.rdu2.redhat.com> <CAEjGV6zRghiCCMC1+-n+YPeA0Lrq=-vcvdoYpbwE4G=TXWzY3Q@mail.gmail.com> <87po3wusq1.fsf@linkitivity.dja.id.au> <20180322140554.GA3273@kroah.com> <alpine.LRH.2.02.1803270818150.30055@file01.intranet.prod.int.rdu2.redhat.com>
Date: Thu, 12 Apr 2018 02:09:09 +1000
Message-ID: <87k1td913u.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1534517131154419915?=
X-GMAIL-MSGID: =?utf-8?q?1597466690649860350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mikulas Patocka <mpatocka@redhat.com> writes:

> On Thu, 22 Mar 2018, Greg Kroah-Hartman wrote:
>
>> On Fri, Mar 23, 2018 at 12:48:06AM +1100, Daniel Axtens wrote:
>> > Hi,
>> > 
>> > >> This patch works, I've had no tty crashes since applying it.
>> > >>
>> > >> I've seen that you haven't sent this patch yet to Linux-4.7-rc and
>> > >> Linux-4.6-stable. Will you? Or did you create a different patch?
>> > >
>> > > We are hitting this now on powerpc.  This patch never seemed to make
>> > > it upstream (drivers/tty/tty_ldisc.c hasn't been touched in 1 year).
>> > 
>> > I seem to be hitting this too on a kernel that has the 4.6 changes
>> > backported to 4.4.
>> > 
>> > Has there been any further progress on getting this accepted?
>> 
>> Can you try applying 28b0f8a6962a ("tty: make n_tty_read() always abort
>> if hangup is in progress") to see if that helps out or not?

Sorry for the delay in getting the test results; as with Mikulas,
28b0f8a6962a does not help.

Regards,
Daniel

>> 
>> thanks,
>> 
>> greg k-h
>
> It doesn't help. I get the same crash as before.
>
> Mikulas
