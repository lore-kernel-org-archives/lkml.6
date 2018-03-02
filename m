Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519981922; cv=none;
        d=google.com; s=arc-20160816;
        b=E5yNnhuj8ntxxBazuPdCiNAx0+LhaJgERUooJcXEWb0bbsq3n12ld5TiBHrhcBhshR
         uD5n5GQDz3C3NTNBW0+yi+4BJ9CDZabtqCYZ/Bq8fP+ozI/G0jO/D0fOsRS0WWxKL8BB
         PsSR3WCYkyHMjNWWCj/4B5yRRnVq3ItyV/L8rUB4dZc+UhYRDnlpXhL9vmplQ79x6hFb
         UtRCYVrZO3Fob7czJYxj0TkD/YSW4mt/pVyJuwBfSK4jtRQSJ664lHxV1SUXionV6dBY
         HP3sM8A/EX7znYKxaCRMYJeCguJD2wmfW7Lf0cohL3kOaLxW5unBG2SRG2g2ZsRPWkQM
         +Wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cRNiMs5o3chUgVQSSQLE5OCdAKs+aQkkTlPazoTra3U=;
        b=Y8OzngbeXOGRBFbJAxVwAI5N/486KpZOfwAPfphX2v5To2kIwOQ+LQTOHdBzWxT/OR
         69YEfTF21FDWb5/DQshf/DsjAy2Y1buRIGcN6omC5QLR64aENB80E1Hs9kQWTcXPd5u3
         J9ZyRSK1nO3J0CmcMjLjNMohXJnRHluHLF77x0H4MCLHmy09GfvCzNE16HrabEim4M71
         qeo8v8NhS6QnagWbw3fUadzU53rw4duoRcl6bUI7lwwmqVVtYREyyyjzp6ZlstH9K7za
         o8H7Pvq3WKC2xfzW6LnpLHoXLrCWtCobR9x3wzRqJnUS65foHq0szaULxXfRdjUWo5wO
         nvYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=h27BmcWd;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=h27BmcWd;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AG47ELui4OmL/Mhy5Rq065AEpJxC0rw+SBnoYdf9OEbS6M9pvpYv5NBqoDfhbRiMa7R66NiCGiV+w79zcP5ePUdZRPg=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180302090546.GB30267@amd>
References: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com> <20180302090546.GB30267@amd>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Mar 2018 10:12:01 +0100
X-Google-Sender-Auth: vxzflGLEhAAaUKVaE85r1BjyXJ4
Message-ID: <CAJZ5v0hjRMRBMrMZMQnK74vdmKxRvmghd9yx-on4hUCxdHWXMg@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
To: Pavel Machek <pavel@ucw.cz>
Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593800783059204124?=
X-GMAIL-MSGID: =?utf-8?q?1593816564646378158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 2, 2018 at 10:05 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2018-03-02 13:01:00, Ganesh Mahendran wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>
> Can the rcu_read_unlock be delayed arbitrarily by userland code?
>
> Is that ok with RCU?

No, it isn't. :-)
