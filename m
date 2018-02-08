Return-Path: <chiu@endlessm.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518058870; cv=none;
        d=google.com; s=arc-20160816;
        b=em6ywwiOZFdNkI+tFX9uQxMvRxcQn1W3wY/nDpiRL87Cga+8OtTs7GqI3q9mjFsdAB
         nxWv0OW0mxmEuCXQhYQAwXiAnjZUQQSknKleWvvEzctfVKWIPb+/bf22Qincg+kBytcX
         MnEdxWknNYf8AApGtQvPQTb5s9VQSNLPCGytNQ0wqUdFEertanGey8PRoFFS1K27WPeM
         odSmVxzMPqIGdhX9gY4cLB0oYuKJnPUs23t4Ge7gZcKVEipS8oMxjaW6e4PHZ3k8swZu
         LqU1yEqjnE5hE4CRKsb92QhoAaUAOLjkXDnalqVIwzEpc/YuaNJTRr6u5f467UYLaUMr
         /EaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=6kkDKVAtMGzw7nikH2hdaDsEZl4g8WX5Cwrgr9FmL4s=;
        b=Fpk4c5Nrf5Scl2gAiAo5FMWCqcr1VJEWW3JFBBvj0uaWxaq85i7Twp0zmTSKMp9YXO
         /DqcJU2rX/aeuFcctYux5U6UEFyY8VH2P0NcHpC1LjqbDO2c6iNK7lqOuMm1vyXNlu0c
         E7UEoRfwXdfTUhoYmptIG8oTHTF5f+Wm17Xkk1hKzPGSm1pQlWn8QhEuzFAo0QHzX6Qm
         pKHyErnXSD+eH3w4GweRWRLL10TYUAuDik/yZAOwkWmwceKYfrlm2GHM0BkL2mOmPSLA
         CSBrkeGw9hhy18nm+6gvMr0GSNDu49escrzh/jS7F6TWHbH2C3gkLio+EK2FYOnIByxB
         CNBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@endlessm-com.20150623.gappssmtp.com header.s=20150623 header.b=xshL99cP;
       spf=pass (google.com: domain of chiu@endlessm.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chiu@endlessm.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@endlessm-com.20150623.gappssmtp.com header.s=20150623 header.b=xshL99cP;
       spf=pass (google.com: domain of chiu@endlessm.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chiu@endlessm.com
X-Google-Smtp-Source: AH8x2245hv6Wz0vobPCwwwMk+ZzvKKlVliBg4egq8120HHPdQ4L6qIQjVyH0aZ4mQmkLRi/C/SkH/LFZZcy09dcWYmw=
MIME-Version: 1.0
From: Chris Chiu <chiu@endlessm.com>
Date: Thu, 8 Feb 2018 11:01:09 +0800
Message-ID: <CAB4CAwfino0JaeeZV1byp3aoaRrOGL1=BYgkruvxYMr6=c=5PQ@mail.gmail.com>
Subject: ipmi_si fails to get BMC ID
To: minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591800098576670064?=
X-GMAIL-MSGID: =?utf-8?q?1591800098576670064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,
    We are working with a new desktop Acer Veriton Z4640G and get
stumbled on failing to enter S3 suspend with kernel version 4.14 even
the latest 4.15+. Here's the kernel log
https://gist.github.com/mschiu77/76888f1fd4eb56aa8959d76759a912bb.

    As you see, it is due to "ipmi_probe+0x430/0x430 [ipmi_si]". After
the message "ipmi_si 0000:02:00.3: There appears to be no BMC at this
location" shows up, then it can really go to suspend w/o problem.
Although it took around 3 mins. The IPMI device is probed from PCI and
here's the output of lspci
https://gist.github.com/mschiu77/33f0372be41670d8a69c97e64f833087. The
IPMI device is "02:00.3 IPMI SMIC interface [0c07]". We get stuck here
because we don't really know why it took so long in try_get_dev_id() /
ipmi_si_intf.c. Any suggestion about this to help us moving forward?
Thanks


Chris
